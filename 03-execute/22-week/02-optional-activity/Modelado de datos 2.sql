CREATE TABLE `ESTADO` (
  `id_estado` int PRIMARY KEY AUTO_INCREMENT,
  `categoria` varchar(100) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255)
);

CREATE TABLE `USUARIO` (
  `id_usuario` int PRIMARY KEY AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `correo` varchar(150) UNIQUE NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `documento` varchar(30) UNIQUE NOT NULL,
  `telefono` varchar(30),
  `fecha_creacion` datetime
);

CREATE TABLE `ROL` (
  `id_rol` int PRIMARY KEY AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `nombre` varchar(50) UNIQUE NOT NULL,
  `descripcion` varchar(255)
);

CREATE TABLE `PERMISO` (
  `id_permiso` int PRIMARY KEY AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `modulo` varchar(100) NOT NULL,
  `recurso` varchar(100) NOT NULL,
  `codigo_accion` varchar(100) NOT NULL,
  `descripcion` varchar(255)
);

CREATE TABLE `USUARIO_ROL` (
  `id_usuario_rol` int PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_rol` int NOT NULL,
  `id_centro` int,
  `id_estado` int NOT NULL,
  `fecha_inicio` date,
  `fecha_fin` date
);

CREATE TABLE `ROL_PERMISO` (
  `id_rol_permiso` int PRIMARY KEY AUTO_INCREMENT,
  `id_rol` int NOT NULL,
  `id_permiso` int NOT NULL
);

CREATE TABLE `CENTRO` (
  `id_centro` int PRIMARY KEY AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `codigo` varchar(30) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `direccion` varchar(255)
);

CREATE TABLE `PROGRAMA_FORMACION` (
  `id_programa` int PRIMARY KEY AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `codigo_programa` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `nivel` varchar(50),
  `total_horas` int,
  `version` varchar(30)
);

CREATE TABLE `COMPETENCIA` (
  `id_competencia` int PRIMARY KEY AUTO_INCREMENT,
  `id_programa` int NOT NULL,
  `id_estado` int NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `horas` int
);

CREATE TABLE `RESULTADO_APRENDIZAJE` (
  `id_resultado` int PRIMARY KEY AUTO_INCREMENT,
  `id_competencia` int NOT NULL,
  `id_estado` int NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `horas` int
);

CREATE TABLE `FICHA` (
  `id_ficha` int PRIMARY KEY AUTO_INCREMENT,
  `id_programa` int NOT NULL,
  `id_centro` int NOT NULL,
  `id_estado` int NOT NULL,
  `numero_ficha` varchar(30) UNIQUE NOT NULL,
  `jornada` varchar(50),
  `fecha_inicio` date,
  `fecha_fin` date,
  `trimestre` int
);

CREATE TABLE `APRENDIZ` (
  `id_aprendiz` int PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` int UNIQUE NOT NULL,
  `id_ficha` int NOT NULL,
  `id_estado` int NOT NULL,
  `es_representante` boolean
);

