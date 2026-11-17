SET application_name = 'app-ventas-web';
SET SESSION AUTHORIZATION app_ventas;
UPDATE public.clientes SET rfc = 'GAMA780912ZZZ' WHERE id = 3;
RESET SESSION AUTHORIZATION;

-- Consultar auditoria como superusuario.
SELECT id_evento, momento, usuario_sesion, usuario_efectivo,
       aplicacion, ip_cliente, operacion, id_cliente,
       valores_antes, valores_despues
FROM auditoria.cambios_clientes
ORDER BY id_evento;

SELECT a.id_evento, a.momento, a.usuario_sesion, a.ip_cliente,
       d.key AS campo,
       a.valores_antes ->> d.key AS antes,
       d.value #>> '{}' AS despues
FROM auditoria.cambios_clientes AS a
CROSS JOIN LATERAL jsonb_each(a.valores_despues) AS d
WHERE a.operacion = 'UPDATE'
  AND a.valores_antes -> d.key IS DISTINCT FROM d.value
ORDER BY a.id_evento;

INSERT INTO public.clientes
    (nombre, correo, rfc, edad, ciudad, codigo_postal)
VALUES
    ('Pedro Ruiz', 'pedro.ruiz@example.test', 'RUPE950101AAA', 30, 'Guasave', '81000');

DELETE FROM public.clientes WHERE correo = 'pedro.ruiz@example.test';

SELECT id_evento, usuario_sesion, operacion, id_cliente,
       valores_antes ->> 'rfc' AS rfc_anterior,
       valores_despues ->> 'rfc' AS rfc_nuevo
FROM auditoria.cambios_clientes
ORDER BY id_evento;
