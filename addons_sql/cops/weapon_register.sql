CREATE TABLE `registered_weapons` (
  `uid` INT NOT NULL AUTO_INCREMENT,
  `serial_number` VARCHAR(128) NOT NULL DEFAULT '',
  `weapon_type` VARCHAR(128) NOT NULL DEFAULT '',
  `weapon_model` VARCHAR(128) NOT NULL DEFAULT '',
  `weapon_owner` VARCHAR(128) NOT NULL DEFAULT '',
  `other` TEXT NOT NULL DEFAULT '',
  `is_wanted` TINYINT(1) NOT NULL DEFAULT 0,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0,
  `hide_in_archiv` TINYINT(1) NOT NULL DEFAULT 0,
  `reason_of_is_wanted` varchar(512) NOT NULL DEFAULT '',
  `createdby` INT NOT NULL DEFAULT 0,
  `createddate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changedby` INT NOT NULL DEFAULT 0,
  `changeddate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`));


INSERT INTO `__definition_function` (`function_name`, `doLoaddata`, `doLoadData_NoID`, `doLoadData_UseridAsId`, `doSaveData`, `doDeleteData`, `DoDeleteData_InArchiv`, `type`, `mysql_table`, `uniquecol`, `needsCount`, `orderBy`, `extraWhereStatement`, `UseSmallView`, `deactivated`) VALUES ('weapon_register', '1', '0', '0', '0', '1', '1', 'table', 'registered_weapons', 'uid', '1', 'serial_number', 'WHERE deleted = 0', '0', '0');
INSERT INTO `__definition_function` (`function_name`, `doLoaddata`, `doLoadData_NoID`, `doLoadData_UseridAsId`, `doSaveData`, `doDeleteData`, `DoDeleteData_InArchiv`, `type`, `mysql_table`, `uniquecol`, `needsCount`, `extraWhereStatement`, `UseSmallView`, `deactivated`) VALUES ('form_weapon', '1', '0', '0', '1', '0', '0', 'form', 'registered_weapons', 'uid', '0', 'WHERE deleted = 0', '0', '0');

INSERT INTO `__definition_tableconfig` (`function_name`, `columnname`, `is_quicksearch`, `sortorder`) VALUES ('weapon_register', 'serial_number', '1', '10');
INSERT INTO `__definition_tableconfig` (`function_name`, `columnname`, `is_quicksearch`, `sortorder`) VALUES ('weapon_register', 'weapon_type', '1', '20');
INSERT INTO `__definition_tableconfig` (`function_name`, `columnname`, `is_quicksearch`, `sortorder`) VALUES ('weapon_register', 'weapon_model', '1', '30');
INSERT INTO `__definition_tableconfig` (`function_name`, `columnname`, `is_quicksearch`, `sortorder`) VALUES ('weapon_register', 'weapon_owner', '1', '40');
INSERT INTO `__definition_tableconfig` (`function_name`, `columnname`, `is_quicksearch`, `sortorder`, `renderer`) VALUES ('weapon_register', 'uid', '0', '60', 'renderer_actonButtons');
INSERT INTO `__definition_tableconfig` (`function_name`, `columnname`, `is_quicksearch`, `sortorder`, `renderer`) VALUES ('weapon_register', 'vehicle_status', '0', '50', 'renderer_isWanted');

INSERT INTO `_navbar` (`name`, `navbar_group`, `visible`, `sorting`, `goto_function_name`, `translation_key`) VALUES ('weapon_register', 'files', '1', '60', 'weapon_register', 'weapon_register');
INSERT INTO `__definition_function_rights` (`function_name`, `right_function_name`, `right_sub_function`) VALUES ('weapon_register', 'weapon_register', 'view');

INSERT INTO `__definition_rights` (`function_name`, `sub_function`, `name_de`, `name_en`, `sortorder`) VALUES ('weapon_register', 'view', 'Waffen - Sehen', 'Weapons - View', '650');
INSERT INTO `__definition_rights` (`function_name`, `sub_function`, `name_de`, `name_en`, `sortorder`) VALUES ('weapon_register', 'add_edit', 'Waffen - Hinzufügen/Bearbeiten', 'Weapons - Add/Edit', '660');
INSERT INTO `__definition_rights` (`function_name`, `sub_function`, `name_de`, `name_en`, `sortorder`) VALUES ('weapon_register', 'delete', 'Waffen - Löschen', 'Weapons - Delete', '670');
INSERT INTO `__definition_rights` (`function_name`, `sub_function`, `name_de`, `name_en`, `sortorder`) VALUES ('weapon_register', 'allow_manhunt', 'Waffen - Fahndung ausschreiben', 'Weapons - Allow Manhunt', '680');


INSERT INTO `__definition_function_buttons` (`function_name`, `button`, `goto_functionname`, `disabled`, `right_function_name`, `right_sub_function`, `allowInAdd`, `allowInEdit`, `allowInView`) VALUES ('weapon_register', 'addButton', 'form_weapon', '0', 'weapon_register', 'add_edit', '0', '0', '0');
INSERT INTO `__definition_function_buttons` (`function_name`, `button`, `disabled`, `right_function_name`, `right_sub_function`, `allowInAdd`, `allowInEdit`, `allowInView`) VALUES ('weapon_register', 'deleteButton', '0', 'weapon_register', 'delete', '0', '0', '0');
INSERT INTO `__definition_function_buttons` (`function_name`, `button`, `goto_functionname`, `disabled`, `right_function_name`, `right_sub_function`, `allowInAdd`, `allowInEdit`, `allowInView`) VALUES ('weapon_register', 'editButton', 'form_weapon', '0', 'weapon_register', 'add_edit', '0', '0', '0');
INSERT INTO `__definition_function_buttons` (`function_name`, `button`, `goto_functionname`, `disabled`, `right_function_name`, `right_sub_function`, `allowInAdd`, `allowInEdit`, `allowInView`) VALUES ('weapon_register', 'viewButton', 'form_weapon', '0', 'weapon_register', 'view', '0', '0', '0');


