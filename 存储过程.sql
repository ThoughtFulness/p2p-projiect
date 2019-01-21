create or replace procedure beginrefund(refundinfo out varchar2)
is
 --����״̬
 v_state number;
 --����ʱ��
 v_tdate date;
 --����ID
 v_loansid number;
 --������ID
 v_userid number;
 --������
 v_loansmoney number;
 --����һ���α꣬��ѯ�����б�ʱ�䵽�ڵ�δ����Ĵ���ID  
 cursor csr_invest2 is select loansid,userid,loansmoney into v_loansid,v_userid,v_loansmoney from tb_loans where loansstate = 2 and investmentamount < loansmoney and (begintime+loancase)<sysdate;
 t_csr_invest2 csr_invest2%rowtype;--�����м�����
 --����һ���α꣬��ǰ�������Ѵ����˻���    to_char(tdate-1,'yyyy-mm-dd')=to_char(sysdate,'yyyy-mm-dd') ����� ����ʱ��ǰһ������д���id
 cursor csr_invest1 is select loansid,to_char(tdate,'yyyy/mm/dd'),userid,loansmoney into v_loansid,v_tdate,v_userid,v_loansmoney from tb_loans where (to_char(tdate-1,'yyyy-mm-dd')=to_char(sysdate,'yyyy-mm-dd') or to_char(tdate-2,'yyyy-mm-dd')=to_char(sysdate,'yyyy-mm-dd') or to_char(tdate-3,'yyyy-mm-dd')=to_char(sysdate,'yyyy-mm-dd')) and loansstate=5;
 t_csr_invest1 csr_invest1%rowtype;--�����м�����
 --����һ���α�,��ѯ�����л���ʱ�䵽�ڵĴ���ID
 cursor csr_invest is select loansid from tb_loans where (to_char(tdate,'yyyy/mm/dd')=to_char(sysdate,'yyyy/mm/dd') or tdate<sysdate) and loansstate in (5,10);
 t_csr_invest csr_invest%rowtype;--�����м�����
 update_exception exception;
 
begin
  
      --���α�  ��ѯ�����б�ʱ�䵽�ڵ�δ����Ĵ���ID  
      open csr_invest2;
        --ѭ��ȡ����
        loop
          --ȡһ������
          fetch csr_invest2 into t_csr_invest2;
          --�ж�
          exit when csr_invest2%notfound;
          update tb_loans set loansstate = 3 where loansid = t_csr_invest2.loansid;
          dbms_output.put_line(t_csr_invest2.userid||'111');
           --�����δ�����Ա���͵�ϵͳ��Ϣ
          insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
                 values(seq_tb_message_id.nextval,'�𾴵Ŀͻ�������,���ı��Ϊ'||t_csr_invest2.loansid||'��'||t_csr_invest2.loansmoney||'Ԫ����δ���꣬���´������ꡣ�������ʣ�����ϵ���ǣ�����һ��Ϊ�����',sysdate,t_csr_invest2.userid,'����');
        end loop;
        commit;
        --refundinfo:='������Ϣ���ͳɹ�';
      --�ر��α�
      close csr_invest2;   


      --���α� ��ǰ�������Ѵ����˻���
      open csr_invest1;
        --ѭ��ȡ����
        loop
          --ȡһ������
          fetch csr_invest1 into t_csr_invest1;
          --�ж�
          exit when csr_invest1%notfound;
          dbms_output.put_line(t_csr_invest1.userid||'222');
          --�����δ�����Ա���͵�ϵͳ��Ϣ
          insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
                 values(seq_tb_message_id.nextval,'�𾴵Ŀͻ�������,���ı��Ϊ'||t_csr_invest1.loansid||'��'||t_csr_invest1.loansmoney||'Ԫ���Ҫ��'||v_tdate||'����뱣֤�����˻��п����ʽ���㡣�������ʣ�����ϵ���ǣ�����һ��Ϊ�����',sysdate,t_csr_invest1.userid,'����');
        end loop;
        commit;
        --refundinfo:='��Ϣ���ͳɹ�';
      --�ر��α�
      close csr_invest1;  

      --���α�  ��ѯ�����л���ʱ�䵽�ڵĴ���ID
      open csr_invest;
        --ѭ��ȡ����
        loop
          --ȡһ������
          fetch csr_invest into t_csr_invest;
          --�ж�
          exit when csr_invest%notfound;
          --��ѯ��ǰ����Ĵ���״̬
          select loansstate into v_state from tb_loans where loansid=t_csr_invest.loansid;
          dbms_output.put_line(t_csr_invest.loansid||'----');
          dbms_output.put_line(v_state||'----');
          if v_state = 5 then
            --�޸�״̬Ϊ������
            update tb_loans set loansstate=4 where loansid=t_csr_invest.loansid;
            get_investor_info(t_csr_invest.loansid,refundinfo);
          elsif v_state=4 or v_state=10 then
            get_investor_info(t_csr_invest.loansid,refundinfo);
          end if;
        end loop;
        commit;
      --�ر��α�
      close csr_invest;
  exception
   when no_data_found then
     refundinfo:='���ܻ���';
   when update_exception then
     rollback;
   when others then
     refundinfo:='ϵͳ������';
     rollback;
 end;


















