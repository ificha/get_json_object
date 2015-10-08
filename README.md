# get_json_object
mssql tsql get_json_object

JSON example: 
{"CorrelationId":"c701af4c-bf11-4645-b852-59a850bc1327","EntityId":"{234C6FAE-4530-E511-949D-00155D000FE8}","LoadTime":1053}

Select as nvarchar
select dbo.get_json_object(eventattrs, 'CorrelationId') from <table_name>

Select as float
select cast(dbo.get_json_object(eventattrs, 'LoadTime') as float) from <table_name>
