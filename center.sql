/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.1.73 : Database - UnifiedCertification_v30
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`UnifiedCertification_v30` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `UnifiedCertification_v30`;

/*Table structure for table `app` */

DROP TABLE IF EXISTS `app`;

CREATE TABLE `app` (
  `appId` int(11) NOT NULL AUTO_INCREMENT,
  `appName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`appId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `app_server` */

DROP TABLE IF EXISTS `app_server`;

CREATE TABLE `app_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appId` int(11) NOT NULL,
  `serverName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ipAddress` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `createName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createDate` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `webAddress` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `centerServerUrl` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `HttpsAddress` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '[3.0]Https地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `logfile` */

DROP TABLE IF EXISTS `logfile`;

CREATE TABLE `logfile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL COMMENT '项目编号',
  `version` varchar(50) DEFAULT NULL COMMENT '版本号',
  `url` varchar(150) DEFAULT NULL COMMENT '日志文件绝对路径',
  `upload_time` datetime DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=936 DEFAULT CHARSET=utf8;

/*Table structure for table `m_focus_familynews` */

DROP TABLE IF EXISTS `m_focus_familynews`;

CREATE TABLE `m_focus_familynews` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `MsgType` tinyint(4) NOT NULL COMMENT '消息类型：10-测量数据(停用)，11-体检随访，12-高血压随访，13-II型糖尿病随访，15-血压测量，16-血糖测量，17-心电测量，18-3合1测量',
  `Sender` char(36) NOT NULL COMMENT '发送者',
  `Receiver` char(36) DEFAULT NULL COMMENT '接收者',
  `SourceID` bigint(20) NOT NULL COMMENT '消息来源ID',
  `Content` varchar(500) NOT NULL COMMENT '消息内容',
  `IsSend` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否发送：0-否，1-是',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_S_R` (`Sender`,`Receiver`)
) ENGINE=InnoDB AUTO_INCREMENT=722 DEFAULT CHARSET=utf8 COMMENT='[1.1]关注的亲友动态表';

/*Table structure for table `m_focus_info` */

DROP TABLE IF EXISTS `m_focus_info`;

CREATE TABLE `m_focus_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `focusType` int(11) NOT NULL COMMENT '关注类型 1表示主动添加，2表示被邀请',
  `memberId` int(11) DEFAULT NULL COMMENT '关注方会员id',
  `memberGUID` char(36) NOT NULL COMMENT '会员GUID',
  `focusId` int(11) DEFAULT NULL COMMENT '被关注方的会员id',
  `focusGUID` char(36) NOT NULL COMMENT '被关注的会员GUID',
  `focusStatus` int(11) DEFAULT NULL COMMENT '关注状态：1-表示未处理，2-表示接受，3-表示拒绝',
  `focusP` varchar(20) DEFAULT NULL COMMENT '允许关注项，格式如下1，2，3关注项的id字符',
  `focusPed` varchar(20) DEFAULT NULL COMMENT '已关注项，格式如下1，2，3关注项的id字符',
  `tag` varchar(5) DEFAULT NULL COMMENT '关注是否过期，N表示未过期Y表示关注方取消Z表示被关注方取消',
  `createTime` varchar(20) DEFAULT NULL,
  `newsLetter` smallint(5) unsigned zerofill DEFAULT NULL COMMENT '<废弃> 1表示关注方接受信息2表示不接收',
  `memberRemark` varchar(255) DEFAULT NULL COMMENT '关注方备注',
  `focusRemark` varchar(255) DEFAULT NULL COMMENT '被关注方备注',
  PRIMARY KEY (`id`),
  KEY `idx_MGUID` (`memberGUID`),
  KEY `idx_FGUID` (`focusGUID`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COMMENT='[1.1]关注表';

/*Table structure for table `memberunifiedlogin` */

DROP TABLE IF EXISTS `memberunifiedlogin`;

CREATE TABLE `memberunifiedlogin` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `MemberID` char(36) NOT NULL COMMENT '[1.1]会员ID',
  `Account` varchar(50) NOT NULL COMMENT '会员账号',
  `AccountType` tinyint(4) NOT NULL COMMENT '账号类型：1-手机号码，2-邮件，3-身份证，4-内部账号[1.1]',
  `serverId` int(11) NOT NULL COMMENT '服务ID(引用appRecode.app_server.id)',
  `CreateTime` datetime NOT NULL COMMENT '记录创建时间',
  `UpdateTime` datetime DEFAULT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`LogID`),
  UNIQUE KEY `uk_A` (`Account`),
  KEY `idx_MID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=130542 DEFAULT CHARSET=utf8 COMMENT='会员统一登录表';

