CREATE TABLE IF NOT EXISTS public.clientes (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    rfc VARCHAR(13),
    edad INTEGER,
    ciudad VARCHAR(80),
    codigo_postal VARCHAR(10),
    fecha_alta DATE DEFAULT CURRENT_DATE
);

INSERT INTO public.clientes
    (nombre, correo, telefono, rfc, edad, ciudad, codigo_postal)
SELECT v.nombre, v.correo, v.telefono, v.rfc, v.edad, v.ciudad, v.codigo_postal
FROM (VALUES
    ('Ana Lopez', 'ana.lopez@example.test', '6671234567', 'LOAA850315ABC', 41, 'Culiacan', '80000'),
    ('Carlos Perez', 'carlos.perez@example.test', '6672345678', 'PECA900720DEF', 35, 'Culiacan', '80100'),
    ('Maria Garcia', 'maria.garcia@example.test', '6673456789', 'GAMA780912GHI', 47, 'Mazatlan', '82000'),
    ('Luis Torres', 'luis.torres@example.test', '6674567890', 'TOLU920201JKL', 34, 'Los Mochis', '81200'),
    ('Laura Sanchez', 'laura.sanchez@example.test', '6675678901', 'SALA880525MNO', 38, 'Culiacan', '80200')
) AS v(nombre, correo, telefono, rfc, edad, ciudad, codigo_postal)
WHERE NOT EXISTS (SELECT 1 FROM public.clientes);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_ventas') THEN
        CREATE ROLE app_ventas LOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'soporte_ana') THEN
        CREATE ROLE soporte_ana LOGIN;
    END IF;
END
$$;

GRANT CONNECT ON DATABASE comercial TO app_ventas, soporte_ana;
GRANT USAGE ON SCHEMA public TO app_ventas, soporte_ana;
GRANT SELECT, UPDATE ON public.clientes TO app_ventas;
GRANT SELECT ON public.clientes TO soporte_ana;
GRANT USAGE, SELECT ON SEQUENCE public.clientes_id_seq TO app_ventas;

-- Asigna las contrasenas desde Login/Group Roles > Properties > Definition.
SELECT id, nombre, rfc FROM public.clientes ORDER BY id;
