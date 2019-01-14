prompt PL/SQL Developer import file
prompt Created on 2019年1月14日 by Administrator
set feedback off
set define off
prompt Creating TB_ACCOUNT...
create table TB_ACCOUNT
(
  account_id   NUMBER not null,
  username     VARCHAR2(20) not null,
  password     VARCHAR2(20) not null,
  roleid       VARCHAR2(20),
  account_name VARCHAR2(20),
  create_date  DATE,
  post         VARCHAR2(20)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_ACCOUNT.account_id
  is '管理员账户id';
comment on column TB_ACCOUNT.username
  is '用户名';
comment on column TB_ACCOUNT.password
  is '密码';
comment on column TB_ACCOUNT.roleid
  is '权限';
comment on column TB_ACCOUNT.account_name
  is '帐户名';
comment on column TB_ACCOUNT.create_date
  is '创建日期';
comment on column TB_ACCOUNT.post
  is '账户职位';

prompt Creating TB_AUDITRECORD...
create table TB_AUDITRECORD
(
  auditrecordid NUMBER not null,
  loansid       NUMBER not null,
  auditstype    NUMBER not null,
  auditstate    NUMBER not null,
  time          DATE not null
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_AUDITRECORD.auditrecordid
  is '审核记录id';
comment on column TB_AUDITRECORD.loansid
  is '贷款id';
comment on column TB_AUDITRECORD.auditstype
  is '审核类型1为招标审核 2为满标审核 3为流标审核';
comment on column TB_AUDITRECORD.auditstate
  is '审核装态 1为通过  2为驳回 3为确认';
comment on column TB_AUDITRECORD.time
  is '时间';

prompt Creating TB_COMMENT...
create table TB_COMMENT
(
  commentid NUMBER,
  jinnangid NUMBER,
  userid    NUMBER,
  content   VARCHAR2(200),
  datetime  DATE
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_COMMENT.commentid
  is '主键id';
comment on column TB_COMMENT.jinnangid
  is '所属锦囊id';
comment on column TB_COMMENT.userid
  is '操作人id';
comment on column TB_COMMENT.content
  is '评论内容';
comment on column TB_COMMENT.datetime
  is '评论时间';

prompt Creating TB_COMPANY_MONEY_RECORD...
create table TB_COMPANY_MONEY_RECORD
(
  recordid        NUMBER not null,
  loansid         NUMBER not null,
  moneychangetype NUMBER,
  changemoney     NUMBER(10,2),
  changetime      DATE,
  availmoney      NUMBER(10,2),
  earnmoney       NUMBER(10,2)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
    maxextents unlimited
  );
comment on column TB_COMPANY_MONEY_RECORD.recordid
  is '平台资金记录ID';
comment on column TB_COMPANY_MONEY_RECORD.loansid
  is '贷款编号';
comment on column TB_COMPANY_MONEY_RECORD.moneychangetype
  is '资金变动类型 0代表是借款  1代表是还款 2是投资 3是回款';
comment on column TB_COMPANY_MONEY_RECORD.changemoney
  is '本次变动资金';
comment on column TB_COMPANY_MONEY_RECORD.changetime
  is '资金变动时间';
comment on column TB_COMPANY_MONEY_RECORD.availmoney
  is '可用资金';
comment on column TB_COMPANY_MONEY_RECORD.earnmoney
  is '本次盈利';

prompt Creating TB_INVESTMENT...
create table TB_INVESTMENT
(
  investmentid    NUMBER not null,
  userid          NUMBER not null,
  loansid         NUMBER not null,
  investmentmoney NUMBER,
  investmentdate  DATE,
  interestrate    NUMBER,
  earnings        NUMBER default 0
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_INVESTMENT.investmentid
  is '投资id';
comment on column TB_INVESTMENT.userid
  is '用户ID';
comment on column TB_INVESTMENT.loansid
  is '贷款Id';
comment on column TB_INVESTMENT.investmentmoney
  is '投资金额';
comment on column TB_INVESTMENT.investmentdate
  is '投标时间';
comment on column TB_INVESTMENT.interestrate
  is '利率';
comment on column TB_INVESTMENT.earnings
  is '本次收益';

prompt Creating TB_JINNANG...
create table TB_JINNANG
(
  issuer_id NUMBER not null,
  id        NUMBER not null,
  headline  VARCHAR2(4000) not null,
  content   VARCHAR2(4000),
  praise    NUMBER
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_JINNANG.issuer_id
  is '发布人id';
comment on column TB_JINNANG.id
  is '主键id';
comment on column TB_JINNANG.headline
  is '锦囊标题';
comment on column TB_JINNANG.content
  is '内容';
comment on column TB_JINNANG.praise
  is '点赞数量';

prompt Creating TB_LIMIT...
create table TB_LIMIT
(
  powerid   NUMBER,
  powername VARCHAR2(30),
  parentid  NUMBER,
  state     VARCHAR2(20),
  incocls   VARCHAR2(20),
  url       VARCHAR2(200),
  remark    VARCHAR2(50)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_LIMIT.powerid
  is 'id';
comment on column TB_LIMIT.powername
  is '权限名称';
comment on column TB_LIMIT.parentid
  is '父ID';
comment on column TB_LIMIT.state
  is '状态（打开  关闭）';
comment on column TB_LIMIT.incocls
  is '节点图标';
comment on column TB_LIMIT.url
  is '请求地址';
comment on column TB_LIMIT.remark
  is '备注';

prompt Creating TB_LOANS...
create table TB_LOANS
(
  loansid           NUMBER not null,
  userid            NUMBER not null,
  username          VARCHAR2(20),
  loansmoney        NUMBER,
  refundway         NVARCHAR2(20),
  loansinterestrate NUMBER,
  refunddeadline    VARCHAR2(20),
  begintime         DATE,
  howmanydays       VARCHAR2(20),
  describe          VARCHAR2(4000),
  loanstype         NUMBER,
  time              DATE,
  loansused         VARCHAR2(20),
  investmentamount  NUMBER default 0 not null,
  loansstate        NUMBER,
  loancase          NUMBER,
  userphone         VARCHAR2(20),
  tdate             DATE,
  reason            VARCHAR2(20)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_LOANS.loansid
  is '借款Id';
comment on column TB_LOANS.userid
  is '申请人Id';
comment on column TB_LOANS.username
  is '申请人';
comment on column TB_LOANS.loansmoney
  is '贷款金额';
comment on column TB_LOANS.refundway
  is '还款方式 ';
comment on column TB_LOANS.loansinterestrate
  is '贷款利率';
comment on column TB_LOANS.refunddeadline
  is '还款期限(月)';
comment on column TB_LOANS.begintime
  is '开始招标时间  ';
comment on column TB_LOANS.howmanydays
  is '招标天数 ';
comment on column TB_LOANS.describe
  is '借款描述';
comment on column TB_LOANS.loanstype
  is '贷款的类型 3:信用贷  1:车辆抵押贷 2:房屋抵押贷';
comment on column TB_LOANS.time
  is '贷款时间';
comment on column TB_LOANS.loansused
  is '贷款用途';
comment on column TB_LOANS.investmentamount
  is '投资金额';
comment on column TB_LOANS.loansstate
  is '贷款状态 1:未审核,2:招标中,0:审核失败,3:流标,4;还款中,5;满标审核通过,6:满标审核失败,7:流标审核后，10:逾期,11:还款结束';
comment on column TB_LOANS.loancase
  is '贷款情况 3：普通贷款  5：紧急贷款 ';
comment on column TB_LOANS.userphone
  is '申请人手机号';
comment on column TB_LOANS.tdate
  is '还款时间  ';
comment on column TB_LOANS.reason
  is '驳回信息';
alter table TB_LOANS
  add constraint ASD primary key (LOANSID)
  disable;

prompt Creating TB_LOANSTYPE...
create table TB_LOANSTYPE
(
  loanstypeid     NUMBER,
  loansid         NUMBER not null,
  loanstype       NUMBER not null,
  globalvalue     NUMBER,
  housenumber     NUMBER,
  houseproperty   VARCHAR2(100),
  carinformation  VARCHAR2(100),
  carvalue        NUMBER,
  appraisalreport VARCHAR2(100),
  loanstypename   VARCHAR2(100)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_LOANSTYPE.loanstypeid
  is '这个字段没用了';
comment on column TB_LOANSTYPE.loansid
  is '贷款编号';
comment on column TB_LOANSTYPE.loanstype
  is '贷款类型';
comment on column TB_LOANSTYPE.globalvalue
  is '总价值';
comment on column TB_LOANSTYPE.housenumber
  is '房屋数量';
comment on column TB_LOANSTYPE.houseproperty
  is '房产证照片';
comment on column TB_LOANSTYPE.carinformation
  is '车辆信息';
comment on column TB_LOANSTYPE.carvalue
  is '车辆价值';
comment on column TB_LOANSTYPE.appraisalreport
  is '评估报告';
comment on column TB_LOANSTYPE.loanstypename
  is '贷款类型名称';

prompt Creating TB_MESSAGE...
create table TB_MESSAGE
(
  messageid      NUMBER not null,
  messagetitle   VARCHAR2(255),
  messagecontent VARCHAR2(4000),
  messagestate   NUMBER default 1,
  sendtime       DATE,
  userid         NUMBER,
  messagetype    VARCHAR2(255),
  state1         VARCHAR2(255),
  state2         NUMBER
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_MESSAGE.messageid
  is '系统消息ID';
comment on column TB_MESSAGE.messagetitle
  is '消息头部 不要';
comment on column TB_MESSAGE.messagecontent
  is '消息内容';
comment on column TB_MESSAGE.messagestate
  is '消息状态2为已读 1为未读';
comment on column TB_MESSAGE.sendtime
  is '消息发送时间';
comment on column TB_MESSAGE.userid
  is '用户ID';
comment on column TB_MESSAGE.messagetype
  is '消息类型';
comment on column TB_MESSAGE.state1
  is '待定列';
comment on column TB_MESSAGE.state2
  is '待定列';
alter table TB_MESSAGE
  add constraint MESSAGEID primary key (MESSAGEID)
  using index 
  tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_MONEY...
create table TB_MONEY
(
  money NUMBER(10,2) not null
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_MONEY.money
  is '可用资金';

prompt Creating TB_MONEYRECORD...
create table TB_MONEYRECORD
(
  moneyrecord      NUMBER not null,
  watercoursetime  DATE,
  watercoursetype  VARCHAR2(20),
  watercoursemoney NUMBER(10,2),
  chargeway        VARCHAR2(20) default '银行卡',
  userid           NUMBER not null,
  balance          NUMBER(10,2)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_MONEYRECORD.moneyrecord
  is '资金记录id';
comment on column TB_MONEYRECORD.watercoursetime
  is '流水时间';
comment on column TB_MONEYRECORD.watercoursetype
  is '流水类型';
comment on column TB_MONEYRECORD.watercoursemoney
  is '流水金额';
comment on column TB_MONEYRECORD.chargeway
  is '充值方式';
comment on column TB_MONEYRECORD.userid
  is '用户ID';
comment on column TB_MONEYRECORD.balance
  is '账户余额';

prompt Creating TB_NOTICE...
create table TB_NOTICE
(
  id       NUMBER not null,
  headline VARCHAR2(200),
  content  VARCHAR2(2000),
  time     DATE,
  operator VARCHAR2(20)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_NOTICE.id
  is '新闻ID';
comment on column TB_NOTICE.headline
  is '新闻标题';
comment on column TB_NOTICE.content
  is '新闻内容';
comment on column TB_NOTICE.time
  is '发布时间';
comment on column TB_NOTICE.operator
  is '操作人';

prompt Creating TB_REFUND...
create table TB_REFUND
(
  refundid     NUMBER not null,
  investmentid NUMBER,
  loansid      NUMBER not null,
  refundmoney  NUMBER(10,2) default 0,
  refunddate   DATE,
  auditstate   NUMBER,
  surplustime  TIMESTAMP(6)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_REFUND.refundid
  is '还款Id';
comment on column TB_REFUND.investmentid
  is '投资Id';
comment on column TB_REFUND.loansid
  is '贷款Id';
comment on column TB_REFUND.refundmoney
  is '还款金额';
comment on column TB_REFUND.refunddate
  is '还款时间';
comment on column TB_REFUND.auditstate
  is '还款状态 1为还款成功 2为逾期';
comment on column TB_REFUND.surplustime
  is '剩余天数';

prompt Creating TB_REFUND_PLAN...
create table TB_REFUND_PLAN
(
  loansid         NUMBER not null,
  currentperiods  NUMBER,
  currentbalance  NUMBER(10,2),
  currentinterest NUMBER(10,2),
  surplusmoney    NUMBER(10,2),
  surplusinterest NUMBER(10,2),
  overdueinterest NUMBER(10,2),
  refundtime      DATE,
  refundstate     NUMBER,
  loanserid       NUMBER
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_REFUND_PLAN.loansid
  is '贷款id';
comment on column TB_REFUND_PLAN.currentperiods
  is '当前期数';
comment on column TB_REFUND_PLAN.currentbalance
  is '本期应还本金';
comment on column TB_REFUND_PLAN.currentinterest
  is '本期应还利息';
comment on column TB_REFUND_PLAN.surplusmoney
  is '剩余本金';
comment on column TB_REFUND_PLAN.surplusinterest
  is '剩余利息';
comment on column TB_REFUND_PLAN.overdueinterest
  is '逾期利息';
comment on column TB_REFUND_PLAN.refundtime
  is '还款时间';
comment on column TB_REFUND_PLAN.refundstate
  is '本期还款状态1为还款成功 2.为逾期 0为待还款';
comment on column TB_REFUND_PLAN.loanserid
  is '贷款人ID';

prompt Creating TB_RESOURCES...
create table TB_RESOURCES
(
  id       NUMBER(10),
  name     VARCHAR2(20),
  resurl   VARCHAR2(100),
  type     NUMBER(10),
  parentid NUMBER(10),
  sort     NUMBER(10)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_RESOURCES.name
  is '资源名称';
comment on column TB_RESOURCES.resurl
  is '资源url';
comment on column TB_RESOURCES.type
  is '资源类型   1:菜单    2：按钮';
comment on column TB_RESOURCES.parentid
  is '父资源';
comment on column TB_RESOURCES.sort
  is '排序';

prompt Creating TB_ROLE...
create table TB_ROLE
(
  roledesc VARCHAR2(20),
  roleid   NUMBER,
  rolename VARCHAR2(20),
  roleflag VARCHAR2(20)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_ROLE.roledesc
  is '角色描述';
comment on column TB_ROLE.roleid
  is '角色管理ID';
comment on column TB_ROLE.rolename
  is '角色昵称';
comment on column TB_ROLE.roleflag
  is '角色状态';

prompt Creating TB_ROLE_POWER...
create table TB_ROLE_POWER
(
  tb_role_power NUMBER,
  roleid        NUMBER,
  powerid       NUMBER,
  addtime       DATE
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ROLE_RESOURCES...
create table TB_ROLE_RESOURCES
(
  roleid      NUMBER(10) not null,
  resourcesid NUMBER(10) not null
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_ROLE_RESOURCES.roleid
  is '角色id';
comment on column TB_ROLE_RESOURCES.resourcesid
  is '资源id';

prompt Creating TB_USER...
create table TB_USER
(
  id       NUMBER(10) not null,
  username VARCHAR2(20) not null,
  password VARCHAR2(80) not null,
  enable   NUMBER(10) default 1 not null,
  salt     VARCHAR2(20)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_USER.id
  is '用户id';
comment on column TB_USER.username
  is '用户名';
comment on column TB_USER.password
  is '用户密码';
comment on column TB_USER.enable
  is '是否启用 1启用 2禁用';
comment on column TB_USER.salt
  is '盐';

prompt Creating TB_USERACCOUNT...
create table TB_USERACCOUNT
(
  useraccountid     NUMBER not null,
  userinformationid NUMBER,
  accounmoney       NUMBER(10,2) default 0,
  availmoney        NUMBER(10,2) default 0,
  awaitinterest     NUMBER(10,2) default 0,
  awaitmoney        NUMBER(10,2) default 0,
  money             NUMBER(10,2) default 0,
  lineofcredit      NUMBER default 50000,
  certification     NUMBER default 0 not null,
  frontimg          VARCHAR2(100),
  behindimg         VARCHAR2(100),
  accruedincome     NUMBER(10,2) default 0,
  frozencapital     NUMBER(10,2) default 0
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_USERACCOUNT.useraccountid
  is '用户账号Id';
comment on column TB_USERACCOUNT.userinformationid
  is '用户信息Id';
comment on column TB_USERACCOUNT.accounmoney
  is '账户总金额';
comment on column TB_USERACCOUNT.availmoney
  is '可用余额';
comment on column TB_USERACCOUNT.awaitinterest
  is '待收利息';
comment on column TB_USERACCOUNT.awaitmoney
  is '待收本金';
comment on column TB_USERACCOUNT.money
  is '待还金额';
comment on column TB_USERACCOUNT.lineofcredit
  is '信用额度';
comment on column TB_USERACCOUNT.certification
  is '实名认证 0:未认证 1:待审核 2:已认证';
comment on column TB_USERACCOUNT.frontimg
  is '身份证正面';
comment on column TB_USERACCOUNT.behindimg
  is '身份证背面';
comment on column TB_USERACCOUNT.accruedincome
  is '累计收益';
comment on column TB_USERACCOUNT.frozencapital
  is '冻结资金';
alter table TB_USERACCOUNT
  add constraint USERACCOUNTID primary key (USERACCOUNTID)
  using index 
  tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_USERINFORMATION...
create table TB_USERINFORMATION
(
  userinformationid NUMBER not null,
  userid            NUMBER not null,
  name              VARCHAR2(20),
  usersex           VARCHAR2(2),
  userphone         VARCHAR2(20),
  identitycard      VARCHAR2(30),
  bankcardnumbers   VARCHAR2(30),
  email             VARCHAR2(30),
  headportrait      VARCHAR2(100),
  site              VARCHAR2(50),
  education         VARCHAR2(20),
  marriage          VARCHAR2(20),
  basicincome       VARCHAR2(20),
  state             NUMBER default 1,
  paypassword       NUMBER default 888888,
  sbttime           DATE default sysdate,
  birthday          DATE
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_USERINFORMATION.userinformationid
  is '用户信息Id';
comment on column TB_USERINFORMATION.userid
  is '用户Id';
comment on column TB_USERINFORMATION.name
  is '姓名';
comment on column TB_USERINFORMATION.usersex
  is '性别';
comment on column TB_USERINFORMATION.userphone
  is '手机号';
comment on column TB_USERINFORMATION.identitycard
  is '身份证';
comment on column TB_USERINFORMATION.bankcardnumbers
  is '银行卡号';
comment on column TB_USERINFORMATION.email
  is '邮箱';
comment on column TB_USERINFORMATION.headportrait
  is '头像';
comment on column TB_USERINFORMATION.site
  is '地址';
comment on column TB_USERINFORMATION.education
  is '学历';
comment on column TB_USERINFORMATION.marriage
  is '婚姻';
comment on column TB_USERINFORMATION.basicincome
  is '基本收入';
comment on column TB_USERINFORMATION.state
  is ' 好像没什么卵用';
comment on column TB_USERINFORMATION.paypassword
  is '支付密码';
comment on column TB_USERINFORMATION.sbttime
  is '审核提交时间';
comment on column TB_USERINFORMATION.birthday
  is '出生年月日';

prompt Creating TB_USER_ROLE...
create table TB_USER_ROLE
(
  userid NUMBER(10) not null,
  roleid NUMBER(10) not null
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column TB_USER_ROLE.userid
  is '用户id';
comment on column TB_USER_ROLE.roleid
  is '角色id 用户id关联角色id 去角色表里面找';

prompt Creating TB_YUE...
create table TB_YUE
(
  month DATE
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating T_ROLE...
create table T_ROLE
(
  roledesc VARCHAR2(20),
  roleid   NUMBER,
  rolename VARCHAR2(20),
  roleflag VARCHAR2(20)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column T_ROLE.roledesc
  is '角色描述';
comment on column T_ROLE.roleid
  is '角色管理ID';
comment on column T_ROLE.rolename
  is '角色昵称';
comment on column T_ROLE.roleflag
  is '角色状态';

prompt Creating USERS...
create table USERS
(
  userid   NUMBER(6) not null,
  username VARCHAR2(20),
  password VARCHAR2(20),
  gender   NUMBER(1),
  email    VARCHAR2(100)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table USERS
  add primary key (USERID)
  using index 
  tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating USERSA...
create table USERSA
(
  userid   NUMBER(7) not null,
  username VARCHAR2(20),
  password VARCHAR2(20),
  gender   NUMBER(1),
  email    VARCHAR2(100),
  age      NUMBER(4),
  city     VARCHAR2(20)
)
tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table USERSA
  add primary key (USERID)
  using index 
  tablespace TBS_GROUPSEVEN
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Disabling triggers for TB_ACCOUNT...
alter table TB_ACCOUNT disable all triggers;
prompt Disabling triggers for TB_AUDITRECORD...
alter table TB_AUDITRECORD disable all triggers;
prompt Disabling triggers for TB_COMMENT...
alter table TB_COMMENT disable all triggers;
prompt Disabling triggers for TB_COMPANY_MONEY_RECORD...
alter table TB_COMPANY_MONEY_RECORD disable all triggers;
prompt Disabling triggers for TB_INVESTMENT...
alter table TB_INVESTMENT disable all triggers;
prompt Disabling triggers for TB_JINNANG...
alter table TB_JINNANG disable all triggers;
prompt Disabling triggers for TB_LIMIT...
alter table TB_LIMIT disable all triggers;
prompt Disabling triggers for TB_LOANS...
alter table TB_LOANS disable all triggers;
prompt Disabling triggers for TB_LOANSTYPE...
alter table TB_LOANSTYPE disable all triggers;
prompt Disabling triggers for TB_MESSAGE...
alter table TB_MESSAGE disable all triggers;
prompt Disabling triggers for TB_MONEY...
alter table TB_MONEY disable all triggers;
prompt Disabling triggers for TB_MONEYRECORD...
alter table TB_MONEYRECORD disable all triggers;
prompt Disabling triggers for TB_NOTICE...
alter table TB_NOTICE disable all triggers;
prompt Disabling triggers for TB_REFUND...
alter table TB_REFUND disable all triggers;
prompt Disabling triggers for TB_REFUND_PLAN...
alter table TB_REFUND_PLAN disable all triggers;
prompt Disabling triggers for TB_RESOURCES...
alter table TB_RESOURCES disable all triggers;
prompt Disabling triggers for TB_ROLE...
alter table TB_ROLE disable all triggers;
prompt Disabling triggers for TB_ROLE_POWER...
alter table TB_ROLE_POWER disable all triggers;
prompt Disabling triggers for TB_ROLE_RESOURCES...
alter table TB_ROLE_RESOURCES disable all triggers;
prompt Disabling triggers for TB_USER...
alter table TB_USER disable all triggers;
prompt Disabling triggers for TB_USERACCOUNT...
alter table TB_USERACCOUNT disable all triggers;
prompt Disabling triggers for TB_USERINFORMATION...
alter table TB_USERINFORMATION disable all triggers;
prompt Disabling triggers for TB_USER_ROLE...
alter table TB_USER_ROLE disable all triggers;
prompt Disabling triggers for TB_YUE...
alter table TB_YUE disable all triggers;
prompt Disabling triggers for T_ROLE...
alter table T_ROLE disable all triggers;
prompt Disabling triggers for USERS...
alter table USERS disable all triggers;
prompt Disabling triggers for USERSA...
alter table USERSA disable all triggers;
prompt Loading TB_ACCOUNT...
insert into TB_ACCOUNT (account_id, username, password, roleid, account_name, create_date, post)
values (11, 'xingbo', 'admin', '1', '邢博博', to_date('04-12-2018 11:20:34', 'dd-mm-yyyy hh24:mi:ss'), '审核员');
insert into TB_ACCOUNT (account_id, username, password, roleid, account_name, create_date, post)
values (12, 'shenen', 'admin', '1', '申恩', to_date('04-12-2018 11:24:35', 'dd-mm-yyyy hh24:mi:ss'), '财务经理');
insert into TB_ACCOUNT (account_id, username, password, roleid, account_name, create_date, post)
values (13, 'maoyu', 'admin', '1', '毛宇', to_date('04-12-2018 11:25:12', 'dd-mm-yyyy hh24:mi:ss'), '管理员');
insert into TB_ACCOUNT (account_id, username, password, roleid, account_name, create_date, post)
values (14, 'yanhaotian', 'admin', '1', '严浩天', to_date('04-12-2018 11:25:51', 'dd-mm-yyyy hh24:mi:ss'), '管理员');
insert into TB_ACCOUNT (account_id, username, password, roleid, account_name, create_date, post)
values (1, 'admin', 'admin', '1', '孙振', to_date('04-12-2018 11:13:29', 'dd-mm-yyyy hh24:mi:ss'), '管理员');
commit;
prompt 5 records loaded
prompt Loading TB_AUDITRECORD...
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (61, 180, 1, 1, to_date('10-01-2019 22:43:47', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (53, 163, 2, 2, to_date('10-01-2019 20:26:57', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (54, 126, 2, 2, to_date('10-01-2019 20:53:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (56, 140, 3, 3, to_date('10-01-2019 21:51:31', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (60, 128, 2, 1, to_date('10-01-2019 22:05:28', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (62, 180, 2, 1, to_date('10-01-2019 22:48:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (66, 183, 2, 2, to_date('10-01-2019 23:22:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (65, 183, 1, 1, to_date('10-01-2019 23:14:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (67, 184, 1, 1, to_date('10-01-2019 23:37:37', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (63, 182, 1, 1, to_date('10-01-2019 23:03:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (64, 182, 2, 1, to_date('10-01-2019 23:07:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (68, 184, 3, 3, to_date('10-01-2019 23:40:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (69, 188, 1, 1, to_date('11-01-2019 08:51:17', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (70, 186, 1, 1, to_date('11-01-2019 08:51:37', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (71, 187, 1, 1, to_date('11-01-2019 08:51:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (72, 189, 1, 1, to_date('11-01-2019 09:18:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (74, 188, 3, 3, to_date('11-01-2019 09:47:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (59, 163, 3, 3, to_date('10-01-2019 21:54:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (73, 189, 2, 1, to_date('11-01-2019 09:22:26', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (57, 140, 3, 3, to_date('10-01-2019 21:52:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_AUDITRECORD (auditrecordid, loansid, auditstype, auditstate, time)
values (58, 163, 3, 3, to_date('10-01-2019 21:52:24', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 21 records loaded
prompt Loading TB_COMMENT...
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (23, 44, 4, '评论', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (24, 42, 1, '真的很修啊', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (43, 43, 47, '士大夫撒旦', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (11, 41, 6, '测试评论毛宇', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (12, 42, 6, '自己评论自己', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (27, 62, 6, 'asdfsadfasdf', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (22, 44, 4, 'sss', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (26, 43, 1, null, null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (29, 43, 2, 'nnnnn', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (30, 63, 4, 'asdfsdaf', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (31, 41, 4, 'sfasfds', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (14, 43, 6, '赞同', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (15, 43, 4, 'sss', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (16, 43, 2, 'lllll', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (21, 44, 4, 'asdfjaskjfk', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (28, 44, 6, 'dxdsasdf ', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (13, 43, 4, '大傻逼', null);
insert into TB_COMMENT (commentid, jinnangid, userid, content, datetime)
values (25, 43, 1, 'safasfasfsfasdf', null);
commit;
prompt 18 records loaded
prompt Loading TB_COMPANY_MONEY_RECORD...
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (284, 163, 0, 100000, to_date('10-01-2019 20:26:57', 'dd-mm-yyyy hh24:mi:ss'), 10099166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (287, 126, 0, 120000, to_date('10-01-2019 20:53:36', 'dd-mm-yyyy hh24:mi:ss'), 10099166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (300, 140, 0, 50000, to_date('10-01-2019 21:47:38', 'dd-mm-yyyy hh24:mi:ss'), 9449166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (301, 140, 0, 50000, to_date('10-01-2019 21:51:31', 'dd-mm-yyyy hh24:mi:ss'), 9399166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (307, 128, 2, 50000, to_date('10-01-2019 22:04:46', 'dd-mm-yyyy hh24:mi:ss'), 9199166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (308, 128, 0, 1500, to_date('10-01-2019 22:05:28', 'dd-mm-yyyy hh24:mi:ss'), 9200666.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (311, 128, 1, 55625, to_date('10-01-2019 22:12:19', 'dd-mm-yyyy hh24:mi:ss'), 9256291.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (312, 128, 3, 55625, to_date('10-01-2019 22:12:19', 'dd-mm-yyyy hh24:mi:ss'), 9200666.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (273, 163, 2, 50000, to_date('10-01-2019 19:51:45', 'dd-mm-yyyy hh24:mi:ss'), 10046166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (275, 128, 2, 30000, to_date('10-01-2019 19:52:36', 'dd-mm-yyyy hh24:mi:ss'), 10126166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (313, 180, 2, 50000, to_date('10-01-2019 22:48:15', 'dd-mm-yyyy hh24:mi:ss'), 9250666.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (314, 180, 0, 1500, to_date('10-01-2019 22:48:54', 'dd-mm-yyyy hh24:mi:ss'), 9252166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (315, 180, 1, 56250, to_date('10-01-2019 22:50:34', 'dd-mm-yyyy hh24:mi:ss'), 9308416.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (316, 180, 3, 56250, to_date('10-01-2019 22:50:34', 'dd-mm-yyyy hh24:mi:ss'), 9252166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (326, 140, 2, 20000, to_date('10-01-2019 23:59:12', 'dd-mm-yyyy hh24:mi:ss'), 9295224.64, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (278, 159, 2, 100000, to_date('10-01-2019 19:55:42', 'dd-mm-yyyy hh24:mi:ss'), 10346166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (285, 126, 2, 80000, to_date('10-01-2019 20:51:19', 'dd-mm-yyyy hh24:mi:ss'), 10179166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (291, 140, 0, 50000, to_date('10-01-2019 21:22:24', 'dd-mm-yyyy hh24:mi:ss'), 9899166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (292, 140, 0, 50000, to_date('10-01-2019 21:27:28', 'dd-mm-yyyy hh24:mi:ss'), 9849166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (293, 140, 0, 50000, to_date('10-01-2019 21:32:11', 'dd-mm-yyyy hh24:mi:ss'), 9799166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (296, 140, 0, 50000, to_date('10-01-2019 21:36:42', 'dd-mm-yyyy hh24:mi:ss'), 9649166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (323, 183, 0, 50000, to_date('10-01-2019 23:22:01', 'dd-mm-yyyy hh24:mi:ss'), 9303724.54, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (274, 163, 2, 50000, to_date('10-01-2019 19:52:15', 'dd-mm-yyyy hh24:mi:ss'), 10096166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (277, 129, 2, 50000, to_date('10-01-2019 19:55:06', 'dd-mm-yyyy hh24:mi:ss'), 10246166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (317, 182, 2, 20000, to_date('10-01-2019 23:05:56', 'dd-mm-yyyy hh24:mi:ss'), 9272166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (318, 182, 2, 30000, to_date('10-01-2019 23:06:23', 'dd-mm-yyyy hh24:mi:ss'), 9302166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (319, 182, 0, 1500, to_date('10-01-2019 23:07:00', 'dd-mm-yyyy hh24:mi:ss'), 9303666.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (320, 182, 1, 51666.67, to_date('10-01-2019 23:09:03', 'dd-mm-yyyy hh24:mi:ss'), 9355333.34, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (321, 182, 3, 51666.67, to_date('10-01-2019 23:09:03', 'dd-mm-yyyy hh24:mi:ss'), 9303666.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (322, 183, 2, 50000, to_date('10-01-2019 23:15:08', 'dd-mm-yyyy hh24:mi:ss'), 9353673.59, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (289, 140, 0, 50000, to_date('10-01-2019 21:17:29', 'dd-mm-yyyy hh24:mi:ss'), 9999166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (294, 140, 0, 50000, to_date('10-01-2019 21:32:59', 'dd-mm-yyyy hh24:mi:ss'), 9749166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (324, 184, 2, 20000, to_date('10-01-2019 23:38:34', 'dd-mm-yyyy hh24:mi:ss'), 9325074.64, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (325, 184, 0, 50000, to_date('10-01-2019 23:40:24', 'dd-mm-yyyy hh24:mi:ss'), 9275074.64, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (333, 188, 0, 20000, to_date('11-01-2019 09:47:36', 'dd-mm-yyyy hh24:mi:ss'), 9388393.72, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (288, 140, 0, 50000, to_date('10-01-2019 21:10:52', 'dd-mm-yyyy hh24:mi:ss'), 10049166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (295, 140, 0, 50000, to_date('10-01-2019 21:33:53', 'dd-mm-yyyy hh24:mi:ss'), 9699166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (298, 140, 0, 50000, to_date('10-01-2019 21:39:56', 'dd-mm-yyyy hh24:mi:ss'), 9549166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (299, 140, 0, 50000, to_date('10-01-2019 21:45:03', 'dd-mm-yyyy hh24:mi:ss'), 9499166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (302, 140, 0, 50000, to_date('10-01-2019 21:52:05', 'dd-mm-yyyy hh24:mi:ss'), 9349166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (303, 163, 0, 100000, to_date('10-01-2019 21:52:24', 'dd-mm-yyyy hh24:mi:ss'), 9249166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (304, 163, 0, 100000, to_date('10-01-2019 21:54:43', 'dd-mm-yyyy hh24:mi:ss'), 9149166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (305, 129, 1, 52083.33, to_date('10-01-2019 21:57:42', 'dd-mm-yyyy hh24:mi:ss'), 9201250, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (306, 129, 3, 52083.33, to_date('10-01-2019 21:57:42', 'dd-mm-yyyy hh24:mi:ss'), 9149166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (309, 128, 1, 55625, to_date('10-01-2019 22:07:01', 'dd-mm-yyyy hh24:mi:ss'), 9256291.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (310, 128, 3, 55625, to_date('10-01-2019 22:07:01', 'dd-mm-yyyy hh24:mi:ss'), 9200666.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (327, 189, 2, 50000, to_date('11-01-2019 09:20:02', 'dd-mm-yyyy hh24:mi:ss'), 9345293.72, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (328, 189, 2, 50000, to_date('11-01-2019 09:21:05', 'dd-mm-yyyy hh24:mi:ss'), 9395293.72, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (329, 189, 0, 3000, to_date('11-01-2019 09:22:26', 'dd-mm-yyyy hh24:mi:ss'), 9398293.72, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (330, 189, 1, 105833.33, to_date('11-01-2019 09:32:59', 'dd-mm-yyyy hh24:mi:ss'), 9504127.05, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (331, 189, 3, 105833.33, to_date('11-01-2019 09:32:59', 'dd-mm-yyyy hh24:mi:ss'), 9398293.72, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (332, 188, 2, 10000, to_date('11-01-2019 09:38:00', 'dd-mm-yyyy hh24:mi:ss'), 9408393.72, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (279, 159, 2, 30000, to_date('10-01-2019 19:56:31', 'dd-mm-yyyy hh24:mi:ss'), 10376166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (280, 128, 2, 20000, to_date('10-01-2019 19:56:54', 'dd-mm-yyyy hh24:mi:ss'), 10396166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (282, 128, 0, 1500, to_date('10-01-2019 20:06:37', 'dd-mm-yyyy hh24:mi:ss'), 10399166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (283, 159, 0, 200000, to_date('10-01-2019 20:09:41', 'dd-mm-yyyy hh24:mi:ss'), 10199166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (276, 159, 2, 70000, to_date('10-01-2019 19:54:36', 'dd-mm-yyyy hh24:mi:ss'), 10196166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (286, 126, 2, 40000, to_date('10-01-2019 20:51:40', 'dd-mm-yyyy hh24:mi:ss'), 10219166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (290, 140, 0, 50000, to_date('10-01-2019 21:20:42', 'dd-mm-yyyy hh24:mi:ss'), 9949166.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (281, 129, 0, 1500, to_date('10-01-2019 19:59:29', 'dd-mm-yyyy hh24:mi:ss'), 10397666.67, null);
insert into TB_COMPANY_MONEY_RECORD (recordid, loansid, moneychangetype, changemoney, changetime, availmoney, earnmoney)
values (297, 140, 0, 50000, to_date('10-01-2019 21:38:43', 'dd-mm-yyyy hh24:mi:ss'), 9599166.67, null);
commit;
prompt 61 records loaded
prompt Loading TB_INVESTMENT...
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (255, 2, 163, 50000, to_date('10-01-2018 19:51:45', 'dd-mm-yyyy hh24:mi:ss'), 10, 4166);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (266, 87, 180, 50000, to_date('10-01-2019 22:48:15', 'dd-mm-yyyy hh24:mi:ss'), 15, 6250);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (264, 47, 126, 40000, to_date('10-08-2018 20:51:40', 'dd-mm-yyyy hh24:mi:ss'), 3, 800);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (271, 70, 140, 20000, to_date('10-01-2019 23:59:12', 'dd-mm-yyyy hh24:mi:ss'), 10, 1166);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (260, 4, 159, 100000, to_date('10-02-2018 19:55:42', 'dd-mm-yyyy hh24:mi:ss'), 8, 6666);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (256, 6, 163, 50000, to_date('10-01-2018 19:52:15', 'dd-mm-yyyy hh24:mi:ss'), 10, 4166);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (259, 2, 129, 50000, to_date('10-01-2018 19:55:06', 'dd-mm-yyyy hh24:mi:ss'), 10, 2083);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (263, 3, 126, 80000, to_date('10-03-2018 20:51:19', 'dd-mm-yyyy hh24:mi:ss'), 3, 1600);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (269, 87, 183, 50000, to_date('10-01-2019 23:15:08', 'dd-mm-yyyy hh24:mi:ss'), 12, 2500);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (267, 87, 182, 20000, to_date('10-01-2019 23:05:56', 'dd-mm-yyyy hh24:mi:ss'), 8, 666);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (268, 68, 182, 30000, to_date('10-01-2019 23:06:23', 'dd-mm-yyyy hh24:mi:ss'), 8, 1000);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (270, 3, 184, 20000, to_date('10-01-2019 23:38:34', 'dd-mm-yyyy hh24:mi:ss'), 12, 2400);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (272, 69, 189, 50000, to_date('11-01-2019 09:20:02', 'dd-mm-yyyy hh24:mi:ss'), 10, 2916);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (273, 68, 189, 50000, to_date('11-01-2019 09:21:05', 'dd-mm-yyyy hh24:mi:ss'), 10, 2916);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (274, 87, 188, 10000, to_date('11-01-2019 09:38:00', 'dd-mm-yyyy hh24:mi:ss'), 9, 300);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (261, 3, 159, 30000, to_date('10-03-2018 19:56:31', 'dd-mm-yyyy hh24:mi:ss'), 8, 2000);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (258, 6, 159, 70000, to_date('10-10-2018 19:54:36', 'dd-mm-yyyy hh24:mi:ss'), 8, 4666);
insert into TB_INVESTMENT (investmentid, userid, loansid, investmentmoney, investmentdate, interestrate, earnings)
values (264, 47, 126, 40000, to_date('10-10-2018 20:51:40', 'dd-mm-yyyy hh24:mi:ss'), 3, 800);
commit;
prompt 18 records loaded
prompt Loading TB_JINNANG...
insert into TB_JINNANG (issuer_id, id, headline, content, praise)
values (4, 63, '测试撒旦发射点', '撒旦发生分厘卡士大夫立刻', 0);
insert into TB_JINNANG (issuer_id, id, headline, content, praise)
values (3, 43, '邢博博', '啊大苏打阀手动阀卡斯大家法律界爱上邓丽君flak是', 35);
insert into TB_JINNANG (issuer_id, id, headline, content, praise)
values (87, 81, 'insdfja', 'sdfkjkadjskf', 0);
insert into TB_JINNANG (issuer_id, id, headline, content, praise)
values (4, 41, '申思测试锦囊', '啊啊啊敖德萨发送大附件阿斯顿回复黑暗圣经肯定会夫卡是发生的', 369);
commit;
prompt 4 records loaded
prompt Loading TB_LIMIT...
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (14, '资金统计', 5, null, null, 'toBackindex', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (15, '公告管理', 2, null, null, 'tonoticeGuanLi', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (16, '锦囊管理', 2, null, null, 'tojinnangGuanLi', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (1, '首页', 0, 'open', null, 'toBackindex', '首页节点');
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (2, '网站管理', 0, 'closed', null, null, null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (3, '权限管理', 0, 'closed', null, null, null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (4, '审核管理', 0, 'closed', null, null, null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (5, '数据统计', 0, 'closed', null, null, null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (13, '身份认证审核', 4, null, null, 'toIdentityAudit', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (7, '账户管理', 3, null, null, 'accountManagement', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (8, '角色管理', 3, null, null, 'permission', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (10, '满标审核', 4, null, null, 'toIoansAccomplishAudit', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (11, '流标审核', 4, null, null, 'toLoseABidAudit', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (12, '招标审核', 4, null, null, 'toLoanAudit', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (13, '历史审核记录', 4, null, null, 'toLoansRecord', null);
insert into TB_LIMIT (powerid, powername, parentid, state, incocls, url, remark)
values (15, '还款情况', 4, null, null, 'toOverdueAudit', null);
commit;
prompt 16 records loaded
prompt Loading TB_LOANS...
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (185, 87, '蔡旭东', 50000, '到期还本还息', 12, '5', to_date('10-05-2019 23:57:29', 'dd-mm-yyyy hh24:mi:ss'), null, 'ceshi', 3, null, '个人日常消费', 0, 1, 3, '15638570846', to_date('10-06-2019 23:57:29', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (180, 70, '李白', 50000, '到期还本还息', 15, '10', to_date('10-01-2019 22:43:05', 'dd-mm-yyyy hh24:mi:ss'), null, '123', 1, to_date('10-01-2019 22:48:54', 'dd-mm-yyyy hh24:mi:ss'), '个人日常消费', 50000, 11, 3, '15638915172', to_date('10-01-2019 22:48:54', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (163, 3, '邢博', 100000, '到期还本还息', 10, '10', to_date('06-01-2019 15:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, '测试', 2, to_date('10-01-2019 15:33:50', 'dd-mm-yyyy hh24:mi:ss'), '个人日常消费', 9000, 7, 3, '18300695622', to_date('10-01-2019 15:33:50', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (182, 70, '李白', 50000, '到期还本还息', 8, '5', to_date('10-01-2019 23:01:50', 'dd-mm-yyyy hh24:mi:ss'), null, '测试', 3, to_date('10-01-2019 23:07:00', 'dd-mm-yyyy hh24:mi:ss'), '个人日常消费', 50000, 11, 3, '15638915172', to_date('10-01-2019 23:07:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (129, 6, '毛宇', 50000, '到期还本还息', 10, '5', to_date('01-02-2018 10:50:13', 'dd-mm-yyyy hh24:mi:ss'), null, null, 3, to_date('10-01-2019 19:59:29', 'dd-mm-yyyy hh24:mi:ss'), '个人日常消费', 50000, 11, 3, '18300695622', to_date('10-01-2019 19:59:29', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (128, 2, '孙振', 50000, '到期还本还息', 15, '9', to_date('01-03-2018 10:49:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, to_date('10-01-2019 22:05:28', 'dd-mm-yyyy hh24:mi:ss'), '个人日常消费', 50000, 11, 3, '15836245606', to_date('10-01-2019 22:05:28', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (183, 70, '李白', 50000, '到期还本还息', 12, '5', to_date('10-01-2019 23:13:49', 'dd-mm-yyyy hh24:mi:ss'), null, 'ceshi', 3, null, '个人日常消费', 50000, 6, 3, '15638915172', to_date('10-06-2019 23:13:49', 'dd-mm-yyyy hh24:mi:ss'), 'cehsi');
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (184, 69, '王炸', 50000, '到期还本还息', 12, '12', to_date('10-01-2019 23:36:56', 'dd-mm-yyyy hh24:mi:ss'), null, 'ceshi', 3, null, '个人日常消费', 20000, 7, 3, '15136074496', to_date('10-01-2020 23:36:56', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (188, 70, '李白', 20000, '到期还本还息', 9, '4', to_date('05-01-2019 08:50:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'ceshi', 3, null, '个人日常消费', 10000, 7, 3, '15638570846', to_date('11-05-2019 08:50:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (159, 67, '张三', 200000, '到期还本还息', 8, '10', to_date('09-01-2019 21:18:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, to_date('09-01-2019 21:46:50', 'dd-mm-yyyy hh24:mi:ss'), '教育', 200000, 6, 3, '18503820901', to_date('10-01-2019 21:46:50', 'dd-mm-yyyy hh24:mi:ss'), '测试');
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (186, 69, '王炸', 100000, '到期还本还息', 8, '7', to_date('11-01-2019 08:41:55', 'dd-mm-yyyy hh24:mi:ss'), null, 'ceshi', 2, null, '个人日常消费', 0, 2, 3, '156638570846', to_date('11-08-2019 08:41:55', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (187, 68, '范文鹏', 50000, '到期还本还息', 12, '10', to_date('11-01-2019 08:43:57', 'dd-mm-yyyy hh24:mi:ss'), null, 'ceshi', 1, null, '个人日常消费', 0, 2, 3, '15638570846', to_date('11-11-2019 08:43:57', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (126, 5, '严浩天', 120000, '到期还本还息', 3, '8', to_date('01-07-2018 10:32:35', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, to_date('09-01-2019 22:23:10', 'dd-mm-yyyy hh24:mi:ss'), '个人日常消费', 120000, 6, 3, '158964854455', to_date('09-01-2019 22:23:10', 'dd-mm-yyyy hh24:mi:ss'), 'ceshi');
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (189, 88, '严浩天', 100000, '到期还本还息', 10, '7', to_date('11-01-2019 09:17:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'ceshi', 1, to_date('11-01-2019 09:22:26', 'dd-mm-yyyy hh24:mi:ss'), '装修', 100000, 11, 3, '15138956487', to_date('11-01-2019 09:22:26', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (140, 4, '申恩', 50000, '到期还本还息', 10, '7', to_date('11-12-2018 15:00:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 2, to_date('11-12-2018 15:42:56', 'dd-mm-yyyy hh24:mi:ss'), '个人日常消费', 20000, 3, 5, '15896485135', to_date('08-01-2019 13:50:33', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_LOANS (loansid, userid, username, loansmoney, refundway, loansinterestrate, refunddeadline, begintime, howmanydays, describe, loanstype, time, loansused, investmentamount, loansstate, loancase, userphone, tdate, reason)
values (155, 6, '毛宇', 100000, '到期还本还息', 10, '10', to_date('01-02-2018 10:50:13', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, to_date('10-01-2019 15:53:07', 'dd-mm-yyyy hh24:mi:ss'), '教育', 100000, 11, 3, '18300695622', to_date('11-01-2019 15:53:07', 'dd-mm-yyyy hh24:mi:ss'), null);
commit;
prompt 16 records loaded
prompt Loading TB_LOANSTYPE...
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 180, 1, 200000, null, 'fdec46b4-eaf7-4b22-b7cc-3609fa310418.jpg', null, null, '05a9154f-faf0-45ad-87f9-09b11b09a64f.jpg', '房屋抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 185, 3, null, null, null, null, null, null, '信用贷款');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 163, 2, 200000, null, null, '75fe8380-476e-4e4f-898b-95c26eaf4df8.jpg', null, '679de2b4-9ff6-4ffe-8ece-dbf758878602.jpg', '车辆抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 155, 2, 500000, null, null, 'b3ccd7a9-f7a1-4a46-bfd3-a91275ecdf25.jpg', null, 'deb1dd72-c3db-4e16-bdae-16365ae72c14.jpg', '车辆抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 128, 1, 1500000, null, 'e7594ca4-48d5-4a5a-9a5d-249d4402d804.jpg', null, null, '9dbd8200-bded-4020-b680-23945152945c.jpg', '房屋抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 182, 3, null, null, null, null, null, null, '信用贷款');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 183, 3, null, null, null, null, null, null, '信用贷款');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 184, 3, null, null, null, null, null, null, '信用贷款');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 188, 3, null, null, null, null, null, null, '信用贷款');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 129, 3, 1200000, null, null, null, null, null, '信用抵押贷款');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 139, 1, 2000000000, null, '477398b0-4740-4d0e-a74a-324e6b203b6c.jpg', null, null, '0b3bc1e9-13ed-4e13-974d-e1a9478389ec.jpg', '房屋抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 124, 1, 200000, null, '4a10cb11-ccf3-4704-8fda-1ebb5ec13343.jpg', null, null, '282a1a04-ac9c-4421-bbaa-5f0db714a63b.jpg', '房屋抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 126, 1, 1200000, null, 'b0906619-15af-4dd4-9774-291ce238518e.jpg', null, null, 'ab8aa0bc-27b4-4be8-a680-b1e82aa96bd3.jpg', '房屋抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 159, 1, 500000, null, 'aca6af14-a63f-4c83-9abb-f1d7af2beb0d.jpg', null, null, 'ff254925-63fa-4c77-9185-97ab3e86c649.jpg', '房屋抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 160, 2, 200000, null, null, '88b2afa0-7f46-44d8-9c69-9639d35b078d.jpg', null, '51990ad2-525d-4ee2-bc47-4375433528ee.jpg', '车辆抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 161, 2, 200000, null, null, '66dc614d-fc52-4bd4-9b5e-fe08abeba4ee.jpg', null, '86f97a29-fc4d-4551-942c-a571f4557163.jpg', '车辆抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 162, 2, 200000, null, null, 'bafd31f0-145c-40e7-be07-7feafbaf114f.jpg', null, '61dc1454-cdc5-469e-abea-cbb6dab1a800.jpg', '车辆抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 186, 2, 200000, null, null, 'a1c245fc-5e2d-4572-bef3-24a6d89cb509.jpg', null, '9bd516e6-8b7b-40d9-a319-66a2ecca658c.jpg', '车辆抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 187, 1, 500000, null, '301d0100-3b7d-45ec-bc76-93a712a0156e.jpg', null, null, '73c8c416-1424-4a17-8111-5864e5858a67.jpg', '房屋抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 189, 1, 1000000, null, 'cd995f25-997b-425b-9187-f25b594749af.jpg', null, null, 'fc40eb1d-524d-45c6-9d83-3503f1268136.jpg', '房屋抵押贷');
insert into TB_LOANSTYPE (loanstypeid, loansid, loanstype, globalvalue, housenumber, houseproperty, carinformation, carvalue, appraisalreport, loanstypename)
values (null, 140, 2, 150000, null, null, '86625a78-996f-4f0d-9414-59aecdef883b.jpg', null, 'cf66c1bd-8f7b-4dbe-a7a2-c05a0a08e06e.jpg', '车辆抵押贷');
commit;
prompt 21 records loaded
prompt Loading TB_MESSAGE...
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (458, null, '尊敬的客户，您好，您的编号为255的50000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:26:57', 'dd-mm-yyyy hh24:mi:ss'), 2, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (459, null, '尊敬的客户，您好，您的编号为256的50000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:26:57', 'dd-mm-yyyy hh24:mi:ss'), 6, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (460, null, '尊敬的客户，您好,您的编号为163的100000元贷款审核没通过，驳回原因为:ceshi ，如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 20:26:57', 'dd-mm-yyyy hh24:mi:ss'), 3, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (463, null, '尊敬的客户，您好，您的编号为263的80000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 20:53:36', 'dd-mm-yyyy hh24:mi:ss'), 3, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (464, null, '尊敬的客户，您好，您的编号为264的40000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:53:36', 'dd-mm-yyyy hh24:mi:ss'), 47, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (438, null, '尊敬的客户，您好,您的编号为255的50000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 19:51:45', 'dd-mm-yyyy hh24:mi:ss'), 2, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (440, null, '尊敬的客户，您好,您的编号为257的30000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 19:52:36', 'dd-mm-yyyy hh24:mi:ss'), 6, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (465, null, '尊敬的客户，您好,您的编号为126的120000元贷款审核没通过，驳回原因为:ceshi，如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:53:36', 'dd-mm-yyyy hh24:mi:ss'), 5, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (473, null, '尊敬的客户，您好，您的编号为2的2元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:25:48', 'dd-mm-yyyy hh24:mi:ss'), 5, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (482, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:47:38', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (483, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:51:31', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (493, null, '尊敬的客户，您好,您的编号为265的50000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 22:04:46', 'dd-mm-yyyy hh24:mi:ss'), 3, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (494, null, '尊敬的客户，您好,您的编号为128的50000元贷款已扣除手续费后发放到您的账户中，请查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 22:05:28', 'dd-mm-yyyy hh24:mi:ss'), 2, '贷款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (495, null, '尊敬的客户，您好，您的编号为265的50000元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 22:05:28', 'dd-mm-yyyy hh24:mi:ss'), 3, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (498, null, '尊敬的客户，您好,您的编号为128的50000元贷款已自动扣款成功。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 22:12:19', 'dd-mm-yyyy hh24:mi:ss'), 2, '还款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (500, null, '招标审核已经通过,正在招标中', 2, to_date('10-01-2019 22:43:47', 'dd-mm-yyyy hh24:mi:ss'), 70, '招审', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (501, null, '尊敬的客户，您好，欢迎您使用中兴财富金融平台！您的支付密码初始为：888888，请您及时修改密码，谨防上当受骗！', 2, to_date('10-01-2019 22:45:39', 'dd-mm-yyyy hh24:mi:ss'), 87, '消息', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (502, null, '尊敬的客户，您好，您的实名认证审核已通过！请准守平台规则，合理消费，谨防上当受骗！', 2, to_date('10-01-2019 22:47:05', 'dd-mm-yyyy hh24:mi:ss'), 87, '审核', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (503, null, '尊敬的客户，您好,您的编号为266的50000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 22:48:15', 'dd-mm-yyyy hh24:mi:ss'), 87, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (504, null, '尊敬的客户，您好,您的编号为180的50000元贷款已扣除手续费后发放到您的账户中，请查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 22:48:54', 'dd-mm-yyyy hh24:mi:ss'), 70, '贷款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (505, null, '尊敬的客户，您好，您的编号为266的50000元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 22:48:54', 'dd-mm-yyyy hh24:mi:ss'), 87, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (506, null, '尊敬的客户，您好,您的编号为180的50000元贷款已自动扣款成功。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 22:50:34', 'dd-mm-yyyy hh24:mi:ss'), 70, '还款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (507, null, '尊敬的客户，您好，您的编号为266的50000元投资款已回款成功，请注意查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 22:50:34', 'dd-mm-yyyy hh24:mi:ss'), 87, '回款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (525, null, '尊敬的客户，您好,您的编号为271的20000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:59:12', 'dd-mm-yyyy hh24:mi:ss'), 70, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (443, null, '尊敬的客户，您好,您的编号为260的100000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 19:55:42', 'dd-mm-yyyy hh24:mi:ss'), 4, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (455, null, '尊敬的客户，您好，您的实名认证审核已通过！请准守平台规则，合理消费，谨防上当受骗！', 2, to_date('10-01-2019 20:20:17', 'dd-mm-yyyy hh24:mi:ss'), 68, '审核', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (456, null, '尊敬的客户，您好，您的实名认证审核已通过！请准守平台规则，合理消费，谨防上当受骗！', 1, to_date('10-01-2019 20:20:23', 'dd-mm-yyyy hh24:mi:ss'), 5, '审核', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (457, null, '尊敬的客户，您好，您的实名认证审核已通过！请准守平台规则，合理消费，谨防上当受骗！', 1, to_date('10-01-2019 20:20:30', 'dd-mm-yyyy hh24:mi:ss'), 47, '审核', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (461, null, '尊敬的客户，您好,您的编号为263的80000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 20:51:19', 'dd-mm-yyyy hh24:mi:ss'), 3, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (472, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:22:24', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (474, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:27:28', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (475, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:32:11', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (478, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:36:42', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (519, null, '尊敬的客户，您好，您的编号为269的50000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:22:01', 'dd-mm-yyyy hh24:mi:ss'), 87, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (520, null, '尊敬的客户，您好,您的编号为183的50000元贷款审核没通过，驳回原因为:cehsi，如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:22:01', 'dd-mm-yyyy hh24:mi:ss'), 70, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (439, null, '尊敬的客户，您好,您的编号为256的50000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 19:52:15', 'dd-mm-yyyy hh24:mi:ss'), 6, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (442, null, '尊敬的客户，您好,您的编号为259的50000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 19:55:06', 'dd-mm-yyyy hh24:mi:ss'), 2, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (476, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:32:59', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (508, null, '招标审核已经通过,正在招标中', 2, to_date('10-01-2019 23:03:24', 'dd-mm-yyyy hh24:mi:ss'), 70, '招审', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (509, null, '尊敬的客户，您好,您的编号为267的20000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:05:56', 'dd-mm-yyyy hh24:mi:ss'), 87, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (510, null, '尊敬的客户，您好,您的编号为268的30000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:06:23', 'dd-mm-yyyy hh24:mi:ss'), 68, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (511, null, '尊敬的客户，您好,您的编号为182的50000元贷款已扣除手续费后发放到您的账户中，请查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:07:00', 'dd-mm-yyyy hh24:mi:ss'), 70, '贷款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (512, null, '尊敬的客户，您好，您的编号为267的20000元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:07:00', 'dd-mm-yyyy hh24:mi:ss'), 87, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (513, null, '尊敬的客户，您好，您的编号为268的30000元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:07:00', 'dd-mm-yyyy hh24:mi:ss'), 68, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (470, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:17:29', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (514, null, '尊敬的客户，您好,您的编号为182的50000元贷款已自动扣款成功。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:09:03', 'dd-mm-yyyy hh24:mi:ss'), 70, '还款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (515, null, '尊敬的客户，您好，您的编号为267的20000元投资款已回款成功，请注意查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:09:03', 'dd-mm-yyyy hh24:mi:ss'), 87, '回款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (516, null, '尊敬的客户，您好，您的编号为268的30000元投资款已回款成功，请注意查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:09:03', 'dd-mm-yyyy hh24:mi:ss'), 68, '回款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (517, null, '招标审核已经通过,正在招标中', 2, to_date('10-01-2019 23:14:15', 'dd-mm-yyyy hh24:mi:ss'), 70, '招审', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (518, null, '尊敬的客户，您好,您的编号为269的50000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:15:08', 'dd-mm-yyyy hh24:mi:ss'), 87, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (521, null, '招标审核已经通过,正在招标中', 2, to_date('10-01-2019 23:37:37', 'dd-mm-yyyy hh24:mi:ss'), 69, '招审', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (522, null, '尊敬的客户，您好,您的编号为270的20000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:38:34', 'dd-mm-yyyy hh24:mi:ss'), 3, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (523, null, '尊敬的客户，您好，您的编号为270的20000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 23:40:24', 'dd-mm-yyyy hh24:mi:ss'), 3, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (524, null, '尊敬的客户，您好,您的编号为184的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 23:40:24', 'dd-mm-yyyy hh24:mi:ss'), 69, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (527, null, '招标审核已经通过,正在招标中', 0, to_date('11-01-2019 08:51:17', 'dd-mm-yyyy hh24:mi:ss'), 70, '招审', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (528, null, '招标审核已经通过,正在招标中', 0, to_date('11-01-2019 08:51:37', 'dd-mm-yyyy hh24:mi:ss'), 69, '招审', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (529, null, '招标审核已经通过,正在招标中', 0, to_date('11-01-2019 08:51:46', 'dd-mm-yyyy hh24:mi:ss'), 68, '招审', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (530, null, '尊敬的客户，您好，欢迎您使用中兴财富金融平台！您的支付密码初始为：888888，请您及时修改密码，谨防上当受骗！', 2, to_date('11-01-2019 09:03:12', 'dd-mm-yyyy hh24:mi:ss'), 88, '消息', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (531, null, '尊敬的客户，您好，您的实名认证审核已通过！请准守平台规则，合理消费，谨防上当受骗！', 2, to_date('11-01-2019 09:13:31', 'dd-mm-yyyy hh24:mi:ss'), 88, '审核', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (532, null, '招标审核已经通过,正在招标中', 2, to_date('11-01-2019 09:18:36', 'dd-mm-yyyy hh24:mi:ss'), 88, '招审', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (542, null, '尊敬的客户，您好,您的编号为188的20000元贷款未满标，导致贷款流标。如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:46:28', 'dd-mm-yyyy hh24:mi:ss'), 70, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (543, null, '尊敬的客户，您好，您的编号为274的10000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:47:36', 'dd-mm-yyyy hh24:mi:ss'), 87, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (544, null, '尊敬的客户，您好,您的编号为188的20000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:47:36', 'dd-mm-yyyy hh24:mi:ss'), 70, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (466, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标，导致贷款流标。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:05:40', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (467, null, '尊敬的客户，您好,您的编号为163的100000元贷款未满标，导致贷款流标。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 21:10:08', 'dd-mm-yyyy hh24:mi:ss'), 3, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (468, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标，导致贷款流标。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:10:08', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (469, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:10:52', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (477, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:33:53', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (480, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:39:56', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (481, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:45:03', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (484, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:52:05', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (485, null, '尊敬的客户，您好，您的编号为255的50000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:52:24', 'dd-mm-yyyy hh24:mi:ss'), 2, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (486, null, '尊敬的客户，您好，您的编号为256的50000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:52:24', 'dd-mm-yyyy hh24:mi:ss'), 6, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (487, null, '尊敬的客户，您好,您的编号为163的100000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 21:52:24', 'dd-mm-yyyy hh24:mi:ss'), 3, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (488, null, '尊敬的客户，您好，您的编号为255的50000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:54:43', 'dd-mm-yyyy hh24:mi:ss'), 2, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (489, null, '尊敬的客户，您好，您的编号为256的50000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:54:43', 'dd-mm-yyyy hh24:mi:ss'), 6, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (444, null, '尊敬的客户，您好,您的编号为261的30000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 19:56:31', 'dd-mm-yyyy hh24:mi:ss'), 3, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (445, null, '尊敬的客户，您好,您的编号为262的20000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 19:56:54', 'dd-mm-yyyy hh24:mi:ss'), 3, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (490, null, '尊敬的客户，您好,您的编号为163的100000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 21:54:43', 'dd-mm-yyyy hh24:mi:ss'), 3, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (491, null, '尊敬的客户，您好,您的编号为129的50000元贷款已自动扣款成功。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:57:42', 'dd-mm-yyyy hh24:mi:ss'), 6, '还款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (492, null, '尊敬的客户，您好，您的编号为259的50000元投资款已回款成功，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:57:42', 'dd-mm-yyyy hh24:mi:ss'), 2, '回款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (496, null, '尊敬的客户，您好,您的编号为128的50000元贷款已自动扣款成功。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 22:07:01', 'dd-mm-yyyy hh24:mi:ss'), 2, '还款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (497, null, '尊敬的客户，您好，您的编号为265的50000元投资款已回款成功，请注意查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 22:07:01', 'dd-mm-yyyy hh24:mi:ss'), 3, '回款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (499, null, '尊敬的客户，您好，您的实名认证审核已通过！请准守平台规则，合理消费，谨防上当受骗！', 2, to_date('10-01-2019 22:29:55', 'dd-mm-yyyy hh24:mi:ss'), 70, '审核', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (526, null, '尊敬的客户，您好，您的实名认证审核已通过！请准守平台规则，合理消费，谨防上当受骗！', 2, to_date('11-01-2019 08:31:15', 'dd-mm-yyyy hh24:mi:ss'), 69, '审核', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (533, null, '尊敬的客户，您好,您的编号为272的50000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:20:02', 'dd-mm-yyyy hh24:mi:ss'), 69, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (534, null, '尊敬的客户，您好,您的编号为273的50000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:21:05', 'dd-mm-yyyy hh24:mi:ss'), 68, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (535, null, '尊敬的客户，您好,您的编号为189的100000元贷款已扣除手续费后发放到您的账户中，请查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('11-01-2019 09:22:26', 'dd-mm-yyyy hh24:mi:ss'), 88, '贷款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (536, null, '尊敬的客户，您好，您的编号为272的50000元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:22:26', 'dd-mm-yyyy hh24:mi:ss'), 69, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (537, null, '尊敬的客户，您好，您的编号为273的50000元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:22:26', 'dd-mm-yyyy hh24:mi:ss'), 68, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (538, null, '尊敬的客户，您好,您的编号为189的100000元贷款已自动扣款成功。如有疑问，请联系我们，我们一定为您解答', 2, to_date('11-01-2019 09:32:59', 'dd-mm-yyyy hh24:mi:ss'), 88, '还款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (539, null, '尊敬的客户，您好，您的编号为272的50000元投资款已回款成功，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:32:59', 'dd-mm-yyyy hh24:mi:ss'), 69, '回款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (540, null, '尊敬的客户，您好，您的编号为273的50000元投资款已回款成功，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:32:59', 'dd-mm-yyyy hh24:mi:ss'), 68, '回款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (541, null, '尊敬的客户，您好,您的编号为274的10000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 1, to_date('11-01-2019 09:38:00', 'dd-mm-yyyy hh24:mi:ss'), 87, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (441, null, '尊敬的客户，您好,您的编号为258的70000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 19:54:36', 'dd-mm-yyyy hh24:mi:ss'), 6, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (446, null, '尊敬的客户，您好,您的编号为129的50000元贷款已扣除手续费后发放到您的账户中，请查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 19:59:29', 'dd-mm-yyyy hh24:mi:ss'), 6, '贷款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (447, null, '尊敬的客户，您好，您的编号为259的50000元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 19:59:29', 'dd-mm-yyyy hh24:mi:ss'), 2, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (448, null, '尊敬的客户，您好,您的编号为128的50000元贷款已扣除手续费后发放到您的账户中，请查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:06:37', 'dd-mm-yyyy hh24:mi:ss'), 2, '贷款', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (449, null, '尊敬的客户，您好，您的编号为257的30000元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:06:37', 'dd-mm-yyyy hh24:mi:ss'), 6, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (450, null, '尊敬的客户，您好，您的编号为262的20000元投资,已中标,请耐心等待收益。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 20:06:37', 'dd-mm-yyyy hh24:mi:ss'), 3, '投资', null, null);
commit;
prompt 100 records committed...
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (451, null, '尊敬的客户，您好，您的编号为260的100000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:09:41', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (452, null, '尊敬的客户，您好，您的编号为261的30000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 2, to_date('10-01-2019 20:09:41', 'dd-mm-yyyy hh24:mi:ss'), 3, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (453, null, '尊敬的客户，您好，您的编号为258的70000元投资流标，金额已返还，请注意查收。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:09:41', 'dd-mm-yyyy hh24:mi:ss'), 6, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (454, null, '尊敬的客户，您好,您的编号为159的200000元贷款审核没通过，驳回原因为:测试，如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:09:41', 'dd-mm-yyyy hh24:mi:ss'), 67, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (462, null, '尊敬的客户，您好,您的编号为264的40000元投资成功,投标金额划入冻结资金。如此贷款项目成功会提醒您,请耐心等待。如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 20:51:40', 'dd-mm-yyyy hh24:mi:ss'), 47, '投资', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (471, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:20:42', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
insert into TB_MESSAGE (messageid, messagetitle, messagecontent, messagestate, sendtime, userid, messagetype, state1, state2)
values (479, null, '尊敬的客户，您好,您的编号为140的50000元贷款未满标,贷款已失败!如有疑问，请联系我们，我们一定为您解答', 1, to_date('10-01-2019 21:38:43', 'dd-mm-yyyy hh24:mi:ss'), 4, '流标', null, null);
commit;
prompt 107 records loaded
prompt Loading TB_MONEY...
insert into TB_MONEY (money)
values (9388393.72);
commit;
prompt 1 records loaded
prompt Loading TB_MONEYRECORD...
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (394, to_date('10-01-2019 22:04:46', 'dd-mm-yyyy hh24:mi:ss'), '投资', 50000, '银行卡', 3, 30000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (398, to_date('10-01-2019 22:12:19', 'dd-mm-yyyy hh24:mi:ss'), '还款', 55625, '银行卡', 2, null);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (386, to_date('10-01-2019 20:53:36', 'dd-mm-yyyy hh24:mi:ss'), '流标', 80000, '银行卡', 3, 80000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (387, to_date('10-01-2019 20:53:36', 'dd-mm-yyyy hh24:mi:ss'), '流标', 40000, '银行卡', 47, 100000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (401, to_date('10-01-2019 22:48:15', 'dd-mm-yyyy hh24:mi:ss'), '投资', 50000, '银行卡', 87, 50000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (399, to_date('10-01-2019 22:47:39', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 50000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (400, to_date('10-01-2019 22:47:50', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 100000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (402, to_date('10-01-2019 22:48:54', 'dd-mm-yyyy hh24:mi:ss'), '贷款', 48500, '银行卡', 70, 148500);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (403, to_date('10-01-2019 22:50:34', 'dd-mm-yyyy hh24:mi:ss'), '还款', 56250, '银行卡', 70, 92250);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (404, to_date('10-01-2019 22:50:34', 'dd-mm-yyyy hh24:mi:ss'), '回款', 56250, '银行卡', 87, 106250);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (442, to_date('10-01-2019 23:59:12', 'dd-mm-yyyy hh24:mi:ss'), '投资', 20000, '银行卡', 70, 69083.33);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (365, to_date('10-01-2019 19:51:45', 'dd-mm-yyyy hh24:mi:ss'), '投资', 50000, '银行卡', 2, 50000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (367, to_date('10-01-2019 19:52:36', 'dd-mm-yyyy hh24:mi:ss'), '投资', 30000, '银行卡', 6, 20000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (371, to_date('10-01-2019 19:55:42', 'dd-mm-yyyy hh24:mi:ss'), '投资', 100000, '银行卡', 4, 0);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (384, to_date('10-01-2019 20:51:19', 'dd-mm-yyyy hh24:mi:ss'), '投资', 80000, '银行卡', 3, 0);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (413, to_date('10-01-2019 23:15:21', 'dd-mm-yyyy hh24:mi:ss'), '提现', 49049, '银行卡', 87, 944.75);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (414, to_date('10-01-2019 23:16:59', 'dd-mm-yyyy hh24:mi:ss'), '提现', 900.9, '银行卡', 87, 43.85);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (416, to_date('10-01-2019 23:20:06', 'dd-mm-yyyy hh24:mi:ss'), '充值', 1000, '银行卡', 87, 993.8);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (418, to_date('10-01-2019 23:22:01', 'dd-mm-yyyy hh24:mi:ss'), '流标', 50000, '银行卡', 87, 49993.8);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (420, to_date('10-01-2019 23:29:49', 'dd-mm-yyyy hh24:mi:ss'), '提现', 500500, '银行卡', 87, 499500);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (421, to_date('10-01-2019 23:29:55', 'dd-mm-yyyy hh24:mi:ss'), '提现', 500500, '银行卡', 87, -1000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (422, to_date('10-01-2019 23:31:11', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 49000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (423, to_date('10-01-2019 23:31:25', 'dd-mm-yyyy hh24:mi:ss'), '提现', 50050, '银行卡', 87, -1050);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (424, to_date('10-01-2019 23:32:49', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 48950);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (366, to_date('10-01-2019 19:52:15', 'dd-mm-yyyy hh24:mi:ss'), '投资', 50000, '银行卡', 6, 50000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (368, to_date('10-01-2019 19:53:47', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 6, 70000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (425, to_date('10-01-2019 23:32:57', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 98950);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (426, to_date('10-01-2019 23:33:10', 'dd-mm-yyyy hh24:mi:ss'), '提现', 50050, '银行卡', 87, 48900);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (427, to_date('10-01-2019 23:34:10', 'dd-mm-yyyy hh24:mi:ss'), '提现', 100.1, '银行卡', 87, 48799.9);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (428, to_date('10-01-2019 23:34:18', 'dd-mm-yyyy hh24:mi:ss'), '提现', 50050, '银行卡', 87, -1250.1);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (429, to_date('10-01-2019 23:34:32', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 48749.9);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (430, to_date('10-01-2019 23:37:00', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 98749.9);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (431, to_date('10-01-2019 23:37:34', 'dd-mm-yyyy hh24:mi:ss'), '提现', 50050, '银行卡', 87, 48699.9);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (432, to_date('10-01-2019 23:37:50', 'dd-mm-yyyy hh24:mi:ss'), '提现', 50050, '银行卡', 87, -1350.1);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (433, to_date('10-01-2019 23:38:02', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 48649.9);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (436, to_date('10-01-2019 23:41:30', 'dd-mm-yyyy hh24:mi:ss'), '提现', 50050, '银行卡', 87, -1400.1);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (437, to_date('10-01-2019 23:41:49', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 48599.9);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (438, to_date('10-01-2019 23:43:57', 'dd-mm-yyyy hh24:mi:ss'), '提现', 50050, '银行卡', 87, -1450.1);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (443, to_date('11-01-2019 00:08:53', 'dd-mm-yyyy hh24:mi:ss'), '提现', 69153.08, '银行卡', 70, -69.75);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (444, to_date('11-01-2019 00:09:17', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 70, 49930.25);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (405, to_date('10-01-2019 23:05:56', 'dd-mm-yyyy hh24:mi:ss'), '投资', 20000, '银行卡', 87, 86250);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (406, to_date('10-01-2019 23:06:23', 'dd-mm-yyyy hh24:mi:ss'), '投资', 30000, '银行卡', 68, 70000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (407, to_date('10-01-2019 23:07:00', 'dd-mm-yyyy hh24:mi:ss'), '贷款', 48500, '银行卡', 70, 140750);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (408, to_date('10-01-2019 23:09:03', 'dd-mm-yyyy hh24:mi:ss'), '还款', 51666.67, '银行卡', 70, 89083.33);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (409, to_date('10-01-2019 23:09:03', 'dd-mm-yyyy hh24:mi:ss'), '回款', 20666.67, '银行卡', 87, 106916.67);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (410, to_date('10-01-2019 23:09:03', 'dd-mm-yyyy hh24:mi:ss'), '回款', 31000, '银行卡', 68, 101000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (411, to_date('10-01-2019 23:12:29', 'dd-mm-yyyy hh24:mi:ss'), '提现', 6922.92, '银行卡', 87, 99993.75);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (412, to_date('10-01-2019 23:15:08', 'dd-mm-yyyy hh24:mi:ss'), '投资', 50000, '银行卡', 87, 49993.75);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (434, to_date('10-01-2019 23:38:34', 'dd-mm-yyyy hh24:mi:ss'), '投资', 20000, '银行卡', 3, 80000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (435, to_date('10-01-2019 23:40:24', 'dd-mm-yyyy hh24:mi:ss'), '流标', 20000, '银行卡', 3, 100000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (454, to_date('11-01-2019 09:47:36', 'dd-mm-yyyy hh24:mi:ss'), '流标', 10000, '银行卡', 87, 100000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (391, to_date('10-01-2019 21:54:43', 'dd-mm-yyyy hh24:mi:ss'), '流标', 50000, '银行卡', 6, 268500);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (383, to_date('10-01-2019 20:48:43', 'dd-mm-yyyy hh24:mi:ss'), '贷款', 9700, '银行卡', 3, 80000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (388, to_date('10-01-2019 21:52:24', 'dd-mm-yyyy hh24:mi:ss'), '流标', 50000, '银行卡', 2, 148500);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (389, to_date('10-01-2019 21:52:24', 'dd-mm-yyyy hh24:mi:ss'), '流标', 50000, '银行卡', 6, 218500);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (390, to_date('10-01-2019 21:54:43', 'dd-mm-yyyy hh24:mi:ss'), '流标', 50000, '银行卡', 2, 198500);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (392, to_date('10-01-2019 21:57:42', 'dd-mm-yyyy hh24:mi:ss'), '还款', 52083.33, '银行卡', 6, null);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (446, to_date('11-01-2019 09:20:02', 'dd-mm-yyyy hh24:mi:ss'), '投资', 50000, '银行卡', 69, 50000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (447, to_date('11-01-2019 09:21:05', 'dd-mm-yyyy hh24:mi:ss'), '投资', 50000, '银行卡', 68, 51000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (397, to_date('10-01-2019 22:07:01', 'dd-mm-yyyy hh24:mi:ss'), '回款', 55625, '银行卡', 3, null);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (445, to_date('11-01-2019 09:12:37', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 88, 50000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (448, to_date('11-01-2019 09:22:26', 'dd-mm-yyyy hh24:mi:ss'), '贷款', 97000, '银行卡', 88, 147000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (449, to_date('11-01-2019 09:32:59', 'dd-mm-yyyy hh24:mi:ss'), '还款', 105833.33, '银行卡', 88, 41166.67);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (450, to_date('11-01-2019 09:32:59', 'dd-mm-yyyy hh24:mi:ss'), '回款', 52916.67, '银行卡', 69, 102916.67);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (372, to_date('10-01-2019 19:56:31', 'dd-mm-yyyy hh24:mi:ss'), '投资', 30000, '银行卡', 3, 70000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (373, to_date('10-01-2019 19:56:54', 'dd-mm-yyyy hh24:mi:ss'), '投资', 20000, '银行卡', 3, 50000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (451, to_date('11-01-2019 09:32:59', 'dd-mm-yyyy hh24:mi:ss'), '回款', 52916.67, '银行卡', 68, 103916.67);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (452, to_date('11-01-2019 09:34:46', 'dd-mm-yyyy hh24:mi:ss'), '提现', 100100, '银行卡', 68, 3916.67);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (453, to_date('11-01-2019 09:38:00', 'dd-mm-yyyy hh24:mi:ss'), '投资', 10000, '银行卡', 87, 90000);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (369, to_date('10-01-2019 19:54:36', 'dd-mm-yyyy hh24:mi:ss'), '投资', 70000, '银行卡', 6, 0);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (441, to_date('10-01-2019 23:45:28', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 48499.9);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (439, to_date('10-01-2019 23:44:12', 'dd-mm-yyyy hh24:mi:ss'), '充值', 50000, '银行卡', 87, 48549.9);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (376, to_date('10-01-2019 20:09:41', 'dd-mm-yyyy hh24:mi:ss'), '流标', 100000, '银行卡', 4, null);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (377, to_date('10-01-2019 20:09:41', 'dd-mm-yyyy hh24:mi:ss'), '流标', 30000, '银行卡', 3, null);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (440, to_date('10-01-2019 23:45:17', 'dd-mm-yyyy hh24:mi:ss'), '提现', 50050, '银行卡', 87, -1500.1);
insert into TB_MONEYRECORD (moneyrecord, watercoursetime, watercoursetype, watercoursemoney, chargeway, userid, balance)
values (385, to_date('10-01-2019 20:51:40', 'dd-mm-yyyy hh24:mi:ss'), '投资', 40000, '银行卡', 47, 60000);
commit;
prompt 76 records loaded
prompt Loading TB_NOTICE...
insert into TB_NOTICE (id, headline, content, time, operator)
values (9, '上雕刻技法设计的风口浪尖', '盎司伦敦警方及时打款了吉拉斯的看见了', to_date('13-12-2018 20:08:50', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_NOTICE (id, headline, content, time, operator)
values (12, 'dsaf', 'sdaf', to_date('15-12-2018 10:43:21', 'dd-mm-yyyy hh24:mi:ss'), 'admin');
insert into TB_NOTICE (id, headline, content, time, operator)
values (7, '测试', '啊萨芬就阿瑟东开了房间萨克龙卷风', to_date('13-12-2018 16:12:49', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into TB_NOTICE (id, headline, content, time, operator)
values (1, '考试', '翻书；马冬梅！合书；马什么冬梅？翻书；马冬梅！合书；马东什么？？翻书；马冬梅！马冬梅！马冬梅！考试；孙红雷！', to_date('26-11-2018', 'dd-mm-yyyy'), '马东梅');
commit;
prompt 4 records loaded
prompt Loading TB_REFUND...
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (3, null, 155, 100000, to_date('10-11-2018 14:43:48', 'dd-mm-yyyy hh24:mi:ss'), 2, null);
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (45, null, 180, 56250, to_date('10-01-2019 22:50:34', 'dd-mm-yyyy hh24:mi:ss'), 1, null);
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (44, null, 128, 55625, to_date('10-01-2019 22:12:19', 'dd-mm-yyyy hh24:mi:ss'), 1, null);
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (29, null, 163, 108333.33, to_date('10-01-2019 17:07:34', 'dd-mm-yyyy hh24:mi:ss'), 2, null);
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (46, null, 182, 51666.67, to_date('10-01-2019 23:09:03', 'dd-mm-yyyy hh24:mi:ss'), 1, null);
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (19, null, 127, 50000, to_date('13-04-2018 20:45:45', 'dd-mm-yyyy hh24:mi:ss'), 1, null);
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (47, null, 189, 105833.33, to_date('11-01-2019 09:32:59', 'dd-mm-yyyy hh24:mi:ss'), 1, null);
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (42, null, 129, 52083.33, to_date('10-01-2019 21:57:42', 'dd-mm-yyyy hh24:mi:ss'), 1, null);
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (43, null, 128, 55625, to_date('10-01-2019 22:07:01', 'dd-mm-yyyy hh24:mi:ss'), 1, null);
insert into TB_REFUND (refundid, investmentid, loansid, refundmoney, refunddate, auditstate, surplustime)
values (23, null, 163, 108333.33, to_date('10-01-2019 15:37:00', 'dd-mm-yyyy hh24:mi:ss'), 1, null);
commit;
prompt 10 records loaded
prompt Loading TB_REFUND_PLAN...
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (128, 1, 50000, 5625, 50000, 5625, null, to_date('10-02-2019 22:05:28', 'dd-mm-yyyy hh24:mi:ss'), 0, 2);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (180, 1, 50000, 6250, 50000, 6250, null, to_date('10-02-2019 22:48:54', 'dd-mm-yyyy hh24:mi:ss'), 0, 70);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (128, 1, 50000, 5625, 50000, 5625, null, to_date('09-10-2019 22:29:30', 'dd-mm-yyyy hh24:mi:ss'), 0, 2);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (129, 1, 50000, 2083.33, 50000, 2083.33, null, to_date('10-02-2019 15:53:07', 'dd-mm-yyyy hh24:mi:ss'), 0, 6);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 1, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-02-2019 21:59:34', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 2, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-03-2019 21:59:34', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 3, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-04-2019 21:59:34', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 4, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-05-2019 21:59:34', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 5, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-06-2019 21:59:34', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 6, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-07-2019 21:59:34', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 7, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-08-2019 21:59:34', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 8, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-09-2019 21:59:34', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 9, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-10-2019 21:59:34', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (126, 1, 120000, 2400, 120000, 2400, null, to_date('09-09-2019 22:23:10', 'dd-mm-yyyy hh24:mi:ss'), 0, 5);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (159, 1, 200000, 13333.33, 200000, 13333.33, null, to_date('09-11-2019 21:46:50', 'dd-mm-yyyy hh24:mi:ss'), 0, 67);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (163, 1, 100000, 8333.33, 100000, 8333.33, null, to_date('10-02-2019 15:33:50', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (182, 1, 50000, 1666.67, 50000, 1666.67, null, to_date('10-02-2019 23:07:00', 'dd-mm-yyyy hh24:mi:ss'), 0, 70);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (189, 1, 100000, 5833.33, 100000, 5833.33, null, to_date('11-02-2019 09:22:26', 'dd-mm-yyyy hh24:mi:ss'), 0, 88);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 1, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-02-2019 22:42:02', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 2, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-03-2019 22:42:02', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 3, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-04-2019 22:42:02', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 4, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-05-2019 22:42:02', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 5, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-06-2019 22:42:02', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 6, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-07-2019 22:42:02', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 7, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-08-2019 22:42:02', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 8, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-09-2019 22:42:02', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 9, 5555.56, 416.67, 5555.56, 416.67, null, to_date('09-10-2019 22:42:02', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (129, 1, 50000, 2083.33, 50000, 2083.33, null, to_date('09-06-2019 22:47:47', 'dd-mm-yyyy hh24:mi:ss'), 0, 6);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (128, 1, 50000, 5625, 50000, 5625, null, to_date('24-09-2019 18:47:13', 'dd-mm-yyyy hh24:mi:ss'), 0, 2);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (129, 1, 50000, 2083.33, 50000, 2083.33, null, to_date('10-02-2019 19:59:29', 'dd-mm-yyyy hh24:mi:ss'), 0, 6);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (128, 1, 50000, 5625, 50000, 5625, null, to_date('10-02-2019 20:06:37', 'dd-mm-yyyy hh24:mi:ss'), 0, 2);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 1, 5555.56, 416.67, 5555.56, 416.67, null, to_date('19-10-2018 18:47:13', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 2, 5555.56, 416.67, 5555.56, 416.67, null, to_date('19-11-2018 18:47:13', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 3, 5555.56, 416.67, 5555.56, 416.67, null, to_date('24-12-2018 18:47:13', 'dd-mm-yyyy hh24:mi:ss'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 4, 5555.56, 416.67, 5555.56, 416.67, null, to_date('19-04-2019', 'dd-mm-yyyy'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 5, 5555.56, 416.67, 5555.56, 416.67, null, to_date('19-05-2019', 'dd-mm-yyyy'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 6, 5555.56, 416.67, 5555.56, 416.67, null, to_date('19-06-2019', 'dd-mm-yyyy'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 7, 5555.56, 416.67, 5555.56, 416.67, null, to_date('19-07-2019', 'dd-mm-yyyy'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 8, 5555.56, 416.67, 5555.56, 416.67, null, to_date('19-08-2019', 'dd-mm-yyyy'), 0, 3);
insert into TB_REFUND_PLAN (loansid, currentperiods, currentbalance, currentinterest, surplusmoney, surplusinterest, overdueinterest, refundtime, refundstate, loanserid)
values (141, 9, 5555.56, 416.67, 5555.56, 416.67, null, to_date('19-09-2019', 'dd-mm-yyyy'), 0, 3);
commit;
prompt 40 records loaded
prompt Loading TB_RESOURCES...
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (1, '系统设置', '/system', 0, 0, 1);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (2, '用户管理', '/usersPage', 1, 1, 2);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (3, '角色管理', '/rolesPage', 1, 1, 3);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (4, '资源管理', '/resourcesPage', 1, 1, 4);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (5, '添加用户', '/users/add', 2, 2, 5);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (6, '删除用户', '/users/delete', 2, 2, 6);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (7, '添加角色', '/roles/add', 2, 3, 7);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (8, '删除角色', '/roles/delete', 2, 3, 8);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (9, '添加资源', '/resources/add', 2, 4, 9);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (10, '删除资源', '/resources/delete', 2, 4, 10);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (11, '分配角色', '/users/saveUserRoles', 2, 2, 11);
insert into TB_RESOURCES (id, name, resurl, type, parentid, sort)
values (12, '分配权限', '/roles/saveRoleResources', 2, 3, 12);
commit;
prompt 12 records loaded
prompt Loading TB_ROLE...
insert into TB_ROLE (roledesc, roleid, rolename, roleflag)
values ('超级管理员', null, null, null);
insert into TB_ROLE (roledesc, roleid, rolename, roleflag)
values ('管理员', null, null, null);
insert into TB_ROLE (roledesc, roleid, rolename, roleflag)
values ('用户', null, null, null);
commit;
prompt 3 records loaded
prompt Loading TB_ROLE_POWER...
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (561, 2, 15, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (562, 2, 16, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (563, 2, 3, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (564, 2, 7, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (565, 2, 8, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (566, 2, 4, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (567, 2, 9, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (568, 2, 10, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (569, 2, 11, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (570, 2, 12, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (571, 2, 13, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (559, 2, 2, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (560, 2, 6, to_date('12-12-2018 10:11:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (592, 1, 15, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (593, 1, 16, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (594, 1, 3, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (595, 1, 7, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (596, 1, 8, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (597, 1, 4, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (598, 1, 10, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (599, 1, 11, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (600, 1, 12, to_date('07-01-2019 20:58:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (601, 1, 13, to_date('07-01-2019 20:58:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (602, 1, 13, to_date('07-01-2019 20:58:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (603, 1, 15, to_date('07-01-2019 20:58:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (604, 1, 5, to_date('07-01-2019 20:58:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (605, 1, 14, to_date('07-01-2019 20:58:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (590, 1, 1, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (591, 1, 2, to_date('07-01-2019 20:58:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (447, 36, 6, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (448, 36, 3, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (449, 36, 7, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (450, 36, 8, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (451, 36, 4, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (452, 36, 9, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (453, 36, 10, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (454, 36, 11, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (455, 36, 12, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (456, 36, 13, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (445, 36, 1, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (446, 36, 2, to_date('04-12-2018 22:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (457, 4, 1, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (458, 4, 2, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (459, 4, 6, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (460, 4, 8, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (461, 4, 4, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (462, 4, 9, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (463, 4, 10, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (464, 4, 11, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (465, 4, 12, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (466, 4, 13, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (467, 4, 5, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_ROLE_POWER (tb_role_power, roleid, powerid, addtime)
values (468, 4, 14, to_date('04-12-2018 22:32:04', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 53 records loaded
prompt Loading TB_ROLE_RESOURCES...
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 1);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 2);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 3);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 4);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 5);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 6);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 7);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 8);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 9);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 10);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 11);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (1, 12);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (2, 1);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (2, 5);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (2, 6);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (2, 7);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (2, 8);
insert into TB_ROLE_RESOURCES (roleid, resourcesid)
values (3, 1);
commit;
prompt 18 records loaded
prompt Loading TB_USER...
insert into TB_USER (id, username, password, enable, salt)
values (1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (2, 'sunzhen', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (3, 'xingbobo', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (4, 'shenen', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (5, 'yanhaotian', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (6, 'maoyu', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (47, 'ceshi', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (87, 'ceshi4', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (69, 'ceshi1', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (68, 'ceshi2', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (70, 'ceshi3', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (88, 'test1', '21232f297a57a5a743894a0e4a801fc3', 1, null);
insert into TB_USER (id, username, password, enable, salt)
values (67, 'zhangsan', '21232f297a57a5a743894a0e4a801fc3', 1, null);
commit;
prompt 13 records loaded
prompt Loading TB_USERACCOUNT...
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (47, 47, 140000, 100000, 0, 0, 0, 50000, 2, '61025493-d505-42b6-95ff-e6938e26aa90.jpg', '2823a21e-6fe9-4721-8a83-f865a26c2057.jpg', 0, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (87, 87, 100000, 100000, 0, 0, 0, 50000, 2, '4ae1ee5b-9d41-403f-b1b0-9698ff42c262.jpg', '47a1dabd-e410-4387-97a5-f396ecbae1df.jpg', 0, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (5, 5, 100000, 100000, 0, 0, 0, 50000, 2, '61025493-d505-42b6-95ff-e6938e26aa90.jpg', '2823a21e-6fe9-4721-8a83-f865a26c2057.jpg', null, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (69, 69, 102916.67, 102916.67, 0, 0, 0, 50000, 2, '2a29116a-1354-4a55-b5a7-bfd482c113b1.jpg', 'caf9ac98-ccda-4bdc-a3ea-25eee60c9eb9.jpg', 2916.67, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (6, 6, 366416.67, 216416.67, 3375, 30000, 0, 50000, 2, '61025493-d505-42b6-95ff-e6938e26aa90.jpg', '2823a21e-6fe9-4721-8a83-f865a26c2057.jpg', null, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (2, 2, 44375, 44375, 0, 0, 0, 50000, 2, '81753af7-7252-4fc2-b3cd-1a0c57822aaa.jpg', '36b7fc9c-dd33-4534-9c51-aa844c7b2be0.jpg', null, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (3, 3, 100000, 100000, 0, 0, 0, 50000, 2, '61025493-d505-42b6-95ff-e6938e26aa90.jpg', '2823a21e-6fe9-4721-8a83-f865a26c2057.jpg', null, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (4, 4, 200000, 100000, 0, 0, 0, 50000, 2, '61025493-d505-42b6-95ff-e6938e26aa90.jpg', '2823a21e-6fe9-4721-8a83-f865a26c2057.jpg', null, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (70, 70, 69930.25, 49930.25, 0, 0, 0, 50000, 2, '9e2efab5-7483-452a-a3c5-0f9b6fad0ea4.jpg', '4af9f09d-0fb4-4759-8026-709bd590d741.jpg', 0, 20000);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (68, 68, 3916.67, 3916.67, 0, 0, 0, 50000, 2, '6b38f994-404a-48ec-9016-261b8104828b.jpg', '18958d7a-8312-4391-af1d-aacd94912a5f.jpg', 3916.67, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (88, 88, 41166.67, 41166.67, 0, 0, 0, 50000, 2, '23bacd94-a153-428b-9700-8bad1ca34bed.jpg', 'a477fc3e-e030-4cd1-ba8f-4aed29bfa4f3.jpg', 0, 0);
insert into TB_USERACCOUNT (useraccountid, userinformationid, accounmoney, availmoney, awaitinterest, awaitmoney, money, lineofcredit, certification, frontimg, behindimg, accruedincome, frozencapital)
values (67, 67, 100000, 100000, 0, 0, 0, 50000, 2, '1791b198-43b0-4eaa-9406-5256e7cdff4c.jpg', 'a9beac0f-c13b-46e4-9b42-56b38b378b25.jpg', 0, 0);
commit;
prompt 12 records loaded
prompt Loading TB_USERINFORMATION...
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (6, 6, '毛宇', '男', '18300695622', '411523199507192014', '6228482399586987562', '931280761@sina.com', '4a84aa7a-685d-4209-ac58-dea5fe364304.jpg', '河南省信阳市新县秀水家园', '专科', '未婚', '9500', 1, 123456, to_date('18-12-2018 11:25:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-04-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (47, 47, '王炸', '男', '15036122780', '412728199719996661', '6228482399519775674', null, 'a7d21803-42a7-4d6d-9511-b6c0e4cae3d7.png', '河南省', '本科', '未婚', null, 1, 123456, to_date('18-12-2018 11:25:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-04-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (87, 87, '蔡旭东', '男', '17737815792', '410522199808270111', '6228482399519775674', null, null, '河南安阳市安阳县', '本科', '未婚', '1000', 1, 123456, to_date('10-01-2019 22:46:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-08-1998', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (2, 2, '孙振', '男', '15836245606', '412728199719996661', '6228484692179624521', '980315919@qq.com', '036eaa22-04ae-41fb-a1dc-ca772ad44f99.png', '河南省信阳市新县秀水家园', '初中或以下', '离异', '100', 1, 123456, to_date('19-12-2018 13:01:20', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-05-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (69, 69, '王炸', '男', '15136074496', '412728199708213831', '6228482399519775674', null, null, '河南周口地区沈丘县', '硕士或研究生以上', '未婚', '1000', 1, 123456, to_date('10-01-2019 20:22:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-08-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (88, 88, '严浩天', '男', '15138956487', '410522199705304710', '6228482399519775674', null, '17a0c484-a1d1-4939-a346-504d828ee14e.jpg', '河南安阳市安阳县', '硕士或研究生以上', '已婚', '100', 1, 123456, to_date('11-01-2019 09:09:12', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-05-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (68, 68, '范文鹏', '男', '18236431010', '410881199702058493', '6228482399519775674', null, '8cfcf272-766b-460e-9410-0d9c7d9e09fb.jpg', '河南焦作市济源市', '硕士或研究生以上', '已婚', '1000', 1, 123456, to_date('10-01-2019 14:58:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-02-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (70, 70, '李白', '男', '15638915172', '412728199708213831', '6228482399519775675', null, null, '河南周口地区沈丘县', '硕士或研究生以上', '未婚', '10000', 1, 123456, to_date('10-01-2019 20:25:22', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-08-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (67, 67, '张三', '男', '18503820901', '412728199719996661', '6228484692179624522', null, '680b0428-9feb-4159-8d0b-0ecdd0bad2a0.jpg', '河南省信阳市新县秀水家园', '硕士或研究生以上', '已婚', '100', 1, 123456, to_date('09-01-2019 21:08:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-05-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (3, 3, '邢博', '男', '15638570846', '412728199719996661', '6228484692179624522', '1813855316@qq.com', 'touxiang3.jpg', '河南省', '本科', '未婚', '12000', 1, 123456, to_date('18-12-2018 11:25:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-04-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (4, 4, '申恩', '男', '15896485135', '412728199719991261', '6228484692179612532', '1813855316@qq.com', '33232ba1-0d12-48a1-8583-90e9b0eb91fc.png', '河南省', '本科', '未婚', '12000', 1, 123456, to_date('18-12-2018 11:30:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-04-1997', 'dd-mm-yyyy'));
insert into TB_USERINFORMATION (userinformationid, userid, name, usersex, userphone, identitycard, bankcardnumbers, email, headportrait, site, education, marriage, basicincome, state, paypassword, sbttime, birthday)
values (5, 5, '严浩天', '男', '13592535690', '412728199719995261', '6228484692179612502', '1813855156@qq.com', 'touxiang3.jpg', '河南省', '本科', '未婚', '12000', 1, 123456, to_date('18-12-2018 11:25:05', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-04-1997', 'dd-mm-yyyy'));
commit;
prompt 12 records loaded
prompt Loading TB_USER_ROLE...
insert into TB_USER_ROLE (userid, roleid)
values (47, 3);
insert into TB_USER_ROLE (userid, roleid)
values (87, 3);
insert into TB_USER_ROLE (userid, roleid)
values (28, 3);
insert into TB_USER_ROLE (userid, roleid)
values (69, 3);
insert into TB_USER_ROLE (userid, roleid)
values (1, 1);
insert into TB_USER_ROLE (userid, roleid)
values (2, 2);
insert into TB_USER_ROLE (userid, roleid)
values (3, 2);
insert into TB_USER_ROLE (userid, roleid)
values (4, 2);
insert into TB_USER_ROLE (userid, roleid)
values (5, 3);
insert into TB_USER_ROLE (userid, roleid)
values (6, 3);
insert into TB_USER_ROLE (userid, roleid)
values (27, 3);
insert into TB_USER_ROLE (userid, roleid)
values (68, 3);
insert into TB_USER_ROLE (userid, roleid)
values (70, 3);
insert into TB_USER_ROLE (userid, roleid)
values (88, 3);
insert into TB_USER_ROLE (userid, roleid)
values (29, 3);
insert into TB_USER_ROLE (userid, roleid)
values (32, 3);
insert into TB_USER_ROLE (userid, roleid)
values (33, 3);
insert into TB_USER_ROLE (userid, roleid)
values (67, 3);
insert into TB_USER_ROLE (userid, roleid)
values (7, 3);
insert into TB_USER_ROLE (userid, roleid)
values (34, 3);
insert into TB_USER_ROLE (userid, roleid)
values (35, 3);
insert into TB_USER_ROLE (userid, roleid)
values (36, 3);
commit;
prompt 22 records loaded
prompt Loading TB_YUE...
insert into TB_YUE (month)
values (to_date('01-11-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('08-10-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('01-09-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('01-08-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('01-07-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('01-06-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('01-05-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('01-04-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('01-03-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('01-02-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('01-01-2018', 'dd-mm-yyyy'));
insert into TB_YUE (month)
values (to_date('08-12-2018', 'dd-mm-yyyy'));
commit;
prompt 12 records loaded
prompt Loading T_ROLE...
insert into T_ROLE (roledesc, roleid, rolename, roleflag)
values ('789', 13, '7744', '1');
insert into T_ROLE (roledesc, roleid, rolename, roleflag)
values ('任性', 1, '超级管理员', '1');
insert into T_ROLE (roledesc, roleid, rolename, roleflag)
values ('网站分布和管理开发', 2, '网站管理员', '1');
insert into T_ROLE (roledesc, roleid, rolename, roleflag)
values ('审核业务', 3, '审核员', '1');
insert into T_ROLE (roledesc, roleid, rolename, roleflag)
values ('查看财务', 4, '财务经理', '1');
commit;
prompt 5 records loaded
prompt Loading USERS...
insert into USERS (userid, username, password, gender, email)
values (1, 'zhangsan', 'admin', 1, 'zhangsan@163.com');
insert into USERS (userid, username, password, gender, email)
values (2, 'lisi', 'admin', 2, 'lisi@163.com');
insert into USERS (userid, username, password, gender, email)
values (3, 'wangwu', 'admin', 1, 'wangwu@163.com');
insert into USERS (userid, username, password, gender, email)
values (4, 'maliu', 'admin', 2, 'maliu@163.com');
commit;
prompt 4 records loaded
prompt Loading USERSA...
prompt Table is empty
prompt Enabling triggers for TB_ACCOUNT...
alter table TB_ACCOUNT enable all triggers;
prompt Enabling triggers for TB_AUDITRECORD...
alter table TB_AUDITRECORD enable all triggers;
prompt Enabling triggers for TB_COMMENT...
alter table TB_COMMENT enable all triggers;
prompt Enabling triggers for TB_COMPANY_MONEY_RECORD...
alter table TB_COMPANY_MONEY_RECORD enable all triggers;
prompt Enabling triggers for TB_INVESTMENT...
alter table TB_INVESTMENT enable all triggers;
prompt Enabling triggers for TB_JINNANG...
alter table TB_JINNANG enable all triggers;
prompt Enabling triggers for TB_LIMIT...
alter table TB_LIMIT enable all triggers;
prompt Enabling triggers for TB_LOANS...
alter table TB_LOANS enable all triggers;
prompt Enabling triggers for TB_LOANSTYPE...
alter table TB_LOANSTYPE enable all triggers;
prompt Enabling triggers for TB_MESSAGE...
alter table TB_MESSAGE enable all triggers;
prompt Enabling triggers for TB_MONEY...
alter table TB_MONEY enable all triggers;
prompt Enabling triggers for TB_MONEYRECORD...
alter table TB_MONEYRECORD enable all triggers;
prompt Enabling triggers for TB_NOTICE...
alter table TB_NOTICE enable all triggers;
prompt Enabling triggers for TB_REFUND...
alter table TB_REFUND enable all triggers;
prompt Enabling triggers for TB_REFUND_PLAN...
alter table TB_REFUND_PLAN enable all triggers;
prompt Enabling triggers for TB_RESOURCES...
alter table TB_RESOURCES enable all triggers;
prompt Enabling triggers for TB_ROLE...
alter table TB_ROLE enable all triggers;
prompt Enabling triggers for TB_ROLE_POWER...
alter table TB_ROLE_POWER enable all triggers;
prompt Enabling triggers for TB_ROLE_RESOURCES...
alter table TB_ROLE_RESOURCES enable all triggers;
prompt Enabling triggers for TB_USER...
alter table TB_USER enable all triggers;
prompt Enabling triggers for TB_USERACCOUNT...
alter table TB_USERACCOUNT enable all triggers;
prompt Enabling triggers for TB_USERINFORMATION...
alter table TB_USERINFORMATION enable all triggers;
prompt Enabling triggers for TB_USER_ROLE...
alter table TB_USER_ROLE enable all triggers;
prompt Enabling triggers for TB_YUE...
alter table TB_YUE enable all triggers;
prompt Enabling triggers for T_ROLE...
alter table T_ROLE enable all triggers;
prompt Enabling triggers for USERS...
alter table USERS enable all triggers;
prompt Enabling triggers for USERSA...
alter table USERSA enable all triggers;
set feedback on
set define on
prompt Done.
