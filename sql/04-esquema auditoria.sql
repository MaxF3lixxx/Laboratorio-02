CREATE SCHEMA IF NOT EXISTS auditoria;
REVOKE ALL ON SCHEMA auditoria FROM PUBLIC;

CREATE TABLE IF NOT EXISTS auditoria.cambios_clientes (
    id_evento BIGSERIAL PRIMARY KEY,
    momento TIMESTAMPTZ NOT NULL DEFAULT now(),
    usuario_sesion TEXT NOT NULL DEFAULT session_user,
    usuario_efectivo TEXT NOT NULL DEFAULT current_user,
    aplicacion TEXT DEFAULT current_setting('application_name', true),
    ip_cliente INET DEFAULT inet_client_addr(),
    operacion TEXT NOT NULL,
    id_cliente BIGINT,
    valores_antes JSONB,
    valores_despues JSONB
);

REVOKE ALL ON ALL TABLES IN SCHEMA auditoria FROM PUBLIC;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA auditoria FROM PUBLIC;
