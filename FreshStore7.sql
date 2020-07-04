/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/7/3 14:47:28                            */
/*==============================================================*/


drop table if exists Adm_admInfo;

drop table if exists Adm_purchase;

drop table if exists Dis_DiscountCommod;

drop table if exists Dis_coupon;

drop table if exists Dis_enoughReduce;

drop table if exists Dis_limit;

drop table if exists Fresh_Evaluate;

drop table if exists Fresh_Recommend;

drop table if exists Fresh_commodInfo;

drop table if exists Fresh_menuInfo;

drop table if exists Fresh_sortInfo;

drop table if exists Use_OrderInfo;

drop table if exists Use_address;

drop table if exists Use_info;

drop table if exists Use_order;

/*==============================================================*/
/* Table: Adm_admInfo                                           */
/*==============================================================*/
create table Adm_admInfo
(
   aINo                 bigint not null auto_increment,
   aIName               varchar(20),
   aIPwd                varchar(20),
   primary key (aINo)
);

/*==============================================================*/
/* Table: Adm_purchase                                          */
/*==============================================================*/
create table Adm_purchase
(
   PurNo                bigint not null auto_increment,
   aINo                 bigint,
   ComNo                bigint,
   PurNum               int,
   PurState             varchar(40),
   primary key (PurNo)
);

/*==============================================================*/
/* Table: Dis_DiscountCommod                                    */
/*==============================================================*/
create table Dis_DiscountCommod
(
   ComNo                bigint not null,
   eRNo                 bigint not null,
   dCBegin              date,
   dVEnd                date,
   primary key (ComNo, eRNo)
);

/*==============================================================*/
/* Table: Dis_coupon                                            */
/*==============================================================*/
create table Dis_coupon
(
   CouNo                bigint not null auto_increment,
   CouContent           varchar(200),
   CouApplyPrice        float(200,0),
   CouReliefPrice       float(200,0),
   CouBegin             date,
   CouEnd               date,
   primary key (CouNo)
);

/*==============================================================*/
/* Table: Dis_enoughReduce                                      */
/*==============================================================*/
create table Dis_enoughReduce
(
   eRNo                 bigint not null auto_increment,
   eRContent            varchar(500),
   eRComNum             int,
   eRDiscount           double not null,
   eRBegin              date,
   eRend                date,
   primary key (eRNo)
);

/*==============================================================*/
/* Table: Dis_limit                                             */
/*==============================================================*/
create table Dis_limit
(
   LimNo                bigint not null auto_increment,
   ComNo                bigint,
   LimPrice             float(200,0),
   LimNum               int,
   LimBegin             date,
   LimEnd               date,
   primary key (LimNo)
);

/*==============================================================*/
/* Table: Fresh_Evaluate                                        */
/*==============================================================*/
create table Fresh_Evaluate
(
   InfoNo               bigint not null,
   ComNo                bigint not null,
   EvaContent           varchar(500),
   EvaDate              date,
   EvaLevel             int,
   EvaPic               longblob,
   primary key (InfoNo, ComNo)
);

/*==============================================================*/
/* Table: Fresh_Recommend                                       */
/*==============================================================*/
create table Fresh_Recommend
(
   ComNo                bigint not null,
   MenuNo               bigint not null,
   ReDescribe           varchar(200),
   primary key (ComNo, MenuNo)
);

/*==============================================================*/
/* Table: Fresh_commodInfo                                      */
/*==============================================================*/
create table Fresh_commodInfo
(
   ComNo                bigint not null auto_increment,
   SortNo               bigint,
   ComName              varchar(50),
   ComPrice             float(200,0),
   ComVIPPrice          float(200,0),
   ComNum               int,
   ComSpecil            varchar(30),
   ComDetail            varchar(500),
   primary key (ComNo)
);

/*==============================================================*/
/* Table: Fresh_menuInfo                                        */
/*==============================================================*/
create table Fresh_menuInfo
(
   MenuNo               bigint not null auto_increment,
   MenuName             varchar(50),
   MenuMaterial         varchar(100),
   MenuStep             varchar(200),
   MenuPic              longblob,
   primary key (MenuNo)
);

/*==============================================================*/
/* Table: Fresh_sortInfo                                        */
/*==============================================================*/
create table Fresh_sortInfo
(
   SortNo               bigint not null auto_increment,
   SortName             varchar(50),
   SortDes              varchar(500),
   primary key (SortNo)
);