CREATE TABLE `INSTRUCTOR` (
  `id_instructor` int PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` int UNIQUE NOT NULL,
  `id_estado` int NOT NULL,
  `especialidad` varchar(150),
  `horas_maximas_semana` decimal(5,2)
);

CREATE TABLE `DISPONIBILIDAD_INSTRUCTOR` (
  `id_disponibilidad` int PRIMARY KEY AUTO_INCREMENT,
  `id_instructor` int NOT NULL,
  `id_estado` int NOT NULL,
  `dia_semana` varchar(20) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `disponible` boolean NOT NULL
);

CREATE TABLE `EXCEPCION_INSTRUCTOR` (
  `id_excepcion` int PRIMARY KEY AUTO_INCREMENT,
  `id_instructor` int NOT NULL,
  `id_revisor` int,
  `id_sesion_afectada` int,
  `id_estado` int NOT NULL,
  `tipo_excepcion` varchar(50) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `motivo` text NOT NULL,
  `soporte_url` varchar(500),
  `soporte_nombre` varchar(255),
  `observaciones_revision` text,
  `fecha_revision` datetime,
  `fecha_creacion` datetime
);

CREATE TABLE `AMBIENTE` (
  `id_ambiente` int PRIMARY KEY AUTO_INCREMENT,
  `id_centro` int NOT NULL,
  `id_estado` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(50),
  `capacidad` int,
  `recursos` text
);

CREATE TABLE `FRANJA_HORARIA` (
  `id_franja` int PRIMARY KEY AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `jornada` varchar(50)
);

CREATE TABLE `HORARIO` (
  `id_horario` int PRIMARY KEY AUTO_INCREMENT,
  `id_ficha` int NOT NULL,
  `id_estado` int NOT NULL,
  `trimestre` int,
  `fecha_inicio` date,
  `fecha_fin` date,
  `jornada` varchar(50),
  `fecha_creacion` datetime,
  `fecha_publicacion` datetime
);

CREATE TABLE `SESION` (
  `id_sesion` int PRIMARY KEY AUTO_INCREMENT,
  `id_horario` int NOT NULL,
  `id_resultado` int NOT NULL,
  `id_instructor` int NOT NULL,
  `id_ambiente` int NOT NULL,
  `id_franja` int NOT NULL,
  `id_estado` int NOT NULL,
  `fecha` date NOT NULL,
  `duracion_horas` decimal(5,2),
  `observaciones` text
);

CREATE TABLE `CONFLICTO` (
  `id_conflicto` int PRIMARY KEY AUTO_INCREMENT,
  `id_horario` int NOT NULL,
  `id_sesion_a` int NOT NULL,
  `id_sesion_b` int NOT NULL,
  `id_estado` int NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `descripcion` text,
  `severidad` varchar(30),
  `fecha_creacion` datetime,
  `fecha_resolucion` datetime,
  `resolucion` text
);

CREATE TABLE `PLANTILLA_DOCUMENTO` (
  `id_plantilla` int PRIMARY KEY AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `version` varchar(30),
  `tipo_salida` varchar(30),
  `contenido` text,
  `fecha_creacion` datetime
);

CREATE TABLE `NOTIFICACION` (
  `id_notificacion` int PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_horario` int,
  `id_sesion` int,
  `id_estado` int NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `mensaje` text NOT NULL,
  `tipo` varchar(50),
  `canal` varchar(50),
  `prioridad` varchar(30),
  `enlace` varchar(500),
  `detalle_cambio` text,
  `valor_anterior` text,
  `valor_actual` text,
  `leida` boolean,
  `fecha_lectura` datetime,
  `fecha_creacion` datetime
);

CREATE TABLE `SEGUIMIENTO_FICHA` (
  `id_seguimiento` int PRIMARY KEY AUTO_INCREMENT,
  `id_ficha` int NOT NULL,
  `id_competencia` int,
  `id_resultado` int,
  `id_usuario_creador` int,
  `id_estado` int NOT NULL,
  `fecha` date NOT NULL,
  `horas_programadas` decimal(6,2),
  `horas_ejecutadas` decimal(6,2),
  `porcentaje_avance` decimal(5,2),
  `raps_aprobados` int,
  `raps_totales` int,
  `completada` boolean,
  `observaciones` text
);

CREATE TABLE `BITACORA_PEDAGOGICA` (
  `id_bitacora` int PRIMARY KEY AUTO_INCREMENT,
  `id_sesion` int NOT NULL,
  `id_instructor` int NOT NULL,
  `id_estado` int NOT NULL,
  `estado_sesion` varchar(50),
  `horas_registradas` decimal(5,2),
  `observaciones` text,
  `justificacion` text,
  `fecha_registro` datetime
);

CREATE TABLE `DOCUMENTO` (
  `id_documento` int PRIMARY KEY AUTO_INCREMENT,
  `id_usuario_creador` int NOT NULL,
  `id_plantilla` int,
  `id_ficha` int,
  `id_estado` int NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `periodo_lectivo` varchar(50),
  `tipo_documento` varchar(100),
  `formato` varchar(20),
  `url_archivo` varchar(500),
  `hash_archivo` varchar(255),
  `firma_digital` text,
  `codigo_trd` varchar(100),
  `fecha_creacion` datetime
);

