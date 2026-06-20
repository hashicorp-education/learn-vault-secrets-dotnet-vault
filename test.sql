SELECT
       'data source=' + @@servername +
       ';initial catalog=' + db_name() +
        case type_desc
           when 'WINDOWS_LOGIN' 
                then ';trusted_connection=true'
           else
                ';user id=' + suser_name()
        end
FROM sys.server_principals
WHERE name = suser_name()