/*Table structure for table `project` */

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `code` varchar(50) NOT NULL COMMENT '项目编号',
  `name` varchar(100) NOT NULL COMMENT '项目名',
  `appId` int(11) DEFAULT NULL COMMENT 'app服务Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Table structure for table `recode` */

DROP TABLE IF EXISTS `recode`;

CREATE TABLE `recode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `appId` int(11) NOT NULL,
  `versionCode` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `updateInfo` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `isForce` int(2) NOT NULL,
  `createName` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `appFile` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `createDate` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `downUrl` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `tb_doctor` */

DROP TABLE IF EXISTS `tb_doctor`;

CREATE TABLE `tb_doctor` (
  `DocID` int(11) NOT NULL AUTO_INCREMENT COMMENT '医生ID',
  `DocGUID` char(36) NOT NULL COMMENT '医生GUID',
  `RoleId` smallint(6) DEFAULT NULL COMMENT '角色代码',
  `OrgId` int(11) DEFAULT NULL COMMENT '组织代码',
  `DocName` varchar(20) DEFAULT NULL COMMENT '医生姓名',
  `Gender` char(1) DEFAULT NULL COMMENT '性别',
  `BirthDate` date DEFAULT NULL COMMENT '出生年月',
  `Tel` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `IDCard` varchar(30) DEFAULT NULL COMMENT '身份证号',
  `Weixin` varchar(20) DEFAULT NULL COMMENT '微信号',
  `HeadAddress` varchar(100) DEFAULT NULL COMMENT '头像地址',
  `Passwd` varchar(50) NOT NULL COMMENT '密码',
  `IsFirstLogin` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否首次登录：0-否，1-是',
  `VerifyType` tinyint(4) NOT NULL DEFAULT '0' COMMENT '认证类型(位运算)：0-无，1-手机认证',
  `Tag` char(1) DEFAULT NULL COMMENT '状态标记：T-有效，E-删除',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`DocID`),
  UNIQUE KEY `uk_DGUID` (`DocGUID`),
  KEY `idx_DN8` (`DocName`(8)),
  KEY `idx_T11` (`Tel`(11))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='[3.1]医生';

/*Table structure for table `tb_kindlyreminder` */

DROP TABLE IF EXISTS `tb_kindlyreminder`;

CREATE TABLE `tb_kindlyreminder` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `SendType` tinyint(4) NOT NULL COMMENT '发送类型：1-医生，2-会员',
  `Sender` char(36) NOT NULL COMMENT '发送者',
  `SenderName` varchar(20) DEFAULT NULL COMMENT '发送者姓名',
  `Receiver` char(36) NOT NULL COMMENT '接收者(会员)',
  `Content` text NOT NULL COMMENT '内容',
  `ScheduleTime` datetime NOT NULL COMMENT '计划发送时间',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_S` (`Sender`),
  KEY `idx_R` (`Receiver`),
  KEY `idx_CT` (`CreateTime`)
) ENGINE=InnoDB AUTO_INCREMENT=24534 DEFAULT CHARSET=utf8 COMMENT='[1.1]温馨提示表';

/*Table structure for table `tb_log_update` */

DROP TABLE IF EXISTS `tb_log_update`;

CREATE TABLE `tb_log_update` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '升级记录ID',
  `VersionNo` varchar(10) NOT NULL COMMENT '版本号',
  `Description` varchar(20) DEFAULT NULL COMMENT '描述',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='[3.0]升级记录';

/*Table structure for table `tb_member` */

DROP TABLE IF EXISTS `tb_member`;