-=-------------------------------------------------------

create or replace procedure get_investor_info(t_loansid in number,refundinfo out varchar2)
is
 investorid number;--Ͷ����ID
 t_investmoney number;--Ͷ�ʽ��
 t_loansinterstrate number;--��������
 maxrefundtime number; --��������
 loanid number; --������ID
 loanstate number;--����״̬
 loansmoneys number;--������
 refundtime date;--����ʱ��
 availmoneys number;--�������˻��еĴ������
 repay number;--�����Ӧ�����
 t_investmentid number; --Ͷ�ʱ��
 days number;--��������
 --����һ���α�
 cursor csr_invest(t_loansid number) is select userid,investmentmoney,interestrate,investmentid into investorid,t_investmoney,t_loansinterstrate,t_investmentid from tb_investment where loansid=t_loansid;      
 t_csr_invest csr_invest%rowtype;--�����м�����
 update_exception exception;
begin
  --���ݴ���ID��ѯ��������ID�ʹ���״̬������ʱ��,������
  select userid,loansstate,loansmoney,refunddeadline,loansinterestrate,tdate into loanid,loanstate,loansmoneys,maxrefundtime,t_loansinterstrate,refundtime from tb_loans where loansid = t_loansid;
  --��ѯ�������˻��еĴ������
  select  availmoney into availmoneys from tb_useraccount where userinformationid = (select userinformationid from tb_userinformation where userid=loanid);
  --��ѯ��������
  select trunc(sysdate)-trunc(tdate) into days from tb_loans where loansid=t_loansid;
  --�жϱ������Ƿ��ڻ�����
  if loanstate=4 or loanstate=10 then
    if loanstate=4 then 
      --����������˵��ں�Ӧ���ı������Ϣ
      repay:=loansmoneys+loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12;
    else
      --����������˵��ں�Ӧ���ı������Ϣ
      repay:=loansmoneys+loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12+loansmoneys*t_loansinterstrate*0.01*days/365;
    end if;
    if(availmoneys>=repay) then
    	--�޸Ĵ������˻��Ŀ������۳�����ı������Ϣ���ʹ������û�����û�������ܽ��еڶ��δ������money�޸�Ϊ0��
       update tb_useraccount set accounmoney=accounmoney-repay,availmoney=availmoney-repay,money=0,lineofcredit=50000 where userinformationid = (select userinformationid from tb_userinformation where userid=loanid);
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --�޸Ĵ���״̬
       update tb_loans set loansstate=11 where loansid=t_loansid;
        --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --�����ʽ��
       update tb_money set money=money+repay;
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --�����˻����ʱ����ƽ̨���ʽ��¼�����һ������
        insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,1,repay,sysdate,(select money from tb_money));
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --�����˻����ʱ������˵��ʽ��¼�����һ������
       insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
         (seq_tb_moneyrecord_id.nextval,sysdate,'����',repay,loanid,'���п�',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=loanid));
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        --�����δ�����Ա���͵�ϵͳ��Ϣ
         insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
         values(seq_tb_message_id.nextval,'�𾴵Ŀͻ�������,���ı��Ϊ'||t_loansid||'��'||loansmoneys||'Ԫ�������Զ��ۿ�ɹ����������ʣ�����ϵ���ǣ�����һ��Ϊ�����',sysdate,loanid,'����');
        --��ʾ�����쳣
         if sql%notfound then raise update_exception; end if;
       if loanstate =4 then
         --�����ʽ��
         update tb_money set money=money-repay;
         --��ʾ�����쳣
         if sql%notfound then raise update_exception; end if;
         --��Ͷ���˻ؿ��ʱ����ƽ̨���ʽ��¼�����һ������
         insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,3,repay,sysdate,(select money from tb_money));
         --��ʾ�����쳣
         if sql%notfound then raise update_exception; end if;
         -- ���α�
         open csr_invest(t_loansid);
           --ѭ��ȡ����
           loop
             --ȡһ������
             fetch csr_invest into t_csr_invest;
             --�ж�
             exit when csr_invest%notfound;
                --�޸�Ͷ�����˻��еĿ�����Ͷ�ʵı������Ϣ������Ͷ���ˣ��ʹ��ձ���ʹ�����Ϣ���Ѿ��ؿ��ˣ����ձ����ʹ�����Ϣ��Ҫ��Ӧ�ļ��٣�
                update tb_useraccount set accounmoney=accounmoney+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,availmoney=availmoney+t_csr_invest.investmentmoney+
                      t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,awaitinterest=awaitinterest-t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,awaitmoney=awaitmoney-t_csr_invest.investmentmoney, 
                      accruedincome=accruedincome+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12 where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
                --��ʾ�����쳣
                if sql%notfound then raise update_exception; end if;
                --������Ͷ���˷��͵���Ϣ
                insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
                       (seq_tb_message_id.nextval,'�𾴵Ŀͻ������ã����ı��Ϊ'||t_csr_invest.investmentid||'��'||t_csr_invest.investmentmoney||'ԪͶ�ʿ��ѻؿ�ɹ�����ע����ա��������ʣ�����ϵ���ǣ�����һ��Ϊ�����',
                        sysdate,t_csr_invest.userid,'�ؿ�');
                --��ʾ�����쳣
                if sql%notfound then raise update_exception; end if;
                --�����˻ؿ��ʱ����ÿ��Ͷ���˵��ʽ��¼�����һ������
                insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
                       (seq_tb_moneyrecord_id.nextval,sysdate,'�ؿ�',t_csr_invest.investmentmoney+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,t_csr_invest.userid,'���п�',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=t_csr_invest.userid));
                --��ʾ�����쳣
                if sql%notfound then raise update_exception; end if;
            end loop;
          --�򻹿���в������ݣ�����ɹ�
          insert into tb_refund (refundid,loansid,refundmoney,refunddate,auditstate) values (seq_tb_refund_id.nextval,t_loansid,repay,sysdate,1);
          --��ʾ�����쳣
          if sql%notfound then raise update_exception; end if;
          --�ر��α�
          close csr_invest; 
          else 
            --�޸Ļ�����еĻ���״̬Ϊ����ɹ� 
            update tb_refund set auditstate=2 where loansid=t_loansid;
          --��ʾ�����쳣
          if sql%notfound then raise update_exception; end if;
          
       end if;
     --����
     commit;
     refundinfo:='����ɹ�';
     return;
     
     --�ж��Ѿ����ڣ����������Ȼ����
     elsif loanstate=10 then
     --�����δ�����Ա���͵�ϵͳ��Ϣ
       insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'�𾴵Ŀͻ�������,���ı��Ϊ'||t_loansid||'��'||loansmoneys||'Ԫ�����Ϊ���㣬�����Զ��ۿ�ʧ�ܣ��������ʱ��������߶�����ڷ��ã��뾡���ֵ���ֶ����
       �������ʣ�����ϵ���ǣ�����һ��Ϊ�����',sysdate,loanid,'����');
       commit;
     refundinfo:='���ڻ���';
     return;
     
     --û�����ڣ���������
    else
       --����������˻��ʽ𲻹��Ļ������ʽ����Ǯ��Ͷ���˻ؿ�
       --�޸ı��δ����״̬Ϊ����
       update tb_loans set loansstate=10 where loansid=t_loansid;
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --�����δ�����Ա���͵�ϵͳ��Ϣ
       insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'�𾴵Ŀͻ�������,���ı��Ϊ'||t_loansid||'��'||loansmoneys||'Ԫ�����Ϊ���㣬�����Զ��ۿ�ʧ�ܣ��������ʱ��������߶�����ڷ��ã��뾡���ֵ���ֶ����
       �������ʣ�����ϵ���ǣ�����һ��Ϊ�����',sysdate,loanid,'����');
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --���ʽ��ȡ��������Ҫ���Ľ��
       update tb_money set money=money-repay;
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --��ƽ̨���ʽ��¼�����һ������
       insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,4,repay,sysdate,(select money from tb_money));
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --���α�
      open csr_invest(t_loansid);
      --ѭ��ȡ����
      loop
        --ȡһ������
        fetch csr_invest into t_csr_invest;
        --�ж�
        exit when csr_invest%notfound;
        --�޸�Ͷ�����˻��еĿ�����Ͷ�ʵı������Ϣ������Ͷ���ˣ��ʹ��ձ���ʹ�����Ϣ���Ѿ��ؿ��ˣ����ձ����ʹ�����Ϣ��Ҫ��Ӧ�ļ��٣�
        update tb_useraccount set accounmoney=accounmoney+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,availmoney=availmoney+t_csr_invest.investmentmoney+
              t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,awaitinterest=awaitinterest-t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,awaitmoney=awaitmoney-t_csr_invest.investmentmoney 
              where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
        --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        --������Ͷ���˷��͵���Ϣ
        insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
          (seq_tb_message_id.nextval,'�𾴵Ŀͻ������ã����ı��Ϊ'||t_csr_invest.investmentid||'��'||t_csr_invest.investmentmoney||'ԪͶ�ʿ��ѻؿ�ɹ�����ע����ա��������ʣ�����ϵ���ǣ�����һ��Ϊ�����',
           sysdate,t_csr_invest.userid,'�ؿ�');
        --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        --�����˻ؿ��ʱ����ÿ��Ͷ���˵��ʽ��¼�����һ������
        insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
           (seq_tb_moneyrecord_id.nextval,sysdate,'�ؿ�',t_csr_invest.investmentmoney+t_csr_invest.investmentmoney*t_loansinterstrate*0.01*maxrefundtime/12,t_csr_invest.userid,'���п�',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=t_csr_invest.userid));
        --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
     end loop;
     --�ر��α�
     close csr_invest;
     --�򻹿���в�������
     insert into tb_refund (refundid,loansid,refundmoney,refunddate,auditstate) values (seq_tb_refund_id.nextval,t_loansid,repay,sysdate,2);
     --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
      commit;
      refundinfo:='����ʧ��';
      return;
    end if;
  else
      refundinfo:='���ܻ���';
      return;
  end if;
  exception
   when no_data_found then
     refundinfo:='�������'; 
   when update_exception then 
     rollback;
   when others then 
     refundinfo:='ϵͳ������';
     rollback;
 end;


