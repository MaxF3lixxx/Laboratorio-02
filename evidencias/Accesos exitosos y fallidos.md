Evidencia 05 — Accesos exitosos y fallidos

## Regla de autenticación observada

La consulta a `pg_hba_file_rules` mostró tres reglas para `{all}`: una local y dos de host (`127.0.0.1` y `::1`). Las tres usan `scram-sha-256`.

**Interpretación:** las conexiones por TCP requieren autenticación con contraseña SCRAM; no se observó una regla `trust` para loopback. Las pruebas de acceso exitoso y fallido y sus líneas de bitácora quedan pendientes.