CREATE TABLE `tb_member` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增记录ID',
  `ServerID` int(11) NOT NULL COMMENT '服务器ID(引用appRecode.app_server.id)',
  `MemberID` char(36) NOT NULL COMMENT '会员ID',
  `MemberName` varchar(50) NOT NULL COMMENT '名称',
  `MemNameCode` varchar(20) DEFAULT NULL COMMENT '[3.0]会员名称简码',
  `MemberSex` tinyint(4) DEFAULT NULL COMMENT '性别：1-男；2-女；3-未知',
  `Birthday` date DEFAULT NULL COMMENT '出生日期',
  `Mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `IDCard` varchar(30) DEFAULT NULL COMMENT '身份证号',
  `HeadAddress` varchar(50) DEFAULT NULL COMMENT '头像地址',
  `Pwd` varchar(50) NOT NULL COMMENT '密码',
  `SyncTimestamp` bigint(20) DEFAULT NULL COMMENT '同步时间戳',
  `VerifyType` tinyint(4) NOT NULL DEFAULT '0' COMMENT '[3.0]认证类型(位运算)：0-无，1-手机认证',
  `IsInfoPerfect` tinyint(4) NOT NULL DEFAULT '0' COMMENT '[3.0]是否资料已完善：0-否，1-是',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  UNIQUE KEY `uk_MID` (`MemberID`),
  KEY `idx_MN8` (`MemberName`(8)),
  KEY `idx_M11` (`Mobile`(11)),
  KEY `idx_ICD18` (`IDCard`(18))
) ENGINE=InnoDB AUTO_INCREMENT=52694 DEFAULT CHARSET=utf8 COMMENT='[1.1]会员表';

/*Table structure for table `tb_messagecenter` */

DROP TABLE IF EXISTS `tb_messagecenter`;

CREATE TABLE `tb_messagecenter` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `MsgType` tinyint(4) NOT NULL COMMENT '消息类型：1-温馨提示，2-我的咨询(医患沟通)，7-关注亲友，8-健康资讯，9-广告，14-关注的亲友动态；<[3.0]废弃：3/4-单项/汇总报告，5/6-单份/组合答卷审核，10-测量数据，19/20-单份/组合问卷发放>',
  `SendType` tinyint(4) NOT NULL COMMENT '发送类型：1-医生，2-会员',
  `Sender` char(36) NOT NULL COMMENT '发送者guid',
  `ReceiveType` tinyint(4) NOT NULL COMMENT '接收类型：1-医生，2-会员，3-tag',
  `Receiver` varchar(50) DEFAULT NULL COMMENT '接收者guid或tag内容',
  `LastSourceID` bigint(20) NOT NULL COMMENT '最新的消息来源ID',
  `LastContent` varchar(70) NOT NULL COMMENT '最新的消息内容摘要',
  `LastContentNotice` varchar(70) NOT NULL COMMENT '[3.0]最新的消息内容通知栏',
  `Number` int(11) NOT NULL COMMENT '累计数量 (如未读则+1，如已读则填0)',
  `SendStatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '发送状态：1-未发送，2-发送成功，3-发送失败',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_SS` (`SendStatus`),
  KEY `idx_R` (`Receiver`),
  KEY `idx_S_R` (`Sender`,`Receiver`)
) ENGINE=InnoDB AUTO_INCREMENT=26294 DEFAULT CHARSET=utf8 COMMENT='[1.1]消息中心表';

/*Table structure for table `tb_messageschedule` */

DROP TABLE IF EXISTS `tb_messageschedule`;

CREATE TABLE `tb_messageschedule` (
  `LogID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `MsgType` tinyint(4) NOT NULL COMMENT '消息类型：1-温馨提示，2-我的咨询(医患沟通)，7-关注亲友，8-健康资讯，9-广告，14-关注的亲友动态；<[3.0]废弃：3/4-单项/汇总报告，5/6-单份/组合答卷审核，10-测量数据，19/20-单份/组合问卷发放>',
  `SendType` tinyint(4) NOT NULL COMMENT '发送类型：1-医生，2-会员',
  `Sender` char(36) NOT NULL COMMENT '发送者guid',
  `ReceiveType` tinyint(4) NOT NULL COMMENT '接收类型：1-医生，2-会员，3-tag',
  `Receiver` varchar(50) DEFAULT NULL COMMENT '接收者guid或tag内容',
  `LastSourceID` bigint(20) NOT NULL COMMENT '最新的消息来源ID',
  `LastContent` varchar(70) NOT NULL COMMENT '最新的消息内容摘要',
  `LastContentNotice` varchar(70) NOT NULL COMMENT '最新的消息内容通知栏',
  `ScheduleTime` datetime NOT NULL COMMENT '计划发送时间',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`LogID`),
  KEY `idx_ST` (`ScheduleTime`)
) ENGINE=InnoDB AUTO_INCREMENT=25959 DEFAULT CHARSET=utf8 COMMENT='[3.0]消息计划表';

