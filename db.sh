#!/bin/sh

php yii migrate/create \
    create_Groups_table \
    --fields="\
id:primaryKey,\
name:string(32):notNull:unique,\
"

php yii migrate/create \
    create_GroupPerms_table \
    --fields="\
id:primaryKey,\
group_id:integer:notNull:foreignKey(Groups),\
permission:string(64):notNull,\
"

php yii migrate/create \
    create_Configs_table \
    --fields="\
id:primaryKey,\
key:string(64):notNull:unique,\
value:string(255):notNull,\
"

php yii migrate/create \
    create_Users_table \
    --fields="\
id:primaryKey,\
username:string(32):notNull,\
password:string(255):notNull,\
group_id:integer:notNull:foreignKey(Groups),\
disabled_at:datetime,\
disabled_reason:string(255):notNull,\
created_at:datetime:notNull:defaultExpression('CURRENT_TIMESTAMP'),\
updated_at:datetime:notNull:defaultExpression('CURRENT_TIMESTAMP'),\
deleted_at:datetime,\
deleted_reason:string(255):notNull\
"

php yii migrate/create \
    create_Logs_table \
    --fields="\
id:primaryKey,\
user_id:integer:foreignKey(Users),\
ip:string(64):notNull,\
level:string(16):notNull,\
action:string(64):notNull,\
description:string(255):notNull,\
created_at:timestamp:notNull:defaultExpression('CURRENT_TIMESTAMP')\
"

php yii migrate/create \
    create_Procedures_table \
    --fields="\
id:primaryKey,\
name:string(64):notNull,\
description:string(255):notNull,\
arguments:string(4096):notNull,\
created_by:integer:notNull:foreignKey(Users id),\
created_at:timestamp:notNull:defaultExpression('CURRENT_TIMESTAMP'),\
obsoleted_by:integer:foreignKey(Procedures id),\
obsoleted_at:datetime,\
deleted_by:integer:foreignKey(Users id),\
deleted_at:datetime\
"

php yii migrate/create \
    create_Jobs_table \
    --fields="\
id:primaryKey,\
procedure_id:integer:notNull:foreignKey(Procedures),\
arguments:string(4096):notNull,\
minute:string(64):notNull,\
hour:string(64):notNull,\
day:string(64):notNull,\
month:string(64):notNull,\
year:string(64):notNull,\
week:string(64):notNull,\
created_by:integer:notNull:foreignKey(Users id),\
created_at:timestamp:notNull:defaultExpression('CURRENT_TIMESTAMP'),\
obsoleted_by:integer:foreignKey(Jobs id),\
obsoleted_at:datetime,\
deleted_at:datetime\
"

php yii migrate/create \
    create_Executions_table \
    --fields="\
id:primaryKey,\
jobs_id:integer:notNull:foreignKey(Jobs),\
result:string(65535),\
started_at:datetime:notNull:defaultExpression('CURRENT_TIMESTAMP'),\
stopped_at:datetime\
"