/*==============================================================*/
/* Table: Use_OrderInfo                                         */
/*==============================================================*/
create table Use_OrderInfo
(
   OrdNo                bigint not null,
   ComNo                bigint not null,
   eRNo                 bigint not null,
   oINum                int,
   oIPrice              float(200,0),
   olDiscount           double,
   primary key (OrdNo, ComNo, eRNo)
);

/*==============================================================*/
/* Table: Use_address                                           */
/*==============================================================*/
create table Use_address
(
   AddNo                bigint not null auto_increment,
   InfoNo               bigint,
   AddProvince          varchar(20),
   AddTown              varchar(20),
   AddArea              varchar(20),
   AddLocation          varchar(50),
   AddContact           varchar(20),
   AddPhone             varchar(20),
   primary key (AddNo)
);

/*==============================================================*/
/* Table: Use_info                                              */
/*==============================================================*/
create table Use_info
(
   InfoNo               bigint not null auto_increment,
   InfoName             varchar(50),
   InfoSex              bool,
   InfoPwd              varchar(20),
   InfoPhoneNum         varchar(20),
   InfoEmail            varchar(50),
   InfoCity             varchar(50),
   InfoRegDate          date,
   InfoVIP              bool,
   InfoVIPEnd           date,
   primary key (InfoNo)
);

/*==============================================================*/
/* Table: Use_order                                             */
/*==============================================================*/
create table Use_order
(
   OrdNo                bigint not null auto_increment,
   AddNo                bigint,
   InfoNo               bigint,
   CouNo                bigint,
   OrdPrmPrice          float(200,0),
   OrdEndPrice          float(200,0),
   OrdLimitTime         date,
   OrdState             varchar(40),
   primary key (OrdNo)
);

alter table Adm_purchase add constraint FK_Adm_have_Purchase foreign key (aINo)
      references Adm_admInfo (aINo) on delete restrict on update restrict;

alter table Adm_purchase add constraint FK_Purchase_have_Commod foreign key (ComNo)
      references Fresh_commodInfo (ComNo) on delete restrict on update restrict;

alter table Dis_DiscountCommod add constraint FK_Dis_DiscountCommod foreign key (ComNo)
      references Fresh_commodInfo (ComNo) on delete restrict on update restrict;

alter table Dis_DiscountCommod add constraint FK_Dis_DiscountCommod2 foreign key (eRNo)
      references Dis_enoughReduce (eRNo) on delete restrict on update restrict;

alter table Dis_limit add constraint FK_Commod_Limit_sale foreign key (ComNo)
      references Fresh_commodInfo (ComNo) on delete restrict on update restrict;

alter table Fresh_Evaluate add constraint FK_Fresh_Evaluate foreign key (InfoNo)
      references Use_info (InfoNo) on delete restrict on update restrict;

alter table Fresh_Evaluate add constraint FK_Fresh_Evaluate2 foreign key (ComNo)
      references Fresh_commodInfo (ComNo) on delete restrict on update restrict;

alter table Fresh_Recommend add constraint FK_Fresh_Recommend foreign key (ComNo)
      references Fresh_commodInfo (ComNo) on delete restrict on update restrict;

alter table Fresh_Recommend add constraint FK_Fresh_Recommend2 foreign key (MenuNo)
      references Fresh_menuInfo (MenuNo) on delete restrict on update restrict;

alter table Fresh_commodInfo add constraint FK_Sort_have_Commod foreign key (SortNo)
      references Fresh_sortInfo (SortNo) on delete restrict on update restrict;

alter table Use_OrderInfo add constraint FK_Use_OrderInfo foreign key (OrdNo)
      references Use_order (OrdNo) on delete restrict on update restrict;

alter table Use_OrderInfo add constraint FK_Use_OrderInfo2 foreign key (ComNo)
      references Fresh_commodInfo (ComNo) on delete restrict on update restrict;

alter table Use_OrderInfo add constraint FK_Use_OrderInfo3 foreign key (eRNo)
      references Dis_enoughReduce (eRNo) on delete restrict on update restrict;

alter table Use_address add constraint FK_User_live_Address foreign key (InfoNo)
      references Use_info (InfoNo) on delete restrict on update restrict;

alter table Use_order add constraint FK_Order_have_Address foreign key (AddNo)
      references Use_address (AddNo) on delete restrict on update restrict;

alter table Use_order add constraint FK_Order_have_Coupon foreign key (CouNo)
      references Dis_coupon (CouNo) on delete restrict on update restrict;

alter table Use_order add constraint FK_User_hava_Order foreign key (InfoNo)
      references Use_info (InfoNo) on delete restrict on update restrict;