/*Table structure for table `tb_sms_cfg` */

DROP TABLE IF EXISTS `tb_sms_cfg`;

CREATE TABLE `tb_sms_cfg` (
  `SCfgID` int(11) NOT NULL AUTO_INCREMENT COMMENT '短信配置ID',
  `ServerID` int(11) NOT NULL COMMENT '服务器ID(引用app_server.id)',
  `OrgID` int(11) NOT NULL COMMENT '组织ID',
  `Account` varchar(20) NOT NULL COMMENT '账号',
  `Passwd` varchar(50) NOT NULL COMMENT '密码',
  `Signature` varchar(20) DEFAULT NULL COMMENT '签名',
  `TotalSendLimit` int(11) DEFAULT NULL COMMENT '总条数限制',
  `DailyMaxSend` int(11) DEFAULT NULL COMMENT '每日最大发送条数',
  `MemberDailyMaxRecv` smallint(6) DEFAULT NULL COMMENT '同一个会员每日可接受条数',
  `MemberDailyMaxRepl` tinyint(4) DEFAULT NULL COMMENT '同一个会员每日允许重复内容条数',
  `SendStartTime` time NOT NULL DEFAULT '08:00:00' COMMENT '短信发送开始时间',
  `SendEndTime` time NOT NULL DEFAULT '20:00:00' COMMENT '短信发送结束时间',
  `CaptchaTempletNo` varchar(20) NOT NULL COMMENT '验证码模板编号',
  `InviteSMSTempletNo` varchar(20) DEFAULT NULL COMMENT '邀请短信模板编号',
  `TestSMSTempletNo` varchar(20) DEFAULT NULL COMMENT '测试短信模板编号',
  `CreateID` int(11) NOT NULL COMMENT '创建医生ID',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新医生ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`SCfgID`),
  KEY `idx_SID_OID` (`ServerID`,`OrgID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='[3.0]短信配置';

/*Table structure for table `tb_sms_send` */

DROP TABLE IF EXISTS `tb_sms_send`;

CREATE TABLE `tb_sms_send` (
  `SSendID` int(11) NOT NULL AUTO_INCREMENT COMMENT '短信发送ID',
  `ServerID` int(11) NOT NULL COMMENT '服务器ID(引用app_server.id)',
  `OrgID` int(11) NOT NULL COMMENT '组织ID',
  `OrgName` varchar(50) NOT NULL COMMENT '组织名称',
  `Account` varchar(20) NOT NULL COMMENT '账号',
  `SmsType` tinyint(4) NOT NULL COMMENT '短信类型：1-会员注册，2-忘记密码，3-邀请短信，4-修改手机号码，5-测试短信',
  `Priority` tinyint(4) NOT NULL COMMENT '优先级：1-紧急，2-较高，3-普通，4-较低，5-最低',
  `ContentType` tinyint(4) NOT NULL COMMENT '发送内容类别：1-文本，2-语音',
  `Content` varchar(300) DEFAULT NULL COMMENT '发送内容',
  `CreateID` int(11) NOT NULL COMMENT '创建者ID，0-系统',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新者ID，0-系统',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`SSendID`),
  KEY `idx_SID_OID` (`ServerID`,`OrgID`)
) ENGINE=InnoDB AUTO_INCREMENT=469 DEFAULT CHARSET=utf8 COMMENT='[3.0]短信发送';

/*Table structure for table `tb_sms_send_detail` */

DROP TABLE IF EXISTS `tb_sms_send_detail`;

CREATE TABLE `tb_sms_send_detail` (
  `SSDetailID` int(11) NOT NULL AUTO_INCREMENT COMMENT '短信发送明细ID',
  `SSendID` int(11) NOT NULL COMMENT '短信发送ID',
  `MemberID` char(36) DEFAULT NULL COMMENT '会员GUID',
  `RecvNumber` varchar(20) NOT NULL COMMENT '接收号码',
  `SendTime` datetime DEFAULT NULL COMMENT '发送时间',
  `SendStatus` tinyint(4) NOT NULL COMMENT '发送状态：1-待发送，2-已发送(至网关)，3-发送成功，4-发送失败',
  `RecvTime` datetime DEFAULT NULL COMMENT '接收时间',
  `FailReason` varchar(100) DEFAULT NULL COMMENT '发送失败原因',
  `FailCount` int(11) DEFAULT NULL COMMENT '失败次数',
  `CreateID` int(11) NOT NULL COMMENT '创建者ID，0-系统',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `UpdateID` int(11) DEFAULT NULL COMMENT '更新者ID，0-系统',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`SSDetailID`),
  KEY `idx_SSID_ST` (`SSendID`,`SendTime`),
  KEY `idx_SSID_RN11` (`SSendID`,`RecvNumber`(11))
) ENGINE=InnoDB AUTO_INCREMENT=514 DEFAULT CHARSET=utf8 COMMENT='[3.0]短信发送明细';

/*Table structure for table `update_record` */

DROP TABLE IF EXISTS `update_record`;

CREATE TABLE `update_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_code` int(11) DEFAULT NULL COMMENT '版本编号',
  `version` varchar(50) DEFAULT NULL COMMENT '版本名',
  `code` varchar(50) NOT NULL COMMENT '项目编号',
  `url` varchar(200) DEFAULT NULL COMMENT 'app存放地址',
  `filename` varchar(200) DEFAULT NULL COMMENT '文件名',
  `fileSize` int(11) DEFAULT NULL COMMENT '文件大小',
  `forced` int(11) DEFAULT '0' COMMENT '是否强制升级',
  `describe` varchar(200) DEFAULT NULL COMMENT '升级说明',
  `last_update` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `userName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `passWord` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/* Procedure structure for procedure `proc_smssend_getStatisticByOrgID` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_smssend_getStatisticByOrgID` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `proc_smssend_getStatisticByOrgID`(
  IN iServerID INT,
  IN vOrgID_list VARCHAR(255),
  
  IN dSSendTime VARCHAR(20),
  IN dESendTime VARCHAR(20),
  IN iSmsType TINYINT,
  IN vRecvNumber VARCHAR(20)
)
    COMMENT '[3.0]短信发送记录->统计'
label:BEGIN
  SET @SQL = 'SELECT a.OrgID, a.OrgName, a.ContentType, SUM(SendStatus = 3 OR SendStatus = 4) AS Total, SUM(SendStatus = 3) AS Success, SUM(SendStatus = 4) AS Fail';
  SET @SQL = CONCAT(@SQL, ' FROM tb_sms_send a, tb_sms_send_detail b');
  SET @SQL = CONCAT(@SQL, ' WHERE a.SSendID = b.SSendID AND a.ServerID = ', iServerID);
  SET @SQL = CONCAT(@SQL, ' AND b.SendStatus IN (3,4)');
  
  IF vOrgID_list IS NOT NULL AND vOrgID_list != '' THEN SET @SQL = CONCAT(@SQL, ' AND a.OrgID IN (', vOrgID_list, ')'); END IF;
  IF iSmsType != -1 THEN SET @SQL = CONCAT(@SQL, ' AND a.SmsType = ', iSmsType); END IF;
  
  IF dSSendTime IS NOT NULL AND dSSendTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.SendTime >= ''', dSSendTime, ''''); END IF;
  IF dESendTime IS NOT NULL AND dESendTime != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.SendTime <= ''', dESendTime, ''''); END IF;
  
  IF vRecvNumber IS NOT NULL AND vRecvNumber != '' THEN SET @SQL = CONCAT(@SQL, ' AND b.RecvNumber LIKE ''', vRecvNumber, '%'''); END IF;
  
  SET @SQL = CONCAT(@SQL, ' GROUP BY a.OrgID, a.ContentType');
  
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END label */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
