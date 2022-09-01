-- MariaDB dump 10.19  Distrib 10.6.5-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: medics
-- ------------------------------------------------------
-- Server version	10.6.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `__archive_columns_to_show`
--

DROP TABLE IF EXISTS `__archive_columns_to_show`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__archive_columns_to_show` (
  `columname` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`columname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__archive_columns_to_show`
--

LOCK TABLES `__archive_columns_to_show` WRITE;
/*!40000 ALTER TABLE `__archive_columns_to_show` DISABLE KEYS */;
INSERT INTO `__archive_columns_to_show` VALUES ('changeddate'),('closed'),('completed'),('createddate'),('crime'),('entry_content'),('file_entry_number'),('file_number'),('first_name'),('investigation_name'),('label'),('last_name'),('law_books_name'),('law_books_shortname'),('loginname'),('mission_date'),('mission_reports_title'),('name'),('owner'),('paragraph'),('personal_file_content'),('plate'),('reason_of_investigation'),('short_title'),('title'),('vehicle');
/*!40000 ALTER TABLE `__archive_columns_to_show` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__archive_settings`
--

DROP TABLE IF EXISTS `__archive_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__archive_settings` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `mysql_table` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `deleted_column` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `uniquecol` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'uid',
  `translation_programmtype` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation_key` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `deactivated` tinyint(1) NOT NULL DEFAULT 0,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`mysql_table`),
  UNIQUE KEY `uid_UNIQUE` (`uid`),
  KEY `idx_deactivated` (`deactivated`),
  KEY `idx_sortorder` (`sortorder`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__archive_settings`
--

