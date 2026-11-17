ALTER SYSTEM SET logging_collector = on;
ALTER SYSTEM SET log_directory = 'log';
ALTER SYSTEM SET log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log';

-- Reinicia PostgreSQL desde Servicios de Windows y ejecuta el resto:
CREATE SCHEMA IF NOT EXISTS dba;
REVOKE ALL ON SCHEMA dba FROM PUBLIC;

CREATE OR REPLACE VIEW dba.bitacora AS
SELECT ordinal AS num, linea
FROM regexp_split_to_table(
    pg_read_file(pg_current_logfile()),
    E'\n'
) WITH ORDINALITY AS registro(linea, ordinal);

REVOKE ALL ON dba.bitacora FROM PUBLIC;

SELECT pg_current_logfile();
SELECT num, linea FROM dba.bitacora ORDER BY num DESC LIMIT 20;