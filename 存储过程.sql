create or replace procedure beginrefund(refundinfo out varchar2)
is
 --贷款状态
 v_state number;
 --还款时间
 v_tdate date;
 --贷款ID
 v_loansid number;
 --贷款人ID
 v_userid number;
 --贷款金额
 v_loansmoney number;
 --定义一个游标，查询所有招标时间到期的未满标的贷款ID  
 cursor csr_invest2 is select loansid,userid,loansmoney into v_loansid,v_userid,v_loansmoney from tb_loans where loansstate = 2 and investmentamount < loansmoney and (begintime+loancase)<sysdate;
 t_csr_invest2 csr_invest2%rowtype;--定义行级变量
 --定义一个游标，提前三天提醒贷款人还款    to_char(tdate-1,'yyyy-mm-dd')=to_char(sysdate,'yyyy-mm-dd') 获贷款 还款时间前一天的所有贷款id
 cursor csr_invest1 is select loansid,to_char(tdate,'yyyy/mm/dd'),userid,loansmoney into v_loansid,v_tdate,v_userid,v_loansmoney from tb_loans where (to_char(tdate-1,'yyyy-mm-dd')=to_char(sysdate,'yyyy-mm-dd') or to_char(tdate-2,'yyyy-mm-dd')=to_char(sysdate,'yyyy-mm-dd') or to_char(tdate-3,'yyyy-mm-dd')=to_char(sysdate,'yyyy-mm-dd')) and loansstate=5;
 t_csr_invest1 csr_invest1%rowtype;--定义行级变量
 --定义一个游标,查询出所有还款时间到期的贷款ID
 cursor csr_invest is select loansid from tb_loans where (to_char(tdate,'yyyy/mm/dd')=to_char(sysdate,'yyyy/mm/dd') or tdate<sysdate) and loansstate in (5,10);
 t_csr_invest csr_invest%rowtype;--定义行级变量
 update_exception exception;
 
begin
  
      --打开游标  查询所有招标时间到期的未满标的贷款ID  
      open csr_invest2;
        --循环取数据
        loop
          --取一行数据
          fetch csr_invest2 into t_csr_invest2;
          --判断
          exit when csr_invest2%notfound;
          update tb_loans set loansstate = 3 where loansid = t_csr_invest2.loansid;
          dbms_output.put_line(t_csr_invest2.userid||'111');
           --给本次贷款人员发送的系统消息
          insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
                 values(seq_tb_message_id.nextval,'尊敬的客户，您好,您的编号为'||t_csr_invest2.loansid||'的'||t_csr_invest2.loansmoney||'元贷款未满标，导致贷款流标。如有疑问，请联系我们，我们一定为您解答',sysdate,t_csr_invest2.userid,'流标');
        end loop;
        commit;
        --refundinfo:='流标消息发送成功';
      --关闭游标
      close csr_invest2;   


      --打开游标 提前三天提醒贷款人还款
      open csr_invest1;
        --循环取数据
        loop
          --取一行数据
          fetch csr_invest1 into t_csr_invest1;
          --判断
          exit when csr_invest1%notfound;
          dbms_output.put_line(t_csr_invest1.userid||'222');
          --给本次贷款人员发送的系统消息
          insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
                 values(seq_tb_message_id.nextval,'尊敬的客户，您好,您的编号为'||t_csr_invest1.loansid||'的'||t_csr_invest1.loansmoney||'元贷款将要在'||v_tdate||'还款，请保证您的账户中可用资金充足。如有疑问，请联系我们，我们一定为您解答',sysdate,t_csr_invest1.userid,'还款');
        end loop;
        commit;
        --refundinfo:='消息发送成功';
      --关闭游标
      close csr_invest1;  

      --打开游标  查询出所有换款时间到期的贷款ID
      open csr_invest;
        --循环取数据
        loop
          --取一行数据
          fetch csr_invest into t_csr_invest;
          --判断
          exit when csr_invest%notfound;
          --查询当前贷款的贷款状态
          select loansstate into v_state from tb_loans where loansid=t_csr_invest.loansid;
          dbms_output.put_line(t_csr_invest.loansid||'----');
          dbms_output.put_line(v_state||'----');
          if v_state = 5 then
            --修改状态为还款中
            update tb_loans set loansstate=4 where loansid=t_csr_invest.loansid;
            get_investor_info(t_csr_invest.loansid,refundinfo);
          elsif v_state=4 or v_state=10 then
            get_investor_info(t_csr_invest.loansid,refundinfo);
          end if;
        end loop;
        commit;
      --关闭游标
      close csr_invest;
  exception
   when no_data_found then
     refundinfo:='不能还款';
   when update_exception then
     rollback;
   when others then
     refundinfo:='系统出错了';
     rollback;
 end;


