LOCK TABLES `__archive_settings` WRITE;
/*!40000 ALTER TABLE `__archive_settings` DISABLE KEYS */;
INSERT INTO `__archive_settings` VALUES (1,'files','file_deleted','uid','archive','files',0,10),(2,'files_entries','deleted','uid','archive','files_entries',0,20),(3,'investigation','deleted','uid','archive','investigation',0,30),(4,'job_grades','deleted','grade','archive','job_grades',0,40),(5,'law_books','deleted','uid','archive','law_books',0,50),(6,'lawbook_laws','deleted','uid','archive','lawbook_laws',0,60),(7,'mission_reports','deleted','uid','archive','mission_reports',0,70),(8,'personal_file','deleted','uid','archive','personal_file',0,80),(9,'registered_user','deleted','userid','archive','registered_user',0,90),(10,'registered_vehicle','deleted','uid','archive','registered_vehicle',0,100),(11,'trainings','deleted','uid','archive','trainings',0,110);
/*!40000 ALTER TABLE `__archive_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_additional_data`
--

DROP TABLE IF EXISTS `__definition_additional_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_additional_data` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `additional_data_type` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `sql_query` blob DEFAULT NULL,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  `type` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'array',
  `allowInEdit` tinyint(1) NOT NULL DEFAULT 0,
  `allowInAdd` tinyint(1) NOT NULL DEFAULT 0,
  `allowInView` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`function_name`,`additional_data_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_additional_data`
--

LOCK TABLES `__definition_additional_data` WRITE;
/*!40000 ALTER TABLE `__definition_additional_data` DISABLE KEYS */;
INSERT INTO `__definition_additional_data` VALUES ('control_centre','control_centre','select \n	count(*)>0 as control_centre_isset\n	,IFNULL((select concat(loginname,\' -> \', last_name,\', \',first_name)),0)as control_centre_name\n	,IFNULL((userid = \'@@USERID@@\'),0) as control_centre_self\nfrom registered_user where is_control_centre = 1\nlimit 1',10,'array',0,0,0),('control_centre','patrols','SELECT\n\n	\'patrols_name\' as patrols_name\n	,\'patrols_shortname_tableheader\' as patrols_shortname_tableheader\n	,\'patrol_officers\' as patrol_officers\n	,\'patrol_status\' as patrol_status\n	,\'patrol_status_info\' as patrol_status_info\n	,\'patrol_area\' as patrol_area\n	,\'patrol_vehicle\' as patrol_vehicle\n	,\'uid\' as uid\nUNION\nSELECT\n	concat(patrols.patrols_name,\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as patrols_name\n	,concat(patrols.patrols_shortname,\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as patrols_shortname_tableheader\n	,concat(IFNULL((SELECT group_concat(concat(loginname, \' -> \',last_name,\', \',first_name) SEPARATOR \'<br>\') FROM registered_user where suspended = 0 AND deleted = 0 AND Patrol_id = patrols.uid),\'\'),\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as patrol_officers\n	,concat(IF(patrol_status.uid is not null, patrol_status_shortname, IFNULL(__definition_languages_values.translation, _defined_global_patrol_status.translation_key)),\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as patrol_status\n	,concat(IF(patrol_status.uid is not null, patrol_status_shortname, \'\'),\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as patrol_status_info\n	,concat(IFNULL(patrol_areas.name,\'\'),\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as patrol_area\n	,concat(patrols.patrols_vehicle,\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as patrol_vehicle\n	,concat(patrols.uid,\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as uid\nFROM patrols\n	left join patrol_status on patrol_status.uid = patrols.patrol_status\n	left join _defined_global_patrol_status on _defined_global_patrol_status.uid = patrols.patrol_status\n	left join _defined_colors on _defined_colors.uid = patrol_status.patrol_status_color\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_global_patrol_status.translation_programmtype\n		AND keyvalue = _defined_global_patrol_status.translation_key\n	left join patrol_areas on patrol_areas.uid = patrols.patrol_area',20,'table',0,0,0),('custom_personal_file','entries','SELECT  \n_defined_colors.fgcolor\n,_defined_colors.bgcolor\n\n,date_format(personal_file.createddate,\'%d.%m.%Y %H:%i:%s\') as createddate\n,(SELECT concat(loginname, \' - \', last_name,\', \',first_name) from registered_user where registered_user.userid = personal_file.createdby) as createdby\n,personal_file.deleted\n,personal_file.completed\n,personal_file.automatic_created\n,personal_file.personal_file_type\n,personal_file.personal_file_content\n,personal_file.uid\n,IFNULL(__definition_languages_values.translation, _defined_personal_file_types.translation_key) as entry_type\n\nFROM personal_file\n	left join _defined_personal_file_types on _defined_personal_file_types.uid = personal_file.personal_file_type\n	left join _defined_colors on _defined_colors.uid = _defined_personal_file_types.color_id\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_personal_file_types.translation_programmtype\n		AND keyvalue = _defined_personal_file_types.translation_key\n    \nWHERE personal_file_userid = @@ID@@\n	and deleted = 0\n\norder by createddate desc',10,'json',0,0,1),('custom_personal_file','officername','select \nconcat(loginname,\' - \',last_name, \',\',first_name) as officer_name\nfrom registered_user where userid = @@ID@@',20,'array',0,0,1),('dashboard','overview','SELECT \n\n(SELECT COUNT(*) FROM files) count_files_total\n,(SELECT COUNT(*) FROM files where file_deleted = 0) count_files\n\n,(\n	(SELECT count(*) from files where date(createddate) >= DATE_SUB(date(now()), interval 1 month)) +\n	(SELECT count(*) from files_entries where date(createddate) >= DATE_SUB(date(now()), interval 1 month)) +\n	(SELECT count(*) from trainings where date(createddate) >= DATE_SUB(date(now()), interval 1 month)) + \n	(SELECT count(*) from mission_reports where date(createddate) >= DATE_SUB(date(now()), interval 1 month))\n) as total_created_month\n,(\n(SELECT count(*) from files where date(createddate) >= DATE_SUB(date(now()), interval 7 day)) +\n(SELECT count(*) from files_entries where date(createddate) >= DATE_SUB(date(now()), interval 7 day)) +\n(SELECT count(*) from trainings where date(createddate) >= DATE_SUB(date(now()), interval 7 day)) + \n(SELECT count(*) from mission_reports where date(createddate) >= DATE_SUB(date(now()), interval 7 day))\n) as total_created_week\n\n,(SELECT count(*) from registered_user where deleted = 0) as count_officers\n,(SELECT count(*) from registered_user where PatrolStatusID <> -1) as count_officer_in_duty\n,IFNULL((SELECT loginname from registered_user where is_control_centre = 1 limit 1),NULL) as control_centre\n,IFNULL((SELECT concat(last_name, \', \', first_name) from registered_user where is_control_centre = 1 limit 1),NULL) as control_centre_fullname',0,'json',0,0,0),('form_files','information','select file_number \n\n,is_dead, is_gangmember, is_violent\n\nfrom files\nwhere uid = @@ID@@',10,'array',0,0,1),('form_files','treatments','select \n\nfiles_entries.*\n,files_entries.closed as entry_done\n\n,concat(registered_user.loginname, \' - \', registered_user.last_name,\', \',registered_user.first_name) as creator\n,date_format(files_entries.createddate,\'%d.%m.%Y %H:%i:%s\') as createddate\n\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'head\') as `injury_head`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'neck\') as `injury_neck`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'hip\') as `injury_hip`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'left_arm\') as `injury_left_arm`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'left_foot\') as `injury_left_foot`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'left_leg\') as `injury_left_leg`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'right_arm\') as `injury_right_arm`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'right_foot\') as `injury_right_foot`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'right_leg\') as `injury_right_leg`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'stomach\') as `injury_stomach`\n,(select injury from files_entries_injuries where files_entries_uid = files_entries.uid and injury_at = \'torso\') as `injury_torso`\n\nfrom files_entries\n    LEFT JOIN registered_user on registered_user.userid = files_entries.createdby\nwhere files_entries.file_uid = @@ID@@\nand files_entries.deleted = 0',20,'json',0,0,1),('form_files_add_entry','penalties','select \n\nlaw_books.uid as lawbook_uid\n,concat(law_books.law_books_shortname, \' - \', law_books_name) as lawbook_name\n,lawbook_laws.uid as law_uid\n,concat(lawbook_laws.paragraph,\' \',lawbook_laws.crime) as crime\n\nfrom law_books\n	left join lawbook_laws on lawbook_laws.lawbook_id = law_books.uid\n\nwhere law_books.deleted = 0\n	AND lawbook_laws.deleted = 0\n    \nORDER BY law_books.law_books_shortname,  law_books_name, lawbook_laws.sortorder',10,'json',0,0,0),('officer_trainings','officername','select \nconcat(loginname,\' - \',last_name, \',\',first_name) as officer_name\nfrom registered_user where userid = @@ID@@',20,'array',0,0,1),('officer_trainings','overview','select \n	\'short_title\' as short_title\n	,\'title\' as title\n	,\'officer_entered\' as officer_entered\n	,\'officer_passed\' as officer_passed\n	,\'uid\' as uid\nunion(\nselect \n\ntrainings.short_title\n,trainings.title\n,if(trainings_employees.training_id is null, 0 , 1 ) as officer_entered\n,ifnull(trainings_employees.passed,-1) as officer_passed\n,trainings.uid\n\nfrom trainings\n	left join trainings_employees on trainings_employees.training_id = trainings.uid\n		and trainings_employees.employee_id = @@ID@@\n\nwhere trainings.deleted = 0\n	\n        \norder by trainings.sorting, trainings.short_title\n)',10,'table',0,0,1),('penalties','penalties','select \n\nlaw_books.uid as lawbook_uid\n,concat(law_books.law_books_shortname, \' - \', law_books_name) as lawbook_name\n,lawbook_laws.uid as law_uid\n,concat(lawbook_laws.paragraph,\' \',lawbook_laws.crime) as crime\n,lawbook_laws.minimum_penalty\n,lawbook_laws.detention_time\n,lawbook_laws.road_traffic_regulations_points\n,lawbook_laws.others\n\n\n\nfrom law_books\n	left join lawbook_laws on lawbook_laws.lawbook_id = law_books.uid\n\nWHERE law_books.deleted = 0\n	AND lawbook_laws.deleted = 0\n    \nORDER BY law_books.law_books_shortname,  law_books_name, lawbook_laws.sortorder',10,'json',0,0,0),('radio','radio','SELECT \n	Patrol_ID\n	,IF(registered_user.PatrolStatusID = -1 AND registered_user.Patrol_ID = -1,1,0) as DisableEndService\n	,IF(registered_user.Patrol_ID = -1,1,0) as DisableLeavePatrol\n	,IF(patrols.uid IS NOT NULL, concat(patrols.patrols_shortname,\' - \', patrols.patrols_name),\'\') as PatrolName\n	,IF(patrol_status.uid is not null,concat(patrol_status.patrol_status_shortname,\' - \',patrol_status.patrol_status_name), IFNULL(__definition_languages_values.translation, _defined_global_patrol_status.translation_key)   ) as StatusName\nFROM registered_user\n	left join patrols on patrols.uid = registered_user.Patrol_ID\n    left join patrol_status on patrol_status.uid = IFNULL(patrols.patrol_status,registered_user.PatrolStatusID)\n    left join _defined_global_patrol_status on _defined_global_patrol_status.uid = IFNULL(patrols.patrol_status,registered_user.PatrolStatusID)\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_global_patrol_status.translation_programmtype\n		AND keyvalue = _defined_global_patrol_status.translation_key\nwhere userid = @@USERID@@',10,'array',0,0,0),('view_investigation','entries','SELECT \n	\'createdby\' as createdby\n	,\'entry_content\' as entry_content\n	,\'is_important_entry\' as is_important_entry\n	\nUNION\n(\nSELECT \n	(SELECT concat(loginname,\'<br>\',last_name,\', \', first_name) from registered_user where userid = investigation_entries.createdby) as createdby \n	,entry_content\n	,is_important_entry\n	\nFROM investigation_entries \nWHERE investigation_id = @@ID@@ \nORDER BY createddate DESC\n)\n',10,'table',0,0,0);
/*!40000 ALTER TABLE `__definition_additional_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_datadeleter_afterdelete_functions`
--

DROP TABLE IF EXISTS `__definition_datadeleter_afterdelete_functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_datadeleter_afterdelete_functions` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `function_name_sub` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  `sql_query` blob DEFAULT NULL,
  `deactivated` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`function_name`,`function_name_sub`),
  KEY `idx_sortorder` (`sortorder`),
  KEY `idx_deactivated` (`deactivated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_datadeleter_afterdelete_functions`
--

LOCK TABLES `__definition_datadeleter_afterdelete_functions` WRITE;
/*!40000 ALTER TABLE `__definition_datadeleter_afterdelete_functions` DISABLE KEYS */;
INSERT INTO `__definition_datadeleter_afterdelete_functions` VALUES ('delete_lawbook_laws','delete_lawbook_laws',0,'UPDATE lawbook_laws\nSET deleted = 1\nWHERE uid = @@ID@@',0),('group_management','unset user rankß',0,'update registered_user\n\nSET rankid = -1\n\nwhere rankid = @@id@@\nand userid<>0',0),('licenses','remove licenses from files',0,'DELETE FROM files_licenses_connection \nWHERE file_uid<>-1\n	AND license_uid = @@ID@@',0),('patrol_status','reset_patrol_patrol_status',10,'UPDATE patrols \nSET patrol_status = -2 \nWHERE uid<>-1 \n	AND patrol_status = @@ID@@',0),('patrol_status','reset_user_patrol_status',0,'UPDATE registered_user \nSET PatrolStatusID = -1 \nWHERE userid<>-1 \n	AND PatrolStatusID = @@ID@@',0),('patrols','reset_user_patrolid',0,'UPDATE registered_user \nSET patrol_id = -1 \nWHERE userid<>-1 \n	AND patrol_id = @@ID@@',0);
/*!40000 ALTER TABLE `__definition_datadeleter_afterdelete_functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_datasaver_custom_statements`
--

DROP TABLE IF EXISTS `__definition_datasaver_custom_statements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_datasaver_custom_statements` (
  `post_function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sub_function` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT 0,
  `sql_query` blob DEFAULT NULL,
  `deactivated` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`post_function_name`,`sub_function`),
  KEY `idx_deactivated` (`deactivated`),
  KEY `idx_sortorder` (`sortorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_datasaver_custom_statements`
--

LOCK TABLES `__definition_datasaver_custom_statements` WRITE;
/*!40000 ALTER TABLE `__definition_datasaver_custom_statements` DISABLE KEYS */;
INSERT INTO `__definition_datasaver_custom_statements` VALUES ('archive_recover','archive_recover',0,'UPDATE @@TABLENAME@@\nSET @@DELETEDCOL@@ = 0\n,changedby = @@SESSIONUSERID@@\nWHERE @@PRIMARYCOL@@ = @@ID@@',0),('archive_remove','archive_remove',0,'UPDATE @@TABLENAME@@\nSET hide_in_archiv = 1\n,changedby = @@SESSIONUSERID@@\nWHERE @@PRIMARYCOL@@ = @@ID@@',0),('control_centre_reset','reset_control_centre',0,'UPDATE registered_user \nSET is_control_centre = 0 \nWHERE userid <> -1',0),('control_centre_set_by_user','reset_other_users',0,'UPDATE registered_user \nSET is_control_centre = 0 \nWHERE userid <> @@SESSIONUSERID@@',0),('control_centre_set_by_user','set_user_as_control_centre',10,'UPDATE registered_user \nSET is_control_centre = 1\nWHERE userid = @@SESSIONUSERID@@',0),('files_entry_complete','files_entry_complete',0,'UPDATE files_entries\n\nSET closed = 1\n,changedby = @@SESSIONUSERID@@\n\nWHERE uid = @@ID@@',0),('files_entry_delete','files_entry_delete',0,'UPDATE files_entries\n\nSET deleted = 1\n,changedby = @@SESSIONUSERID@@\n\nWHERE uid = @@ID@@',0),('files_grant_license','files_grant_license',0,'INSERT INTO files_licenses_connection(\n	file_uid\n    ,license_uid\n    ,createdby\n    ,changedby\n) VALUES (\n	@@ID@@\n	,@@LICENSEID@@\n	,@@SESSIONUSERID@@\n	,@@SESSIONUSERID@@\n) on duplicate key update\n	changedby = values(`changedby`)',0),('files_handle_meta','handle delete, blacken, close',0,'UPDATE files\n	SET @@COLUMNNAME@@ = IF(@@COLUMNNAME@@ = 1 , 0 , 1 )\n	,changedby = @@SESSIONUSERID@@ \nWHERE uid = @@ID@@',0),('files_manhunt_end','files_manhunt_end',0,'UPDATE files_entries\n\nSET file_is_wanted_finished = 1\n,changedby = @@SESSIONUSERID@@\n\nWHERE uid = @@ID@@',0),('files_remove_license','files_remove_license',0,'DELETE FROM files_licenses_connection\nWHERE file_uid = @@ID@@\n	AND license_uid = @@LICENSEID@@',0),('investigation_add_entry','investigation_add_entry',0,'insert into investigation_entries(\n	investigation_id\n	,entry_content\n	,is_important_entry\n	,createdby\n	,changedby\n) VALUES (\n	@@ID@@\n	,\'@@ENTRY_CONTENT@@\'\n	,@@IS_IMPORTANT_ENTRY@@\n	,@@SESSIONUSERID@@\n	,@@SESSIONUSERID@@\n)',0),('investigation_set_closed','handle closed',0,'update investigation \nSET closed = IF(closed = 1,0,1)\n	, changedby = @@SESSIONUSERID@@\nWHERE uid = @@ID@@',0),('password_reset','reset_password',0,'UPDATE registered_user\nSET password = MD5(\'@@PASSWORD@@\')\nWHERE userid = IF(@@ID@@ = -1, @@SESSIONUSERID@@, @@ID@@)',0),('patrol_leave_by_user','patrol_leave_by_user',0,'UPDATE registered_user \nSET PatrolStatusID = -2\n,Patrol_ID = -1  \nWHERE userid = @@SESSIONUSERID@@',0),('patrol_reset','reset patrol status',0,'UPDATE patrols \nSET patrol_status = -2\n,patrol_area = -1\nWHERE uid<>-1 \nand IF(\'@@ID@@\' <> \'*\', uid = \'@@ID@@\', 1=1 )',0),('patrol_reset','reset patrol users',10,'UPDATE registered_user \nSET PatrolStatusID = -1, Patrol_ID = -1  \nWHERE userid <> 0 \n	AND IF(\'@@ID@@\' <> \'*\', Patrol_ID = \'@@ID@@\',1=1)',0),('patrol_service_end_by_user','end_patrol_service',0,'UPDATE registered_user \n	SET PatrolStatusID = -1\n    ,Patrol_ID = -1  \nWHERE userid = @@SESSIONUSERID@@',0),('patrol_set_status_by_user','reset patrol status at user if in a patrol',10,'UPDATE registered_user \n	SET PatrolStatusID = -2\nWHERE Patrol_ID<>-1 \n	AND userid = @@SESSIONUSERID@@',0),('patrol_set_status_by_user','set patrol status at user if not in a patrol',0,'UPDATE registered_user \n	SET PatrolStatusID = @@ID@@ \nWHERE Patrol_ID=-1 \n	AND userid = @@SESSIONUSERID@@',0),('patrol_set_status_by_user','update patrol user is sitting in',20,'UPDATE patrols \n	SET patrol_status = @@ID@@\nWHERE uid = (SELECT Patrol_ID FROM registered_user where userid = @@SESSIONUSERID@@)',0),('personal_file_complete','personal_file_complete',0,'UPDATE personal_file\n\nset completed = 1\n,changedby = @@SESSIONUSERID@@\n\nwhere uid = @@ID@@',0),('personal_file_delete','personal_file_delete',0,'UPDATE personal_file\n\nset deleted = 1\n,changedby = @@SESSIONUSERID@@\n\nwhere uid = @@ID@@',0),('registered_vehicle_reset_wanting','registered_vehicle_reset_wanting',0,'UPDATE registered_vehicle\nSET is_wanted = 0\n	,reason_of_is_wanted=\'\'\n	,changedby = @@SESSIONUSERID@@\nWHERE uid = @@ID@@',0),('save_personal_file_entry','save_personal_file_entry',0,'INSERT INTO personal_file(\n	personal_file_userid\n    ,personal_file_content\n    ,personal_file_type\n    ,createdby\n    ,changedby\n) VALUES (\n	@@USERID@@\n	,\'@@PERSONAL_FILE_CONTENT@@\'\n	,@@PERSONAL_FILE_TYPE@@\n	,@@SESSIONUSERID@@\n    ,@@SESSIONUSERID@@\n)',0),('training_participant_add','training participant add',0,'INSERT INTO trainings_employees(\n	training_id\n	,employee_id\n	,createdby\n	,changedby\n) VALUES (\n	@@ID@@\n	,@@POSTUSERID@@\n	,@@SESSIONUSERID@@\n	,@@SESSIONUSERID@@\n) on duplicate key update \n	passed = -1\n    , changedby = values(`changedby`)',0),('training_participant_delete','delete participent',0,'DELETE FROM trainings_employees \nWHERE training_id = @@ID@@ \nAnd employee_id = @@POSTUSERID@@',0),('training_participant_set_passed','set_passed',0,'INSERT INTO trainings_employees(\n	training_id\n	,employee_id\n	,passed\n	,createdby\n	,changedby\n) VALUES (\n	@@ID@@\n	,@@POSTUSERID@@\n	,@@PASSED@@\n	,@@SESSIONUSERID@@\n	,@@SESSIONUSERID@@\n) on duplicate key update\n	passed = values(`passed`)\n	,changedby = values(`changedby`)',0),('training_participant_set_passed','write_personalfile',10,'INSERT INTO personal_file(\n	personal_file_userid\n	,personal_file_content\n	,personal_file_type\n	,automatic_created\n	,createdby\n	,changedby\n) VALUES (\n	@@POSTUSERID@@\n	,IFNULL((\n		SELECT REPLACE(\n			(\n				SELECT group_concat(text_content ORDER BY sortorder ASC SEPARATOR \'\')\n				FROM _defined_personal_file_automation_texts\n				WHERE find_in_set(\'training_passed_@@PASSED@@\',select_type)\n			)\n			,\'@@TRAININGNAME@@\'\n			,trainings.title\n		) \n		FROM trainings where uid = @@ID@@\n	),\'\')\n	,0\n	,1\n	,@@SESSIONUSERID@@\n	,@@SESSIONUSERID@@\n);',0),('training_participate_self','training_participate_self',0,'INSERT INTO trainings_employees(\n	training_id\n	,employee_id\n	,createdby\n	,changedby\n) VALUES(\n	@@ID@@\n	,@@SESSIONUSERID@@\n	,@@SESSIONUSERID@@\n	,@@SESSIONUSERID@@\n)',0),('user_set_deleted','delete_activate_user',0,'UPDATE registered_user \n	SET deleted = IF(deleted = 1 , 0 , 1 )\n	,Patrol_ID=-1\n	, PatrolStatusID=-1\n	,is_control_centre=0 \n	,changedby = @@SESSIONUSERID@@ \nWHERE userid = @@ID@@',0),('user_set_suspended','user_set_suspended',0,'UPDATE registered_user \n	SET suspended = IF(suspended = 1 , 0 , 1 )\n	,Patrol_ID=-1\n	, PatrolStatusID=-1\n	,is_control_centre=0 \n	,changedby = @@SESSIONUSERID@@ \nWHERE userid = @@ID@@',0);
/*!40000 ALTER TABLE `__definition_datasaver_custom_statements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_dropdowns`
--

DROP TABLE IF EXISTS `__definition_dropdowns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_dropdowns` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `column_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sql_query` blob DEFAULT NULL,
  PRIMARY KEY (`column_name`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_dropdowns`
--

LOCK TABLES `__definition_dropdowns` WRITE;
/*!40000 ALTER TABLE `__definition_dropdowns` DISABLE KEYS */;
INSERT INTO `__definition_dropdowns` VALUES (9,'PatrolStatusID','(select \n	uid\n    ,IFNULL(__definition_languages_values.translation, _defined_global_patrol_status.translation_key) as name\n	\nfrom _defined_global_patrol_status\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'de\'\n		AND programmtype = _defined_global_patrol_status.translation_programmtype\n		AND keyvalue = _defined_global_patrol_status.translation_key\nwhere uid = -1\n)\nunion\n(\nSELECT \n	uid\n    ,concat(patrol_status_shortname, \' - \', patrol_status_name) as name\n\nFROM patrol_status\n	ORDER BY patrol_status_name\n)'),(12,'Patrol_ID','SELECT \n	uid\n	,concat(patrols_shortname,\' - \', patrols_name) as name\n\nFROM patrols \nORDER BY patrols_name'),(16,'allow_officer_self_entry','select \nuid\n,IFNULL(__definition_languages_values.translation, _defined_yesno.translation_key) as name\n from _defined_yesno\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_yesno.translation_programmtype\n		AND keyvalue = _defined_yesno.translation_key\nORDER BY _defined_yesno.uid'),(18,'closed','select \nuid\n,IFNULL(__definition_languages_values.translation, _defined_yesno.translation_key) as name\n from _defined_yesno\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_yesno.translation_programmtype\n		AND keyvalue = _defined_yesno.translation_key\nORDER BY _defined_yesno.uid'),(24,'complaint_reporter','select \n	\'\' as uid\n	,\'\' as name\nunion\nselect \n	-9999 as uid\n	,IF(\"@@LOCALE@@\"=\'de\',\'Neue Akte\',\'New File\') as name\nunion(\n\nSELECT \n	uid\n    ,name\n\nFROM files\n\nwhere file_blackend = 0\n	and file_closed = 0\n    and file_deleted = 0\n\norder by name ASC)\n'),(6,'employee_id','select \n	userid as uid\n	,concat(loginname ,\' - \',last_name,\', \',first_name) as name\nfrom registered_user \n	where deleted = 0 \n	and suspended = 0 \nORDER BY last_name, first_name'),(25,'file_is_wanted','select \nuid\n,IFNULL(__definition_languages_values.translation, _defined_yesno.translation_key) as name\n from _defined_yesno\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_yesno.translation_programmtype\n		AND keyvalue = _defined_yesno.translation_key\nORDER BY _defined_yesno.uid'),(5,'instructor_id','select \n	userid as uid\n	,concat(loginname ,\' - \',last_name,\', \',first_name) as name\nfrom registered_user \n	where deleted = 0 \n	and suspended = 0 \n  and rankid<>9999\nORDER BY last_name, first_name'),(7,'instructor_id_all','select \n	userid as uid\n	, concat(loginname ,\' - \',last_name,\', \',first_name) as name \nfrom registered_user\nORDER BY last_name, first_name'),(29,'is_dead','select \nuid\n,IFNULL(__definition_languages_values.translation, _defined_yesno.translation_key) as name\n from _defined_yesno\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_yesno.translation_programmtype\n		AND keyvalue = _defined_yesno.translation_key\nORDER BY _defined_yesno.uid'),(30,'is_gangmember','select \nuid\n,IFNULL(__definition_languages_values.translation, _defined_yesno.translation_key) as name\n from _defined_yesno\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_yesno.translation_programmtype\n		AND keyvalue = _defined_yesno.translation_key\nORDER BY _defined_yesno.uid'),(19,'is_important_entry','select \nuid\n,IFNULL(__definition_languages_values.translation, _defined_yesno.translation_key) as name\n from _defined_yesno\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_yesno.translation_programmtype\n		AND keyvalue = _defined_yesno.translation_key\nORDER BY _defined_yesno.uid'),(31,'is_violent','select \nuid\n,IFNULL(__definition_languages_values.translation, _defined_yesno.translation_key) as name\n from _defined_yesno\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_yesno.translation_programmtype\n		AND keyvalue = _defined_yesno.translation_key\nORDER BY _defined_yesno.uid'),(17,'is_wanted','select \nuid\n,IFNULL(__definition_languages_values.translation, _defined_yesno.translation_key) as name\n from _defined_yesno\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_yesno.translation_programmtype\n		AND keyvalue = _defined_yesno.translation_key\nORDER BY _defined_yesno.uid'),(11,'lawbook_id','SELECT\n	uid\n	,concat(law_books_shortname,\' - \', law_books_name) as name\n\nFROM law_books \nwhere deleted = 0\norder by law_books_shortname, law_books_name'),(13,'locale','SELECT \n	locale as uid\n	,name\nFROM __definition_languages \nORDER BY name'),(21,'min_rankid','SELECT \n	grade as uid\n	,label as name\n\nFROM job_grades\nwhere deleted = 0'),(28,'need_follow_up_treatment','select \nuid\n,IFNULL(__definition_languages_values.translation, _defined_yesno.translation_key) as name\n from _defined_yesno\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_yesno.translation_programmtype\n		AND keyvalue = _defined_yesno.translation_key\nORDER BY _defined_yesno.uid'),(27,'patrol_area','select uid,name \nfrom patrol_areas\norder by name'),(10,'patrol_status','(select \n	uid\n    ,IFNULL(__definition_languages_values.translation, _defined_global_patrol_status.translation_key) as name\n	\nfrom _defined_global_patrol_status\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'de\'\n		AND programmtype = _defined_global_patrol_status.translation_programmtype\n		AND keyvalue = _defined_global_patrol_status.translation_key\nwhere uid = -2\n)\nunion\n(\nSELECT \n	uid\n    ,concat(patrol_status_shortname, \' - \', patrol_status_name) as name\n\nFROM patrol_status\n	ORDER BY patrol_status_name\n)'),(4,'patrol_status_color','SELECT \n\nuid\n,IFNULL(__definition_languages_values.translation, _defined_colors.translation_key) as name\n\nFROM _defined_colors\n\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_colors.translation_programmtype\n		AND keyvalue = _defined_colors.translation_key\norder by _defined_colors.sortorder'),(23,'perpetrator','select \n	0 as uid\n    ,IF(\"@@LOCALE@@\"=\'de\',\'Unbekannt\',\'Unknown\') as name\nunion\nselect \n	-9999 as uid\n	,IF(\"@@LOCALE@@\"=\'de\',\'Neue Akte\',\'New File\') as name\nunion (\nSELECT \n	uid\n    ,name\n\nFROM files\n\nwhere file_blackend = 0\n	and file_closed = 0\n    and file_deleted = 0\n\norder by name ASC\n)'),(8,'personal_file_type','select  \n\n_defined_personal_file_types.uid\n,IFNULL(__definition_languages_values.translation, _defined_personal_file_types.translation_key) as name\n\n\nfrom _defined_personal_file_types\n\nLEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'de\'\n	AND programmtype = _defined_personal_file_types.translation_programmtype\n	AND keyvalue = _defined_personal_file_types.translation_key\n    \nORDER BY _defined_personal_file_types.uid'),(20,'rankid','SELECT \n	grade as uid\n	,label as name\nFROM job_grades\n\nwhere deleted = 0'),(2,'securety_level','SELECT \n	uid\n	,name\n\nFROM _defined_securety_level\n\nwhere uid <= (\n	select if(rankid = 9999, rankid, securety_level) from registered_user\n	where userid = @@USERID@@\n)\n\nORDER BY uid'),(1,'sex','SELECT \n\nuid\n,IFNULL(__definition_languages_values.translation, _defined_sex.translation_key) as name\n\nFROM _defined_sex\n\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_sex.translation_programmtype\n		AND keyvalue = _defined_sex.translation_key\norder by _defined_sex.uid'),(3,'status','SELECT \n	uid\n	,IFNULL((\n		SELECT translation \n        from __definition_languages_values \n        where __definition_languages_values.locale=\'@@LOCALE@@\' \n			AND __definition_languages_values.programmtype = _defined_status.translation_programmtype\n			AND __definition_languages_values.keyvalue = _defined_status.translation_key\n    \n    ),_defined_status.translation_key) as name\nFROM _defined_status \nORDER BY uid'),(26,'type_of_entry','select \n\nuid\n,IFNULL(__definition_languages_values.translation, _defined_file_entry_types.translation_key) as name\n\n\nfrom _defined_file_entry_types\n\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_file_entry_types.translation_programmtype\n		AND keyvalue = _defined_file_entry_types.translation_key'),(22,'violation_of','SELECT\n	uid\n	,concat(law_books_shortname,\' - \', law_books_name) as name\n\nFROM law_books \nwhere deleted = 0\norder by law_books_shortname, law_books_name');
/*!40000 ALTER TABLE `__definition_dropdowns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_extrabuttons`
--

DROP TABLE IF EXISTS `__definition_extrabuttons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_extrabuttons` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `button_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `label` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `onclickevent` varchar(256) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT 0,
  `btncolor` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'primary',
  `value_field` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `right_function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `right_sub_function` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `default_disabled` tinyint(1) NOT NULL DEFAULT 0,
  `deactivated` tinyint(1) NOT NULL DEFAULT 0,
  `allowInAdd` tinyint(1) NOT NULL DEFAULT 0,
  `allowInEdit` tinyint(1) NOT NULL DEFAULT 0,
  `allowInView` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`function_name`,`button_name`),
  KEY `idx_deactivated` (`deactivated`),
  KEY `idx_sortorder` (`sortorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_extrabuttons`
--

LOCK TABLES `__definition_extrabuttons` WRITE;
/*!40000 ALTER TABLE `__definition_extrabuttons` DISABLE KEYS */;
INSERT INTO `__definition_extrabuttons` VALUES ('custom_personal_file','form_officer','navigate_back','doLoadPageContent(this.id,\"view\",@@lastRequestedID@@)',10,'warning','','','',0,0,0,0,1),('custom_personal_file','form_personalfile_entry','add_entry','doLoadPageContent(this.id,\"add\",@@lastRequestedID@@)',20,'success','','personal_file','add_edit',0,0,0,0,1),('form_files','files_delete','files_delete','files_handle_meta(this.id)',40,'danger','file_deleted','files','delete',0,0,0,0,1),('form_files','files_set_blackend','files_set_blackend','files_handle_meta(this.id)',20,'warning','file_blackend','files','blacken',0,0,0,0,1),('form_files','files_set_closed','files_set_closed','files_handle_meta(this.id)',30,'primary','file_closed','files','close',0,0,0,0,1),('form_files','form_files_add_entry','add_entry','doLoadPageContent(\"form_files_add_entry\",\"add\",@@lastRequestedID@@)',10,'success','','file_entries','add_edit',0,0,0,0,1),('form_files_add_entry','form_files','cancel','doLoadPageContent(this.id,\"view\",@@lastRequestedID@@)',10,'danger','','','',0,0,1,1,0),('form_files_add_entry','save','save','files_add_entry(@@lastRequestedID@@)',20,'success','','file_entries','add_edit',1,0,1,1,0),('form_officer','custom_personal_file','view_personal_file','doLoadPageContent(this.id,\"view\",@@lastRequestedID@@)',30,'primary','','training_participants','view',0,0,0,0,1),('form_officer','form_passwordreset_foruser','passwordreset','doLoadPageContent(this.id,\"edit\",@@lastRequestedID@@)',40,'success','','officers','add_edit',0,0,0,0,1),('form_officer','officer_trainings','view_officertrainings','doLoadPageContent(this.id,\"view\",@@lastRequestedID@@)',40,'info','','training_participants','view',0,0,0,0,1),('form_officer','user_set_deleted','delete_activate_user','user_set_deleted(this.id, @@lastRequestedID@@)',10,'danger','deleted','officers','delete',0,1,0,0,1),('form_officer','user_set_suspended','suspend_unsuspend_user','user_set_suspended(this.id,@@lastRequestedID@@)',20,'warning','suspended','officers','suspend',0,0,0,0,1),('form_participent','save_participant','save_participant','training_participant_add(@@lastRequestedID@@)',20,'success','','training_participants','add_edit',0,0,1,1,0),('form_participent','training_participants','view_participants','doLoadPageContent(this.id,\"view\",@@lastRequestedID@@)',10,'warning','','training_participants','view',0,0,1,1,0),('form_personalfile_entry','custom_personal_file','cancel','doLoadPageContent(this.id,\"view\",@@lastRequestedID@@)',10,'danger','','','',0,0,1,1,0),('form_personalfile_entry','save','save','save_personal_file_entry()',20,'success','','personal_file','add_edit',1,0,1,1,0),('form_training','training_participants','view_participants','doLoadPageContent(this.id,\"view\",@@lastRequestedID@@)',10,'primary','','training_participants','view',0,0,0,0,1),('group_rights','group_management','group_management','changePage(this.id,-1)',10,'danger','','','',0,0,0,0,0),('group_rights','save_data','save_data','group_rights_save()',20,'success','','group_management','set_rights',0,0,0,0,0),('officer_trainings','form_officer','navigate_back','doLoadPageContent(this.id,\"view\",@@lastRequestedID@@)',10,'warning','','','',0,0,0,0,1),('radio','patrol_leave_by_user','leave_patrol','patrol_leave_by_user(this.id)',10,'warning','','','',0,0,0,0,0),('radio','patrol_service_end_by_user','end_service','patrol_service_end_by_user(this.id)',20,'primary','','','',0,0,0,0,0),('training_participants','form_participent','add_participent','doLoadPageContent(this.id,\"add\",@@lastRequestedID@@)',20,'success','','training_participants','add_edit',0,0,0,0,1),('training_participants','form_training','navigate_back','doLoadPageContent(this.id,\"view\",@@lastRequestedID@@)',10,'warning','','','',0,0,0,0,1);
/*!40000 ALTER TABLE `__definition_extrabuttons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_fixed_sqlquery`
--

DROP TABLE IF EXISTS `__definition_fixed_sqlquery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_fixed_sqlquery` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sql_query` blob DEFAULT NULL,
  `column_names` varchar(1028) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `allowSearch` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`function_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_fixed_sqlquery`
--

LOCK TABLES `__definition_fixed_sqlquery` WRITE;
/*!40000 ALTER TABLE `__definition_fixed_sqlquery` DISABLE KEYS */;
INSERT INTO `__definition_fixed_sqlquery` VALUES ('control_centre','SELECT\n@@columns@@\n FROM registered_user\n left join patrol_status on patrol_status.uid = registered_user.PatrolStatusID\n left join _defined_global_patrol_status on _defined_global_patrol_status.uid = registered_user.PatrolStatusID\n left join _defined_colors on _defined_colors.uid = patrol_status.patrol_status_color\nLEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n	AND programmtype = _defined_global_patrol_status.translation_programmtype\n	AND keyvalue = _defined_global_patrol_status.translation_key\n where patrol_id = -1\n	 AND suspended = 0 \n	 AND deleted = 0\n	and rankid <> 9999\n@@ORDERBY@@\n@@LIMIT@@',',concat(registered_user.userid,\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as uid\n,concat(registered_user.loginname,\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as loginname\n ,concat(last_name,\', \',first_name,\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as fullname\n ,concat(IF(patrol_status.uid is not null, patrol_status_shortname, IFNULL(__definition_languages_values.translation, _defined_global_patrol_status.translation_key)),\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as _officer_status\n ,concat(IF(patrol_status.uid is not null, patrol_status_shortname, \'\'),\'|\',IFNULL(_defined_colors.bgColor,\'\'),\'|\',IFNULL(_defined_colors.fgColor,\'\')) as officer_status_info',0);
/*!40000 ALTER TABLE `__definition_fixed_sqlquery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_formconfig`
--

DROP TABLE IF EXISTS `__definition_formconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_formconfig` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `columnname` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `form_group` int(11) NOT NULL DEFAULT 0,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  `form_type` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'text',
  `height` int(11) NOT NULL DEFAULT 0,
  `isReadOnly` tinyint(1) NOT NULL DEFAULT 0,
  `needsValidation` tinyint(1) NOT NULL DEFAULT 1,
  `isHidden` tinyint(1) NOT NULL DEFAULT 0,
  `textMixLength` int(11) NOT NULL DEFAULT 0,
  `textMaxLength` int(11) NOT NULL DEFAULT 0,
  `right_function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `right_sub_function` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `allowInEdit` tinyint(1) NOT NULL DEFAULT 0,
  `allowInAdd` tinyint(1) NOT NULL DEFAULT 0,
  `allowInView` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`function_name`,`columnname`),
  KEY `idx_formgroup` (`form_group`),
  KEY `idx_sortorder` (`sortorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_formconfig`
--

LOCK TABLES `__definition_formconfig` WRITE;
/*!40000 ALTER TABLE `__definition_formconfig` DISABLE KEYS */;
INSERT INTO `__definition_formconfig` VALUES ('add_lawbook','law_books_name',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('add_lawbook','law_books_shortname',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('add_licenses','name',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('add_licenses','sortorder',20,10,'number',0,0,1,0,0,0,'','',0,0,0),('add_personal_file','personal_file_content',20,10,'textarea',8,0,1,0,0,0,'','',0,0,0),('add_personal_file','personal_file_type',30,10,'text',0,0,1,0,0,0,'','',0,0,0),('add_personal_file','personal_file_userid',10,10,'text',0,1,1,0,0,0,'','',0,0,0),('edit_crime','crime',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_crime','detention_time',30,20,'number',0,0,1,0,0,0,'','',0,0,0),('edit_crime','lawbook_id',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_crime','minimum_penalty',30,10,'number',0,0,1,0,0,0,'','',0,0,0),('edit_crime','others',50,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_crime','paragraph',20,20,'text',0,0,1,0,0,0,'','',0,0,0),('edit_crime','road_traffic_regulations_points',40,10,'number',0,0,1,0,0,0,'','',0,0,0),('edit_crime','sortorder',40,20,'number',0,0,1,0,0,0,'','',0,0,0),('edit_criminal_charges','act_of_crime',50,10,'textarea',2,0,1,0,0,0,'','',0,0,0),('edit_criminal_charges','complaint_reporter',10,10,'select-search',0,0,1,0,0,0,'','',0,0,0),('edit_criminal_charges','notes',60,10,'textarea',2,0,0,0,0,0,'','',0,0,0),('edit_criminal_charges','perpetrator',10,20,'select-search',0,0,1,0,0,0,'','',0,0,0),('edit_criminal_charges','perpetrator_description',20,10,'textarea',2,0,1,0,0,0,'','',0,0,0),('edit_criminal_charges','securety_level',40,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_criminal_charges','status',40,20,'text',0,0,1,0,0,0,'','',0,0,0),('edit_criminal_charges','violation_of',40,30,'text',0,0,1,0,0,0,'','',0,0,0),('edit_files','alias',10,20,'text',0,0,1,0,0,0,'','',0,0,0),('edit_files','birthdate',30,20,'date',0,0,1,0,0,0,'','',0,0,0),('edit_files','eye_color',40,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_files','hair_color',40,20,'text',0,0,1,0,0,0,'','',0,0,0),('edit_files','name',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_files','phone',20,20,'text',0,0,1,0,0,0,'','',0,0,0),('edit_files','securety_level',50,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_files','sex',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_files','size',30,10,'number',0,0,1,0,0,0,'','',0,0,0),('edit_files','traffic_points',50,20,'number',0,0,1,0,0,0,'','',0,0,0),('edit_investigation','investigation_name',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_investigation','reason_of_investigation',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_investigation','securety_level',30,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_jobrank','label',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_lawbook','law_books_name',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_lawbook','law_books_shortname',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_licenses','name',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_licenses','sortorder',20,10,'number',0,0,1,0,0,0,'','',0,0,0),('edit_mission_reports','involved_forces',20,20,'text',0,0,1,0,0,0,'','',0,0,0),('edit_mission_reports','location',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_mission_reports','mission_content',30,10,'textarea',8,0,1,0,0,0,'','',0,0,0),('edit_mission_reports','mission_date',10,20,'date',0,0,1,0,0,0,'','',0,0,0),('edit_mission_reports','mission_reports_title',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_mission_reports','securety_level',40,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_officer','deleted',60,20,'text',0,0,1,1,0,0,'','',0,0,0),('edit_officer','first_name',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_officer','last_name',20,20,'text',0,0,1,0,0,0,'','',0,0,0),('edit_officer','loginname',10,10,'text',0,1,1,0,0,0,'','',0,0,0),('edit_officer','rankid',40,40,'text',0,0,1,0,0,0,'','',0,0,0),('edit_officer','securety_level',50,50,'text',0,0,1,0,0,0,'officers','change_securety_level',0,0,0),('edit_patrol','patrols_name',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_patrol','patrols_shortname',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_patrol','patrols_vehicle',30,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_patrol_status','patrol_status_color',30,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_patrol_status','patrol_status_name',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_patrol_status','patrol_status_shortname',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_training','allow_officer_self_entry',50,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_training','instructor_id',70,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_training','min_rankid',50,20,'text',0,0,1,0,0,0,'','',0,0,0),('edit_training','short_title',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_training','sorting',20,20,'number',0,0,1,0,0,0,'','',0,0,0),('edit_training','title',10,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_training','training_content',30,10,'textarea',8,0,1,0,0,0,'','',0,0,0),('edit_vehicle','is_wanted',40,10,'dropdown',0,0,1,0,0,0,'vehicle_register','allow_manhunt',0,0,0),('edit_vehicle','mot',20,20,'date',0,0,1,0,0,0,'','',0,0,0),('edit_vehicle','owner',10,20,'text',0,0,1,0,0,0,'','',0,0,0),('edit_vehicle','plate',10,10,'text',0,0,1,0,8,8,'','',0,0,0),('edit_vehicle','reason_of_is_wanted',50,10,'text',0,0,0,0,0,0,'vehicle_register','allow_manhunt',0,0,0),('edit_vehicle','vehicle',30,10,'text',0,0,1,0,0,0,'','',0,0,0),('edit_vehicle','vehicle_type',20,10,'text',0,0,1,0,0,0,'','',0,0,0),('form_files','alias',10,20,'text',0,0,1,0,0,0,'','',1,1,1),('form_files','birthdate',30,20,'date',0,0,1,0,0,0,'','',1,1,1),('form_files','eye_color',40,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_files','file_blackend',70,10,'text',0,0,1,1,0,0,'','',0,0,1),('form_files','file_closed',70,20,'text',0,0,1,1,0,0,'','',0,0,1),('form_files','file_deleted',70,30,'text',0,0,1,1,0,0,'','',0,0,1),('form_files','hair_color',40,20,'text',0,0,1,0,0,0,'','',1,1,1),('form_files','is_dead',60,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_files','is_gangmember',60,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_files','is_violent',60,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_files','name',10,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_files','phone',20,20,'text',0,0,1,0,0,0,'','',1,1,1),('form_files','securety_level',50,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_files','sex',20,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_files','size',30,10,'number',0,0,1,0,0,0,'','',1,1,1),('form_files_add_entry','entry_content',10,10,'textarea',8,0,1,0,0,0,'','',1,1,0),('form_files_add_entry','intensity_of_wounds',20,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_files_add_entry','need_follow_up_treatment',30,20,'text',0,0,1,0,0,0,'','',1,1,0),('form_files_add_entry','treatment',30,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_files_add_entry','type_of_bleeding',20,20,'text',0,0,1,0,0,0,'','',1,1,0),('form_jobrank','label',10,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_mission_reports','involved_forces',20,20,'text',0,0,1,0,0,0,'','',1,1,1),('form_mission_reports','location',20,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_mission_reports','mission_content',30,10,'textarea',8,0,1,0,0,0,'','',1,1,1),('form_mission_reports','mission_date',10,20,'date',0,0,1,0,0,0,'','',1,1,1),('form_mission_reports','mission_reports_title',10,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_mission_reports','securety_level',40,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_officer','deleted',80,20,'text',0,0,0,1,0,0,'','',0,0,1),('form_officer','first_name',20,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_officer','last_name',20,20,'text',0,0,1,0,0,0,'','',1,1,1),('form_officer','loginname',10,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_officer','password',30,30,'password',0,0,1,0,0,0,'','',1,1,1),('form_officer','rankid',40,40,'text',0,0,1,0,0,0,'','',1,1,1),('form_officer','securety_level',50,50,'text',0,0,1,0,0,0,'officers','change_securety_level',1,1,1),('form_officer','suspended',80,10,'text',0,0,0,1,0,0,'','',0,0,1),('form_participent','employee_id',10,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_patrol','patrols_name',20,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_patrol','patrols_shortname',10,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_patrol','patrols_vehicle',30,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_patrol_area','name',10,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_patrol_status','patrol_status_color',30,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_patrol_status','patrol_status_name',10,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_patrol_status','patrol_status_shortname',20,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_personalfile_entry','personal_file_content',12,10,'textarea',12,0,1,0,0,0,'','',1,1,0),('form_personalfile_entry','personal_file_type',20,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_set_officer_patrol','Patrol_ID',10,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_set_officer_status','PatrolStatusID',10,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_set_patrol_area','patrol_area',10,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_set_patrol_status','patrol_status',10,10,'text',0,0,1,0,0,0,'','',1,1,0),('form_training','allow_officer_self_entry',50,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_training','instructor_id',70,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_training','min_rankid',50,20,'text',0,0,1,0,0,0,'','',1,1,1),('form_training','short_title',20,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_training','sorting',20,20,'number',0,0,1,0,0,0,'','',1,1,1),('form_training','title',10,10,'text',0,0,1,0,0,0,'','',1,1,1),('form_training','training_content',30,10,'textarea',8,0,1,0,0,0,'','',1,1,1),('form_usersettings','locale',10,10,'text',0,0,1,0,0,0,'','',1,1,0),('open_file','alias',10,20,'text',0,1,1,0,0,0,'','',0,0,0),('open_file','birthdate',30,20,'date',0,1,1,0,0,0,'','',0,0,0),('open_file','eye_color',40,10,'text',0,1,1,0,0,0,'','',0,0,0),('open_file','file_blackend',60,10,'number',0,1,1,1,0,0,'','',0,0,0),('open_file','file_closed',60,30,'number',0,1,1,1,0,0,'','',0,0,0),('open_file','file_deleted',60,20,'number',0,1,1,1,0,0,'','',0,0,0),('open_file','hair_color',40,20,'text',0,1,1,0,0,0,'','',0,0,0),('open_file','name',10,10,'text',0,1,1,0,0,0,'','',0,0,0),('open_file','phone',20,20,'text',0,1,1,0,0,0,'','',0,0,0),('open_file','securety_level',50,10,'text',0,1,1,0,0,0,'','',0,0,0),('open_file','sex',20,10,'text',0,1,1,0,0,0,'','',0,0,0),('open_file','size',30,10,'number',0,1,1,0,0,0,'','',0,0,0),('open_file','traffic_points',50,20,'number',0,1,1,0,0,0,'','',0,0,0),('show_vehicle','additional_info',40,20,'text',0,1,1,0,0,0,'','',0,0,0),('show_vehicle','mot',30,20,'date',0,1,1,0,0,0,'','',0,0,0),('show_vehicle','owner',20,20,'text',0,1,1,0,0,0,'','',0,0,0),('show_vehicle','plate',20,10,'text',0,1,1,0,8,8,'','',0,0,0),('show_vehicle','reason_of_is_wanted',10,10,'alert-danger',0,0,0,0,0,0,'','',0,0,0),('show_vehicle','vehicle',40,10,'text',0,1,1,0,0,0,'','',0,0,0),('show_vehicle','vehicle_type',30,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_criminal_charges','act_of_crime',50,10,'textarea',2,1,1,0,0,0,'','',0,0,0),('view_criminal_charges','complaint_reporter_ro',10,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_criminal_charges','notes',60,10,'textarea',2,1,0,0,0,0,'','',0,0,0),('view_criminal_charges','perpetrator_description',20,10,'textarea',2,1,1,0,0,0,'','',0,0,0),('view_criminal_charges','perpetrator_ro',10,20,'text',0,1,1,0,0,0,'','',0,0,0),('view_criminal_charges','securety_level',40,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_criminal_charges','status',40,20,'text',0,1,1,0,0,0,'','',0,0,0),('view_criminal_charges','violation_of',40,30,'text',0,1,1,0,0,0,'','',0,0,0),('view_investigation','closed',40,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_investigation','investigation_name',10,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_investigation','reason_of_investigation',20,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_investigation','securety_level',30,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_mission_reports','involved_forces',20,20,'text',0,1,1,0,0,0,'','',0,0,0),('view_mission_reports','location',20,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_mission_reports','mission_content',30,10,'textarea',8,1,1,0,0,0,'','',0,0,0),('view_mission_reports','mission_date',10,20,'date',0,1,1,0,0,0,'','',0,0,0),('view_mission_reports','mission_reports_title',10,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_mission_reports','securety_level',40,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_officer','deleted',60,20,'text',0,1,1,1,0,0,'','',0,0,0),('view_officer','first_name',20,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_officer','last_name',20,20,'text',0,1,1,0,0,0,'','',0,0,0),('view_officer','loginname',10,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_officer','rankid',30,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_officer','suspended',60,10,'text',0,1,1,1,0,0,'','',0,0,0),('view_training','allow_officer_self_entry',50,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_training','instructor_id_all',70,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_training','min_rankid',50,20,'text',0,1,1,0,0,0,'','',0,0,0),('view_training','short_title',20,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_training','sorting',20,20,'number',0,1,1,0,0,0,'','',0,0,0),('view_training','title',10,10,'text',0,1,1,0,0,0,'','',0,0,0),('view_training','training_content',30,10,'textarea',8,1,1,0,0,0,'','',0,0,0);
/*!40000 ALTER TABLE `__definition_formconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_function`
--

DROP TABLE IF EXISTS `__definition_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_function` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `doLoaddata` tinyint(1) NOT NULL DEFAULT 0,
  `doLoadData_NoID` tinyint(1) NOT NULL DEFAULT 0,
  `doLoadData_UseridAsId` tinyint(1) NOT NULL DEFAULT 0,
  `doSaveData` tinyint(1) NOT NULL DEFAULT 0,
  `doDeleteData` tinyint(1) NOT NULL DEFAULT 0,
  `DoDeleteData_InArchiv` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'table',
  `mysql_table` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `uniquecol` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `needsCount` tinyint(1) NOT NULL DEFAULT 0,
  `orderBy` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `extraColumnsStatement` varchar(1048) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `extraWhereStatement` varchar(1048) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `UseSmallView` tinyint(1) NOT NULL DEFAULT 0,
  `deactivated` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`function_name`),
  KEY `idx_deactivated` (`deactivated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_function`
--

LOCK TABLES `__definition_function` WRITE;
/*!40000 ALTER TABLE `__definition_function` DISABLE KEYS */;
INSERT INTO `__definition_function` VALUES ('archive',1,0,0,0,0,0,'table','','',0,'','','',0,0),('archive_details',1,0,0,0,0,0,'table','','',0,'','','',0,0),('control_centre',1,0,0,0,0,0,'table','','',1,'','','',0,0),('criminal_charges',1,0,0,0,1,1,'table','criminal_complaints','uid',1,'createddate desc','','WHERE (select count(*) from files where (files.uid = complaint_reporter OR files.uid = perpetrator)  and (file_deleted = 1 OR file_blackend = 1)) = 0',0,0),('custom_personal_file',0,0,0,0,0,0,'custom','','',0,'','','',0,0),('dashboard',0,0,0,0,0,0,'custom','','',0,'','','',0,0),('files',1,0,0,0,0,1,'table','files','uid',1,'name','','WHERE file_deleted = 0 AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',0,0),('form_files',0,0,0,1,0,0,'form','files','uid',0,'','','',0,0),('form_files_add_entry',0,0,0,1,0,0,'form','files_licenses_connection','license_uid',0,'','','',1,0),('form_jobrank',0,0,0,1,0,0,'form','job_grades','grade',0,'','','',0,0),('form_mission_reports',0,0,0,1,0,0,'form','mission_reports','uid',0,'','','',0,0),('form_officer',0,0,0,1,0,0,'form','registered_user','userid',0,'','','',0,0),('form_participent',0,0,0,1,0,0,'form','trainings_employees','uid',0,'','','',0,0),('form_passwordreset_foruser',0,0,0,0,0,0,'custom','','',0,'','','',0,0),('form_patrol',0,0,0,1,0,0,'form','patrols','uid',0,'','','',0,0),('form_patrol_area',0,0,0,1,0,0,'form','patrol_areas','uid',0,'','','',0,0),('form_patrol_status',0,0,0,1,0,0,'form','patrol_status','uid',0,'','','',0,0),('form_personalfile_entry',0,0,0,1,0,0,'form','personal_file','uid',0,'','','',0,0),('form_resetpassword',0,0,0,0,0,0,'custom','-','-',0,'','','',0,0),('form_set_officer_patrol',0,0,0,1,0,0,'form','registered_user','userid',0,'','','',0,0),('form_set_officer_status',0,0,0,1,0,0,'form','registered_user','userid',0,'','','',0,0),('form_set_patrol_area',0,0,0,1,0,0,'form','patrols','uid',0,'','','',0,0),('form_set_patrol_status',0,0,0,1,0,0,'form','patrols','uid',0,'','','',0,0),('form_training',0,0,0,1,0,0,'form','trainings','uid',0,'','','',0,0),('form_usersettings',1,1,1,1,0,0,'form','registered_user','userid',0,'','','',0,0),('form_vehicle',0,0,0,1,0,0,'form','registered_vehicle','uid',0,'','','',0,0),('group_management',1,0,0,0,1,1,'table','job_grades','grade',0,'grade','','where deleted = 0',0,0),('group_rights',1,0,0,0,0,0,'table','__definition_rights','uid',0,'sortorder','','',0,0),('investigation',1,0,0,0,1,1,'table','investigation','uid',1,'createddate DESC','','WHERE deleted = 0 AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',0,0),('licenses',1,0,0,0,1,0,'table','licenses','uid',0,'sortorder','','',0,0),('manhunt',1,0,0,0,0,0,'table','','',0,'','','',0,0),('mission_reports',1,0,0,0,1,1,'table','mission_reports','uid',1,'createddate DESC','','WHERE deleted = 0 AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',0,0),('officer_trainings',0,0,0,0,0,0,'custom','','',0,'','','',0,0),('officers',1,0,0,0,1,1,'table','registered_user','userid',1,'last_name,first_name','','WHERE rankid<>9999 and deleted = 0',0,0),('open_file',1,0,0,0,0,0,'form','files','uid',0,'','','WHERE file_deleted = 0 AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',1,0),('patrol_areas',1,0,0,0,1,0,'table','patrol_areas','uid',0,'','','',0,0),('patrol_status',1,0,0,0,1,0,'table','patrol_status','uid',1,'','','WHERE isHidden = 0',0,0),('patrols',1,0,0,0,1,0,'table','patrols','uid',1,'patrols_shortname','','',0,0),('penalties',0,0,0,0,1,1,'custom','law_books','uid',0,'law_books_name','','',0,0),('radio',1,0,0,0,0,0,'table','patrol_status','uid',0,'patrol_status_name','','WHERE isHidden = 0',0,0),('resetpassword',0,0,0,0,0,0,'custom','-','-',0,'','','',0,0),('settings',0,0,0,0,0,0,'custom','-','-',0,'','','',0,0),('show_vehicle',1,0,0,0,0,0,'form','registered_vehicle','uid',0,'','','WHERE deleted = 0',0,0),('training_participants',1,0,0,0,0,0,'table','trainings_employees','employee_id',1,'','','WHERE training_id = @@ID@@',0,0),('trainings',1,0,0,0,1,1,'table','trainings','uid',1,'createddate desc','','WHERE deleted =0',0,0),('vehicle_register',1,0,0,0,1,1,'table','registered_vehicle','uid',1,'plate','','WHERE deleted = 0',0,0),('view_criminal_charges',1,0,0,1,0,0,'form','criminal_complaints','uid',0,'','','WHERE securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',1,0),('view_criminal_complaints_byfile_0',1,0,0,0,0,0,'table','criminal_complaints','complaint_reporter',1,'createddate DESC','','WHERE complaint_reporter = @@ID@@ AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',0,0),('view_criminal_complaints_byfile_1',1,0,0,0,0,0,'table','criminal_complaints','perpetrator',1,'createddate DESC','','WHERE perpetrator = @@ID@@ AND status=1 WHERE complaint_reporter = @@ID@@ AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',0,0),('view_criminal_complaints_byfile_2',1,0,0,0,0,0,'table','criminal_complaints','perpetrator',1,'createddate DESC','','WHERE perpetrator = @@ID@@ AND status=2 WHERE complaint_reporter = @@ID@@ AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',0,0),('view_criminal_complaints_byfile_3',1,0,0,0,0,0,'table','criminal_complaints','perpetrator',1,'createddate DESC','','WHERE perpetrator = @@ID@@ AND status=3 WHERE complaint_reporter = @@ID@@ AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',0,0),('view_investigation',1,0,0,0,0,0,'form','investigation','uid',0,'','','WHERE deleted = 0 AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',0,0),('view_mission_reports',1,0,0,0,0,0,'form','mission_reports','uid',0,'','','WHERE deleted = 0 AND securety_level <= (select if(rankid = 9999, rankid, securety_level) from registered_user where userid = @@USERID@@)',0,0),('view_officer',1,0,0,0,0,0,'form','registered_user','userid',0,'','','WHERE deleted = 0',0,0),('view_training',1,0,0,0,0,0,'form','trainings','uid',0,'','','WHERE deleted =0',0,0);
/*!40000 ALTER TABLE `__definition_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_function_buttons`
--

DROP TABLE IF EXISTS `__definition_function_buttons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_function_buttons` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `button` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `goto_functionname` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `goto_functiontype` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `goto_functionname_idDefined` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `goto_functiontype_idDefined` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'bottom',
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `right_function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `right_sub_function` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `allowInAdd` tinyint(1) NOT NULL DEFAULT 0,
  `allowInEdit` tinyint(1) NOT NULL DEFAULT 0,
  `allowInView` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`function_name`,`button`),
  KEY `idx_disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_function_buttons`
--

LOCK TABLES `__definition_function_buttons` WRITE;
/*!40000 ALTER TABLE `__definition_function_buttons` DISABLE KEYS */;
INSERT INTO `__definition_function_buttons` VALUES ('archive_details','backButton','archive','','','bottom',0,'','',0,0,0),('criminal_charges','addButton','add_criminal_charges','','','bottom',0,'','',0,0,0),('criminal_charges','deleteButton','','','','bottom',0,'criminal_charges','delete',0,0,0),('criminal_charges','editButton','edit_criminal_charges','','','bottom',0,'','',0,0,0),('criminal_charges','viewButton','view_criminal_charges','','','bottom',0,'','',0,0,0),('files','addButton','form_files','add','','bottom',0,'files','add_edit',0,0,0),('files','editButton','form_files','edit','','bottom',0,'files','add_edit',0,0,0),('files','viewButton','form_files','view','','bottom',0,'files','view',0,0,0),('form_crime','CancelSaveButton','penalties','','','bottom',0,'','',0,0,0),('form_criminal_charges','CancelSaveButton','criminal_charges','','','bottom',0,'','',0,0,0),('form_files','CancelSaveButton','files','','','bottom',0,'','',1,1,0),('form_files','backButton','files','','','top',0,'files','view',0,0,1),('form_files','editButton','form_files','edit','','top',0,'files','add_edit',0,0,1),('form_investigation','CancelSaveButton','investigation','','','bottom',0,'','',0,0,0),('form_jobrank','CancelSaveButton','group_management','','','bottom',0,'group_management','add_edit',1,1,0),('form_lawbook','CancelSaveButton','penalties','','','bottom',0,'','',0,0,0),('form_licenses','CancelSaveButton','licenses','','','bottom',0,'','',0,0,0),('form_mission_reports','CancelSaveButton','mission_reports','','','bottom',0,'mission_reports','add_edit',1,1,0),('form_mission_reports','backButton','mission_reports','','','bottom',0,'mission_reports','view',0,0,1),('form_mission_reports','editButton','form_mission_reports','edit','','bottom',0,'mission_reports','add_edit',0,0,1),('form_officer','CancelSaveButton','officers','','','bottom',0,'','',1,1,0),('form_officer','backButton','officers','','','bottom',0,'','',0,0,1),('form_officer','editButton','form_officer','edit','','bottom',0,'officers','add_edit',0,0,1),('form_participants','backButton','training','view','','bottom',0,'','',0,0,0),('form_patrol','CancelSaveButton','patrols','','','bottom',0,'','',1,1,0),('form_patrol_area','CancelSaveButton','patrol_areas','','','bottom',0,'','',1,1,0),('form_patrol_status','CancelSaveButton','patrol_status','','','bottom',0,'patrol_status','add_edit',1,1,0),('form_personalfile_entry','CancelSaveButton','officers','','','bottom',0,'','',0,0,0),('form_set_officer_patrol','CancelSaveButton','control_centre','','','bottom',0,'','',1,1,0),('form_set_officer_status','CancelSaveButton','control_centre','','','bottom',0,'','',1,1,0),('form_set_patrol_area','CancelSaveButton','control_centre','','','bottom',0,'','',1,1,0),('form_set_patrol_status','CancelSaveButton','control_centre','','','bottom',0,'','',1,1,0),('form_training','CancelSaveButton','trainings','','','bottom',0,'trainings','add_edit',1,1,0),('form_training','backButton','trainings','','','bottom',0,'','',0,0,1),('form_training','editButton','form_training','edit','','bottom',0,'trainings','add_edit',0,0,1),('form_usersettings','CancelSaveButton','settings','','','bottom',0,'','',1,1,0),('form_vehicle','CancelSaveButton','vehicle_register','','','bottom',0,'','',0,0,0),('group_management','addButton','form_jobrank','','','bottom',0,'group_management','add_edit',0,0,0),('group_management','deleteButton','','','','bottom',0,'group_management','delete',0,0,0),('group_management','editButton','form_jobrank','edit','','bottom',0,'group_management','add_edit',0,0,0),('group_management','setRightsButton','group_rights','','','bottom',0,'group_management','add_edit',0,0,0),('group_rights','CancelSaveButton','group_management','','','bottom',0,'','',0,0,0),('investigation','addButton','add_investigation','','','bottom',0,'investigation','add_edit',0,0,0),('investigation','deleteButton','','','','bottom',0,'investigation','delete',0,0,0),('investigation','editButton','edit_investigation','','','bottom',0,'investigation','add_edit',0,0,0),('licenses','addButton','add_licenses','','','bottom',0,'licenses','add_edit',0,0,0),('licenses','deleteButton','','','','bottom',0,'licenses','delete',0,0,0),('licenses','editButton','edit_licenses','','','bottom',0,'licenses','add_edit',0,0,0),('mission_reports','addButton','form_mission_reports','add','','bottom',0,'mission_reports','add_edit',0,0,0),('mission_reports','deleteButton','','','','bottom',0,'mission_reports','delete',0,0,0),('mission_reports','editButton','form_mission_reports','edit','','bottom',0,'mission_reports','add_edit',0,0,0),('mission_reports','viewButton','form_mission_reports','view','','bottom',0,'mission_reports','view',0,0,0),('officers','addButton','form_officer','add','','bottom',0,'officers','add_edit',0,0,0),('officers','deleteButton','','','','bottom',0,'officers','delete',0,0,0),('officers','editButton','edit_officer','','','bottom',0,'officers','add_edit',0,0,0),('officers','viewButton','form_officer','','','bottom',0,'officers','view',0,0,0),('patrol_areas','addButton','form_patrol_area','add','','bottom',0,'patrols','add_edit',0,0,0),('patrol_areas','deleteButton','','','','bottom',0,'patrol_areas','delete',0,0,0),('patrol_areas','editButton','form_patrol_area','edit','','bottom',0,'patrol_areas','add_edit',0,0,0),('patrol_status','addButton','form_patrol_status','add','','bottom',0,'patrol_status','add_edit',0,0,0),('patrol_status','deleteButton','','','','bottom',0,'patrol_status','delete',0,0,0),('patrol_status','editButton','form_patrol_status','edit','','bottom',0,'patrol_status','add_edit',0,0,0),('patrols','addButton','form_patrol','add','','bottom',0,'patrols','add_edit',0,0,0),('patrols','deleteButton','','','','bottom',0,'patrols','delete',0,0,0),('patrols','editButton','form_patrol','edit','','bottom',0,'patrols','add_edit',0,0,0),('penalties','addButton','add_lawbook','','','bottom',0,'law_book','add_edit',0,0,0),('penalties','deleteButton','','','','bottom',0,'law_books','delete',0,0,0),('penalties','editButton','edit_lawbook','','','bottom',0,'law_book','add_edit',0,0,0),('resetpassword','CancelSaveButton','settings','','','bottom',0,'','',0,0,0),('show_vehicle','backButton','vehicle_register','','','bottom',0,'','',0,0,0),('show_vehicle','editButton','edit_vehicle','','','bottom',0,'vehicle_register','add_edit',0,0,0),('trainings','addButton','form_training','add','','bottom',0,'trainings','add_edit',0,0,0),('trainings','deleteButton','','','','bottom',0,'trainings','delete',0,0,0),('trainings','editButton','edit_training','','','bottom',0,'trainings','add_edit',0,0,0),('trainings','viewButton','form_training','view','','bottom',0,'trainings','view',0,0,0),('vehicle_register','addButton','add_vehicle','','','bottom',0,'vehicle_register','add_edit',0,0,0),('vehicle_register','deleteButton','','','','bottom',0,'vehicle_register','delete',0,0,0),('vehicle_register','editButton','edit_vehicle','','','bottom',0,'vehicle_register','add_edit',0,0,0),('vehicle_register','viewButton','show_vehicle','','','bottom',0,'vehicle_register','view',0,0,0),('view_criminal_charges','backButton','criminal_charges','','','bottom',0,'','',0,0,0),('view_criminal_charges','editButton','edit_criminal_charges','','','bottom',0,'','',0,0,0),('view_investigation','backButton','investigation','','','bottom',0,'','',0,0,0),('view_investigation','editButton','edit_investigation','','','bottom',0,'investigation','add_edit',0,0,0);
/*!40000 ALTER TABLE `__definition_function_buttons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_function_extra_selects`
--

DROP TABLE IF EXISTS `__definition_function_extra_selects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_function_extra_selects` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `extra_select` varchar(4096) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`function_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_function_extra_selects`
--

LOCK TABLES `__definition_function_extra_selects` WRITE;
/*!40000 ALTER TABLE `__definition_function_extra_selects` DISABLE KEYS */;
INSERT INTO `__definition_function_extra_selects` VALUES ('form_training',',instructor_id as instructor_id_all'),('group_rights',',IF(\'@@LOCALE@@\'=\'de\',name_de,name_en) AS name\n,(SELECT COUNT(*)>0 FROM group_rights WHERE rankid = @@ID@@ and right_id = __definition_rights.uid) as isSelected'),('mission_reports',',date(createddate) as createddate,date(changeddate)  as changeddate\n,(SELECT concat(last_name,\', \', first_name) from registered_user where userid = mission_reports.createdby) as createdby\n,(SELECT concat(last_name,\', \', first_name) from registered_user where userid = mission_reports.changedby) as changedby'),('officers',',IF(deleted = 1, 1, if(suspended = 1,2,0)) as _officer_status,userid as uid\n,IFNULL((select label from job_grades where grade = registered_user.rankid),\'\') as rankid'),('radio',',concat(uid, \'|\',IFNULL((SELECT PatrolStatusID FROM registered_user where userid = 1 AND PatrolStatusID >= 0),-9999),\'|\', IFNULL((SELECT patrol_status from patrols where patrol_status >= 0 AND uid =  (SELECT Patrol_ID FROM registered_user where userid = 1)),-9999)) as uid'),('training_participants',',concat(training_id,\'|\',employee_id,\'|\',passed) as passcolumn ,concat(training_id,\'|\',employee_id,\'|\',passed) as deletecolumn,(SELECT concat(last_name,\', \', first_name) from registered_user where userid = trainings_employees.employee_id) as employee_id'),('trainings',',concat(trainings.uid,\'|\',trainings.allow_officer_self_entry,\'|\',(SELECT count(*)>0 from trainings_employees where training_id = trainings.uid and employee_id = @@USERID@@)) as participate\n,(SELECT concat(last_name,\', \', first_name) from registered_user where userid = trainings.instructor_id) as instructor_id'),('vehicle_register',', is_wanted as vehicle_status'),('view_criminal_charges',',(select files.name from files where files.uid = criminal_complaints.complaint_reporter) as complaint_reporter_ro\n,IF(perpetrator <> 0 , (select files.name from files where files.uid = criminal_complaints.perpetrator) , IFNULL((\n		SELECT translation \n			FROM __definition_languages_values \n			WHERE programmtype = \'global\'\n				AND locale = \'@@LOCALE@@\'\n				AND keyvalue = \'unknown\')\n		,\'unknown\'\n	)) as perpetrator_ro'),('view_criminal_complaints_byfile_0',',(select files.name from files where files.uid = criminal_complaints.complaint_reporter) as complaint_reporter\n,IF(perpetrator <> 0 , \n	(select files.name from files where files.uid = criminal_complaints.perpetrator) \n	,IFNULL((\n		SELECT translation \n			FROM __definition_languages_values \n			WHERE programmtype = \'global\'\n				AND locale = \'@@LOCALE@@\'\n				AND keyvalue = \'unknown\')\n		,\'unknown\'\n	)\n) as perpetrator\n,(SELECT CONCAT(loginname,\'<br>\',first_name,\', \',last_name) from registered_user where userid = criminal_complaints.createdby) as createdby\n,(SELECT CONCAT(loginname,\'<br>\',first_name,\', \',last_name) from registered_user where userid = criminal_complaints.changedby) as changedby\n,(SELECT IFNULL(__definition_languages_values.translation, _defined_status.translation_key)  FROM _defined_status\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_status.translation_programmtype\n		AND keyvalue = _defined_status.translation_key\n	WHERE _defined_status.uid = criminal_complaints.status\n) as `status`'),('view_criminal_complaints_byfile_1',',(select files.name from files where files.uid = criminal_complaints.complaint_reporter) as complaint_reporter\n,IF(perpetrator <> 0 , \n	(select files.name from files where files.uid = criminal_complaints.perpetrator) \n	,IFNULL((\n		SELECT translation \n			FROM __definition_languages_values \n			WHERE programmtype = \'global\'\n				AND locale = \'@@LOCALE@@\'\n				AND keyvalue = \'unknown\')\n		,\'unknown\'\n	)\n) as perpetrator\n,(SELECT CONCAT(loginname,\'<br>\',first_name,\', \',last_name) from registered_user where userid = criminal_complaints.createdby) as createdby\n,(SELECT CONCAT(loginname,\'<br>\',first_name,\', \',last_name) from registered_user where userid = criminal_complaints.changedby) as changedby\n,(SELECT IFNULL(__definition_languages_values.translation, _defined_status.translation_key)  FROM _defined_status\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_status.translation_programmtype\n		AND keyvalue = _defined_status.translation_key\n	WHERE _defined_status.uid = criminal_complaints.status\n) as `status`'),('view_criminal_complaints_byfile_2',',(select files.name from files where files.uid = criminal_complaints.complaint_reporter) as complaint_reporter\n,IF(perpetrator <> 0 , \n	(select files.name from files where files.uid = criminal_complaints.perpetrator) \n	,IFNULL((\n		SELECT translation \n			FROM __definition_languages_values \n			WHERE programmtype = \'global\'\n				AND locale = \'@@LOCALE@@\'\n				AND keyvalue = \'unknown\')\n		,\'unknown\'\n	)\n) as perpetrator\n,(SELECT CONCAT(loginname,\'<br>\',first_name,\', \',last_name) from registered_user where userid = criminal_complaints.createdby) as createdby\n,(SELECT CONCAT(loginname,\'<br>\',first_name,\', \',last_name) from registered_user where userid = criminal_complaints.changedby) as changedby\n,(SELECT IFNULL(__definition_languages_values.translation, _defined_status.translation_key)  FROM _defined_status\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_status.translation_programmtype\n		AND keyvalue = _defined_status.translation_key\n	WHERE _defined_status.uid = criminal_complaints.status\n) as `status`'),('view_criminal_complaints_byfile_3',',(select files.name from files where files.uid = criminal_complaints.complaint_reporter) as complaint_reporter\n,IF(perpetrator <> 0 , \n	(select files.name from files where files.uid = criminal_complaints.perpetrator) \n	,IFNULL((\n		SELECT translation \n			FROM __definition_languages_values \n			WHERE programmtype = \'global\'\n				AND locale = \'@@LOCALE@@\'\n				AND keyvalue = \'unknown\')\n		,\'unknown\'\n	)\n) as perpetrator\n,(SELECT CONCAT(loginname,\'<br>\',first_name,\', \',last_name) from registered_user where userid = criminal_complaints.createdby) as createdby\n,(SELECT CONCAT(loginname,\'<br>\',first_name,\', \',last_name) from registered_user where userid = criminal_complaints.changedby) as changedby\n,(SELECT IFNULL(__definition_languages_values.translation, _defined_status.translation_key)  FROM _defined_status\n	LEFT JOIN __definition_languages_values ON __definition_languages_values.locale = \'@@LOCALE@@\'\n		AND programmtype = _defined_status.translation_programmtype\n		AND keyvalue = _defined_status.translation_key\n	WHERE _defined_status.uid = cr');
/*!40000 ALTER TABLE `__definition_function_extra_selects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_function_rights`
--

DROP TABLE IF EXISTS `__definition_function_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_function_rights` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `right_function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `right_sub_function` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`function_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_function_rights`
--

LOCK TABLES `__definition_function_rights` WRITE;
/*!40000 ALTER TABLE `__definition_function_rights` DISABLE KEYS */;
INSERT INTO `__definition_function_rights` VALUES ('add_crime','crimes','add_edit'),('add_criminal_charges','criminal_charges','add_edit'),('add_investigation','investigation','add_edit'),('add_investigation_entry','investigation_entries','add_edit'),('add_jobrank','group_management','add_edit'),('add_lawbook','law_books','add_edit'),('add_licenses','licenses','add_edit'),('add_mission_reports','mission_reports','add_edit'),('add_participent','personal_file','add_edit'),('add_patrol','patrols','add_edit'),('add_patrol_area','patrol_areas','add_edit'),('add_patrol_status','patrol_status','add_edit'),('add_personalfile_entry','personal_file','add_edit'),('add_training','trainings','add_edit'),('add_vehicle','vehicle_register','add_edit'),('archive','archiv','view'),('archive_details','archiv','view'),('control_centre','control_centre','view'),('criminal_charges','criminal_charges','view'),('dashboard','',''),('edit_crime','crimes','add_edit'),('edit_criminal_charges','criminal_charges','add_edit'),('edit_files','files','add_edit'),('edit_investigation','investigation','add_edit'),('edit_jobrank','group_management','add_edit'),('edit_lawbook','law_books','add_edit'),('edit_licenses','licenses','add_edit'),('edit_mission_reports','mission_reports','add_edit'),('edit_officer','officers','add_edit'),('edit_patrol','patrols','add_edit'),('edit_patrol_area','patrol_areas','add_edit'),('edit_patrol_status','patrol_status','add_edit'),('edit_training','trainings','add_edit'),('edit_vehicle','vehicle_register','add_edit'),('files','files','view'),('files_add_entry','file_entries','add_edit'),('form_files','files','add_edit'),('form_officer','officers','add_edit'),('group_management','group_management','view'),('group_rights','group_management','set_rights'),('investigation','investigation','view'),('licenses','licenses','view'),('manhunt','manhunt','view'),('mission_reports','mission_reports','view'),('officer_patrol','control_centre','set_officer_to_patrol'),('officer_status','control_centre','set_officer_status'),('officer_trainings','training_participants','view'),('officers','officers','view'),('open_file','files','view'),('passwordreset_foruser','officers','add_edit'),('patrol_areas','patrol_areas','view'),('patrol_status','patrol_status','view'),('patrols','patrols','view'),('penalties','law_books','view'),('radio','radio','view'),('resetpassword','',''),('set_patrol_area','control_centre','set_patrol_area'),('set_patrol_status','control_centre','set_patrol_status'),('settings','',''),('show_vehicle','vehicle_register','view'),('trainings','trainings','view'),('usersettings','',''),('vehicle_register','vehicle_register','view'),('view_criminal_charges','criminal_charges','view'),('view_criminal_complaints_byfile_0','criminal_charges','view'),('view_criminal_complaints_byfile_1','criminal_charges','view'),('view_criminal_complaints_byfile_2','criminal_charges','view'),('view_criminal_complaints_byfile_3','criminal_charges','view'),('view_investigation','investigation','view'),('view_mission_reports','mission_reports','view'),('view_officer','officers','view'),('view_participants','training_participants','view'),('view_personal_file','personal_file','view'),('view_training','trainings','view');
/*!40000 ALTER TABLE `__definition_function_rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_languages`
--

DROP TABLE IF EXISTS `__definition_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_languages` (
  `locale` varchar(3) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `name` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_languages`
--

LOCK TABLES `__definition_languages` WRITE;
/*!40000 ALTER TABLE `__definition_languages` DISABLE KEYS */;
INSERT INTO `__definition_languages` VALUES ('de','Deutsch'),('en','English');
/*!40000 ALTER TABLE `__definition_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_languages_values`
--

DROP TABLE IF EXISTS `__definition_languages_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_languages_values` (
  `locale` varchar(3) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `programmtype` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `keyvalue` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`locale`,`programmtype`,`keyvalue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_languages_values`
--

LOCK TABLES `__definition_languages_values` WRITE;
/*!40000 ALTER TABLE `__definition_languages_values` DISABLE KEYS */;
INSERT INTO `__definition_languages_values` VALUES ('de','archive','files','Akten'),('de','archive','files_entries','Akteneinträge'),('de','archive','investigation','Ermittlungen'),('de','archive','job_grades','Ränge/Gruppen'),('de','archive','law_books','Gesetzbücher'),('de','archive','lawbook_laws','Straftaten'),('de','archive','mission_reports','Einsatzberichte'),('de','archive','personal_file','Personalakte'),('de','archive','registered_user','Polizisten'),('de','archive','registered_vehicle','Fahrzeuge'),('de','archive','trainings','Ausbildungen'),('de','colors','black','Schwarz'),('de','colors','blue','Blau'),('de','colors','dark_red','Dunkelrot'),('de','colors','gray','Grau'),('de','colors','green','Grün'),('de','colors','orange','Orange'),('de','colors','pink','Pink'),('de','colors','red','Rot'),('de','columns','Count','Anzahl'),('de','columns','Patrol_ID','Streife'),('de','columns','Type','Bereich'),('de','columns','_action','#'),('de','columns','_officer_status','Status'),('de','columns','act_of_crime','Tatvorgang'),('de','columns','additional_info','Sonstiges'),('de','columns','alias','Spitzname'),('de','columns','allow_officer_self_entry','Polizistens dürfen selbst eintragen?'),('de','columns','birthdate','Geburtsdatum'),('de','columns','changedby','Geändert von'),('de','columns','changedby_name','Geändert von'),('de','columns','changeddate','Geändert am'),('de','columns','closed','Geschlossen'),('de','columns','complaint_reporter','Anzeige von'),('de','columns','complaint_reporter_name','Anzeige von'),('de','columns','complaint_reporter_ro','Anzeige von'),('de','columns','completed','Abgeschlossen'),('de','columns','createdby','Erstellt von'),('de','columns','createdby_name','Erstellt von'),('de','columns','createddate','Erstellt am'),('de','columns','crime','Straftat'),('de','columns','crimes','Strafen'),('de','columns','deletecolumn','#'),('de','columns','deleted','Gelöscht'),('de','columns','detention_time','Hafteinheiten'),('de','columns','employee_id','Mitarbeiter'),('de','columns','entry_content','Inhalt'),('de','columns','eye_color','Augenfarbe'),('de','columns','file_blackend','Geschwärzt'),('de','columns','file_closed','Geschlossen'),('de','columns','file_deleted','Gelöscht'),('de','columns','file_entries_0','-'),('de','columns','file_entries_1','-'),('de','columns','file_entry_number','Eintragsnummer'),('de','columns','file_is_wanted','Fahndung'),('de','columns','file_number','Aktennummer'),('de','columns','file_status','Status'),('de','columns','fine','Geldstrafe (€)'),('de','columns','first_name','Vorname'),('de','columns','fullname','Name'),('de','columns','grade','#'),('de','columns','hair_color','Haarfarbe'),('de','columns','in_progress','In Bearbeitung'),('de','columns','information','Info'),('de','columns','instructor_id','Ausbilder'),('de','columns','instructor_id_all','Ausbilder'),('de','columns','intensity_of_wounds','Intensität der Wunden'),('de','columns','investigation_name','Bezeichnung'),('de','columns','involved_forces','Beteiligte Einsatzkräfte'),('de','columns','isSelected','Gewählt'),('de','columns','is_dead','Ist Tot?'),('de','columns','is_gangmember','Ist Gangmitglied?'),('de','columns','is_important_entry','Wichtiger Eintrag?'),('de','columns','is_violent','Ist Gewaltätig?'),('de','columns','is_wanted','Fahndung?'),('de','columns','label','Rangbezeichnung'),('de','columns','last_name','Nachname'),('de','columns','law_books_name','Bezeichnung'),('de','columns','law_books_shortname','Kurzbezeichnung'),('de','columns','lawbook_id','Gesetzbuch'),('de','columns','license_givenby','Erteilt von'),('de','columns','licensename','Lizenz'),('de','columns','locale','Sprache'),('de','columns','location','Einsatzort'),('de','columns','loginname','Dienstnummer'),('de','columns','min_rankid','Rang (min)'),('de','columns','minimum_penalty','Geldstrafe (min.)'),('de','columns','mission_content','Einsatzbericht'),('de','columns','mission_date','Einsatzdatum'),('de','columns','mission_reports_title','Bezeichnung'),('de','columns','mot','TÜV bis'),('de','columns','name','Name'),('de','columns','need_follow_up_treatment','Nachbehandlung nötig?'),('de','columns','notes','Notizen'),('de','columns','officer_entered','Eingetragen'),('de','columns','officer_passed','Bestanden'),('de','columns','officer_status_info','Status info'),('de','columns','others','Sonstiges'),('de','columns','owner','Besitzer'),('de','columns','paragraph','Paragraph'),('de','columns','participate','Teilnehmen'),('de','columns','passcolumn','Bestanden?'),('de','columns','password','Passwort'),('de','columns','patrol_area','Gebiet'),('de','columns','patrol_officers','Polizist(en)'),('de','columns','patrol_status','Status'),('de','columns','patrol_status_color','Farbe'),('de','columns','patrol_status_info','Status info'),('de','columns','patrol_status_name','Bezeichnung'),('de','columns','patrol_status_shortname','Kurzbezeichnung'),('de','columns','patrol_vehicle','Fahrzeug'),('de','columns','patrols_name','Bezeichnung'),('de','columns','patrols_shortname','Kurzbezeichnung'),('de','columns','patrols_shortname_tableheader','Kurz Bez.'),('de','columns','patrols_vehicle','Fahrzeug'),('de','columns','perpetrator','Täter'),('de','columns','perpetrator_description','Täter Beschreibung'),('de','columns','perpetrator_name','Täter'),('de','columns','perpetrator_ro','Täter'),('de','columns','personal_file_content','Inhalt'),('de','columns','personal_file_type','Art des Eintrags'),('de','columns','phone','Telefon-Nr.'),('de','columns','plate','Kennzeichen'),('de','columns','rankid','Rang'),('de','columns','reason_of_investigation','Grund'),('de','columns','reason_of_is_wanted','Grund der Fahndung'),('de','columns','reporter','Anzeigesteller'),('de','columns','road_traffic_regulations_points','Verkehrspunkte'),('de','columns','securety_level','Sicherheitsstufe'),('de','columns','sex','Geschlecht'),('de','columns','short_title','Kurzbezeichnung'),('de','columns','size','Größe'),('de','columns','sorting','Sortierung'),('de','columns','sortorder','Sortierung'),('de','columns','status','Status'),('de','columns','suspended','Suspendiert'),('de','columns','title','Bezeichnung'),('de','columns','traffic_points','Verkehrspunkte'),('de','columns','training_content','Inhalt'),('de','columns','treatment','Behandlung'),('de','columns','type_of_bleeding','Art der Blutung'),('de','columns','type_of_entry','Art d. Eintrags'),('de','columns','uid','#'),('de','columns','unedited','Unbearbeitet'),('de','columns','values','Werte'),('de','columns','vehicle','Fahrzeug'),('de','columns','vehicle_status','Status'),('de','columns','vehicle_type','Fahrzeugtyp'),('de','columns','violation_of','Verstoß gegen'),('de','columns','wanting_type','Fahndungstyp'),('de','control_centre','current','Aktuelle Leitstelle'),('de','control_centre','none','Keine Leitstelle aktiv!'),('de','control_centre','patrol_reset','Zurücksetzen'),('de','control_centre','patrol_reset_all','Streifen zurücksetzen'),('de','control_centre','reset','Leiststelle zurücksetzen'),('de','control_centre','set_area','Gebiet setzen'),('de','control_centre','set_patrol','Streife setzen'),('de','control_centre','set_status','Status setzen'),('de','control_centre','take','Leistelle übernehmen'),('de','crime','no_crime_deposited','Keine Straftat hinterlegt'),('de','crimes','detention_time','Hafteinheiten'),('de','crimes','fine','Geldstrafe (€)'),('de','crimes','penalties_imposed','verhängte Strafen'),('de','dashboard','count_files','Anzahl Akten'),('de','dashboard','count_files_currently','Anzahl Akten (aktuell)'),('de','dashboard','count_manhunt','Fahndungen'),('de','dashboard','count_officers','Polizisten (Gesamt)'),('de','dashboard','count_open_investigations','Offene Ermittlungen'),('de','dashboard','count_vehicles','Anzahl Fahrzeuge'),('de','dashboard','created_datasets','Erstellte Einträge'),('de','dashboard','current_control_centre','Leistelle'),('de','dashboard','current_control_centre_none','Keine'),('de','dashboard','includes_deleted','(inkl. gelöschte)'),('de','dashboard','last_month','Letzten Monat'),('de','dashboard','last_week','Heute -7 Tage'),('de','dashboard','officer_in_duty','Polizisten im Dienst'),('de','extrabutton','add_entry','Eintrag hinzufügen'),('de','extrabutton','add_investigation_entry','Eintrag hinzufügen'),('de','extrabutton','add_participent','Teilnehmer hinzufügen'),('de','extrabutton','cancel','Abbrechen'),('de','extrabutton','close_investigation','Schließen'),('de','extrabutton','delete_activate_user','Löschen'),('de','extrabutton','delete_activate_user_0','Löschen'),('de','extrabutton','delete_activate_user_1','Aktivieren'),('de','extrabutton','end_service','Dienst beenden'),('de','extrabutton','files_delete','Löschen'),('de','extrabutton','files_delete_0','Löschen'),('de','extrabutton','files_delete_1','Wiederherstellen'),('de','extrabutton','files_set_blackend','Schwärzen'),('de','extrabutton','files_set_blackend_0','Schwärzen'),('de','extrabutton','files_set_blackend_1','Entschwärzen'),('de','extrabutton','files_set_closed','Schließen'),('de','extrabutton','files_set_closed_0','Schließen'),('de','extrabutton','files_set_closed_1','Wiederöffnen'),('de','extrabutton','group_management','Zurück'),('de','extrabutton','investigation_set_closed_0','Schließen'),('de','extrabutton','investigation_set_closed_1','Öffnen'),('de','extrabutton','leave_patrol','Streife verlassen'),('de','extrabutton','navigate_back','Zurück'),('de','extrabutton','passwordreset','Passwort zurücksetzen'),('de','extrabutton','save','Speichern'),('de','extrabutton','save_participant','Teilnehmer speichern'),('de','extrabutton','suspend_unsuspend_user','Suspendieren'),('de','extrabutton','suspend_unsuspend_user_0','Suspendieren'),('de','extrabutton','suspend_unsuspend_user_1','Einstellen'),('de','extrabutton','user_set_deleted_0','Löschen'),('de','extrabutton','user_set_deleted_1','Aktivieren'),('de','extrabutton','user_set_suspended_0','Suspendieren'),('de','extrabutton','user_set_suspended_1','Einstellen'),('de','extrabutton','view_officertrainings','Ausbildungen'),('de','extrabutton','view_participants','Teilnehmer anzeigen'),('de','extrabutton','view_personal_file','Personalakte anzeigen'),('de','file_entry_types','fine_crime','Busgeld/Straftat'),('de','file_entry_types','neutral','Neutral'),('de','file_entry_types','positive','Positiv'),('de','files','add_license_to_file','Lizenz erteilen'),('de','files','criminal_complaints_overview','Übersicht Anzeigen'),('de','files','entry_done','Erledigt'),('de','files','existing_injuries','vorhandene Verletzungen'),('de','files','file_entry_number','Eintragsnummer'),('de','files','injuries','Verletzungen'),('de','files','injury_types','Verletzungsarten'),('de','files','marked_as','Gekennzeichnet als'),('de','files','marked_dead','Tot'),('de','files','marked_gangmember','Gangmitglied'),('de','files','marked_violent','Gewaltätig'),('de','files','name','Name'),('de','files','no_licenses_granted','Es wurden noch keine Lizenzen erteilt.'),('de','files','overview_all_licenses','Übersicht Lizenzen'),('de','files','post_treatment','Nachbehandlung'),('de','files','remove_license','Entziehen'),('de','files','title_file_entries','Übersicht Akteneinträge'),('de','global','add_crime','Straftat hinzufügen'),('de','global','add_criminal_charges','Stafanzeige hinzufügen'),('de','global','add_entry','Eintrag hinzufügen'),('de','global','add_files','Akte hinzufügen'),('de','global','add_investigation_entry','Eintrag hinzufügen'),('de','global','add_jobrank','Rang/Gruppe hinzufügen'),('de','global','add_lawbook','Gesetzbuch hinzufügen'),('de','global','add_licenses','Lizenz hinzufügen'),('de','global','add_mission_reports','Einsatzberichte hinzufügen'),('de','global','add_officer','Polizist hinzufügen'),('de','global','add_participent','Teilnehmer hinzufügen'),('de','global','add_patrol','Streife hinzufügen'),('de','global','add_patrol_area','Streifengebiet hinzufügen'),('de','global','add_patrol_status','Funkstatus hinzufügen'),('de','global','add_personalfile_entry','Eintrag hinzufügen'),('de','global','add_training','Ausbildung hinzufügen'),('de','global','add_vehicle','Fahrzeug hinzufügen'),('de','global','archive','Archiv'),('de','global','archive_details','Archiv Info'),('de','global','automatic_created','Automatisch'),('de','global','cancel','Abbrechen'),('de','global','complete','Abschließen'),('de','global','completed','Abgeschlossen'),('de','global','control_centre','Leitstelle'),('de','global','createdby','Erstellt von'),('de','global','createddate','Erstellt am'),('de','global','criminal_charges','Strafanzeigen'),('de','global','dashboard','Übersicht'),('de','global','delete','Löschen'),('de','global','edit','Bearbeiten'),('de','global','edit_crime','Straftat bearbeiten'),('de','global','edit_criminal_charges','Strafanzeige bearbeiten'),('de','global','edit_files','Akte bearbeiten'),('de','global','edit_investigation','Ermittlung bearbeiten'),('de','global','edit_lawbook','Gesetzbuch bearbeiten'),('de','global','edit_licenses','Lizenz bearbeiten'),('de','global','edit_mission_reports','Einsatzbericht bearbeiten'),('de','global','edit_officer','Polizist bearbeiten'),('de','global','edit_patrol','Streife Bearbeiten'),('de','global','edit_patrol_area','Streifengebiet bearbeiten'),('de','global','edit_patrol_status','Funkstatus bearbeiten'),('de','global','edit_training','Ausbildung Bearbeiten'),('de','global','edit_vehicle','Fahrzeug Bearbeiten'),('de','global','employees','Mitarbeiter'),('de','global','files','Akten'),('de','global','files_add_entry','Akteneintrag hinzufügen'),('de','global','group_management','Gruppenmanagement'),('de','global','group_management_settings','Gruppen verwalten'),('de','global','group_rights','Rechte setzen'),('de','global','information','Info'),('de','global','investigation','Ermittlungen'),('de','global','license_settings','Lizenzen verwalten'),('de','global','licenses','Lizenzverwaltung'),('de','global','management','Verwaltung'),('de','global','manhunt','Fahndungen'),('de','global','max_length','Max. Länge'),('de','global','menu','Menü'),('de','global','min_length','Min. Länge'),('de','global','mission_reports','Einsatzberichte'),('de','global','navigate_back','Zurück'),('de','global','network','Netzwerk'),('de','global','next','Weiter'),('de','global','no','Nein'),('de','global','no_data','Keine Daten'),('de','global','no_data_to_display','Keine Daten gefunden!'),('de','global','no_data_to_display_changepage','Bitte Seite verlassen!'),('de','global','notes','Notes'),('de','global','officer_patrol','Streife setzen'),('de','global','officer_status','Status setzen'),('de','global','officer_trainings','Ausbildungen'),('de','global','officers','Polizisten'),('de','global','open_file','Akte anzeigen'),('de','global','others','Sonstiges'),('de','global','passwordreset_foruser','Passwort zurücksetzen'),('de','global','passworts_not_match','Passwörter stimmen nicht überein!'),('de','global','patrol_areas','Streifengebiete'),('de','global','patrol_status','Funkstatus'),('de','global','patrols','Streifen'),('de','global','penalties','Gesetzbücher'),('de','global','quicksearch','Suche'),('de','global','radio','Funk'),('de','global','radio_traffic','Funkverkehr'),('de','global','recover','Wiederherstellen'),('de','global','resetpassword','Passwort zurücksetzen'),('de','global','save','Speichern'),('de','global','set_patrol_area','Streifengebiet setzen'),('de','global','set_patrol_status','Status setzen'),('de','global','settings','Einstellungen'),('de','global','show_vehicle','Fahrzeug'),('de','global','showentities','@@from@@ - @@to@@ von @@totalcount@@ Einträgen'),('de','global','status_deleted','Gelöscht'),('de','global','status_suspended','Suspendiert'),('de','global','system','System'),('de','global','trainings','Ausbildungen'),('de','global','traning','Ausbildungen'),('de','global','unknown','Unbekannt'),('de','global','usersettings','Benutzereinstellungen'),('de','global','vehicle_register','KFZ-Register'),('de','global','view','Anzeigen'),('de','global','view_criminal_charges','Strafanzeigen anzeigen'),('de','global','view_criminal_complaints_byfile_0','Anzeigen - Gestellte Strafanzeigen'),('de','global','view_criminal_complaints_byfile_1','Anzeigen - Als Täter - unbearbeitet'),('de','global','view_criminal_complaints_byfile_2','Anzeigen - Als Täter - in Bearbeitung'),('de','global','view_criminal_complaints_byfile_3','Anzeigen - Als Täter - Geschlossen'),('de','global','view_investigation','Ermittlung anzeigen'),('de','global','view_mission_reports','Einsatzbericht anzeigen'),('de','global','view_officer','Polizist anzeigen'),('de','global','view_participants','Teilnehmer ansicht'),('de','global','view_personal_file','Personalakte'),('de','global','view_training','Ausbildung'),('de','global','yes','Ja'),('de','global_status','status_closed','Geschlossen'),('de','global_status','status_inprogress','In Bearbeitung'),('de','global_status','status_unedited','Unbearbeitet'),('de','group_management','set_rights','Rechte setzen'),('de','injuries','head','Kopf'),('de','injuries','hip','Hüfte'),('de','injuries','left_arm','Linker Arm'),('de','injuries','left_foot','Linker Fuß'),('de','injuries','left_leg','Linkes Bein'),('de','injuries','neck','Hals'),('de','injuries','right_arm','Rechter Arm'),('de','injuries','right_foot','Rechter Fuß'),('de','injuries','right_leg','Rechtes Bein'),('de','injuries','stomach','Bauch'),('de','injuries','torso','Oberkörper'),('de','investigation','reason_of_investigation','Name der Ermittlung'),('de','lawbook','edit','Gesetzbuch bearbeiten'),('de','manhunt','_action','#'),('de','manhunt','active_manhunt','aktive Fahndung'),('de','manhunt','crimes','Stafen'),('de','manhunt','end_is_wanted','Fahndung beenden'),('de','manhunt','headline','Gesucht'),('de','manhunt','information','Info'),('de','manhunt','is_wanted','Gesucht'),('de','manhunt','is_wanted_additional_info','Bei Sichtung sofort melden! Andernfalls muss mit Konsequenzen gerechnet werden!'),('de','manhunt','is_wanted_reason_unknown','Unbekannt'),('de','manhunt','old_manhunt','Alte Fahndung'),('de','manhunt','person_is_wanted_by','Zur Fahndung ausgeschrieben von'),('de','manhunt','reason','Grund:'),('de','manhunt','status_is_wanted','Gesucht'),('de','manhunt','status_not_wanted','Nicht gesucht'),('de','manhunt','wanted_since','Gesucht seit'),('de','manhunt','wanting_type','Fahndungstyp'),('de','manhunt','wanting_type_file','Person'),('de','manhunt','wanting_type_vehicle','KFZ'),('de','pageloader','archive','Archiv'),('de','pageloader','archive_details','Archivdaten'),('de','pageloader','control_centre','Leiststelle'),('de','pageloader','custom_personal_file','Personalakte einsehen'),('de','pageloader','dashboard','Dashboard'),('de','pageloader','files','Akten'),('de','pageloader','form_files_add','Akte hinzufügen'),('de','pageloader','form_files_add_entry_add','Akteneintrag hinzufügen'),('de','pageloader','form_files_edit','Akte bearbeiten'),('de','pageloader','form_files_view','Einsatzbericht hinzufügen'),('de','pageloader','form_jobrank_add','Gruppe hinzufügen'),('de','pageloader','form_jobrank_edit','Gruppe bearbeiten'),('de','pageloader','form_mission_reports_add','Einsatzbericht hinzufügen'),('de','pageloader','form_mission_reports_edit','Einsatzbericht bearbeiten'),('de','pageloader','form_mission_reports_view','Einsatzbericht ansehen'),('de','pageloader','form_officer_add','Mitarbeiter hinzufügen'),('de','pageloader','form_officer_view','Mitarbeiter ansicht'),('de','pageloader','form_participent_add','Mitarbeiter zu Ausbildung eintragen'),('de','pageloader','form_passwordreset_foruser','Passwort ändern'),('de','pageloader','form_patrol_add','Einsatzfahrzeug hinzufügen'),('de','pageloader','form_patrol_edit','Einsatzfahrzeug bearbeiten'),('de','pageloader','form_patrol_status_add','Funkstatus hinzufügen'),('de','pageloader','form_patrol_status_edit','Funkstatus bearbeiten'),('de','pageloader','form_personalfile_entry_add','Eintrag hinzufügen'),('de','pageloader','form_resetpassword','Passwort ändern'),('de','pageloader','form_training_add','Ausbildung hinzufügen'),('de','pageloader','form_training_edit','Ausbuldung bearbeiten'),('de','pageloader','form_training_view','Ausbuldung ansehen'),('de','pageloader','form_usersettings_edit','Meine Einstellungen'),('de','pageloader','group_management','Gruppenmanagement'),('de','pageloader','group_rights','Rechte setzen'),('de','pageloader','mission_reports','Einsatzberichte'),('de','pageloader','officer_trainings','Mitarbeiterausbildungen'),('de','pageloader','officers','Mitarbeiter'),('de','pageloader','patrol_status','Funkstatus'),('de','pageloader','patrols','Einsatzfahrzeuge'),('de','pageloader','radio','Funk'),('de','pageloader','settings','Einstellungen'),('de','pageloader','training_participants','Mitarbeiter für Ausbildung'),('de','pageloader','trainings','Ausbildung'),('de','password','confirm_password','Passwort wiederholen'),('de','password','password','Passwort'),('de','password','password_policy_error','Passwortrichtlinie nicht eingehalten:'),('de','password','passworts_not_match','Passwörter stimmen nicht überein'),('de','password','pwd_require_special_char','Mindestens ein Sonderzeichen'),('de','password','pwd_requires_capital_letter','Mindestens ein Großbuchstabe'),('de','password','pwd_requires_digit','Miindestens eine Zahl'),('de','patrol_status','off_duty','Außer Dienst'),('de','patrol_status','radio_offline','Funk offline'),('de','personal_file_types','negativ','Negativ'),('de','personal_file_types','note','Notiz'),('de','personal_file_types','positive','Positiv'),('de','radio','current_patrol','Aktuelle Streife'),('de','radio','current_status_of_patrol','Aktueller Status der Streife:'),('de','radio','current_status_of_user','Aktueller Status:'),('de','radio','set_status','Status setzen'),('de','registered_vehicle','owner','Besitzer'),('de','registered_vehicle','plate','Kennzeichen'),('de','registered_vehicle','vehicle','Fahrzeug'),('de','registered_vehicle','vehicle_type','Fahrzeugtyp'),('de','sex','diverse','divers'),('de','sex','female','weiblich'),('de','sex','male','männlich'),('de','sex','unknown','Unbekannt'),('de','trainings','allow_officer_self_entry','Polizisten dürfen selbst eintragen'),('de','trainings','participate','Teilnehmen'),('en','archive','files','Files'),('en','archive','files_entries','File entries'),('en','archive','investigation','Investigations'),('en','archive','job_grades','Ranks/Groups'),('en','archive','law_books','Law Looks'),('en','archive','lawbook_laws','Crimes'),('en','archive','mission_reports','Mission reports'),('en','archive','personal_file','Personal file'),('en','archive','registered_user','Officers'),('en','archive','registered_vehicle','Vehicles'),('en','archive','trainings','Trainings'),('en','colors','black','Black'),('en','colors','blue','Blue'),('en','colors','dark_red','Dark red'),('en','colors','gray','Gray'),('en','colors','green','Green'),('en','colors','orange','Orange'),('en','colors','pink','Pink'),('en','colors','red','Red'),('en','columns','Count','Count'),('en','columns','Patrol_ID','Patrol'),('en','columns','Type','Area'),('en','columns','_action','#'),('en','columns','_officer_status','Status'),('en','columns','act_of_crime','Act of crime'),('en','columns','additional_info','Other'),('en','columns','alias','Alias'),('en','columns','allow_officer_self_entry','Allow officer self entry'),('en','columns','birthdate','Date of birth'),('en','columns','changedby','Changed by'),('en','columns','changedby_name','Changed by'),('en','columns','changeddate','Changed on'),('en','columns','closed','Closed'),('en','columns','complaint_reporter','Reported by'),('en','columns','complaint_reporter_name','Reported by'),('en','columns','complaint_reporter_ro','Reported by'),('en','columns','completed','Completed'),('en','columns','createdby','Created by'),('en','columns','createdby_name','Created by'),('en','columns','createddate','Created on'),('en','columns','crime','Crime'),('en','columns','crimes','Crimes'),('en','columns','deletecolumn','#'),('en','columns','deleted','Deleted'),('en','columns','detention_time','Detention units'),('en','columns','employee_id','Employee'),('en','columns','entry_content','Content'),('en','columns','eye_color','Eye colour'),('en','columns','file_blackend','Blackened'),('en','columns','file_closed','Closed'),('en','columns','file_deleted','Deleted'),('en','columns','file_entries_0','-'),('en','columns','file_entries_1','-'),('en','columns','file_entry_number','Entry number'),('en','columns','file_is_wanted','Manhunt'),('en','columns','file_number','File number'),('en','columns','file_status','Status'),('en','columns','fine','Fine (€)'),('en','columns','first_name','First name'),('en','columns','fullname','Name'),('en','columns','grade','#'),('en','columns','hair_color','Hair colour'),('en','columns','in_progress','In progress'),('en','columns','information','Info'),('en','columns','instructor_id','Instructor'),('en','columns','instructor_id_all','Instructor'),('en','columns','intensity_of_wounds','Intensity of wounds'),('en','columns','investigation_name','Description'),('en','columns','involved_forces','Involved forces'),('en','columns','isSelected','Selected'),('en','columns','is_dead','Is dead?'),('en','columns','is_gangmember','Is gangmember?'),('en','columns','is_important_entry','Important entry?'),('en','columns','is_violent','Is violent?'),('en','columns','is_wanted','Manhunt?'),('en','columns','label','Rank description'),('en','columns','last_name','Last name'),('en','columns','law_books_name','Description'),('en','columns','law_books_shortname','Short name'),('en','columns','lawbook_id','Law book'),('en','columns','license_givenby','Granted by'),('en','columns','licensename','Licence'),('en','columns','locale','Language'),('en','columns','location','Location'),('en','columns','loginname','Service number'),('en','columns','min_rankid','Min. rank'),('en','columns','minimum_penalty','Fine (min.)'),('en','columns','mission_content','Report'),('en','columns','mission_date','Deployment date'),('en','columns','mission_reports_title','Description'),('en','columns','mot','MOT till'),('en','columns','name','Name'),('en','columns','need_follow_up_treatment','Needs follow up treatment?'),('en','columns','notes','Notes'),('en','columns','officer_entered','Enter'),('en','columns','officer_passed','Passed'),('en','columns','officer_status_info','Status info'),('en','columns','others','Other'),('en','columns','owner','Owner'),('en','columns','paragraph','Paragraph'),('en','columns','participate','Participate'),('en','columns','passcolumn','Passed?'),('en','columns','password','Password'),('en','columns','patrol_area','Area'),('en','columns','patrol_officers','Officers'),('en','columns','patrol_status','Status'),('en','columns','patrol_status_color','Colour'),('en','columns','patrol_status_info','Status info'),('en','columns','patrol_status_name','Description'),('en','columns','patrol_status_shortname','Short name'),('en','columns','patrol_vehicle','Vehicle'),('en','columns','patrols_name','Description'),('en','columns','patrols_shortname','Short name'),('en','columns','patrols_shortname_tableheader','Short name'),('en','columns','patrols_vehicle','Vehicle'),('en','columns','perpetrator','Perpetrator'),('en','columns','perpetrator_description','Perpetrator description'),('en','columns','perpetrator_name','Perpetrator'),('en','columns','perpetrator_ro','Perpetrator'),('en','columns','personal_file_content','Content'),('en','columns','personal_file_type','Type of entry'),('en','columns','phone','Phone'),('en','columns','plate','Plate'),('en','columns','rankid','Rank'),('en','columns','reason_of_investigation','Reason'),('en','columns','reason_of_is_wanted','Reason for the manhunt'),('en','columns','reporter','Reporter'),('en','columns','road_traffic_regulations_points','Traffic Points'),('en','columns','securety_level','Security level'),('en','columns','sex','Gender'),('en','columns','short_title','Short name'),('en','columns','size','Size'),('en','columns','sorting','Sorting'),('en','columns','sortorder','Sorting'),('en','columns','status','Status'),('en','columns','suspended','Suspended'),('en','columns','title','Description'),('en','columns','traffic_points','Traffic Points'),('en','columns','training_content','Content'),('en','columns','treatment','Treatment'),('en','columns','type_of_bleeding','Type of bleeding'),('en','columns','type_of_entry','Type of entry'),('en','columns','uid','#'),('en','columns','unedited','Unedited'),('en','columns','values','Values'),('en','columns','vehicle','Vehicle'),('en','columns','vehicle_status','Status'),('en','columns','vehicle_type','Vehicle type'),('en','columns','violation_of','Violation of'),('en','columns','wanting_type','Search type'),('en','control_centre','current','Current control centre'),('en','control_centre','none','No control centre active!'),('en','control_centre','patrol_reset','Reset'),('en','control_centre','patrol_reset_all','Reset patrols'),('en','control_centre','reset','Reset Control centre'),('en','control_centre','set_area','Set area'),('en','control_centre','set_patrol','Set patrol'),('en','control_centre','set_status','Set status'),('en','control_centre','take','Take over control centre'),('en','crime','no_crime_deposited','No crime deposited'),('en','crimes','detention_time','Detention units'),('en','crimes','fine','Fine (€)'),('en','crimes','penalties_imposed','Penalties imposed'),('en','dashboard','count_files','Count files'),('en','dashboard','count_files_currently','Count files (currrently)'),('en','dashboard','count_manhunt','Manhunts'),('en','dashboard','count_officers','Officers (total)'),('en','dashboard','count_open_investigations','Open investigations'),('en','dashboard','count_vehicles','Number of vehicles'),('en','dashboard','created_datasets','Created entries'),('en','dashboard','current_control_centre','Control Centre'),('en','dashboard','current_control_centre_none','None'),('en','dashboard','includes_deleted','(incl. deleted)'),('en','dashboard','last_month','Last month'),('en','dashboard','last_week','Today -7 days'),('en','dashboard','officer_in_duty','Officer in Duty'),('en','extrabutton','add_entry','Add entry'),('en','extrabutton','add_investigation_entry','Add entry'),('en','extrabutton','add_participent','Add participant'),('en','extrabutton','cancel','Cancel'),('en','extrabutton','close_investigation','Close'),('en','extrabutton','delete_activate_user','Delete'),('en','extrabutton','delete_activate_user_0','Delete'),('en','extrabutton','delete_activate_user_1','Activate'),('en','extrabutton','end_service','Go off duty'),('en','extrabutton','files_delete','Delete'),('en','extrabutton','files_delete_0','Delete'),('en','extrabutton','files_delete_1','Recover'),('en','extrabutton','files_set_blackend','Blackening'),('en','extrabutton','files_set_blackend_0','Blackening'),('en','extrabutton','files_set_blackend_1','Decolourise'),('en','extrabutton','files_set_closed','Close'),('en','extrabutton','files_set_closed_0','Close'),('en','extrabutton','files_set_closed_1','Repoen'),('en','extrabutton','group_management','Back'),('en','extrabutton','investigation_set_closed_0','Close'),('en','extrabutton','investigation_set_closed_1','Open'),('en','extrabutton','leave_patrol','Leave patrol'),('en','extrabutton','navigate_back','Back'),('en','extrabutton','passwordreset','Password reset'),('en','extrabutton','save','Save'),('en','extrabutton','save_participant','Save participant'),('en','extrabutton','suspend_unsuspend_user','Suspend'),('en','extrabutton','suspend_unsuspend_user_0','Suspend'),('en','extrabutton','suspend_unsuspend_user_1','Rehire'),('en','extrabutton','user_set_deleted_0','Delete'),('en','extrabutton','user_set_deleted_1','Activate'),('en','extrabutton','user_set_suspended_0','Suspend'),('en','extrabutton','user_set_suspended_1','Rehire'),('en','extrabutton','view_officertrainings','Trainings'),('en','extrabutton','view_participants','View participant'),('en','extrabutton','view_personal_file','Show personnel file'),('en','file_entry_types','fine_crime','Fine/crime'),('en','file_entry_types','neutral','Neutral'),('en','file_entry_types','positive','Positiv'),('en','files','add_license_to_file','Grant a licence'),('en','files','criminal_complaints_overview','Overview criminal charges'),('en','files','entry_done','Entry done'),('en','files','existing_injuries','Existing injuries'),('en','files','file_entry_number','Entry number'),('en','files','injuries','Injuries'),('en','files','injury_types','Injury types'),('en','files','marked_as','Marked as'),('en','files','marked_dead','Dead'),('en','files','marked_gangmember','Gangmember'),('en','files','marked_violent','Violent'),('en','files','name','Name'),('en','files','no_licenses_granted','No licences have been granted yet.'),('en','files','overview_all_licenses','Licenses overview'),('en','files','post_treatment','Post Treatment'),('en','files','remove_license','Withdraw'),('en','files','title_file_entries','Overview entries'),('en','global','add_crime','Add crime'),('en','global','add_criminal_charges','Add criminal charge'),('en','global','add_entry','Add entry'),('en','global','add_files','Add file'),('en','global','add_investigation_entry','Add entry'),('en','global','add_jobrank','Add rank/group'),('en','global','add_lawbook','Add law book'),('en','global','add_licenses','Add licences'),('en','global','add_mission_reports','Add mission reports'),('en','global','add_officer','Add Officer'),('en','global','add_participent','Add participant'),('en','global','add_patrol','Add patrol'),('en','global','add_patrol_area','Add patrol area'),('en','global','add_patrol_status','Add radio status'),('en','global','add_personalfile_entry','Add entry'),('en','global','add_training','Add training'),('en','global','add_vehicle','Add vehicle'),('en','global','archive','Archive'),('en','global','archive_details','Archive info'),('en','global','automatic_created','Automatic'),('en','global','cancel','Cancel'),('en','global','complete','Complete'),('en','global','completed','Completed'),('en','global','control_centre','Control centre'),('en','global','createdby','Created by'),('en','global','createddate','Created on'),('en','global','criminal_charges','Criminal charges'),('en','global','dashboard','Overview'),('en','global','delete','Delete'),('en','global','edit','Edit'),('en','global','edit_crime','Edit crime'),('en','global','edit_criminal_charges','Edit criminal charge'),('en','global','edit_files','Edit File'),('en','global','edit_investigation','Edit investigation'),('en','global','edit_lawbook','Edit law book'),('en','global','edit_licenses','Edit licence'),('en','global','edit_mission_reports','Edd mission report'),('en','global','edit_officer','Edit Officer'),('en','global','edit_patrol','Edit patrol'),('en','global','edit_patrol_area','Edit patrol area'),('en','global','edit_patrol_status','Edit radio status'),('en','global','edit_training','Edit training'),('en','global','edit_vehicle','Edit vehicle'),('en','global','employees','Employee'),('en','global','files','Files'),('en','global','files_add_entry','Add file entry'),('en','global','group_management','Group management'),('en','global','group_management_settings','Manage groups'),('en','global','group_rights','Set rights'),('en','global','information','Info'),('en','global','investigation','Investigations'),('en','global','license_settings','Manage licences'),('en','global','licenses','Licence management'),('en','global','management','Management'),('en','global','manhunt','Manhunts'),('en','global','max_length','Max. length'),('en','global','menu','Menu'),('en','global','min_length','Min. length'),('en','global','mission_reports','Mission reports'),('en','global','navigate_back','Back'),('en','global','network','Network'),('en','global','next','next'),('en','global','no','No'),('en','global','no_data','No data'),('en','global','no_data_to_display','No data to display!'),('en','global','no_data_to_display_changepage','Please return to another page!'),('en','global','notes','Notes'),('en','global','officer_patrol','Set patrol'),('en','global','officer_status','Set status'),('en','global','officer_trainings','Trainings'),('en','global','officers','Officers'),('en','global','open_file','View File'),('en','global','others','Others'),('en','global','passwordreset_foruser','Password reset'),('en','global','passworts_not_match','Passwords do not match!'),('en','global','patrol_areas','Patrol areas'),('en','global','patrol_status','Radio status'),('en','global','patrols','Patrols'),('en','global','penalties','Law books'),('en','global','quicksearch','Search'),('en','global','radio','Radio'),('en','global','radio_traffic','Radio traffic'),('en','global','recover','Recover'),('en','global','resetpassword','Reset password'),('en','global','save','Save'),('en','global','set_patrol_area','Set patrol area'),('en','global','set_patrol_status','Set status'),('en','global','settings','Settings'),('en','global','show_vehicle','Vehicle'),('en','global','showentities','@@from@@ - @@to@@ from @@totalcount@@ entries'),('en','global','status_deleted','Deleted'),('en','global','status_suspended','Suspended'),('en','global','system','System'),('en','global','trainings','Trainings'),('en','global','traning','Trainings'),('en','global','unknown','Unknown'),('en','global','usersettings','User settings'),('en','global','vehicle_register','Vehicle register'),('en','global','view','View'),('en','global','view_criminal_charges','Show criminal charges'),('en','global','view_criminal_complaints_byfile_0','Charges - Criminal charges filed'),('en','global','view_criminal_complaints_byfile_1','Charges - As perpetrator - unprocessed'),('en','global','view_criminal_complaints_byfile_2','Charges - As perpetrator - in progress'),('en','global','view_criminal_complaints_byfile_3','Charges - As perpetrator - closed'),('en','global','view_investigation','Show investigation'),('en','global','view_mission_reports','Show mission reports'),('en','global','view_officer','View Officer'),('en','global','view_participants','Participant view'),('en','global','view_personal_file','Personnel file'),('en','global','view_training','Training'),('en','global','yes','Yes'),('en','global_status','status_closed','Closed'),('en','global_status','status_inprogress','In progress'),('en','global_status','status_unedited','Unedited'),('en','group_management','set_rights','Set rights'),('en','injuries','head','Head'),('en','injuries','hip','Hip'),('en','injuries','left_arm','Left arm'),('en','injuries','left_foot','Left foot'),('en','injuries','left_leg','Left leg'),('en','injuries','neck','Neck'),('en','injuries','right_arm','Right arm'),('en','injuries','right_foot','Right foot'),('en','injuries','right_leg','Right leg'),('en','injuries','stomach','Stomach'),('en','injuries','torso','Torso'),('en','investigation','reason_of_investigation','Name of investigation'),('en','lawbook','edit','Edit law book'),('en','manhunt','_action','#'),('en','manhunt','active_manhunt','Active manhunt'),('en','manhunt','crimes','Crimes'),('en','manhunt','end_is_wanted','End manhunt'),('en','manhunt','headline','Wanted'),('en','manhunt','information','Info'),('en','manhunt','is_wanted','Wanted'),('en','manhunt','is_wanted_additional_info','Report sightings immediately! Otherwise, consequences must be expected!'),('en','manhunt','is_wanted_reason_unknown','Unknown'),('en','manhunt','old_manhunt','Old manhunt'),('en','manhunt','person_is_wanted_by','Put out an alert by'),('en','manhunt','reason','Reason:'),('en','manhunt','status_is_wanted','Wanted'),('en','manhunt','status_not_wanted','Not wanted'),('en','manhunt','wanted_since','Wanted since'),('en','manhunt','wanting_type','Type of Manhunt'),('en','manhunt','wanting_type_file','Persons'),('en','manhunt','wanting_type_vehicle','Car'),('en','pageloader','archive','Archive'),('en','pageloader','archive_details','Archive details'),('en','pageloader','control_centre','Control centre'),('en','pageloader','custom_personal_file','View personnel file'),('en','pageloader','dashboard','Dashboard'),('en','pageloader','files','Files'),('en','pageloader','form_files_add','Add file'),('en','pageloader','form_files_add_entry_add','Add file entry'),('en','pageloader','form_files_edit','Edit file'),('en','pageloader','form_files_view','Add mission report'),('en','pageloader','form_jobrank_add','Add group'),('en','pageloader','form_jobrank_edit','Edit group'),('en','pageloader','form_mission_reports_add','Add mission report'),('en','pageloader','form_mission_reports_edit','Edit mission report'),('en','pageloader','form_mission_reports_view','View mission report'),('en','pageloader','form_officer_add','Add employee'),('en','pageloader','form_officer_view','View employee'),('en','pageloader','form_participent_add','Add employee to training'),('en','pageloader','form_passwordreset_foruser','Change password'),('en','pageloader','form_patrol_add','Add emergency vehicle'),('en','pageloader','form_patrol_edit','Edit emergency vehicle'),('en','pageloader','form_patrol_status_add','Add Radio status'),('en','pageloader','form_patrol_status_edit','Edit Radio status'),('en','pageloader','form_personalfile_entry_add','Add entry'),('en','pageloader','form_resetpassword','Change password'),('en','pageloader','form_training_add','Add training'),('en','pageloader','form_training_edit','Edit training'),('en','pageloader','form_training_view','View training'),('en','pageloader','form_usersettings_edit','Usersettings'),('en','pageloader','group_management','Group management'),('en','pageloader','group_rights','Set rights'),('en','pageloader','mission_reports','Mission reports'),('en','pageloader','officer_trainings','Trainings of employee'),('en','pageloader','officers','Employees'),('en','pageloader','patrol_status','Radio status'),('en','pageloader','patrols','Emergency vehicles'),('en','pageloader','radio','Radio'),('en','pageloader','settings','Settings'),('en','pageloader','training_participants','Employees for training'),('en','pageloader','trainings','Training'),('en','password','confirm_password','Repeat password'),('en','password','password','Password'),('en','password','password_policy_error','Password policy not adhered to:'),('en','password','passworts_not_match','Passwords do not match!'),('en','password','pwd_require_special_char','At least one special character'),('en','password','pwd_requires_capital_letter','At least one capital letter'),('en','password','pwd_requires_digit','At least one number'),('en','patrol_status','off_duty','Off duty'),('en','patrol_status','radio_offline','Radio offline'),('en','personal_file_types','negativ','Negative'),('en','personal_file_types','note','Notes'),('en','personal_file_types','positive','Positiv'),('en','radio','current_patrol','Current patrol'),('en','radio','current_status_of_patrol','Current status of the patrol:'),('en','radio','current_status_of_user','Current status:'),('en','radio','set_status','Set status'),('en','registered_vehicle','owner','Owner'),('en','registered_vehicle','plate','Plate'),('en','registered_vehicle','vehicle','Vehicle'),('en','registered_vehicle','vehicle_type','Vehicle type'),('en','sex','diverse','diverse'),('en','sex','female','female'),('en','sex','male','male'),('en','sex','unknown','Unknown'),('en','trainings','allow_officer_self_entry','Allow officer self entry'),('en','trainings','participate','Participate'),('glo','add_mission_reports','',''),('glo','add_officer','',''),('glo','add_training','',''),('glo','control_centre','',''),('glo','employees','',''),('glo','investigation','',''),('glo','licenses','',''),('glo','management','',''),('glo','manhunt','',''),('glo','menu','',''),('glo','mission_reports','',''),('glo','officers','',''),('glo','patrols','',''),('glo','penalties','',''),('glo','radio','',''),('glo','radio_traffic','',''),('glo','settings','',''),('glo','system','',''),('glo','trainings','',''),('glo','traning','','');
/*!40000 ALTER TABLE `__definition_languages_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_rights`
--

DROP TABLE IF EXISTS `__definition_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_rights` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sub_function` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `name_de` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `name_en` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_rights`
--

LOCK TABLES `__definition_rights` WRITE;
/*!40000 ALTER TABLE `__definition_rights` DISABLE KEYS */;
INSERT INTO `__definition_rights` VALUES (59,'files','view','Akten - Sehen','Files - View',10),(60,'files','add_edit','Akten - Hinzufügen/Bearbeiten','Files - Add/edit',20),(61,'files','close','Akten - Schließen','Files - Close',30),(62,'files','blacken','Akten - Schwärzen','Files - Blacken',40),(63,'files','delete','Akten - Löschen','Files - Delete',50),(64,'files','allow_manhunt','Akten - Fahndung ausschreiben','Files - Allow/manhunt',60),(65,'file_licenses','grant','Akten - Lizenz erteilen','File_licenses - Grant',200),(66,'file_licenses','remove','Akten - Lizenz entziehen','File_licenses - Remove',210),(67,'file_entries','add_edit','Akteneinträge - Hinzufügen/Bearbeiten','File_entries - Add/edit',300),(68,'file_entries','close','Akteneinträge - Abschließen','File_entries - Close',310),(69,'file_entries','delete','Akteneinträge - Löschen','File_entries - Delete',320),(70,'criminal_charges','view','Stafanzeigen - Sehen','Criminal_charges - View',400),(71,'criminal_charges','add_edit','Stafanzeigen - Hinzufügen/Bearbeiten','Criminal_charges - Add/edit',410),(72,'manhunt','view','Fahndungen - Sehen','Manhunt - View',500),(73,'manhunt','end','Fahndungen - Beenden','Manhunt - End',510),(74,'vehicle_register','view','Fahrzeuge - Sehen','Vehicle_register - View',600),(75,'vehicle_register','add_edit','Fahrzeuge - Hinzufügen/Bearbeiten','Vehicle_register - Add/edit',610),(76,'vehicle_register','delete','Fahrzeuge - Löschen','Vehicle_register - Delete',620),(77,'vehicle_register','allow_manhunt','Fahrzeuge - Fahndung ausschreiben','Vehicle_register - Allow/manhunt',630),(78,'officers','view','Polizisten - Sehen','Officers - View',700),(79,'officers','add_edit','Polizisten - Hinzufügen/Bearbeiten','Officers - Add/edit',710),(80,'officers','delete','Polizisten - Löschen','Officers - Delete',720),(81,'officers','suspend','Polizisten - Suspendieren','Officers - Suspend',730),(82,'personal_file','view','Personalakte - Sehen','Personal_file - View',800),(83,'personal_file','add_edit','Personalakte - Hinzufügen/Bearbeiten','Personal_file - Add/edit',810),(84,'personal_file','close','Personalakte - Eintrag Abschliessen','Personal_file - Close',820),(85,'personal_file','delete','Personalakte - Eintrag Löschen','Personal_file - Delete',830),(86,'trainings','view','Ausbildungen - Sehen','Trainings - View',900),(87,'trainings','add_edit','Ausbildungen - Hinzufügen/Bearbeiten','Trainings - Add/edit',910),(88,'training_participants','view','Ausbildung-Teilnehmer - Sehen','Training_participants - View',1000),(89,'training_participants','add_edit','Ausbildung-Teilnehmer - Hinzufügen','Training_participants - Add/edit',1010),(90,'training_participants','set_passed','Ausbildung-Teilnehmer - Bestanden setzen','Training_participants - Set/passed',1030),(91,'law_books','view','Gesetzbücher - Sehen','Law_books - View',1100),(92,'law_books','add_edit','Gesetzbücher - Hinzufügen/Bearbeiten','Law_books - Add/edit',1110),(93,'law_books','delete','Gesetzbücher - Löschen','Law_books - Delete',1120),(94,'crimes','add_edit','Straftaten - Hinzufügen/Bearbeiten','Crimes - Add/edit',1200),(95,'crimes','delete','Straftaten - Löschen','Crimes - Delete',1210),(96,'investigation','view','Ermittlungen - Sehen','Investigation - View',1300),(97,'investigation','add_edit','Ermittlungen - Hinzufügen/Bearbeiten','Investigation - Add/edit',1310),(98,'investigation','delete','Ermittlungen - Löschen','Investigation - Delete',1320),(99,'investigation_entries','add_edit','Ermittlungen-Einträge - Hinzufügen/Bearbeiten','Investigation_entries - Add/edit',1400),(100,'mission_reports','view','Einsatzberichte - Sehen','Mission_reports - View',1500),(101,'mission_reports','add_edit','Einsatzberichte - Hinzufügen/Bearbeiten','Mission_reports - Add/edit',1510),(102,'patrol_status','view','Funkstatus - Sehen','Patrol_status - View',1600),(103,'patrol_status','add_edit','Funkstatus - Hinzufügen/Bearbeiten','Patrol_status - Add/edit',1610),(104,'patrols','view','Streifen - Sehen','Patrols - View',1700),(105,'patrols','add_edit','Streifen - Hinzufügen/Bearbeiten','Patrols - Add/edit',1710),(106,'patrols','delete','Streifen - Löschen','Patrols - Delete',1720),(107,'patrol_areas','view','Streifengebiete - Sehen','Patrol_areas - View',1800),(108,'patrol_areas','add_edit','Streifengebiete - Hinzufügen/Bearbeiten','Patrol_areas - Add/edit',1810),(109,'patrol_areas','delete','Streifengebiete - Löschen','Patrol_areas - Delete',1820),(110,'radio','view','Funk - Sehen','Radio - View',1900),(111,'control_centre','view','Leistelle - Sehen','Control_centre - View',2000),(112,'control_centre','take_on','Leitstelle - Übernehmen','Control_centre - Take/on',2010),(113,'licenses','view','Lizenzen - Sehen','Licenses - View',2020),(114,'licenses','add_edit','Lizenzen - Hinzufügen/Bearbeiten','Licenses - Add/edit',2030),(115,'group_management','view','Gruppenmanagement - Sehen','Group_management - View',2100),(116,'group_management','add_edit','Gruppenmanagement - Hinzufügen/Bearbeiten','Group_management - Add/edit',2110),(117,'group_management','delete','Gruppenmanagement - Löschen','Group_management - Delete',2120),(118,'group_management','set_rights','Gruppenmanagement - Rechte setzen','Group_management - Set/rights',2130),(119,'archiv','view','Archiv - Sehen','Archiv - View',2200),(120,'archiv','recover_entries','Archiv - Gelöschte Einträge wiederherstellen','Archiv - Recover/entries',2210),(121,'patrol_status','delete','Funkstatus - Löschen','Patrol_status - Delete',1620),(122,'officers','change_securety_level','Polizisten - Sicherheitsstufe ändern','Officers - Change/securety/level',740),(123,'investigation','close','Ermittlungen - Schliessen','Investigation - Close',1330),(124,'training_participants','delete','Ausbildung-Teilnehmer - Löschen','Training_participants - Delete',1020),(125,'licenses','delete','Lizenz - Löschen','Licenses - Delete',2040),(126,'mission_reports','delete','Einsatzberichte - Löschen','Mission_reports - Delete',1520),(127,'trainings','delete','Ausbildungen - Löschen','Trainings - Delete',920);
/*!40000 ALTER TABLE `__definition_rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__definition_tableconfig`
--

DROP TABLE IF EXISTS `__definition_tableconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__definition_tableconfig` (
  `function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `columnname` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `is_quicksearch` tinyint(1) NOT NULL DEFAULT 0,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  `renderer` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`function_name`,`columnname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__definition_tableconfig`
--

LOCK TABLES `__definition_tableconfig` WRITE;
/*!40000 ALTER TABLE `__definition_tableconfig` DISABLE KEYS */;
INSERT INTO `__definition_tableconfig` VALUES ('archive','Count',0,20,''),('archive','Type',0,10,''),('archive','uid',0,30,'renderer_archiveaction'),('archive_details','changeddate',0,10,''),('archive_details','uid',0,30,'renderer_activedetails_actions'),('archive_details','values',0,20,''),('control_centre','_officer_status',0,30,'renderer_color'),('control_centre','fullname',0,20,'renderer_color'),('control_centre','loginname',0,10,'renderer_color'),('control_centre','officer_status_info',0,40,'renderer_color'),('control_centre','uid',0,50,'renderer_officerActions'),('criminal_charges','changedby',0,40,'renderer_color'),('criminal_charges','complaint_reporter',1,10,'renderer_color'),('criminal_charges','createdby',0,30,'renderer_color'),('criminal_charges','perpetrator',1,20,'renderer_color'),('criminal_charges','status',0,50,'renderer_color'),('criminal_charges','uid',0,60,'renderer_actonButtons'),('files','alias',1,20,''),('files','name',1,10,''),('files','phone',1,30,''),('files','uid',0,50,'renderer_actonButtons'),('group_management','grade',0,30,'renderer_actonButtons'),('group_management','label',1,20,''),('group_rights','isSelected',0,30,'renderer_switch'),('group_rights','name',0,20,''),('group_rights','uid',0,10,''),('investigation','investigation_name',1,10,''),('investigation','reason_of_investigation',1,20,''),('investigation','uid',0,30,'renderer_actonButtons'),('licenses','name',1,10,''),('licenses','uid',0,20,'renderer_actonButtons'),('manhunt','_action',0,50,'renderer_manhunt_actions'),('manhunt','crimes',0,30,''),('manhunt','information',0,40,''),('manhunt','name',0,20,''),('manhunt','wanting_type',0,10,'renderer_manhunt_wantingtype'),('mission_reports','changedby',0,50,''),('mission_reports','changeddate',0,60,'renderer_date'),('mission_reports','createdby',0,30,''),('mission_reports','createddate',0,40,'renderer_date'),('mission_reports','mission_date',0,20,'renderer_date'),('mission_reports','mission_reports_title',1,10,''),('mission_reports','uid',0,70,'renderer_actonButtons'),('officers','_officer_status',0,50,'renderer_officerStatus'),('officers','first_name',1,30,''),('officers','last_name',1,20,''),('officers','loginname',1,10,''),('officers','rankid',0,40,'renderer_rank'),('officers','uid',0,70,'renderer_actonButtons'),('patrol_areas','name',0,10,''),('patrol_areas','uid',0,20,'renderer_actonButtons'),('patrol_status','patrol_status_name',1,10,''),('patrol_status','patrol_status_shortname',1,20,''),('patrol_status','uid',0,40,'renderer_actonButtons'),('patrols','patrols_name',1,10,''),('patrols','patrols_shortname',1,20,''),('patrols','patrols_vehicle',1,30,''),('patrols','uid',0,40,'renderer_actonButtons'),('penalties','law_books_name',1,20,''),('penalties','law_books_shortname',1,10,''),('penalties','uid',0,30,'renderer_actonButtons'),('radio','patrol_status_name',0,10,''),('radio','patrol_status_shortname',0,20,''),('radio','uid',0,30,'renderer_setPatrolStatus'),('training_participants','deletecolumn',0,30,'renderer_deleteParticipate'),('training_participants','employee_id',0,10,''),('training_participants','passcolumn',0,20,'renderer_participentPassed'),('trainings','instructor_id',0,30,''),('trainings','participate',0,40,'renderer_doParticipate'),('trainings','short_title',1,20,''),('trainings','title',1,10,''),('trainings','uid',0,50,'renderer_actonButtons'),('vehicle_register','mot',0,50,'renderer_motValid'),('vehicle_register','owner',1,40,''),('vehicle_register','plate',1,10,''),('vehicle_register','uid',0,70,'renderer_actonButtons'),('vehicle_register','vehicle',1,30,''),('vehicle_register','vehicle_status',0,60,'renderer_isWanted'),('vehicle_register','vehicle_type',1,20,''),('view_criminal_complaints_byfile_0','changedby',0,40,''),('view_criminal_complaints_byfile_0','complaint_reporter',0,10,''),('view_criminal_complaints_byfile_0','createdby',0,30,''),('view_criminal_complaints_byfile_0','perpetrator',0,20,''),('view_criminal_complaints_byfile_0','status',0,50,''),('view_criminal_complaints_byfile_1','changedby',0,40,''),('view_criminal_complaints_byfile_1','complaint_reporter',0,10,''),('view_criminal_complaints_byfile_1','createdby',0,30,''),('view_criminal_complaints_byfile_1','perpetrator',0,20,''),('view_criminal_complaints_byfile_1','status',0,50,''),('view_criminal_complaints_byfile_2','changedby',0,40,''),('view_criminal_complaints_byfile_2','complaint_reporter',0,10,''),('view_criminal_complaints_byfile_2','createdby',0,30,''),('view_criminal_complaints_byfile_2','perpetrator',0,20,''),('view_criminal_complaints_byfile_2','status',0,50,''),('view_criminal_complaints_byfile_3','changedby',0,40,''),('view_criminal_complaints_byfile_3','complaint_reporter',0,10,''),('view_criminal_complaints_byfile_3','createdby',0,30,''),('view_criminal_complaints_byfile_3','perpetrator',0,20,''),('view_criminal_complaints_byfile_3','status',0,50,''),('view_lawbook','crime',0,10,''),('view_lawbook','detention_time',0,40,''),('view_lawbook','minimum_penalty',0,30,''),('view_lawbook','others',0,60,''),('view_lawbook','paragraph',0,20,''),('view_lawbook','road_traffic_regulations_points',0,50,''),('view_lawbook','uid',0,80,'renderer_actonButtons');
/*!40000 ALTER TABLE `__definition_tableconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_defined_colors`
--

DROP TABLE IF EXISTS `_defined_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_defined_colors` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `bgColor` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `fgColor` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '#000000',
  `translation_programmtype` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation_key` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  KEY `idx_sortorder` (`sortorder`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_defined_colors`
--

LOCK TABLES `_defined_colors` WRITE;
/*!40000 ALTER TABLE `_defined_colors` DISABLE KEYS */;
INSERT INTO `_defined_colors` VALUES (1,'#000000','#FFFFFF','colors','black',60),(2,'#0000FF','#FFFFFF','colors','blue',30),(3,'#880000','#FFFFFF','colors','dark_red',80),(4,'#888888','#000000','colors','gray',70),(5,'#008000','#FFFFFF','colors','green',10),(6,'#FF0000','#FFFFFF','colors','red',20),(7,'#ffa500','#000000','colors','orange',40),(8,'#ffc0cb','#000000','colors','pink',50);
/*!40000 ALTER TABLE `_defined_colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_defined_file_entry_types`
--

DROP TABLE IF EXISTS `_defined_file_entry_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_defined_file_entry_types` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `translation_programmtype` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation_key` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `color_uid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_defined_file_entry_types`
--

LOCK TABLES `_defined_file_entry_types` WRITE;
/*!40000 ALTER TABLE `_defined_file_entry_types` DISABLE KEYS */;
INSERT INTO `_defined_file_entry_types` VALUES (1,'file_entry_types','fine_crime',6),(2,'file_entry_types','positive',5),(3,'file_entry_types','neutral',4);
/*!40000 ALTER TABLE `_defined_file_entry_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_defined_global_patrol_status`
--

DROP TABLE IF EXISTS `_defined_global_patrol_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_defined_global_patrol_status` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `translation_programmtype` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation_key` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `patrol_status_color` int(11) NOT NULL DEFAULT 0,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isHidden` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_defined_global_patrol_status`
--

LOCK TABLES `_defined_global_patrol_status` WRITE;
/*!40000 ALTER TABLE `_defined_global_patrol_status` DISABLE KEYS */;
INSERT INTO `_defined_global_patrol_status` VALUES (-2,'patrol_status','radio_offline',0,1,'2021-11-04 12:02:00',1,'2021-11-05 08:45:19',1),(-1,'patrol_status','off_duty',0,1,'2021-11-04 12:02:00',1,'2021-11-05 08:45:19',1);
/*!40000 ALTER TABLE `_defined_global_patrol_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_defined_personal_file_automation_texts`
--

DROP TABLE IF EXISTS `_defined_personal_file_automation_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_defined_personal_file_automation_texts` (
  `type` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `text_content` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `select_type` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_defined_personal_file_automation_texts`
--

LOCK TABLES `_defined_personal_file_automation_texts` WRITE;
/*!40000 ALTER TABLE `_defined_personal_file_automation_texts` DISABLE KEYS */;
INSERT INTO `_defined_personal_file_automation_texts` VALUES ('PERSONALFILE_TRAINING_PASSED_0_DE','Ausbildung nicht bestanden: @@TRAININGNAME@@','training_passed_0',10),('PERSONALFILE_TRAINING_PASSED_0_EN','Training not passed: @@TRAININGNAME@@','training_passed_0',40),('PERSONALFILE_TRAINING_PASSED_1_DE','Ausbildung erfolgreich abgeschlossen: @@TRAININGNAME@@','training_passed_1',10),('PERSONALFILE_TRAINING_PASSED_1_EN','Training successfully completed: @@TRAININGNAME@@','training_passed_1',40),('TEXT_DELIMITER','<br>#############################<br>','training_passed_0,training_passed_1',30);
/*!40000 ALTER TABLE `_defined_personal_file_automation_texts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_defined_personal_file_types`
--

DROP TABLE IF EXISTS `_defined_personal_file_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_defined_personal_file_types` (
  `uid` int(11) NOT NULL,
  `translation_programmtype` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation_key` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `color_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_defined_personal_file_types`
--

LOCK TABLES `_defined_personal_file_types` WRITE;
/*!40000 ALTER TABLE `_defined_personal_file_types` DISABLE KEYS */;
INSERT INTO `_defined_personal_file_types` VALUES (0,'personal_file_types','note',4),(1,'personal_file_types','positive',5),(2,'personal_file_types','negativ',6);
/*!40000 ALTER TABLE `_defined_personal_file_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_defined_securety_level`
--

DROP TABLE IF EXISTS `_defined_securety_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_defined_securety_level` (
  `uid` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_defined_securety_level`
--

LOCK TABLES `_defined_securety_level` WRITE;
/*!40000 ALTER TABLE `_defined_securety_level` DISABLE KEYS */;
INSERT INTO `_defined_securety_level` VALUES (0,'0'),(1,'1'),(2,'2'),(3,'3'),(4,'4'),(5,'5');
/*!40000 ALTER TABLE `_defined_securety_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_defined_sex`
--

DROP TABLE IF EXISTS `_defined_sex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_defined_sex` (
  `uid` int(11) NOT NULL,
  `translation_programmtype` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation_key` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_defined_sex`
--

LOCK TABLES `_defined_sex` WRITE;
/*!40000 ALTER TABLE `_defined_sex` DISABLE KEYS */;
INSERT INTO `_defined_sex` VALUES (0,'sex','unknown'),(1,'sex','male'),(2,'sex','female'),(3,'sex','diverse');
/*!40000 ALTER TABLE `_defined_sex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_defined_status`
--

DROP TABLE IF EXISTS `_defined_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_defined_status` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `translation_programmtype` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation_key` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `color_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_defined_status`
--

LOCK TABLES `_defined_status` WRITE;
/*!40000 ALTER TABLE `_defined_status` DISABLE KEYS */;
INSERT INTO `_defined_status` VALUES (1,'global_status','status_unedited',4),(2,'global_status','status_inprogress',7),(3,'global_status','status_closed',5);
/*!40000 ALTER TABLE `_defined_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_defined_yesno`
--

DROP TABLE IF EXISTS `_defined_yesno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_defined_yesno` (
  `uid` int(11) NOT NULL,
  `translation_programmtype` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation_key` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_defined_yesno`
--

LOCK TABLES `_defined_yesno` WRITE;
/*!40000 ALTER TABLE `_defined_yesno` DISABLE KEYS */;
INSERT INTO `_defined_yesno` VALUES (0,'global','no'),(1,'global','yes');
/*!40000 ALTER TABLE `_defined_yesno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_navbar`
--

DROP TABLE IF EXISTS `_navbar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_navbar` (
  `name` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `navbar_group` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `sorting` int(11) NOT NULL DEFAULT 0,
  `goto_function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `goto_sub_function_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `translation_key` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`name`),
  KEY `idx_sorting` (`sorting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_navbar`
--

LOCK TABLES `_navbar` WRITE;
/*!40000 ALTER TABLE `_navbar` DISABLE KEYS */;
INSERT INTO `_navbar` VALUES ('add_mission_reports','mission_reports',1,10,'form_mission_reports','add','form_mission_reports_add'),('add_officer','employees',1,10,'form_officer','add','form_officer_add'),('add_training','traning',1,10,'form_training','add','form_training_add'),('archive','system',1,50,'archive','','archive'),('control_centre','radio_traffic',1,50,'control_centre','','control_centre'),('criminal_charges','files',0,20,'criminal_charges','','criminal_charges'),('dashboard','menu',1,10,'dashboard','','dashboard'),('files','files',1,10,'files','','files'),('group_management','system',1,20,'group_management','','group_management'),('investigation','management',0,20,'investigation','','investigation'),('licenses','system',0,30,'licenses','','licenses'),('manhunt','files',0,30,'manhunt','','manhunt'),('mission_reports','mission_reports',1,20,'mission_reports','','mission_reports'),('network','files',0,50,'network','','network'),('notes','system',0,40,'notes','','notes'),('officers','employees',1,20,'officers','','officers'),('patrol_areas','radio_traffic',0,30,'patrol_areas','','patrol_areas'),('patrol_status','radio_traffic',1,10,'patrol_status','','patrol_status'),('patrols','radio_traffic',1,20,'patrols','','patrols'),('penalties','management',0,10,'penalties','','penalties'),('radio','radio_traffic',1,40,'radio','','radio'),('settings','system',1,10,'settings','','settings'),('trainings','traning',1,20,'trainings','','trainings'),('vehicle_register','files',0,40,'vehicle_register','','vehicle_register');
/*!40000 ALTER TABLE `_navbar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_navbar_groups`
--

DROP TABLE IF EXISTS `_navbar_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_navbar_groups` (
  `id` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_navbar_groups`
--

LOCK TABLES `_navbar_groups` WRITE;
/*!40000 ALTER TABLE `_navbar_groups` DISABLE KEYS */;
INSERT INTO `_navbar_groups` VALUES ('employees',1,30),('files',1,20),('management',1,50),('menu',1,10),('mission_reports',1,60),('radio_traffic',1,70),('system',1,80),('traning',1,40);
/*!40000 ALTER TABLE `_navbar_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `criminal_complaints`
--

DROP TABLE IF EXISTS `criminal_complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `criminal_complaints` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `complaint_reporter` int(11) NOT NULL DEFAULT 0,
  `perpetrator` int(11) NOT NULL DEFAULT 0,
  `perpetrator_description` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `securety_level` int(11) NOT NULL DEFAULT 0,
  `violation_of` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `act_of_crime` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `notes` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `hide_in_archiv` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  KEY `idx_createddate` (`createddate`),
  KEY `idx_deleted` (`deleted`),
  KEY `idx_hide_in_archiv` (`hide_in_archiv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `criminal_complaints`
--

LOCK TABLES `criminal_complaints` WRITE;
/*!40000 ALTER TABLE `criminal_complaints` DISABLE KEYS */;
/*!40000 ALTER TABLE `criminal_complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `file_number` varchar(90) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `name` varchar(256) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `alias` varchar(256) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sex` int(11) NOT NULL DEFAULT 0,
  `size` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `eye_color` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `hair_color` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `phone` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `birthdate` date DEFAULT NULL,
  `securety_level` int(11) NOT NULL DEFAULT 0,
  `file_blackend` tinyint(1) NOT NULL DEFAULT 0,
  `file_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `file_closed` tinyint(1) NOT NULL DEFAULT 0,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hide_in_archiv` tinyint(1) NOT NULL DEFAULT 0,
  `is_dead` tinyint(1) NOT NULL DEFAULT 0,
  `is_gangmember` tinyint(1) NOT NULL DEFAULT 0,
  `is_violent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  KEY `idx_file_deleted` (`file_deleted`),
  KEY `idx_createddate` (`createddate`),
  KEY `idx_hide_in_archiv` (`hide_in_archiv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files_entries`
--

DROP TABLE IF EXISTS `files_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files_entries` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `file_uid` int(11) NOT NULL DEFAULT 0,
  `file_entry_number` varchar(90) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `entry_content` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `intensity_of_wounds` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `type_of_bleeding` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `treatment` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `need_follow_up_treatment` tinyint(1) NOT NULL DEFAULT 0,
  `closed` tinyint(1) NOT NULL DEFAULT 0,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hide_in_archiv` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  KEY `idx_createddate` (`createddate`),
  KEY `idx_deleted` (`deleted`),
  KEY `idx_closed` (`closed`),
  KEY `idx_file_uid` (`file_uid`),
  KEY `idx_file_is_wanted` (`intensity_of_wounds`),
  KEY `idx_file_is_wanted_finished` (`type_of_bleeding`),
  KEY `idx_hide_in_archiv` (`hide_in_archiv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files_entries`
--

LOCK TABLES `files_entries` WRITE;
/*!40000 ALTER TABLE `files_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `files_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files_entries_injuries`
--

DROP TABLE IF EXISTS `files_entries_injuries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files_entries_injuries` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `files_entries_uid` int(11) NOT NULL DEFAULT 0,
  `injury_at` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `injury` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `createdby` int(11) NOT NULL DEFAULT 0,
  `changedby` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`files_entries_uid`,`injury_at`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files_entries_injuries`
--

LOCK TABLES `files_entries_injuries` WRITE;
/*!40000 ALTER TABLE `files_entries_injuries` DISABLE KEYS */;
/*!40000 ALTER TABLE `files_entries_injuries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_rights`
--

DROP TABLE IF EXISTS `group_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_rights` (
  `rankid` int(11) NOT NULL,
  `right_id` int(11) NOT NULL,
  `updated` int(11) NOT NULL DEFAULT 1,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`rankid`,`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_rights`
--

LOCK TABLES `group_rights` WRITE;
/*!40000 ALTER TABLE `group_rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_grades`
--

DROP TABLE IF EXISTS `job_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_grades` (
  `grade` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `hide_in_archiv` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`grade`),
  KEY `idx_deleted` (`deleted`),
  KEY `idx_hide_in_archiv` (`hide_in_archiv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_grades`
--

LOCK TABLES `job_grades` WRITE;
/*!40000 ALTER TABLE `job_grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mission_reports`
--

DROP TABLE IF EXISTS `mission_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mission_reports` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `mission_reports_title` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `mission_date` date DEFAULT NULL,
  `location` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `involved_forces` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `mission_content` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `securety_level` int(11) NOT NULL DEFAULT 0,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `hide_in_archiv` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  KEY `idx_createddate` (`createddate`),
  KEY `idx_deleted` (`deleted`),
  KEY `idx_hide_in_archiv` (`hide_in_archiv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mission_reports`
--

LOCK TABLES `mission_reports` WRITE;
/*!40000 ALTER TABLE `mission_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `mission_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT 0,
  `headline` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `note` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrol_areas`
--

DROP TABLE IF EXISTS `patrol_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patrol_areas` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrol_areas`
--

LOCK TABLES `patrol_areas` WRITE;
/*!40000 ALTER TABLE `patrol_areas` DISABLE KEYS */;
/*!40000 ALTER TABLE `patrol_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrol_status`
--

DROP TABLE IF EXISTS `patrol_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patrol_status` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `patrol_status_name` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `patrol_status_shortname` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `patrol_status_color` int(11) NOT NULL DEFAULT 0,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isHidden` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`patrol_status_name`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrol_status`
--

LOCK TABLES `patrol_status` WRITE;
/*!40000 ALTER TABLE `patrol_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `patrol_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrols`
--

DROP TABLE IF EXISTS `patrols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patrols` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `patrols_name` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `patrols_shortname` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `patrols_vehicle` varchar(10) COLLATE utf8mb4_bin NOT NULL,
  `patrol_status` int(11) NOT NULL DEFAULT -2,
  `patrol_area` int(11) NOT NULL DEFAULT -1,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`patrols_name`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrols`
--

LOCK TABLES `patrols` WRITE;
/*!40000 ALTER TABLE `patrols` DISABLE KEYS */;
/*!40000 ALTER TABLE `patrols` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_file`
--

DROP TABLE IF EXISTS `personal_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_file` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `personal_file_userid` int(11) NOT NULL DEFAULT 0,
  `personal_file_content` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `personal_file_type` int(11) NOT NULL DEFAULT 0,
  `automatic_created` tinyint(1) NOT NULL DEFAULT 0,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `hide_in_archiv` tinyint(1) NOT NULL DEFAULT 0,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  KEY `idx_personal_file_userid` (`personal_file_userid`),
  KEY `idx_createddate` (`createddate`),
  KEY `idx_hide_in_archiv` (`hide_in_archiv`),
  KEY `idx_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_file`
--

LOCK TABLES `personal_file` WRITE;
/*!40000 ALTER TABLE `personal_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registered_user`
--

DROP TABLE IF EXISTS `registered_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registered_user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `password` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `first_name` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `last_name` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `job` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'police',
  `rankid` int(11) NOT NULL DEFAULT 0,
  `locale` varchar(45) COLLATE utf8mb4_bin NOT NULL DEFAULT 'en',
  `securety_level` int(11) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `hide_in_archiv` tinyint(1) NOT NULL DEFAULT 0,
  `is_control_centre` tinyint(1) NOT NULL DEFAULT 0,
  `Patrol_ID` int(11) NOT NULL DEFAULT -1,
  `PatrolStatusID` int(11) NOT NULL DEFAULT -1,
  `cookie_setting` varchar(1024) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `loginname_UNIQUE` (`loginname`),
  KEY `idx_password` (`password`),
  KEY `idx_PatrolStatusID` (`PatrolStatusID`),
  KEY `idx_Patrol_ID` (`Patrol_ID`),
  KEY `idx_is_control_centre` (`is_control_centre`),
  KEY `idx_deleted` (`deleted`),
  KEY `idx_suspended` (`suspended`),
  KEY `idx_rankid` (`rankid`),
  KEY `idx_hide_in_archiv` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registered_user`
--

LOCK TABLES `registered_user` WRITE;
/*!40000 ALTER TABLE `registered_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `registered_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainings`
--

DROP TABLE IF EXISTS `trainings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trainings` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `short_title` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sorting` int(11) NOT NULL DEFAULT 0,
  `training_content` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `allow_officer_self_entry` tinyint(1) NOT NULL DEFAULT 0,
  `min_rankid` int(11) NOT NULL DEFAULT 0,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `instructor_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `hide_in_archiv` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  KEY `idx_createddate` (`createddate`),
  KEY `idx_deleted` (`deleted`),
  KEY `idx_hide_in_archiv` (`hide_in_archiv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainings`
--

LOCK TABLES `trainings` WRITE;
/*!40000 ALTER TABLE `trainings` DISABLE KEYS */;
/*!40000 ALTER TABLE `trainings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainings_employees`
--

DROP TABLE IF EXISTS `trainings_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trainings_employees` (
  `training_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `passed` int(11) NOT NULL DEFAULT -1,
  `createdby` int(11) NOT NULL DEFAULT 0,
  `createddate` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedby` int(11) NOT NULL DEFAULT 0,
  `changeddate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`training_id`,`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainings_employees`
--

LOCK TABLES `trainings_employees` WRITE;
/*!40000 ALTER TABLE `trainings_employees` DISABLE KEYS */;
/*!40000 ALTER TABLE `trainings_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'medics'
--

--
-- Dumping routines for database 'medics'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-20 17:46:17
