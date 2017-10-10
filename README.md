# 龙果支付系统

龙果支付系统是国内首款开源的互联网支付系统，其核心目标是汇聚所有主流支付渠道，打造一款轻量、便捷、易用，且集支付、资金对账、资金清结算于一体的支付系统，满足互联网业务系统的收款和业务资金管理需求。

######主要特点：

1. 具备支付系统通用的支付、对账、清算、资金账户管理、支付订单管理等功能；

2. 目前已接通“支付宝即时到账”和“微信扫码支付”通道；

3. 支持直连和间连两种支付模式，任君选择；

4. 通过支付网关，业务系统可以轻松实现统一支付接入；

5. 搭配运营后台，支付数据的监控和管理可以兼得；

6. 配套完善的系统使用文档，可轻松嵌入任何需要支付的场景；

7. 龙果支付系统产品技术团队是一支拥有多年第三方支付系统设计研发经验的团队，会为龙果支付系统持续提供商业级的免费开源技术服务支持。

######项目结构说明：

1. roncoo-pay-app-notify
    主要是通知接入系统的商户提交的订单的状态；

2. roncoo-pay-app-order-polling
    主要是拉取银行或者第三发支付支付结果的信息；

3. roncoo-pay-app-reconciliation
    主要是对账处理，包括拉取对账文件、处理对账文件、进行对账、处理和保存差错记录；

4. roncoo-pay-app-settlement
    主要是按商户来进行结算处理；

5. roncoo-pay-common-core
    存放整个系统通用的一些类或者设置；

6. roncoo-pay-service
    整个支付系统的业务逻辑实现；

7. roncoo-pay-web-boss
    运营管理系统；

8. roncoo-pay-web-gateway
    支付网关；

9. roncoo-pay-web-merchant
    商户后台；

10. roncoo-pay-web-sample-shop
    支付测试展示项目；
----------------------------------------------------------------------------------

######应用架构：
![应用架构](http://git.oschina.net/uploads/images/2016/0726/171546_239efc3b_860625.jpeg "应用架构")

---------

在线支付演示：http://demo.pay.roncoo.com

后台运营管理：http://demo.pay.roncoo.com/boss

系统操作说明：http://www.roncoo.com/article/detail/124375

系统详细介绍：http://www.roncoo.com/article/detail/124373

系统搭建部署：http://www.roncoo.com/article/detail/124511

官方QQ群：287684257，欢迎大家加入，共同探讨互联网金融支付行业业务、技术等。

![Alt text](http://git.oschina.net/uploads/images/2016/0722/175850_9e020e87_860625.png)

 




 