-=-------------------------------------------------------

create or replace procedure get_investor_info(t_loansid in number,refundinfo out varchar2)
is
 investorid number;--投资人ID
 t_investmoney number;--投资金额
 t_loansinterstrate number;--贷款利率
 maxrefundtime number; --还款期限
 loanid number; --贷款人ID
 loanstate number;--贷款状态
 loansmoneys number;--贷款金额
 refundtime date;--还款时间
 availmoneys number;--贷款人账户中的代还金额
 repay number;--借款人应还金额
 t_investmentid number; --投资编号
 days number;--逾期天数
 --定义一个游标
 cursor csr_invest(t_loansid number) is select userid,investmentmoney,interestrate,investmentid into investorid,t_investmoney,t_loansinterstrate,t_investmentid from tb_investment where loansid=t_loansid;      
 t_csr_invest csr_invest%rowtype;--定义行级变量
 update_exception exception;
begin
  --根据贷款ID查询出贷款人ID和贷款状态，换款时间,贷款金额
  select userid,loansstate,loansmoney,refunddeadline,loansinterestrate,tdate into loanid,loanstate,loansmoneys,maxrefundtime,t_loansinterstrate,refundtime from tb_loans where loansid = t_loansid;
  --查询贷款人账户中的待还金额
  select  availmoney into availmoneys from tb_useraccount where userinformationid = (select userinformationid from tb_userinformation where userid=loanid);
  --查询逾期天数
  select trunc(sysdate)-trunc(tdate) into days from tb_loans where loansid=t_loansid;
  --判断本贷款是否处于还款中
  if loanstate=4 or loanstate=10 then
    if loanstate=4 then 
      --计算出贷款人到期后应还的本金加利息
      repay:=loansmoneys+loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12;
    else
      --计算出贷款人到期后应还的本金加利息
      repay:=loansmoneys+loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12+loansmoneys*t_loansinterstrate*0.01*days/365;
    end if;
    if(availmoneys>=repay) then
    	--修改贷款人账户的可用余额（扣除贷款的本金加利息）和待还金额（用户还款没结束不能进行第二次贷款，所以money修改为0）
       update tb_useraccount set accounmoney=accounmoney-repay,availmoney=availmoney-repay,money=0,lineofcredit=50000 where userinformationid = (select userinformationid from tb_userinformation where userid=loanid);
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --修改贷款状态
       update tb_loans set loansstate=11 where loansid=t_loansid;
        --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --更新资金池
       update tb_money set money=money+repay;
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --贷款人还款的时候，向平台的资金记录表添加一条数据
        insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,1,repay,sysdate,(select money from tb_money));
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --贷款人还款的时候，向个人的资金记录表添加一条数据
       insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
         (seq_tb_moneyrecord_id.nextval,sysdate,'还款',repay,loanid,'银行卡',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=loanid));
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
        --给本次贷款人员发送的系统消息
         insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
         values(seq_tb_message_id.nextval,'尊敬的客户，您好,您的编号为'||t_loansid||'的'||loansmoneys||'元贷款已自动扣款成功。如有疑问，请联系我们，我们一定为您解答',sysdate,loanid,'还款');
        --显示引发异常
         if sql%notfound then raise update_exception; end if;
       if loanstate =4 then
         --更新资金池
         update tb_money set money=money-repay;
         --显示引发异常
         if sql%notfound then raise update_exception; end if;
         --给投资人回款的时候，向平台的资金记录表添加一条数据
         insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,3,repay,sysdate,(select money from tb_money));
         --显示引发异常
         if sql%notfound then raise update_exception; end if;
         -- 打开游标
         open csr_invest(t_loansid);
           --循环取数据
           loop
             --取一行数据
             fetch csr_invest into t_csr_invest;
             --判断
             exit when csr_invest%notfound;
                --修改投资人账户中的可用余额（投资的本金加利息返还给投资人）和待收本金和待收利息（已经回款了，待收本机和待收利息都要相应的减少）
                update tb_useraccount set accounmoney=accounmoney+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,availmoney=availmoney+t_csr_invest.investmentmoney+
                      t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,awaitinterest=awaitinterest-t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,awaitmoney=awaitmoney-t_csr_invest.investmentmoney, 
                      accruedincome=accruedincome+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12 where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
                --显示引发异常
                if sql%notfound then raise update_exception; end if;
                --给本次投资人发送的消息
                insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
                       (seq_tb_message_id.nextval,'尊敬的客户，您好，您的编号为'||t_csr_invest.investmentid||'的'||t_csr_invest.investmentmoney||'元投资款已回款成功，请注意查收。如有疑问，请联系我们，我们一定为您解答',
                        sysdate,t_csr_invest.userid,'回款');
                --显示引发异常
                if sql%notfound then raise update_exception; end if;
                --贷款人回款的时候，向每个投资人的资金记录表添加一条数据
                insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
                       (seq_tb_moneyrecord_id.nextval,sysdate,'回款',t_csr_invest.investmentmoney+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,t_csr_invest.userid,'银行卡',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=t_csr_invest.userid));
                --显示引发异常
                if sql%notfound then raise update_exception; end if;
            end loop;
          --向还款表中插入数据，还款成功
          insert into tb_refund (refundid,loansid,refundmoney,refunddate,auditstate) values (seq_tb_refund_id.nextval,t_loansid,repay,sysdate,1);
          --显示引发异常
          if sql%notfound then raise update_exception; end if;
          --关闭游标
          close csr_invest; 
          else 
            --修改还款表中的还款状态为还款成功 
            update tb_refund set auditstate=2 where loansid=t_loansid;
          --显示引发异常
          if sql%notfound then raise update_exception; end if;
          
       end if;
     --保存
     commit;
     refundinfo:='还款成功';
     return;
     
     --判断已经逾期，但是余额仍然不足
     elsif loanstate=10 then
     --给本次贷款人员发送的系统消息
       insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'尊敬的客户，您好,您的编号为'||t_loansid||'的'||loansmoneys||'元贷款，因为余额不足，导致自动扣款失败，如果不及时还款将产生高额的逾期费用，请尽快充值并手动还款。
       如有疑问，请联系我们，我们一定为您解答',sysdate,loanid,'逾期');
       commit;
     refundinfo:='逾期还款';
     return;
     
     --没有逾期，但是余额不足
    else
       --如果贷款人账户资金不够的话，从资金池拿钱给投资人回款
       --修改本次贷款的状态为逾期
       update tb_loans set loansstate=10 where loansid=t_loansid;
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --给本次贷款人员发送的系统消息
       insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'尊敬的客户，您好,您的编号为'||t_loansid||'的'||loansmoneys||'元贷款，因为余额不足，导致自动扣款失败，如果不及时还款将产生高额的逾期费用，请尽快充值并手动还款。
       如有疑问，请联系我们，我们一定为您解答',sysdate,loanid,'逾期');
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --从资金池取出贷款人要还的金额
       update tb_money set money=money-repay;
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --向平台的资金记录表添加一条数据
       insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,4,repay,sysdate,(select money from tb_money));
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --打开游标
      open csr_invest(t_loansid);
      --循环取数据
      loop
        --取一行数据
        fetch csr_invest into t_csr_invest;
        --判断
        exit when csr_invest%notfound;
        --修改投资人账户中的可用余额（投资的本金加利息返还给投资人）和待收本金和待收利息（已经回款了，待收本机和待收利息都要相应的减少）
        update tb_useraccount set accounmoney=accounmoney+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,availmoney=availmoney+t_csr_invest.investmentmoney+
              t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,awaitinterest=awaitinterest-t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,awaitmoney=awaitmoney-t_csr_invest.investmentmoney 
              where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
        --显示引发异常
        if sql%notfound then raise update_exception; end if;
        --给本次投资人发送的消息
        insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
          (seq_tb_message_id.nextval,'尊敬的客户，您好，您的编号为'||t_csr_invest.investmentid||'的'||t_csr_invest.investmentmoney||'元投资款已回款成功，请注意查收。如有疑问，请联系我们，我们一定为您解答',
           sysdate,t_csr_invest.userid,'回款');
        --显示引发异常
        if sql%notfound then raise update_exception; end if;
        --贷款人回款的时候，向每个投资人的资金记录表添加一条数据
        insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
           (seq_tb_moneyrecord_id.nextval,sysdate,'回款',t_csr_invest.investmentmoney+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,t_csr_invest.userid,'银行卡',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=t_csr_invest.userid));
        --显示引发异常
        if sql%notfound then raise update_exception; end if;
     end loop;
     --关闭游标
     close csr_invest;
     --向还款表中插入数据
     insert into tb_refund (refundid,loansid,refundmoney,refunddate,auditstate) values (seq_tb_refund_id.nextval,t_loansid,repay,sysdate,2);
     --显示引发异常
        if sql%notfound then raise update_exception; end if;
      commit;
      refundinfo:='还款失败';
      return;
    end if;
  else
      refundinfo:='不能还款';
      return;
  end if;
  exception
   when no_data_found then
     refundinfo:='贷款不存在'; 
   when update_exception then 
     rollback;
   when others then 
     refundinfo:='系统出错了';
     rollback;
 end;