--------------------
��
create or replace procedure manbiaobohui(t_loansid in number,state in number,bohui in varchar2,refundinfo out number)
is
 investorid number;--Ͷ����ID
 t_investmoney number;--Ͷ�ʽ��
 t_loansinterstrate number;--��������
 maxrefundtime number; --��������
 loanid number; --������ID
 loanstate number;--����״̬
 loansmoneys number;--������
 refundtime date;--����ʱ��
 --availmoneys number;--�������˻��еĴ������
 repay number;--�����Ӧ�����
 t_investmentid number; --Ͷ�ʱ��
 periods number;--��������
 the_repay_money number;--����Ӧ������
 the_repay_interest number;--����Ӧ����Ϣ
 remain_money number; --ʣ�౾��
 remain_interest number;--ʣ����Ϣ
 tb_refundway varchar2(20); --��������
 --����һ���α�
 cursor csr_invest(t_loansid number) is select userid,investmentmoney,interestrate,investmentid into investorid,t_investmoney,t_loansinterstrate,t_investmentid from tb_investment where loansid=t_loansid;
 t_csr_invest csr_invest%rowtype;--�����м�����
 update_exception exception;
begin
  --���ݴ���ID��ѯ��������ID�ʹ���״̬������ʱ��,������                                                                                                               -- ��ǰ��������
     select userid,loansstate,loansmoney,refunddeadline,loansinterestrate,tdate,refundway into loanid,loanstate,loansmoneys,maxrefundtime,t_loansinterstrate,refundtime,tb_refundway from tb_loans where loansid = t_loansid;
    --����ǰ������������ֵ
    periods:=1;
    --ÿ��Ӧ������
    the_repay_money:=loansmoneys/maxrefundtime;
    --ÿ��Ӧ����Ϣ
    the_repay_interest:=loansmoneys*t_loansinterstrate*0.01/12;

    --1Ϊͨ��
 if state = 1 then
    --����������˵��ں�Ӧ���ı������Ϣ
    repay:=loansmoneys+loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12;
    --�������ͨ�����Ѵ�����۳������Ѻ���������˻���
    update tb_useraccount set accounmoney=accounmoney+loansmoneys*0.97,availmoney = availmoney+loansmoneys*0.97,money=repay where userinformationid = (select userinformationid from tb_userinformation where userid=loanid);
    --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
    --�����ʽ��
    update tb_money set money=money+loansmoneys*0.03;
    --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
    --���Ĵ���״̬
    update tb_loans set loansstate = 5,time=sysdate,tdate=add_months(sysdate,+maxrefundtime) where loansid = t_loansid;
    --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
    --��ƽ̨�ʽ��¼���������
    insert into tb_company_money_record(recordid,loansid,moneychangetype,changemoney,changetime,availmoney) 
       values(seq_tb_moneypool_id.nextval,t_loansid,0,loansmoneys*0.03,sysdate,(select money from tb_money));
    --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
    ---����˵��ʽ��¼�����һ������
    insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
         (seq_tb_moneyrecord_id.nextval,sysdate,'����',loansmoneys*0.97,loanid,'���п�',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=loanid));
    --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        
    -- �����˼�¼      
    insert into tb_auditrecord(auditrecordid,loansid,auditstype,auditstate,time) values(seq_tb_auditrecord_id.nextval,t_loansid,2,1,sysdate); 
    --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
         
    --�����δ�����Ա���͵�ϵͳ��Ϣ
    insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'�𾴵Ŀͻ�������,���ı��Ϊ'||t_loansid||'��'||loansmoneys||'Ԫ�����ѿ۳������Ѻ󷢷ŵ������˻��У�����ա��������ʣ�����ϵ���ǣ�����һ��Ϊ�����',sysdate,loanid,'����');
    --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line(tb_refundway);
     if tb_refundway='�ȶϢ' then
        --ѭ���򻹿�ƻ������������
       while (periods<=maxrefundtime) loop 
         --ʣ�౾��
         remain_money:=loansmoneys-the_repay_money*(periods-1);
         --ʣ����Ϣ
         remain_interest:=the_repay_interest*(maxrefundtime-periods+1);
         
         insert into tb_refund_plan(loansid,currentperiods,currentbalance,currentinterest,surplusmoney,surplusinterest,refundtime,refundstate,loanserid) values 
            (t_loansid,periods,the_repay_money,the_repay_interest,the_repay_money,the_repay_interest,add_months(sysdate,+maxrefundtime),0,loanid);
         periods:=periods+1;
         dbms_output.put_line('ѭ����');
       end loop;
      elsif tb_refundway='���ڻ�����Ϣ' then     
      
         insert into tb_refund_plan(loansid,currentperiods,currentbalance,currentinterest,surplusmoney,surplusinterest,refundtime,refundstate,loanserid) values 
            (t_loansid,periods,loansmoneys,loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12,loansmoneys,loansmoneys*t_loansinterstrate*0.01*maxrefundtime/12,add_months(sysdate,+periods),0,loanid);
      
      end if;
    --���α�
      open csr_invest(t_loansid);
      --ѭ��ȡ����
       loop
        --ȡһ������
        fetch csr_invest into t_csr_invest;
        --�ж�
        exit when csr_invest%notfound;
        --�޸�Ͷ�����˻��еĴ��ձ���ʹ�����Ϣ
       update tb_useraccount set awaitmoney=awaitmoney+t_csr_invest.investmentmoney,awaitinterest=awaitinterest+t_csr_invest.investmentmoney*t_csr_invest.interestrate*0.01*maxrefundtime/12,frozenCapital = frozenCapital-t_csr_invest.investmentmoney  where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --������Ͷ���˷��͵���Ϣ
       insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
          (seq_tb_message_id.nextval,'�𾴵Ŀͻ������ã����ı��Ϊ'||t_csr_invest.investmentid||'��'||t_csr_invest.investmentmoney||'ԪͶ��,���б�,�����ĵȴ����档�������ʣ�����ϵ���ǣ�����һ��Ϊ�����',sysdate,t_csr_invest.userid,'Ͷ��');
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        --��Ͷ���˵��ʽ��¼�����һ������
       --insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
          -- (seq_tb_moneyrecord_id.nextval,sysdate,'Ͷ��',t_csr_invest.investmentmoney,t_csr_invest.userid,'���п�',(select availmoney from tb_useraccount where userid=t_csr_invest.userid));
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
     end loop;
     --�ر��α�
     close csr_invest;
     
     commit;
    refundinfo:=1; --'��˳ɹ�'
    return;
    
     -- 2 Ϊ ���� 
  elsif state=2 then
      --����غ��޸Ĵ����״̬
      update tb_loans set loansstate= 6 ,reason=bohui where loansid=t_loansid;
      --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
      --���¹�˾�ʽ��
      update tb_money set money=money-loansmoneys; --where userinformationid =(select userinformationid from tb_userinformation where userid=loanid);
      --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
      -- �����˼�¼      
       insert into tb_auditrecord(auditrecordid,loansid,auditstype,auditstate,time) values(seq_tb_auditrecord_id.nextval,t_loansid,2,2,sysdate); 
       --��ʾ�����쳣
       if sql%notfound then raise update_exception; end if;
      --���α�
      open csr_invest(t_loansid);
      --ѭ��ȡ����
       loop
        --ȡһ������
        fetch csr_invest into t_csr_invest;
        --�ж�
        exit when csr_invest%notfound;
        --�޸�Ͷ�����˻��еĿ������
       update tb_useraccount set accounmoney=accounmoney,availmoney = availmoney+t_csr_invest.investmentmoney,frozenCapital = frozenCapital - t_csr_invest.investmentmoney where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
       --������Ͷ���˷��͵���Ϣ
       insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
          (seq_tb_message_id.nextval,'�𾴵Ŀͻ������ã����ı��Ϊ'||t_csr_invest.investmentid||'��'||t_csr_invest.investmentmoney||'ԪͶ�����꣬����ѷ�������ע����ա��������ʣ�����ϵ���ǣ�����һ��Ϊ�����',
           sysdate,t_csr_invest.userid,'����');
        --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if; 
       --����˵��ʽ��¼�����һ������
       insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
           (seq_tb_moneyrecord_id.nextval,sysdate,'����',t_csr_invest.investmentmoney,t_csr_invest.userid,'���п�',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=t_csr_invest.userid));
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
     end loop;
     --�ر��α�
     close csr_invest;
     --�����δ�����Ա���͵�ϵͳ��Ϣ
       insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'�𾴵Ŀͻ�������,���ı��Ϊ'||t_loansid||'��'||loansmoneys||'Ԫ�������ûͨ��������ԭ��Ϊ:'||bohui||'���������ʣ�����ϵ���ǣ�����һ��Ϊ�����',sysdate,loanid,'����');
      --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
    --��ƽ̨�ʽ��¼���������
    insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,0,loansmoneys,sysdate,(select money from tb_money));
     --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
     --����
     commit;
      refundinfo:=0; --'���ʧ��'
      return;
      
      --����
  elsif state=3 then
      --����������޸Ĵ����״̬
      update tb_loans set loansstate= 7 ,reason=bohui where loansid=t_loansid;
      --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('----');
      --�����ʽ��
      update tb_money set money=money-loansmoneys; --where userinformationid =(select userinformationid from tb_userinformation where userid=loanid);
      --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('----1');
        dbms_output.put_line(t_loansid);
      --���α�
      open csr_invest(t_loansid);
      dbms_output.put_line('---222-');
      --ѭ��ȡ����
       loop
         dbms_output.put_line('---333-');
        --ȡһ������
        fetch csr_invest into t_csr_invest;
        dbms_output.put_line('---444-');
        --�ж�
         exit when csr_invest%notfound;
        dbms_output.put_line('---111-');
        --�޸�Ͷ�����˻��еĿ������
       update tb_useraccount set accounmoney=accounmoney,availmoney = availmoney+t_csr_invest.investmentmoney,frozenCapital = frozenCapital - t_csr_invest.investmentmoney where userinformationid =(select userinformationid from tb_userinformation where userid=t_csr_invest.userid);
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('---2-');
       --������Ͷ���˷��͵���Ϣ
       insert into tb_message(messageid,messagecontent,sendtime,userid,messagetype) values
          (seq_tb_message_id.nextval,'�𾴵Ŀͻ������ã����ı��Ϊ'||t_csr_invest.investmentid||'��'||t_csr_invest.investmentmoney||'ԪͶ�����꣬����ѷ�������ע����ա��������ʣ�����ϵ���ǣ�����һ��Ϊ�����',
           sysdate,t_csr_invest.userid,'����');
        --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line(t_loansid);
        --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;   
        dbms_output.put_line('----3');      
        --����˵��ʽ��¼�����һ������
       insert into tb_moneyrecord (moneyrecord,watercoursetime,watercoursetype,watercoursemoney,userid,chargeway,balance) values
           (seq_tb_moneyrecord_id.nextval,sysdate,'����',t_csr_invest.investmentmoney,t_csr_invest.userid,'���п�',(select a.availmoney from tb_useraccount a
         join tb_userinformation b on a.userinformationid=b.userinformationid
         where b.userid=t_csr_invest.userid));
       --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('----4');
     end loop;
     --�ر��α�
     close csr_invest;
     
       -- �����˼�¼      
       insert into tb_auditrecord(auditrecordid,loansid,auditstype,auditstate,time) values(seq_tb_auditrecord_id.nextval,t_loansid,3,3,sysdate); 
        --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
     
     --�����δ�����Ա���͵�ϵͳ��Ϣ
     insert into tb_message (messageid,messagecontent,sendtime,userid,messagetype)
       values(seq_tb_message_id.nextval,'�𾴵Ŀͻ�������,���ı��Ϊ'||t_loansid||'��'||loansmoneys||'Ԫ����δ����,������ʧ��!�������ʣ�����ϵ���ǣ�����һ��Ϊ�����',sysdate,loanid,'����');
      --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('---54-');
     --��ƽ̨�ʽ��¼���������
    insert into tb_company_money_record (recordid,loansid,moneychangetype,changemoney,changetime,availmoney) values (seq_tb_moneypool_id.nextval,t_loansid,0,loansmoneys,sysdate,(select money from tb_money));
     --��ʾ�����쳣
        if sql%notfound then raise update_exception; end if;
        dbms_output.put_line('---6-');
     --����
     commit;
      refundinfo:=7; --'����'
      return;
  end if;
  exception
      when no_data_found then
           refundinfo:=3;--'�������';
      when update_exception then 
           rollback;
           refundinfo:=4;--'����쳣';
      when others then
           rollback;
           refundinfo:=5;--'ϵͳ�쳣';
 end;


