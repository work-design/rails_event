# RailsEvent

RailsEvent 用于处理基于事件、地点、参与人的业务，如：活动举办、课程。


## 说明

预约模型由以下几部分组成：

* 事件，对应model: Plan
* 时间与地点，对应model: PlanTime
* 人物，对应model: PlanParticipant(crowd)

当上述配置完成之后，会根据时间的配置信息（如何按每周、每月等重复），生成具体的数据如下：

* PlanItem：具体的事件发生的时间（date + time_item_id），地点(place)
* PlanAttender(出席人): 具体的事件里的参与人，PlanItem + PlanCrowd


## Installation

```
yarn add moment
yarn add moment-timezone
yarn add @fullcalendar/core
yarn add @fullcalendar/daygrid
yarn add @fullcalendar/timegrid
```


## 许可
本项目采用 [LGPL-3.0](https://opensource.org/licenses/LGPL-3.0) 协议。

基于本项目二次开发之后不允许闭源。

如需商业使用，请联系作者单独授权。

