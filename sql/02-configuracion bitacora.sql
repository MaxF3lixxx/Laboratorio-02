ALTER SYSTEM SET log_connections = on;
ALTER SYSTEM SET log_disconnections = on;
ALTER SYSTEM SET log_line_prefix = '%m [%p] user=%u db=%d app=%a client=%h ';
ALTER SYSTEM SET log_statement = 'ddl';
ALTER SYSTEM SET log_min_error_statement = 'error';
SELECT pg_reload_conf();

SELECT name, setting, source, pending_restart
FROM pg_settings
WHERE name IN (
    'log_connections', 'log_disconnections', 'log_line_prefix',
    'log_statement', 'log_min_error_statement'
)
ORDER BY name;

-- Ejecutar durante la Actividad 7 para incluir INSERT, UPDATE y DELETE.
ALTER SYSTEM SET log_statement = 'mod';
SELECT pg_reload_conf();

SELECT num, linea FROM dba.bitacora ORDER BY num DESC LIMIT 100;