INSERT INTO `__definition_function_buttons` (`function_name`, `button`, `goto_functionname`, `allowInAdd`, `allowInEdit`, `allowInView`) VALUES ('form_weapon', 'CancelSaveButton', 'weapon_register', '1', '1', '0');
INSERT INTO `__definition_function_buttons` (`function_name`, `button`, `goto_functionname`, `allowInAdd`, `allowInEdit`, `allowInView`) VALUES ('form_weapon', 'backButton', 'weapon_register', '0', '0', '1');
INSERT INTO `__definition_function_buttons` (`function_name`, `button`, `goto_functionname`, `right_function_name`, `right_sub_function`, `allowInAdd`, `allowInEdit`, `allowInView`) VALUES ('form_weapon', 'editButton', 'form_weapon', 'weapon_register', 'add_edit', '0', '0', '1');


INSERT INTO `__definition_formconfig` (`function_name`, `columnname`, `form_group`, `sortorder`, `form_type`, `needsValidation`, `allowInEdit`, `allowInAdd`, `allowInView`) VALUES ('form_weapon', 'serial_number', '10', '10', 'text', '1', '1', '1', '1');
INSERT INTO `__definition_formconfig` (`function_name`, `columnname`, `form_group`, `sortorder`, `form_type`, `needsValidation`, `allowInEdit`, `allowInAdd`, `allowInView`) VALUES ('form_weapon', 'weapon_owner', '10', '20', 'text', '1', '1', '1', '1');
INSERT INTO `__definition_formconfig` (`function_name`, `columnname`, `form_group`, `sortorder`, `form_type`, `needsValidation`, `allowInEdit`, `allowInAdd`, `allowInView`) VALUES ('form_weapon', 'weapon_type', '20', '10', 'text', '1', '1', '1', '1');
INSERT INTO `__definition_formconfig` (`function_name`, `columnname`, `form_group`, `sortorder`, `form_type`, `needsValidation`, `allowInEdit`, `allowInAdd`, `allowInView`) VALUES ('form_weapon', 'weapon_model', '20', '20', 'text', '1', '1', '1', '1');
INSERT INTO `__definition_formconfig` (`function_name`, `columnname`, `form_group`, `sortorder`, `form_type`, `height`, `needsValidation`, `allowInEdit`, `allowInAdd`, `allowInView`) VALUES ('form_weapon', 'other', '30', '10', 'textarea', '8', '0', '1', '1', '1');
INSERT INTO `__definition_formconfig` (`function_name`, `columnname`, `form_group`, `sortorder`, `form_type`, `right_function_name`, `right_sub_function`, `allowInEdit`, `allowInAdd`, `allowInView`,`needsValidation`) VALUES ('form_weapon', 'is_wanted', '40', '10', 'dropdown', 'weapon_register', 'allow_manhunt', '1', '1', '1','0');
INSERT INTO `__definition_formconfig` (`function_name`, `columnname`, `form_group`, `sortorder`, `form_type`, `right_function_name`, `right_sub_function`, `allowInEdit`, `allowInAdd`, `allowInView`,`needsValidation`) VALUES ('form_weapon', 'reason_of_is_wanted', '50', '10', 'text', 'weapon_register', 'allow_manhunt', '1', '1', '1','0');

INSERT INTO `__definition_function_extra_selects` (`function_name`, `extra_select`) VALUES ('weapon_register', ', is_wanted as vehicle_status');

INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('de', 'pageloader', 'weapon_register', 'Waffenregister');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('en', 'pageloader', 'weapon_register', 'Weapons registry');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('de', 'columns', 'serial_number', 'Seriennummer');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('en', 'columns', 'serial_number', 'Serial number');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('de', 'columns', 'weapon_type', 'Typ');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('en', 'columns', 'weapon_type', 'Type');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('de', 'columns', 'weapon_model', 'Modell');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('en', 'columns', 'weapon_model', 'Model');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('de', 'columns', 'weapon_owner', 'Besitzer');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('en', 'columns', 'weapon_owner', 'Owner');

INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('de', 'pageloader', 'form_weapon_view', 'Waffe - Ansicht');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('en', 'pageloader', 'form_weapon_view', 'View Weapon');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('de', 'columns', 'other', 'Sonstiges');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('en', 'columns', 'other', 'Others');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('de', 'pageloader', 'form_weapon_edit', 'Waffe - Bearbeiten');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('en', 'pageloader', 'form_weapon_edit', 'Edit Weapon');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('de', 'pageloader', 'form_weapon_add', 'Waffe - Hinzufügen');
INSERT INTO `__definition_languages_values` (`locale`, `programmtype`, `keyvalue`, `translation`) VALUES ('en', 'pageloader', 'form_weapon_add', 'Add Weapon');


