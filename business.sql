/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.1.73 : Database - product_v30
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`product_v30` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `product_v30`;

/*Table structure for table `cache_log` */

DROP TABLE IF EXISTS `cache_log`;

CREATE TABLE `cache_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prefix` varchar(50) DEFAULT NULL COMMENT 'key的前缀',
  `cache_key` varchar(300) DEFAULT NULL COMMENT 'key值',
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=387 DEFAULT CHARSET=utf8 COMMENT='[2.1]缓存表';

/*Table structure for table `cam1` */

DROP TABLE IF EXISTS `cam1`;

CREATE TABLE `cam1` (
  `CombAnsid` int(11) NOT NULL COMMENT '组合答卷ID',
  `AnsNumber` int(11) NOT NULL COMMENT '答卷编号',
  `AnsTag` char(1) DEFAULT NULL COMMENT '答卷状态：Y-已审核，N-未完成',
  PRIMARY KEY (`CombAnsid`,`AnsNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合答卷关联单份答卷';

/*Table structure for table `cam2` */

DROP TABLE IF EXISTS `cam2`;

CREATE TABLE `cam2` (
  `CombAnsid` int(11) NOT NULL COMMENT '组合答卷ID',
  `LineNum` smallint(6) NOT NULL COMMENT '行号',
  `OptId` smallint(6) DEFAULT NULL COMMENT '选项代码',
  `FunId` smallint(6) NOT NULL COMMENT '功能代码',
  `AuditLevel` smallint(6) DEFAULT NULL COMMENT '审核级别',
  `Docid` int(11) DEFAULT NULL COMMENT '审核医生',
  `AuditDesc` text COMMENT '审核意见',
  `AuditTime` datetime DEFAULT NULL COMMENT '审核时间',
  `AuditMode` char(1) DEFAULT '0' COMMENT '审核方式：0-人工审核，1-批量审核',
  `diagnosis` varchar(255) DEFAULT NULL COMMENT '诊断'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合问卷审核结果';

/*Table structure for table `chat` */

DROP TABLE IF EXISTS `chat`;

CREATE TABLE `chat` (
  `_logid` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `SendType` tinyint(4) NOT NULL COMMENT '发送类型：1-医生，2-会员',
  `Sender` int(11) NOT NULL COMMENT '发送者ID',
  `SenderGUID` char(36) NOT NULL COMMENT '发送者GUID',
  `SendTime` datetime NOT NULL COMMENT '发送时间',
  `ReceiveType` tinyint(4) NOT NULL COMMENT '接收类型：1-医生，2-会员',
  `Receiver` int(11) NOT NULL COMMENT '接收者ID',
  `ReceiverGUID` char(36) NOT NULL COMMENT '接收者GUID',
  `ReceiveTime` datetime DEFAULT NULL COMMENT '接收时间',
  `ContentType` tinyint(4) NOT NULL COMMENT '内容类别：1-文本，2-图片，3-音频，4-视频',
  `Content` text NOT NULL COMMENT '内容',
  `RefType` tinyint(4) DEFAULT NULL COMMENT '[3.0]引用类型：1-健教，2-复诊，3-测量，4-单份问卷，5-组合问卷，6-高血压随访(公卫)，7-糖尿病随访(公卫)',
  `RefID` bigint(20) DEFAULT NULL COMMENT '[3.0]引用表记录ID',
  `RefStatus` tinyint(4) DEFAULT NULL COMMENT '[3.0]引用状态：<类型4和5>1-未答、2-已答、3-已审核、4-已撤回',
  PRIMARY KEY (`_logid`),
  KEY `idx_S` (`Sender`),
  KEY `idx_R` (`Receiver`),
  KEY `idx_RID` (`RefID`)
) ENGINE=InnoDB AUTO_INCREMENT=1944 DEFAULT CHARSET=utf8 COMMENT='[2.1]聊天表';

/*Table structure for table `cqt1` */

DROP TABLE IF EXISTS `cqt1`;

CREATE TABLE `cqt1` (
  `CombQustid` int(11) NOT NULL COMMENT '组合答卷ID',
  `Qustid` int(11) NOT NULL COMMENT '问卷ID号',
  `QustCode` varchar(20) DEFAULT NULL COMMENT '问卷编号',
  `OptId` smallint(6) DEFAULT NULL COMMENT '选项代码',
  `FunId` smallint(6) DEFAULT NULL COMMENT '功能代码',
  `Qustname` varchar(50) DEFAULT NULL COMMENT '问卷名称',
  `QustVer` varchar(20) DEFAULT NULL COMMENT '问卷版本号',
  PRIMARY KEY (`CombQustid`,`Qustid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合问卷关联单份明细';

/*Table structure for table `d_disease_dictionary` */

DROP TABLE IF EXISTS `d_disease_dictionary`;

CREATE TABLE `d_disease_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `disease_id` int(20) DEFAULT NULL COMMENT '疾病id',
  `disease_name` varchar(50) DEFAULT NULL COMMENT '疾病名称',
  `SortNO` int(11) DEFAULT '0' COMMENT '排序号(正序)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `disease_id` (`disease_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='疾病数字字典 ';

/*Table structure for table `d_omem_relation` */

DROP TABLE IF EXISTS `d_omem_relation`;

CREATE TABLE `d_omem_relation` (
  `unique_id` varchar(50) NOT NULL COMMENT '合作方数据标识（如：健康档案号）',
  `logogram` varchar(40) DEFAULT NULL COMMENT '拼音简写 ',
  `relation` int(5) DEFAULT NULL COMMENT '与户主关系 1户主  2.配偶;3.子女;4.(外)孙子女;5.父母;6.(外)祖父母;7.兄弟姐妹;8.儿媳;9.女婿;10.孙子女;11.侄子女;12.曾孙子女;13.祖父母;99.其他',
  `company` varchar(100) DEFAULT NULL COMMENT '工作单位 ',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `village` varchar(50) DEFAULT NULL COMMENT '街道（乡）',
  `neighborhood_committee` varchar(50) DEFAULT NULL COMMENT '居委会 ',
  `live_status` int(5) DEFAULT NULL COMMENT ' 1.本地户籍常住;2.本地户籍不常住;3.外地户籍常住;4.不详;',
  `nation` varchar(20) DEFAULT NULL COMMENT '民族',
  `pay_type` int(5) DEFAULT NULL COMMENT '1.全自费;2.全公费;3.城镇职工基本医疗保险;4.城镇居民基本医疗保险;5.新型农村合作医疗;6.社会医疗保险;7.商业医疗保险;8.贫困救助;99.其他;',
  `medical_account` varchar(100) DEFAULT NULL COMMENT '医疗保险号',
  `agro_account` varchar(60) DEFAULT NULL COMMENT '新农合号',
  `survey_time` datetime DEFAULT NULL COMMENT '调查时间',
  `fetation_status` int(5) DEFAULT NULL COMMENT '怀孕情况  0.未孕;1.已孕未生产;2.已生产(随访期内);2.已生产(随访期外);',
  `certificate_type` int(5) DEFAULT NULL COMMENT '1.身份证;2.护照(外籍人士);3.军官证; ',
  `file_type` int(5) DEFAULT NULL COMMENT '1.城镇;2.农村;',
  `file_status` int(5) DEFAULT '1' COMMENT '1.活动;2.非活动;',
  `prgid` varchar(100) DEFAULT NULL COMMENT '所属机构',
  `other_pay` varchar(100) DEFAULT NULL COMMENT '其他支付方式',
  `family_code` varchar(100) DEFAULT NULL COMMENT '家庭档案编号',
  `belong_area` varchar(100) DEFAULT NULL COMMENT '所属片区',
  `file_status_desc` int(2) DEFAULT NULL COMMENT '档案非活动状态原因，1.死亡;2.失踪;3.迁出;4.其他;5.长期外出',
  `state` int(2) DEFAULT NULL COMMENT '判断状态，1，成功，2，数据连接失败，3，插入数据不匹配',
  PRIMARY KEY (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员档案关联信息表';

/*Table structure for table `dgp1` */

DROP TABLE IF EXISTS `dgp1`;

CREATE TABLE `dgp1` (
  `OdgpId` int(11) NOT NULL COMMENT '分组代码',
  `Docid` int(11) NOT NULL COMMENT '医生代码',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `AuditLevel` smallint(6) DEFAULT NULL COMMENT '审核级别',
  PRIMARY KEY (`OdgpId`,`Docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='医生分组明细';

/*Table structure for table `doc1` */

DROP TABLE IF EXISTS `doc1`;

CREATE TABLE `doc1` (
  `Docid` int(11) NOT NULL AUTO_INCREMENT COMMENT '医生代码',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `DocAcc` varchar(50) DEFAULT NULL COMMENT '登录帐号',
  `DocPass` varchar(50) DEFAULT NULL COMMENT '登录密码',
  `LogRole` char(1) DEFAULT NULL COMMENT '登录角色：1管理员、6超级管理员、5金钥匙、其它是医生',
  `Tag` char(1) DEFAULT NULL COMMENT '标记  ',
  `failTime` datetime DEFAULT NULL COMMENT '最近登入失败时间',
  `failCount` int(11) DEFAULT NULL COMMENT '失败次数',
  `lastLoginAddr` varchar(15) DEFAULT NULL,
  `lastLoginTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Docid`)
) ENGINE=InnoDB AUTO_INCREMENT=493 DEFAULT CHARSET=utf8 COMMENT='医生登录管理表';

/*Table structure for table `doc2` */

DROP TABLE IF EXISTS `doc2`;

CREATE TABLE `doc2` (
  `Docid` int(11) NOT NULL COMMENT '医生代码',
  `MonIntegral` int(11) DEFAULT NULL COMMENT '本月积分',
  `AccIntegral` int(11) DEFAULT NULL COMMENT '累计积分',
  `MonReport` int(11) DEFAULT NULL COMMENT '本月报告数',
  `AccReport` int(11) DEFAULT NULL COMMENT '累计报告数',
  `MonReply` int(11) DEFAULT NULL COMMENT '本月回复咨询',
  `AccReply` int(11) DEFAULT NULL COMMENT '累计回复咨询',
  PRIMARY KEY (`Docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='医生积分表';

/*Table structure for table `doclog` */

DROP TABLE IF EXISTS `doclog`;

CREATE TABLE `doclog` (
  `doctor_id` int(11) NOT NULL COMMENT '医生代码',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `session` varchar(50) DEFAULT NULL COMMENT '令牌',
  `tag` char(1) DEFAULT NULL COMMENT '账号禁用状态',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `device` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='医生登录密码及状态表';

/*Table structure for table `ecg1` */

DROP TABLE IF EXISTS `ecg1`;

CREATE TABLE `ecg1` (
  `Docentry` bigint(20) NOT NULL COMMENT '测量记录号',
  `LineNum` smallint(6) NOT NULL COMMENT '行号',
  `ObjectId` varchar(50) DEFAULT NULL,
  `AbECGType` varchar(50) DEFAULT NULL,
  `AbECGTime` int(11) DEFAULT NULL,
  PRIMARY KEY (`Docentry`,`LineNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='心电测量明细';

/*Table structure for table `ecg2` */

DROP TABLE IF EXISTS `ecg2`;

CREATE TABLE `ecg2` (
  `Docentry` bigint(20) NOT NULL COMMENT '测量记录号',
  `AbnName` varchar(50) NOT NULL COMMENT '心动过速',
  `AbnNum` int(11) DEFAULT NULL COMMENT '二联律',
  PRIMARY KEY (`Docentry`,`AbnName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='心电12种异常';

/*Table structure for table `ecg3` */

DROP TABLE IF EXISTS `ecg3`;

CREATE TABLE `ecg3` (
  `Docentry` bigint(20) NOT NULL,
  `ObjectId` varchar(50) NOT NULL,
  `StartTime` bigint(20) DEFAULT NULL,
  `EndTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ObjectId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `logics` */

DROP TABLE IF EXISTS `logics`;

CREATE TABLE `logics` (
  `questId` int(11) NOT NULL COMMENT '问卷编号',
  `problemId` int(11) NOT NULL COMMENT '问题编号',
  `answerId` int(11) NOT NULL COMMENT '答案编号',
  `problemIds` varchar(255) DEFAULT NULL COMMENT '选择的答案编号后，不做答的题号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单份问卷中问题作答逻辑';

/*Table structure for table `mem1` */

DROP TABLE IF EXISTS `mem1`;

CREATE TABLE `mem1` (
  `Memberid` int(11) NOT NULL COMMENT '会员代码',
  `ContactName` varchar(20) NOT NULL COMMENT '联系人姓名',
  `ContactMobPhone` varchar(50) DEFAULT NULL COMMENT '联系人手机',
  `Relation` varchar(20) DEFAULT NULL COMMENT '关系',
  `MessageTag` char(1) DEFAULT NULL COMMENT '是否接收消息：Y-是，N-否',
  `ReceiveTag` char(1) DEFAULT NULL COMMENT '是否接收回复：Y-是，N-否',
  PRIMARY KEY (`Memberid`,`ContactName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='紧急联系人';

/*Table structure for table `mem2` */

DROP TABLE IF EXISTS `mem2`;

CREATE TABLE `mem2` (
  `Memberid` int(11) NOT NULL COMMENT '会员代码',
  `BloodType` varchar(10) DEFAULT NULL COMMENT '血型',
  `AllergicHis` char(1) DEFAULT 'N' COMMENT '[2.1]过敏史(有或者无)',
  `AllergicHisName` varchar(100) DEFAULT NULL COMMENT '过敏史',
  `Height` int(11) DEFAULT NULL COMMENT '身高(cm)',
  `Weight` decimal(5,2) DEFAULT NULL COMMENT '体重(kg)',
  `Waist` int(11) DEFAULT NULL COMMENT '腰围(cm)',
  `Hip` int(11) DEFAULT NULL COMMENT '臀围(cm)',
  `Pulse` int(11) DEFAULT NULL COMMENT '脉搏',
  `HeartRate` int(11) DEFAULT NULL COMMENT '心率',
  `BloodH` smallint(6) DEFAULT NULL COMMENT '血压',
  `BloodL` smallint(6) DEFAULT NULL COMMENT '舒张压',
  `FastingGlucose` decimal(8,1) DEFAULT NULL COMMENT '空腹血糖',
  `UricAcid` int(11) DEFAULT NULL COMMENT '尿酸',
  `TotalCholesterol` decimal(8,3) DEFAULT NULL COMMENT '总胆固醇',
  `Triglyceride` decimal(8,3) DEFAULT NULL COMMENT '甘油三酯',
  `DensityLipop` decimal(8,3) DEFAULT NULL COMMENT '高密度脂蛋白',
  `LDLip` decimal(8,3) DEFAULT NULL COMMENT '低密度脂蛋白',
  PRIMARY KEY (`Memberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='体格检查';

/*Table structure for table `mem3` */

DROP TABLE IF EXISTS `mem3`;

CREATE TABLE `mem3` (
  `Memberid` int(11) NOT NULL COMMENT '会员代码',
  `LineNum` smallint(6) NOT NULL COMMENT '行号',
  `DiseaseID` int(11) DEFAULT NULL COMMENT '疾病ID，来源字典',
  `DiseaseName` varchar(30) DEFAULT NULL COMMENT '疾病名称',
  `DiagTime` date DEFAULT NULL COMMENT '确诊时间',
  `ProTag` char(1) DEFAULT 'F' COMMENT '既往标记：N-现病史，Y-既往病史',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`Memberid`,`LineNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='疾病史';

/*Table structure for table `mem4` */

DROP TABLE IF EXISTS `mem4`;

CREATE TABLE `mem4` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `Relation` tinyint(4) NOT NULL COMMENT '关系：1-父亲，2-母亲，3-子女，4-兄弟姐妹',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `DiseaseID` int(11) NOT NULL COMMENT '疾病ID，来源字典',
  `DiseaseName` varchar(100) DEFAULT NULL COMMENT '其它疾病名称',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_MID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=778 DEFAULT CHARSET=utf8 COMMENT='[2.1]会员家族史表';

/*Table structure for table `mem5` */

DROP TABLE IF EXISTS `mem5`;

CREATE TABLE `mem5` (
  `Memberid` int(11) NOT NULL COMMENT '会员代码',
  `LineNum` smallint(6) NOT NULL COMMENT '行号',
  `PackageCode` int(11) DEFAULT NULL COMMENT '套餐代码',
  `Tag` char(1) DEFAULT NULL COMMENT '标记：T-有效，F-无效',
  `CreateTime` datetime DEFAULT NULL COMMENT '创建日期',
  `Createid` int(11) DEFAULT NULL COMMENT '创建医生ID',
  `CreateName` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  PRIMARY KEY (`Memberid`,`LineNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员订购套餐表';

/*Table structure for table `mem6` */

DROP TABLE IF EXISTS `mem6`;

CREATE TABLE `mem6` (
  `Memberid` int(11) NOT NULL COMMENT '会员代码',
  `VigorIndex` int(11) DEFAULT NULL COMMENT '活力指数',
  PRIMARY KEY (`Memberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员活力指数表';

/*Table structure for table `mem7` */

DROP TABLE IF EXISTS `mem7`;

CREATE TABLE `mem7` (
  `Memberid` int(11) NOT NULL COMMENT '会员代码',
  `Smoking` char(1) DEFAULT NULL COMMENT '是否抽烟',
  `DoDrink` char(1) DEFAULT NULL COMMENT '是否喝酒',
  `DoNtFood` varchar(100) DEFAULT NULL COMMENT '不喜欢的食品',
  `StapleFood` char(1) DEFAULT '1' COMMENT '主食',
  `SleepCond` char(1) DEFAULT NULL COMMENT '睡眠状况',
  `LikeSports` varchar(20) DEFAULT NULL COMMENT '喜欢的运动',
  `MoveLong` varchar(10) DEFAULT NULL COMMENT '运动时长',
  `TimeSeg` varchar(20) DEFAULT NULL COMMENT '时间间段',
  `WeekNumTimes` smallint(6) DEFAULT NULL COMMENT '每周几次',
  PRIMARY KEY (`Memberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员习惯信息';

/*Table structure for table `mem8` */

DROP TABLE IF EXISTS `mem8`;

CREATE TABLE `mem8` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `memberId` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `uploadTime` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29648 DEFAULT CHARSET=utf8;

/*Table structure for table `memlog` */

DROP TABLE IF EXISTS `memlog`;

CREATE TABLE `memlog` (
  `Memberid` int(11) NOT NULL COMMENT '会员代码',
  `PassWord` varchar(50) DEFAULT NULL COMMENT '密码',
  `Session` varchar(50) DEFAULT NULL COMMENT '令牌',
  `curTag` char(1) DEFAULT NULL COMMENT '状态',
  `LoginTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Device` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Memberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员登录密码及状态表';

/*Table structure for table `message` */

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (
  `Messageid` int(11) NOT NULL AUTO_INCREMENT,
  `Receiveid` int(11) NOT NULL COMMENT '接收方',
  `Sendid` int(11) NOT NULL COMMENT '发送方',
  `Content` text COMMENT '内容',
  `SendTime` datetime DEFAULT NULL COMMENT '发送时间',
  `OrgId` int(11) DEFAULT NULL,
  `Tag` char(255) DEFAULT NULL,
  `has_read` char(100) DEFAULT 'T' COMMENT '会员是否已读该条信息：T-已读，F-未读',
  PRIMARY KEY (`Messageid`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 COMMENT='消息';

/*Table structure for table `mfq1` */

DROP TABLE IF EXISTS `mfq1`;

CREATE TABLE `mfq1` (
  `Qustid` int(11) NOT NULL COMMENT '问卷ID号',
  `Problemid` int(11) NOT NULL COMMENT '问题ID',
  `QustTypeid` smallint(6) DEFAULT NULL COMMENT '问卷类型ID',
  `ProDesc` varchar(200) DEFAULT NULL COMMENT '问题内容',
  `LineNum` smallint(6) DEFAULT NULL COMMENT '答案个数',
  `AnsType` char(1) DEFAULT '0' COMMENT '答案类型',
  `relation` char(1) DEFAULT NULL COMMENT '与上题关系：0-不同时出现，1-同时出现',
  `Uproblemid` int(11) DEFAULT NULL COMMENT '关联问题ID',
  `Uansid` smallint(6) DEFAULT NULL COMMENT '关联答案',
  `CreateDate` date DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`Qustid`,`Problemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问卷信息明细表';

/*Table structure for table `mfq11` */

DROP TABLE IF EXISTS `mfq11`;

CREATE TABLE `mfq11` (
  `Qustid` int(11) NOT NULL COMMENT '问卷ID号',
  `Problemid` int(11) NOT NULL COMMENT '问题ID',
  `Ansid` smallint(6) NOT NULL COMMENT '答案ID',
  `Description` varchar(200) DEFAULT NULL COMMENT '答案内容描述',
  `Mark` char(1) DEFAULT NULL COMMENT '答案标号',
  `Score` double(6,1) DEFAULT NULL COMMENT '对应分值',
  `FillTag` char(1) DEFAULT 'F' COMMENT '是否填空',
  `Fillblank` varchar(100) DEFAULT NULL COMMENT '填空',
  `isValidate` tinyint(1) DEFAULT NULL COMMENT '有效性',
  `MinScore` smallint(6) DEFAULT NULL COMMENT '最小参考值',
  `MaxScore` smallint(6) DEFAULT NULL COMMENT '最大参考值',
  `ComTag` char(1) DEFAULT NULL COMMENT '比较值计分标记',
  `Createid` int(11) DEFAULT NULL COMMENT '创建医生ID',
  `DocName` varchar(20) DEFAULT NULL COMMENT '医生姓名',
  PRIMARY KEY (`Qustid`,`Problemid`,`Ansid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题回答项明细表';

/*Table structure for table `mfq12` */

DROP TABLE IF EXISTS `mfq12`;

CREATE TABLE `mfq12` (
  `Qustid` int(11) NOT NULL COMMENT '问卷ID号',
  `Problemid` int(11) NOT NULL COMMENT '问题ID',
  `Ansid` smallint(6) NOT NULL COMMENT '答案ID',
  `LineNum` smallint(6) NOT NULL COMMENT '行号',
  `MinNum` int(11) DEFAULT NULL COMMENT '最小值',
  `MaxNum` int(11) DEFAULT NULL COMMENT '最大值',
  `Score` double(6,1) DEFAULT NULL COMMENT '得分数',
  PRIMARY KEY (`Qustid`,`Problemid`,`Ansid`,`LineNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比较值取分表';

/*Table structure for table `mfq2` */

DROP TABLE IF EXISTS `mfq2`;

CREATE TABLE `mfq2` (
  `Qustid` int(11) NOT NULL COMMENT '问卷ID号',
  `LineNum` smallint(6) NOT NULL COMMENT '行号',
  `Description` varchar(100) DEFAULT NULL COMMENT '总分描述',
  `Startid` int(11) DEFAULT NULL COMMENT '开始题号',
  `Endid` int(11) DEFAULT NULL COMMENT '结束题号',
  `countmethod` char(1) DEFAULT NULL COMMENT '计分方法',
  `TotalScore` double(6,1) DEFAULT NULL COMMENT '总分',
  `CreateDate` date DEFAULT NULL COMMENT '创建日期',
  `problemIds` varchar(255) DEFAULT NULL COMMENT '有效问题编号（统计总分使用）',
  PRIMARY KEY (`Qustid`,`LineNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问卷总分信息表';

/*Table structure for table `mfq21` */

DROP TABLE IF EXISTS `mfq21`;

CREATE TABLE `mfq21` (
  `Qustid` int(11) NOT NULL COMMENT '问卷ID号',
  `LineNum` smallint(6) NOT NULL COMMENT '行号',
  `Convid` smallint(6) NOT NULL COMMENT '结论ID',
  `MinScore` double(6,1) DEFAULT NULL COMMENT '总分最小值',
  `MaxScore` double(6,1) DEFAULT NULL COMMENT '总分最大值',
  `Conclusion` varchar(100) DEFAULT NULL COMMENT '结论',
  PRIMARY KEY (`Qustid`,`LineNum`,`Convid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总分比较值设置';

/*Table structure for table `oasr` */

DROP TABLE IF EXISTS `oasr`;

CREATE TABLE `oasr` (
  `serialNumber` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '进度流水号',
  `ReportNo` int(11) DEFAULT NULL COMMENT '报告单号',
  `OptId` smallint(6) DEFAULT NULL COMMENT '选项代码',
  `OptName` varchar(50) DEFAULT NULL COMMENT '选项名称',
  `Memberid` int(11) DEFAULT NULL COMMENT '会员代码',
  `DocGrpCode` int(11) DEFAULT NULL COMMENT '医生分组',
  `TempCode` int(11) DEFAULT NULL COMMENT '模板代码',
  `MeasTime` datetime DEFAULT NULL COMMENT '测量起始时间',
  `MeasTermTime` datetime DEFAULT NULL COMMENT '测量终止时间',
  `MeasNum` smallint(6) DEFAULT NULL COMMENT '测量次数',
  `GrenerTime` datetime DEFAULT NULL COMMENT '产生时间',
  `AuditLevel` smallint(6) DEFAULT NULL COMMENT '审核级别',
  `AuditState` char(1) DEFAULT NULL COMMENT '审核状态：W-审核中，N-未处理，Y-已审核',
  `SubmitOther` char(1) DEFAULT NULL COMMENT '是否提交其他组：Y-提交，N-不提交',
  `YNTag` char(1) DEFAULT 'N' COMMENT '是否是终审：N-不是，Y-是',
  `Docid` int(11) DEFAULT NULL COMMENT '审核医生',
  `AuditDatetime` datetime DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`serialNumber`),
  KEY `idx_MID` (`Memberid`),
  KEY `idx_OID_AS` (`OptId`,`AuditState`)
) ENGINE=InnoDB AUTO_INCREMENT=12977 DEFAULT CHARSET=utf8 COMMENT='审核步骤记录';

/*Table structure for table `obsr` */

DROP TABLE IF EXISTS `obsr`;

CREATE TABLE `obsr` (
  `Docentry` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '测量记录号',
  `EventId` bigint(20) DEFAULT NULL,
  `Memberid` int(11) DEFAULT NULL COMMENT '会员代码',
  `UploadTime` datetime DEFAULT NULL COMMENT '上传时间',
  `TestTime` datetime DEFAULT NULL COMMENT '测量时间',
  `DelTag` char(1) DEFAULT NULL COMMENT '是否删除',
  `BsValue` decimal(10,1) DEFAULT NULL COMMENT '本次测量血糖值',
  `timePeriod` char(1) DEFAULT '0' COMMENT '测量时间段',
  `AnalysisResult` char(1) DEFAULT '0' COMMENT '分析结果',
  `DeviceCode` varchar(30) DEFAULT NULL,
  `BluetoothMacAddr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Docentry`),
  KEY `idx_MID` (`Memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=23469 DEFAULT CHARSET=utf8 COMMENT='血糖测量表';

/*Table structure for table `ocam` */

DROP TABLE IF EXISTS `ocam`;

CREATE TABLE `ocam` (
  `CombAnsid` int(11) NOT NULL AUTO_INCREMENT COMMENT '组合答卷ID',
  `CombQustid` int(11) DEFAULT NULL COMMENT '组合答卷ID',
  `CombQustName` varchar(50) DEFAULT NULL COMMENT '组合问卷名称',
  `CombQustCode` int(11) DEFAULT NULL COMMENT '组合问卷编号',
  `CombDesc` varchar(500) DEFAULT NULL COMMENT '组合介绍',
  `PublisherTime` datetime DEFAULT NULL COMMENT '发放时间',
  `Memberid` int(11) DEFAULT NULL COMMENT '会员代码',
  `ChTag` char(1) DEFAULT NULL COMMENT '是否审核：Y-审核，N-免审',
  `CombTag` char(1) DEFAULT '0' COMMENT '[2.0.4]组合答卷状态：0-未完成，1-已完成正在审核中，2-审核完成，3-作答中',
  `AssessDate` date DEFAULT NULL COMMENT '评定日期',
  `Docid` int(11) DEFAULT NULL COMMENT '发放医生ID',
  `DocName` varchar(20) DEFAULT NULL COMMENT '发放医生姓名',
  `answerTime` datetime DEFAULT NULL COMMENT '答卷时间',
  `readStatus` tinyint(4) DEFAULT '0' COMMENT '[2.1]会员是否已读已审核的答卷：0-已读,1-未读',
  PRIMARY KEY (`CombAnsid`),
  KEY `idx_MID` (`Memberid`),
  KEY `idx_CQID_MID` (`CombQustid`,`Memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8 COMMENT='会员组合答卷主表';

/*Table structure for table `ocqt` */

DROP TABLE IF EXISTS `ocqt`;

CREATE TABLE `ocqt` (
  `CombQustid` int(11) NOT NULL AUTO_INCREMENT COMMENT '组合答卷ID',
  `CombQustName` varchar(50) DEFAULT NULL COMMENT '组合问卷名称',
  `CombQustCode` int(11) DEFAULT NULL COMMENT '组合问卷编号',
  `CombDesc` varchar(500) DEFAULT NULL COMMENT '组合介绍',
  `ChTag` char(1) DEFAULT NULL COMMENT '是否审核',
  `QustTag` char(1) DEFAULT NULL COMMENT '问卷状态',
  `CreateDate` date DEFAULT NULL COMMENT '创建日期',
  `Createid` int(11) DEFAULT NULL COMMENT '创建医生ID',
  `CreateName` varchar(20) DEFAULT NULL COMMENT '创建医生名称',
  `optId` smallint(6) DEFAULT NULL COMMENT '选项代码',
  `orgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `qustVer` varchar(20) DEFAULT '1' COMMENT '问卷版本号',
  PRIMARY KEY (`CombQustid`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='组合问卷主表';

/*Table structure for table `odgp` */

DROP TABLE IF EXISTS `odgp`;

CREATE TABLE `odgp` (
  `OdgpId` int(11) NOT NULL AUTO_INCREMENT COMMENT '分组代码',
  `OdgpName` varchar(50) DEFAULT NULL COMMENT '分组名称',
  `Remark` varchar(100) DEFAULT NULL COMMENT '分组说明',
  `FathId` int(11) DEFAULT NULL COMMENT '上级分组代码',
  `DocNum` int(11) DEFAULT NULL COMMENT '分组内的医生人数',
  `ChLevel` smallint(6) DEFAULT NULL COMMENT '审核级数',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `OptId` smallint(6) DEFAULT NULL COMMENT '选项代码',
  `FunId` smallint(6) DEFAULT NULL COMMENT '功能代码',
  `EndBlockTag` tinyint(1) DEFAULT '0' COMMENT '[2.0.4]未梢组织',
  `UseTag` char(1) DEFAULT 'T' COMMENT '使用标记',
  `order` int(11) DEFAULT '10' COMMENT '[2.0.4]排序',
  `Path` varchar(300) NOT NULL COMMENT '路径(以逗号拼接)，比如：,0,1,2,',
  PRIMARY KEY (`OdgpId`),
  KEY `idx_FID` (`FathId`),
  KEY `idx_P30` (`Path`(30))
) ENGINE=InnoDB AUTO_INCREMENT=468 DEFAULT CHARSET=utf8 COMMENT='医生分组';

/*Table structure for table `odmt` */

DROP TABLE IF EXISTS `odmt`;

CREATE TABLE `odmt` (
  `OdgpId` int(11) NOT NULL COMMENT '分组代码',
  `MemGrpid` int(11) NOT NULL COMMENT '会员分组代码',
  PRIMARY KEY (`MemGrpid`,`OdgpId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='医生分组与会员分组对应表';

/*Table structure for table `odoc` */

DROP TABLE IF EXISTS `odoc`;

CREATE TABLE `odoc` (
  `Docid` int(11) NOT NULL AUTO_INCREMENT COMMENT '医生代码',
  `DocGUID` char(36) NOT NULL COMMENT '[2.1]医生GUID',
  `RoleId` smallint(6) DEFAULT NULL COMMENT '角色代码',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `DocName` varchar(20) DEFAULT NULL COMMENT '医生姓名',
  `Title` varchar(20) DEFAULT NULL COMMENT '职称',
  `Gender` char(1) DEFAULT NULL COMMENT '性别',
  `BirthDate` date DEFAULT NULL COMMENT '出生年月',
  `ContactTel` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `Tel` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `Email` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `HomeAddress` varchar(200) DEFAULT NULL COMMENT '家庭地址',
  `workAddress` varchar(100) DEFAULT NULL COMMENT '工作单位',
  `UnitAddress` varchar(200) DEFAULT NULL COMMENT '单位地址',
  `ResideAddress` varchar(200) DEFAULT NULL COMMENT '户口地址',
  `CertiType` char(1) DEFAULT NULL COMMENT '证件类型',
  `CertiNum` varchar(50) DEFAULT NULL COMMENT '证件号码',
  `Weixin` varchar(20) DEFAULT NULL COMMENT '微信号',
  `Desription` varchar(5000) DEFAULT NULL COMMENT '简介',
  `WorkDepart` varchar(20) DEFAULT NULL COMMENT '工作科室',
  `HeadAddress` varchar(100) DEFAULT NULL COMMENT '头像地址',
  `SignAddress` varchar(100) DEFAULT NULL COMMENT '签名地址',
  `Tag` char(1) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`Docid`),
  UNIQUE KEY `uk_DGUID` (`DocGUID`)
) ENGINE=InnoDB AUTO_INCREMENT=493 DEFAULT CHARSET=utf8 COMMENT='医生档案';

/*Table structure for table `oecg` */

DROP TABLE IF EXISTS `oecg`;

CREATE TABLE `oecg` (
  `Docentry` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '测量记录号',
  `EventId` bigint(20) DEFAULT NULL,
  `Memberid` int(11) DEFAULT NULL COMMENT '会员代码',
  `UploadTime` datetime DEFAULT NULL COMMENT '上传时间',
  `TimeLength` int(11) DEFAULT NULL COMMENT '录入开始时间',
  `EcgTime` datetime DEFAULT NULL COMMENT '录入结束时间',
  `MeasTime` datetime DEFAULT NULL COMMENT '测量时间',
  `ImageNum` smallint(6) DEFAULT NULL COMMENT '写入数据库时间',
  `HeartNum` int(11) DEFAULT NULL COMMENT '总心搏数',
  `SlowestBeat` smallint(6) DEFAULT NULL COMMENT '最小心率',
  `SlowestTime` int(11) DEFAULT NULL COMMENT '最小心率时间',
  `FastestBeat` smallint(6) DEFAULT NULL COMMENT '最大心率',
  `FastestTime` int(11) DEFAULT NULL COMMENT '最大心率时间',
  `AverageHeart` int(11) DEFAULT NULL COMMENT '平均心率',
  `SDNN` decimal(10,4) DEFAULT NULL,
  `PNN50` decimal(10,4) DEFAULT NULL,
  `HRVI` decimal(10,4) DEFAULT NULL,
  `RMSSD` decimal(10,4) DEFAULT NULL,
  `TP` decimal(10,4) DEFAULT NULL,
  `VLF` decimal(10,4) DEFAULT NULL,
  `LF` decimal(10,4) DEFAULT NULL,
  `HF` decimal(10,4) DEFAULT NULL,
  `LF_HF` decimal(10,4) DEFAULT NULL,
  `SD1` decimal(10,4) DEFAULT NULL,
  `SD2` decimal(10,4) DEFAULT NULL,
  `ICount` smallint(6) DEFAULT NULL,
  `Fs` smallint(6) DEFAULT NULL,
  `SDNNLevel` smallint(6) DEFAULT NULL,
  `PNN50Level` smallint(6) DEFAULT NULL,
  `HRVILevel` smallint(6) DEFAULT NULL,
  `RMSSDLevel` smallint(6) DEFAULT NULL,
  `TPLevel` smallint(6) DEFAULT NULL,
  `VLFLevel` smallint(6) DEFAULT NULL,
  `LFLevel` smallint(6) DEFAULT NULL,
  `HFLevel` smallint(6) DEFAULT NULL,
  `LHRLevel` smallint(6) DEFAULT NULL,
  `HRLevel` smallint(6) DEFAULT NULL,
  `AddValue` smallint(6) DEFAULT NULL,
  `DeviceCode` varchar(30) DEFAULT NULL,
  `BluetoothMacAddr` varchar(50) DEFAULT NULL,
  `RawECGImg` varchar(50) DEFAULT NULL,
  `FreqPSD` varchar(50) DEFAULT NULL,
  `RRInterval` varchar(50) DEFAULT NULL,
  `RawECG` varchar(50) DEFAULT NULL,
  `DelTag` char(1) DEFAULT '0' COMMENT '是否删除',
  `ECGResult` smallint(6) DEFAULT '0' COMMENT '状态',
  `StatusTag` smallint(6) DEFAULT '0' COMMENT '分析完成状态',
  PRIMARY KEY (`Docentry`),
  KEY `idx_MID` (`Memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=4016 DEFAULT CHARSET=utf8 COMMENT='心电测量表';

/*Table structure for table `ofun` */

DROP TABLE IF EXISTS `ofun`;

CREATE TABLE `ofun` (
  `FunId` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '功能代码',
  `FunName` varchar(50) DEFAULT NULL COMMENT '功能名称',
  `FunDes` varchar(150) DEFAULT NULL COMMENT '功能名称',
  `Tag` char(1) DEFAULT NULL COMMENT '标记',
  PRIMARY KEY (`FunId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='分组功能表';

/*Table structure for table `oipn` */

DROP TABLE IF EXISTS `oipn`;

CREATE TABLE `oipn` (
  `NoticeNumber` int(11) NOT NULL AUTO_INCREMENT COMMENT '通知流水号',
  `NoticeContent` varchar(500) DEFAULT NULL COMMENT '通知内容',
  `NoticeTime` datetime DEFAULT NULL COMMENT '通知内容',
  `Publisherid` int(11) DEFAULT NULL COMMENT '发布人Id',
  `PublisherName` varchar(20) DEFAULT NULL COMMENT '发布人姓名',
  `Tag` char(1) DEFAULT NULL COMMENT '标记',
  PRIMARY KEY (`NoticeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知';

/*Table structure for table `omds` */

DROP TABLE IF EXISTS `omds`;

CREATE TABLE `omds` (
  `eventid` bigint(20) NOT NULL AUTO_INCREMENT,
  `Memberid` int(11) NOT NULL COMMENT '会员代码',
  `TimeLength` int(11) DEFAULT NULL COMMENT '测试时长',
  `UploadTime` datetime DEFAULT NULL COMMENT '上传时间',
  `EventType` char(1) DEFAULT NULL COMMENT '事件类型',
  `WheAbnTag` char(1) DEFAULT '0' COMMENT '是否有异常',
  `StatusTag` smallint(6) DEFAULT '0' COMMENT '分析完成状态',
  PRIMARY KEY (`eventid`),
  KEY `idx_MID` (`Memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=31052 DEFAULT CHARSET=utf8 COMMENT='测量数据记录表';

/*Table structure for table `omem` */

DROP TABLE IF EXISTS `omem`;

CREATE TABLE `omem` (
  `Memberid` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员代码',
  `LogName` varchar(20) DEFAULT NULL COMMENT '会员帐号',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `MemId` smallint(6) DEFAULT NULL COMMENT '会员类型',
  `MemName` varchar(20) DEFAULT NULL COMMENT '会员姓名',
  `MemNameCode` varchar(20) DEFAULT NULL COMMENT '[2.1SP1]会员名称简码',
  `Gender` char(1) DEFAULT NULL COMMENT '性别：1男；2女；3未知',
  `BirthDate` date DEFAULT NULL COMMENT '出生年月',
  `Tel` varchar(30) DEFAULT NULL COMMENT '手机号码',
  `Email` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `IdCard` varchar(30) DEFAULT NULL COMMENT '身份证号',
  `NativeAddr` varchar(20) DEFAULT NULL COMMENT '籍贯',
  `Address` varchar(200) DEFAULT NULL COMMENT '地址',
  `MarryStatus` char(1) DEFAULT NULL COMMENT '婚姻状况：1未婚；2已婚；3初婚；4再婚；5复婚；6丧偶；7离异；8未说明的婚姻状况',
  `EducationStatus` char(2) DEFAULT NULL COMMENT '教育状况：1研究生及以上；2大学本科；3大学专科和专科学校；4中等专业学校；5技工学校；6高中；7初中；8小学；9文盲或半文盲；10学历不详；11无',
  `Occupation` varchar(20) DEFAULT NULL COMMENT '职业：1.农林牧渔水利业生产人员；2.生产运输设备操作人员及有关人员；3.专业技术人员；4.办事人员和有关人员；5.商业、服务业人员；6.国家机关、党群组织、企事业单位负责人；7.在校学生；8.家务；9.待业；10.离退休人员；11.婴幼、学龄前儿童；12.军人；13.其他劳动者',
  `Docid` int(11) DEFAULT NULL COMMENT '医生代码',
  `DocName` varchar(20) DEFAULT NULL COMMENT '医生姓名',
  `HeadAddress` varchar(100) DEFAULT NULL,
  `UseTag` char(1) DEFAULT 'F' COMMENT '使用标记：T-有效，F-无效，E-导入失败，D-删除中，M-修改中，R-注册中',
  `CreateTime` datetime DEFAULT NULL COMMENT '创建时间',
  `headImg` blob,
  `status` char(1) NOT NULL DEFAULT 'T' COMMENT '会员状态：T-正常，F-冻结',
  `unique_id` varchar(100) DEFAULT NULL COMMENT '合作方数据标识（如：健康档案号）',
  `source` int(11) DEFAULT '0' COMMENT '[2.1]档案来源：0-web医生端注册，1-中联佳裕导入，2-好医生',
  `memberGUID` char(36) NOT NULL COMMENT '[2.1]会员GUID',
  `VerifyType` tinyint(4) NOT NULL DEFAULT '0' COMMENT '[3.0]认证类型(位运算)：0-无，1-手机认证',
  `IsInfoPerfect` tinyint(4) NOT NULL DEFAULT '0' COMMENT '[3.0]是否资料完善：0-否，1-是',
  PRIMARY KEY (`Memberid`),
  UNIQUE KEY `uk_MGUID` (`memberGUID`),
  KEY `idx_OID` (`OrgId`),
  KEY `idx_UI` (`unique_id`),
  KEY `idx_MN8` (`MemName`(8)),
  KEY `idx_MNC8` (`MemNameCode`(8)),
  KEY `idx_T11` (`Tel`(11)),
  KEY `idx_ICD18` (`IdCard`(18))
) ENGINE=InnoDB AUTO_INCREMENT=100942 DEFAULT CHARSET=utf8 COMMENT='会员档案';

/*Table structure for table `omem_account` */

DROP TABLE IF EXISTS `omem_account`;

CREATE TABLE `omem_account` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `Memberid` int(11) NOT NULL COMMENT '会员代码，引用omem',
  `Account` varchar(50) NOT NULL COMMENT '会员账号',
  `AccountType` tinyint(4) NOT NULL COMMENT '账号类型：1-手机号码，2-邮件，3-身份证，4-内部账号[2.1]',
  `Status` tinyint(4) NOT NULL COMMENT '与UC同步状态：1-待新增，2-新增成功，3-待删除',
  `CreateDrID` int(11) NOT NULL COMMENT '创建医生ID(引用odoc表)，其中0-系统/对接，-1-会员',
  `CreateTime` datetime NOT NULL COMMENT '记录创建时间',
  `UpdateDrID` int(11) DEFAULT NULL COMMENT '更新医生ID(引用odoc表)，0-系统/对接',
  `UpdateTime` datetime DEFAULT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`LogID`),
  UNIQUE KEY `uk_A` (`Account`),
  KEY `idx_MID` (`Memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=69160 DEFAULT CHARSET=utf8 COMMENT='会员账号表';

/*Table structure for table `omem_family_card` */

DROP TABLE IF EXISTS `omem_family_card`;

CREATE TABLE `omem_family_card` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `Memberid` int(11) NOT NULL COMMENT '本人_会员代码(引用omem)',
  `FamilyMemberid` int(11) NOT NULL COMMENT '家庭成员_会员代码(引用omem)',
  `Role` tinyint(4) NOT NULL COMMENT '角色：0-本人，1-爸爸，2-妈妈，3-爷爷，4-奶奶，5-儿子，6-女儿，7-其他[V2.1SP1]',
  `RoleName` varchar(10) DEFAULT NULL COMMENT '角色名称',
  `CardNo` varchar(30) DEFAULT NULL COMMENT '卡号',
  `CreateTime` datetime NOT NULL COMMENT '记录创建时间',
  `UpdateTime` datetime DEFAULT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_MID` (`Memberid`),
  KEY `idx_CN15` (`CardNo`(15))
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8 COMMENT='会员及家庭成员卡号表';

/*Table structure for table `omem_importlog` */

DROP TABLE IF EXISTS `omem_importlog`;

CREATE TABLE `omem_importlog` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `memberGUID` char(36) NOT NULL COMMENT '会员GUID',
  `ImportBatchGUID` char(36) DEFAULT NULL COMMENT '导入批次GUID',
  `ImportTime` datetime NOT NULL COMMENT '导入时间',
  `Reason` varchar(50) DEFAULT NULL COMMENT '原因',
  `UseTag` char(1) NOT NULL DEFAULT 'T' COMMENT '使用tag：T-有效，F-无效',
  `SyncTimestamp` bigint(20) DEFAULT NULL COMMENT '同步时间戳',
  `Content` text COMMENT '内容',
  `SourceType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '[3.0]来源类型：1-Web，2-App',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  UNIQUE KEY `uk_HNIID` (`memberGUID`)
) ENGINE=InnoDB AUTO_INCREMENT=22072 DEFAULT CHARSET=utf8 COMMENT='[2.1]会员导入记录表';

/*Table structure for table `omem_labelitem` */

DROP TABLE IF EXISTS `omem_labelitem`;

CREATE TABLE `omem_labelitem` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `LItemID` int(11) NOT NULL COMMENT '标签小项ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_MID` (`MemberID`),
  KEY `idx_LIID` (`LItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=40866 DEFAULT CHARSET=utf8 COMMENT='[3.0]会员与标签小项关系';

/*Table structure for table `omem_movement` */

DROP TABLE IF EXISTS `omem_movement`;

CREATE TABLE `omem_movement` (
  `MMovementID` int(11) NOT NULL AUTO_INCREMENT COMMENT '转移ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `OutOrgID` int(11) NOT NULL COMMENT '转出组织ID',
  `OutDrID` int(11) DEFAULT NULL COMMENT '转出确认医生',
  `InOrgID` int(11) NOT NULL COMMENT '转入组织ID',
  `InMemGrpidList` varchar(255) NOT NULL COMMENT '转入分组ID列表，以逗号拼接',
  `MoveStatus` tinyint(4) NOT NULL COMMENT '转移状态：1-待确认，2-已同意，3-已拒绝',
  `ConfirmTime` datetime DEFAULT NULL COMMENT '确认时间',
  `RefuseReason` varchar(100) DEFAULT NULL COMMENT '拒绝原因',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MMovementID`),
  KEY `idx_ODID` (`OutDrID`),
  KEY `idx_CID` (`CreateID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='[3.0]会员转移';

/*Table structure for table `omes` */

DROP TABLE IF EXISTS `omes`;

CREATE TABLE `omes` (
  `MemId` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '会员类型',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `MemName` varchar(20) DEFAULT NULL COMMENT '会员类型名',
  `MemDesc` varchar(100) DEFAULT NULL COMMENT '会员类型说明',
  `Tag` char(1) DEFAULT NULL COMMENT '标记',
  PRIMARY KEY (`MemId`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COMMENT='会员类型';

/*Table structure for table `omfq` */

DROP TABLE IF EXISTS `omfq`;

CREATE TABLE `omfq` (
  `Qustid` int(11) NOT NULL AUTO_INCREMENT COMMENT '问卷ID号',
  `OptId` smallint(6) DEFAULT NULL COMMENT '选项代码',
  `FunId` smallint(6) DEFAULT NULL COMMENT '功能代码',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `QustCode` varchar(20) DEFAULT NULL COMMENT '问卷编号',
  `Qustname` varchar(50) DEFAULT NULL COMMENT '问卷名称',
  `AnsMode` char(1) DEFAULT NULL COMMENT '回答方式',
  `Desription` varchar(100) DEFAULT NULL COMMENT '简单介绍',
  `QustVer` varchar(20) DEFAULT NULL COMMENT '问卷版本号',
  `QustDesc` varchar(1000) DEFAULT NULL COMMENT '问卷说明',
  `ChTag` char(1) DEFAULT NULL COMMENT '是否审核',
  `QustTag` char(1) DEFAULT NULL COMMENT '问卷状态',
  `CreateDate` date DEFAULT NULL COMMENT '创建日期',
  `Createid` int(11) DEFAULT NULL COMMENT '创建医生ID',
  `CreateName` varchar(20) DEFAULT NULL COMMENT '创建医生名称',
  `UseRange` tinyint(4) NOT NULL DEFAULT '3' COMMENT '应用范围：1-全局，2-组织内共享(管理员)，3-组织内共享(医生)',
  PRIMARY KEY (`Qustid`)
) ENGINE=InnoDB AUTO_INCREMENT=551 DEFAULT CHARSET=utf8 COMMENT='问卷信息主表';

/*Table structure for table `omgs` */

DROP TABLE IF EXISTS `omgs`;

CREATE TABLE `omgs` (
  `MemGrpid` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员分组代码',
  `MemGrpName` varchar(20) DEFAULT NULL COMMENT '会员分组代码',
  `MemGrpDesc` varchar(100) DEFAULT NULL COMMENT '会员分组说明',
  `faMemid` int(11) DEFAULT NULL COMMENT '上级会员分组代码',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `UseTag` char(1) DEFAULT 'T' COMMENT '使用标记',
  `order` int(11) DEFAULT '10' COMMENT '[2.0.4]排序',
  `Path` varchar(300) NOT NULL COMMENT '路径(以逗号拼接)，比如：,0,1,2,',
  PRIMARY KEY (`MemGrpid`),
  KEY `idx_FMID` (`faMemid`),
  KEY `idx_P30` (`Path`(30))
) ENGINE=InnoDB AUTO_INCREMENT=897 DEFAULT CHARSET=utf8 COMMENT='会员分组设置';

/*Table structure for table `ompb` */

DROP TABLE IF EXISTS `ompb`;

CREATE TABLE `ompb` (
  `MemGrpid` int(11) NOT NULL COMMENT '会员分组代码',
  `Memberid` int(11) NOT NULL COMMENT '会员代码',
  PRIMARY KEY (`MemGrpid`,`Memberid`),
  KEY `idx_MID` (`Memberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员分组归属';

/*Table structure for table `onco` */

DROP TABLE IF EXISTS `onco`;

CREATE TABLE `onco` (
  `Newsid` int(11) NOT NULL AUTO_INCREMENT COMMENT '新闻流水号',
  `NewsContent` varchar(5000) DEFAULT NULL COMMENT '新闻内容',
  `Publisherid` int(11) DEFAULT NULL COMMENT '发布人Id',
  `PublisherName` varchar(20) DEFAULT NULL COMMENT '发布人姓名',
  `Tag` char(1) DEFAULT NULL COMMENT '标记',
  PRIMARY KEY (`Newsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻';

/*Table structure for table `oopt` */

DROP TABLE IF EXISTS `oopt`;

CREATE TABLE `oopt` (
  `OptId` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '选项代码',
  `FunId` smallint(6) NOT NULL COMMENT '功能代码',
  `OptName` varchar(50) DEFAULT NULL COMMENT '选项名称',
  `OptDes` varchar(150) DEFAULT NULL COMMENT '选项说明',
  `CHLevel` smallint(6) DEFAULT NULL COMMENT '审核级数',
  `Tag` char(1) DEFAULT NULL COMMENT '标记',
  `orgid` int(11) DEFAULT NULL,
  PRIMARY KEY (`OptId`,`FunId`)
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8 COMMENT='选项表';

/*Table structure for table `oppg` */

DROP TABLE IF EXISTS `oppg`;

CREATE TABLE `oppg` (
  `Docentry` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '测量记录号',
  `EventId` bigint(20) DEFAULT NULL,
  `Memberid` int(11) DEFAULT NULL COMMENT '会员代码',
  `TimeLength` int(11) DEFAULT NULL COMMENT '测量时长',
  `UploadTime` datetime DEFAULT NULL COMMENT '上传时间',
  `MeasureTime` datetime DEFAULT NULL,
  `PulsebeatCount` smallint(6) DEFAULT NULL COMMENT '总脉搏数',
  `SlowPulse` smallint(6) DEFAULT NULL COMMENT '最小脉搏',
  `SlowTime` smallint(6) DEFAULT NULL COMMENT '最小脉搏时间',
  `QuickPulse` smallint(6) DEFAULT NULL COMMENT '最大脉搏',
  `QuickTime` smallint(6) DEFAULT NULL COMMENT '最大脉搏时间',
  `PulseRate` smallint(6) DEFAULT NULL COMMENT '平均脉搏',
  `Spo` smallint(6) DEFAULT NULL COMMENT '血氧饱和度',
  `SPO1` smallint(6) DEFAULT NULL,
  `CO` decimal(10,4) DEFAULT NULL COMMENT '平均每分射血量 CO',
  `SI` decimal(10,4) DEFAULT NULL,
  `SV` decimal(10,4) DEFAULT NULL COMMENT '心脏每搏射血量 SV',
  `CI` decimal(10,4) DEFAULT NULL COMMENT '心指数 CI',
  `SPI` decimal(10,4) DEFAULT NULL COMMENT '心搏指数 SPI',
  `K` decimal(10,4) DEFAULT NULL COMMENT '波形特征量 K',
  `K1` decimal(10,4) DEFAULT NULL,
  `V` decimal(10,4) DEFAULT NULL COMMENT '血液粘度 V',
  `TPR` decimal(10,4) DEFAULT NULL COMMENT '外周阻力 TPR',
  `PWTT` decimal(10,4) DEFAULT NULL,
  `Pm` decimal(10,4) DEFAULT NULL,
  `AC` decimal(10,4) DEFAULT NULL COMMENT '血管顺应度 AC',
  `ImageNum` smallint(6) DEFAULT NULL COMMENT '瞬时脉搏图',
  `PRLevel` smallint(6) DEFAULT NULL COMMENT '脉搏评估',
  `KLevel` smallint(6) DEFAULT NULL,
  `SVLevel` smallint(6) DEFAULT NULL,
  `COLevel` smallint(6) DEFAULT NULL,
  `ACLevel` smallint(6) DEFAULT NULL COMMENT 'ACLevel',
  `SILevel` smallint(6) DEFAULT NULL,
  `VLevel` smallint(6) DEFAULT NULL,
  `TPRLevel` smallint(6) DEFAULT NULL,
  `SPOLevel` smallint(6) DEFAULT NULL,
  `CILevel` smallint(6) DEFAULT NULL,
  `SPILevel` smallint(6) DEFAULT NULL,
  `PWTTLevel` smallint(6) DEFAULT NULL,
  `AbnormalData` int(11) DEFAULT NULL,
  `Ppgrr` varchar(50) DEFAULT NULL,
  `RawPPG` varchar(50) DEFAULT NULL,
  `BluetoothMacAddr` varchar(50) DEFAULT NULL,
  `DeviceCode` varchar(30) DEFAULT NULL,
  `ICount` smallint(6) DEFAULT NULL,
  `AddValue` int(11) DEFAULT NULL,
  `Fs` smallint(6) DEFAULT NULL COMMENT '采样频率',
  `PPGResult` smallint(6) DEFAULT NULL COMMENT '状态：0-未见异常，1-有异常',
  `StatusTag` smallint(6) DEFAULT NULL COMMENT '分析状态：0-未分析，1-分析失败，2-分析成功',
  `DelTag` char(1) DEFAULT '0' COMMENT '是否删除：0-否，1-是',
  PRIMARY KEY (`Docentry`),
  KEY `idx_MID` (`Memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=1281 DEFAULT CHARSET=utf8 COMMENT='脉搏测量表';

/*Table structure for table `opsp` */

DROP TABLE IF EXISTS `opsp`;

CREATE TABLE `opsp` (
  `PackageCode` int(11) NOT NULL AUTO_INCREMENT COMMENT '套餐代码',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `PackageName` varchar(20) DEFAULT NULL COMMENT '套餐名称',
  `PackageDesc` varchar(50) DEFAULT NULL COMMENT '套餐说明',
  `PackageType` smallint(6) DEFAULT NULL COMMENT '套餐类型',
  `Price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `PackageLevel` char(1) DEFAULT NULL COMMENT '套餐级别',
  `CreateTime` datetime DEFAULT NULL COMMENT '创建日期',
  `Createid` int(11) DEFAULT NULL COMMENT '创建医生ID',
  `CreateName` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `UseTag` char(1) DEFAULT 'F' COMMENT '使用标记：T-正常，F-关闭',
  PRIMARY KEY (`PackageCode`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8 COMMENT='服务套餐设置';

/*Table structure for table `orgs` */

DROP TABLE IF EXISTS `orgs`;

CREATE TABLE `orgs` (
  `OrgId` int(11) NOT NULL AUTO_INCREMENT COMMENT '组织代码',
  `OrgCode` char(20) DEFAULT NULL COMMENT '[2.0.4]组织架构编码',
  `OrgName` varchar(50) DEFAULT NULL COMMENT '组织名称',
  `Superior` int(11) DEFAULT NULL COMMENT '上级组织代码',
  `IsExternalService` char(1) DEFAULT 'N' COMMENT '是否对外服务：Y-是，N-否',
  `Otype` smallint(6) DEFAULT NULL COMMENT '类型',
  `Memnum` int(11) DEFAULT NULL COMMENT '会员数',
  `DocNum` int(11) DEFAULT NULL COMMENT '组织架构内医生人数',
  `UseTag` char(1) DEFAULT 'F' COMMENT '使用标记',
  `order` int(11) DEFAULT '10' COMMENT '[2.0.4]排序',
  `Path` varchar(300) NOT NULL COMMENT '路径(以逗号拼接)，比如：,0,1,2,',
  PRIMARY KEY (`OrgId`),
  KEY `idx_S` (`Superior`),
  KEY `idx_P30` (`Path`(30))
) ENGINE=InnoDB AUTO_INCREMENT=1064 DEFAULT CHARSET=utf8 COMMENT='组织架构表';

/*Table structure for table `orgs_cfg` */

DROP TABLE IF EXISTS `orgs_cfg`;

CREATE TABLE `orgs_cfg` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `OrgID` int(11) NOT NULL COMMENT '组织ID',
  `MemMustSetItem` bigint(20) DEFAULT NULL COMMENT '会员信息必填项(位运算)：1-姓名，2-性别，4-出生日期，8-身份证，16-手机号',
  `MemId` smallint(6) DEFAULT NULL COMMENT '会员类型',
  `ExperienceNum` int(11) DEFAULT NULL COMMENT '体验会员数量(个)',
  `ExperienceDay` int(11) DEFAULT NULL COMMENT '体验时长(天)',
  `IsDisplayCard` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否显示智能卡号：0-否，1-是',
  `IsSharedParentNode` tinyint(4) NOT NULL DEFAULT '1' COMMENT '[3.0]是否与上级节点共享：0-否，1-是',
  `CreateDrID` int(11) NOT NULL COMMENT '创建医生ID，0-系统',
  `CreateTime` datetime NOT NULL COMMENT '记录创建时间',
  `UpdateDrID` int(11) DEFAULT NULL COMMENT '更新医生ID，0-系统',
  `UpdateTime` datetime DEFAULT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_OID` (`OrgID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='组织配置表';

/*Table structure for table `orol` */

DROP TABLE IF EXISTS `orol`;

CREATE TABLE `orol` (
  `RoleId` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '角色代码',
  `RoleName` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `RoleDes` varchar(150) DEFAULT NULL COMMENT '角色说明',
  `Tag` char(1) DEFAULT NULL COMMENT '标记',
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Table structure for table `osbp` */

DROP TABLE IF EXISTS `osbp`;

CREATE TABLE `osbp` (
  `Docentry` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '测量记录号',
  `EventId` bigint(20) DEFAULT NULL,
  `Memberid` int(11) DEFAULT NULL COMMENT '会员代码',
  `UploadTime` datetime DEFAULT NULL COMMENT '上传时间',
  `TestTime` datetime DEFAULT NULL COMMENT '测量时间',
  `DelTag` char(1) DEFAULT '0' COMMENT '是否删除：0-否，1-是',
  `Abnormal` char(1) DEFAULT '0' COMMENT '异常状态：0-正常, 1-低血压，2-高度高血压，3-中度高血压，4-轻度高血压，5-单纯收缩期高血压，6-正常高值',
  `timePeriod` char(1) DEFAULT '0' COMMENT '测量时间段：0-其他(随机测量)，1-起床后2小时内，2-睡觉前',
  `SBP` int(11) DEFAULT NULL COMMENT '收缩压',
  `DBP` int(11) DEFAULT NULL COMMENT '舒张压',
  `PulseRate` int(11) DEFAULT NULL COMMENT '脉搏率',
  `BluetoothMacAddr` varchar(50) DEFAULT NULL,
  `DeviceCode` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Docentry`),
  KEY `idx_MID` (`Memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=3541 DEFAULT CHARSET=utf8 COMMENT='血压测量表';

/*Table structure for table `otpl` */

DROP TABLE IF EXISTS `otpl`;

CREATE TABLE `otpl` (
  `ID` smallint(6) NOT NULL AUTO_INCREMENT,
  `Phrise` varchar(20) DEFAULT NULL COMMENT '常用短语',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='常用短语库';

/*Table structure for table `otqi` */

DROP TABLE IF EXISTS `otqi`;

CREATE TABLE `otqi` (
  `QustTypeid` smallint(6) NOT NULL COMMENT '问卷类型ID',
  `QustTypeName` varchar(20) DEFAULT NULL COMMENT '问卷类型名称',
  `CreateDate` date DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`QustTypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问卷类型信息';

/*Table structure for table `ouai` */

DROP TABLE IF EXISTS `ouai`;

CREATE TABLE `ouai` (
  `AnsNumber` int(11) NOT NULL AUTO_INCREMENT COMMENT '答卷编号',
  `Memberid` int(11) DEFAULT NULL COMMENT '会员代码',
  `Qustid` int(11) DEFAULT NULL COMMENT '问卷ID号',
  `QustVer` varchar(20) DEFAULT NULL COMMENT '问卷版本号',
  `AssessDate` date DEFAULT NULL COMMENT '评定日期',
  `ChTag` char(1) DEFAULT NULL COMMENT '是否审核：Y-审核，N-免审',
  `QustTag` char(1) DEFAULT NULL COMMENT '[2.0.4]答卷状态：T-已答，F-未答，C-已审核，B-暂存',
  `QustCode` varchar(20) DEFAULT NULL COMMENT '问卷编号',
  `PublisherTime` datetime DEFAULT NULL COMMENT '发放时间',
  `FailureTime` datetime DEFAULT NULL COMMENT '失效时间',
  `FunId` smallint(6) DEFAULT NULL COMMENT '功能代码',
  `OptId` smallint(6) DEFAULT NULL COMMENT '选项代码',
  `Docid` int(11) DEFAULT NULL COMMENT '发放医生ID',
  `DocName` varchar(20) DEFAULT NULL COMMENT '发放医生姓名',
  `answerTime` datetime DEFAULT NULL COMMENT '答卷时间',
  `readStatus` int(11) DEFAULT '0' COMMENT '会员是否已读已审核的答卷：0-已读，1-未读',
  `HExamID` bigint(20) DEFAULT NULL COMMENT '体检主ID',
  `MSETaskID` bigint(20) DEFAULT NULL COMMENT '[3.0]管理方案_执行_任务ID',
  PRIMARY KEY (`AnsNumber`),
  KEY `idx_MID` (`Memberid`),
  KEY `idx_QID_MID` (`Qustid`,`Memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=2280 DEFAULT CHARSET=utf8 COMMENT='会员答卷信息表';

/*Table structure for table `pc_mini_record` */

DROP TABLE IF EXISTS `pc_mini_record`;

CREATE TABLE `pc_mini_record` (
  `user_id` varchar(30) NOT NULL COMMENT '用户id',
  `mem_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别：F-女，M-男',
  `tel` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `idCard` varchar(30) DEFAULT NULL COMMENT '身份证号',
  `bluetooth_mac_addr` varchar(50) NOT NULL COMMENT '蓝牙设备地址',
  `send_down_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'mini下放时间',
  `upload_time` timestamp NULL DEFAULT NULL COMMENT 'mini上传时间',
  `has_uploaded` int(11) DEFAULT '0' COMMENT '是否已经上传：0-未上传，1-已上传',
  `has_deleted` int(11) DEFAULT '0' COMMENT '是否已经：0-未删除，1-已删除',
  `send_doc_id` varchar(30) NOT NULL COMMENT 'mini设备下发医生id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='pc端发送和上传mini记录表';

/*Table structure for table `ph_diabetes` */

DROP TABLE IF EXISTS `ph_diabetes`;

CREATE TABLE `ph_diabetes` (
  `DiabetesID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '糖尿病随访主ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `Unique_ID` varchar(36) DEFAULT NULL COMMENT '健康档案号',
  `RefCompany` tinyint(4) NOT NULL DEFAULT '0' COMMENT '合作公司，0-录入，{字典1}',
  `RefDataPK` varchar(36) NOT NULL COMMENT '合作公司的业务数据主键值',
  `IDCard` varchar(36) DEFAULT NULL COMMENT '身份证号',
  `Name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `VisitDate` datetime DEFAULT NULL COMMENT '随访日期',
  `VisitDrName` varchar(50) DEFAULT NULL COMMENT '随访医生签名',
  `VisitClass` tinyint(4) NOT NULL DEFAULT '0' COMMENT '此次随访分类，0-待随访，{字典18}',
  `GetTime` datetime NOT NULL COMMENT '最近入库时间',
  `IsDeleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已删除：0-否，1-是',
  `MSETaskID` bigint(20) DEFAULT NULL COMMENT '[3.0]管理方案_执行_任务ID',
  `CreateDrID` int(11) NOT NULL COMMENT '创建医生ID，0-系统(对接)',
  `CreateDrName` varchar(50) NOT NULL COMMENT '创建医生名称',
  `CreateTime` datetime NOT NULL COMMENT '记录创建时间',
  `UpdateDrID` int(11) DEFAULT NULL COMMENT '更新医生ID，0-系统',
  `UpdateDrName` varchar(50) DEFAULT NULL COMMENT '更新医生名称',
  `UpdateTime` datetime DEFAULT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`DiabetesID`),
  UNIQUE KEY `uidx_RDPK_RC` (`RefDataPK`,`RefCompany`),
  KEY `idx_GT` (`GetTime`),
  KEY `idx_MID` (`MemberID`),
  KEY `idx_UID` (`Unique_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=44843 DEFAULT CHARSET=utf8 COMMENT='公共卫生_2型糖尿病随访表';

/*Table structure for table `ph_diabetesdetail` */

DROP TABLE IF EXISTS `ph_diabetesdetail`;

CREATE TABLE `ph_diabetesdetail` (
  `DiabetesID` bigint(20) NOT NULL COMMENT '糖尿病随访主ID',
  `VisitWay` tinyint(4) DEFAULT NULL COMMENT '随访方式，{字典10}',
  `Symptom` varchar(30) DEFAULT NULL COMMENT '症状_列表(以@#拼接)，{字典11}',
  `Symptom_Desc` varchar(200) DEFAULT NULL COMMENT '症状_其他描述',
  `Systolic` smallint(6) DEFAULT NULL COMMENT '体征_收缩压(mmHg)',
  `Diastolic` smallint(6) DEFAULT NULL COMMENT '体征_舒张压(mmHg)',
  `Height` decimal(5,1) DEFAULT NULL COMMENT '体征_身高(cm)',
  `Weight` decimal(5,1) DEFAULT NULL COMMENT '体征_当前体重(kg)',
  `Weight_Next` decimal(5,1) DEFAULT NULL COMMENT '体征_下次目标体重(kg)',
  `BMI` decimal(5,2) DEFAULT NULL COMMENT '体征_当前体质指数',
  `BMI_Next` decimal(5,2) DEFAULT NULL COMMENT '体征_下次目标体质指数',
  `Arteriopalmus` tinyint(4) DEFAULT NULL COMMENT '体征_足背动脉搏动，{字典12}',
  `OtherSign` varchar(100) DEFAULT NULL COMMENT '体征_其他',
  `DailySmoking` smallint(6) DEFAULT NULL COMMENT '生活方式指导_当前日吸烟量(支)',
  `DailySmoking_Next` smallint(6) DEFAULT NULL COMMENT '生活方式指导_下次目标日吸烟量(支)',
  `DailyDrink` decimal(3,1) DEFAULT NULL COMMENT '[2.1]生活方式指导_日饮酒量(两)',
  `DailyDrink_Next` decimal(3,1) DEFAULT NULL COMMENT '[2.1]生活方式指导_下次目标日饮酒量(两)',
  `SportFrequency` varchar(20) DEFAULT NULL COMMENT '生活方式指导_当前运动频率(次/周)',
  `SportFrequency_Next` varchar(20) DEFAULT NULL COMMENT '生活方式指导_下次目标运动频率(次/周)',
  `SportDuration` smallint(6) DEFAULT NULL COMMENT '生活方式指导_当前时长(分钟/次)',
  `SportDuration_Next` smallint(6) DEFAULT NULL COMMENT '生活方式指导_下次目标时长(分钟/次)',
  `MainFood` smallint(6) DEFAULT NULL COMMENT '生活方式指导_当前主食(克/天)',
  `MainFood_Next` smallint(6) DEFAULT NULL COMMENT '生活方式指导_下次目标主食(克/天)',
  `PsychologicalRecovery` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_心理调整，{字典13}',
  `ComplianceBehavior` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_遵医行为，{字典14}',
  `FPG` decimal(5,2) DEFAULT NULL COMMENT '[2.1]辅助检查_空腹血糖值(mmol/L)',
  `PGLU` decimal(5,2) DEFAULT NULL COMMENT '[2.1]辅助检查_餐后血糖(mmol/L)',
  `HBA1C` decimal(4,1) DEFAULT NULL COMMENT '辅助检查_糖化血红蛋白(%)',
  `CheckDate` datetime DEFAULT NULL COMMENT '辅助检查_检查日期',
  `CheckResult` varchar(100) DEFAULT NULL COMMENT '辅助检查_检查结果',
  `DrugCompliance` tinyint(4) DEFAULT NULL COMMENT '服药依从性，{字典15}',
  `DrugAdverseReaction` tinyint(4) DEFAULT NULL COMMENT '药物不良反应，{字典16}',
  `DrugAdverseReaction_Desc` varchar(100) DEFAULT NULL COMMENT '药物不良反应描述',
  `RHG` tinyint(4) DEFAULT NULL COMMENT '低血糖反应，{字典17}',
  `TransferReason` varchar(100) DEFAULT NULL COMMENT '转诊_原因',
  `TransferOrgAndDept` varchar(50) DEFAULT NULL COMMENT '转诊_机构及科室',
  `VisitDate_Next` datetime DEFAULT NULL COMMENT '下次随访日期',
  PRIMARY KEY (`DiabetesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公共卫生_2型糖尿病随访明细表';

/*Table structure for table `ph_diabetesdetailmedicine` */

DROP TABLE IF EXISTS `ph_diabetesdetailmedicine`;

CREATE TABLE `ph_diabetesdetailmedicine` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `DiabetesID` int(11) NOT NULL COMMENT '糖尿病随访主ID',
  `DrugName` varchar(50) DEFAULT NULL COMMENT '药物名称',
  `DrugUsage` varchar(30) DEFAULT NULL COMMENT '用法（口服、注射等）',
  `DrugFreq` varchar(30) DEFAULT NULL COMMENT '频率（每日一次等）',
  `DrugDosage` varchar(10) DEFAULT NULL COMMENT '用量',
  `DrugUnit` varchar(20) DEFAULT NULL COMMENT '单位（mg、支等）',
  `Remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`LogID`),
  KEY `idx_DID` (`DiabetesID`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8 COMMENT='公共卫生_2型糖尿病随访明细_用药情况表';

/*Table structure for table `ph_dictitem` */

DROP TABLE IF EXISTS `ph_dictitem`;

CREATE TABLE `ph_dictitem` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `DTypeID` smallint(6) NOT NULL COMMENT '字典类型ID',
  `DItemID` tinyint(4) NOT NULL COMMENT '字典小项ID',
  `DItemName` varchar(20) NOT NULL COMMENT '字典小项名称',
  `CreateTime` datetime NOT NULL COMMENT '记录创建时间',
  PRIMARY KEY (`LogID`),
  UNIQUE KEY `uidx_DTID_DIID` (`DTypeID`,`DItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8 COMMENT='公共卫生_字典小项表';

/*Table structure for table `ph_dicttype` */

DROP TABLE IF EXISTS `ph_dicttype`;

CREATE TABLE `ph_dicttype` (
  `DTypeID` smallint(6) NOT NULL COMMENT '字典类型ID',
  `DTypeName` varchar(20) NOT NULL COMMENT '字典类型名称',
  `Source` varchar(30) NOT NULL COMMENT '来源分类',
  `CreateTime` datetime NOT NULL COMMENT '记录创建时间',
  PRIMARY KEY (`DTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公共卫生_字典类型表';

/*Table structure for table `ph_healthexam` */

DROP TABLE IF EXISTS `ph_healthexam`;

CREATE TABLE `ph_healthexam` (
  `HExamID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '体检主ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `Unique_ID` varchar(36) DEFAULT NULL COMMENT '健康档案号',
  `RefCompany` tinyint(4) NOT NULL DEFAULT '0' COMMENT '合作公司，0-录入，{字典1}',
  `RefDataPK` varchar(36) NOT NULL COMMENT '合作公司的业务数据主键值',
  `IDCard` varchar(36) DEFAULT NULL COMMENT '身份证号',
  `Name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `ExamDate` datetime DEFAULT NULL COMMENT '体检日期',
  `ResponsibleDrName` varchar(50) DEFAULT NULL COMMENT '责任医生',
  `GetTime` datetime NOT NULL COMMENT '最近入库时间',
  `IsDeleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已删除：0-否，1-是',
  `CreateDrID` int(11) NOT NULL COMMENT '创建医生ID，0-系统(对接)',
  `CreateDrName` varchar(50) NOT NULL COMMENT '创建医生名称',
  `CreateTime` datetime NOT NULL COMMENT '记录创建时间',
  `UpdateDrID` int(11) DEFAULT NULL COMMENT '更新医生ID，0-系统',
  `UpdateDrName` varchar(50) DEFAULT NULL COMMENT '更新医生名称',
  `UpdateTime` datetime DEFAULT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`HExamID`),
  UNIQUE KEY `uidx_RDPK_RC` (`RefDataPK`,`RefCompany`),
  KEY `idx_GT` (`GetTime`),
  KEY `idx_MID` (`MemberID`),
  KEY `idx_UID` (`Unique_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=90056 DEFAULT CHARSET=utf8 COMMENT='公共卫生_健康体检表';

/*Table structure for table `ph_healthexamdetail` */

DROP TABLE IF EXISTS `ph_healthexamdetail`;

CREATE TABLE `ph_healthexamdetail` (
  `HExamID` bigint(20) NOT NULL COMMENT '体检主ID',
  `Symptom` varchar(100) DEFAULT NULL COMMENT '症状_列表(以@#拼接)，{字典19}',
  `Symptom_Desc` varchar(200) DEFAULT NULL COMMENT '症状_其他描述',
  `BodyTemperature` decimal(4,1) DEFAULT NULL COMMENT '一般状况_体温(℃)',
  `PulseRate` smallint(6) DEFAULT NULL COMMENT '一般状况_脉率(次/min)',
  `RespiratoryRate` smallint(6) DEFAULT NULL COMMENT '一般状况_呼吸频率(次/min)',
  `LeftSystolic` smallint(6) DEFAULT NULL COMMENT '一般状况_左收缩压(mmHg)',
  `LeftDiastolic` smallint(6) DEFAULT NULL COMMENT '一般状况_左舒张压(mmHg)',
  `RightSystolic` smallint(6) DEFAULT NULL COMMENT '一般状况_右收缩压(mmHg)',
  `RightDiastolic` smallint(6) DEFAULT NULL COMMENT '一般状况_右舒张压(mmHg)',
  `Height` decimal(5,1) DEFAULT NULL COMMENT '一般状况_身高(cm)',
  `Weight` decimal(5,1) DEFAULT NULL COMMENT '一般状况_当前体重(kg)',
  `Waist` decimal(5,1) DEFAULT NULL COMMENT '一般状况_腰围(cm)',
  `BMI` decimal(5,2) DEFAULT NULL COMMENT '一般状况_体质指数',
  `AgedHealthEvaluate` tinyint(4) DEFAULT NULL COMMENT '一般状况_老年人健康状态自我评估，{字典20}',
  `AgedLifeEvaluate` tinyint(4) DEFAULT NULL COMMENT '一般状况_老年人生活自理能力自我评估，{字典21}',
  `AgedCognition` tinyint(4) DEFAULT NULL COMMENT '一般状况_老年人认知功能，{字典22}',
  `AgedCognitionScore` tinyint(4) DEFAULT NULL COMMENT '一般状况_老年人认知功能_总分',
  `AgedFeeling` tinyint(4) DEFAULT NULL COMMENT '一般状况_老年人情感状态，{字典23}',
  `AgedFeelingScore` tinyint(4) DEFAULT NULL COMMENT '一般状况_老年人情感状态_总分',
  `SportFrequency` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_运动频率，{字典23}',
  `SportDuration` smallint(6) DEFAULT NULL COMMENT '生活方式指导_每次锻炼时间(分钟/次)',
  `SportTotalTime` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_坚持锻炼时间(年)',
  `SportWay` varchar(100) DEFAULT NULL COMMENT '生活方式指导_锻炼方式',
  `EatingHabits` varchar(20) DEFAULT NULL COMMENT '生活方式指导_饮食习惯_列表(以@#拼接)，{字典25}',
  `SmokingState` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_吸烟状况，{字典26}',
  `DailySmoking` smallint(6) DEFAULT NULL COMMENT '生活方式指导_日吸烟量(支)',
  `SmokingStartAge` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_开始吸烟年龄(岁)',
  `SmokingEndAge` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_戒烟年龄(岁)',
  `DrinkFrequency` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_饮酒频率，{字典27}',
  `DailyDrink` decimal(3,1) DEFAULT NULL COMMENT '[2.1]生活方式指导_日饮酒量(两)',
  `IsAbstinence` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_是否戒酒，{字典28}',
  `AbstinenceAge` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_戒酒(岁)',
  `DrinkStartAge` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_开始饮酒年龄(岁)',
  `IsTemulenceLastYear` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_近一年内是否曾醉酒，{字典90}',
  `DrinkType` varchar(20) DEFAULT NULL COMMENT '生活方式指导_饮酒种类_列表(以@#拼接)，{字典29}',
  `DrinkOther_Desc` varchar(100) DEFAULT NULL COMMENT '生活方式指导_其他饮酒种类描述',
  `Occupation` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_职业病危害因素接触史，{字典30}',
  `TypeOfWork` varchar(100) DEFAULT NULL COMMENT '生活方式指导_工种',
  `WorkTime` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_从业时间(年)',
  `Dust` varchar(50) DEFAULT NULL COMMENT '生活方式指导_粉尘',
  `DustGuard` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_粉尘防护措施，{字典31}',
  `DustGuard_Desc` varchar(50) DEFAULT NULL COMMENT '生活方式指导_粉尘防护措施描述',
  `Radiogen` varchar(50) DEFAULT NULL COMMENT '生活方式指导_放射物质',
  `RadiogenGuard` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_放射物质防护措施，{字典32}',
  `RadiogenGuard_Desc` varchar(50) DEFAULT NULL COMMENT '生活方式指导_放射物质防护措施描述',
  `Physical` varchar(50) DEFAULT NULL COMMENT '生活方式指导_物理因素',
  `PhysicalGuard` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_物理因素防护措施，{字典33}',
  `PhysicalGuard_Desc` varchar(50) DEFAULT NULL COMMENT '生活方式指导_物理因素防护措施描述',
  `Chemical` varchar(50) DEFAULT NULL COMMENT '生活方式指导_化学物质',
  `ChemicalGuard` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_化学物质防护措施，{字典34}',
  `ChemicalGuard_Desc` varchar(50) DEFAULT NULL COMMENT '生活方式指导_化学物质防护措施描述',
  `ToxicOther` varchar(50) DEFAULT NULL COMMENT '生活方式指导_其他',
  `ToxicOtherGuard` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_其他防护措施，{字典35}',
  `ToxicOtherGuard_Desc` varchar(50) DEFAULT NULL COMMENT '生活方式指导_其他防护措施描述',
  `Lips` tinyint(4) DEFAULT NULL COMMENT '脏器功能_口唇，{字典36}',
  `Dentition` tinyint(4) DEFAULT NULL COMMENT '脏器功能_齿列，{字典37}',
  `Dentition_Desc` varchar(100) DEFAULT NULL COMMENT '脏器功能_齿列描述',
  `Throat` tinyint(4) DEFAULT NULL COMMENT '脏器功能_咽部，{字典38}',
  `LeftVision` decimal(3,1) DEFAULT NULL COMMENT '脏器功能_左眼视力',
  `RightVision` decimal(3,1) DEFAULT NULL COMMENT '脏器功能_右眼视力',
  `LeftCorrectVision` decimal(3,1) DEFAULT NULL COMMENT '脏器功能_左眼矫正视力',
  `RightCorrectVision` decimal(3,1) DEFAULT NULL COMMENT '脏器功能_右眼矫正视力',
  `Hearing` tinyint(4) DEFAULT NULL COMMENT '脏器功能_听力，{字典39}',
  `Movement` tinyint(4) DEFAULT NULL COMMENT '脏器功能_运动功能，{字典40}',
  `Eyeground` tinyint(4) DEFAULT NULL COMMENT '查体_眼底，{字典41}',
  `Eyeground_Desc` varchar(100) DEFAULT NULL COMMENT '查体_眼底描述',
  `Skin` tinyint(4) DEFAULT NULL COMMENT '查体_皮肤，{字典42}',
  `Skin_Desc` varchar(100) DEFAULT NULL COMMENT '查体_皮肤其他描述',
  `Sclero` tinyint(4) DEFAULT NULL COMMENT '查体_巩膜，{字典43}',
  `Sclero_Desc` varchar(100) DEFAULT NULL COMMENT '查体_巩膜其他描述',
  `Lymph` tinyint(4) DEFAULT NULL COMMENT '查体_淋巴结，{字典44}',
  `Lymph_Desc` varchar(100) DEFAULT NULL COMMENT '查体_淋巴结其他描述',
  `LungBarrelChest` tinyint(4) DEFAULT NULL COMMENT '查体_肺桶状胸，{字典45}',
  `LungBreathSounds` tinyint(4) DEFAULT NULL COMMENT '查体_肺呼吸音，{字典46}',
  `LungBreathSounds_Desc` varchar(100) DEFAULT NULL COMMENT '查体_肺呼吸音异常描述',
  `LungRales` tinyint(4) DEFAULT NULL COMMENT '查体_肺罗音，{字典47}',
  `LungRales_Desc` varchar(100) DEFAULT NULL COMMENT '查体_肺罗音其他描述',
  `HeartRate` smallint(6) DEFAULT NULL COMMENT '查体_心率(次/分钟)',
  `Rhythm` tinyint(4) DEFAULT NULL COMMENT '查体_心律，{字典48}',
  `Murmur` tinyint(4) DEFAULT NULL COMMENT '查体_杂音，{字典49}',
  `Murmur_Desc` varchar(100) DEFAULT NULL COMMENT '查体_杂音描述',
  `Pain` tinyint(4) DEFAULT NULL COMMENT '查体_腹压痛，{字典50}',
  `Pain_Desc` varchar(100) DEFAULT NULL COMMENT '查体_腹压痛描述',
  `Block` tinyint(4) DEFAULT NULL COMMENT '查体_腹包块，{字典51}',
  `Block_Desc` varchar(100) DEFAULT NULL COMMENT '查体_腹包块描述',
  `Hepatomegaly` tinyint(4) DEFAULT NULL COMMENT '查体_腹肝大，{字典52}',
  `Hepatomegaly_Desc` varchar(100) DEFAULT NULL COMMENT '查体_腹肝大描述',
  `Splenomegaly` tinyint(4) DEFAULT NULL COMMENT '查体_腹脾大，{字典53}',
  `Splenomegaly_Desc` varchar(100) DEFAULT NULL COMMENT '查体_腹脾大描述',
  `MoveSonant` tinyint(4) DEFAULT NULL COMMENT '查体_腹移动浊音，{字典54}',
  `MoveSonant_Desc` varchar(100) DEFAULT NULL COMMENT '查体_腹移动浊音描述',
  `LowLimbEdema` tinyint(4) DEFAULT NULL COMMENT '查体_下肢水肿，{字典55}',
  `Arteriopalmus` tinyint(4) DEFAULT NULL COMMENT '查体_足背动脉搏动，{字典56}',
  `AnusTactus` tinyint(4) DEFAULT NULL COMMENT '查体_肛门指诊，{字典57}',
  `AnusTactus_Desc` varchar(100) DEFAULT NULL COMMENT '查体_肛门指诊描述',
  `Breast` varchar(20) DEFAULT NULL COMMENT '查体_乳腺_列表(以@#拼接)，{字典58}',
  `Breast_Desc` varchar(100) DEFAULT NULL COMMENT '查体_乳腺其他描述',
  `Pudendum` tinyint(4) DEFAULT NULL COMMENT '查体_外阴，{字典59}',
  `Pudendum_Desc` varchar(100) DEFAULT NULL COMMENT '查体_外阴异常描述',
  `Vagina` tinyint(4) DEFAULT NULL COMMENT '查体_阴道，{字典60}',
  `Vagina_Desc` varchar(100) DEFAULT NULL COMMENT '查体_阴道异常描述',
  `Cervical` tinyint(4) DEFAULT NULL COMMENT '查体_宫颈，{字典61}',
  `Cervical_Desc` varchar(100) DEFAULT NULL COMMENT '查体_宫颈异常描述',
  `Uteri` tinyint(4) DEFAULT NULL COMMENT '查体_宫体，{字典62}',
  `Uteri_Desc` varchar(100) DEFAULT NULL COMMENT '查体_宫体异常描述',
  `Enclosure` tinyint(4) DEFAULT NULL COMMENT '查体_附件，{字典63}',
  `Enclosure_Desc` varchar(100) DEFAULT NULL COMMENT '查体_附件异常描述',
  `GynaecologyOther` varchar(100) DEFAULT NULL COMMENT '查体_妇科其他',
  `Hemoglobin` smallint(6) DEFAULT NULL COMMENT '辅助检查_血红蛋白(g/L)',
  `Leukocyte` decimal(4,1) DEFAULT NULL COMMENT '辅助检查_白细胞(10E9/L)',
  `Platelet` smallint(6) DEFAULT NULL COMMENT '辅助检查_血小板(10E9/L)',
  `BloodOther` varchar(100) DEFAULT NULL COMMENT '辅助检查_血常规其他',
  `UrineProtein` varchar(100) DEFAULT NULL COMMENT '辅助检查_尿蛋白',
  `UrineSugar` varchar(100) DEFAULT NULL COMMENT '辅助检查_尿糖',
  `UrineAcetoneBody` varchar(100) DEFAULT NULL COMMENT '辅助检查_尿酮体',
  `UrineOccultBlood` varchar(100) DEFAULT NULL COMMENT '辅助检查_尿潜血',
  `UrineOther` varchar(100) DEFAULT NULL COMMENT '辅助检查_尿常规其他',
  `GLU` decimal(5,2) DEFAULT NULL COMMENT '[2.1]辅助检查_空腹血糖值(mmol/L)',
  `PGLU` decimal(5,2) DEFAULT NULL COMMENT '[2.1]辅助检查_餐后血糖(mmol/L)',
  `Cardiogram` tinyint(4) DEFAULT NULL COMMENT '辅助检查_心电图，{字典64}',
  `Cardiogram_Desc` varchar(100) DEFAULT NULL COMMENT '辅助检查_心电图异常描述',
  `UrineMicroAlbumin` decimal(5,1) DEFAULT NULL COMMENT '辅助检查_尿微量白蛋白(mg/dL)',
  `FecalOccultBlood` tinyint(4) DEFAULT NULL COMMENT '辅助检查_大便潜血，{字典65}',
  `HBA1C` decimal(4,1) DEFAULT NULL COMMENT '辅助检查_糖化血红蛋白(%)',
  `HBSAG` tinyint(4) DEFAULT NULL COMMENT '辅助检查_乙肝表面抗原，{字典66}',
  `CPT` smallint(6) DEFAULT NULL COMMENT '辅助检查_血清谷丙转氨酶(U/L)',
  `AST` smallint(6) DEFAULT NULL COMMENT '辅助检查_血清谷草转氨酶(U/L)',
  `ALB` smallint(6) DEFAULT NULL COMMENT '辅助检查_白蛋白(g/L)',
  `TBIL` decimal(4,1) DEFAULT NULL COMMENT '辅助检查_总胆红素(μmol/L)',
  `CBIL` decimal(5,1) DEFAULT NULL COMMENT '辅助检查_结合胆红素(μmol/L)',
  `CR` decimal(6,2) DEFAULT NULL COMMENT '[2.1]辅助检查_血清肌酐(μmol/L)',
  `BUN` decimal(5,2) DEFAULT NULL COMMENT '[2.1]辅助检查_血尿素氮(mmol/L)',
  `SerumPotassium` decimal(5,2) DEFAULT NULL COMMENT '[2.1]辅助检查_血钾浓度(mmol/L)',
  `SerumSodium` decimal(6,2) DEFAULT NULL COMMENT '[2.1]辅助检查_血钠浓度(mmol/L)',
  `CHOL` decimal(5,2) DEFAULT NULL COMMENT '辅助检查_总胆固醇(mmol/L)',
  `TG` decimal(4,2) DEFAULT NULL COMMENT '[2.1]辅助检查_甘油三酯(mmol/L)',
  `LDL_C` decimal(5,2) DEFAULT NULL COMMENT '辅助检查_血清低密度脂蛋白胆固醇(mmol/L)',
  `HDL_C` decimal(5,2) DEFAULT NULL COMMENT '辅助检查_血清高密度脂蛋白胆固醇(mmol/L)',
  `X_RAY` tinyint(4) DEFAULT NULL COMMENT '辅助检查_胸部X线片，{字典67}',
  `X_RAY_Desc` varchar(100) DEFAULT NULL COMMENT '辅助检查_胸部X线片异常描述',
  `B_Ultrasonic` tinyint(4) DEFAULT NULL COMMENT '辅助检查_B超，{字典68}',
  `B_Ultrasonic_Desc` varchar(100) DEFAULT NULL COMMENT '辅助检查_B超异常描述',
  `CervicalSmear` tinyint(4) DEFAULT NULL COMMENT '辅助检查_宫颈涂片，{字典69}',
  `CervicalSmear_Desc` varchar(100) DEFAULT NULL COMMENT '辅助检查_宫颈涂片异常描述',
  `AssistCheckOther` varchar(100) DEFAULT NULL COMMENT '辅助检查_其他描述',
  `TCM_PHZ` tinyint(4) DEFAULT NULL COMMENT '中医体质辨识_平和质_辨识结果，{字典70}',
  `TCM_PHZ_Guide` varchar(20) DEFAULT NULL COMMENT '中医体质辨识_平和质_保健指导_列表(以@#拼接)，{字典91}',
  `TCM_PHZ_Guide_Desc` varchar(100) DEFAULT NULL COMMENT '中医体质辨识_平和质_保健指导_其它描述',
  `TCM_QXZ` tinyint(4) DEFAULT NULL COMMENT '中医体质辨识_气虚质_辨识结果，{字典71}',
  `TCM_QXZ_Guide` varchar(20) DEFAULT NULL COMMENT '中医体质辨识_气虚质_保健指导_列表(以@#拼接)，{字典92}',
  `TCM_QXZ_Guide_Desc` varchar(100) DEFAULT NULL COMMENT '中医体质辨识_气虚质_保健指导_其它描述',
  `TCM_YXZ` tinyint(4) DEFAULT NULL COMMENT '中医体质辨识_阳虚质_辨识结果，{字典72}',
  `TCM_YXZ_Guide` varchar(20) DEFAULT NULL COMMENT '中医体质辨识_阳虚质_保健指导_列表(以@#拼接)，{字典93}',
  `TCM_YXZ_Guide_Desc` varchar(100) DEFAULT NULL COMMENT '中医体质辨识_阳虚质_保健指导_其它描述',
  `TCM_YIXZ` tinyint(4) DEFAULT NULL COMMENT '中医体质辨识_阴虚质_辨识结果，{字典73}',
  `TCM_YIXZ_Guide` varchar(20) DEFAULT NULL COMMENT '中医体质辨识_阴虚质_保健指导_列表(以@#拼接)，{字典94}',
  `TCM_YIXZ_Guide_Desc` varchar(100) DEFAULT NULL COMMENT '中医体质辨识_阴虚质_保健指导_其它描述',
  `TCM_TSZ` tinyint(4) DEFAULT NULL COMMENT '中医体质辨识_痰湿质_辨识结果，{字典74}',
  `TCM_TSZ_Guide` varchar(20) DEFAULT NULL COMMENT '中医体质辨识_痰湿质_保健指导_列表(以@#拼接)，{字典95}',
  `TCM_TSZ_Guide_Desc` varchar(100) DEFAULT NULL COMMENT '中医体质辨识_痰湿质_保健指导_其它描述',
  `TCM_SRZ` tinyint(4) DEFAULT NULL COMMENT '中医体质辨识_温热质_辨识结果，{字典75}',
  `TCM_SRZ_Guide` varchar(20) DEFAULT NULL COMMENT '中医体质辨识_温热质_保健指导_列表(以@#拼接)，{字典96}',
  `TCM_SRZ_Guide_Desc` varchar(100) DEFAULT NULL COMMENT '中医体质辨识_温热质_保健指导_其它描述',
  `TCM_XTZ` tinyint(4) DEFAULT NULL COMMENT '中医体质辨识_血瘀质_辨识结果，{字典76}',
  `TCM_XTZ_Guide` varchar(20) DEFAULT NULL COMMENT '中医体质辨识_血瘀质_保健指导_列表(以@#拼接)，{字典97}',
  `TCM_XTZ_Guide_Desc` varchar(100) DEFAULT NULL COMMENT '中医体质辨识_血瘀质_保健指导_其它描述',
  `TCM_QYZ` tinyint(4) DEFAULT NULL COMMENT '中医体质辨识_气郁质_辨识结果，{字典77}',
  `TCM_QYZ_Guide` varchar(20) DEFAULT NULL COMMENT '中医体质辨识_气郁质_保健指导_列表(以@#拼接)，{字典98}',
  `TCM_QYZ_Guide_Desc` varchar(100) DEFAULT NULL COMMENT '中医体质辨识_气郁质_保健指导_其它描述',
  `TCM_TBZ` tinyint(4) DEFAULT NULL COMMENT '中医体质辨识_特秉质_辨识结果，{字典78}',
  `TCM_TBZ_Guide` varchar(20) DEFAULT NULL COMMENT '中医体质辨识_特秉质_保健指导_列表(以@#拼接)，{字典99}',
  `TCM_TBZ_Guide_Desc` varchar(100) DEFAULT NULL COMMENT '中医体质辨识_特秉质_保健指导_其它描述',
  `CerebralVessel` varchar(30) DEFAULT NULL COMMENT '现存主要健康问题_脑血管疾病_列表(以@#拼接)，{字典79}',
  `CerebralVessel_Desc` varchar(100) DEFAULT NULL COMMENT '现存主要健康问题_脑血管疾病其他描述',
  `Kidney` varchar(30) DEFAULT NULL COMMENT '现存主要健康问题_肾脏疾病_列表(以@#拼接)，{字典80}',
  `Kidney_Desc` varchar(100) DEFAULT NULL COMMENT '现存主要健康问题_肾脏疾病其他描述',
  `Heart` varchar(30) DEFAULT NULL COMMENT '现存主要健康问题_心脏疾病_列表(以@#拼接)，{字典81}',
  `Heart_Desc` varchar(100) DEFAULT NULL COMMENT '现存主要健康问题_心脏疾病其他描述',
  `BloodPipe` varchar(20) DEFAULT NULL COMMENT '现存主要健康问题_血管疾病_列表(以@#拼接)，{字典82}',
  `BloodPipe_Desc` varchar(100) DEFAULT NULL COMMENT '现存主要健康问题_血管疾病其他描述',
  `EyePart` varchar(20) DEFAULT NULL COMMENT '现存主要健康问题_眼部疾病_列表(以@#拼接)，{字典83}',
  `EyePart_Desc` varchar(100) DEFAULT NULL COMMENT '现存主要健康问题_眼部疾病其他描述',
  `NervousSystem` tinyint(4) DEFAULT NULL COMMENT '现存主要健康问题_神经系统疾病，{字典84}',
  `NervousSystem_Desc` varchar(100) DEFAULT NULL COMMENT '现存主要健康问题_神经系统疾病描述',
  `OtherSystem` tinyint(4) DEFAULT NULL COMMENT '现存主要健康问题_其他系统疾病，{字典85}',
  `OtherSystem_Desc` varchar(100) DEFAULT NULL COMMENT '现存主要健康问题_其他系统疾病描述',
  `HealthEvaluate` tinyint(4) DEFAULT NULL COMMENT '健康评价，{字典87}',
  `HealthEvaluate_Desc` varchar(1000) DEFAULT NULL COMMENT '健康评价异常描述(以@#拼接)',
  `HealthGuide` varchar(20) DEFAULT NULL COMMENT '健康指导_列表(以@#拼接)，{字典88}',
  `RiskFactor` varchar(30) DEFAULT NULL COMMENT '危险因素控制_列表(以@#拼接)，{字典89}',
  `RiskFactor_Target` varchar(10) DEFAULT NULL COMMENT '危险因素控制_目标',
  `RiskFactor_Vaccine` varchar(100) DEFAULT NULL COMMENT '危险因素控制_疫苗',
  `RiskFactor_Other` varchar(100) DEFAULT NULL COMMENT '危险因素控制_其他',
  PRIMARY KEY (`HExamID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公共卫生_健康体检明细表';

/*Table structure for table `ph_healthexamdetailfamilybed` */

DROP TABLE IF EXISTS `ph_healthexamdetailfamilybed`;

CREATE TABLE `ph_healthexamdetailfamilybed` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `HExamID` int(11) NOT NULL COMMENT '体检主ID',
  `StartDate` datetime DEFAULT NULL COMMENT '建床日期',
  `EndTime` datetime DEFAULT NULL COMMENT '撤床日期',
  `Resson` varchar(100) DEFAULT NULL COMMENT '原因',
  `Institution` varchar(70) DEFAULT NULL COMMENT '医疗机构名称',
  `PatientID` varchar(20) DEFAULT NULL COMMENT '病案号',
  PRIMARY KEY (`LogID`),
  KEY `idx_HEID` (`HExamID`)
) ENGINE=InnoDB AUTO_INCREMENT=459 DEFAULT CHARSET=utf8 COMMENT='公共卫生_健康体检明细_家庭病床史表';

/*Table structure for table `ph_healthexamdetailinpatient` */

DROP TABLE IF EXISTS `ph_healthexamdetailinpatient`;

CREATE TABLE `ph_healthexamdetailinpatient` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `HExamID` int(11) NOT NULL COMMENT '体检主ID',
  `StartDate` datetime DEFAULT NULL COMMENT '入院日期',
  `EndTime` datetime DEFAULT NULL COMMENT '出院日期',
  `Resson` varchar(100) DEFAULT NULL COMMENT '原因',
  `Institution` varchar(70) DEFAULT NULL COMMENT '医疗机构名称',
  `PatientID` varchar(20) DEFAULT NULL COMMENT '病案号',
  PRIMARY KEY (`LogID`),
  KEY `idx_HEID` (`HExamID`)
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=utf8 COMMENT='公共卫生_健康体检明细_住院史表';

/*Table structure for table `ph_healthexamdetailmedicine` */

DROP TABLE IF EXISTS `ph_healthexamdetailmedicine`;

CREATE TABLE `ph_healthexamdetailmedicine` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `HExamID` int(11) NOT NULL COMMENT '体检主ID',
  `DrugName` varchar(50) DEFAULT NULL COMMENT '药物名称',
  `DrugUsage` varchar(30) DEFAULT NULL COMMENT '用法（口服、注射等）',
  `DrugFreq` varchar(30) DEFAULT NULL COMMENT '频率（每日一次等）',
  `DrugDosage` varchar(10) DEFAULT NULL COMMENT '用量',
  `DrugUnit` varchar(20) DEFAULT NULL COMMENT '单位（mg、支等）',
  `DrugUseTime` varchar(20) DEFAULT NULL COMMENT '用药时间',
  `DrugCompliance` tinyint(4) DEFAULT NULL COMMENT '服药依从性，{字典86}',
  `Remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`LogID`),
  KEY `idx_HEID` (`HExamID`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='公共卫生_健康体检明细_主要用药情况表';

/*Table structure for table `ph_healthexamdetailnonimmune` */

DROP TABLE IF EXISTS `ph_healthexamdetailnonimmune`;

CREATE TABLE `ph_healthexamdetailnonimmune` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `HExamID` int(11) NOT NULL COMMENT '体检主ID',
  `VaccinateName` varchar(100) DEFAULT NULL COMMENT '接种名称',
  `VaccinateDate` datetime DEFAULT NULL COMMENT '接种日期',
  `Institution` varchar(70) DEFAULT NULL COMMENT '医疗机构名称',
  PRIMARY KEY (`LogID`),
  KEY `idx_HEID` (`HExamID`)
) ENGINE=InnoDB AUTO_INCREMENT=556 DEFAULT CHARSET=utf8 COMMENT='公共卫生_健康体检明细_非免疫规划预防接种史表';

/*Table structure for table `ph_hypertension` */

DROP TABLE IF EXISTS `ph_hypertension`;

CREATE TABLE `ph_hypertension` (
  `HypertensionID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '高血压随访主ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `Unique_ID` varchar(36) DEFAULT NULL COMMENT '健康档案号',
  `RefCompany` tinyint(4) NOT NULL DEFAULT '0' COMMENT '合作公司，0-录入，{字典1}',
  `RefDataPK` varchar(36) NOT NULL COMMENT '合作公司的业务数据主键值',
  `IDCard` varchar(36) DEFAULT NULL COMMENT '身份证号',
  `Name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `VisitDate` datetime DEFAULT NULL COMMENT '随访日期',
  `VisitDrName` varchar(50) DEFAULT NULL COMMENT '随访医生签名',
  `VisitClass` tinyint(4) NOT NULL DEFAULT '0' COMMENT '此次随访分类，0-待随访，{字典9}',
  `GetTime` datetime NOT NULL COMMENT '最近入库时间',
  `IsDeleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已删除：0-否，1-是',
  `MSETaskID` bigint(20) DEFAULT NULL COMMENT '[3.0]管理方案_执行_任务ID',
  `CreateDrID` int(11) NOT NULL COMMENT '创建医生ID，0-系统(对接)',
  `CreateDrName` varchar(50) NOT NULL COMMENT '创建医生名称',
  `CreateTime` datetime NOT NULL COMMENT '记录创建时间',
  `UpdateDrID` int(11) DEFAULT NULL COMMENT '更新医生ID，0-系统',
  `UpdateDrName` varchar(50) DEFAULT NULL COMMENT '更新医生名称',
  `UpdateTime` datetime DEFAULT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`HypertensionID`),
  UNIQUE KEY `uidx_RDPK_RC` (`RefDataPK`,`RefCompany`),
  KEY `idx_GT` (`GetTime`),
  KEY `idx_MID` (`MemberID`),
  KEY `idx_UID` (`Unique_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=44918 DEFAULT CHARSET=utf8 COMMENT='公共卫生_高血压随访表';

/*Table structure for table `ph_hypertensiondetail` */

DROP TABLE IF EXISTS `ph_hypertensiondetail`;

CREATE TABLE `ph_hypertensiondetail` (
  `HypertensionID` bigint(20) NOT NULL COMMENT '高血压随访主ID',
  `VisitWay` tinyint(4) DEFAULT NULL COMMENT '随访方式，{字典2}',
  `Symptom` varchar(30) DEFAULT NULL COMMENT '症状_列表(以@#拼接)，{字典3}',
  `Symptom_Desc` varchar(200) DEFAULT NULL COMMENT '症状_其他描述',
  `Systolic` smallint(6) DEFAULT NULL COMMENT '体征_收缩压(mmHg)',
  `Diastolic` smallint(6) DEFAULT NULL COMMENT '体征_舒张压(mmHg)',
  `Height` decimal(5,1) DEFAULT NULL COMMENT '体征_身高(cm)',
  `Weight` decimal(5,1) DEFAULT NULL COMMENT '体征_当前体重(kg)',
  `Weight_Next` decimal(5,1) DEFAULT NULL COMMENT '体征_下次目标体重(kg)',
  `BMI` decimal(5,2) DEFAULT NULL COMMENT '体征_当前体质指数',
  `BMI_Next` decimal(5,2) DEFAULT NULL COMMENT '体征_下次目标体质指数',
  `HeartRate` smallint(6) DEFAULT NULL COMMENT '体征_心率',
  `OtherSign` varchar(100) DEFAULT NULL COMMENT '体征_其他',
  `DailySmoking` smallint(6) DEFAULT NULL COMMENT '生活方式指导_当前日吸烟量(支)',
  `DailySmoking_Next` smallint(6) DEFAULT NULL COMMENT '生活方式指导_下次目标日吸烟量(支)',
  `DailyDrink` decimal(3,1) DEFAULT NULL COMMENT '[2.1]生活方式指导_日饮酒量(两)',
  `DailyDrink_Next` decimal(3,1) DEFAULT NULL COMMENT '[2.1]生活方式指导_下次目标日饮酒量(两)',
  `SportFrequency` varchar(20) DEFAULT NULL COMMENT '生活方式指导_当前运动频率(次/周)',
  `SportFrequency_Next` varchar(20) DEFAULT NULL COMMENT '生活方式指导_下次目标运动频率(次/周)',
  `SportDuration` smallint(6) DEFAULT NULL COMMENT '生活方式指导_当前时长(分钟/次)',
  `SportDuration_Next` smallint(6) DEFAULT NULL COMMENT '生活方式指导_下次目标时长(分钟/次)',
  `IntakeSalt` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_当前摄盐情况（咸淡），{字典4}',
  `IntakeSalt_Next` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_下次目标摄盐情况（咸淡），{字典4}',
  `PsychologicalRecovery` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_心理调整，{字典5}',
  `ComplianceBehavior` tinyint(4) DEFAULT NULL COMMENT '生活方式指导_遵医行为，{字典6}',
  `CheckResult` varchar(100) DEFAULT NULL COMMENT '辅助检查',
  `DrugCompliance` tinyint(4) DEFAULT NULL COMMENT '服药依从性，{字典7}',
  `DrugAdverseReaction` tinyint(4) DEFAULT NULL COMMENT '药物不良反应，{字典8}',
  `DrugAdverseReaction_Desc` varchar(100) DEFAULT NULL COMMENT '药物不良反应描述',
  `TransferReason` varchar(100) DEFAULT NULL COMMENT '转诊_原因',
  `TransferOrgAndDept` varchar(50) DEFAULT NULL COMMENT '转诊_机构及科室',
  `VisitDate_Next` datetime DEFAULT NULL COMMENT '下次随访日期',
  PRIMARY KEY (`HypertensionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公共卫生_高血压随访明细表';

/*Table structure for table `ph_hypertensiondetailmedicine` */

DROP TABLE IF EXISTS `ph_hypertensiondetailmedicine`;

CREATE TABLE `ph_hypertensiondetailmedicine` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `HypertensionID` int(11) NOT NULL COMMENT '糖尿病随访主ID',
  `DrugName` varchar(50) DEFAULT NULL COMMENT '药物名称',
  `DrugUsage` varchar(30) DEFAULT NULL COMMENT '用法（口服、注射等）',
  `DrugFreq` varchar(30) DEFAULT NULL COMMENT '频率（每日一次等）',
  `DrugDosage` varchar(10) DEFAULT NULL COMMENT '用量',
  `DrugUnit` varchar(20) DEFAULT NULL COMMENT '单位（mg、支等）',
  `Remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`LogID`),
  KEY `idx_HID` (`HypertensionID`)
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8 COMMENT='公共卫生_高血压随访明细_用药情况表';

/*Table structure for table `tb_advertisement` */

DROP TABLE IF EXISTS `tb_advertisement`;

CREATE TABLE `tb_advertisement` (
  `AID` int(11) NOT NULL AUTO_INCREMENT COMMENT '广告ID',
  `Title` varchar(50) NOT NULL COMMENT '标题',
  `CoverImage` varchar(255) DEFAULT NULL COMMENT '封面图路径',
  `Content` text COMMENT '内容',
  `UsePage` tinyint(4) NOT NULL COMMENT '使用页面：1-App首页，2-App健康中心，3-App选择测量工具，4-健康服务套餐[3.0]',
  `StatusType` tinyint(4) NOT NULL COMMENT '状态：1-新建，2-已发布',
  `ReleaseTime` datetime DEFAULT NULL COMMENT '发布时间',
  `CreateID` int(11) NOT NULL COMMENT '创建者ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`AID`),
  KEY `idx_RT` (`ReleaseTime`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COMMENT='[2.1]广告表';

/*Table structure for table `tb_healtheducation` */

DROP TABLE IF EXISTS `tb_healtheducation`;

CREATE TABLE `tb_healtheducation` (
  `HEducationID` int(11) NOT NULL AUTO_INCREMENT COMMENT '健教ID',
  `HEducationType` tinyint(4) NOT NULL COMMENT '健教类型：1-饮食指导，2-运动指导，3-心理指导，4-中医指导，5-生活方式指导，6-用药指导',
  `Title` varchar(50) NOT NULL COMMENT '标题',
  `SourceWay` tinyint(4) NOT NULL DEFAULT '2' COMMENT '来源方式：1-自定义，2-健康资讯，3-复制网址',
  `SourceID` int(11) DEFAULT NULL COMMENT '来源ID',
  `Content` text COMMENT '内容',
  `OrgID` int(11) NOT NULL COMMENT '组织ID',
  `UseRange` tinyint(4) NOT NULL COMMENT '使用范围：1-全局，2-组织内，3-私有',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`HEducationID`),
  KEY `idx_OID` (`OrgID`),
  KEY `idx_CID` (`CreateID`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8 COMMENT='[3.0]健教库';

/*Table structure for table `tb_healtheducation_disease` */

DROP TABLE IF EXISTS `tb_healtheducation_disease`;

CREATE TABLE `tb_healtheducation_disease` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `HEducationID` int(11) NOT NULL COMMENT '健教ID',
  `MSDiseaseID` int(11) NOT NULL COMMENT '管理方案_疾病ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_HEID` (`HEducationID`),
  KEY `idx_MSDID` (`MSDiseaseID`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8 COMMENT='[3.0]健教库_疾病关系';

/*Table structure for table `tb_healthnews_bookmark` */

DROP TABLE IF EXISTS `tb_healthnews_bookmark`;

CREATE TABLE `tb_healthnews_bookmark` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `HNInfoID` int(11) NOT NULL COMMENT '健康资讯ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_HNIID` (`HNInfoID`),
  KEY `idx_MID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8 COMMENT='[2.1]健康资讯_收藏表';

/*Table structure for table `tb_healthnews_info` */

DROP TABLE IF EXISTS `tb_healthnews_info`;

CREATE TABLE `tb_healthnews_info` (
  `HNInfoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '健康资讯_信息ID',
  `Title` varchar(50) NOT NULL COMMENT '标题',
  `Author` varchar(20) NOT NULL COMMENT '作者',
  `Thumbnail` varchar(255) DEFAULT NULL COMMENT '缩略图路径',
  `CoverImage` varchar(255) DEFAULT NULL COMMENT '封面图路径',
  `Content` text COMMENT '内容',
  `IsStickyPost` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否置顶：0-否，1-是',
  `StatusType` tinyint(4) NOT NULL COMMENT '状态：1-新建，2-已发布，3-已推送，4-已删除',
  `ReleaseTime` datetime DEFAULT NULL COMMENT '发布时间',
  `TakeEffectTime` datetime DEFAULT NULL COMMENT '生效时间',
  `DelReason` varchar(50) DEFAULT NULL COMMENT '已推送的删除原因',
  `CreateID` int(11) NOT NULL COMMENT '创建者ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`HNInfoID`),
  KEY `idx_RT` (`ReleaseTime`),
  KEY `idx_TET` (`TakeEffectTime`)
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8 COMMENT='[2.1]健康资讯_信息表';

/*Table structure for table `tb_healthnews_info_label` */

DROP TABLE IF EXISTS `tb_healthnews_info_label`;

CREATE TABLE `tb_healthnews_info_label` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增记录ID',
  `HNInfoID` int(11) NOT NULL COMMENT '健康资讯_信息ID',
  `HNLabelID` int(11) NOT NULL COMMENT '健康资讯_标签ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_HNIID` (`HNInfoID`),
  KEY `idx_HNLID` (`HNLabelID`)
) ENGINE=InnoDB AUTO_INCREMENT=622 DEFAULT CHARSET=utf8 COMMENT='[2.1]健康资讯_内容与标签关系表';

/*Table structure for table `tb_healthnews_label` */

DROP TABLE IF EXISTS `tb_healthnews_label`;

CREATE TABLE `tb_healthnews_label` (
  `HNLabelID` int(11) NOT NULL AUTO_INCREMENT COMMENT '健康资讯_标签ID',
  `Content` varchar(20) NOT NULL COMMENT '内容',
  `StatusType` tinyint(4) NOT NULL COMMENT '状态：1-新建，2-已启用，3-已禁用',
  `CreateID` int(11) NOT NULL COMMENT '创建者ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`HNLabelID`),
  KEY `idx_CT` (`CreateTime`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8 COMMENT='[2.1]健康资讯_标签表';

/*Table structure for table `tb_healthnews_label_member` */

DROP TABLE IF EXISTS `tb_healthnews_label_member`;

CREATE TABLE `tb_healthnews_label_member` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增记录ID',
  `HNLabelID` int(11) NOT NULL COMMENT '健康资讯_标签ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_HNLID` (`HNLabelID`),
  KEY `idx_MID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=343 DEFAULT CHARSET=utf8 COMMENT='[2.1]健康资讯_标签与会员关系表';

/*Table structure for table `tb_healthnews_praise` */

DROP TABLE IF EXISTS `tb_healthnews_praise`;

CREATE TABLE `tb_healthnews_praise` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增记录ID',
  `HNInfoID` int(11) NOT NULL COMMENT '健康资讯_信息ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_HNIID` (`HNInfoID`),
  KEY `idx_MID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='[2.1]健康资讯_点赞表';

/*Table structure for table `tb_job_config` */

DROP TABLE IF EXISTS `tb_job_config`;

CREATE TABLE `tb_job_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `job_id` varchar(50) DEFAULT NULL COMMENT '定时任务',
  `job_time_expression` varchar(100) DEFAULT NULL COMMENT '定时任务时间',
  `job_name` varchar(50) DEFAULT NULL COMMENT '定时任务名称 job_name',
  `job_status` varchar(20) DEFAULT NULL COMMENT '定时任务状态 job_status',
  `job_desc` varchar(50) DEFAULT NULL COMMENT '定时任务备注 job_desc',
  `job_type` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='[2.1]定时任务配置表';

/*Table structure for table `tb_label_class` */

DROP TABLE IF EXISTS `tb_label_class`;

CREATE TABLE `tb_label_class` (
  `LClassID` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签分类ID',
  `ClassName` varchar(10) NOT NULL COMMENT '名称',
  `Description` varchar(50) DEFAULT NULL COMMENT '描述',
  `IsSystem` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否系统级：0-否，1-是(不可删除)',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LClassID`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8 COMMENT='[3.0]会员标签分类';

/*Table structure for table `tb_label_item` */

DROP TABLE IF EXISTS `tb_label_item`;

CREATE TABLE `tb_label_item` (
  `LItemID` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签小项ID',
  `LClassID` int(11) NOT NULL COMMENT '标签分类ID',
  `ItemName` varchar(10) NOT NULL COMMENT '名称',
  `Remarks` varchar(50) DEFAULT NULL COMMENT '备注',
  `ItemStatus` tinyint(4) NOT NULL COMMENT '状态：1-新增，2-启用，3-禁用',
  `OrgID` int(11) NOT NULL COMMENT '组织ID',
  `UseRange` tinyint(4) NOT NULL COMMENT '使用范围：1-全局，2-组织内，3-私有',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LItemID`),
  KEY `idx_LCID` (`LClassID`),
  KEY `idx_OID` (`OrgID`),
  KEY `idx_CID` (`CreateID`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8 COMMENT='[3.0]会员标签小项表';

/*Table structure for table `tb_log_synchronization` */

DROP TABLE IF EXISTS `tb_log_synchronization`;

CREATE TABLE `tb_log_synchronization` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `ModuleType` tinyint(4) NOT NULL COMMENT '模块类型：1-测量数据，2-好友圈，3-问卷',
  `SourceServiceID` int(11) NOT NULL COMMENT '源服务器ID',
  `SourceMemberGUID` char(36) NOT NULL COMMENT '源会员GUID',
  `TargetServiceID` int(11) NOT NULL COMMENT '目标服务器ID',
  `TargetMemberGUID` char(36) NOT NULL COMMENT '目标会员GUID',
  `SyncStatus` tinyint(4) NOT NULL COMMENT '同步状态：1-待同步，2-同步中，3-成功，4-失败',
  `SyncSTime` datetime DEFAULT NULL COMMENT '同步开始时间',
  `SyncETime` datetime DEFAULT NULL COMMENT '同步结束时间',
  `FailReason` varchar(50) DEFAULT NULL COMMENT '失败原因',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_SSID_SMID` (`SourceServiceID`,`SourceMemberGUID`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='[3.0]日志_同步';

/*Table structure for table `tb_log_update` */

DROP TABLE IF EXISTS `tb_log_update`;

CREATE TABLE `tb_log_update` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '升级记录ID',
  `VersionNo` varchar(10) NOT NULL COMMENT '版本号',
  `Description` varchar(20) DEFAULT NULL COMMENT '描述',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='[3.0]升级记录';

/*Table structure for table `tb_managescheme_design` */

DROP TABLE IF EXISTS `tb_managescheme_design`;

CREATE TABLE `tb_managescheme_design` (
  `MSDesignID` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理方案_制定ID',
  `SchemeType` tinyint(4) NOT NULL COMMENT '方案类型：1-个人，2-群体',
  `SchemeTitle` varchar(20) NOT NULL COMMENT '方案标题',
  `MassStatus` tinyint(4) DEFAULT NULL COMMENT '群体状态：1-制定中，2-已生效，3-已终止',
  `MassEffectTime` datetime DEFAULT NULL COMMENT '群体生效时间',
  `MassOffTime` datetime DEFAULT NULL COMMENT '群体终止时间',
  `MassOffReason` varchar(50) DEFAULT NULL COMMENT '群体终止原因',
  `MassEffectProcess` tinyint(4) DEFAULT NULL COMMENT '群体为已生效的总处理过程；1-未触发，2-生成中，3-已生成，4-生成失败',
  `ExecDrID` int(11) NOT NULL COMMENT '执行医生ID',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MSDesignID`),
  KEY `idx_EDID` (`ExecDrID`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8 COMMENT='[3.0]管理方案_制定';

/*Table structure for table `tb_managescheme_design_detail` */

DROP TABLE IF EXISTS `tb_managescheme_design_detail`;

CREATE TABLE `tb_managescheme_design_detail` (
  `MSDesignID` int(11) NOT NULL COMMENT '管理方案_制定ID',
  `ManageGoal` varchar(500) NOT NULL COMMENT '总体管理目标',
  `BenchmarkTime` tinyint(4) NOT NULL DEFAULT '1' COMMENT '基准时间：1-方案触发时间',
  `SrvLimitValue` smallint(6) DEFAULT NULL COMMENT '服务期限数值',
  `SrvLimitType` tinyint(4) NOT NULL DEFAULT '3' COMMENT '服务期限类型：1-天，2-周，3-月，4-年',
  `IsCharge` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否收费：0-否，1-是',
  `Price` decimal(10,2) DEFAULT NULL COMMENT '收费价格(元)',
  `FileName` varchar(100) DEFAULT NULL COMMENT '附件显示名称',
  `FilePath` varchar(255) DEFAULT NULL COMMENT '附件路径+文件名',
  `Introduction` varchar(500) DEFAULT NULL COMMENT '方案介绍',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MSDesignID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='[3.0]管理方案_制定_明细';

/*Table structure for table `tb_managescheme_design_task` */

DROP TABLE IF EXISTS `tb_managescheme_design_task`;

CREATE TABLE `tb_managescheme_design_task` (
  `MSDTaskID` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理方案_制定_任务ID',
  `MSDesignID` int(11) NOT NULL COMMENT '管理方案_制定ID',
  `PlanTimeValue` smallint(6) DEFAULT NULL COMMENT '计划时间数值(基准时间后)',
  `PlanTimeType` tinyint(4) DEFAULT NULL COMMENT '计划时间的类型：1-天，2-周，3-月，4-年',
  `TaskType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '任务类型：1-健教，2-复诊，3-测量，4-问卷调查，5-高血压随访(公卫)，6-糖尿病随访(公卫)，7-阶段总结',
  `TaskRefID` bigint(20) DEFAULT NULL COMMENT '任务引用表记录ID，如健教ID或问卷ID',
  `ExecWay` tinyint(4) NOT NULL DEFAULT '3' COMMENT '执行方式：1-医生电话服务，2-医生现场服务，3-推送消息给会员',
  `Summary` varchar(100) NOT NULL COMMENT '任务概述',
  `Content` text COMMENT '详情内容/任务说明',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MSDTaskID`),
  KEY `idx_MSDID` (`MSDesignID`)
) ENGINE=InnoDB AUTO_INCREMENT=807 DEFAULT CHARSET=utf8 COMMENT='[3.0]管理方案_制定_任务';

/*Table structure for table `tb_managescheme_disease` */

DROP TABLE IF EXISTS `tb_managescheme_disease`;

CREATE TABLE `tb_managescheme_disease` (
  `MSDiseaseID` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理方案_疾病ID',
  `DiseaseName` varchar(10) NOT NULL COMMENT '名称',
  `ParentID` int(11) NOT NULL COMMENT '父疾病ID',
  `SortNo` int(11) NOT NULL COMMENT '排序号',
  `Description` varchar(100) DEFAULT NULL COMMENT '描述',
  `Path` varchar(255) NOT NULL COMMENT '路径，如,0,1,2,',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MSDiseaseID`),
  KEY `idx_PID` (`ParentID`),
  KEY `idx_P50` (`Path`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 COMMENT='[3.0]管理方案_疾病';

/*Table structure for table `tb_managescheme_exec` */

DROP TABLE IF EXISTS `tb_managescheme_exec`;

CREATE TABLE `tb_managescheme_exec` (
  `MSExecID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '管理方案_个人执行ID',
  `MSDesignID` int(11) NOT NULL COMMENT '管理方案_制定ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `ExecStatus` tinyint(4) NOT NULL COMMENT '执行状态：1-制定中，2-执行中，3-无任务，4-已终止',
  `ExecOffTime` datetime DEFAULT NULL COMMENT '执行终止时间',
  `ExecOffReason` varchar(50) DEFAULT NULL COMMENT '执行终止原因',
  `MEPersonProcess` tinyint(4) DEFAULT NULL COMMENT '群体为已生效的个人处理过程；1-未触发，2-生成中，3-已生成，4-生成失败',
  `MEPTriggerTime` datetime DEFAULT NULL COMMENT '群体为已生效的个人触发时间',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MSExecID`),
  UNIQUE KEY `uk_MSDID_MID` (`MSDesignID`,`MemberID`),
  KEY `idx_MID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=33542 DEFAULT CHARSET=utf8 COMMENT='[3.0]管理方案_个人执行';

/*Table structure for table `tb_managescheme_exec_task` */

DROP TABLE IF EXISTS `tb_managescheme_exec_task`;

CREATE TABLE `tb_managescheme_exec_task` (
  `MSETaskID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '管理方案_个人执行_任务ID',
  `MSExecID` int(11) NOT NULL COMMENT '管理方案_执行ID',
  `MSDTaskID` int(11) NOT NULL COMMENT '管理方案_制定_任务ID',
  `PlanTime` datetime NOT NULL COMMENT '计划时间',
  `ExecTime` datetime DEFAULT NULL COMMENT '执行时间',
  `ExecResult` text COMMENT '执行结果/总结',
  `ExecStatus` tinyint(4) NOT NULL COMMENT '执行状态：1-待执行，2-已执行，3-已终止',
  `ConclusionType` tinyint(4) DEFAULT NULL COMMENT '结论类型：1-继续执行，2-终止方案，3-执行下一阶段方案',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MSETaskID`),
  KEY `idx_MSEID_PT` (`MSExecID`,`PlanTime`),
  KEY `idx_MSDTID` (`MSDTaskID`)
) ENGINE=InnoDB AUTO_INCREMENT=745 DEFAULT CHARSET=utf8 COMMENT='[3.0]管理方案_个人执行_任务';

/*Table structure for table `tb_managescheme_templet` */

DROP TABLE IF EXISTS `tb_managescheme_templet`;

CREATE TABLE `tb_managescheme_templet` (
  `MSTempletID` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理方案_模板ID',
  `SchemeTitle` varchar(20) NOT NULL COMMENT '方案标题',
  `ManageGoal` varchar(500) NOT NULL COMMENT '总体管理目标',
  `BenchmarkTime` tinyint(4) NOT NULL DEFAULT '1' COMMENT '基准时间：1-方案触发时间',
  `SrvLimitValue` smallint(6) DEFAULT NULL COMMENT '服务期限数值',
  `SrvLimitType` tinyint(4) NOT NULL DEFAULT '3' COMMENT '服务期限类型：1-天，2-周，3-月，4-年',
  `IsCharge` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否收费：0-否，1-是',
  `Price` decimal(10,2) DEFAULT NULL COMMENT '收费价格(元)',
  `FileName` varchar(255) DEFAULT NULL COMMENT '附件显示名称',
  `FilePath` varchar(255) DEFAULT NULL COMMENT '附件路径+文件名',
  `Introduction` varchar(500) DEFAULT NULL COMMENT '方案介绍',
  `UsedNumber` int(11) DEFAULT NULL COMMENT '被使用次数',
  `TempletStatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1-新增，2-生效，3-作废',
  `OrgID` int(11) NOT NULL COMMENT '组织ID',
  `UseRange` tinyint(4) NOT NULL COMMENT '使用范围：1-全局，2-组织内，3-私有',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MSTempletID`),
  KEY `idx_OID` (`OrgID`),
  KEY `idx_CID` (`CreateID`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 COMMENT='[3.0]管理方案_模板';

/*Table structure for table `tb_managescheme_templet_disease` */

DROP TABLE IF EXISTS `tb_managescheme_templet_disease`;

CREATE TABLE `tb_managescheme_templet_disease` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `MSTempletID` int(11) NOT NULL COMMENT '管理方案_模板ID',
  `MSDiseaseID` int(11) NOT NULL COMMENT '疾病ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_MSTID` (`MSTempletID`),
  KEY `idx_MSDID` (`MSDiseaseID`)
) ENGINE=InnoDB AUTO_INCREMENT=396 DEFAULT CHARSET=utf8 COMMENT='[3.0]管理方案_模板_疾病关系';

/*Table structure for table `tb_managescheme_templet_task` */

DROP TABLE IF EXISTS `tb_managescheme_templet_task`;

CREATE TABLE `tb_managescheme_templet_task` (
  `MSTTaskID` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理方案_模板_任务ID',
  `MSTempletID` int(11) NOT NULL COMMENT '管理方案_模板ID',
  `PlanTimeValue` smallint(6) NOT NULL COMMENT '计划时间数值(基准时间后)',
  `PlanTimeType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '计划时间的类型：1-天，2-周，3-月，4-年',
  `TaskType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '任务类型：1-健教，2-复诊，3-测量，4-问卷调查，5-高血压随访(公卫)，6-糖尿病随访(公卫)，7-阶段总结',
  `TaskRefID` bigint(20) DEFAULT NULL COMMENT '任务引用表记录ID，如健教ID或问卷ID',
  `ExecWay` tinyint(4) NOT NULL DEFAULT '3' COMMENT '执行方式：1-医生电话服务，2-医生现场服务，3-推送消息给会员',
  `Summary` varchar(100) NOT NULL COMMENT '任务概述',
  `Content` text COMMENT '详情内容/任务说明',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MSTTaskID`),
  KEY `idx_MSTID` (`MSTempletID`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8 COMMENT='[3.0]管理方案_模板_任务';

/*Table structure for table `tb_member_device` */

DROP TABLE IF EXISTS `tb_member_device`;

CREATE TABLE `tb_member_device` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `DeviceType` tinyint(4) NOT NULL COMMENT '设备类别：1-血压，2-血糖',
  `DeviceCode` varchar(20) NOT NULL COMMENT '设备Code',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_MID` (`MemberID`),
  KEY `idx_DC10` (`DeviceCode`(10))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='[3.0]会员_设备关系';

/*Table structure for table `tb_transfertreatment` */

DROP TABLE IF EXISTS `tb_transfertreatment`;

CREATE TABLE `tb_transfertreatment` (
  `TTreatmentID` int(11) NOT NULL AUTO_INCREMENT COMMENT '转诊ID',
  `MemberID` int(11) NOT NULL COMMENT '会员ID',
  `OrgAndDept` varchar(50) NOT NULL COMMENT '转诊机构和科室',
  `Reason` varchar(100) NOT NULL COMMENT '转诊原因',
  `Result` varchar(100) DEFAULT NULL COMMENT '转诊原因',
  `TreatTime` datetime DEFAULT NULL COMMENT '转诊时间',
  `TreatStatus` tinyint(4) NOT NULL COMMENT '转诊状态：1-转诊申请，2-取消转诊，3-已转诊',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`TTreatmentID`),
  KEY `idx_MID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COMMENT='[3.0]转诊';

/*Table structure for table `template` */

DROP TABLE IF EXISTS `template`;

CREATE TABLE `template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模板id',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `type` int(1) NOT NULL COMMENT '类别：1-报告审核意见，2-答卷审核意见',
  `orgId` int(11) NOT NULL COMMENT '所属组织',
  `createTime` varchar(20) NOT NULL COMMENT '创建时间',
  `content` text NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='模板';

/*Table structure for table `uai21` */

DROP TABLE IF EXISTS `uai21`;

CREATE TABLE `uai21` (
  `AnsNumber` int(11) NOT NULL COMMENT '答卷编号',
  `Problemid` int(11) NOT NULL COMMENT '问题ID',
  `Ansid` smallint(6) NOT NULL COMMENT '答案ID',
  `Score` double(6,1) DEFAULT NULL COMMENT '对应分值',
  `Fillblank` varchar(100) DEFAULT NULL COMMENT '填空',
  PRIMARY KEY (`AnsNumber`,`Problemid`,`Ansid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员答卷答案明细';

/*Table structure for table `uai3` */

DROP TABLE IF EXISTS `uai3`;

CREATE TABLE `uai3` (
  `AnsNumber` int(11) NOT NULL COMMENT '答卷编号',
  `LineNum` smallint(6) NOT NULL COMMENT '行号',
  `FunId` smallint(6) DEFAULT NULL COMMENT '功能代码',
  `OptId` smallint(6) DEFAULT NULL COMMENT '选项代码',
  `AuditLevel` smallint(6) DEFAULT NULL COMMENT '审核级别',
  `Docid` int(11) DEFAULT NULL COMMENT '审核医生',
  `AuditDesc` text COMMENT '审核意见',
  `AuditTime` datetime DEFAULT NULL COMMENT '审核时间',
  `AuditMode` char(1) DEFAULT NULL COMMENT '审核方式',
  `diagnosis` varchar(255) DEFAULT NULL COMMENT '诊断'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单份答卷审核结果';

/*Table structure for table `uai4` */

DROP TABLE IF EXISTS `uai4`;

CREATE TABLE `uai4` (
  `AnsNumber` int(11) NOT NULL COMMENT '答卷编号',
  `LineNum` smallint(6) NOT NULL COMMENT '行号',
  `Score` double(6,1) DEFAULT NULL COMMENT '对应分值',
  `Conclusion` varchar(100) DEFAULT NULL COMMENT '结论',
  PRIMARY KEY (`AnsNumber`,`LineNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Procedure structure for procedure `proc_getAllMemListByDocId` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_getAllMemListByDocId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_getAllMemListByDocId`(
  IN iDocId INT,
  IN iMemGrpid INT,
  IN vMemName VARCHAR(20),
  IN vMemNameCode VARCHAR(20),
  IN cGender CHAR(1),
  IN vTel VARCHAR(30),
  IN vIdCard VARCHAR(30),
  IN dSBirthDate VARCHAR(10),
  IN dEBirthDate VARCHAR(10),
  IN vAddress VARCHAR(200),
  IN vDiseaseName VARCHAR(30),
  
  IN iMemId INT,
  IN iQustid INT,
  IN iCombQustid INT,
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT
)
    COMMENT '[2.1SP1]全部会员-查询'
label:BEGIN
  DECLARE iOrgId INT;
  
  SET group_concat_max_len = 10240;
  SET iCount = 0;
  
  SELECT OrgId INTO iOrgId FROM odoc WHERE Docid = iDocId;
  
  SET @SQL = ' omem t WHERE t.useTag = ''T''';
  SET @SQL = CONCAT(@SQL, ' AND t.OrgId = ', iOrgId);
  
  IF vMemName IS NOT NULL AND vMemName != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemName LIKE ''',vMemName,'%'''); END IF;
  IF vMemNameCode IS NOT NULL AND vMemNameCode != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemNameCode LIKE ''',vMemNameCode,'%'''); END IF;
  IF cGender IS NOT NULL AND cGender != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Gender = ''',cGender,''''); END IF;
  IF vTel IS NOT NULL AND vTel != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Tel LIKE ''%',vTel,'%'''); END IF;
  IF vIdCard IS NOT NULL AND vIdCard != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.IdCard LIKE ''%',vIdCard,'%'''); END IF;
  IF dSBirthDate IS NOT NULL AND dSBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.BirthDate >= ''',dSBirthDate,''''); END IF;
  IF dEBirthDate IS NOT NULL AND dEBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.BirthDate <= ''',dEBirthDate,''''); END IF;
  IF vAddress IS NOT NULL AND vAddress != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Address LIKE ''%',vAddress,'%'''); END IF;
  IF vDiseaseName IS NOT NULL AND vDiseaseName != '' THEN SET @SQL = CONCAT(' mem3 f,', @SQL, ' AND f.Memberid = t.Memberid AND f.DiseaseName LIKE ''%',vDiseaseName,'%'''); END IF;
  IF iMemId != -1 THEN SET @SQL = CONCAT(' omes a,', @SQL, ' AND a.MemId = t.MemId AND a.Tag = ''T'' AND a.MemId = ', iMemId); END IF;
  
  SET @count_SQL = CONCAT('SELECT COUNT(DISTINCT t.memberid) INTO @iCount FROM', @SQL);
  PREPARE stmt FROM @count_SQL;
  EXECUTE stmt;
  SET iCount = @iCount;
  
  SET @SQL = CONCAT(@SQL, ' ORDER BY t.memberid DESC');
  SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
  SET @SQL = CONCAT(' SELECT DISTINCT t.memberid FROM', @SQL);
  
  SET @SQL = CONCAT(' FROM (', @SQL, ')t');
  SET @SQL = CONCAT(' MAX(c.UploadTime) AS last_UploadTime, GROUP_CONCAT(DISTINCT f.MemGrpID) AS MemGrpID_List, GROUP_CONCAT(DISTINCT f.MemGrpName) AS MemGrpName_List, g.MemDesc',@SQL);
  SET @SQL = CONCAT(' GROUP_CONCAT(DISTINCT b.DiseaseName) AS DiseaseName_List,',@SQL);
  SET @SQL = CONCAT('SELECT a.Memberid, a.LogName, a.MemName, a.Gender, a.BirthDate, a.Tel, a.IDCard, a.status, a.createtime,',@SQL);
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem a ON a.Memberid = t.Memberid');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN mem3 b ON b.Memberid = t.Memberid');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN ompb e ON e.Memberid = t.Memberid');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omgs f ON f.MemGrpid = e.MemGrpid');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omes g ON g.Memid = a.Memid AND g.Tag = ''T''');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omds c ON c.Memberid = t.Memberid');
  SET @SQL = CONCAT(@SQL, ' GROUP BY t.Memberid DESC');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_getDiabetesMemList` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_getDiabetesMemList` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_getDiabetesMemList`(
  IN iDocId INT,
  IN vMemName VARCHAR(20),
  IN vTel VARCHAR(30),
  IN vIdCard VARCHAR(30),
  
  IN dSCreateTime VARCHAR(10),
  IN dECreateTime VARCHAR(10),  
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT
)
    COMMENT '[2.0.4SP5]糖尿病会员-查询'
label:BEGIN
  DECLARE vMemGrpIDList VARCHAR(10000);
  
  SET group_concat_max_len = 10240;
  SET iCount = 0;
  
  SELECT GROUP_CONCAT(DISTINCT d.MemGrpid) INTO vMemGrpIDList
    FROM dgp1 a, odgp b, odmt c, omgs d
   WHERE a.Docid = iDocId AND a.OdgpId = b.OdgpId AND b.OdgpId = c.OdgpId AND c.MemGrpid = d.MemGrpid;
  
  IF vMemGrpIDList IS NULL OR vMemGrpIDList = '' THEN LEAVE label; END IF;
  
  SET @SQL = ' omem t JOIN ompb a ON a.Memberid = t.Memberid';
  SET @SQL = CONCAT(@SQL, ' AND a.MemGrpid IN (',vMemGrpIDList,')');
  SET @SQL = CONCAT(@SQL, ' JOIN mem3 c ON c.memberid = t.memberid AND c.diseaseid = 2');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN ph_diabetes b ON b.Memberid = t.memberid AND b.VisitClass = 0');
  
  SET @SQL = CONCAT(@SQL, ' WHERE t.useTag = ''T'' AND b.Memberid IS NULL');
  IF vMemName IS NOT NULL AND vMemName != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemName LIKE ''%',vMemName,'%'''); END IF;
  IF vTel IS NOT NULL AND vTel != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Tel LIKE ''%',vTel,'%'''); END IF;
  IF vIdCard IS NOT NULL AND vIdCard != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.IdCard LIKE ''%',vIdCard,'%'''); END IF;
  IF dSCreateTime IS NOT NULL AND dSCreateTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.CreateTime >= ''',dSCreateTime,''''); END IF;
  IF dECreateTime IS NOT NULL AND dECreateTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.CreateTime <= ''',dECreateTime,' 23:59:59'''); END IF;
    
  SET @count_SQL = CONCAT('SELECT COUNT(DISTINCT t.memberid) INTO @iCount FROM', @SQL);
  PREPARE stmt FROM @count_SQL;
  EXECUTE stmt;
  SET iCount = @iCount;
  
  SET @SQL = CONCAT(@SQL, ' GROUP BY t.memberid DESC');
  SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
  SET @SQL = CONCAT('SELECT t.Memberid, t.MemName, t.Tel, t.IDCard, t.createtime, t.unique_id FROM', @SQL);
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_getHypertensionMemList` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_getHypertensionMemList` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_getHypertensionMemList`(
  IN iDocId INT,
  IN vMemName VARCHAR(20),
  IN vTel VARCHAR(30),
  IN vIdCard VARCHAR(30),
  
  IN dSCreateTime VARCHAR(10),
  IN dECreateTime VARCHAR(10),  
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT
)
    COMMENT '[2.0.4SP5]糖尿病会员-查询'
label:BEGIN
  DECLARE vMemGrpIDList VARCHAR(10000);
  
  SET group_concat_max_len = 10240;
  SET iCount = 0;
  
  SELECT GROUP_CONCAT(DISTINCT d.MemGrpid) INTO vMemGrpIDList
    FROM dgp1 a, odgp b, odmt c, omgs d
   WHERE a.Docid = iDocId AND a.OdgpId = b.OdgpId AND b.OdgpId = c.OdgpId AND c.MemGrpid = d.MemGrpid;
  
  IF vMemGrpIDList IS NULL OR vMemGrpIDList = '' THEN LEAVE label; END IF;
  
  SET @SQL = ' omem t JOIN ompb a ON a.Memberid = t.Memberid';
  SET @SQL = CONCAT(@SQL, ' AND a.MemGrpid IN (',vMemGrpIDList,')');
  SET @SQL = CONCAT(@SQL, ' JOIN mem3 c ON c.memberid = t.memberid AND c.diseaseid = 1');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN ph_hypertension b ON b.Memberid = t.memberid AND b.VisitClass = 0');
  
  SET @SQL = CONCAT(@SQL, ' WHERE t.useTag = ''T'' AND b.Memberid IS NULL');
  IF vMemName IS NOT NULL AND vMemName != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemName LIKE ''%',vMemName,'%'''); END IF;
  IF vTel IS NOT NULL AND vTel != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Tel LIKE ''%',vTel,'%'''); END IF;
  IF vIdCard IS NOT NULL AND vIdCard != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.IdCard LIKE ''%',vIdCard,'%'''); END IF;
  IF dSCreateTime IS NOT NULL AND dSCreateTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.CreateTime >= ''',dSCreateTime,''''); END IF;
  IF dECreateTime IS NOT NULL AND dECreateTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.CreateTime <= ''',dECreateTime,' 23:59:59'''); END IF;
    
  SET @count_SQL = CONCAT('SELECT COUNT(DISTINCT t.memberid) INTO @iCount FROM', @SQL);
  PREPARE stmt FROM @count_SQL;
  EXECUTE stmt;
  SET iCount = @iCount;
  
  SET @SQL = CONCAT(@SQL, ' GROUP BY t.memberid DESC');
  SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
  SET @SQL = CONCAT('SELECT t.Memberid, t.MemName, t.Tel, t.IDCard, t.createtime, t.unique_id FROM', @SQL);
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_getMeasureInfoStatistic` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_getMeasureInfoStatistic` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_getMeasureInfoStatistic`(
  IN iOrgID INT,
  IN dSMeasureTime VARCHAR(10),
  IN dEMeasureTime VARCHAR(10),
  IN dSBirthDate VARCHAR(10),
  IN dEBirthDate VARCHAR(10),
  IN cGender CHAR(1),
  IN vDiseaseIDList VARCHAR(100),
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT
)
    COMMENT '[2.0.4SP5]测量状况统计'
label:BEGIN
  DECLARE m_IsIncludeNode TINYINT DEFAULT FALSE;
  DECLARE m_vDiseaseIDList_len TINYINT;
  
  SET iCount = 0;
  
  SELECT TRUE INTO m_IsIncludeNode FROM orgs WHERE Superior = iOrgID LIMIT 1;
  
  IF vDiseaseIDList IS NOT NULL AND vDiseaseIDList != '' THEN
    SET m_vDiseaseIDList_len = LENGTH(vDiseaseIDList) - LENGTH(REPLACE(vDiseaseIDList,',','')) + 1;
  END IF;
  
  IF m_IsIncludeNode THEN
    SET @SQL = CONCAT(' orgs t, orgs t1, omem a WHERE t.Superior = ', iOrgID);
    SET @SQL = CONCAT(@SQL, ' AND t1.Path LIKE CONCAT(t.Path,''%'')');
    SET @SQL = CONCAT(@SQL, ' AND a.OrgID = t1.OrgID AND a.UseTag = ''T''');
    IF dSBirthDate IS NOT NULL AND dSBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND a.BirthDate >= ''',dSBirthDate,''''); END IF;
    IF dEBirthDate IS NOT NULL AND dEBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND a.BirthDate <= ''',dEBirthDate,''''); END IF;
    IF cGender IS NOT NULL AND cGender != '' THEN SET @SQL = CONCAT(@SQL, ' AND a.Gender = ''',cGender,''''); END IF;
    
    IF m_vDiseaseIDList_len IS NOT NULL THEN
      SET @SQL = CONCAT(' mem3 b,', @SQL,' AND b.Memberid = a.Memberid AND b.DiseaseID IN (', vDiseaseIDList, ')');
      SET @SQL = CONCAT(@SQL, ' GROUP BY t.OrgID, a.Memberid');
      SET @SQL = CONCAT(@SQL, ' HAVING COUNT(DISTINCT b.DiseaseID) = ', m_vDiseaseIDList_len);
    END IF;
    
    SET @SQL = CONCAT(' SELECT DISTINCT t.OrgID AS id, a.Memberid FROM', @SQL);
  ELSE
    SET @SQL = CONCAT(' omgs t, omgs t1, ompb t2, omem a WHERE t.faMemid = 0 AND t.OrgID = ', iOrgID);
    SET @SQL = CONCAT(@SQL, ' AND t1.Path LIKE CONCAT(t.Path,''%'')');
    SET @SQL = CONCAT(@SQL, ' AND t2.MemGrpid = t1.MemGrpid');
    SET @SQL = CONCAT(@SQL, ' AND a.Memberid = t2.Memberid AND a.UseTag = ''T''');
    
    IF dSBirthDate IS NOT NULL AND dSBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND a.BirthDate >= ''',dSBirthDate,''''); END IF;
    IF dEBirthDate IS NOT NULL AND dEBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND a.BirthDate <= ''',dEBirthDate,''''); END IF;
    IF cGender IS NOT NULL AND cGender != '' THEN SET @SQL = CONCAT(@SQL, ' AND a.Gender = ''',cGender,''''); END IF;
    
    IF m_vDiseaseIDList_len IS NOT NULL THEN
      SET @SQL = CONCAT(' mem3 b,', @SQL,' AND b.Memberid = a.Memberid AND b.DiseaseID IN (', vDiseaseIDList, ')');
      SET @SQL = CONCAT(@SQL, ' GROUP BY t.OrgID, a.Memberid');
      SET @SQL = CONCAT(@SQL, ' HAVING COUNT(DISTINCT b.DiseaseID) = ', m_vDiseaseIDList_len);
    END IF;
    
    SET @SQL = CONCAT(' SELECT DISTINCT t.MemGrpid AS id, a.Memberid FROM', @SQL);
  END IF;
  
  DROP TABLE IF EXISTS tmp_org_mem;    
  SET @SQL = CONCAT('CREATE TEMPORARY TABLE tmp_org_mem', @SQL);
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
 
  DROP TABLE IF EXISTS tmp_MeasureInfoStatistic;
  
  SET @SQL = 'CREATE TEMPORARY TABLE tmp_MeasureInfoStatistic';
  SET @SQL = CONCAT(@SQL, ' SELECT a.id, COUNT(DISTINCT a.Memberid) AS n1, COUNT(DISTINCT b.Docentry) AS n2, 1 AS flag');
  SET @SQL = CONCAT(@SQL, ' FROM tmp_org_mem a, osbp b');
  SET @SQL = CONCAT(@SQL, ' WHERE b.Memberid = a.Memberid AND b.DelTag = 0');
  IF dSMeasureTime IS NOT NULL AND dSMeasureTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.TestTime >= ''',dSMeasureTime,''''); END IF;
  IF dEMeasureTime IS NOT NULL AND dEMeasureTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.TestTime <= ''',dEMeasureTime,' 23:59:59'''); END IF;
  SET @SQL = CONCAT(@SQL, ' GROUP BY a.id');
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  
  SET @SQL = 'INSERT INTO tmp_MeasureInfoStatistic';
  SET @SQL = CONCAT(@SQL, ' SELECT a.id, COUNT(DISTINCT a.Memberid), COUNT(DISTINCT b.Docentry), 2 AS flag');
  SET @SQL = CONCAT(@SQL, ' FROM tmp_org_mem a, obsr b');
  SET @SQL = CONCAT(@SQL, ' WHERE b.Memberid = a.Memberid AND b.DelTag = 0');
  IF dSMeasureTime IS NOT NULL AND dSMeasureTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.TestTime >= ''',dSMeasureTime,''''); END IF;
  IF dEMeasureTime IS NOT NULL AND dEMeasureTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.TestTime <= ''',dEMeasureTime,' 23:59:59'''); END IF;
  SET @SQL = CONCAT(@SQL, ' GROUP BY a.id');
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  
  SET @SQL = 'INSERT INTO tmp_MeasureInfoStatistic';
  SET @SQL = CONCAT(@SQL, ' SELECT a.id, COUNT(DISTINCT a.Memberid), COUNT(DISTINCT b.Docentry), 3 AS flag');
  SET @SQL = CONCAT(@SQL, ' FROM tmp_org_mem a, oppg b, omds c');
  SET @SQL = CONCAT(@SQL, ' WHERE b.Memberid = a.Memberid AND b.DelTag = 0 AND b.eventid = c.eventid AND c.EventType = 3');
  IF dSMeasureTime IS NOT NULL AND dSMeasureTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.MeasureTime >= ''',dSMeasureTime,''''); END IF;
  IF dEMeasureTime IS NOT NULL AND dEMeasureTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.MeasureTime <= ''',dEMeasureTime,' 23:59:59'''); END IF;
  SET @SQL = CONCAT(@SQL, ' GROUP BY a.id');
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;  
  
  SET @SQL = 'INSERT INTO tmp_MeasureInfoStatistic';
  SET @SQL = CONCAT(@SQL, ' SELECT a.id, COUNT(DISTINCT a.Memberid), COUNT(DISTINCT b.Docentry), 4 AS flag');
  SET @SQL = CONCAT(@SQL, ' FROM tmp_org_mem a, oecg b, omds c');
  SET @SQL = CONCAT(@SQL, ' WHERE b.Memberid = a.Memberid AND b.DelTag = 0 AND b.eventid = c.eventid AND c.EventType = 4');
  IF dSMeasureTime IS NOT NULL AND dSMeasureTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.MeasTime >= ''',dSMeasureTime,''''); END IF;
  IF dEMeasureTime IS NOT NULL AND dEMeasureTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.MeasTime <= ''',dEMeasureTime,' 23:59:59'''); END IF;
  SET @SQL = CONCAT(@SQL, ' GROUP BY a.id');
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  
  SELECT COUNT(DISTINCT id) INTO iCount FROM tmp_MeasureInfoStatistic;
  
  SET @SQL = ' SUM(IF(t.flag=1, n1, 0)) AS osbp_n1, SUM(IF(t.flag=1, n2, 0)) AS osbp_n2,';
  SET @SQL = CONCAT(@SQL, ' SUM(IF(t.flag=2, n1, 0)) AS obsr_n1, SUM(IF(t.flag=2, n2, 0)) AS obsr_n2,');
  SET @SQL = CONCAT(@SQL, ' SUM(IF(t.flag=3, n1, 0)) AS oppg_n1, SUM(IF(t.flag=3, n2, 0)) AS oppg_n2,');
  SET @SQL = CONCAT(@SQL, ' SUM(IF(t.flag=4, n1, 0)) AS oecg_n1, SUM(IF(t.flag=4, n2, 0)) AS oecg_n2');
  IF m_IsIncludeNode THEN
    SET @SQL = CONCAT('SELECT a.OrgName AS `Name`,', @SQL);
    SET @SQL = CONCAT(@SQL, ' FROM tmp_MeasureInfoStatistic t, orgs a');
    SET @SQL = CONCAT(@SQL, ' WHERE t.id = a.OrgID');
    SET @SQL = CONCAT(@SQL, ' GROUP BY a.Order, a.OrgID');
  ELSE
    SET @SQL = CONCAT('SELECT a.MemGrpName AS `Name`,', @SQL);
    SET @SQL = CONCAT(@SQL, ' FROM tmp_MeasureInfoStatistic t, omgs a');
    SET @SQL = CONCAT(@SQL, ' WHERE t.id = a.MemGrpid');
    SET @SQL = CONCAT(@SQL, ' GROUP BY a.Order, a.MemGrpid');
  END IF;
  SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt; 
  DROP TABLE IF EXISTS tmp_org_mem;
  DROP TABLE IF EXISTS tmp_MeasureInfoStatistic;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_getMyMemListByDocId` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_getMyMemListByDocId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_getMyMemListByDocId`(
  IN iDocId INT,
  IN iMemGrpid INT,
  
  IN vMemName VARCHAR(20),
  IN vMemNameCode VARCHAR(20),
  IN cGender CHAR(1),
  IN vTel VARCHAR(30),
  IN vIdCard VARCHAR(30),
  IN dSBirthDate VARCHAR(10),
  IN dEBirthDate VARCHAR(10),
  
  IN idisease_id INT,
  IN iExecStatus TINYINT,
  IN vLItemID_list VARCHAR(255),
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT
)
    COMMENT '[3.0]会员管理->我的会员->查询'
label:BEGIN
  DECLARE m_OrgPath VARCHAR(300);
  DECLARE m_OrgID_list VARCHAR(300);
  
  SET iCount = 0;
  
  SELECT TRIM(BOTH ',' FROM b.Path) INTO m_OrgPath
    FROM odoc a, orgs b
   WHERE a.Tag = 'T' AND a.DocId = iDocId AND a.OrgID = b.OrgID;
  
  IF m_OrgPath IS NULL OR m_OrgPath = '' THEN LEAVE label; END IF;
  
  SET @SQL = 'SELECT a.Path INTO @OrgPath FROM orgs a, orgs_cfg b';
  SET @SQL = CONCAT(@SQL, ' WHERE a.OrgID = b.OrgID AND b.IsSharedParentNode = 0 AND a.OrgID IN (', MID(m_OrgPath,3), ')');
  SET @SQL = CONCAT(@SQL, ' ORDER BY a.Path DESC LIMIT 1');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  
  SET @OrgPath = TRIM(BOTH ',' FROM @OrgPath);
  IF @OrgPath IS NULL OR @OrgPath = m_OrgPath THEN
    SET m_OrgID_list = SUBSTRING_INDEX(m_OrgPath,',',-1);
  ELSE
    SET m_OrgID_list = REPLACE(m_OrgPath, @OrgPath, SUBSTRING_INDEX(@OrgPath,',',-1));
  END IF;
  SET @SQL = ' omem t JOIN ompb a ON a.MemberID = t.MemberID';
  SET @SQL = CONCAT(@SQL, ' JOIN odmt b ON b.MemGrpid = a.MemGrpid');
  SET @SQL = CONCAT(@SQL, ' JOIN dgp1 c ON c.OdgpId = b.OdgpId AND c.Docid = ', iDocId);
  SET @SQL = CONCAT(@SQL, ' JOIN odgp d ON d.OdgpId = c.OdgpId');
  SET @SQL = CONCAT(@SQL, ' JOIN omgs e ON e.MemGrpid = b.MemGrpid');
  IF iMemGrpid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND FIND_IN_SET(', iMemGrpid, ',e.Path)'); END IF;
  
  IF idisease_id != -1 THEN SET @SQL = CONCAT(@SQL, ' JOIN mem3 f ON f.MemberID = t.MemberID AND f.DiseaseID = ', idisease_id); END IF;
  
  IF iExecStatus <= 0 THEN SET @SQL = CONCAT(@SQL, ' LEFT'); END IF;
  SET @SQL = CONCAT(@SQL, ' JOIN tb_managescheme_exec g ON g.MemberID = t.MemberID');
  IF iExecStatus <= 0 THEN SET @SQL = CONCAT(@SQL, ' LEFT'); END IF;  
  SET @SQL = CONCAT(@SQL, ' JOIN tb_managescheme_design h ON h.MSDesignID = g.MSDesignID AND h.SchemeType = 1');
  
  IF vLItemID_list IS NOT NULL AND vLItemID_list != '' THEN SET @SQL = CONCAT(@SQL, ' JOIN omem_labelitem i ON i.MemberID = t.MemberID AND i.LItemID IN (', vLItemID_list, ')'); END IF;  
  
  SET @SQL = CONCAT(@SQL, ' WHERE t.useTag = ''T''');
  IF vMemName IS NOT NULL AND vMemName != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemName LIKE ''', vMemName, '%'''); END IF;
  IF vMemNameCode IS NOT NULL AND vMemNameCode != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemNameCode LIKE ''', vMemNameCode, '%'''); END IF;
  IF cGender IS NOT NULL AND cGender != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Gender = ''', cGender,''''); END IF;
  IF vTel IS NOT NULL AND vTel != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Tel LIKE ''', vTel, '%'''); END IF;
  IF vIdCard IS NOT NULL AND vIdCard != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.IdCard LIKE ''', vIdCard, '%'''); END IF;
  IF dSBirthDate IS NOT NULL AND dSBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.BirthDate >= ''', dSBirthDate, ''''); END IF;
  IF dEBirthDate IS NOT NULL AND dEBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.BirthDate <= ''', dEBirthDate, ''''); END IF;
  
  SET @SQL = CONCAT(' SELECT t.MemberID, IFNULL(SUBSTRING_INDEX(GROUP_CONCAT(DISTINCT CONCAT(h.MSDesignID,'','',g.ExecStatus) ORDER BY h.SchemeType, g.CreateTime DESC),'','',2),'',0'') AS sub_MSDID_ES FROM', @SQL);
  SET @SQL = CONCAT(@SQL, ' GROUP BY t.MemberID');
  
  IF vLItemID_list IS NOT NULL AND vLItemID_list != '' THEN
    SET @SQL = CONCAT(@SQL, ' HAVING COUNT(DISTINCT i.LItemID) = ', LENGTH(vLItemID_list) - LENGTH(REPLACE(vLItemID_list,',','')) + 1);
    IF iExecStatus > 0 THEN
      SET @SQL = CONCAT(@SQL, ' AND SUBSTRING_INDEX(sub_MSDID_ES,'','',-1) = ', iExecStatus);
    END IF;
  ELSEIF iExecStatus > 0 THEN
    SET @SQL = CONCAT(@SQL, ' HAVING SUBSTRING_INDEX(sub_MSDID_ES,'','',-1) = ', iExecStatus);
  END IF;
  
  SET @c_SQL = CONCAT('SELECT COUNT(tmp.MemberID) INTO @iCount FROM (', @SQL, ')tmp');
  
  PREPARE stmt FROM @c_SQL;
  EXECUTE stmt;
  SET iCount = @iCount;
  
  SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
  
  SET @SQL = CONCAT('SELECT t.MemberID, t.MemName, t.Gender, t.BirthDate, t.Tel, t.status, GROUP_CONCAT(DISTINCT f.DiseaseName) AS DiseaseName_List, MAX(k.UploadTime) AS last_UploadTime, GROUP_CONCAT(DISTINCT e.MemGrpID) AS MemGrpID_List, GROUP_CONCAT(DISTINCT e.MemGrpName) AS MemGrpName_List, j.MemName as MemberTypeName, h.MSDesignID, SUBSTRING_INDEX(tmp.sub_MSDID_ES,'','',-1) AS ExecStatus, h.SchemeTitle, GROUP_CONCAT(DISTINCT l.ItemName) AS ItemName_List FROM (',@SQL, ')tmp');
  
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem t ON t.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN ompb a ON a.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omgs e ON e.MemGrpid = a.MemGrpid');
  IF iMemGrpid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND FIND_IN_SET(', iMemGrpid, ',e.Path)'); END IF;
  
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN mem3 f ON f.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN tb_managescheme_design h ON h.MSDesignID = SUBSTRING_INDEX(tmp.sub_MSDID_ES,'','',1)');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omes j ON j.Memid = t.Memid AND j.Tag = ''T'''); 
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omds k ON k.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem_labelitem i ON i.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN tb_label_item l ON l.LItemID = i.LItemID AND l.ItemStatus = 2 AND (l.UseRange = 1 OR (l.OrgID IN (', m_OrgID_list, ') AND l.UseRange = 2) OR (l.UseRange = 3 AND l.CreateID = ',iDocId,'))');
  SET @SQL = CONCAT(@SQL, ' GROUP BY tmp.MemberID');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_getOtherMemListByDocId` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_getOtherMemListByDocId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_getOtherMemListByDocId`(
  IN iDocId INT,
  IN iMemGrpid INT,
  IN vMemName VARCHAR(20),
  IN vMemNameCode VARCHAR(20),
  IN cGender CHAR(1),
  IN vTel VARCHAR(30),
  IN vIdCard VARCHAR(30),
  IN dSBirthDate VARCHAR(10),
  IN dEBirthDate VARCHAR(10),
  IN vAddress VARCHAR(200),
  IN vDiseaseName VARCHAR(30),
  
  IN iMemId INT,
  IN iQustid INT,
  IN iCombQustid INT,
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT
)
    COMMENT '[2.1SP1]其他会员-查询'
label:BEGIN
  DECLARE vMemGrpIDList VARCHAR(10000);
  DECLARE iOrgId INT;
  
  SET group_concat_max_len = 10240;
  SET iCount = 0;  
  
  SELECT GROUP_CONCAT(DISTINCT d.MemGrpid) INTO vMemGrpIDList
    FROM dgp1 a, odgp b, odmt c, omgs d
   WHERE a.Docid = iDocId AND a.OdgpId = b.OdgpId AND b.OdgpId = c.OdgpId AND c.MemGrpid = d.MemGrpid;
  
  SELECT OrgId INTO iOrgId FROM odoc WHERE Docid = iDocId;
  
  SET @SQL = ' omem t';
  
  IF vDiseaseName IS NOT NULL AND vDiseaseName != '' THEN SET @SQL = CONCAT(@SQL, ' JOIN mem3 f ON f.Memberid = t.Memberid AND f.DiseaseName LIKE ''%',vDiseaseName,'%'''); END IF;
  IF iMemId != -1 THEN SET @SQL = CONCAT(@SQL, ' JOIN omes a ON a.MemId = t.MemId AND a.Tag = ''T'' AND a.MemId = ', iMemId); END IF;
  
  IF vMemGrpIDList IS NOT NULL AND vMemGrpIDList != '' THEN
    SET @SQL = CONCAT(@SQL, ' LEFT JOIN ompb b ON b.Memberid = t.Memberid AND b.MemGrpid IN (',vMemGrpIDList,')');
  END IF;
  
  SET @SQL = CONCAT(@SQL, ' WHERE t.useTag = ''T'' AND t.OrgId = ', iOrgId);
  
  IF vMemName IS NOT NULL AND vMemName != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemName LIKE ''',vMemName,'%'''); END IF;
  IF vMemNameCode IS NOT NULL AND vMemNameCode != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemNameCode LIKE ''',vMemNameCode,'%'''); END IF;
  IF cGender IS NOT NULL AND cGender != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Gender = ''',cGender,''''); END IF;
  IF vTel IS NOT NULL AND vTel != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Tel LIKE ''%',vTel,'%'''); END IF;
  IF vIdCard IS NOT NULL AND vIdCard != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.IdCard LIKE ''%',vIdCard,'%'''); END IF;
  IF dSBirthDate IS NOT NULL AND dSBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.BirthDate >= ''',dSBirthDate,''''); END IF;
  IF dEBirthDate IS NOT NULL AND dEBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.BirthDate <= ''',dEBirthDate,''''); END IF;
  IF vAddress IS NOT NULL AND vAddress != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Address LIKE ''%',vAddress,'%'''); END IF;
  IF vMemGrpIDList IS NOT NULL AND vMemGrpIDList != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.MemGrpid IS NULL'); END IF;
  SET @count_SQL = CONCAT('SELECT COUNT(DISTINCT t.memberid) INTO @iCount FROM', @SQL);
  PREPARE stmt FROM @count_SQL;
  EXECUTE stmt;
  SET iCount = @iCount;
  SET @SQL = CONCAT(@SQL, ' ORDER BY t.memberid DESC');
  SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
  SET @SQL = CONCAT(' SELECT DISTINCT t.memberid FROM', @SQL);
  
  SET @SQL = CONCAT(' FROM (', @SQL, ')t');
  SET @SQL = CONCAT(' MAX(c.UploadTime) AS last_UploadTime, GROUP_CONCAT(DISTINCT f.MemGrpID) AS MemGrpID_List, GROUP_CONCAT(DISTINCT f.MemGrpName) AS MemGrpName_List, g.MemDesc',@SQL);
  SET @SQL = CONCAT(' GROUP_CONCAT(DISTINCT b.DiseaseName) AS DiseaseName_List,',@SQL);
  SET @SQL = CONCAT('SELECT a.Memberid, a.LogName, a.MemName, a.Gender, a.BirthDate, a.Tel, a.IDCard, a.status, a.createtime,',@SQL);
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem a ON a.Memberid = t.Memberid');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN mem3 b ON b.Memberid = t.Memberid');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN ompb e ON e.Memberid = t.Memberid');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omgs f ON f.MemGrpid = e.MemGrpid');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omes g ON g.Memid = a.Memid AND g.Tag = ''T''');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omds c ON c.Memberid = t.Memberid');
  SET @SQL = CONCAT(@SQL, ' GROUP BY t.Memberid DESC');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_mscheme_addExecTaskByMSDesignID` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_mscheme_addExecTaskByMSDesignID` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_mscheme_addExecTaskByMSDesignID`(
  IN iMSDesignID INT,
  IN iDocID INT
)
    COMMENT '[3.0]管理方案(群体)->生成个人执行任务'
label:BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
      UPDATE tb_managescheme_design SET MassEffectProcess = 4, UpdateID = iDocID, UpdateTime = NOW() WHERE MSDesignID = iMSDesignID;
      UPDATE tb_managescheme_exec SET MEPersonProcess = 4, UpdateID = iDocID, UpdateTime = NOW() WHERE MSDesignID = iMSDesignID;
    END;
  
  START TRANSACTION;
    INSERT INTO tb_managescheme_exec_task(MSExecID,MSDTaskID,PlanTime,ExecStatus,CreateID,CreateTime)
    SELECT a.MSExecID, b.MSDTaskID,
           CASE PlanTimeType WHEN 1 THEN ADDDATE(NOW(),INTERVAL PlanTimeValue DAY)
                             WHEN 2 THEN ADDDATE(NOW(),INTERVAL PlanTimeValue WEEK)
                             WHEN 3 THEN ADDDATE(NOW(),INTERVAL PlanTimeValue MONTH)
                             WHEN 4 THEN ADDDATE(NOW(),INTERVAL PlanTimeValue YEAR) END,
           1, iDocID, NOW()
      FROM tb_managescheme_exec a, tb_managescheme_design_task b
     WHERE a.MSDesignID = iMSDesignID AND a.ExecStatus = 1 AND a.MEPersonProcess = 2 AND a.MSDesignID = b.MSDesignID;
    
    UPDATE tb_managescheme_exec a, tb_managescheme_exec_task b
       SET a.ExecStatus = 2,
           a.MEPersonProcess = 3,
           a.MEPTriggerTime = b.CreateTime,
           a.UpdateID = iDocID,
           a.UpdateTime = NOW()
     WHERE a.MSExecID = b.MSExecID AND b.MSETaskID BETWEEN LAST_INSERT_ID() AND LAST_INSERT_ID() + ROW_COUNT() - 1;
     
    UPDATE tb_managescheme_design SET MassEffectProcess = 3, UpdateID = iDocID, UpdateTime = NOW() WHERE MSDesignID = iMSDesignID;
  COMMIT;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_mscheme_getMemberByDocId` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_mscheme_getMemberByDocId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_mscheme_getMemberByDocId`(
  IN iDocId INT,
  
  IN vMemName VARCHAR(20),
  IN vTel VARCHAR(30),
  IN vIdCard VARCHAR(30),
  
  IN iMemGrpid INT,
  IN idisease_id INT,
  IN iMemId INT,
  IN vLItemID_list VARCHAR(255),
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT
)
    COMMENT '[3.0]管理方案(个人)->制定->查询会员列表'
label:BEGIN
  DECLARE m_OrgPath VARCHAR(300);
  DECLARE m_OrgID_list VARCHAR(300);
  
  SET iCount = 0;
  
  SELECT TRIM(BOTH ',' FROM b.Path) INTO m_OrgPath
    FROM odoc a, orgs b
   WHERE a.Tag = 'T' AND a.DocId = iDocId AND a.OrgID = b.OrgID;
  
  IF m_OrgPath IS NULL OR m_OrgPath = '' THEN LEAVE label; END IF;
  
  SET @SQL = 'SELECT a.Path INTO @OrgPath FROM orgs a, orgs_cfg b';
  SET @SQL = CONCAT(@SQL, ' WHERE a.OrgID = b.OrgID AND b.IsSharedParentNode = 0 AND a.OrgID IN (', MID(m_OrgPath,3), ')');
  SET @SQL = CONCAT(@SQL, ' ORDER BY a.Path DESC LIMIT 1');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  
  SET @OrgPath = TRIM(BOTH ',' FROM @OrgPath);
  IF @OrgPath IS NULL OR @OrgPath = m_OrgPath THEN
    SET m_OrgID_list = SUBSTRING_INDEX(m_OrgPath,',',-1);
  ELSE
    SET m_OrgID_list = REPLACE(m_OrgPath, @OrgPath, SUBSTRING_INDEX(@OrgPath,',',-1));
  END IF;
  
  SET @SQL = ' omem t JOIN ompb a ON a.MemberID = t.MemberID';
  SET @SQL = CONCAT(@SQL, ' JOIN odmt b ON b.MemGrpid = a.MemGrpid');
  SET @SQL = CONCAT(@SQL, ' JOIN dgp1 c ON c.OdgpId = b.OdgpId AND c.Docid = ', iDocId);
  SET @SQL = CONCAT(@SQL, ' JOIN odgp d ON d.OdgpId = c.OdgpId');
  SET @SQL = CONCAT(@SQL, ' JOIN omgs e ON e.MemGrpid = b.MemGrpid');
  
  IF iMemGrpid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND FIND_IN_SET(', iMemGrpid, ',e.Path)'); END IF;
  
  IF idisease_id != -1 THEN SET @SQL = CONCAT(@SQL, ' JOIN mem3 f ON f.MemberID = t.MemberID AND f.DiseaseID = ', idisease_id); END IF;
  IF iMemId != -1 THEN SET @SQL = CONCAT(@SQL, ' JOIN omes g ON g.MemId = t.MemId AND g.Tag = ''T'' AND g.MemId = ', iMemId); END IF;
  IF vLItemID_list IS NOT NULL AND vLItemID_list != '' THEN SET @SQL = CONCAT(@SQL, ' JOIN omem_labelitem h ON h.MemberID = t.MemberID AND h.LItemID IN (', vLItemID_list, ')'); END IF;
  
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN tb_managescheme_exec i ON i.MemberID = t.MemberID AND i.ExecStatus <> 4');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN tb_managescheme_design j ON j.MSDesignID = i.MSDesignID AND j.SchemeType = 1'); 
 
  SET @SQL = CONCAT(@SQL, ' WHERE t.useTag = ''T'' AND t.status = ''T''');
  
  IF vMemName IS NOT NULL AND vMemName != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemName LIKE ''',vMemName,'%'''); END IF;
  IF vTel IS NOT NULL AND vTel != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Tel LIKE ''',vTel,'%'''); END IF;
  IF vIdCard IS NOT NULL AND vIdCard != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.IdCard LIKE ''',vIdCard,'%'''); END IF;
  
  SET @SQL = CONCAT(' SELECT t.MemberID FROM', @SQL);
  SET @SQL = CONCAT(@SQL, ' GROUP BY t.MemberID');
  
  SET @SQL = CONCAT(@SQL, ' HAVING SUBSTRING_INDEX(GROUP_CONCAT(DISTINCT j.MSDesignID ORDER BY j.SchemeType, i.CreateTime DESC),'','',1) IS NULL');
  IF vLItemID_list IS NOT NULL AND vLItemID_list != '' THEN 
    SET @SQL = CONCAT(@SQL, ' AND COUNT(DISTINCT h.LItemID) = ', LENGTH(vLItemID_list) - LENGTH(REPLACE(vLItemID_list,',','')) + 1);
  END IF;
  
  SET @c_SQL = CONCAT('SELECT COUNT(tmp.MemberID) INTO @iCount FROM (', @SQL, ')tmp');   
  
  PREPARE stmt FROM @c_SQL;
  EXECUTE stmt;
  SET iCount = @iCount;
  
  SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
  
  SET @SQL = CONCAT('SELECT t.MemberID, t.MemName, t.Gender, t.Tel, g.MemName as MemberTypeName, GROUP_CONCAT(DISTINCT e.MemGrpName) AS MemGrpName_List, GROUP_CONCAT(DISTINCT f.DiseaseName) AS DiseaseName_List, GROUP_CONCAT(DISTINCT i.ItemName) AS ItemName_List FROM (',@SQL, ')tmp');
  
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem t ON t.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN ompb a ON a.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omgs e ON e.MemGrpid = a.MemGrpid');
  
  IF iMemGrpid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND FIND_IN_SET(', iMemGrpid, ',e.Path)'); END IF;
  
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN mem3 f ON f.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omes g ON g.Memid = t.Memid AND g.Tag = ''T''');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem_labelitem h ON h.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN tb_label_item i ON i.LItemID = h.LItemID AND i.ItemStatus = 2 AND (i.UseRange = 1 OR (i.OrgID IN (', m_OrgID_list, ') AND i.UseRange = 2) OR (i.UseRange = 3 AND i.CreateID = ',iDocId,'))');
  SET @SQL = CONCAT(@SQL, ' GROUP BY tmp.MemberID');
 
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_mscheme_getoraddMemberByDocId` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_mscheme_getoraddMemberByDocId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_mscheme_getoraddMemberByDocId`(
  IN iDocId INT,
  IN iMSDesignID INT,
  
  IN vMemName VARCHAR(20),
  IN vTel VARCHAR(30),
  IN vIdCard VARCHAR(30),
  
  IN iMemGrpid INT,
  IN idisease_id INT,
  IN iMemId INT,
  IN vLItemID_list VARCHAR(255),
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT,
  
  IN i_trueOrfalse TINYINT
)
    COMMENT '[3.0]管理方案(群体)->选择会员->新增->查询会员列表'
label:BEGIN
  DECLARE m_OrgPath VARCHAR(300);
  DECLARE m_OrgID_list VARCHAR(300);
  
  SET iCount = 0;
  
  SELECT TRIM(BOTH ',' FROM b.Path) INTO m_OrgPath
    FROM odoc a, orgs b
   WHERE a.Tag = 'T' AND a.DocId = iDocId AND a.OrgID = b.OrgID;
  
  IF m_OrgPath IS NULL OR m_OrgPath = '' THEN LEAVE label; END IF;
  
  SET @SQL = 'SELECT a.Path INTO @OrgPath FROM orgs a, orgs_cfg b';
  SET @SQL = CONCAT(@SQL, ' WHERE a.OrgID = b.OrgID AND b.IsSharedParentNode = 0 AND a.OrgID IN (', MID(m_OrgPath,3), ')');
  SET @SQL = CONCAT(@SQL, ' ORDER BY a.Path DESC LIMIT 1');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  
  SET @OrgPath = TRIM(BOTH ',' FROM @OrgPath);
  IF @OrgPath IS NULL OR @OrgPath = m_OrgPath THEN
    SET m_OrgID_list = SUBSTRING_INDEX(m_OrgPath,',',-1);
  ELSE
    SET m_OrgID_list = REPLACE(m_OrgPath, @OrgPath, SUBSTRING_INDEX(@OrgPath,',',-1));
  END IF;
  
  SET @SQL = ' omem t JOIN ompb a ON a.MemberID = t.MemberID';
  SET @SQL = CONCAT(@SQL, ' JOIN odmt b ON b.MemGrpid = a.MemGrpid');
  SET @SQL = CONCAT(@SQL, ' JOIN dgp1 c ON c.OdgpId = b.OdgpId AND c.Docid = ', iDocId);
  SET @SQL = CONCAT(@SQL, ' JOIN odgp d ON d.OdgpId = c.OdgpId');
  SET @SQL = CONCAT(@SQL, ' JOIN omgs e ON e.MemGrpid = b.MemGrpid');
  IF iMemGrpid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND FIND_IN_SET(', iMemGrpid, ',e.Path)'); END IF;
  
  IF idisease_id != -1 THEN SET @SQL = CONCAT(@SQL, ' JOIN mem3 f ON f.MemberID = t.MemberID AND f.DiseaseID = ', idisease_id); END IF;
  IF iMemId != -1 THEN SET @SQL = CONCAT(@SQL, ' JOIN omes g ON g.MemId = t.MemId AND g.Tag = ''T'' AND g.MemId = ', iMemId); END IF;
  IF vLItemID_list IS NOT NULL AND vLItemID_list != '' THEN SET @SQL = CONCAT(@SQL, ' JOIN omem_labelitem h ON h.MemberID = t.MemberID AND h.LItemID IN (', vLItemID_list, ')'); END IF;
  
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN tb_managescheme_exec i ON i.MemberID = t.MemberID AND i.MSDesignID = ', iMSDesignID);
 
  SET @SQL = CONCAT(@SQL, ' WHERE t.useTag = ''T'' AND t.status = ''T'' AND i.MSDesignID IS NULL');
  
  IF vMemName IS NOT NULL AND vMemName != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemName LIKE ''',vMemName,'%'''); END IF;
  IF vTel IS NOT NULL AND vTel != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Tel LIKE ''',vTel,'%'''); END IF;
  IF vIdCard IS NOT NULL AND vIdCard != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.IdCard LIKE ''',vIdCard,'%'''); END IF;
  
  IF vLItemID_list IS NOT NULL AND vLItemID_list != '' THEN 
    SET @SQL = CONCAT(@SQL, ' GROUP BY t.MemberID');
    SET @SQL = CONCAT(@SQL, ' HAVING COUNT(DISTINCT h.LItemID) = ', LENGTH(vLItemID_list) - LENGTH(REPLACE(vLItemID_list,',','')) + 1);
  END IF;
  
  IF i_trueOrfalse = 0 THEN
    IF vLItemID_list IS NOT NULL AND vLItemID_list != '' THEN
      SET @SQL = CONCAT(' SELECT t.MemberID FROM', @SQL);
      SET @c_SQL = CONCAT('SELECT COUNT(tmp.MemberID) INTO @iCount FROM (', @SQL, ')tmp');
    ELSE
      SET @c_SQL = CONCAT('SELECT COUNT(DISTINCT t.MemberID) INTO @iCount FROM', @SQL);
      
      SET @SQL = CONCAT(' SELECT t.MemberID FROM', @SQL);
      SET @SQL = CONCAT(@SQL, ' GROUP BY t.MemberID');
    END IF;
    
    PREPARE stmt FROM @c_SQL;
    EXECUTE stmt;
    SET iCount = @iCount;
    SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
    
    SET @SQL = CONCAT('SELECT t.MemberID, t.MemName, t.Gender, t.Tel, g.MemName as MemberTypeName, GROUP_CONCAT(DISTINCT e.MemGrpName) AS MemGrpName_List, GROUP_CONCAT(DISTINCT f.DiseaseName) AS DiseaseName_List, GROUP_CONCAT(DISTINCT i.ItemName) AS ItemName_List FROM (',@SQL, ')tmp');
    
    SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem t ON t.MemberID = tmp.MemberID');
    SET @SQL = CONCAT(@SQL, ' LEFT JOIN ompb a ON a.MemberID = tmp.MemberID');
    SET @SQL = CONCAT(@SQL, ' LEFT JOIN omgs e ON e.MemGrpid = a.MemGrpid');
    IF iMemGrpid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND FIND_IN_SET(', iMemGrpid, ',e.Path)'); END IF;
    
    SET @SQL = CONCAT(@SQL, ' LEFT JOIN mem3 f ON f.MemberID = tmp.MemberID');
    SET @SQL = CONCAT(@SQL, ' LEFT JOIN omes g ON g.Memid = t.Memid AND g.Tag = ''T''');
    SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem_labelitem h ON h.MemberID = tmp.MemberID');
    SET @SQL = CONCAT(@SQL, ' LEFT JOIN tb_label_item i ON i.LItemID = h.LItemID AND i.ItemStatus = 2 AND (i.UseRange = 1 OR (i.OrgID IN (', m_OrgID_list, ') AND i.UseRange = 2) OR (i.UseRange = 3 AND i.CreateID = ',iDocId,'))');
    SET @SQL = CONCAT(@SQL, ' GROUP BY tmp.MemberID');
    
    PREPARE stmt FROM @SQL;
    EXECUTE stmt;
  ELSE
    SET @SQL = CONCAT(' SELECT DISTINCT ', iMSDesignID,', t.MemberID, 1, 1, ', iDocId,', NOW() FROM', @SQL);
    SET @SQL = CONCAT('INSERT INTO tb_managescheme_exec(MSDesignID, MemberID, ExecStatus, MEPersonProcess, CreateID, CreateTime)', @SQL);
    
    PREPARE stmt FROM @SQL;
    EXECUTE stmt;
    SET iCount = ROW_COUNT();
  END IF;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_questionnare_getMemberByDocId` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_questionnare_getMemberByDocId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_questionnare_getMemberByDocId`(
  IN iDocId INT,
  
  IN vMemName VARCHAR(20),
  IN cGender CHAR(1),
  IN vTel VARCHAR(30),
  IN vIdCard VARCHAR(30),
  IN dSBirthDate VARCHAR(10),
  IN dEBirthDate VARCHAR(10),
  
  IN vDiseaseName VARCHAR(30),
  IN iMemId INT,
  IN iQustid INT,
  IN iCombQustid INT,
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT
)
    COMMENT '[3.0]问卷发放-会员列表查询'
label:BEGIN
  DECLARE vMemGrpIDList VARCHAR(1024);
  SET iCount = 0;
  
  SELECT GROUP_CONCAT(DISTINCT d.MemGrpid) INTO vMemGrpIDList
    FROM dgp1 a, odgp b, odmt c, omgs d
   WHERE a.Docid = iDocId AND a.OdgpId = b.OdgpId AND b.OdgpId = c.OdgpId AND c.MemGrpid = d.MemGrpid;
  
  IF vMemGrpIDList IS NULL OR vMemGrpIDList = '' THEN LEAVE label; END IF;
  
  SET @SQL = ' omem t JOIN ompb b ON b.MemberID = t.MemberID';
  SET @SQL = CONCAT(@SQL, ' AND b.MemGrpid IN (',vMemGrpIDList,')');
  
  IF vDiseaseName IS NOT NULL AND vDiseaseName != '' THEN SET @SQL = CONCAT(@SQL, ' JOIN mem3 f ON f.MemberID = t.MemberID AND f.DiseaseName LIKE ''%', vDiseaseName,'%'''); END IF;
    
  IF iMemId != -1 THEN SET @SQL = CONCAT(@SQL, ' JOIN omes a ON a.MemId = t.MemId AND a.Tag = ''T'' AND a.MemId = ', iMemId); END IF;
  IF iQustid != -1 THEN SET @SQL = CONCAT(@SQL, ' LEFT JOIN ouai d ON d.MemberID = t.MemberID AND d.qustTag IN (''F'',''B'') AND d.Qustid = ', iQustid); END IF;
  IF iCombQustid != -1 THEN SET @SQL = CONCAT(@SQL, ' LEFT JOIN ocam e ON e.MemberID = t.MemberID AND e.CombTag IN (0,3) AND e.CombQustid = ', iCombQustid); END IF;
  
  SET @SQL = CONCAT(@SQL, ' WHERE t.useTag = ''T''');
  IF vMemName IS NOT NULL AND vMemName != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemName LIKE ''',vMemName,'%'''); END IF;
  IF cGender IS NOT NULL AND cGender != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Gender = ''',cGender,''''); END IF;
  IF vTel IS NOT NULL AND vTel != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Tel LIKE ''%',vTel,'%'''); END IF;
  IF vIdCard IS NOT NULL AND vIdCard != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.IdCard LIKE ''%',vIdCard,'%'''); END IF;
  IF dSBirthDate IS NOT NULL AND dSBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.BirthDate >= ''',dSBirthDate,''''); END IF;
  IF dEBirthDate IS NOT NULL AND dEBirthDate != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.BirthDate <= ''',dEBirthDate,''''); END IF;
  
  IF iQustid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND t.status = ''T'' AND d.AnsNumber IS NULL'); END IF;
  IF iCombQustid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND t.status = ''T'' AND e.CombAnsid IS NULL'); END IF;
     
  SET @count_SQL = CONCAT('SELECT COUNT(DISTINCT t.MemberID) INTO @iCount FROM', @SQL);
  PREPARE stmt FROM @count_SQL;
  EXECUTE stmt;
  SET iCount = @iCount;
  
  SET @SQL = CONCAT(' SELECT DISTINCT t.MemberID FROM', @SQL);
  SET @SQL = CONCAT(@SQL, ' ORDER BY t.MemberID');
  SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
  
  SET @SQL = CONCAT('SELECT a.MemberID, a.MemName, a.Gender, a.BirthDate, a.Tel, a.status, a.createtime, GROUP_CONCAT(DISTINCT b.DiseaseName) AS DiseaseName_List, MAX(c.UploadTime) AS last_UploadTime, GROUP_CONCAT(DISTINCT f.MemGrpID) AS MemGrpID_List, GROUP_CONCAT(DISTINCT f.MemGrpName) AS MemGrpName_List, g.MemDesc FROM (', @SQL, ')t');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem a ON a.MemberID = t.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN mem3 b ON b.MemberID = t.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN ompb e ON e.MemberID = t.MemberID AND e.MemGrpid IN (',vMemGrpIDList,')');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omgs f ON f.MemGrpid = e.MemGrpid');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omes g ON g.Memid = a.Memid AND g.Tag = ''T''');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omds c ON c.MemberID = t.MemberID');
  SET @SQL = CONCAT(@SQL, ' GROUP BY t.MemberID');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_statistic_DiabetesVisit` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_statistic_DiabetesVisit` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_statistic_DiabetesVisit`(
  IN iOrgID INT,
  IN iYear INT
)
    COMMENT '[2.1]统计2型糖尿病随访'
label:BEGIN
  DECLARE m_IsIncludeNode TINYINT DEFAULT FALSE;
  
  DROP TABLE IF EXISTS tmp_org_mem;  
  
  SELECT TRUE INTO m_IsIncludeNode FROM orgs WHERE Superior = iOrgID LIMIT 1;
  
  IF m_IsIncludeNode THEN
    CREATE TEMPORARY TABLE tmp_org_mem
    SELECT DISTINCT t.OrgID AS id, a.Memberid, b.CreateTime
      FROM orgs t
      JOIN orgs t1 ON t1.Path LIKE CONCAT(t.Path,'%')
      JOIN omem a ON a.OrgID = t1.OrgID AND a.UseTag = 'T'
      JOIN mem3 b ON b.Memberid = a.Memberid AND b.DiseaseID = 2 AND YEAR(b.CreateTime) <= iYear
     WHERE t.Superior = iOrgID;
  ELSE
    CREATE TEMPORARY TABLE tmp_org_mem
    SELECT DISTINCT t.MemGrpid AS id, a.Memberid, b.CreateTime
      FROM omgs t
      JOIN omgs t1 ON t1.Path LIKE CONCAT(t.Path,'%')
      JOIN ompb t2 ON t2.MemGrpid = t1.MemGrpid
      JOIN omem a ON a.Memberid = t2.Memberid AND a.UseTag = 'T'
      JOIN mem3 b ON b.Memberid = a.Memberid AND b.DiseaseID = 2 AND YEAR(b.CreateTime) <= iYear
     WHERE t.faMemid = 0 AND t.OrgID = iOrgID;
  END IF;
    
  DROP TABLE IF EXISTS tmp_statistic_diabetesVisit;
  CREATE TEMPORARY TABLE tmp_statistic_diabetesVisit
  SELECT t.id,
         COUNT(DISTINCT t.Memberid) AS total, 
         COUNT(DISTINCT IF(a.diabetesID IS NOT NULL AND a.diabetesID <> '', t.Memberid, NULL)) AS manage_sum,
         0 AS rule_sum,
         COUNT(DISTINCT IF(YEAR(t.CreateTime) = iYear, t.Memberid, NULL)) AS newadd_sum,
         0 AS lastnormal_sum
    FROM tmp_org_mem t
    LEFT JOIN ph_diabetes a ON a.MemberID = t.MemberID AND YEAR(a.VisitDate) = iYear
   GROUP BY t.id;
    
  UPDATE tmp_statistic_diabetesVisit a,
        (SELECT tmp.id, COUNT(DISTINCT tmp.Memberid) AS rule_sum
           FROM (
                 SELECT t.id, t.Memberid, COUNT(DISTINCT QUARTER(a.VisitDate)) AS count_n
                   FROM tmp_org_mem t, ph_diabetes a
                  WHERE t.MemberID = a.MemberID AND YEAR(a.VisitDate) = iYear
                  GROUP BY t.id, t.Memberid
                 HAVING (YEAR(CURDATE()) > iYear AND count_n = 4) OR (YEAR(CURDATE()) = iYear AND count_n = QUARTER(CURDATE()) - 1)
                ) tmp
          GROUP BY tmp.id) tmp2
     SET a.rule_sum = tmp2.rule_sum
   WHERE a.id = tmp2.id;
    
  UPDATE tmp_statistic_diabetesVisit a,
        (SELECT tmp.id, COUNT(DISTINCT tmp.Memberid) AS lastnormal_sum
           FROM (
                 SELECT t.id, t.Memberid, SUBSTRING_INDEX(GROUP_CONCAT(b.FPG ORDER BY a.VisitDate DESC, a.diabetesID DESC),',',1) AS last_FPG
                   FROM tmp_org_mem t, ph_diabetes a, ph_diabetesdetail b
                  WHERE t.MemberID = a.MemberID AND YEAR(a.VisitDate) = iYear AND b.diabetesID = a.diabetesID
                  GROUP BY t.id, t.Memberid
                 HAVING last_FPG < 7
                ) tmp
          GROUP BY tmp.id) tmp2
     SET a.lastnormal_sum = tmp2.lastnormal_sum
   WHERE a.id = tmp2.id;
    
  IF m_IsIncludeNode THEN
    SELECT a.OrgName AS `Name`, t.total, t.manage_sum, t.rule_sum, t.newadd_sum, t.lastnormal_sum
      FROM tmp_statistic_diabetesVisit t, orgs a
     WHERE t.id = a.OrgID
     ORDER BY a.Order, a.OrgID;
  ELSE
    SELECT a.MemGrpName AS `Name`, t.total, t.manage_sum, t.rule_sum, t.newadd_sum, t.lastnormal_sum
      FROM tmp_statistic_diabetesVisit t, omgs a
     WHERE t.id = a.MemGrpid
     ORDER BY a.Order, a.MemGrpid;
  END IF;
    
  DROP TABLE IF EXISTS tmp_org_mem;
  DROP TABLE IF EXISTS tmp_statistic_diabetesVisit;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_statistic_ExamInfoByYear` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_statistic_ExamInfoByYear` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_statistic_ExamInfoByYear`(
  IN iOrgID INT,
  IN iYear INT
)
    COMMENT '[2.1]统计老年人年度体检信息'
label:BEGIN
  IF EXISTS(SELECT * FROM orgs WHERE Superior = iOrgID) THEN
    SELECT t.OrgName AS `Name`, COUNT(DISTINCT a.Memberid) AS total,
           COUNT(DISTINCT IF(b.HExamID IS NULL, a.Memberid, NULL)) AS noexam_sum
      FROM orgs t
      JOIN orgs t1 ON t1.Path LIKE CONCAT(t.Path,'%')
      JOIN omem a ON a.OrgID = t1.OrgID AND a.UseTag = 'T' AND YEAR(CURDATE()) - YEAR(a.BirthDate) >= 65
      LEFT JOIN ph_healthexam b ON b.MemberID = a.MemberID AND YEAR(b.ExamDate) = iYear
     WHERE t.Superior = iOrgID
     GROUP BY t.Order, t.OrgID;
  ELSE
    SELECT t.MemGrpName AS `Name`, COUNT(DISTINCT a.Memberid) AS total,
           COUNT(DISTINCT IF(b.HExamID IS NULL, a.Memberid, NULL)) AS noexam_sum
      FROM omgs t
      JOIN omgs t1 ON t1.Path LIKE CONCAT(t.Path,'%')
      JOIN ompb t2 ON t2.MemGrpid = t1.MemGrpid
      JOIN omem a ON a.Memberid = t2.Memberid AND a.UseTag = 'T' AND YEAR(CURDATE()) - YEAR(a.BirthDate) >= 65
      LEFT JOIN ph_healthexam b ON b.MemberID = a.MemberID AND YEAR(b.ExamDate) = iYear
     WHERE t.faMemid = 0 AND t.OrgID = iOrgID
     GROUP BY t.Order, t.MemGrpid;
  END IF;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_statistic_HealthManageInfo` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_statistic_HealthManageInfo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_statistic_HealthManageInfo`(
  IN iOrgID INT,
  in iYear int
)
    COMMENT '[2.0.4SP4]统计老年人接受健康管理状况'
label:BEGIN
 
  IF EXISTS(SELECT * FROM orgs WHERE Superior = iOrgID) THEN
    SELECT t.OrgName AS `Name`, COUNT(DISTINCT a.Memberid) AS total,
           count(distinct if(a.unique_id is null or a.unique_id = '', a.Memberid, null)) as noaccept_sum
      FROM orgs t
      JOIN orgs t1 ON t1.Path LIKE CONCAT(t.Path,'%')
      JOIN omem a ON a.OrgID = t1.OrgID AND a.UseTag = 'T' and YEAR(CURDATE()) - YEAR(a.BirthDate) >= 65 and year(a.CreateTime) = iYear
     WHERE t.Superior = iOrgID
     GROUP BY t.Order, t.OrgID;
  ELSE
    SELECT t.MemGrpName AS `Name`, COUNT(DISTINCT a.Memberid) AS total,
           COUNT(DISTINCT IF(a.unique_id IS NULL OR a.unique_id = '', a.Memberid, NULL)) AS noaccept_sum
      FROM omgs t
      JOIN omgs t1 ON t1.Path LIKE CONCAT(t.Path,'%')
      JOIN ompb t2 ON t2.MemGrpid = t1.MemGrpid
      JOIN omem a ON a.Memberid = t2.Memberid AND a.UseTag = 'T' AND YEAR(CURDATE()) - YEAR(a.BirthDate) >= 65 AND YEAR(a.CreateTime) = iYear
     WHERE t.faMemid = 0 AND t.OrgID = iOrgID
     GROUP BY t.Order, t.MemGrpid;
  END IF;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_statistic_HypertensionVisit` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_statistic_HypertensionVisit` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_statistic_HypertensionVisit`(
  IN iOrgID INT,
  IN iYear INT
)
    COMMENT '[2.1]统计高血压随访'
label:BEGIN
  DECLARE m_IsIncludeNode TINYINT DEFAULT FALSE;
  
  DROP TABLE IF EXISTS tmp_org_mem;  
  
  SELECT TRUE INTO m_IsIncludeNode FROM orgs WHERE Superior = iOrgID LIMIT 1;
  
  IF m_IsIncludeNode THEN
    CREATE TEMPORARY TABLE tmp_org_mem
    SELECT DISTINCT t.OrgID AS id, a.Memberid, b.CreateTime
      FROM orgs t
      JOIN orgs t1 ON t1.Path LIKE CONCAT(t.Path,'%')
      JOIN omem a ON a.OrgID = t1.OrgID AND a.UseTag = 'T'
      JOIN mem3 b ON b.Memberid = a.Memberid AND b.DiseaseID = 1 AND YEAR(b.CreateTime) <= iYear
     WHERE t.Superior = iOrgID;
  ELSE
    CREATE TEMPORARY TABLE tmp_org_mem
    SELECT DISTINCT t.MemGrpid AS id, a.Memberid, b.CreateTime
      FROM omgs t
      JOIN omgs t1 ON t1.Path LIKE CONCAT(t.Path,'%')
      JOIN ompb t2 ON t2.MemGrpid = t1.MemGrpid
      JOIN omem a ON a.Memberid = t2.Memberid AND a.UseTag = 'T'
      JOIN mem3 b ON b.Memberid = a.Memberid AND b.DiseaseID = 1 AND YEAR(b.CreateTime) <= iYear
     WHERE t.faMemid = 0 AND t.OrgID = iOrgID;
  END IF;
    
  DROP TABLE IF EXISTS tmp_statistic_HypertensionVisit;
  CREATE TEMPORARY TABLE tmp_statistic_HypertensionVisit
  SELECT t.id,
         COUNT(DISTINCT t.Memberid) AS total, 
         COUNT(DISTINCT IF(a.HypertensionID IS NOT NULL AND a.HypertensionID <> '', t.Memberid, NULL)) AS manage_sum,
         0 AS rule_sum,
         COUNT(DISTINCT IF(YEAR(t.CreateTime) = iYear, t.Memberid, NULL)) AS newadd_sum,
         0 AS lastnormal_sum
    FROM tmp_org_mem t
    LEFT JOIN ph_hypertension a ON a.MemberID = t.MemberID AND YEAR(a.VisitDate) = iYear
   GROUP BY t.id;
    
  UPDATE tmp_statistic_HypertensionVisit a,
        (SELECT tmp.id, COUNT(DISTINCT tmp.Memberid) AS rule_sum
           FROM (
                 SELECT t.id, t.Memberid, COUNT(DISTINCT QUARTER(a.VisitDate)) AS count_n
                   FROM tmp_org_mem t, ph_hypertension a
                  WHERE t.MemberID = a.MemberID AND YEAR(a.VisitDate) = iYear
                  GROUP BY t.id, t.Memberid
                 HAVING (YEAR(CURDATE()) > iYear AND count_n = 4) OR (YEAR(CURDATE()) = iYear AND count_n = QUARTER(CURDATE()) - 1)
                ) tmp
          GROUP BY tmp.id) tmp2
     SET a.rule_sum = tmp2.rule_sum
   WHERE a.id = tmp2.id;
    
  UPDATE tmp_statistic_HypertensionVisit a,
        (SELECT tmp.id, COUNT(DISTINCT tmp.Memberid) AS lastnormal_sum
           FROM (
                 SELECT t.id, t.Memberid, SUBSTRING_INDEX(GROUP_CONCAT(b.Systolic ORDER BY a.VisitDate DESC, a.HypertensionID DESC),',',1) AS last_Systolic,
                        SUBSTRING_INDEX(GROUP_CONCAT(b.Diastolic ORDER BY a.VisitDate DESC, a.HypertensionID DESC),',',1) AS last_Diastolic
                   FROM tmp_org_mem t, ph_hypertension a, ph_hypertensiondetail b
                  WHERE t.MemberID = a.MemberID AND YEAR(a.VisitDate) = iYear AND b.HypertensionID = a.HypertensionID
                  GROUP BY t.id, t.Memberid
                 HAVING last_Systolic < 140 AND last_Diastolic < 90
                ) tmp
          GROUP BY tmp.id) tmp2
     SET a.lastnormal_sum = tmp2.lastnormal_sum
   WHERE a.id = tmp2.id;
    
  IF m_IsIncludeNode THEN
    SELECT a.OrgName AS `Name`, t.total, t.manage_sum, t.rule_sum, t.newadd_sum, t.lastnormal_sum
      FROM tmp_statistic_HypertensionVisit t, orgs a
     WHERE t.id = a.OrgID
     ORDER BY a.Order, a.OrgID;  
  ELSE
    SELECT a.MemGrpName AS `Name`, t.total, t.manage_sum, t.rule_sum, t.newadd_sum, t.lastnormal_sum
      FROM tmp_statistic_HypertensionVisit t, omgs a
     WHERE t.id = a.MemGrpid
     ORDER BY a.Order, a.MemGrpid;
  END IF;
    
  DROP TABLE IF EXISTS tmp_org_mem;
  DROP TABLE IF EXISTS tmp_statistic_HypertensionVisit;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_statistic_PopulationBaseInfo` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_statistic_PopulationBaseInfo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_statistic_PopulationBaseInfo`(
  IN iOrgID INT
)
    COMMENT '[2.0.4SP4]统计人口基本情况'
label:BEGIN
  if exists(select * from orgs where Superior = iOrgID) then
    SELECT t.OrgName as `Name`, COUNT(DISTINCT a.Memberid) AS total,
           COUNT(DISTINCT IF(YEAR(CURDATE()) - YEAR(a.BirthDate) >= 65, a.Memberid, NULL)) AS sixtyfive_sum,
           COUNT(DISTINCT IF(b.DiseaseID = 1, a.Memberid, NULL)) AS hypertension_sum,
           COUNT(DISTINCT IF(b.DiseaseID = 2, a.Memberid, NULL)) AS diabetes_sum
      FROM orgs t
      join orgs t1 on t1.Path LIKE CONCAT(t.Path,'%')
      JOIN omem a ON a.OrgID = t1.OrgID AND a.UseTag = 'T'
      LEFT JOIN mem3 b on b.Memberid = a.Memberid and b.DiseaseID in (1,2)
     where t.Superior = iOrgID
     GROUP BY t.Order, t.OrgID;
  else
    SELECT t.MemGrpName AS `Name`, COUNT(DISTINCT a.Memberid) AS total,
           COUNT(DISTINCT IF(YEAR(CURDATE()) - YEAR(a.BirthDate) >= 65, a.Memberid, NULL)) AS sixtyfive_sum,
           COUNT(DISTINCT IF(b.DiseaseID = 1, a.Memberid, NULL)) AS hypertension_sum,
           COUNT(DISTINCT IF(b.DiseaseID = 2, a.Memberid, NULL)) AS diabetes_sum
      FROM omgs t
      join omgs t1 on t1.Path like concat(t.Path,'%')
      join ompb t2 on t2.MemGrpid = t1.MemGrpid
      JOIN omem a ON a.Memberid = t2.Memberid AND a.UseTag = 'T'
      LEFT JOIN mem3 b ON b.Memberid = a.Memberid AND b.DiseaseID IN (1,2)
     WHERE t.faMemid = 0 and t.OrgID = iOrgID
     GROUP BY t.Order, t.MemGrpid;
  end if;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `proc_ttreatment_getMemberByDocId` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_ttreatment_getMemberByDocId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_ttreatment_getMemberByDocId`(
  IN iDocId INT,
  
  IN vMemName VARCHAR(20),
  IN vTel VARCHAR(30),
  IN vIdCard VARCHAR(30),
  
  IN iMemGrpid INT,
  IN idisease_id INT,
  IN iMemId INT,
  IN vLItemID_list VARCHAR(255),
  
  IN iCurrentPageIndex INT,
  IN iPageSize INT,
  OUT iCount INT
)
    COMMENT '[3.0]转诊记录->新增->查询会员列表'
label:BEGIN
  DECLARE m_OrgPath VARCHAR(300);
  DECLARE m_OrgID_list VARCHAR(300);
  
  SET iCount = 0;
  
  SELECT TRIM(BOTH ',' FROM b.Path) INTO m_OrgPath
    FROM odoc a, orgs b
   WHERE a.Tag = 'T' AND a.DocId = iDocId AND a.OrgID = b.OrgID;
  
  IF m_OrgPath IS NULL OR m_OrgPath = '' THEN LEAVE label; END IF;
  
  SET @SQL = 'SELECT a.Path INTO @OrgPath FROM orgs a, orgs_cfg b';
  SET @SQL = CONCAT(@SQL, ' WHERE a.OrgID = b.OrgID AND b.IsSharedParentNode = 0 AND a.OrgID IN (', MID(m_OrgPath,3), ')');
  SET @SQL = CONCAT(@SQL, ' ORDER BY a.Path DESC LIMIT 1');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  
  SET @OrgPath = TRIM(BOTH ',' FROM @OrgPath);
  IF @OrgPath IS NULL OR @OrgPath = m_OrgPath THEN
    SET m_OrgID_list = SUBSTRING_INDEX(m_OrgPath,',',-1);
  ELSE
    SET m_OrgID_list = REPLACE(m_OrgPath, @OrgPath, SUBSTRING_INDEX(@OrgPath,',',-1));
  END IF;
  
  SET @SQL = ' omem t JOIN ompb a ON a.MemberID = t.MemberID';
  SET @SQL = CONCAT(@SQL, ' JOIN odmt b ON b.MemGrpid = a.MemGrpid');
  SET @SQL = CONCAT(@SQL, ' JOIN dgp1 c ON c.OdgpId = b.OdgpId AND c.Docid = ', iDocId);
  SET @SQL = CONCAT(@SQL, ' JOIN odgp d ON d.OdgpId = c.OdgpId');
  SET @SQL = CONCAT(@SQL, ' JOIN omgs e ON e.MemGrpid = b.MemGrpid');
  IF iMemGrpid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND FIND_IN_SET(', iMemGrpid, ',e.Path)'); END IF;
  
  IF idisease_id != -1 THEN SET @SQL = CONCAT(@SQL, ' JOIN mem3 f ON f.MemberID = t.MemberID AND f.DiseaseID = ', idisease_id); END IF;
  IF iMemId != -1 THEN SET @SQL = CONCAT(@SQL, ' JOIN omes g ON g.MemId = t.MemId AND g.Tag = ''T'' AND g.MemId = ', iMemId); END IF;
  IF vLItemID_list IS NOT NULL AND vLItemID_list != '' THEN SET @SQL = CONCAT(@SQL, ' JOIN omem_labelitem h ON h.MemberID = t.MemberID AND h.LItemID IN (', vLItemID_list, ')'); END IF;
 
  SET @SQL = CONCAT(@SQL, ' WHERE t.useTag = ''T''');
  
  IF vMemName IS NOT NULL AND vMemName != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.MemName LIKE ''',vMemName,'%'''); END IF;
  IF vTel IS NOT NULL AND vTel != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.Tel LIKE ''',vTel,'%'''); END IF;
  IF vIdCard IS NOT NULL AND vIdCard != '' THEN SET @SQL = CONCAT(@SQL, ' AND t.IdCard LIKE ''',vIdCard,'%'''); END IF;
  
  IF vLItemID_list IS NOT NULL AND vLItemID_list != '' THEN 
    SET @SQL = CONCAT(' SELECT t.MemberID FROM', @SQL);
    SET @SQL = CONCAT(@SQL, ' GROUP BY t.MemberID');
    SET @SQL = CONCAT(@SQL, ' HAVING COUNT(DISTINCT h.LItemID) = ', LENGTH(vLItemID_list) - LENGTH(REPLACE(vLItemID_list,',','')) + 1);
    SET @c_SQL = CONCAT('SELECT COUNT(tmp.MemberID) INTO @iCount FROM (', @SQL, ')tmp');  
  ELSE
    SET @c_SQL = CONCAT('SELECT COUNT(DISTINCT t.MemberID) INTO @iCount FROM', @SQL);
    
    SET @SQL = CONCAT(' SELECT t.MemberID FROM', @SQL);
    SET @SQL = CONCAT(@SQL, ' GROUP BY t.MemberID');
  END IF;
  
  PREPARE stmt FROM @c_SQL;
  EXECUTE stmt;
  SET iCount = @iCount; 
  
  SET @SQL = CONCAT(@SQL, ' LIMIT ', iCurrentPageIndex*iPageSize, ',', iPageSize);
  
  SET @SQL = CONCAT('SELECT t.MemberID, t.MemName, t.Gender, t.Tel, g.MemName as MemberTypeName, GROUP_CONCAT(DISTINCT e.MemGrpName) AS MemGrpName_List, GROUP_CONCAT(DISTINCT f.DiseaseName) AS DiseaseName_List, GROUP_CONCAT(DISTINCT i.ItemName) AS ItemName_List FROM (',@SQL, ')tmp');
  
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem t ON t.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN ompb a ON a.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omgs e ON e.MemGrpid = a.MemGrpid');
  IF iMemGrpid != -1 THEN SET @SQL = CONCAT(@SQL, ' AND FIND_IN_SET(', iMemGrpid, ',e.Path)'); END IF;
  
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN mem3 f ON f.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omes g ON g.Memid = t.Memid AND g.Tag = ''T''');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN omem_labelitem h ON h.MemberID = tmp.MemberID');
  SET @SQL = CONCAT(@SQL, ' LEFT JOIN tb_label_item i ON i.LItemID = h.LItemID AND i.ItemStatus = 2 AND (i.UseRange = 1 OR (i.OrgID IN (', m_OrgID_list, ') AND i.UseRange = 2) OR (i.UseRange = 3 AND i.CreateID = ',iDocId,'))');
  SET @SQL = CONCAT(@SQL, ' GROUP BY tmp.MemberID');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/* Procedure structure for procedure `Pro_GetOdgp` */

/*!50003 DROP PROCEDURE IF EXISTS  `Pro_GetOdgp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `Pro_GetOdgp`(IN idd INT)
BEGIN
  DECLARE lev INT;
  SET lev=1;
  
  DROP TABLE IF EXISTS tmp1;
  CREATE TABLE tmp1(id INT,levv INT);
  
  INSERT tmp1 SELECT odgpId ,1 FROM odgp WHERE fathId=idd;
  WHILE  ROW_COUNT()>0
  DO
    SET lev=lev+1;
    INSERT tmp1 SELECT t.odgpId,lev FROM odgp t JOIN tmp1 a ON t.fathId=a.id AND a.levv=lev-1;
  END WHILE ;
     
  INSERT tmp1 SELECT odgpId ,lev FROM odgp WHERE odgpId=idd ;
  SELECT id FROM tmp1 ORDER BY levv DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Pro_GetOmgs` */

/*!50003 DROP PROCEDURE IF EXISTS  `Pro_GetOmgs` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `Pro_GetOmgs`(IN idd INT)
BEGIN
  DECLARE lev INT;
  SET lev=1;
  
  DROP TABLE IF EXISTS tmp1;
  CREATE TABLE tmp1(id INT,levv INT);
  INSERT tmp1 SELECT MemGrpid ,1 FROM omgs WHERE faMemid=idd;
  WHILE  ROW_COUNT()>0
  DO
    SET lev=lev+1;
    INSERT tmp1 SELECT t.MemGrpid,lev FROM omgs t JOIN tmp1 a ON t.faMemid=a.id AND a.levv=lev-1;
  END WHILE ;
     
  INSERT tmp1 SELECT MemGrpid ,lev FROM omgs WHERE MemGrpid=idd ;
  SELECT id FROM tmp1 ORDER BY levv DESC;
END */$$
DELIMITER ;

/*Table structure for table `v_dgp1` */

DROP TABLE IF EXISTS `v_dgp1`;

/*!50001 DROP VIEW IF EXISTS `v_dgp1` */;
/*!50001 DROP TABLE IF EXISTS `v_dgp1` */;

/*!50001 CREATE TABLE  `v_dgp1`(
 `OdgpId` int(11) ,
 `Docid` int(11) ,
 `AuditLevel` smallint(6) ,
 `RoleId` smallint(6) ,
 `DocName` varchar(20) ,
 `Title` varchar(20) ,
 `Gender` char(1) ,
 `BirthDate` date ,
 `ContactTel` varchar(20) ,
 `Tel` varchar(20) ,
 `Email` varchar(30) ,
 `HomeAddress` varchar(200) ,
 `workAddress` varchar(100) ,
 `UnitAddress` varchar(200) ,
 `ResideAddress` varchar(200) ,
 `CertiType` char(1) ,
 `CertiNum` varchar(50) ,
 `Weixin` varchar(20) ,
 `Desription` varchar(5000) ,
 `WorkDepart` varchar(20) ,
 `HeadAddress` varchar(100) ,
 `SignAddress` varchar(100) ,
 `Tag` char(1) ,
 `OdgpName` varchar(50) ,
 `Remark` varchar(100) ,
 `FathId` int(11) ,
 `DocNum` int(11) ,
 `ChLevel` smallint(6) ,
 `OptId` smallint(6) ,
 `FunId` smallint(6) ,
 `EndBlockTag` tinyint(1) ,
 `UseTag` char(1) ,
 `OrgId` int(11) ,
 `OrgCode` char(20) ,
 `OrgName` varchar(50) ,
 `IsExternalService` char(1) 
)*/;

/*Table structure for table `v_ocam` */

DROP TABLE IF EXISTS `v_ocam`;

/*!50001 DROP VIEW IF EXISTS `v_ocam` */;
/*!50001 DROP TABLE IF EXISTS `v_ocam` */;

/*!50001 CREATE TABLE  `v_ocam`(
 `CombAnsid` int(11) ,
 `CombQustid` int(11) ,
 `CombQustName` varchar(50) ,
 `CombQustCode` int(11) ,
 `CombDesc` varchar(500) ,
 `PublisherTime` datetime ,
 `Memberid` int(11) ,
 `ChTag` char(1) ,
 `CombTag` char(1) ,
 `AssessDate` date ,
 `Docid` int(11) ,
 `DocName` varchar(20) ,
 `OrgId` int(11) ,
 `DocAcc` varchar(50) ,
 `DocPass` varchar(50) ,
 `LogRole` char(1) ,
 `Tag` char(1) ,
 `MemName` varchar(20) 
)*/;

/*Table structure for table `v_odgp` */

DROP TABLE IF EXISTS `v_odgp`;

/*!50001 DROP VIEW IF EXISTS `v_odgp` */;
/*!50001 DROP TABLE IF EXISTS `v_odgp` */;

/*!50001 CREATE TABLE  `v_odgp`(
 `OdgpId` int(11) ,
 `OdgpName` varchar(50) ,
 `Remark` varchar(100) ,
 `FathId` int(11) ,
 `DocNum` int(11) ,
 `ChLevel` smallint(6) ,
 `OrgId` int(11) ,
 `OptId` smallint(6) ,
 `FunId` smallint(6) ,
 `EndBlockTag` tinyint(1) ,
 `UseTag` char(1) ,
 `OrgCode` char(20) ,
 `OrgName` varchar(50) ,
 `OptName` varchar(50) ,
 `OptDes` varchar(150) ,
 `FunName` varchar(50) ,
 `FunDes` varchar(150) ,
 `ooptCHLevel` smallint(6) 
)*/;

/*Table structure for table `v_odmt` */

DROP TABLE IF EXISTS `v_odmt`;

/*!50001 DROP VIEW IF EXISTS `v_odmt` */;
/*!50001 DROP TABLE IF EXISTS `v_odmt` */;

/*!50001 CREATE TABLE  `v_odmt`(
 `OrgId` int(11) ,
 `OdgpId` int(11) ,
 `OdgpName` varchar(50) ,
 `Remark` varchar(100) ,
 `DocNum` int(11) ,
 `ChLevel` smallint(6) ,
 `OptId` smallint(6) ,
 `OptName` varchar(50) ,
 `FunId` smallint(6) ,
 `FunName` varchar(50) ,
 `EndBlockTag` tinyint(1) ,
 `Usetag` char(1) ,
 `MemGrpid` int(11) ,
 `MemGrpName` varchar(20) ,
 `MemGrpDesc` varchar(100) ,
 `omgsUseTag` char(1) 
)*/;

/*Table structure for table `v_omgs` */

DROP TABLE IF EXISTS `v_omgs`;

/*!50001 DROP VIEW IF EXISTS `v_omgs` */;
/*!50001 DROP TABLE IF EXISTS `v_omgs` */;

/*!50001 CREATE TABLE  `v_omgs`(
 `MemGrpid` int(11) ,
 `MemGrpName` varchar(20) ,
 `MemGrpDesc` varchar(100) ,
 `faMemid` int(11) ,
 `OrgId` int(11) ,
 `OrgName` varchar(50) ,
 `OrgCode` char(20) ,
 `UseTag` char(1) 
)*/;

/*Table structure for table `v_ompb` */

DROP TABLE IF EXISTS `v_ompb`;

/*!50001 DROP VIEW IF EXISTS `v_ompb` */;
/*!50001 DROP TABLE IF EXISTS `v_ompb` */;

/*!50001 CREATE TABLE  `v_ompb`(
 `MemGrpid` int(11) ,
 `Memberid` int(11) ,
 `MemGrpName` varchar(20) ,
 `MemGrpDesc` varchar(100) ,
 `faMemid` int(11) ,
 `LogName` varchar(20) ,
 `MemId` smallint(6) ,
 `MemName` varchar(20) ,
 `Gender` char(1) ,
 `BirthDate` date ,
 `Tel` varchar(30) ,
 `Email` varchar(30) ,
 `IdCard` varchar(30) ,
 `Address` varchar(200) ,
 `MarryStatus` char(1) ,
 `EducationStatus` char(2) ,
 `Occupation` varchar(20) ,
 `Docid` int(11) ,
 `DocName` varchar(20) ,
 `CreateTime` datetime ,
 `OrgId` int(11) ,
 `UseTag` char(1) 
)*/;

/*Table structure for table `v_oopt` */

DROP TABLE IF EXISTS `v_oopt`;

/*!50001 DROP VIEW IF EXISTS `v_oopt` */;
/*!50001 DROP TABLE IF EXISTS `v_oopt` */;

/*!50001 CREATE TABLE  `v_oopt`(
 `OptId` smallint(6) ,
 `FunId` smallint(6) ,
 `OptName` varchar(50) ,
 `OptDes` varchar(150) ,
 `CHLevel` smallint(6) ,
 `Tag` char(1) ,
 `FunName` varchar(50) ,
 `FunDes` varchar(150) ,
 `Orgid` int(11) 
)*/;

/*Table structure for table `v_ouai` */

DROP TABLE IF EXISTS `v_ouai`;

/*!50001 DROP VIEW IF EXISTS `v_ouai` */;
/*!50001 DROP TABLE IF EXISTS `v_ouai` */;

/*!50001 CREATE TABLE  `v_ouai`(
 `AnsNumber` int(11) ,
 `Memberid` int(11) ,
 `Qustid` int(11) ,
 `QustVer` varchar(20) ,
 `AssessDate` date ,
 `ChTag` char(1) ,
 `QustTag` char(1) ,
 `QustCode` varchar(20) ,
 `PublisherTime` datetime ,
 `FailureTime` datetime ,
 `FunId` smallint(6) ,
 `OptId` smallint(6) ,
 `Docid` int(11) ,
 `DocName` varchar(20) ,
 `OrgId` int(11) ,
 `Qustname` varchar(50) ,
 `AnsMode` char(1) ,
 `Desription` varchar(100) ,
 `QustDesc` varchar(1000) ,
 `CreateDate` date ,
 `Createid` int(11) ,
 `CreateName` varchar(20) ,
 `LogName` varchar(20) ,
 `MemId` smallint(6) ,
 `MemName` varchar(20) ,
 `Gender` char(1) ,
 `BirthDate` date ,
 `Tel` varchar(30) ,
 `Email` varchar(30) ,
 `IdCard` varchar(30) ,
 `Address` varchar(200) ,
 `MarryStatus` char(1) ,
 `EducationStatus` char(2) ,
 `Occupation` varchar(20) ,
 `UseTag` char(1) ,
 `CreateTime` datetime 
)*/;

/*Table structure for table `v_uai21` */

DROP TABLE IF EXISTS `v_uai21`;

/*!50001 DROP VIEW IF EXISTS `v_uai21` */;
/*!50001 DROP TABLE IF EXISTS `v_uai21` */;

/*!50001 CREATE TABLE  `v_uai21`(
 `AnsNumber` int(11) ,
 `Problemid` int(11) ,
 `Ansid` smallint(6) ,
 `Score` double(6,1) ,
 `Fillblank` varchar(100) ,
 `Qustid` int(11) ,
 `QustTypeid` smallint(6) ,
 `ProDesc` varchar(200) ,
 `LineNum` smallint(6) ,
 `AnsType` char(1) ,
 `relation` char(1) ,
 `Uproblemid` int(11) ,
 `Uansid` smallint(6) ,
 `CreateDate` date ,
 `Description` varchar(200) ,
 `Mark` char(1) ,
 `FillTag` char(1) ,
 `isValidate` tinyint(1) ,
 `MinScore` smallint(6) ,
 `MaxScore` smallint(6) ,
 `ComTag` char(1) ,
 `Createid` int(11) ,
 `DocName` varchar(20) 
)*/;

/*View structure for view v_dgp1 */

/*!50001 DROP TABLE IF EXISTS `v_dgp1` */;
/*!50001 DROP VIEW IF EXISTS `v_dgp1` */;

/*!50001 CREATE ALGORITHM=MERGE DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_dgp1` AS select `dgp1`.`OdgpId` AS `OdgpId`,`dgp1`.`Docid` AS `Docid`,`dgp1`.`AuditLevel` AS `AuditLevel`,`odoc`.`RoleId` AS `RoleId`,`odoc`.`DocName` AS `DocName`,`odoc`.`Title` AS `Title`,`odoc`.`Gender` AS `Gender`,`odoc`.`BirthDate` AS `BirthDate`,`odoc`.`ContactTel` AS `ContactTel`,`odoc`.`Tel` AS `Tel`,`odoc`.`Email` AS `Email`,`odoc`.`HomeAddress` AS `HomeAddress`,`odoc`.`workAddress` AS `workAddress`,`odoc`.`UnitAddress` AS `UnitAddress`,`odoc`.`ResideAddress` AS `ResideAddress`,`odoc`.`CertiType` AS `CertiType`,`odoc`.`CertiNum` AS `CertiNum`,`odoc`.`Weixin` AS `Weixin`,`odoc`.`Desription` AS `Desription`,`odoc`.`WorkDepart` AS `WorkDepart`,`odoc`.`HeadAddress` AS `HeadAddress`,`odoc`.`SignAddress` AS `SignAddress`,`odoc`.`Tag` AS `Tag`,`odgp`.`OdgpName` AS `OdgpName`,`odgp`.`Remark` AS `Remark`,`odgp`.`FathId` AS `FathId`,`odgp`.`DocNum` AS `DocNum`,`odgp`.`ChLevel` AS `ChLevel`,`odgp`.`OptId` AS `OptId`,`odgp`.`FunId` AS `FunId`,`odgp`.`EndBlockTag` AS `EndBlockTag`,`odgp`.`UseTag` AS `UseTag`,`odoc`.`OrgId` AS `OrgId`,`orgs`.`OrgCode` AS `OrgCode`,`orgs`.`OrgName` AS `OrgName`,`orgs`.`IsExternalService` AS `IsExternalService` from (((`dgp1` join `odoc`) join `odgp`) join `orgs`) where ((`dgp1`.`OdgpId` = `odgp`.`OdgpId`) and (`dgp1`.`Docid` = `odoc`.`Docid`) and (`odgp`.`OrgId` = `orgs`.`OrgId`)) */;

/*View structure for view v_ocam */

/*!50001 DROP TABLE IF EXISTS `v_ocam` */;
/*!50001 DROP VIEW IF EXISTS `v_ocam` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_ocam` AS select `ocam`.`CombAnsid` AS `CombAnsid`,`ocam`.`CombQustid` AS `CombQustid`,`ocam`.`CombQustName` AS `CombQustName`,`ocam`.`CombQustCode` AS `CombQustCode`,`ocam`.`CombDesc` AS `CombDesc`,`ocam`.`PublisherTime` AS `PublisherTime`,`ocam`.`Memberid` AS `Memberid`,`ocam`.`ChTag` AS `ChTag`,`ocam`.`CombTag` AS `CombTag`,`ocam`.`AssessDate` AS `AssessDate`,`ocam`.`Docid` AS `Docid`,`ocam`.`DocName` AS `DocName`,`doc1`.`OrgId` AS `OrgId`,`doc1`.`DocAcc` AS `DocAcc`,`doc1`.`DocPass` AS `DocPass`,`doc1`.`LogRole` AS `LogRole`,`doc1`.`Tag` AS `Tag`,`omem`.`MemName` AS `MemName` from ((`ocam` join `doc1`) join `omem`) where ((`ocam`.`Docid` = `doc1`.`Docid`) and (`ocam`.`Memberid` = `omem`.`Memberid`)) order by `ocam`.`CombAnsid` desc */;

/*View structure for view v_odgp */

/*!50001 DROP TABLE IF EXISTS `v_odgp` */;
/*!50001 DROP VIEW IF EXISTS `v_odgp` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_odgp` AS select `odgp`.`OdgpId` AS `OdgpId`,`odgp`.`OdgpName` AS `OdgpName`,`odgp`.`Remark` AS `Remark`,`odgp`.`FathId` AS `FathId`,`odgp`.`DocNum` AS `DocNum`,`odgp`.`ChLevel` AS `ChLevel`,`odgp`.`OrgId` AS `OrgId`,`odgp`.`OptId` AS `OptId`,`odgp`.`FunId` AS `FunId`,`odgp`.`EndBlockTag` AS `EndBlockTag`,`odgp`.`UseTag` AS `UseTag`,`orgs`.`OrgCode` AS `OrgCode`,`orgs`.`OrgName` AS `OrgName`,`oopt`.`OptName` AS `OptName`,`oopt`.`OptDes` AS `OptDes`,`ofun`.`FunName` AS `FunName`,`ofun`.`FunDes` AS `FunDes`,`oopt`.`CHLevel` AS `ooptCHLevel` from (((`odgp` join `orgs`) join `oopt`) join `ofun`) where ((`odgp`.`OrgId` = `orgs`.`OrgId`) and (`odgp`.`OptId` = `oopt`.`OptId`) and (`odgp`.`FunId` = `ofun`.`FunId`)) */;

/*View structure for view v_odmt */

/*!50001 DROP TABLE IF EXISTS `v_odmt` */;
/*!50001 DROP VIEW IF EXISTS `v_odmt` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_odmt` AS select `a`.`OrgId` AS `OrgId`,`a`.`OdgpId` AS `OdgpId`,`a`.`OdgpName` AS `OdgpName`,`a`.`Remark` AS `Remark`,`a`.`DocNum` AS `DocNum`,`a`.`ChLevel` AS `ChLevel`,`a`.`OptId` AS `OptId`,`b`.`OptName` AS `OptName`,`a`.`FunId` AS `FunId`,`c`.`FunName` AS `FunName`,`a`.`EndBlockTag` AS `EndBlockTag`,`a`.`UseTag` AS `Usetag`,`e`.`MemGrpid` AS `MemGrpid`,`e`.`MemGrpName` AS `MemGrpName`,`e`.`MemGrpDesc` AS `MemGrpDesc`,`e`.`UseTag` AS `omgsUseTag` from ((((`odgp` `a` join `oopt` `b` on((`a`.`OptId` = `b`.`OptId`))) join `ofun` `c` on((`a`.`FunId` = `c`.`FunId`))) join `odmt` `d`) join `omgs` `e` on(((`a`.`OdgpId` = `d`.`OdgpId`) and (`d`.`MemGrpid` = `e`.`MemGrpid`)))) */;

/*View structure for view v_omgs */

/*!50001 DROP TABLE IF EXISTS `v_omgs` */;
/*!50001 DROP VIEW IF EXISTS `v_omgs` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_omgs` AS select `a`.`MemGrpid` AS `MemGrpid`,`a`.`MemGrpName` AS `MemGrpName`,`a`.`MemGrpDesc` AS `MemGrpDesc`,`a`.`faMemid` AS `faMemid`,`a`.`OrgId` AS `OrgId`,`b`.`OrgName` AS `OrgName`,`b`.`OrgCode` AS `OrgCode`,`a`.`UseTag` AS `UseTag` from (`omgs` `a` join `orgs` `b` on((`a`.`OrgId` = `b`.`OrgId`))) */;

/*View structure for view v_ompb */

/*!50001 DROP TABLE IF EXISTS `v_ompb` */;
/*!50001 DROP VIEW IF EXISTS `v_ompb` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_ompb` AS select `ompb`.`MemGrpid` AS `MemGrpid`,`ompb`.`Memberid` AS `Memberid`,`omgs`.`MemGrpName` AS `MemGrpName`,`omgs`.`MemGrpDesc` AS `MemGrpDesc`,`omgs`.`faMemid` AS `faMemid`,`omem`.`LogName` AS `LogName`,`omem`.`MemId` AS `MemId`,`omem`.`MemName` AS `MemName`,`omem`.`Gender` AS `Gender`,`omem`.`BirthDate` AS `BirthDate`,`omem`.`Tel` AS `Tel`,`omem`.`Email` AS `Email`,`omem`.`IdCard` AS `IdCard`,`omem`.`Address` AS `Address`,`omem`.`MarryStatus` AS `MarryStatus`,`omem`.`EducationStatus` AS `EducationStatus`,`omem`.`Occupation` AS `Occupation`,`omem`.`Docid` AS `Docid`,`omem`.`DocName` AS `DocName`,`omem`.`CreateTime` AS `CreateTime`,`omgs`.`OrgId` AS `OrgId`,`omem`.`UseTag` AS `UseTag` from ((`ompb` join `omgs`) join `omem`) where ((`ompb`.`MemGrpid` = `omgs`.`MemGrpid`) and (`ompb`.`Memberid` = `omem`.`Memberid`)) */;

/*View structure for view v_oopt */

/*!50001 DROP TABLE IF EXISTS `v_oopt` */;
/*!50001 DROP VIEW IF EXISTS `v_oopt` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_oopt` AS select `oo`.`OptId` AS `OptId`,`oo`.`FunId` AS `FunId`,`oo`.`OptName` AS `OptName`,`oo`.`OptDes` AS `OptDes`,`oo`.`CHLevel` AS `CHLevel`,`oo`.`Tag` AS `Tag`,`of`.`FunName` AS `FunName`,`of`.`FunDes` AS `FunDes`,`oo`.`orgid` AS `Orgid` from (`oopt` `oo` join `ofun` `of`) where (`oo`.`FunId` = `of`.`FunId`) */;

/*View structure for view v_ouai */

/*!50001 DROP TABLE IF EXISTS `v_ouai` */;
/*!50001 DROP VIEW IF EXISTS `v_ouai` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_ouai` AS select `ouai`.`AnsNumber` AS `AnsNumber`,`ouai`.`Memberid` AS `Memberid`,`ouai`.`Qustid` AS `Qustid`,`ouai`.`QustVer` AS `QustVer`,`ouai`.`AssessDate` AS `AssessDate`,`ouai`.`ChTag` AS `ChTag`,`ouai`.`QustTag` AS `QustTag`,`ouai`.`QustCode` AS `QustCode`,`ouai`.`PublisherTime` AS `PublisherTime`,`ouai`.`FailureTime` AS `FailureTime`,`ouai`.`FunId` AS `FunId`,`ouai`.`OptId` AS `OptId`,`ouai`.`Docid` AS `Docid`,`ouai`.`DocName` AS `DocName`,`omfq`.`OrgId` AS `OrgId`,`omfq`.`Qustname` AS `Qustname`,`omfq`.`AnsMode` AS `AnsMode`,`omfq`.`Desription` AS `Desription`,`omfq`.`QustDesc` AS `QustDesc`,`omfq`.`CreateDate` AS `CreateDate`,`omfq`.`Createid` AS `Createid`,`omfq`.`CreateName` AS `CreateName`,`omem`.`LogName` AS `LogName`,`omem`.`MemId` AS `MemId`,`omem`.`MemName` AS `MemName`,`omem`.`Gender` AS `Gender`,`omem`.`BirthDate` AS `BirthDate`,`omem`.`Tel` AS `Tel`,`omem`.`Email` AS `Email`,`omem`.`IdCard` AS `IdCard`,`omem`.`Address` AS `Address`,`omem`.`MarryStatus` AS `MarryStatus`,`omem`.`EducationStatus` AS `EducationStatus`,`omem`.`Occupation` AS `Occupation`,`omem`.`UseTag` AS `UseTag`,`omem`.`CreateTime` AS `CreateTime` from ((`ouai` join `omem`) join `omfq`) where ((`ouai`.`Qustid` = `omfq`.`Qustid`) and (`ouai`.`Memberid` = `omem`.`Memberid`)) order by `ouai`.`AnsNumber` desc */;

/*View structure for view v_uai21 */

/*!50001 DROP TABLE IF EXISTS `v_uai21` */;
/*!50001 DROP VIEW IF EXISTS `v_uai21` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_uai21` AS select `uai21`.`AnsNumber` AS `AnsNumber`,`uai21`.`Problemid` AS `Problemid`,`uai21`.`Ansid` AS `Ansid`,`uai21`.`Score` AS `Score`,`uai21`.`Fillblank` AS `Fillblank`,`mfq1`.`Qustid` AS `Qustid`,`mfq1`.`QustTypeid` AS `QustTypeid`,`mfq1`.`ProDesc` AS `ProDesc`,`mfq1`.`LineNum` AS `LineNum`,`mfq1`.`AnsType` AS `AnsType`,`mfq1`.`relation` AS `relation`,`mfq1`.`Uproblemid` AS `Uproblemid`,`mfq1`.`Uansid` AS `Uansid`,`mfq1`.`CreateDate` AS `CreateDate`,`mfq11`.`Description` AS `Description`,`mfq11`.`Mark` AS `Mark`,`mfq11`.`FillTag` AS `FillTag`,`mfq11`.`isValidate` AS `isValidate`,`mfq11`.`MinScore` AS `MinScore`,`mfq11`.`MaxScore` AS `MaxScore`,`mfq11`.`ComTag` AS `ComTag`,`mfq11`.`Createid` AS `Createid`,`mfq11`.`DocName` AS `DocName` from ((`uai21` left join `mfq1` on(((`uai21`.`Problemid` = `mfq1`.`Problemid`) and (`mfq1`.`Qustid` = (select `ouai`.`Qustid` from `ouai` where (`ouai`.`AnsNumber` = `uai21`.`AnsNumber`)))))) left join `mfq11` on(((`mfq11`.`Qustid` = (select `ouai`.`Qustid` from `ouai` where (`ouai`.`AnsNumber` = `uai21`.`AnsNumber`))) and (`mfq11`.`Problemid` = `uai21`.`Problemid`) and (`mfq11`.`Ansid` = `uai21`.`Ansid`)))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
