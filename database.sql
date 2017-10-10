/*==============================================================*/
/* dbms name:      mysql 5.0                                    */
/* created on:     2016-6-29 18:28:57   www.roncoo.com          */
/*==============================================================*/


DROP TABLE IF EXISTS rp_account;

DROP TABLE IF EXISTS rp_account_history;

DROP TABLE IF EXISTS rp_pay_product;

DROP TABLE IF EXISTS rp_pay_way;

DROP TABLE IF EXISTS rp_sett_daily_collect;

DROP TABLE IF EXISTS rp_sett_record;

DROP TABLE IF EXISTS rp_sett_record_annex;

DROP TABLE IF EXISTS rp_user_bank_account;

DROP TABLE IF EXISTS rp_user_info;

DROP TABLE IF EXISTS rp_user_pay_config;

DROP TABLE IF EXISTS rp_user_pay_info;

DROP TABLE IF EXISTS rp_account_check_batch;

DROP TABLE IF EXISTS rp_account_check_mistake;

DROP TABLE IF EXISTS rp_account_check_mistake_scratch_pool;

DROP TABLE IF EXISTS rp_notify_record;

DROP TABLE IF EXISTS rp_notify_record_log;

DROP TABLE IF EXISTS rp_refund_record;

DROP TABLE IF EXISTS rp_trade_payment_order;

DROP TABLE IF EXISTS rp_trade_payment_record;

DROP TABLE IF EXISTS seq_table;

/*==============================================================*/
/* table: rp_account                                            */
/*==============================================================*/
CREATE TABLE rp_account
(
  id             VARCHAR(50)    NOT NULL,
  create_time    DATETIME       NOT NULL,
  edit_time      DATETIME,
  version        BIGINT         NOT NULL,
  remark         VARCHAR(200),
  account_no     VARCHAR(50)    NOT NULL,
  balance        DECIMAL(20, 6) NOT NULL,
  unbalance      DECIMAL(20, 6) NOT NULL,
  security_money DECIMAL(20, 6) NOT NULL,
  status         VARCHAR(36)    NOT NULL,
  total_income   DECIMAL(20, 6) NOT NULL,
  total_expend   DECIMAL(20, 6) NOT NULL,
  today_income   DECIMAL(20, 6) NOT NULL,
  today_expend   DECIMAL(20, 6) NOT NULL,
  account_type   VARCHAR(50)    NOT NULL,
  sett_amount    DECIMAL(20, 6) NOT NULL,
  user_no        VARCHAR(50),
  PRIMARY KEY (id)
);

ALTER TABLE rp_account
  COMMENT '资金账户表';

/*==============================================================*/
/* table: rp_account_history                                    */
/*==============================================================*/
CREATE TABLE rp_account_history
(
  id               VARCHAR(50)    NOT NULL,
  create_time      DATETIME       NOT NULL,
  edit_time        DATETIME,
  version          BIGINT         NOT NULL,
  remark           VARCHAR(200),
  account_no       VARCHAR(50)    NOT NULL,
  amount           DECIMAL(20, 6) NOT NULL,
  balance          DECIMAL(20, 6) NOT NULL,
  fund_direction   VARCHAR(36)    NOT NULL,
  is_allow_sett    VARCHAR(36)    NOT NULL,
  is_complete_sett VARCHAR(36)    NOT NULL,
  request_no       VARCHAR(36)    NOT NULL,
  bank_trx_no      VARCHAR(30),
  trx_type         VARCHAR(36)    NOT NULL,
  risk_day         INT,
  user_no          VARCHAR(50),
  PRIMARY KEY (id)
);

ALTER TABLE rp_account_history
  COMMENT '资金账户流水表';

/*==============================================================*/
/* table: rp_pay_product                                        */
/*==============================================================*/
CREATE TABLE rp_pay_product
(
  id           VARCHAR(50)  NOT NULL,
  create_time  DATETIME     NOT NULL,
  edit_time    DATETIME,
  version      BIGINT       NOT NULL,
  status       VARCHAR(36)  NOT NULL,
  product_code VARCHAR(50)  NOT NULL
  COMMENT '支付产品编号',
  product_name VARCHAR(200) NOT NULL
  COMMENT '支付产品名称',
  audit_status VARCHAR(45),
  PRIMARY KEY (id)
);

ALTER TABLE rp_pay_product
  COMMENT '支付产品表';

/*==============================================================*/
/* table: rp_pay_way                                            */
/*==============================================================*/
CREATE TABLE rp_pay_way
(
  id               VARCHAR(50)  NOT NULL
  COMMENT 'id',
  version          BIGINT       NOT NULL DEFAULT 0
  COMMENT 'version',
  create_time      DATETIME     NOT NULL
  COMMENT '创建时间',
  edit_time        DATETIME COMMENT '修改时间',
  pay_way_code     VARCHAR(50)  NOT NULL
  COMMENT '支付方式编号',
  pay_way_name     VARCHAR(100) NOT NULL
  COMMENT '支付方式名称',
  pay_type_code    VARCHAR(50)  NOT NULL
  COMMENT '支付类型编号',
  pay_type_name    VARCHAR(100) NOT NULL
  COMMENT '支付类型名称',
  pay_product_code VARCHAR(50) COMMENT '支付产品编号',
  status           VARCHAR(36)  NOT NULL
  COMMENT '状态(100:正常状态,101非正常状态)',
  sorts            INT                   DEFAULT 1000
  COMMENT '排序(倒序排序,默认值1000)',
  pay_rate         DOUBLE       NOT NULL
  COMMENT '商户支付费率',
  PRIMARY KEY (id)
);

ALTER TABLE rp_pay_way
  COMMENT '支付方式';

/*==============================================================*/
/* table: rp_sett_daily_collect                                 */
/*==============================================================*/
CREATE TABLE rp_sett_daily_collect
(
  id           VARCHAR(50)     NOT NULL
  COMMENT 'id',
  version      INT             NOT NULL DEFAULT 0
  COMMENT '版本号',
  create_time  DATETIME        NOT NULL
  COMMENT '创建时间',
  edit_time    DATETIME        NOT NULL
  COMMENT '修改时间',
  account_no   VARCHAR(20)     NOT NULL
  COMMENT '账户编号',
  user_name    VARCHAR(200) COMMENT '用户姓名',
  collect_date DATE            NOT NULL
  COMMENT '汇总日期',
  collect_type VARCHAR(50)     NOT NULL
  COMMENT '汇总类型(参考枚举:settdailycollecttypeenum)',
  total_amount DECIMAL(24, 10) NOT NULL
  COMMENT '交易总金额',
  total_count  INT             NOT NULL
  COMMENT '交易总笔数',
  sett_status  VARCHAR(50)     NOT NULL
  COMMENT '结算状态(参考枚举:settdailycollectstatusenum)',
  remark       VARCHAR(300) COMMENT '备注',
  risk_day     INT COMMENT '风险预存期天数',
  PRIMARY KEY (id)
);