--------------------
、
create or replace procedure manbiaobohui(t_loansid in number,state in number,bohui in varchar2,refundinfo out number)
is
 investorid number;--投资人ID
 t_investmoney number;--投资金额
 t_loansinterstrate number;--贷款利率
 maxrefundtime number; --还款期限
 loanid number; --贷款人ID
 loanstate number;--贷款状态
 loansmoneys number;--贷款金额
 refundtime date;--还款时间
 --availmoneys number;--贷款人账户中的代还金额
 repay number;--借款人应还金额
 t_investmentid number; --投资编号
 periods number;--贷款期数
 the_repay_money number;--本期应还本金
 the_repay_interest number;--本期应还利息
 remain_money number; --剩余本金
 remain_interest number;--剩余利息
 tb_refundway varchar2(20); --贷款类型
 --定义一个游标
 cursor csr_invest(t_loansid number) is select userid,investmentmoney,interestrate,investmentid into investorid,t_investmoney,t_loansinterstrate,t_investmentid from tb_investment where loansid=t_loansid;
 t_csr_invest csr_invest%rowtype;--定义行级变量
 update_exception exception;
begin
  --根据贷款ID查询出贷款人ID和贷款状态，换款时间,贷款金额                                                                                                               -- 当前贷款类型
     select userid,loansstate,loansmoney,refunddeadline,loansinterestrate,tdate,refundway into loanid,loanstate,loansmoneys,maxrefundtime,t_loansinterstrate,refundtime,tb_refundway from tb_loans where loansid = t_loansid;
    --给当前还款期数赋初值
    periods:=1;
    --每期应还本金
    the_repay_money:=loansmoneys/maxrefundtime;
    --每期应还利息
    the_repay_interest:=loansmoneys*t_loansinterstrate*0.01/12;

    --1为通过
 if state = 1 then
    --计算出贷款人到期后应还的本金加利息
    repay:=loansmoneys+loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12;
    --贷款审核通过，把贷款金额扣除手续费后给贷款人账户中
    update tb_useraccount set accounmoney=accounmoney+loansmoneys*0.97,availmoney = availmoney+loansmoneys*0.97,money=repay where userinformationid = (select userinformationid from tb_userinformation where userid=loanid);
    --显示引发异常
        if sql%notfound then raise update_exception; end if;
    --更新资金池
    update tb_money set money=money+loansmoneys*0.03;
    --显示引发异常
        if sql%notfound then raise update_exception; end if;
    --更改贷款状态
    update tb_loans set loansstate = 5,time=sysdate,tdate=add_months(sysdate,+maxrefundtime) where loansid = t_loansid;
    --显示引发异常
        if sql%notfound then raise update_exception; end if;
    --向平台资金记录表添加数据
    insert into tb_company_money_record(recordid,loansid,moneychangetype,changemoney,changetime,availmoney) 
       values(seq_tb_moneypool_id.nextval,t_loansid,0,loansmoneys*0.03,sysdate,(select money from tb_money));
    --显示引发异常
        if sql%notfound then raise update_exception; end if;
    ---向个人的资金记录表添加一条数据
    insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
         (seq_tb_moneyrecord_id.nextval,sysdate,'贷款',loansmoneys*0.97,loanid,'银行卡',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=loanid));
    --显示引发异常
        if sql%notfound then raise update_exception; end if;
        
    -- 添加审核记录      
    insert into tb_auditrecord(auditrecordid,loansid,auditstype,auditstate,time) values(seq_tb_auditrecord_id.nextval,t_loansid,2,1,sysdate); 
    --显示引发异常
        if sql%notfound then raise update_exception; end if;
         
    --给本次贷款人员发送的系统消息
    insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'尊敬的客户，您好,您的编号为'||t_loansid||'的'||loansmoneys||'元贷款已扣除手续费后发放到您的账户中，请查收。如有疑问，请联系我们，我们一定为您解答',sysdate,loanid,'贷款');
    --显示引发异常
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line(tb_refundway);
     if tb_refundway='等额本息' then
        --循环向还款计划表中添加数据
       while (periods<=maxrefundtime) loop 
         --剩余本金
         remain_money:=loansmoneys-the_repay_money*(periods-1);
         --剩余利息
         remain_interest:=the_repay_interest*(maxrefundtime-periods+1);
         
         insert into tb_refund_plan(loansid,currentperiods,currentbalance,currentinterest,surplusmoney,surplusinterest,refundtime,refundstate,loanserid) values 
            (t_loansid,periods,the_repay_money,the_repay_interest,the_repay_money,the_repay_interest,add_months(sysdate,+maxrefundtime),0,loanid);
         periods:=periods+1;
         dbms_output.put_line('循环中');
       end loop;
      elsif tb_refundway='到期还本还息' then     
      
         insert into tb_refund_plan(loansid,currentperiods,currentbalance,currentinterest,surplusmoney,surplusinterest,refundtime,refundstate,loanserid) values 
            (t_loansid,periods,loansmoneys,loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12,loansmoneys,loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12,add_months(sysdate,+periods),0,loanid);
      
      end if;
    --打开游标
      open csr_invest(t_loansid);
      --循环取数据
       loop
        --取一行数据
        fetch csr_invest into t_csr_invest;
        --判断
        exit when csr_invest%notfound;
        --修改投资人账户中的待收本金和待收利息
       update tb_useraccount set awaitmoney=awaitmoney+t_csr_invest.investmentmoney,awaitinterest=awaitinterest+t_csr_invest.investmentmoney*t_csr_invest.interestrate*0.01*maxrefundtime/12,frozenCapital = frozenCapital-t_csr_invest.investmentmoney  where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --给本次投资人发送的消息
       insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
          (seq_tb_message_id.nextval,'尊敬的客户，您好，您的编号为'||t_csr_invest.investmentid||'的'||t_csr_invest.investmentmoney||'元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答',sysdate,t_csr_invest.userid,'投资');
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
        --向投资人的资金记录表添加一条数据
       --insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
          -- (seq_tb_moneyrecord_id.nextval,sysdate,'投资',t_csr_invest.investmentmoney,t_csr_invest.userid,'银行卡',(select availmoney from tb_useraccount where userid=t_csr_invest.userid));
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
     end loop;
     --关闭游标
     close csr_invest;
     
     commit;
    refundinfo:=1; --'审核成功'
    return;
    
     -- 2 为 驳回 
  elsif state=2 then
      --贷款驳回后修改贷款的状态
      update tb_loans set loansstate= 6 ,reason=bohui where loansid=t_loansid;
      --显示引发异常
        if sql%notfound then raise update_exception; end if;
      --更新公司资金池
      update tb_money set money=money-loansmoneys; --where userinformationid =(select userinformationid from tb_userinformation where userid=loanid);
      --显示引发异常
        if sql%notfound then raise update_exception; end if;
      -- 添加审核记录      
       insert into tb_auditrecord(auditrecordid,loansid,auditstype,auditstate,time) values(seq_tb_auditrecord_id.nextval,t_loansid,2,2,sysdate); 
       --显示引发异常
       if sql%notfound then raise update_exception; end if;
      --打开游标
      open csr_invest(t_loansid);
      --循环取数据
       loop
        --取一行数据
        fetch csr_invest into t_csr_invest;
        --判断
        exit when csr_invest%notfound;
        --修改投资人账户中的可用余额
       update tb_useraccount set accounmoney=accounmoney,availmoney = availmoney+t_csr_invest.investmentmoney,frozenCapital = frozenCapital - t_csr_invest.investmentmoney where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
       --给本次投资人发送的消息
       insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
          (seq_tb_message_id.nextval,'尊敬的客户，您好，您的编号为'||t_csr_invest.investmentid||'的'||t_csr_invest.investmentmoney||'元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答',
           sysdate,t_csr_invest.userid,'流标');
        --显示引发异常
        if sql%notfound then raise update_exception; end if;
        --显示引发异常
        if sql%notfound then raise update_exception; end if; 
       --向个人的资金记录表添加一条数据
       insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
           (seq_tb_moneyrecord_id.nextval,sysdate,'流标',t_csr_invest.investmentmoney,t_csr_invest.userid,'银行卡',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=t_csr_invest.userid));
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
     end loop;
     --关闭游标
     close csr_invest;
     --给本次贷款人员发送的系统消息
       insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'尊敬的客户，您好,您的编号为'||t_loansid||'的'||loansmoneys||'元贷款审核没通过，驳回原因为:'||bohui||'，如有疑问，请联系我们，我们一定为您解答',sysdate,loanid,'流标');
      --显示引发异常
        if sql%notfound then raise update_exception; end if;
    --向平台资金记录表添加数据
    insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,0,loansmoneys,sysdate,(select money from tb_money));
     --显示引发异常
        if sql%notfound then raise update_exception; end if;
     --保存
     commit;
      refundinfo:=0; --'审核失败'
      return;
      
      --流标
  elsif state=3 then
      --贷款流标后修改贷款的状态
      update tb_loans set loansstate= 7 ,reason=bohui where loansid=t_loansid;
      --显示引发异常
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('----');
      --更新资金池
      update tb_money set money=money-loansmoneys; --where userinformationid =(select userinformationid from tb_userinformation where userid=loanid);
      --显示引发异常
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('----1');
        dbms_output.put_line(t_loansid);
      --打开游标
      open csr_invest(t_loansid);
      dbms_output.put_line('---222-');
      --循环取数据
       loop
         dbms_output.put_line('---333-');
        --取一行数据
        fetch csr_invest into t_csr_invest;
        dbms_output.put_line('---444-');
        --判断
         exit when csr_invest%notfound;
        dbms_output.put_line('---111-');
        --修改投资人账户中的可用余额
       update tb_useraccount set accounmoney=accounmoney,availmoney = availmoney+t_csr_invest.investmentmoney,frozenCapital = frozenCapital - t_csr_invest.investmentmoney where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('---2-');
       --给本次投资人发送的消息
       insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
          (seq_tb_message_id.nextval,'尊敬的客户，您好，您的编号为'||t_csr_invest.investmentid||'的'||t_csr_invest.investmentmoney||'元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答',
           sysdate,t_csr_invest.userid,'流标');
        --显示引发异常
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line(t_loansid);
        --显示引发异常
        if sql%notfound then raise update_exception; end if;   
        dbms_output.put_line('----3');      
        --向个人的资金记录表添加一条数据
       insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
           (seq_tb_moneyrecord_id.nextval,sysdate,'流标',t_csr_invest.investmentmoney,t_csr_invest.userid,'银行卡',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=t_csr_invest.userid));
       --显示引发异常
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('----4');
     end loop;
     --关闭游标
     close csr_invest;
     
       -- 添加审核记录      
       insert into tb_auditrecord(auditrecordid,loansid,auditstype,auditstate,time) values(seq_tb_auditrecord_id.nextval,t_loansid,3,3,sysdate); 
        --显示引发异常
        if sql%notfound then raise update_exception; end if;
     
     --给本次贷款人员发送的系统消息
     insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'尊敬的客户，您好,您的编号为'||t_loansid||'的'||loansmoneys||'元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答',sysdate,loanid,'流标');
      --显示引发异常
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('---54-');
     --向平台资金记录表添加数据
    insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,0,loansmoneys,sysdate,(select money from tb_money));
     --显示引发异常
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('---6-');
     --保存
     commit;
      refundinfo:=7; --'流标'
      return;
  end if;
  exception
      when no_data_found then
           refundinfo:=3;--'贷款不存在';
      when update_exception then 
           rollback;
           refundinfo:=4;--'语句异常';
      when others then
           rollback;
           refundinfo:=5;--'系统异常';
 end;


