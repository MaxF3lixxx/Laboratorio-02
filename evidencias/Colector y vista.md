# Evidencia 02 — Colector y vista

**Acción:** Se activó `logging_collector` y se reinició PostgreSQL en Windows.

**Resultado de `pg_settings`:** `logging_collector = on`, origen `configuration file`.  
**Resultado de `dba.bitacora`:** la vista devolvió 10 líneas recientes correctamente. El servidor Windows guardó caracteres que no eran UTF-8, por lo que la lectura se ajustó con `pg_read_binary_file` y `convert_from(..., 'WIN1252')`.

**Interpretación:** `logging_collector` requiere reiniciar el servicio para iniciar el proceso que captura la salida del servidor. Leer la bitácora mediante SQL evita tener que abrir directamente el archivo del servicio, pero `pg_read_file` permite acceder a archivos que el servidor puede leer; por eso la vista queda restringida y debe consultarla solo personal autorizado.