ALTER TABLE rp_sett_daily_collect
  COMMENT '每日待结算汇总';

/*==============================================================*/
/* table: rp_sett_record                                        */
/*==============================================================*/
CREATE TABLE rp_sett_record
(
  id                   VARCHAR(50) NOT NULL
  COMMENT 'id',
  version              INT         NOT NULL DEFAULT 0
  COMMENT '版本号',
  create_time          DATETIME    NOT NULL
  COMMENT '创建时间',
  edit_time            DATETIME    NOT NULL
  COMMENT '修改时间',
  sett_mode            VARCHAR(50) COMMENT '结算发起方式(参考settmodetypeenum)',
  account_no           VARCHAR(20) NOT NULL
  COMMENT '账户编号',
  user_no              VARCHAR(20) COMMENT '用户编号',
  user_name            VARCHAR(200) COMMENT '用户姓名',
  user_type            VARCHAR(50) COMMENT '用户类型',
  sett_date            DATE COMMENT '结算日期',
  bank_code            VARCHAR(20) COMMENT '银行编码',
  bank_name            VARCHAR(100) COMMENT '银行名称',
  bank_account_name    VARCHAR(60) COMMENT '开户名',
  bank_account_no      VARCHAR(20) COMMENT '开户账户',
  bank_account_type    VARCHAR(50) COMMENT '开户账户',
  country              VARCHAR(200) COMMENT '开户行所在国家',
  province             VARCHAR(50) COMMENT '开户行所在省份',
  city                 VARCHAR(50) COMMENT '开户行所在城市',
  areas                VARCHAR(50) COMMENT '开户行所在区',
  bank_account_address VARCHAR(300) COMMENT '开户行全称',
  mobile_no            VARCHAR(20) COMMENT '收款人手机号',
  sett_amount          DECIMAL(24, 10) COMMENT '结算金额',
  sett_fee             DECIMAL(16, 6) COMMENT '结算手续费',
  remit_amount         DECIMAL(16, 2) COMMENT '结算打款金额',
  sett_status          VARCHAR(50) COMMENT '结算状态(参考枚举:settrecordstatusenum)',
  remit_confirm_time   DATETIME COMMENT '打款确认时间',
  remark               VARCHAR(200) COMMENT '描述',
  remit_remark         VARCHAR(200) COMMENT '打款备注',
  operator_loginname   VARCHAR(50) COMMENT '操作员登录名',
  operator_realname    VARCHAR(50) COMMENT '操作员姓名',
  PRIMARY KEY (id)
);

ALTER TABLE rp_sett_record
  COMMENT '结算记录';

/*==============================================================*/
/* table: rp_sett_record_annex                                  */
/*==============================================================*/
CREATE TABLE rp_sett_record_annex
(
  id            VARCHAR(50)  NOT NULL,
  create_time   DATETIME     NOT NULL,
  edit_time     DATETIME,
  version       BIGINT       NOT NULL,
  remark        VARCHAR(200),
  is_delete     VARCHAR(36)  NOT NULL,
  annex_name    VARCHAR(200),
  annex_address VARCHAR(500) NOT NULL,
  settlement_id VARCHAR(50)  NOT NULL,
  PRIMARY KEY (id)
);