CREATE TABLE `AUDITORIA` (
  `id_auditoria` int PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_estado` int NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `ip` varchar(45),
  `entidad` varchar(100),
  `id_entidad` int,
  `operacion` varchar(50),
  `valor_anterior` text,
  `valor_nuevo` text,
  `diferencias` text,
  `severidad` varchar(30)
);

CREATE TABLE `CATALOGO` (
  `id_catalogo` int PRIMARY KEY AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `descripcion` varchar(255)
);

CREATE TABLE `CATALOGO_DETALLE` (
  `id_detalle` int PRIMARY KEY AUTO_INCREMENT,
  `id_catalogo` int NOT NULL,
  `id_estado` int NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255),
  `orden` int
);

CREATE UNIQUE INDEX `ESTADO_index_0` ON `ESTADO` (`categoria`, `codigo`);

CREATE UNIQUE INDEX `PERMISO_index_1` ON `PERMISO` (`modulo`, `recurso`, `codigo_accion`);

CREATE UNIQUE INDEX `USUARIO_ROL_index_2` ON `USUARIO_ROL` (`id_usuario`, `id_rol`);

CREATE UNIQUE INDEX `ROL_PERMISO_index_3` ON `ROL_PERMISO` (`id_rol`, `id_permiso`);

CREATE UNIQUE INDEX `COMPETENCIA_index_4` ON `COMPETENCIA` (`id_programa`, `codigo`);

CREATE UNIQUE INDEX `RESULTADO_APRENDIZAJE_index_5` ON `RESULTADO_APRENDIZAJE` (`id_competencia`, `codigo`);

ALTER TABLE `USUARIO` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `ROL` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `PERMISO` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `USUARIO_ROL` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `CENTRO` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `PROGRAMA_FORMACION` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `COMPETENCIA` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `RESULTADO_APRENDIZAJE` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `FICHA` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `APRENDIZ` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `INSTRUCTOR` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `DISPONIBILIDAD_INSTRUCTOR` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `EXCEPCION_INSTRUCTOR` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `AMBIENTE` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `FRANJA_HORARIA` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `HORARIO` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `SESION` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `CONFLICTO` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `PLANTILLA_DOCUMENTO` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `NOTIFICACION` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `SEGUIMIENTO_FICHA` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `BITACORA_PEDAGOGICA` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `DOCUMENTO` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `AUDITORIA` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `CATALOGO` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `CATALOGO_DETALLE` ADD FOREIGN KEY (`id_estado`) REFERENCES `ESTADO` (`id_estado`);

ALTER TABLE `USUARIO_ROL` ADD FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `USUARIO_ROL` ADD FOREIGN KEY (`id_rol`) REFERENCES `ROL` (`id_rol`);

ALTER TABLE `USUARIO_ROL` ADD FOREIGN KEY (`id_centro`) REFERENCES `CENTRO` (`id_centro`);

ALTER TABLE `ROL_PERMISO` ADD FOREIGN KEY (`id_rol`) REFERENCES `ROL` (`id_rol`);

ALTER TABLE `ROL_PERMISO` ADD FOREIGN KEY (`id_permiso`) REFERENCES `PERMISO` (`id_permiso`);

ALTER TABLE `INSTRUCTOR` ADD FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `APRENDIZ` ADD FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `COMPETENCIA` ADD FOREIGN KEY (`id_programa`) REFERENCES `PROGRAMA_FORMACION` (`id_programa`);

ALTER TABLE `RESULTADO_APRENDIZAJE` ADD FOREIGN KEY (`id_competencia`) REFERENCES `COMPETENCIA` (`id_competencia`);

ALTER TABLE `FICHA` ADD FOREIGN KEY (`id_programa`) REFERENCES `PROGRAMA_FORMACION` (`id_programa`);

ALTER TABLE `FICHA` ADD FOREIGN KEY (`id_centro`) REFERENCES `CENTRO` (`id_centro`);

ALTER TABLE `APRENDIZ` ADD FOREIGN KEY (`id_ficha`) REFERENCES `FICHA` (`id_ficha`);

ALTER TABLE `DISPONIBILIDAD_INSTRUCTOR` ADD FOREIGN KEY (`id_instructor`) REFERENCES `INSTRUCTOR` (`id_instructor`);

ALTER TABLE `EXCEPCION_INSTRUCTOR` ADD FOREIGN KEY (`id_instructor`) REFERENCES `INSTRUCTOR` (`id_instructor`);

ALTER TABLE `EXCEPCION_INSTRUCTOR` ADD FOREIGN KEY (`id_revisor`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `EXCEPCION_INSTRUCTOR` ADD FOREIGN KEY (`id_sesion_afectada`) REFERENCES `SESION` (`id_sesion`);

ALTER TABLE `AMBIENTE` ADD FOREIGN KEY (`id_centro`) REFERENCES `CENTRO` (`id_centro`);

ALTER TABLE `HORARIO` ADD FOREIGN KEY (`id_ficha`) REFERENCES `FICHA` (`id_ficha`);

ALTER TABLE `SESION` ADD FOREIGN KEY (`id_horario`) REFERENCES `HORARIO` (`id_horario`);

ALTER TABLE `SESION` ADD FOREIGN KEY (`id_resultado`) REFERENCES `RESULTADO_APRENDIZAJE` (`id_resultado`);

ALTER TABLE `SESION` ADD FOREIGN KEY (`id_instructor`) REFERENCES `INSTRUCTOR` (`id_instructor`);

ALTER TABLE `SESION` ADD FOREIGN KEY (`id_ambiente`) REFERENCES `AMBIENTE` (`id_ambiente`);

ALTER TABLE `SESION` ADD FOREIGN KEY (`id_franja`) REFERENCES `FRANJA_HORARIA` (`id_franja`);

ALTER TABLE `CONFLICTO` ADD FOREIGN KEY (`id_horario`) REFERENCES `HORARIO` (`id_horario`);

ALTER TABLE `CONFLICTO` ADD FOREIGN KEY (`id_sesion_a`) REFERENCES `SESION` (`id_sesion`);

ALTER TABLE `CONFLICTO` ADD FOREIGN KEY (`id_sesion_b`) REFERENCES `SESION` (`id_sesion`);

ALTER TABLE `NOTIFICACION` ADD FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `NOTIFICACION` ADD FOREIGN KEY (`id_horario`) REFERENCES `HORARIO` (`id_horario`);

ALTER TABLE `NOTIFICACION` ADD FOREIGN KEY (`id_sesion`) REFERENCES `SESION` (`id_sesion`);

ALTER TABLE `SEGUIMIENTO_FICHA` ADD FOREIGN KEY (`id_ficha`) REFERENCES `FICHA` (`id_ficha`);

ALTER TABLE `SEGUIMIENTO_FICHA` ADD FOREIGN KEY (`id_competencia`) REFERENCES `COMPETENCIA` (`id_competencia`);

ALTER TABLE `SEGUIMIENTO_FICHA` ADD FOREIGN KEY (`id_resultado`) REFERENCES `RESULTADO_APRENDIZAJE` (`id_resultado`);

ALTER TABLE `SEGUIMIENTO_FICHA` ADD FOREIGN KEY (`id_usuario_creador`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `BITACORA_PEDAGOGICA` ADD FOREIGN KEY (`id_sesion`) REFERENCES `SESION` (`id_sesion`);

ALTER TABLE `BITACORA_PEDAGOGICA` ADD FOREIGN KEY (`id_instructor`) REFERENCES `INSTRUCTOR` (`id_instructor`);

ALTER TABLE `DOCUMENTO` ADD FOREIGN KEY (`id_usuario_creador`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DOCUMENTO` ADD FOREIGN KEY (`id_plantilla`) REFERENCES `PLANTILLA_DOCUMENTO` (`id_plantilla`);

ALTER TABLE `DOCUMENTO` ADD FOREIGN KEY (`id_ficha`) REFERENCES `FICHA` (`id_ficha`);

ALTER TABLE `AUDITORIA` ADD FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CATALOGO_DETALLE` ADD FOREIGN KEY (`id_catalogo`) REFERENCES `CATALOGO` (`id_catalogo`);
