-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-03-2026 a las 00:16:35
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_turnos_v2`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `limpiar_tablas` ()   BEGIN
  SET FOREIGN_KEY_CHECKS = 0;
  DELETE FROM postulante;
  DELETE FROM reemplazo;
  DELETE FROM motivo_ahorro;
  DELETE FROM turno;
  DELETE FROM permiso;
  DELETE FROM empleado;
  ALTER TABLE postulante AUTO_INCREMENT = 1;
  ALTER TABLE reemplazo AUTO_INCREMENT = 1;
  ALTER TABLE motivo_ahorro AUTO_INCREMENT = 1;
  ALTER TABLE turno AUTO_INCREMENT = 1;
  ALTER TABLE permiso AUTO_INCREMENT = 1;
  ALTER TABLE empleado AUTO_INCREMENT = 1;
  SET FOREIGN_KEY_CHECKS = 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ausentismo_personal`
--

CREATE TABLE `ausentismo_personal` (
  `id_ausentismo` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `id_permiso` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `dias_ausencia` int(11) NOT NULL,
  `comentario` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `ausentismo_personal`
--

INSERT INTO `ausentismo_personal` (`id_ausentismo`, `id_empleado`, `id_permiso`, `fecha_inicio`, `dias_ausencia`, `comentario`) VALUES
(1, 1, 1, '2025-09-05', 7, 'Licencia médica por resfrío'),
(2, 6, 2, '2025-09-10', 3, 'Permiso familiar FLA'),
(3, 7, 3, '2025-09-20', 1, 'Asunto personal'),
(4, 9, 1, '2025-09-12', 10, 'Licencia médica post operatorio'),
(5, 11, 1, '2025-09-18', 5, 'Licencia médica'),
(6, 15, 3, '2025-09-25', 2, 'Asunto personal sin reemplazo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE `cargo` (
  `id_cargo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`id_cargo`, `nombre`) VALUES
(1, 'ENFERMERA/O'),
(2, 'TENS'),
(3, 'AUXILIAR_SERVICIO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `rut` varchar(20) DEFAULT NULL,
  `id_cargo` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL,
  `id_unidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_empleado`, `nombre`, `apellido`, `rut`, `id_cargo`, `id_estado`, `id_unidad`) VALUES
(1, 'Carolina', 'Villaseñor', '24234', 1, 1, 6),
(2, 'Marisol', 'Baez', NULL, 1, 1, 6),
(3, 'Tatiana', 'Vidal', NULL, 1, 1, 6),
(4, 'Isidora', 'Villanueva', NULL, 1, 1, 6),
(5, 'Lia', 'Lara', NULL, 1, 1, 6),
(6, 'Sandra', 'Calfuén', NULL, 2, 1, 6),
(7, 'Damaris', 'Castillo', NULL, 2, 1, 6),
(8, 'Francisca', 'Cortes', NULL, 2, 1, 6),
(9, 'Margarita', 'Lezana', NULL, 2, 1, 6),
(10, 'Barbarita', 'Poblete', NULL, 2, 1, 6),
(11, 'Cheryl', 'Pizarro', NULL, 2, 1, 6),
(12, 'Nicole', 'Barría', NULL, 2, 1, 3),
(13, 'Javiera', 'Flores', NULL, 2, 1, 6),
(14, 'Lucia', 'Bernal', NULL, 2, 1, 6),
(15, 'Vania', 'Quizas', NULL, 2, 1, 6),
(16, 'Cynthia', 'Ceron', NULL, 2, 1, 6),
(17, 'Yasna', 'Cea', NULL, 2, 1, 6),
(18, 'Sarvia', 'Ortega', NULL, 2, 1, 6),
(19, 'Javiera', 'Moreno', NULL, 2, 1, 6),
(20, 'Sandra', 'Segura', NULL, 3, 1, 6),
(21, 'Mariana', 'Filippe', NULL, 3, 1, 6),
(22, 'Maria', 'Jimenez', NULL, 3, 1, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado_turno`
--

CREATE TABLE `empleado_turno` (
  `id_empleado_turno` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `id_turno` int(11) NOT NULL,
  `asistencia` tinyint(4) DEFAULT 0,
  `id_permiso` int(11) DEFAULT NULL,
  `id_reemplazo_empleado` int(11) DEFAULT NULL,
  `observacion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_empleado`
--

CREATE TABLE `estado_empleado` (
  `id_estado` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `estado_empleado`
--

INSERT INTO `estado_empleado` (`id_estado`, `nombre`) VALUES
(1, 'ACTIVO'),
(2, 'LICENCIA'),
(3, 'VACACIONES'),
(4, 'OTRO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivo_ahorro`
--

CREATE TABLE `motivo_ahorro` (
  `id_motivo` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `id_permiso` int(11) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_termino` time NOT NULL,
  `cantidad_horas` decimal(4,1) DEFAULT NULL,
  `motivo` varchar(100) DEFAULT NULL,
  `comentario` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `motivo_ahorro`
--

INSERT INTO `motivo_ahorro` (`id_motivo`, `id_empleado`, `id_permiso`, `fecha`, `hora_inicio`, `hora_termino`, `cantidad_horas`, `motivo`, `comentario`) VALUES
(1, 10, 1, '2025-09-08', '08:00:00', '20:00:00', 12.0, 'PRESTAMO NICOLE SILVA', NULL),
(2, 10, 1, '2025-09-09', '20:00:00', '08:00:00', 12.0, 'PRESTAMO NICOLE SILVA', NULL),
(3, 6, 3, '2025-09-08', '08:00:00', '20:00:00', 12.0, 'BAJA OCUPACION', NULL),
(4, 21, 5, '2025-09-06', '09:00:00', '20:00:00', 11.0, 'PRESTAMO SIQ', NULL),
(5, 4, 1, '2025-09-18', '20:00:00', '09:00:00', 13.0, 'EU NUEVA (SUPERNUMERARIA)', NULL),
(6, 3, 4, '2025-09-16', '08:00:00', '20:00:00', 12.0, 'CAMBIO DE ROL', NULL),
(7, 7, 2, '2025-09-24', '08:00:00', '20:00:00', 12.0, 'PERMISO FAMILIAR', NULL),
(8, 15, 1, '2025-09-25', '20:00:00', '08:00:00', 12.0, 'PRESTAMO NICOLE SILVA', NULL),
(9, 21, 5, '2025-09-29', '08:00:00', '20:00:00', 12.0, 'PRESTAMO SIQ', 'Cambio de rol a Nicolás');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

CREATE TABLE `perfil` (
  `id_perfil` int(11) NOT NULL,
  `nombre_perfil` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `perfil`
--

INSERT INTO `perfil` (`id_perfil`, `nombre_perfil`, `descripcion`) VALUES
(1, 'ADMINISTRADOR', 'Acceso total al sistema'),
(2, 'SUPERVISOR', 'Gestión operativa de turnos y reemplazos'),
(3, 'ENFERMERA', 'Visualización y marcación de asistencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil_rol`
--

CREATE TABLE `perfil_rol` (
  `id_perfil` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `perfil_rol`
--

INSERT INTO `perfil_rol` (`id_perfil`, `id_rol`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `id_permiso` int(11) NOT NULL,
  `tipo_permiso` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `color_hex` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permiso`, `tipo_permiso`, `descripcion`, `color_hex`) VALUES
(1, 'LM', 'Licencia Médica', '#00FF00'),
(2, 'FLA', 'Feriados Legales', '#FF0000'),
(3, 'HORAS GREMIALES', 'Horas sindicales', '#FFFF00'),
(4, 'ADMINISTRATIVO', 'Permiso administrativo', '#0080FF'),
(5, 'CARGO', 'Permiso por cambio de cargo', '#A0522D');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postulante`
--

CREATE TABLE `postulante` (
  `id_postulante` int(11) NOT NULL,
  `id_reemplazo` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `orden_postulacion` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `postulante`
--

INSERT INTO `postulante` (`id_postulante`, `id_reemplazo`, `id_empleado`, `orden_postulacion`) VALUES
(1, 1, 13, 1),
(2, 1, 14, 2),
(3, 1, 15, 3),
(4, 2, 10, 1),
(5, 2, 11, 2),
(6, 2, 12, 3),
(7, 3, 9, 1),
(8, 3, 10, 2),
(9, 3, 11, 3),
(10, 4, 14, 1),
(11, 4, 13, 2),
(12, 4, 12, 3),
(13, 5, 11, 1),
(14, 5, 12, 2),
(15, 5, 10, 3),
(16, 6, 9, 1),
(17, 6, 10, 2),
(18, 7, 14, 1),
(19, 7, 15, 2),
(20, 8, 12, 1),
(21, 8, 13, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reemplazo`
--

CREATE TABLE `reemplazo` (
  `id_reemplazo` int(11) NOT NULL,
  `id_turno` int(11) NOT NULL,
  `id_reemplazado` int(11) NOT NULL,
  `id_reemplazante` int(11) DEFAULT NULL,
  `id_permiso` int(11) DEFAULT NULL,
  `asignado_por` int(11) DEFAULT NULL,
  `visado_por` int(11) DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `reemplazo`
--

INSERT INTO `reemplazo` (`id_reemplazo`, `id_turno`, `id_reemplazado`, `id_reemplazante`, `id_permiso`, `asignado_por`, `visado_por`, `observaciones`) VALUES
(1, 1, 7, 13, 2, 1, 2, 'Turno cubierto por Javiera Flores'),
(2, 2, 6, 10, 3, 1, 2, 'Horas gremiales Sandra Calfuén'),
(3, 3, 6, 9, 1, 1, 2, 'Licencia médica'),
(4, 4, 7, 14, 1, 1, 2, 'Licencia médica Damaris'),
(5, 5, 6, 11, 2, 1, 2, 'Permiso FLA Sandra'),
(6, 5, 8, 11, 1, 1, 2, 'Licencia médica Francisca'),
(7, 6, 15, 14, 1, 1, 2, 'Cambio de rol'),
(8, 7, 16, 9, 1, 1, 2, 'Noche por embarazo'),
(9, 8, 7, 12, 2, 1, 2, 'Permiso FLA Damaris');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre_rol`, `descripcion`) VALUES
(1, 'VER_TURNOS', 'Permite visualizar turnos'),
(2, 'CREAR_TURNOS', 'Permite crear nuevos turnos'),
(3, 'EDITAR_TURNOS', 'Permite editar turnos existentes'),
(4, 'APROBAR_REEMPLAZOS', 'Permite aprobar reemplazos'),
(5, 'GENERAR_REPORTES', 'Permite acceder a reportes'),
(6, 'GESTIONAR_USUARIOS', 'Permite administrar usuarios del sistema');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_turno`
--

CREATE TABLE `tipo_turno` (
  `id_tipo_turno` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tipo_turno`
--

INSERT INTO `tipo_turno` (`id_tipo_turno`, `nombre`) VALUES
(1, 'DIA'),
(2, 'NOCHE'),
(3, 'OTRO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno`
--

CREATE TABLE `turno` (
  `id_turno` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_termino` time NOT NULL,
  `cantidad_horas` decimal(4,1) NOT NULL,
  `id_tipo_turno` int(11) DEFAULT NULL,
  `id_unidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `turno`
--

INSERT INTO `turno` (`id_turno`, `fecha`, `hora_inicio`, `hora_termino`, `cantidad_horas`, `id_tipo_turno`, `id_unidad`) VALUES
(1, '2025-09-03', '20:00:00', '08:00:00', 12.0, 2, 6),
(2, '2025-09-12', '20:00:00', '09:00:00', 13.0, 1, 6),
(3, '2025-09-13', '09:00:00', '20:00:00', 11.0, 1, 6),
(4, '2025-09-15', '20:00:00', '08:00:00', 12.0, 2, 6),
(5, '2025-09-24', '08:00:00', '20:00:00', 12.0, 1, 6),
(6, '2025-09-25', '20:00:00', '08:00:00', 12.0, 2, 6),
(7, '2025-09-26', '20:00:00', '09:00:00', 13.0, 2, 6),
(8, '2025-09-30', '08:00:00', '20:00:00', 12.0, 1, 3),
(9, '2025-11-01', '08:00:00', '20:00:00', 12.0, 1, 3),
(10, '2025-11-01', '20:00:00', '08:00:00', 12.0, 2, 3),
(11, '2025-11-02', '08:00:00', '20:00:00', 12.0, 1, 3),
(12, '2025-11-02', '20:00:00', '08:00:00', 12.0, 2, 3),
(13, '2025-11-03', '08:00:00', '20:00:00', 12.0, 1, 3),
(14, '2025-11-03', '20:00:00', '08:00:00', 12.0, 2, 3),
(15, '2025-11-04', '08:00:00', '20:00:00', 12.0, 1, 3),
(16, '2025-11-04', '20:00:00', '08:00:00', 12.0, 2, 3),
(17, '2025-11-05', '08:00:00', '20:00:00', 12.0, 1, 3),
(18, '2025-11-05', '20:00:00', '08:00:00', 12.0, 2, 3),
(19, '2025-11-06', '08:00:00', '20:00:00', 12.0, 1, 3),
(20, '2025-11-06', '20:00:00', '08:00:00', 12.0, 2, 3),
(21, '2025-11-07', '08:00:00', '20:00:00', 12.0, 1, 3),
(22, '2025-11-07', '20:00:00', '08:00:00', 12.0, 2, 3),
(23, '2025-11-08', '08:00:00', '20:00:00', 12.0, 1, 3),
(24, '2025-11-08', '20:00:00', '08:00:00', 12.0, 2, 3),
(25, '2025-11-09', '08:00:00', '20:00:00', 12.0, 1, 3),
(26, '2025-11-09', '20:00:00', '08:00:00', 12.0, 2, 3),
(27, '2025-11-10', '08:00:00', '20:00:00', 12.0, 1, 3),
(28, '2025-11-10', '20:00:00', '08:00:00', 12.0, 2, 3),
(29, '2025-11-11', '08:00:00', '20:00:00', 12.0, 1, 3),
(30, '2025-11-11', '20:00:00', '08:00:00', 12.0, 2, 3),
(31, '2025-11-12', '08:00:00', '20:00:00', 12.0, 1, 3),
(32, '2025-11-12', '20:00:00', '08:00:00', 12.0, 2, 3),
(33, '2025-11-13', '08:00:00', '20:00:00', 12.0, 1, 3),
(34, '2025-11-13', '20:00:00', '08:00:00', 12.0, 2, 3),
(35, '2025-11-14', '08:00:00', '20:00:00', 12.0, 1, 3),
(36, '2025-11-14', '20:00:00', '08:00:00', 12.0, 2, 3),
(37, '2025-11-15', '08:00:00', '20:00:00', 12.0, 1, 3),
(38, '2025-11-15', '20:00:00', '08:00:00', 12.0, 2, 3),
(39, '2025-11-16', '08:00:00', '20:00:00', 12.0, 1, 3),
(40, '2025-11-16', '20:00:00', '08:00:00', 12.0, 2, 3),
(41, '2025-11-17', '08:00:00', '20:00:00', 12.0, 1, 3),
(42, '2025-11-17', '20:00:00', '08:00:00', 12.0, 2, 3),
(43, '2025-11-18', '08:00:00', '20:00:00', 12.0, 1, 3),
(44, '2025-11-18', '20:00:00', '08:00:00', 12.0, 2, 3),
(45, '2025-11-19', '08:00:00', '20:00:00', 12.0, 1, 3),
(46, '2025-11-19', '20:00:00', '08:00:00', 12.0, 2, 3),
(47, '2025-11-20', '08:00:00', '20:00:00', 12.0, 1, 3),
(48, '2025-11-20', '20:00:00', '08:00:00', 12.0, 2, 3),
(49, '2025-11-21', '08:00:00', '20:00:00', 12.0, 1, 3),
(50, '2025-11-21', '20:00:00', '08:00:00', 12.0, 2, 3),
(51, '2025-11-22', '08:00:00', '20:00:00', 12.0, 1, 3),
(52, '2025-11-22', '20:00:00', '08:00:00', 12.0, 2, 3),
(53, '2025-11-23', '08:00:00', '20:00:00', 12.0, 1, 3),
(54, '2025-11-23', '20:00:00', '08:00:00', 12.0, 2, 3),
(55, '2025-11-24', '08:00:00', '20:00:00', 12.0, 1, 3),
(56, '2025-11-24', '20:00:00', '08:00:00', 12.0, 2, 3),
(57, '2025-11-25', '08:00:00', '20:00:00', 12.0, 1, 3),
(58, '2025-11-25', '20:00:00', '08:00:00', 12.0, 2, 3),
(59, '2025-11-26', '08:00:00', '20:00:00', 12.0, 1, 3),
(60, '2025-11-26', '20:00:00', '08:00:00', 12.0, 2, 3),
(61, '2025-11-27', '08:00:00', '20:00:00', 12.0, 1, 3),
(62, '2025-11-27', '20:00:00', '08:00:00', 12.0, 2, 3),
(63, '2025-11-28', '08:00:00', '20:00:00', 12.0, 1, 3),
(64, '2025-11-28', '20:00:00', '08:00:00', 12.0, 2, 3),
(65, '2025-11-29', '08:00:00', '20:00:00', 12.0, 1, 3),
(66, '2025-11-29', '20:00:00', '08:00:00', 12.0, 2, 3),
(67, '2025-11-30', '08:00:00', '20:00:00', 12.0, 1, 3),
(68, '2025-11-30', '20:00:00', '08:00:00', 12.0, 2, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_hospitalaria`
--

CREATE TABLE `unidad_hospitalaria` (
  `id_unidad` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `unidad_hospitalaria`
--

INSERT INTO `unidad_hospitalaria` (`id_unidad`, `nombre`, `descripcion`) VALUES
(1, 'Urgencias', 'Atención de emergencias y pacientes críticos'),
(2, 'UCI', 'Unidad de Cuidados Intensivos'),
(3, 'Pabellón', 'Cirugías programadas y procedimientos'),
(4, 'Pediatría', 'Atención infantil'),
(5, 'Medicina General', 'Hospitalización de pacientes adultos'),
(6, 'Médico Quirúrgico 3er Piso', NULL),
(13, 'vcbcb', 'dsfdsf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `contrasena_hash` varchar(255) NOT NULL,
  `nombre_completo` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_perfil` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_ausentismo_mensual`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_ausentismo_mensual` (
`anio` int(4)
,`mes` int(2)
,`unidad` varchar(100)
,`tipo_permiso` varchar(50)
,`empleados_afectados` bigint(21)
,`total_dias_ausencia` decimal(32,0)
,`promedio_dias_por_empleado` decimal(35,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_cobertura_turnos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_cobertura_turnos` (
`nro_turno` int(11)
,`fecha_turno` date
,`unidad_turno` varchar(100)
,`horario` varchar(23)
,`cantidad_horas` decimal(4,1)
,`reemplazado` varchar(201)
,`cargo_reemplazado` varchar(50)
,`tipo_permiso` varchar(50)
,`postulante_1` mediumtext
,`postulante_2` mediumtext
,`postulante_3` mediumtext
,`reemplazante` varchar(201)
,`unidad_reemplazante` varchar(100)
,`asignado_por` varchar(201)
,`visado_por` varchar(201)
,`observaciones` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_empleados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_empleados` (
`id_empleado` int(11)
,`rut` varchar(20)
,`nombre` varchar(100)
,`apellido` varchar(100)
,`cargo` varchar(50)
,`unidad` varchar(100)
,`estado` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_horas_ahorradas_por_permisos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_horas_ahorradas_por_permisos` (
`unidad` varchar(100)
,`tipo_permiso` varchar(50)
,`horas_ahorradas` decimal(26,1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_horas_cubiertas_por_reemplazos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_horas_cubiertas_por_reemplazos` (
`unidad` varchar(100)
,`horas_reemplazo` decimal(26,1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_horas_totales_ausencia_por_tipo_cargo_y_unidad`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_horas_totales_ausencia_por_tipo_cargo_y_unidad` (
`unidad` varchar(100)
,`estamento` varchar(50)
,`horas_ausentismo` decimal(26,1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_kpi_reemplazos_cruzados_entre_unidades`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_kpi_reemplazos_cruzados_entre_unidades` (
`unidad_turno` varchar(100)
,`unidad_reemplazante` varchar(100)
,`reemplazos_cruzados` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_kpi_tasa_de_reemplazos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_kpi_tasa_de_reemplazos` (
`unidad` varchar(100)
,`turnos_reemplazados` bigint(21)
,`total_turnos` bigint(21)
,`tasa_reemplazo` decimal(26,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_kpi_unidades`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_kpi_unidades` (
`unidad` varchar(100)
,`total_reemplazos` bigint(21)
,`horas_reemplazo` decimal(26,1)
,`turnos_con_permiso` bigint(21)
,`tasa_cobertura` decimal(26,2)
,`promedio_horas_turno` decimal(6,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_motivo_ahorro`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_motivo_ahorro` (
`nro_registro` int(11)
,`cargo` varchar(50)
,`empleado` varchar(201)
,`unidad` varchar(100)
,`tipo_permiso` varchar(50)
,`fecha` date
,`hora_inicio` varchar(10)
,`hora_termino` varchar(10)
,`cantidad_horas` decimal(4,1)
,`motivo_del_ahorro` varchar(100)
,`comentario` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_porcentaje_ausentismo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_porcentaje_ausentismo` (
`unidad` varchar(100)
,`porcentaje_ausentismo` decimal(38,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_promedio_dias_ausentes_empleado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_promedio_dias_ausentes_empleado` (
`empleado` varchar(201)
,`promedio_dias_ausencia` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_promedio_dias_ausentismo_por_tipo_permiso`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_promedio_dias_ausentismo_por_tipo_permiso` (
`tipo_permiso` varchar(50)
,`total_dias` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_promedio_horas_reemplazadas_por_turno_por_unidad`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_promedio_horas_reemplazadas_por_turno_por_unidad` (
`unidad` varchar(100)
,`promedio_horas_reemplazo` decimal(6,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_ranking_reemplazantes_mas_activos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_ranking_reemplazantes_mas_activos` (
`reemplazante` varchar(201)
,`unidad` varchar(100)
,`total_turnos_cubiertos` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_resumen_mensual_turnos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_resumen_mensual_turnos` (
`anio` int(4)
,`mes` int(2)
,`unidad_turno` varchar(100)
,`estamento` varchar(50)
,`tipo_permiso` varchar(50)
,`total_reemplazos` bigint(21)
,`total_horas_reemplazo` decimal(26,1)
,`total_horas_ahorro` decimal(26,1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_tasa_cobertura_por_unidad`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_tasa_cobertura_por_unidad` (
`unidad` varchar(100)
,`turnos_reemplazados` bigint(21)
,`turnos_con_permiso` bigint(21)
,`tasa_cobertura` decimal(26,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_total_dias_ausentismo_por_unidad`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_total_dias_ausentismo_por_unidad` (
`unidad` varchar(100)
,`total_dias_ausencia` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_turnos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_turnos` (
`id_turno` int(11)
,`fecha` date
,`hora_inicio` varchar(13)
,`hora_termino` varchar(13)
,`cantidad_horas` decimal(4,1)
,`tipo_turno` varchar(20)
,`unidad` varchar(100)
,`id_unidad` int(11)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_ausentismo_mensual`
--
DROP TABLE IF EXISTS `vw_ausentismo_mensual`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_ausentismo_mensual`  AS SELECT year(`a`.`fecha_inicio`) AS `anio`, month(`a`.`fecha_inicio`) AS `mes`, `u`.`nombre` AS `unidad`, `p`.`tipo_permiso` AS `tipo_permiso`, count(distinct `a`.`id_empleado`) AS `empleados_afectados`, sum(`a`.`dias_ausencia`) AS `total_dias_ausencia`, round(sum(`a`.`dias_ausencia`) / count(distinct `a`.`id_empleado`),2) AS `promedio_dias_por_empleado` FROM (((`ausentismo_personal` `a` join `empleado` `e` on(`a`.`id_empleado` = `e`.`id_empleado`)) join `unidad_hospitalaria` `u` on(`e`.`id_unidad` = `u`.`id_unidad`)) join `permiso` `p` on(`a`.`id_permiso` = `p`.`id_permiso`)) GROUP BY year(`a`.`fecha_inicio`), month(`a`.`fecha_inicio`), `u`.`nombre`, `p`.`tipo_permiso` ORDER BY year(`a`.`fecha_inicio`) DESC, month(`a`.`fecha_inicio`) DESC, `u`.`nombre` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_cobertura_turnos`
--
DROP TABLE IF EXISTS `vw_cobertura_turnos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_cobertura_turnos`  AS SELECT `r`.`id_reemplazo` AS `nro_turno`, `t`.`fecha` AS `fecha_turno`, `u`.`nombre` AS `unidad_turno`, concat(date_format(`t`.`hora_inicio`,'%H:%i'),' - ',date_format(`t`.`hora_termino`,'%H:%i')) AS `horario`, `t`.`cantidad_horas` AS `cantidad_horas`, concat(`e_reemp`.`nombre`,' ',`e_reemp`.`apellido`) AS `reemplazado`, `c_reemp`.`nombre` AS `cargo_reemplazado`, `p`.`tipo_permiso` AS `tipo_permiso`, group_concat(case when `po`.`orden_postulacion` = 1 then concat(`epo`.`nombre`,' ',`epo`.`apellido`) end separator '') AS `postulante_1`, group_concat(case when `po`.`orden_postulacion` = 2 then concat(`epo`.`nombre`,' ',`epo`.`apellido`) end separator '') AS `postulante_2`, group_concat(case when `po`.`orden_postulacion` = 3 then concat(`epo`.`nombre`,' ',`epo`.`apellido`) end separator '') AS `postulante_3`, concat(`e_reempl`.`nombre`,' ',`e_reempl`.`apellido`) AS `reemplazante`, `u_reempl`.`nombre` AS `unidad_reemplazante`, concat(`e_asig`.`nombre`,' ',`e_asig`.`apellido`) AS `asignado_por`, concat(`e_visa`.`nombre`,' ',`e_visa`.`apellido`) AS `visado_por`, `r`.`observaciones` AS `observaciones` FROM (((((((((((`reemplazo` `r` join `turno` `t` on(`r`.`id_turno` = `t`.`id_turno`)) left join `unidad_hospitalaria` `u` on(`t`.`id_unidad` = `u`.`id_unidad`)) join `empleado` `e_reemp` on(`r`.`id_reemplazado` = `e_reemp`.`id_empleado`)) left join `cargo` `c_reemp` on(`e_reemp`.`id_cargo` = `c_reemp`.`id_cargo`)) left join `empleado` `e_reempl` on(`r`.`id_reemplazante` = `e_reempl`.`id_empleado`)) left join `unidad_hospitalaria` `u_reempl` on(`e_reempl`.`id_unidad` = `u_reempl`.`id_unidad`)) left join `empleado` `e_asig` on(`r`.`asignado_por` = `e_asig`.`id_empleado`)) left join `empleado` `e_visa` on(`r`.`visado_por` = `e_visa`.`id_empleado`)) left join `permiso` `p` on(`r`.`id_permiso` = `p`.`id_permiso`)) left join `postulante` `po` on(`po`.`id_reemplazo` = `r`.`id_reemplazo`)) left join `empleado` `epo` on(`po`.`id_empleado` = `epo`.`id_empleado`)) GROUP BY `r`.`id_reemplazo` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_empleados`
--
DROP TABLE IF EXISTS `vw_empleados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_empleados`  AS SELECT `e`.`id_empleado` AS `id_empleado`, `e`.`rut` AS `rut`, `e`.`nombre` AS `nombre`, `e`.`apellido` AS `apellido`, `c`.`nombre` AS `cargo`, `u`.`nombre` AS `unidad`, `es`.`nombre` AS `estado` FROM (((`empleado` `e` left join `cargo` `c` on(`e`.`id_cargo` = `c`.`id_cargo`)) left join `unidad_hospitalaria` `u` on(`e`.`id_unidad` = `u`.`id_unidad`)) left join `estado_empleado` `es` on(`e`.`id_estado` = `es`.`id_estado`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_horas_ahorradas_por_permisos`
--
DROP TABLE IF EXISTS `vw_horas_ahorradas_por_permisos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_horas_ahorradas_por_permisos`  AS SELECT `u`.`nombre` AS `unidad`, `p`.`tipo_permiso` AS `tipo_permiso`, sum(`ma`.`cantidad_horas`) AS `horas_ahorradas` FROM (((`motivo_ahorro` `ma` join `empleado` `e` on(`ma`.`id_empleado` = `e`.`id_empleado`)) join `unidad_hospitalaria` `u` on(`e`.`id_unidad` = `u`.`id_unidad`)) left join `permiso` `p` on(`ma`.`id_permiso` = `p`.`id_permiso`)) GROUP BY `u`.`nombre`, `p`.`tipo_permiso` ORDER BY `u`.`nombre` ASC, sum(`ma`.`cantidad_horas`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_horas_cubiertas_por_reemplazos`
--
DROP TABLE IF EXISTS `vw_horas_cubiertas_por_reemplazos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_horas_cubiertas_por_reemplazos`  AS SELECT `u`.`nombre` AS `unidad`, sum(`t`.`cantidad_horas`) AS `horas_reemplazo` FROM ((`reemplazo` `r` join `turno` `t` on(`r`.`id_turno` = `t`.`id_turno`)) join `unidad_hospitalaria` `u` on(`t`.`id_unidad` = `u`.`id_unidad`)) GROUP BY `u`.`nombre` ORDER BY sum(`t`.`cantidad_horas`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_horas_totales_ausencia_por_tipo_cargo_y_unidad`
--
DROP TABLE IF EXISTS `vw_horas_totales_ausencia_por_tipo_cargo_y_unidad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_horas_totales_ausencia_por_tipo_cargo_y_unidad`  AS SELECT `u`.`nombre` AS `unidad`, `c`.`nombre` AS `estamento`, sum(`ma`.`cantidad_horas`) AS `horas_ausentismo` FROM (((`motivo_ahorro` `ma` join `empleado` `e` on(`ma`.`id_empleado` = `e`.`id_empleado`)) join `cargo` `c` on(`e`.`id_cargo` = `c`.`id_cargo`)) join `unidad_hospitalaria` `u` on(`e`.`id_unidad` = `u`.`id_unidad`)) GROUP BY `u`.`nombre`, `c`.`nombre` ORDER BY `u`.`nombre` ASC, sum(`ma`.`cantidad_horas`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_kpi_reemplazos_cruzados_entre_unidades`
--
DROP TABLE IF EXISTS `vw_kpi_reemplazos_cruzados_entre_unidades`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_kpi_reemplazos_cruzados_entre_unidades`  AS SELECT `u_destino`.`nombre` AS `unidad_turno`, `u_origen`.`nombre` AS `unidad_reemplazante`, count(0) AS `reemplazos_cruzados` FROM ((((`reemplazo` `r` join `turno` `t` on(`r`.`id_turno` = `t`.`id_turno`)) join `empleado` `e` on(`r`.`id_reemplazante` = `e`.`id_empleado`)) join `unidad_hospitalaria` `u_destino` on(`t`.`id_unidad` = `u_destino`.`id_unidad`)) join `unidad_hospitalaria` `u_origen` on(`e`.`id_unidad` = `u_origen`.`id_unidad`)) WHERE `u_destino`.`id_unidad` <> `u_origen`.`id_unidad` GROUP BY `u_destino`.`nombre`, `u_origen`.`nombre` ORDER BY count(0) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_kpi_tasa_de_reemplazos`
--
DROP TABLE IF EXISTS `vw_kpi_tasa_de_reemplazos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_kpi_tasa_de_reemplazos`  AS SELECT `u`.`nombre` AS `unidad`, count(distinct `r`.`id_reemplazo`) AS `turnos_reemplazados`, count(distinct `t`.`id_turno`) AS `total_turnos`, round(count(distinct `r`.`id_reemplazo`) / count(distinct `t`.`id_turno`) * 100,2) AS `tasa_reemplazo` FROM ((`turno` `t` left join `reemplazo` `r` on(`t`.`id_turno` = `r`.`id_turno`)) left join `unidad_hospitalaria` `u` on(`t`.`id_unidad` = `u`.`id_unidad`)) GROUP BY `u`.`nombre` ORDER BY round(count(distinct `r`.`id_reemplazo`) / count(distinct `t`.`id_turno`) * 100,2) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_kpi_unidades`
--
DROP TABLE IF EXISTS `vw_kpi_unidades`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_kpi_unidades`  AS SELECT `u`.`nombre` AS `unidad`, count(distinct `r`.`id_reemplazo`) AS `total_reemplazos`, sum(`t`.`cantidad_horas`) AS `horas_reemplazo`, count(distinct case when `r`.`id_permiso` is not null then `r`.`id_turno` end) AS `turnos_con_permiso`, round(count(distinct `r`.`id_reemplazo`) / count(distinct case when `r`.`id_permiso` is not null then `r`.`id_turno` end) * 100,2) AS `tasa_cobertura`, round(avg(`t`.`cantidad_horas`),2) AS `promedio_horas_turno` FROM ((`reemplazo` `r` join `turno` `t` on(`r`.`id_turno` = `t`.`id_turno`)) join `unidad_hospitalaria` `u` on(`t`.`id_unidad` = `u`.`id_unidad`)) GROUP BY `u`.`nombre` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_motivo_ahorro`
--
DROP TABLE IF EXISTS `vw_motivo_ahorro`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_motivo_ahorro`  AS SELECT `ma`.`id_motivo` AS `nro_registro`, `c`.`nombre` AS `cargo`, concat(`e`.`nombre`,' ',`e`.`apellido`) AS `empleado`, `u`.`nombre` AS `unidad`, `p`.`tipo_permiso` AS `tipo_permiso`, `ma`.`fecha` AS `fecha`, date_format(`ma`.`hora_inicio`,'%H:%i') AS `hora_inicio`, date_format(`ma`.`hora_termino`,'%H:%i') AS `hora_termino`, `ma`.`cantidad_horas` AS `cantidad_horas`, `ma`.`motivo` AS `motivo_del_ahorro`, `ma`.`comentario` AS `comentario` FROM ((((`motivo_ahorro` `ma` join `empleado` `e` on(`ma`.`id_empleado` = `e`.`id_empleado`)) left join `permiso` `p` on(`ma`.`id_permiso` = `p`.`id_permiso`)) left join `cargo` `c` on(`e`.`id_cargo` = `c`.`id_cargo`)) left join `unidad_hospitalaria` `u` on(`e`.`id_unidad` = `u`.`id_unidad`)) ORDER BY `ma`.`fecha` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_porcentaje_ausentismo`
--
DROP TABLE IF EXISTS `vw_porcentaje_ausentismo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_porcentaje_ausentismo`  AS SELECT `u`.`nombre` AS `unidad`, round(sum(`a`.`dias_ausencia`) / (count(distinct `e`.`id_empleado`) * 30) * 100,2) AS `porcentaje_ausentismo` FROM ((`ausentismo_personal` `a` join `empleado` `e` on(`a`.`id_empleado` = `e`.`id_empleado`)) join `unidad_hospitalaria` `u` on(`e`.`id_unidad` = `u`.`id_unidad`)) GROUP BY `u`.`nombre` ORDER BY round(sum(`a`.`dias_ausencia`) / (count(distinct `e`.`id_empleado`) * 30) * 100,2) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_promedio_dias_ausentes_empleado`
--
DROP TABLE IF EXISTS `vw_promedio_dias_ausentes_empleado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_promedio_dias_ausentes_empleado`  AS SELECT concat(`e`.`nombre`,' ',`e`.`apellido`) AS `empleado`, avg(`a`.`dias_ausencia`) AS `promedio_dias_ausencia` FROM (`ausentismo_personal` `a` join `empleado` `e` on(`a`.`id_empleado` = `e`.`id_empleado`)) GROUP BY `e`.`id_empleado` ORDER BY avg(`a`.`dias_ausencia`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_promedio_dias_ausentismo_por_tipo_permiso`
--
DROP TABLE IF EXISTS `vw_promedio_dias_ausentismo_por_tipo_permiso`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_promedio_dias_ausentismo_por_tipo_permiso`  AS SELECT `p`.`tipo_permiso` AS `tipo_permiso`, sum(`a`.`dias_ausencia`) AS `total_dias` FROM (`ausentismo_personal` `a` join `permiso` `p` on(`a`.`id_permiso` = `p`.`id_permiso`)) GROUP BY `p`.`tipo_permiso` ORDER BY sum(`a`.`dias_ausencia`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_promedio_horas_reemplazadas_por_turno_por_unidad`
--
DROP TABLE IF EXISTS `vw_promedio_horas_reemplazadas_por_turno_por_unidad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_promedio_horas_reemplazadas_por_turno_por_unidad`  AS SELECT `u`.`nombre` AS `unidad`, round(avg(`t`.`cantidad_horas`),2) AS `promedio_horas_reemplazo` FROM ((`reemplazo` `r` join `turno` `t` on(`r`.`id_turno` = `t`.`id_turno`)) join `unidad_hospitalaria` `u` on(`t`.`id_unidad` = `u`.`id_unidad`)) GROUP BY `u`.`nombre` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_ranking_reemplazantes_mas_activos`
--
DROP TABLE IF EXISTS `vw_ranking_reemplazantes_mas_activos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_ranking_reemplazantes_mas_activos`  AS SELECT concat(`e`.`nombre`,' ',`e`.`apellido`) AS `reemplazante`, `u`.`nombre` AS `unidad`, count(0) AS `total_turnos_cubiertos` FROM ((`reemplazo` `r` join `empleado` `e` on(`r`.`id_reemplazante` = `e`.`id_empleado`)) left join `unidad_hospitalaria` `u` on(`e`.`id_unidad` = `u`.`id_unidad`)) GROUP BY `e`.`id_empleado`, `u`.`nombre` ORDER BY count(0) DESC LIMIT 0, 10 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_resumen_mensual_turnos`
--
DROP TABLE IF EXISTS `vw_resumen_mensual_turnos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_resumen_mensual_turnos`  AS SELECT year(`t`.`fecha`) AS `anio`, month(`t`.`fecha`) AS `mes`, `u`.`nombre` AS `unidad_turno`, `c`.`nombre` AS `estamento`, `p`.`tipo_permiso` AS `tipo_permiso`, count(distinct `r`.`id_reemplazo`) AS `total_reemplazos`, sum(`t`.`cantidad_horas`) AS `total_horas_reemplazo`, (select ifnull(sum(`ma`.`cantidad_horas`),0) from (((`motivo_ahorro` `ma` join `empleado` `e2` on(`ma`.`id_empleado` = `e2`.`id_empleado`)) left join `permiso` `p2` on(`ma`.`id_permiso` = `p2`.`id_permiso`)) left join `unidad_hospitalaria` `u2` on(`e2`.`id_unidad` = `u2`.`id_unidad`)) where `u2`.`id_unidad` = `u`.`id_unidad` and `p2`.`tipo_permiso` = `p`.`tipo_permiso` and year(`ma`.`fecha`) = year(`t`.`fecha`) and month(`ma`.`fecha`) = month(`t`.`fecha`)) AS `total_horas_ahorro` FROM (((((`reemplazo` `r` join `turno` `t` on(`r`.`id_turno` = `t`.`id_turno`)) left join `unidad_hospitalaria` `u` on(`t`.`id_unidad` = `u`.`id_unidad`)) join `empleado` `e_reemp` on(`r`.`id_reemplazado` = `e_reemp`.`id_empleado`)) left join `cargo` `c` on(`e_reemp`.`id_cargo` = `c`.`id_cargo`)) left join `permiso` `p` on(`r`.`id_permiso` = `p`.`id_permiso`)) GROUP BY year(`t`.`fecha`), month(`t`.`fecha`), `u`.`nombre`, `c`.`nombre`, `p`.`tipo_permiso` ORDER BY year(`t`.`fecha`) DESC, month(`t`.`fecha`) DESC, `u`.`nombre` ASC, `c`.`nombre` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_tasa_cobertura_por_unidad`
--
DROP TABLE IF EXISTS `vw_tasa_cobertura_por_unidad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tasa_cobertura_por_unidad`  AS SELECT `u`.`nombre` AS `unidad`, count(distinct `r`.`id_reemplazo`) AS `turnos_reemplazados`, count(distinct case when `r`.`id_permiso` is not null then `r`.`id_turno` end) AS `turnos_con_permiso`, round(count(distinct `r`.`id_reemplazo`) / count(distinct case when `r`.`id_permiso` is not null then `r`.`id_turno` end) * 100,2) AS `tasa_cobertura` FROM ((`reemplazo` `r` join `turno` `t` on(`r`.`id_turno` = `t`.`id_turno`)) join `unidad_hospitalaria` `u` on(`t`.`id_unidad` = `u`.`id_unidad`)) GROUP BY `u`.`nombre` ORDER BY round(count(distinct `r`.`id_reemplazo`) / count(distinct case when `r`.`id_permiso` is not null then `r`.`id_turno` end) * 100,2) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_total_dias_ausentismo_por_unidad`
--
DROP TABLE IF EXISTS `vw_total_dias_ausentismo_por_unidad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_total_dias_ausentismo_por_unidad`  AS SELECT `u`.`nombre` AS `unidad`, sum(`a`.`dias_ausencia`) AS `total_dias_ausencia` FROM ((`ausentismo_personal` `a` join `empleado` `e` on(`a`.`id_empleado` = `e`.`id_empleado`)) join `unidad_hospitalaria` `u` on(`e`.`id_unidad` = `u`.`id_unidad`)) GROUP BY `u`.`nombre` ORDER BY sum(`a`.`dias_ausencia`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_turnos`
--
DROP TABLE IF EXISTS `vw_turnos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_turnos`  AS SELECT `t`.`id_turno` AS `id_turno`, `t`.`fecha` AS `fecha`, date_format(`t`.`hora_inicio`,'%H:%i:%s') AS `hora_inicio`, date_format(`t`.`hora_termino`,'%H:%i:%s') AS `hora_termino`, `t`.`cantidad_horas` AS `cantidad_horas`, `tt`.`nombre` AS `tipo_turno`, `u`.`nombre` AS `unidad`, `u`.`id_unidad` AS `id_unidad` FROM ((`turno` `t` join `tipo_turno` `tt` on(`t`.`id_tipo_turno` = `tt`.`id_tipo_turno`)) join `unidad_hospitalaria` `u` on(`t`.`id_unidad` = `u`.`id_unidad`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ausentismo_personal`
--
ALTER TABLE `ausentismo_personal`
  ADD PRIMARY KEY (`id_ausentismo`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_permiso` (`id_permiso`);

--
-- Indices de la tabla `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id_cargo`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`),
  ADD KEY `id_cargo` (`id_cargo`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_unidad` (`id_unidad`);

--
-- Indices de la tabla `empleado_turno`
--
ALTER TABLE `empleado_turno`
  ADD PRIMARY KEY (`id_empleado_turno`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_turno` (`id_turno`),
  ADD KEY `id_permiso` (`id_permiso`),
  ADD KEY `id_reemplazo_empleado` (`id_reemplazo_empleado`);

--
-- Indices de la tabla `estado_empleado`
--
ALTER TABLE `estado_empleado`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `motivo_ahorro`
--
ALTER TABLE `motivo_ahorro`
  ADD PRIMARY KEY (`id_motivo`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_permiso` (`id_permiso`);

--
-- Indices de la tabla `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`id_perfil`);

--
-- Indices de la tabla `perfil_rol`
--
ALTER TABLE `perfil_rol`
  ADD PRIMARY KEY (`id_perfil`,`id_rol`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `postulante`
--
ALTER TABLE `postulante`
  ADD PRIMARY KEY (`id_postulante`),
  ADD KEY `id_reemplazo` (`id_reemplazo`),
  ADD KEY `id_empleado` (`id_empleado`);

--
-- Indices de la tabla `reemplazo`
--
ALTER TABLE `reemplazo`
  ADD PRIMARY KEY (`id_reemplazo`),
  ADD KEY `id_turno` (`id_turno`),
  ADD KEY `id_reemplazado` (`id_reemplazado`),
  ADD KEY `id_reemplazante` (`id_reemplazante`),
  ADD KEY `id_permiso` (`id_permiso`),
  ADD KEY `asignado_por` (`asignado_por`),
  ADD KEY `visado_por` (`visado_por`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `tipo_turno`
--
ALTER TABLE `tipo_turno`
  ADD PRIMARY KEY (`id_tipo_turno`);

--
-- Indices de la tabla `turno`
--
ALTER TABLE `turno`
  ADD PRIMARY KEY (`id_turno`),
  ADD KEY `id_tipo_turno` (`id_tipo_turno`),
  ADD KEY `id_unidad` (`id_unidad`);

--
-- Indices de la tabla `unidad_hospitalaria`
--
ALTER TABLE `unidad_hospitalaria`
  ADD PRIMARY KEY (`id_unidad`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD KEY `id_perfil` (`id_perfil`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ausentismo_personal`
--
ALTER TABLE `ausentismo_personal`
  MODIFY `id_ausentismo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id_cargo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `empleado_turno`
--
ALTER TABLE `empleado_turno`
  MODIFY `id_empleado_turno` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_empleado`
--
ALTER TABLE `estado_empleado`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `motivo_ahorro`
--
ALTER TABLE `motivo_ahorro`
  MODIFY `id_motivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `perfil`
--
ALTER TABLE `perfil`
  MODIFY `id_perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `postulante`
--
ALTER TABLE `postulante`
  MODIFY `id_postulante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `reemplazo`
--
ALTER TABLE `reemplazo`
  MODIFY `id_reemplazo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tipo_turno`
--
ALTER TABLE `tipo_turno`
  MODIFY `id_tipo_turno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `turno`
--
ALTER TABLE `turno`
  MODIFY `id_turno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT de la tabla `unidad_hospitalaria`
--
ALTER TABLE `unidad_hospitalaria`
  MODIFY `id_unidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ausentismo_personal`
--
ALTER TABLE `ausentismo_personal`
  ADD CONSTRAINT `ausentismo_personal_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `ausentismo_personal_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`id_cargo`) REFERENCES `cargo` (`id_cargo`),
  ADD CONSTRAINT `empleado_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estado_empleado` (`id_estado`),
  ADD CONSTRAINT `empleado_ibfk_3` FOREIGN KEY (`id_unidad`) REFERENCES `unidad_hospitalaria` (`id_unidad`);

--
-- Filtros para la tabla `empleado_turno`
--
ALTER TABLE `empleado_turno`
  ADD CONSTRAINT `empleado_turno_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `empleado_turno_ibfk_2` FOREIGN KEY (`id_turno`) REFERENCES `turno` (`id_turno`),
  ADD CONSTRAINT `empleado_turno_ibfk_3` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`),
  ADD CONSTRAINT `empleado_turno_ibfk_4` FOREIGN KEY (`id_reemplazo_empleado`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `motivo_ahorro`
--
ALTER TABLE `motivo_ahorro`
  ADD CONSTRAINT `motivo_ahorro_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `motivo_ahorro_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`);

--
-- Filtros para la tabla `perfil_rol`
--
ALTER TABLE `perfil_rol`
  ADD CONSTRAINT `perfil_rol_ibfk_1` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`),
  ADD CONSTRAINT `perfil_rol_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`);

--
-- Filtros para la tabla `postulante`
--
ALTER TABLE `postulante`
  ADD CONSTRAINT `postulante_ibfk_1` FOREIGN KEY (`id_reemplazo`) REFERENCES `reemplazo` (`id_reemplazo`),
  ADD CONSTRAINT `postulante_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `reemplazo`
--
ALTER TABLE `reemplazo`
  ADD CONSTRAINT `reemplazo_ibfk_1` FOREIGN KEY (`id_turno`) REFERENCES `turno` (`id_turno`),
  ADD CONSTRAINT `reemplazo_ibfk_2` FOREIGN KEY (`id_reemplazado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `reemplazo_ibfk_3` FOREIGN KEY (`id_reemplazante`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `reemplazo_ibfk_4` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`),
  ADD CONSTRAINT `reemplazo_ibfk_5` FOREIGN KEY (`asignado_por`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `reemplazo_ibfk_6` FOREIGN KEY (`visado_por`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `turno`
--
ALTER TABLE `turno`
  ADD CONSTRAINT `turno_ibfk_1` FOREIGN KEY (`id_tipo_turno`) REFERENCES `tipo_turno` (`id_tipo_turno`),
  ADD CONSTRAINT `turno_ibfk_2` FOREIGN KEY (`id_unidad`) REFERENCES `unidad_hospitalaria` (`id_unidad`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
