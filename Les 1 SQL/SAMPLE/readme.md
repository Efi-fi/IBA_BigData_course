1. в консоле IBM Cloud DB2 получить сгенерировать credentials;
2. заменить во всех файлах "GMC27476" на "<user>", <user> получить из credentials;
3. запусить в DBVis скрипты:
	- 1_ddl.sql
	- 2_data.sql
	- 3_ddl_foreign.sql
4. в настройках sql editor изменить Statement terminator с ";" на "@" и выполнить скрипты
	- 4_ddl_stored.sql
5. выполнить:
	SET CURRENT SCHEMA = <user>;
