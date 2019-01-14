# P2P-Project
---------------------------------------------------------------------------------------------------
数据库导入需要先创建表空间 否则会报错
create tablespace tbs_GroupSeven
datafile  'E:\app\Administrator\oradata\orcl\GroupSeven.dbf'---自己定义
size 100m
autoextend  on next 50m maxsize unlimited 
-- 创建用户
create user group7
identified by admin
default tablespace tbs_GroupSeven
-- 授权
grant connect,resource,dba to group7;
-----------------------------------------------------------------------------------------------------
数据库说明在resources目录下 explain
 
数据库用户表加密采用MD5加密  解密可以直接在网上用MD5解密

接口采用的是  万维易源   有短信接口 身份证接口等  需付费哦~~~~~~~~ 需要的可以自行去网上参考
万维易源
用户名：359670316@qq.com
密码：Yanhaotian530


安全框架采用的是Apache shiro 

前端框架 Vue Element LayUI EasyUI 
服务器  ftp服务器
后台登录隐藏入口  首页>底部>关于我们 可直接登入后台

具体功能不做介绍  









