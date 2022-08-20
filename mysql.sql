-- MySQL dump 10.18  Distrib 10.3.27-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ry
-- ------------------------------------------------------
-- Server version	10.3.27-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`article_id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_chapter`
--

DROP TABLE IF EXISTS `article_chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_chapter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chapter_id` int(11) NOT NULL,
  `no` varchar(12) NOT NULL,
  `content` longtext NOT NULL,
  `permission` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_chapter`
--

LOCK TABLES `article_chapter` WRITE;
/*!40000 ALTER TABLE `article_chapter` DISABLE KEYS */;
/*!40000 ALTER TABLE `article_chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_menu`
--

DROP TABLE IF EXISTS `article_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` text NOT NULL,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_menu`
--

LOCK TABLES `article_menu` WRITE;
/*!40000 ALTER TABLE `article_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `article_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob DEFAULT NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob DEFAULT NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob DEFAULT NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2022-08-04 07:43:03','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2022-08-04 07:43:03','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2022-08-04 07:43:03','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2022-08-04 07:43:03','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2022-08-04 07:43:03','',NULL,'是否开启注册用户功能（true开启，false关闭）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','若依科技',0,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:49','',NULL),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:49','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:50','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:50','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:50','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:50','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:50','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:50','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:50','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2022-08-04 07:42:50','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2022-08-04 07:43:01','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2022-08-04 07:43:01','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2022-08-04 07:43:01','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2022-08-04 07:43:01','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2022-08-04 07:43:01','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2022-08-04 07:43:01','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2022-08-04 07:43:01','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2022-08-04 07:43:01','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2022-08-04 07:43:01','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2022-08-04 07:43:02','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2022-08-04 07:43:02','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2022-08-04 07:43:02','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2022-08-04 07:43:02','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2022-08-04 07:43:02','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2022-08-04 07:43:02','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2022-08-04 07:43:02','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2022-08-04 07:43:02','',NULL,'关闭状态'),(18,1,'新增','1','sys_oper_type','','info','N','0','admin','2022-08-04 07:43:02','',NULL,'新增操作'),(19,2,'修改','2','sys_oper_type','','info','N','0','admin','2022-08-04 07:43:02','',NULL,'修改操作'),(20,3,'删除','3','sys_oper_type','','danger','N','0','admin','2022-08-04 07:43:02','',NULL,'删除操作'),(21,4,'授权','4','sys_oper_type','','primary','N','0','admin','2022-08-04 07:43:02','',NULL,'授权操作'),(22,5,'导出','5','sys_oper_type','','warning','N','0','admin','2022-08-04 07:43:02','',NULL,'导出操作'),(23,6,'导入','6','sys_oper_type','','warning','N','0','admin','2022-08-04 07:43:02','',NULL,'导入操作'),(24,7,'强退','7','sys_oper_type','','danger','N','0','admin','2022-08-04 07:43:02','',NULL,'强退操作'),(25,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2022-08-04 07:43:02','',NULL,'生成操作'),(26,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2022-08-04 07:43:02','',NULL,'清空操作'),(27,1,'成功','0','sys_common_status','','primary','N','0','admin','2022-08-04 07:43:02','',NULL,'正常状态'),(28,2,'失败','1','sys_common_status','','danger','N','0','admin','2022-08-04 07:43:02','',NULL,'停用状态');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2022-08-04 07:43:00','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2022-08-04 07:43:00','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2022-08-04 07:43:00','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2022-08-04 07:43:00','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2022-08-04 07:43:01','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2022-08-04 07:43:01','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2022-08-04 07:43:01','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2022-08-04 07:43:01','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2022-08-04 07:43:01','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2022-08-04 07:43:01','',NULL,'登录状态列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2022-08-04 07:43:04','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2022-08-04 07:43:04','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2022-08-04 07:43:04','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码错误','2022-08-04 08:52:34'),(101,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-04 08:52:41'),(102,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-04 09:56:16'),(103,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-04 15:37:50'),(104,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-04 17:59:08'),(105,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-04 17:59:20'),(106,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-04 19:49:30'),(107,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-04 19:49:56'),(108,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-04 20:50:21'),(109,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-04 20:51:06'),(110,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-04 20:52:03'),(111,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-04 21:59:50'),(112,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码错误','2022-08-05 08:54:45'),(113,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 08:54:50'),(114,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 09:44:38'),(115,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 11:07:27'),(116,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 12:14:49'),(117,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 12:46:16'),(118,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-05 15:37:19'),(119,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 15:37:34'),(120,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-05 15:37:53'),(121,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码错误','2022-08-05 15:38:06'),(122,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 15:38:09'),(123,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-05 15:44:18'),(124,'123456','127.0.0.1','内网IP','Firefox 7','Linux','1','密码输入错误1次','2022-08-05 15:44:35'),(125,'123456','127.0.0.1','内网IP','Firefox 7','Linux','1','用户不存在/密码错误','2022-08-05 15:44:35'),(126,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 15:44:43'),(127,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-05 15:47:16'),(128,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 15:47:32'),(129,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-05 15:48:21'),(130,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码错误','2022-08-05 15:48:37'),(131,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 15:48:42'),(132,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-05 15:50:16'),(133,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 15:50:31'),(134,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-05 15:52:50'),(135,'ry','127.0.0.1','内网IP','Firefox 7','Linux','1','密码输入错误1次','2022-08-05 15:53:07'),(136,'ry','127.0.0.1','内网IP','Firefox 7','Linux','1','用户不存在/密码错误','2022-08-05 15:53:07'),(137,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 15:53:27'),(138,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-05 15:58:47'),(139,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 15:59:02'),(140,'123456','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-05 16:04:26'),(141,'123456','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-05 16:05:11'),(142,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 16:05:20'),(143,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-05 18:15:20'),(144,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 18:15:25'),(145,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','登录成功','2022-08-05 18:19:31'),(146,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','退出成功','2022-08-05 18:55:34'),(147,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','登录成功','2022-08-05 18:55:43'),(148,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','退出成功','2022-08-05 18:56:27'),(149,'123456','127.0.0.1','内网IP','Chrome 9','Linux','1','验证码错误','2022-08-05 18:56:43'),(150,'123456','127.0.0.1','内网IP','Chrome 9','Linux','0','登录成功','2022-08-05 18:56:48'),(151,'123456','127.0.0.1','内网IP','Chrome 9','Linux','0','退出成功','2022-08-05 19:36:24'),(152,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','登录成功','2022-08-05 19:36:35'),(153,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','退出成功','2022-08-05 19:37:14'),(154,'123456','127.0.0.1','内网IP','Chrome 9','Linux','0','登录成功','2022-08-05 19:37:27'),(155,'123456','127.0.0.1','内网IP','Chrome 9','Linux','0','退出成功','2022-08-05 19:38:37'),(156,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','登录成功','2022-08-05 19:38:45'),(157,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','退出成功','2022-08-05 19:44:06'),(158,'visitor','127.0.0.1','内网IP','Chrome 9','Linux','0','登录成功','2022-08-05 19:44:29'),(159,'visitor','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-05 20:02:45'),(160,'visitor','127.0.0.1','内网IP','Chrome 9','Linux','0','退出成功','2022-08-05 20:19:24'),(161,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','登录成功','2022-08-05 20:19:38'),(162,'admin','127.0.0.1','内网IP','Chrome 9','Linux','0','退出成功','2022-08-05 20:26:13'),(163,'visitor','127.0.0.1','内网IP','Chrome 9','Linux','0','登录成功','2022-08-05 20:26:26'),(164,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-10 08:49:31'),(165,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-10 08:49:36'),(166,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-10 09:55:16'),(167,'visitor','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-10 09:55:31'),(168,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-11 10:37:59'),(169,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-11 10:38:01'),(170,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-11 10:38:24'),(171,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-12 08:50:44'),(172,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-12 09:32:59'),(173,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-12 13:54:58'),(174,'visitor','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-12 13:55:14'),(175,'visitor','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-12 15:55:15'),(176,'visitor','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-12 18:19:15'),(177,'visitor','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-12 18:44:26'),(178,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-12 18:44:37'),(179,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','退出成功','2022-08-12 21:36:35'),(180,'visitor','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-12 21:36:44'),(181,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-13 08:15:34'),(182,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-13 08:15:40'),(183,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-13 15:32:18'),(184,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-13 15:32:24'),(185,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-13 15:32:31'),(186,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-13 15:32:54'),(187,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-13 15:32:58'),(188,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-13 16:30:13'),(189,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-13 19:04:18'),(190,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-13 19:04:22'),(191,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-13 20:11:33'),(192,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码错误','2022-08-13 20:11:35'),(193,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-13 20:11:40'),(194,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-14 08:24:52'),(195,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码已失效','2022-08-14 08:25:16'),(196,'admin','127.0.0.1','内网IP','Firefox 7','Linux','1','验证码错误','2022-08-14 08:25:18'),(197,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-14 08:25:21'),(198,'admin','127.0.0.1','内网IP','Firefox 7','Linux','0','登录成功','2022-08-14 10:34:57');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2003 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,2,'system',NULL,'',1,0,'M','0','0','','system','admin','2022-08-04 07:42:51','admin','2022-08-13 10:10:03','系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'',1,0,'M','0','0','','monitor','admin','2022-08-04 07:42:51','',NULL,'系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'',1,0,'M','0','0','','tool','admin','2022-08-04 07:42:51','',NULL,'系统工具目录'),(4,'若依官网',0,4,'http://ruoyi.vip',NULL,'',0,0,'M','0','0','','guide','admin','2022-08-04 07:42:51','',NULL,'若依官网地址'),(100,'用户管理',1,1,'user','system/user/index','',1,0,'C','0','0','system:user:list','user','admin','2022-08-04 07:42:52','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','',1,0,'C','0','0','system:role:list','peoples','admin','2022-08-04 07:42:52','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','',1,0,'C','0','0','system:menu:list','tree-table','admin','2022-08-04 07:42:52','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','',1,0,'C','0','0','system:dept:list','tree','admin','2022-08-04 07:42:52','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','',1,0,'C','0','0','system:post:list','post','admin','2022-08-04 07:42:52','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','',1,0,'C','0','0','system:dict:list','dict','admin','2022-08-04 07:42:52','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','',1,0,'C','0','0','system:config:list','edit','admin','2022-08-04 07:42:52','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','',1,0,'C','0','0','system:notice:list','message','admin','2022-08-04 07:42:52','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','',1,0,'M','0','0','','log','admin','2022-08-04 07:42:52','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','',1,0,'C','0','0','monitor:online:list','online','admin','2022-08-04 07:42:52','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','',1,0,'C','0','0','monitor:job:list','job','admin','2022-08-04 07:42:52','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','',1,0,'C','0','0','monitor:druid:list','druid','admin','2022-08-04 07:42:52','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','',1,0,'C','0','0','monitor:server:list','server','admin','2022-08-04 07:42:52','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','',1,0,'C','0','0','monitor:cache:list','redis','admin','2022-08-04 07:42:52','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2022-08-04 07:42:52','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','',1,0,'C','0','0','tool:build:list','build','admin','2022-08-04 07:42:52','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','',1,0,'C','0','0','tool:gen:list','code','admin','2022-08-04 07:42:52','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2022-08-04 07:42:52','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','',1,0,'C','0','0','monitor:operlog:list','form','admin','2022-08-04 07:42:52','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2022-08-04 07:42:52','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','',1,0,'F','0','0','system:user:query','#','admin','2022-08-04 07:42:52','',NULL,''),(1001,'用户新增',100,2,'','','',1,0,'F','0','0','system:user:add','#','admin','2022-08-04 07:42:52','',NULL,''),(1002,'用户修改',100,3,'','','',1,0,'F','0','0','system:user:edit','#','admin','2022-08-04 07:42:52','',NULL,''),(1003,'用户删除',100,4,'','','',1,0,'F','0','0','system:user:remove','#','admin','2022-08-04 07:42:52','',NULL,''),(1004,'用户导出',100,5,'','','',1,0,'F','0','0','system:user:export','#','admin','2022-08-04 07:42:53','',NULL,''),(1005,'用户导入',100,6,'','','',1,0,'F','0','0','system:user:import','#','admin','2022-08-04 07:42:53','',NULL,''),(1006,'重置密码',100,7,'','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2022-08-04 07:42:53','',NULL,''),(1007,'角色查询',101,1,'','','',1,0,'F','0','0','system:role:query','#','admin','2022-08-04 07:42:53','',NULL,''),(1008,'角色新增',101,2,'','','',1,0,'F','0','0','system:role:add','#','admin','2022-08-04 07:42:53','',NULL,''),(1009,'角色修改',101,3,'','','',1,0,'F','0','0','system:role:edit','#','admin','2022-08-04 07:42:53','',NULL,''),(1010,'角色删除',101,4,'','','',1,0,'F','0','0','system:role:remove','#','admin','2022-08-04 07:42:53','',NULL,''),(1011,'角色导出',101,5,'','','',1,0,'F','0','0','system:role:export','#','admin','2022-08-04 07:42:53','',NULL,''),(1012,'菜单查询',102,1,'','','',1,0,'F','0','0','system:menu:query','#','admin','2022-08-04 07:42:53','',NULL,''),(1013,'菜单新增',102,2,'','','',1,0,'F','0','0','system:menu:add','#','admin','2022-08-04 07:42:53','',NULL,''),(1014,'菜单修改',102,3,'','','',1,0,'F','0','0','system:menu:edit','#','admin','2022-08-04 07:42:53','',NULL,''),(1015,'菜单删除',102,4,'','','',1,0,'F','0','0','system:menu:remove','#','admin','2022-08-04 07:42:53','',NULL,''),(1016,'部门查询',103,1,'','','',1,0,'F','0','0','system:dept:query','#','admin','2022-08-04 07:42:53','',NULL,''),(1017,'部门新增',103,2,'','','',1,0,'F','0','0','system:dept:add','#','admin','2022-08-04 07:42:53','',NULL,''),(1018,'部门修改',103,3,'','','',1,0,'F','0','0','system:dept:edit','#','admin','2022-08-04 07:42:53','',NULL,''),(1019,'部门删除',103,4,'','','',1,0,'F','0','0','system:dept:remove','#','admin','2022-08-04 07:42:53','',NULL,''),(1020,'岗位查询',104,1,'','','',1,0,'F','0','0','system:post:query','#','admin','2022-08-04 07:42:53','',NULL,''),(1021,'岗位新增',104,2,'','','',1,0,'F','0','0','system:post:add','#','admin','2022-08-04 07:42:53','',NULL,''),(1022,'岗位修改',104,3,'','','',1,0,'F','0','0','system:post:edit','#','admin','2022-08-04 07:42:53','',NULL,''),(1023,'岗位删除',104,4,'','','',1,0,'F','0','0','system:post:remove','#','admin','2022-08-04 07:42:53','',NULL,''),(1024,'岗位导出',104,5,'','','',1,0,'F','0','0','system:post:export','#','admin','2022-08-04 07:42:53','',NULL,''),(1025,'字典查询',105,1,'#','','',1,0,'F','0','0','system:dict:query','#','admin','2022-08-04 07:42:53','',NULL,''),(1026,'字典新增',105,2,'#','','',1,0,'F','0','0','system:dict:add','#','admin','2022-08-04 07:42:53','',NULL,''),(1027,'字典修改',105,3,'#','','',1,0,'F','0','0','system:dict:edit','#','admin','2022-08-04 07:42:53','',NULL,''),(1028,'字典删除',105,4,'#','','',1,0,'F','0','0','system:dict:remove','#','admin','2022-08-04 07:42:53','',NULL,''),(1029,'字典导出',105,5,'#','','',1,0,'F','0','0','system:dict:export','#','admin','2022-08-04 07:42:53','',NULL,''),(1030,'参数查询',106,1,'#','','',1,0,'F','0','0','system:config:query','#','admin','2022-08-04 07:42:54','',NULL,''),(1031,'参数新增',106,2,'#','','',1,0,'F','0','0','system:config:add','#','admin','2022-08-04 07:42:54','',NULL,''),(1032,'参数修改',106,3,'#','','',1,0,'F','0','0','system:config:edit','#','admin','2022-08-04 07:42:54','',NULL,''),(1033,'参数删除',106,4,'#','','',1,0,'F','0','0','system:config:remove','#','admin','2022-08-04 07:42:54','',NULL,''),(1034,'参数导出',106,5,'#','','',1,0,'F','0','0','system:config:export','#','admin','2022-08-04 07:42:54','',NULL,''),(1035,'公告查询',107,1,'#','','',1,0,'F','0','0','system:notice:query','#','admin','2022-08-04 07:42:54','',NULL,''),(1036,'公告新增',107,2,'#','','',1,0,'F','0','0','system:notice:add','#','admin','2022-08-04 07:42:54','',NULL,''),(1037,'公告修改',107,3,'#','','',1,0,'F','0','0','system:notice:edit','#','admin','2022-08-04 07:42:54','',NULL,''),(1038,'公告删除',107,4,'#','','',1,0,'F','0','0','system:notice:remove','#','admin','2022-08-04 07:42:54','',NULL,''),(1039,'操作查询',500,1,'#','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2022-08-04 07:42:54','',NULL,''),(1040,'操作删除',500,2,'#','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2022-08-04 07:42:54','',NULL,''),(1041,'日志导出',500,4,'#','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2022-08-04 07:42:54','',NULL,''),(1042,'登录查询',501,1,'#','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2022-08-04 07:42:54','',NULL,''),(1043,'登录删除',501,2,'#','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2022-08-04 07:42:54','',NULL,''),(1044,'日志导出',501,3,'#','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2022-08-04 07:42:54','',NULL,''),(1045,'在线查询',109,1,'#','','',1,0,'F','0','0','monitor:online:query','#','admin','2022-08-04 07:42:54','',NULL,''),(1046,'批量强退',109,2,'#','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2022-08-04 07:42:54','',NULL,''),(1047,'单条强退',109,3,'#','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2022-08-04 07:42:54','',NULL,''),(1048,'任务查询',110,1,'#','','',1,0,'F','0','0','monitor:job:query','#','admin','2022-08-04 07:42:54','',NULL,''),(1049,'任务新增',110,2,'#','','',1,0,'F','0','0','monitor:job:add','#','admin','2022-08-04 07:42:54','',NULL,''),(1050,'任务修改',110,3,'#','','',1,0,'F','0','0','monitor:job:edit','#','admin','2022-08-04 07:42:54','',NULL,''),(1051,'任务删除',110,4,'#','','',1,0,'F','0','0','monitor:job:remove','#','admin','2022-08-04 07:42:54','',NULL,''),(1052,'状态修改',110,5,'#','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2022-08-04 07:42:54','',NULL,''),(1053,'任务导出',110,7,'#','','',1,0,'F','0','0','monitor:job:export','#','admin','2022-08-04 07:42:54','',NULL,''),(1054,'生成查询',115,1,'#','','',1,0,'F','0','0','tool:gen:query','#','admin','2022-08-04 07:42:55','',NULL,''),(1055,'生成修改',115,2,'#','','',1,0,'F','0','0','tool:gen:edit','#','admin','2022-08-04 07:42:55','',NULL,''),(1056,'生成删除',115,3,'#','','',1,0,'F','0','0','tool:gen:remove','#','admin','2022-08-04 07:42:55','',NULL,''),(1057,'导入代码',115,2,'#','','',1,0,'F','0','0','tool:gen:import','#','admin','2022-08-04 07:42:55','',NULL,''),(1058,'预览代码',115,4,'#','','',1,0,'F','0','0','tool:gen:preview','#','admin','2022-08-04 07:42:55','',NULL,''),(1059,'生成代码',115,5,'#','','',1,0,'F','0','0','tool:gen:code','#','admin','2022-08-04 07:42:55','',NULL,''),(2000,'文章展示',0,1,'article','/article',NULL,1,1,'C','0','0','system:md:list','education','admin','2022-08-04 10:04:05','admin','2022-08-13 10:08:30',''),(2001,'文章管理',2002,1,'article-manager','system/md/articleManager',NULL,1,1,'C','0','0','','education','admin','2022-08-13 08:58:31','admin','2022-08-13 09:01:46',''),(2002,'文章管理',0,1,'article',NULL,NULL,1,0,'M','0','0',NULL,'education','admin','2022-08-13 08:59:36','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob DEFAULT NULL COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2','新版本内容','0','admin','2022-08-04 07:43:05','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1','维护内容','0','admin','2022-08-04 07:43:05','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"md/aritcle/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-04 10:04:05'),(101,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"md/article/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-04 10:25:35'),(102,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-04 10:27:29'),(103,'用户管理',2,'com.ruoyi.web.controller.system.SysUserController.edit()','PUT',1,'admin',NULL,'/system/user','127.0.0.1','内网IP','{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-08-04 07:42:50\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"ry@163.com\",\"loginDate\":\"2022-08-04 09:56:15\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{},\"password\":\"\",\"phonenumber\":\"15888888888\",\"postIds\":[1],\"remark\":\"管理员\",\"roleIds\":[1],\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}',NULL,1,'不允许操作超级管理员用户','2022-08-04 11:10:46'),(104,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2022-08-04 07:42:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,2,109,1045,1046,1047,110,1048,1049,1050,1051,1052,1053,111,112,113,114,3,115,1054,1055,1057,1056,1058,1059,116,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 15:15:10'),(105,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":true,\"createTime\":\"2022-08-04 07:42:51\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"超级管理员\",\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"3\",\"status\":\"0\"}',NULL,1,'不允许操作超级管理员角色','2022-08-05 15:21:41'),(106,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":true,\"createTime\":\"2022-08-04 07:42:51\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"超级管理员\",\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"2\",\"status\":\"0\"}',NULL,1,'不允许操作超级管理员角色','2022-08-05 15:32:02'),(107,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2022-08-04 07:42:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,2,109,1045,1046,1047,110,1048,1049,1050,1051,1052,1053,111,112,113,114,3,115,1054,1055,1057,1056,1058,1059,116,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"2\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 15:32:26'),(108,'用户管理',1,'com.ruoyi.web.controller.system.SysUserController.add()','POST',1,'admin',NULL,'/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"123456\",\"params\":{},\"password\":\"$2a$10$mlc9/usbaYN2wjm6JlSyiuCNcwU72yDQ/sl2LuuLgSs7nzdeN52gq\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":100,\"userName\":\"123456\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 15:37:14'),(109,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 15:49:55'),(110,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 15:54:32'),(111,'用户管理',2,'com.ruoyi.web.controller.system.SysUserController.edit()','PUT',1,'admin',NULL,'/system/user','127.0.0.1','内网IP','{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-08-05 15:37:13\",\"delFlag\":\"0\",\"deptId\":103,\"email\":\"\",\"loginDate\":\"2022-08-05 15:50:31\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"123456\",\"params\":{},\"password\":\"\",\"phonenumber\":\"\",\"postIds\":[2],\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"2\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"123456\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 15:56:54'),(112,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2022-08-04 07:42:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,2,109,1045,1046,1047,110,1048,1049,1050,1051,1052,1053,111,112,113,114,3,115,1054,1055,1057,1056,1058,1059,116,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"4\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 18:56:04'),(113,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2022-08-04 07:42:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,2,109,1045,1046,1047,110,1048,1049,1050,1051,1052,1053,111,112,113,114,3,115,1054,1055,1057,1056,1058,1059,116,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"2\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:37:03'),(114,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2022-08-04 07:42:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,2,109,1045,1046,1047,110,1048,1049,1050,1051,1052,1053,111,112,113,114,3,115,1054,1055,1057,1056,1058,1059,116,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"4\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:39:02'),(115,'角色管理',1,'com.ruoyi.web.controller.system.SysRoleController.add()','POST',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,2000,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,2,109,1045,1046,1047,110,1048,1049,1050,1051,1052,1053,111,112,113,114,3,115,1054,1055,1057,1056,1058,1059,116,117,4],\"params\":{},\"roleId\":100,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"roleSort\":\"4\",\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:39:41'),(116,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2022-08-04 07:42:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,2,109,1045,1046,1047,110,1048,1049,1050,1051,1052,1053,111,112,113,114,3,115,1054,1055,1057,1056,1058,1059,116,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"3\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:39:53'),(117,'角色管理',1,'com.ruoyi.web.controller.system.SysRoleController.add()','POST',1,'admin',NULL,'/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"roleId\":101,\"roleKey\":\"vip\",\"roleName\":\"vip\",\"roleSort\":\"2\",\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:40:26'),(118,'用户管理',2,'com.ruoyi.web.controller.system.SysUserController.edit()','PUT',1,'admin',NULL,'/system/user','127.0.0.1','内网IP','{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-08-05 15:37:13\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"loginDate\":\"2022-08-05 19:37:27\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"visitor\",\"params\":{},\"password\":\"\",\"phonenumber\":\"\",\"postIds\":[2],\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"3\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"123456\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:41:32'),(119,'用户管理',3,'com.ruoyi.web.controller.system.SysUserController.remove()','DELETE',1,'admin',NULL,'/system/user/100','127.0.0.1','内网IP','{userIds=100}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:42:00'),(120,'用户管理',1,'com.ruoyi.web.controller.system.SysUserController.add()','POST',1,'admin',NULL,'/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"游客\",\"params\":{},\"password\":\"$2a$10$JBcrLjUS2P5ZyF5no1lqKeJ9vJEVbbuBiTi25QFY/t1Z/WfgObfLy\",\"postIds\":[],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":101,\"userName\":\"visitor\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:42:25'),(121,'用户管理',1,'com.ruoyi.web.controller.system.SysUserController.add()','POST',1,'admin',NULL,'/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"vip\",\"params\":{},\"password\":\"$2a$10$J8yoCwnpjpTWUg0SuhR4U.G6If4Rsq8OegPBcO4ZwqlhlE00HkBUy\",\"postIds\":[],\"roleIds\":[101],\"sex\":\"1\",\"status\":\"0\",\"userId\":102,\"userName\":\"vip\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:42:47'),(122,'用户管理',1,'com.ruoyi.web.controller.system.SysUserController.add()','POST',1,'admin',NULL,'/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"login\",\"params\":{},\"password\":\"$2a$10$uj8sucGCKgyJwHFdRLfH4eCmfdixGiinupCA89cP8AuaJjUdpx6VW\",\"postIds\":[],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":103,\"userName\":\"login\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-05 19:43:28'),(123,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章展示\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 08:56:38'),(124,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"education\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章展示\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 08:56:54'),(125,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/articleManager\",\"createBy\":\"admin\",\"icon\":\"education\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article-manager\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 08:58:31'),(126,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"文章管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"article\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 08:59:37'),(127,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"education\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章展示\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 09:01:29'),(128,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/articleManager\",\"createTime\":\"2022-08-13 08:58:31\",\"icon\":\"education\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"path\":\"article-manager\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 09:01:46'),(129,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"education\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章展示\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 09:57:50'),(130,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章展示\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 10:03:48'),(131,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"education\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章展示\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 10:05:21'),(132,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"md/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"education\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章展示\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 10:07:16'),(133,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"/article\",\"createTime\":\"2022-08-04 10:04:05\",\"icon\":\"education\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"文章展示\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"article\",\"perms\":\"system:md:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 10:08:30'),(134,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2022-08-04 07:42:51\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 10:10:03'),(135,'岗位管理',5,'com.ruoyi.web.controller.system.SysPostController.export()','POST',1,'admin',NULL,'/system/post/export','127.0.0.1','内网IP','{\"flag\":false,\"params\":{}}',NULL,0,NULL,'2022-08-13 10:20:36'),(136,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 11:06:55'),(137,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 11:08:22'),(138,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 11:09:01'),(139,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 11:10:26'),(140,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:13:46'),(141,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:15:12'),(142,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:16:13'),(143,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:18:47'),(144,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:30:16'),(145,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:35:24'),(146,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:39:20'),(147,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:39:53'),(148,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:42:34'),(149,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:43:29'),(150,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:48:12'),(151,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'Your InputStream was neither an OLE2 stream, nor an OOXML stream','2022-08-13 11:49:23'),(152,'用户管理',5,'com.ruoyi.web.controller.system.SysUserController.export()','POST',1,'admin',NULL,'/system/user/export','127.0.0.1','内网IP','{\"admin\":false,\"params\":{\"dataScope\":\"\"}}',NULL,0,NULL,'2022-08-13 11:50:03'),(153,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 12:13:18'),(154,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 12:23:01'),(155,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 12:25:10'),(156,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 12:27:15'),(157,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 12:34:16'),(158,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 12:48:31'),(159,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 12:49:38'),(160,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 12:56:18'),(161,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 12:59:31'),(162,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:01:39'),(163,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:03:38'),(164,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:12:50'),(165,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:32:17'),(166,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:35:38'),(167,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:37:43'),(168,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:40:48'),(169,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:43:51'),(170,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:44:22'),(171,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:45:06'),(172,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:47:24'),(173,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:48:22'),(174,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:54:39'),(175,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:55:43'),(176,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 13:56:52'),(177,'用户管理',5,'com.ruoyi.web.controller.system.SysUserController.export()','POST',1,'admin',NULL,'/system/user/export','127.0.0.1','内网IP','{\"admin\":false,\"params\":{\"dataScope\":\"\"}}',NULL,0,NULL,'2022-08-13 13:57:04'),(178,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 15:46:31'),(179,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 15:46:45'),(180,'用户管理',3,'com.ruoyi.web.controller.system.SysUserController.remove()','DELETE',1,'admin',NULL,'/system/user/2','127.0.0.1','内网IP','{userIds=2}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2022-08-13 16:54:21'),(181,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 17:26:28'),(182,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 17:27:34'),(183,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 17:40:19'),(184,'用户管理',5,'com.ruoyi.web.controller.system.SysUserController.export()','POST',1,'admin',NULL,'/system/user/export','127.0.0.1','内网IP','{\"admin\":false,\"params\":{\"dataScope\":\"\"}}',NULL,0,NULL,'2022-08-13 17:40:36'),(185,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 20:22:51'),(186,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 20:48:30'),(187,'用户管理',6,'com.ruoyi.web.controller.system.SysUserController.importData()','POST',1,'admin',NULL,'/system/user/importData','127.0.0.1','内网IP','false',NULL,1,'org.apache.poi.openxml4j.exceptions.InvalidFormatException: Package should contain a content type part [M1.13]','2022-08-13 21:32:05'),(188,'用户管理',5,'com.ruoyi.web.controller.system.SysUserController.export()','POST',1,'admin',NULL,'/system/user/export','127.0.0.1','内网IP','{\"admin\":false,\"params\":{\"dataScope\":\"\"}}',NULL,0,NULL,'2022-08-14 11:52:29');
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2022-08-04 07:42:51','',NULL,''),(2,'se','项目经理',2,'0','admin','2022-08-04 07:42:51','',NULL,''),(3,'hr','人力资源',3,'0','admin','2022-08-04 07:42:51','',NULL,''),(4,'user','普通员工',4,'0','admin','2022-08-04 07:42:51','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2022-08-04 07:42:51','',NULL,'超级管理员'),(2,'普通角色','common',3,'2',1,1,'0','0','admin','2022-08-04 07:42:51','admin','2022-08-05 19:39:53','普通角色'),(100,'游客','visitor',4,'1',1,1,'0','0','admin','2022-08-05 19:39:40','',NULL,NULL),(101,'vip','vip',2,'1',1,1,'0','0','admin','2022-08-05 19:40:26','',NULL,NULL);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,1),(2,2),(2,3),(2,4),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(100,1),(100,2),(100,3),(100,4),(100,100),(100,101),(100,102),(100,103),(100,104),(100,105),(100,106),(100,107),(100,108),(100,109),(100,110),(100,111),(100,112),(100,113),(100,114),(100,115),(100,116),(100,117),(100,500),(100,501),(100,1000),(100,1001),(100,1002),(100,1003),(100,1004),(100,1005),(100,1006),(100,1007),(100,1008),(100,1009),(100,1010),(100,1011),(100,1012),(100,1013),(100,1014),(100,1015),(100,1016),(100,1017),(100,1018),(100,1019),(100,1020),(100,1021),(100,1022),(100,1023),(100,1024),(100,1025),(100,1026),(100,1027),(100,1028),(100,1029),(100,1030),(100,1031),(100,1032),(100,1033),(100,1034),(100,1035),(100,1036),(100,1037),(100,1038),(100,1039),(100,1040),(100,1041),(100,1042),(100,1043),(100,1044),(100,1045),(100,1046),(100,1047),(100,1048),(100,1049),(100,1050),(100,1051),(100,1052),(100,1053),(100,1054),(100,1055),(100,1056),(100,1057),(100,1058),(100,1059),(100,2000);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','若依','00','ry@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2022-08-14 10:34:56','admin','2022-08-04 07:42:50','','2022-08-14 10:34:56','管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','2','127.0.0.1','2022-08-04 07:42:50','admin','2022-08-04 07:42:50','',NULL,'测试员'),(100,103,'123456','visitor','00','','','0','','$2a$10$mlc9/usbaYN2wjm6JlSyiuCNcwU72yDQ/sl2LuuLgSs7nzdeN52gq','0','2','127.0.0.1','2022-08-05 19:37:27','admin','2022-08-05 15:37:13','admin','2022-08-05 19:41:32',NULL),(101,NULL,'visitor','游客','00','','','0','','$2a$10$JBcrLjUS2P5ZyF5no1lqKeJ9vJEVbbuBiTi25QFY/t1Z/WfgObfLy','0','0','127.0.0.1','2022-08-12 21:36:44','admin','2022-08-05 19:42:25','','2022-08-12 21:36:44',NULL),(102,NULL,'vip','vip','00','','','1','','$2a$10$J8yoCwnpjpTWUg0SuhR4U.G6If4Rsq8OegPBcO4ZwqlhlE00HkBUy','0','0','',NULL,'admin','2022-08-05 19:42:47','',NULL,NULL),(103,NULL,'login','login','00','','','0','','$2a$10$uj8sucGCKgyJwHFdRLfH4eCmfdixGiinupCA89cP8AuaJjUdpx6VW','0','0','',NULL,'admin','2022-08-05 19:43:28','',NULL,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(101,100),(102,101),(103,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-20 17:47:42