/*==============================================================*/
/* table: rp_user_bank_account                                  */
/*==============================================================*/
CREATE TABLE rp_user_bank_account
(
  id                VARCHAR(50)  NOT NULL,
  create_time       DATETIME     NOT NULL,
  edit_time         DATETIME,
  version           BIGINT       NOT NULL,
  remark            VARCHAR(200),
  status            VARCHAR(36)  NOT NULL,
  user_no           VARCHAR(50)  NOT NULL,
  bank_name         VARCHAR(200) NOT NULL,
  bank_code         VARCHAR(50)  NOT NULL,
  bank_account_name VARCHAR(100) NOT NULL,
  bank_account_no   VARCHAR(36)  NOT NULL,
  card_type         VARCHAR(36)  NOT NULL,
  card_no           VARCHAR(36)  NOT NULL,
  mobile_no         VARCHAR(50)  NOT NULL,
  is_default        VARCHAR(36),
  province          VARCHAR(20),
  city              VARCHAR(20),
  areas             VARCHAR(20),
  street            VARCHAR(300),
  bank_account_type VARCHAR(36)  NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE rp_user_bank_account
  COMMENT '用户银行账户表';

/*==============================================================*/
/* table: rp_user_info                                          */
/*==============================================================*/
CREATE TABLE rp_user_info
(
  id          VARCHAR(50) NOT NULL,
  create_time DATETIME    NOT NULL,
  status      VARCHAR(36) NOT NULL,
  user_no     VARCHAR(50),
  user_name   VARCHAR(100),
  account_no  VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY ak_key_2 (account_no)
);

ALTER TABLE rp_user_info
  COMMENT '该表用来存放用户的基本信息';

/*==============================================================*/
/* table: rp_user_pay_config                                    */
/*==============================================================*/
CREATE TABLE rp_user_pay_config
(
  id             VARCHAR(50)  NOT NULL,
  create_time    DATETIME     NOT NULL,
  edit_time      DATETIME,
  version        BIGINT       NOT NULL,
  remark         VARCHAR(200),
  status         VARCHAR(36)  NOT NULL,
  audit_status   VARCHAR(45),
  is_auto_sett   VARCHAR(36)  NOT NULL DEFAULT 'no',
  product_code   VARCHAR(50)  NOT NULL
  COMMENT '支付产品编号',
  product_name   VARCHAR(200) NOT NULL
  COMMENT '支付产品名称',
  user_no        VARCHAR(50),
  user_name      VARCHAR(100),
  risk_day       INT,
  pay_key        VARCHAR(50),
  fund_into_type VARCHAR(50),
  pay_secret     VARCHAR(50),
  PRIMARY KEY (id)
);

ALTER TABLE rp_user_pay_config
  COMMENT '支付设置表';

/*==============================================================*/
/* table: rp_user_pay_info                                      */
/*==============================================================*/
CREATE TABLE rp_user_pay_info
(
  id_          VARCHAR(50)  NOT NULL,
  create_time  DATETIME     NOT NULL,
  edit_time    DATETIME,
  version      BIGINT       NOT NULL,
  remark       VARCHAR(200),
  status       VARCHAR(36)  NOT NULL,
  app_id       VARCHAR(50)  NOT NULL,
  app_sectet   VARCHAR(100),
  merchant_id  VARCHAR(50),
  app_type     VARCHAR(50),
  user_no      VARCHAR(50),
  user_name    VARCHAR(100),
  partner_key  VARCHAR(100),
  pay_way_code VARCHAR(50)  NOT NULL
  COMMENT '支付方式编号',
  pay_way_name VARCHAR(100) NOT NULL
  COMMENT '支付方式名称',
  PRIMARY KEY (id_)
);

ALTER TABLE rp_user_pay_info
  COMMENT '该表用来存放用户开通的第三方支付信息';


CREATE TABLE rp_account_check_batch
(
  id                      VARCHAR(50)  NOT NULL,
  version                 INT UNSIGNED NOT NULL,
  create_time             DATETIME     NOT NULL,
  editor                  VARCHAR(100) COMMENT '修改者',
  creater                 VARCHAR(100) COMMENT '创建者',
  edit_time               DATETIME COMMENT '最后修改时间',
  status                  VARCHAR(30)  NOT NULL,
  remark                  VARCHAR(500),
  batch_no                VARCHAR(30)  NOT NULL,
  bill_date               DATE         NOT NULL,
  bill_type               VARCHAR(30),
  handle_status           VARCHAR(10),
  bank_type               VARCHAR(30),
  mistake_count           INT(8),
  unhandle_mistake_count  INT(8),
  trade_count             INT(8),
  bank_trade_count        INT(8),
  trade_amount            DECIMAL(20, 6),
  bank_trade_amount       DECIMAL(20, 6),
  refund_amount           DECIMAL(20, 6),
  bank_refund_amount      DECIMAL(20, 6),
  bank_fee                DECIMAL(20, 6),
  org_check_file_path     VARCHAR(500),
  release_check_file_path VARCHAR(500),
  release_status          VARCHAR(15),
  check_fail_msg          VARCHAR(300),
  bank_err_msg            VARCHAR(300),
  PRIMARY KEY (id)
);

ALTER TABLE rp_account_check_batch
  COMMENT '对账批次表 rp_account_check_batch';

CREATE TABLE rp_account_check_mistake
(
  id                     VARCHAR(50)  NOT NULL,
  version                INT UNSIGNED NOT NULL,
  create_time            DATETIME     NOT NULL,
  editor                 VARCHAR(100) COMMENT '修改者',
  creater                VARCHAR(100) COMMENT '创建者',
  edit_time              DATETIME COMMENT '最后修改时间',
  status                 VARCHAR(30),
  remark                 VARCHAR(500),
  account_check_batch_no VARCHAR(50)  NOT NULL,
  bill_date              DATE         NOT NULL,
  bank_type              VARCHAR(30)  NOT NULL,
  order_time             DATETIME,
  merchant_name          VARCHAR(100),
  merchant_no            VARCHAR(50),
  order_no               VARCHAR(40),
  trade_time             DATETIME,
  trx_no                 VARCHAR(20),
  order_amount           DECIMAL(20, 6),
  refund_amount          DECIMAL(20, 6),
  trade_status           VARCHAR(30),
  fee                    DECIMAL(20, 6),
  bank_trade_time        DATETIME,
  bank_order_no          VARCHAR(40),
  bank_trx_no            VARCHAR(40),
  bank_trade_status      VARCHAR(30),
  bank_amount            DECIMAL(20, 6),
  bank_refund_amount     DECIMAL(20, 6),
  bank_fee               DECIMAL(20, 6),
  err_type               VARCHAR(30)  NOT NULL,
  handle_status          VARCHAR(10)  NOT NULL,
  handle_value           VARCHAR(1000),
  handle_remark          VARCHAR(1000),
  operator_name          VARCHAR(100),
  operator_account_no    VARCHAR(50),
  PRIMARY KEY (id)
);

ALTER TABLE rp_account_check_mistake
  COMMENT '对账差错表 rp_account_check_mistake';

CREATE TABLE rp_account_check_mistake_scratch_pool
(
  id                    VARCHAR(50)  NOT NULL,
  version               INT UNSIGNED NOT NULL,
  create_time           DATETIME     NOT NULL,
  editor                VARCHAR(100) COMMENT '修改者',
  creater               VARCHAR(100) COMMENT '创建者',
  edit_time             DATETIME COMMENT '最后修改时间',
  product_name          VARCHAR(50) COMMENT '商品名称',
  merchant_order_no     VARCHAR(30)  NOT NULL
  COMMENT '商户订单号',
  trx_no                CHAR(20)     NOT NULL
  COMMENT '支付流水号',
  bank_order_no         CHAR(20) COMMENT '银行订单号',
  bank_trx_no           VARCHAR(30) COMMENT '银行流水号',
  order_amount          DECIMAL(20, 6) DEFAULT 0
  COMMENT '订单金额',
  plat_income           DECIMAL(20, 6) COMMENT '平台收入',
  fee_rate              DECIMAL(20, 6) COMMENT '费率',
  plat_cost             DECIMAL(20, 6) COMMENT '平台成本',
  plat_profit           DECIMAL(20, 6) COMMENT '平台利润',
  status                VARCHAR(30) COMMENT '状态(参考枚举:paymentrecordstatusenum)',
  pay_way_code          VARCHAR(50) COMMENT '支付通道编号',
  pay_way_name          VARCHAR(100) COMMENT '支付通道名称',
  pay_success_time      DATETIME COMMENT '支付成功时间',
  complete_time         DATETIME COMMENT '完成时间',
  is_refund             VARCHAR(30)    DEFAULT '101'
  COMMENT '是否退款(100:是,101:否,默认值为:101)',
  refund_times          SMALLINT       DEFAULT 0
  COMMENT '退款次数(默认值为:0)',
  success_refund_amount DECIMAL(20, 6) COMMENT '成功退款总金额',
  remark                VARCHAR(500) COMMENT '备注',
  batch_no              VARCHAR(50),
  bill_date             DATETIME
);

ALTER TABLE rp_account_check_mistake_scratch_pool
  COMMENT '差错暂存池';

CREATE TABLE rp_notify_record
(
  id                 VARCHAR(50)   NOT NULL,
  version            INT           NOT NULL,
  create_time        DATETIME      NOT NULL,
  editor             VARCHAR(100) COMMENT '修改者',
  creater            VARCHAR(100) COMMENT '创建者',
  edit_time          DATETIME COMMENT '最后修改时间',
  notify_times       INT           NOT NULL,
  limit_notify_times INT           NOT NULL,
  url                VARCHAR(2000) NOT NULL,
  merchant_order_no  VARCHAR(50)   NOT NULL,
  merchant_no        VARCHAR(50)   NOT NULL,
  status             VARCHAR(50)   NOT NULL
  COMMENT '100:成功 101:失败',
  notify_type        VARCHAR(30) COMMENT '通知类型',
  PRIMARY KEY (id),
  KEY ak_key_2 (merchant_order_no)
);

ALTER TABLE rp_notify_record
  COMMENT '通知记录表 rp_notify_record';

CREATE TABLE rp_notify_record_log
(
  id                VARCHAR(50)   NOT NULL,
  version           INT           NOT NULL,
  editor            VARCHAR(100) COMMENT '修改者',
  creater           VARCHAR(100) COMMENT '创建者',
  edit_time         DATETIME COMMENT '最后修改时间',
  create_time       DATETIME      NOT NULL,
  notify_id         VARCHAR(50)   NOT NULL,
  request           VARCHAR(2000) NOT NULL,
  response          VARCHAR(2000) NOT NULL,
  merchant_no       VARCHAR(50)   NOT NULL,
  merchant_order_no VARCHAR(50)   NOT NULL
  COMMENT '商户订单号',
  http_status       VARCHAR(50)   NOT NULL
  COMMENT 'http状态',
  PRIMARY KEY (id)
);

ALTER TABLE rp_notify_record_log
  COMMENT '通知记录日志表 rp_notify_record_log';

CREATE TABLE rp_refund_record
(
  id                      VARCHAR(50)  NOT NULL
  COMMENT 'id',
  version                 INT          NOT NULL
  COMMENT '版本号',
  create_time             DATETIME COMMENT '创建时间',
  editor                  VARCHAR(100) COMMENT '修改者',
  creater                 VARCHAR(100) COMMENT '创建者',
  edit_time               DATETIME COMMENT '最后修改时间',
  org_merchant_order_no   VARCHAR(50) COMMENT '原商户订单号',
  org_trx_no              VARCHAR(50) COMMENT '原支付流水号',
  org_bank_order_no       VARCHAR(50) COMMENT '原银行订单号',
  org_bank_trx_no         VARCHAR(50) COMMENT '原银行流水号',
  merchant_name           VARCHAR(100) COMMENT '商家名称',
  merchant_no             VARCHAR(100) NOT NULL
  COMMENT '商家编号',
  org_product_name        VARCHAR(60) COMMENT '原商品名称',
  org_biz_type            VARCHAR(30) COMMENT '原业务类型',
  org_payment_type        VARCHAR(30) COMMENT '原支付方式类型',
  refund_amount           DECIMAL(20, 6) COMMENT '订单退款金额',
  refund_trx_no           VARCHAR(50)  NOT NULL
  COMMENT '退款流水号',
  refund_order_no         VARCHAR(50)  NOT NULL
  COMMENT '退款订单号',
  bank_refund_order_no    VARCHAR(50) COMMENT '银行退款订单号',
  bank_refund_trx_no      VARCHAR(30) COMMENT '银行退款流水号',
  result_notify_url       VARCHAR(500) COMMENT '退款结果通知url',
  refund_status           VARCHAR(30) COMMENT '退款状态',
  refund_from             VARCHAR(30) COMMENT '退款来源（分发平台）',
  refund_way              VARCHAR(30) COMMENT '退款方式',
  refund_request_time     DATETIME COMMENT '退款请求时间',
  refund_success_time     DATETIME COMMENT ' 退款成功时间',
  refund_complete_time    DATETIME COMMENT '退款完成时间',
  request_apply_user_id   VARCHAR(50) COMMENT '退款请求,申请人登录名',
  request_apply_user_name VARCHAR(90) COMMENT '退款请求,申请人姓名',
  refund_reason           VARCHAR(500) COMMENT '退款原因',
  remark                  VARCHAR(3000) COMMENT '备注',
  PRIMARY KEY (id),
  UNIQUE KEY ak_key_2 (refund_trx_no)
);

ALTER TABLE rp_refund_record
  COMMENT '退款记录表';

CREATE TABLE rp_trade_payment_order
(
  id                    VARCHAR(50)  NOT NULL
  COMMENT 'id',
  version               INT          NOT NULL DEFAULT 0
  COMMENT '版本号',
  create_time           DATETIME     NOT NULL
  COMMENT '创建时间',
  editor                VARCHAR(100) COMMENT '修改者',
  creater               VARCHAR(100) COMMENT '创建者',
  edit_time             DATETIME COMMENT '最后修改时间',
  status                VARCHAR(50) COMMENT '状态(参考枚举:orderstatusenum)',
  product_name          VARCHAR(300) COMMENT '商品名称',
  merchant_order_no     VARCHAR(30)  NOT NULL
  COMMENT '商户订单号',
  order_amount          DECIMAL(20, 6)        DEFAULT 0
  COMMENT '订单金额',
  order_from            VARCHAR(30) COMMENT '订单来源',
  merchant_name         VARCHAR(100) COMMENT '商家名称',
  merchant_no           VARCHAR(100) NOT NULL
  COMMENT '商户编号',
  order_time            DATETIME COMMENT '下单时间',
  order_date            DATE COMMENT '下单日期',
  order_ip              VARCHAR(50) COMMENT '下单ip(客户端ip,在网关页面获取)',
  order_referer_url     VARCHAR(100) COMMENT '从哪个页面链接过来的(可用于防诈骗)',
  return_url            VARCHAR(600) COMMENT '页面回调通知url',
  notify_url            VARCHAR(600) COMMENT '后台异步通知url',
  cancel_reason         VARCHAR(600) COMMENT '订单撤销原因',
  order_period          SMALLINT COMMENT '订单有效期(单位分钟)',
  expire_time           DATETIME COMMENT '到期时间',
  pay_way_code          VARCHAR(50) COMMENT '支付方式编号',
  pay_way_name          VARCHAR(100) COMMENT '支付方式名称',
  remark                VARCHAR(200) COMMENT '支付备注',
  trx_type              VARCHAR(30) COMMENT '交易业务类型  ：消费、充值等',
  trx_no                VARCHAR(50) COMMENT '支付流水号',
  pay_type_code         VARCHAR(50) COMMENT '支付类型编号',
  pay_type_name         VARCHAR(100) COMMENT '支付类型名称',
  fund_into_type        VARCHAR(30) COMMENT '资金流入类型',
  is_refund             VARCHAR(30)           DEFAULT '101'
  COMMENT '是否退款(100:是,101:否,默认值为:101)',
  refund_times          INT                   DEFAULT 0
  COMMENT '退款次数(默认值为:0)',
  success_refund_amount DECIMAL(20, 6) COMMENT '成功退款总金额',
  field1                VARCHAR(500),
  field2                VARCHAR(500),
  field3                VARCHAR(500),
  field4                VARCHAR(500),
  field5                VARCHAR(500),
  PRIMARY KEY (id),
  UNIQUE KEY ak_key_2 (merchant_order_no, merchant_no)
);

ALTER TABLE rp_trade_payment_order
  COMMENT 'roncoo pay 龙果支付 支付订单表';

CREATE TABLE rp_trade_payment_record
(
  id                    VARCHAR(50) NOT NULL
  COMMENT 'id',
  version               INT         NOT NULL DEFAULT 0
  COMMENT '版本号',
  create_time           DATETIME COMMENT '创建时间',
  status                VARCHAR(30) COMMENT '状态(参考枚举:paymentrecordstatusenum)',
  editor                VARCHAR(100) COMMENT '修改者',
  creater               VARCHAR(100) COMMENT '创建者',
  edit_time             DATETIME COMMENT '最后修改时间',
  product_name          VARCHAR(50) COMMENT '商品名称',
  merchant_order_no     VARCHAR(50) NOT NULL
  COMMENT '商户订单号',
  trx_no                VARCHAR(50) NOT NULL
  COMMENT '支付流水号',
  bank_order_no         VARCHAR(50) COMMENT '银行订单号',
  bank_trx_no           VARCHAR(50) COMMENT '银行流水号',
  merchant_name         VARCHAR(300) COMMENT '商家名称',
  merchant_no           VARCHAR(50) NOT NULL
  COMMENT '商家编号',
  payer_user_no         VARCHAR(50) COMMENT '付款人编号',
  payer_name            VARCHAR(60) COMMENT '付款人名称',
  payer_pay_amount      DECIMAL(20, 6)       DEFAULT 0
  COMMENT '付款方支付金额',
  payer_fee             DECIMAL(20, 6)       DEFAULT 0
  COMMENT '付款方手续费',
  payer_account_type    VARCHAR(30) COMMENT '付款方账户类型(参考账户类型枚举:accounttypeenum)',
  receiver_user_no      VARCHAR(15) COMMENT '收款人编号',
  receiver_name         VARCHAR(60) COMMENT '收款人名称',
  receiver_pay_amount   DECIMAL(20, 6)       DEFAULT 0
  COMMENT '收款方支付金额',
  receiver_fee          DECIMAL(20, 6)       DEFAULT 0
  COMMENT '收款方手续费',
  receiver_account_type VARCHAR(30) COMMENT '收款方账户类型(参考账户类型枚举:accounttypeenum)',
  order_ip              VARCHAR(30) COMMENT '下单ip(客户端ip,从网关中获取)',
  order_referer_url     VARCHAR(100) COMMENT '从哪个页面链接过来的(可用于防诈骗)',
  order_amount          DECIMAL(20, 6)       DEFAULT 0
  COMMENT '订单金额',
  plat_income           DECIMAL(20, 6) COMMENT '平台收入',
  fee_rate              DECIMAL(20, 6) COMMENT '费率',
  plat_cost             DECIMAL(20, 6) COMMENT '平台成本',
  plat_profit           DECIMAL(20, 6) COMMENT '平台利润',
  return_url            VARCHAR(600) COMMENT '页面回调通知url',
  notify_url            VARCHAR(600) COMMENT '后台异步通知url',
  pay_way_code          VARCHAR(50) COMMENT '支付方式编号',
  pay_way_name          VARCHAR(100) COMMENT '支付方式名称',
  pay_success_time      DATETIME COMMENT '支付成功时间',
  complete_time         DATETIME COMMENT '完成时间',
  is_refund             VARCHAR(30)          DEFAULT '101'
  COMMENT '是否退款(100:是,101:否,默认值为:101)',
  refund_times          INT                  DEFAULT 0
  COMMENT '退款次数(默认值为:0)',
  success_refund_amount DECIMAL(20, 6) COMMENT '成功退款总金额',
  trx_type              VARCHAR(30) COMMENT '交易业务类型  ：消费、充值等',
  order_from            VARCHAR(30) COMMENT '订单来源',
  pay_type_code         VARCHAR(50) COMMENT '支付类型编号',
  pay_type_name         VARCHAR(100) COMMENT '支付类型名称',
  fund_into_type        VARCHAR(30) COMMENT '资金流入类型',
  remark                VARCHAR(3000) COMMENT '备注',
  field1                VARCHAR(500),
  field2                VARCHAR(500),
  field3                VARCHAR(500),
  field4                VARCHAR(500),
  field5                VARCHAR(500),
  bank_return_msg       VARCHAR(2000) COMMENT '银行返回信息',
  PRIMARY KEY (id),
  UNIQUE KEY ak_key_2 (trx_no)
);

ALTER TABLE rp_trade_payment_record
  COMMENT '支付记录表';

CREATE TABLE seq_table (
  seq_name      VARCHAR(50)                 NOT NULL,
  current_value BIGINT DEFAULT '1000000002' NOT NULL,
  increment     SMALLINT DEFAULT '1'        NOT NULL,
  remark        VARCHAR(100)                NOT NULL,
  PRIMARY KEY (seq_name)
)
  ENGINE = innodb
  DEFAULT CHARSET = utf8;
INSERT INTO seq_table (seq_name, current_value, increment, remark) VALUES ('ACCOUNT_NO_SEQ', 10000000, 1, '账户--账户编号');
INSERT INTO seq_table (seq_name, current_value, increment, remark) VALUES ('ACTIVITY_NO_SEQ', 10000006, 1, '活动--活动编号');
INSERT INTO seq_table (seq_name, current_value, increment, remark) VALUES ('USER_NO_SEQ', 10001113, 1, '用户--用户编号');
INSERT INTO seq_table (seq_name, current_value, increment, remark) VALUES ('TRX_NO_SEQ', 10000000, 1, '交易—-支付流水号');
INSERT INTO seq_table (seq_name, current_value, increment, remark)
VALUES ('BANK_ORDER_NO_SEQ', 10000000, 1, '交易—-银行订单号');
INSERT INTO seq_table (seq_name, current_value, increment, remark)
VALUES ('RECONCILIATION_BATCH_NO_SEQ', 10000000, 1, '对账—-批次号');

/*==============================================================*/
/* create function                                              */
/*==============================================================*/
CREATE FUNCTION `fun_seq`(seq VARCHAR(50))
  RETURNS BIGINT(20)
  BEGIN
    UPDATE seq_table
    SET current_value = current_value + increment
    WHERE seq_name = seq;
    RETURN fun_seq_current_value(seq);
  END;


CREATE FUNCTION `fun_seq_current_value`(seq VARCHAR(50))
  RETURNS BIGINT(20)
  BEGIN
    DECLARE value INTEGER;
    SET value = 0;
    SELECT current_value
    INTO value
    FROM seq_table
    WHERE seq_name = seq;
    RETURN value;
  END;

CREATE FUNCTION `fun_seq_set_value`(seq VARCHAR(50), value INTEGER)
  RETURNS BIGINT(20)
  BEGIN
    UPDATE seq_table
    SET current_value = value
    WHERE seq_name = seq;
    RETURN fun_seq_current_value(seq);
  END;

CREATE FUNCTION fun_now()
  RETURNS DATETIME
  BEGIN
    RETURN now();
  END;

-- 时间函数

CREATE FUNCTION `fun_date_add`(str_date VARCHAR(10), str_interval INTEGER)
  RETURNS DATE
  BEGIN
    RETURN date_add(str_date, INTERVAL str_interval DAY);
  END;

-- -----------------------------------------------------------------------------------------------------------------------------------
--                                   注意：该脚本运行在mysql环境下，如果是其他数据库，如有需要请先修改，再执行。                    --
--                                                                                           编写人：沈佳龙   （www.roncoo.com）    --
-- -----------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS pms_menu;

DROP TABLE IF EXISTS pms_menu_role;

DROP TABLE IF EXISTS pms_operator;

DROP TABLE IF EXISTS pms_operator_log;

DROP TABLE IF EXISTS pms_permission;

DROP TABLE IF EXISTS pms_role;

DROP TABLE IF EXISTS pms_role_operator;

DROP TABLE IF EXISTS pms_role_permission;

CREATE TABLE pms_menu
(
  id          BIGINT      NOT NULL AUTO_INCREMENT,
  version     BIGINT      NOT NULL,
  creater     VARCHAR(50) NOT NULL
  COMMENT '创建人',
  create_time DATETIME    NOT NULL
  COMMENT '创建时间',
  editor      VARCHAR(50) COMMENT '修改人',
  edit_time   DATETIME COMMENT '修改时间',
  status      VARCHAR(20) NOT NULL,
  remark      VARCHAR(300),
  is_leaf     VARCHAR(20),
  level       SMALLINT,
  parent_id   BIGINT      NOT NULL,
  target_name VARCHAR(100),
  number      VARCHAR(20),
  name        VARCHAR(100),
  url         VARCHAR(100),
  PRIMARY KEY (id)
)
  AUTO_INCREMENT = 1000;

ALTER TABLE pms_menu
  COMMENT '菜单表';


ALTER TABLE pms_menu
  COMMENT '菜单表';

CREATE TABLE pms_menu_role
(
  id          BIGINT NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  version     BIGINT,
  creater     VARCHAR(50) COMMENT '创建人',
  create_time DATETIME COMMENT '创建时间',
  editor      VARCHAR(50) COMMENT '修改人',
  edit_time   DATETIME COMMENT '修改时间',
  status      VARCHAR(20),
  remark      VARCHAR(300),
  role_id     BIGINT NOT NULL,
  menu_id     BIGINT NOT NULL,
  PRIMARY KEY (id),
  KEY ak_key_2 (role_id, menu_id)
)
  AUTO_INCREMENT = 1000;

ALTER TABLE pms_menu_role
  COMMENT '权限与角色关联表';

CREATE TABLE pms_operator
(
  id          BIGINT       NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  version     BIGINT       NOT NULL,
  creater     VARCHAR(50)  NOT NULL
  COMMENT '创建人',
  create_time DATETIME     NOT NULL
  COMMENT '创建时间',
  editor      VARCHAR(50) COMMENT '修改人',
  edit_time   DATETIME COMMENT '修改时间',
  status      VARCHAR(20)  NOT NULL,
  remark      VARCHAR(300),
  real_name   VARCHAR(50)  NOT NULL,
  mobile_no   VARCHAR(15)  NOT NULL,
  login_name  VARCHAR(50)  NOT NULL,
  login_pwd   VARCHAR(256) NOT NULL,
  type        VARCHAR(20)  NOT NULL,
  salt        VARCHAR(50)  NOT NULL,
  PRIMARY KEY (id),
  KEY ak_key_2 (login_name)
)
  AUTO_INCREMENT = 1000;

ALTER TABLE pms_operator
  COMMENT '操作员表';

CREATE TABLE pms_operator_log
(
  id            BIGINT       NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  version       BIGINT       NOT NULL,
  creater       VARCHAR(50)  NOT NULL
  COMMENT '创建人',
  create_time   DATETIME     NOT NULL
  COMMENT '创建时间',
  editor        VARCHAR(50) COMMENT '修改人',
  edit_time     DATETIME COMMENT '修改时间',
  status        VARCHAR(20)  NOT NULL,
  remark        VARCHAR(300),
  operator_id   BIGINT       NOT NULL,
  operator_name VARCHAR(50)  NOT NULL,
  operate_type  VARCHAR(50)  NOT NULL
  COMMENT '操作类型（1:增加，2:修改，3:删除，4:查询）',
  ip            VARCHAR(100) NOT NULL,
  content       VARCHAR(3000),
  PRIMARY KEY (id)
)
  AUTO_INCREMENT = 1000;

ALTER TABLE pms_operator_log
  COMMENT '权限_操作员操作日志表';

CREATE TABLE pms_permission
(
  id              BIGINT       NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  version         BIGINT       NOT NULL,
  creater         VARCHAR(50)  NOT NULL
  COMMENT '创建人',
  create_time     DATETIME     NOT NULL
  COMMENT '创建时间',
  editor          VARCHAR(50) COMMENT '修改人',
  edit_time       DATETIME COMMENT '修改时间',
  status          VARCHAR(20)  NOT NULL,
  remark          VARCHAR(300),
  permission_name VARCHAR(100) NOT NULL,
  permission      VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  KEY ak_key_2 (permission),
  KEY ak_key_3 (permission_name)
)
  AUTO_INCREMENT = 1000;

ALTER TABLE pms_permission
  COMMENT '权限表';

CREATE TABLE pms_role
(
  id          BIGINT       NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  version     BIGINT,
  creater     VARCHAR(50) COMMENT '创建人',
  create_time DATETIME COMMENT '创建时间',
  editor      VARCHAR(50) COMMENT '修改人',
  edit_time   DATETIME COMMENT '修改时间',
  status      VARCHAR(20),
  remark      VARCHAR(300),
  role_code   VARCHAR(20)  NOT NULL
  COMMENT '角色类型（1:超级管理员角色，0:普通操作员角色）',
  role_name   VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  KEY ak_key_2 (role_name)
)
  AUTO_INCREMENT = 1000;

ALTER TABLE pms_role
  COMMENT '角色表';

CREATE TABLE pms_role_operator
(
  id          BIGINT      NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  version     BIGINT      NOT NULL,
  creater     VARCHAR(50) NOT NULL
  COMMENT '创建人',
  create_time DATETIME    NOT NULL
  COMMENT '创建时间',
  editor      VARCHAR(50) COMMENT '修改人',
  edit_time   DATETIME COMMENT '修改时间',
  status      VARCHAR(20) NOT NULL,
  remark      VARCHAR(300),
  role_id     BIGINT      NOT NULL,
  operator_id BIGINT      NOT NULL,
  PRIMARY KEY (id),
  KEY ak_key_2 (role_id, operator_id)
)
  AUTO_INCREMENT = 1000;

ALTER TABLE pms_role_operator
  COMMENT '操作员与角色关联表';

CREATE TABLE pms_role_permission
(
  id            BIGINT NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  version       BIGINT,
  creater       VARCHAR(50) COMMENT '创建人',
  create_time   DATETIME COMMENT '创建时间',
  editor        VARCHAR(50) COMMENT '修改人',
  edit_time     DATETIME COMMENT '修改时间',
  status        VARCHAR(20),
  remark        VARCHAR(300),
  role_id       BIGINT NOT NULL,
  permission_id BIGINT NOT NULL,
  PRIMARY KEY (id),
  KEY ak_key_2 (role_id, permission_id)
)
  AUTO_INCREMENT = 1000;

ALTER TABLE pms_role_permission
  COMMENT '权限与角色关联表';

-- ------------------------------step 1  菜单-------------------------------------------------
-- 菜单初始化数据
--  -- 菜单的初始化数据
INSERT INTO pms_menu (id, version, status, creater, create_time, editor, edit_time, remark, name, url, number, is_leaf, level, parent_id, target_name)
VALUES
  (1, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '权限管理', '##', '001', 'NO', 1, 0,
   '#'),
  (2, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '菜单管理', 'pms/menu/list', '00101', 'YES', 2, 1, 'cdgl'),
  (3, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '权限管理', 'pms/permission/list', '00102', 'YES', 2, 1, 'qxgl'),
  (4, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '角色管理', 'pms/role/list', '00103', 'YES', 2, 1, 'jsgl'),
  (5, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '操作员管理', 'pms/operator/list', '00104', 'YES', 2, 1, 'czygl'),

  (10, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '账户管理', '##', '002', 'NO', 1, 0, '#'),
  (12, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '账户信息', 'account/list', '00201', 'YES', 2, 10, 'zhxx'),
  (13, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '账户历史信息', 'account/historyList', '00202', 'YES', 2, 10, 'zhlsxx'),


  (20, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '用户管理', '##', '003', 'NO', 1, 0, '#'),
  (22, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '用户信息', 'user/info/list', '00301', 'YES', 2, 20, 'yhxx'),

  (30, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '支付管理', '##', '004', 'NO', 1, 0, '#'),
  (32, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '支付产品信息', 'pay/product/list', '00401', 'YES', 2, 30, 'zfcpgl'),
  (33, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '用户支付配置', 'pay/config/list', '00402', 'YES', 2, 30, 'yhzfpz'),

  (40, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '交易管理', '##', '005', 'NO', 1, 0, '#'),
  (42, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '支付订单管理', 'trade/listPaymentOrder', '00501', 'YES', 2, 40, 'zfddgl'),
  (43, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '支付记录管理', 'trade/listPaymentRecord', '00502', 'YES', 2, 40, 'zfjjgl'),

  (50, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '结算管理', '##', '006', 'NO', 1, 0, '#'),
  (52, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '结算记录管理', 'sett/list', '00601', 'YES', 2, 50, 'jsjlgl'),

  (60, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '对账管理', '##', '007', 'NO', 1, 0, '#'),
  (62, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '对账差错列表', 'reconciliation/list/mistake', '00701', 'YES', 2, 60, 'dzcclb'),
  (63, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '对账批次列表', 'reconciliation/list/checkbatch', '00702', 'YES', 2, 60, 'dzpclb'),
  (64, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '', '对账缓冲池列表',
       'reconciliation/list/scratchPool', '00703', 'YES', 2, 60, 'dzhcclb');

-- ------------------------------step 2：权限功能点-------------------------------------------------
-- 权限功能点的初始化数据


INSERT INTO pms_permission (id, version, status, creater, create_time, editor, edit_time, remark, permission_name, permission)
VALUES
  (1, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-菜单-查看', '权限管理-菜单-查看',
   'pms:menu:view'),
  (2, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-菜单-添加', '权限管理-菜单-添加', 'pms:menu:add'),
  (3, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-菜单-查看', '权限管理-菜单-修改', 'pms:menu:edit'),
  (4, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-菜单-删除', '权限管理-菜单-删除', 'pms:menu:delete'),

  (11, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-权限-查看', '权限管理-权限-查看', 'pms:permission:view'),
  (12, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-权限-添加', '权限管理-权限-添加', 'pms:permission:add'),
  (13, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-权限-修改', '权限管理-权限-修改', 'pms:permission:edit'),
  (14, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-权限-删除', '权限管理-权限-删除', 'pms:permission:delete'),

  (21, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-角色-查看', '权限管理-角色-查看', 'pms:role:view'),
  (22, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-角色-添加', '权限管理-角色-添加', 'pms:role:add'),
  (23, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-角色-修改', '权限管理-角色-修改', 'pms:role:edit'),
  (24, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-角色-删除', '权限管理-角色-删除', 'pms:role:delete'),
  (25, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-角色-分配权限', '权限管理-角色-分配权限', 'pms:role:assignpermission'),

  (31, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-操作员-查看', '权限管理-操作员-查看', 'pms:operator:view'),
  (32, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-操作员-添加', '权限管理-操作员-添加', 'pms:operator:add'),
  (33, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-操作员-查看', '权限管理-操作员-修改', 'pms:operator:edit'),
  (34, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-操作员-冻结与解冻', '权限管理-操作员-冻结与解冻', 'pms:operator:changestatus'),
  (35, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '权限管理-操作员-重置密码', '权限管理-操作员-重置密码', 'pms:operator:resetpwd'),


  (51, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '账户管理-账户-查看', '账户管理-账户-查看', 'account:accountInfo:view'),
  (52, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '账户管理-账户-添加', '账户管理-账户-添加', 'account:accountInfo:add'),
  (53, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '账户管理-账户-查看', '账户管理-账户-修改', 'account:accountInfo:edit'),
  (54, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '账户管理-账户-删除', '账户管理-账户-删除', 'account:accountInfo:delete'),

  (61, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '账户管理-账户历史-查看', '账户管理-账户历史-查看', 'account:accountHistory:view'),

  (71, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '用户管理-用户信息-查看', '用户管理-用户信息-查看', 'user:userInfo:view'),
  (72, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '用户管理-用户信息-添加', '用户管理-用户信息-添加', 'user:userInfo:add'),
  (73, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '用户管理-用户信息-查看', '用户管理-用户信息-修改', 'user:userInfo:edit'),
  (74, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '用户管理-用户信息-删除', '用户管理-用户信息-删除', 'user:userInfo:delete'),

  (81, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付产品-查看', '支付管理-支付产品-查看', 'pay:product:view'),
  (82, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付产品-添加', '支付管理-支付产品-添加', 'pay:product:add'),
  (83, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付产品-查看', '支付管理-支付产品-修改', 'pay:product:edit'),
  (84, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付产品-删除', '支付管理-支付产品-删除', 'pay:product:delete'),

  (85, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付方式-查看', '支付管理-支付方式-查看', 'pay:way:view'),
  (86, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付方式-添加', '支付管理-支付方式-添加', 'pay:way:add'),
  (87, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付方式-查看', '支付管理-支付方式-修改', 'pay:way:edit'),
  (88, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付方式-删除', '支付管理-支付方式-删除', 'pay:way:delete'),

  (91, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付配置-查看', '支付管理-支付配置-查看', 'pay:config:view'),
  (92, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付配置-添加', '支付管理-支付配置-添加', 'pay:config:add'),
  (93, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付配置-查看', '支付管理-支付配置-修改', 'pay:config:edit'),
  (94, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '支付管理-支付配置-删除', '支付管理-支付配置-删除', 'pay:config:delete'),

  (101, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '交易管理-订单-查看', '交易管理-订单-查看', 'trade:order:view'),
  (102, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '交易管理-订单-添加', '交易管理-订单-添加', 'trade:order:add'),
  (103, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '交易管理-订单-查看', '交易管理-订单-修改', 'trade:order:edit'),
  (104, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '交易管理-订单-删除', '交易管理-订单-删除', 'trade:order:delete'),

  (111, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '交易管理-记录-查看', '交易管理-记录-查看', 'trade:record:view'),
  (112, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '交易管理-记录-添加', '交易管理-记录-添加', 'trade:record:add'),
  (113, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '交易管理-记录-查看', '交易管理-记录-修改', 'trade:record:edit'),
  (114, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '交易管理-记录-删除', '交易管理-记录-删除', 'trade:record:delete'),

  (121, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '结算管理-记录-查看', '结算管理-记录-查看', 'sett:record:view'),
  (122, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '结算管理-记录-添加', '结算管理-记录-添加', 'sett:record:add'),
  (123, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '结算管理-记录-查看', '结算管理-记录-修改', 'sett:record:edit'),
  (124, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '结算管理-记录-删除', '结算管理-记录-删除', 'sett:record:delete'),

  (131, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-差错-查看', '对账管理-差错-查看', 'recon:mistake:view'),
  (132, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-差错-添加', '对账管理-差错-添加', 'recon:mistake:add'),
  (133, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-差错-查看', '对账管理-差错-修改', 'recon:mistake:edit'),
  (134, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-差错-删除', '对账管理-差错-删除', 'recon:mistake:delete'),

  (141, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-批次-查看', '对账管理-批次-查看', 'recon:batch:view'),
  (142, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-批次-添加', '对账管理-批次-添加', 'recon:batch:add'),
  (143, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-批次-查看', '对账管理-批次-修改', 'recon:batch:edit'),
  (144, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-批次-删除', '对账管理-批次-删除', 'recon:batch:delete'),

  (151, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-缓冲池-查看', '对账管理-缓冲池-查看', 'recon:scratchPool:view'),
  (152, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-缓冲池-添加', '对账管理-缓冲池-添加', 'recon:scratchPool:add'),
  (153, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-缓冲池-查看', '对账管理-缓冲池-修改',
   'recon:scratchPool:edit'),
  (154, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '对账管理-缓冲池-删除', '对账管理-缓冲池-删除',
   'recon:scratchPool:delete');

-- -----------------------------------step3：操作员--------------------------------------------
-- -- 操作员的初始化数据
--  admin 超级管理员
INSERT INTO pms_operator (id, version, status, creater, create_time, editor, edit_time, remark, login_name, login_pwd, real_name, mobile_no, type, salt)
VALUES (1, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '超级管理员', 'admin',
           'd3c59d25033dbf980d29554025c23a75', '超级管理员', '18620936193', 'ADMIN', '8d78869f470951332959580424d4bf4f');

--  guest  游客
INSERT INTO pms_operator (id, version, status, creater, create_time, editor, edit_time, remark, login_name, login_pwd, real_name, mobile_no, type, salt)
VALUES (2, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'guest', '2016-06-03 11:07:43', '游客', 'guest',
           '3f0dbf580ee39ec03b632cb33935a363', '游客', '18926215592', 'USER', '183d9f2f0f2ce760e98427a5603d1c73');

-- ------------------------------------step4：角色-------------------------------------------
-- -- 角色的初始化数据
INSERT INTO pms_role (id, version, status, creater, create_time, editor, edit_time, remark, role_code, role_name)
VALUES (1, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'admin', '2016-06-03 11:07:43', '超级管理员角色', 'admin', '超级管理员角色');

INSERT INTO pms_role (id, version, status, creater, create_time, editor, edit_time, remark, role_code, role_name)
VALUES (2, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'guest', '2016-06-03 11:07:43', '游客角色', 'guest', '游客角色');

-- ------------------------------------step5：操作员和角色关联-------------------------------------------
-- -- 操作员与角色关联的初始化数据

--  admin  关联admin 和test两个角色
INSERT INTO pms_role_operator (id, version, status, creater, create_time, editor, edit_time, remark, role_id, operator_id)
VALUES (1, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 1, 1);
INSERT INTO pms_role_operator (id, version, status, creater, create_time, editor, edit_time, remark, role_id, operator_id)
VALUES (2, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 1);

-- guest  关联游客角色  （游客角色只有查看交易记录的信息）
INSERT INTO pms_role_operator (id, version, status, creater, create_time, editor, edit_time, remark, role_id, operator_id)
VALUES (3, 0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 2);

-- -------------------------------------step6：角色和权限关联------------------------------------------
-- -- 角色与用户功能点关联的初始化数据

-- admin（拥有所有的权限点）
INSERT INTO pms_role_permission (role_id, permission_id) SELECT
                                                           1,
                                                           id
                                                         FROM pms_permission;

-- guest （只有所有的查看权限）
INSERT INTO pms_role_permission (version, status, creater, create_time, editor, edit_time, remark, role_id, permission_id)
VALUES
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 1),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 11),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 21),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 31),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 41),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 51),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 61),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 71),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 81),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 85),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 91),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 101),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 111),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 121),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 131),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 141),
  (0, 'ACTIVE', 'roncoo', '2016-06-03 11:07:43', 'test', '2016-06-03 11:07:43', '', 2, 151);

-- -------------------------------------step7：角色和菜单关联------------------------------------------
--  角色与信息关联初始化数据
-- admin

INSERT INTO pms_menu_role (role_id, menu_id) SELECT
                                               1,
                                               id
                                             FROM pms_menu;

-- guest  所有的菜单（只有查看权限）
INSERT INTO pms_menu_role (role_id, menu_id) SELECT
                                               2,
                                               id
                                             FROM pms_menu;

-- 2016.8.5 第三方支付信息表增加支付宝线下产品字段
ALTER TABLE rp_user_pay_info
  ADD offline_app_id VARCHAR(50);
ALTER TABLE rp_user_pay_info
  ADD rsa_private_key VARCHAR(100);
ALTER TABLE rp_user_pay_info
  ADD rsa_public_key VARCHAR(100);

-- 2016.9.5 增加登录信息字段
ALTER TABLE rp_user_info
  ADD mobile VARCHAR(15);
ALTER TABLE rp_user_info
  ADD password VARCHAR(50);

-- 2017.4.4 用户信息表增加支付密码字段
ALTER TABLE rp_user_info
  ADD pay_pwd VARCHAR(50) COMMENT '支付密码' DEFAULT '123456';

-- 2017.4.5 增加用户支付配置表安全等级字段 商户服务器IP字段
ALTER TABLE rp_user_pay_config
  ADD security_rating VARCHAR(20) COMMENT '安全等级' DEFAULT 'MD5';

ALTER TABLE rp_user_pay_config
  ADD merchant_server_ip VARCHAR(200) COMMENT '商户服务器IP';