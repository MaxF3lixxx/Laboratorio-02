Evidencia 04 — Configuración de la bitácora

**Recarga:** `pg_reload_conf()` devolvió `true`.

| Parámetro | Valor observado | Origen |
|---|---|---|
| `log_connections` | `on` | configuration file |
| `log_disconnections` | `on` | configuration file |
| `log_line_prefix` | `%m [%p] user=%u db=%d app=%a client=%h` | configuration file |
| `log_statement` | `ddl` | configuration file |
| `log_min_error_statement` | `error` | configuration file |

**Interpretación:** el prefijo permite asociar cada línea con fecha/hora, PID, usuario, base, aplicación y cliente. `ddl` incluye cambios de estructura y privilegios, pero todavía no registra `UPDATE`. `log_min_error_statement = error` permite incluir la sentencia que causó un error.

