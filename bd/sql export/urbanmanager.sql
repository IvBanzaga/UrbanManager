-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-09-2024 a las 20:26:09
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `urbanmanager`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `city`
--

CREATE TABLE `city` (
  `id` binary(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country_id` binary(16) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `city`
--

INSERT INTO `city` (`id`, `name`, `country_id`, `date_created`, `date_deleted`) VALUES
(0x4650f423781d11efbd13fc3497e6e6d5, 'Madrid', 0x323dd4ad781d11efbd13fc3497e6e6d5, '2024-09-21 13:27:39', NULL),
(0x46510b47781d11efbd13fc3497e6e6d5, 'Paris', 0x323de13c781d11efbd13fc3497e6e6d5, '2024-09-21 13:27:39', NULL),
(0x46510ccd781d11efbd13fc3497e6e6d5, 'Berlin', 0x323de1fd781d11efbd13fc3497e6e6d5, '2024-09-21 13:27:39', NULL);

--
-- Disparadores `city`
--
DELIMITER $$
CREATE TRIGGER `before_insert_city` BEFORE INSERT ON `city` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `country`
--

CREATE TABLE `country` (
  `id` binary(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `country`
--

INSERT INTO `country` (`id`, `name`, `date_created`, `date_deleted`) VALUES
(0x323dd4ad781d11efbd13fc3497e6e6d5, 'Spain', '2024-09-21 13:27:06', NULL),
(0x323de13c781d11efbd13fc3497e6e6d5, 'France', '2024-09-21 13:27:06', NULL),
(0x323de1fd781d11efbd13fc3497e6e6d5, 'Germany', '2024-09-21 13:27:06', NULL);

--
-- Disparadores `country`
--
DELIMITER $$
CREATE TRIGGER `before_insert_country` BEFORE INSERT ON `country` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `history`
--

CREATE TABLE `history` (
  `id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  `report_id` binary(16) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL,
  `action` enum('create','update','delete') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `history`
--

INSERT INTO `history` (`id`, `user_id`, `report_id`, `date_created`, `date_deleted`, `action`) VALUES
(0x599f88da781e11efbd13fc3497e6e6d5, 0x602bea7e781d11efbd13fc3497e6e6d5, 0x3a44dc97781e11efbd13fc3497e6e6d5, '2024-09-21 13:35:21', NULL, 'create'),
(0x599fad72781e11efbd13fc3497e6e6d5, 0x602bf9a6781d11efbd13fc3497e6e6d5, 0x3a4506e8781e11efbd13fc3497e6e6d5, '2024-09-21 13:35:21', NULL, 'create');

--
-- Disparadores `history`
--
DELIMITER $$
CREATE TRIGGER `before_insert_history` BEFORE INSERT ON `history` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `media`
--

CREATE TABLE `media` (
  `id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  `report_id` binary(16) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `type` enum('photo','video','file') NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL,
  `dni` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `media`
--
DELIMITER $$
CREATE TRIGGER `before_insert_media` BEFORE INSERT ON `media` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_user_dni` AFTER INSERT ON `media` FOR EACH ROW BEGIN
    IF NEW.dni IS NOT NULL THEN
        UPDATE user
        SET dni = NEW.dni
        WHERE id = NEW.user_id AND dni IS NULL;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postcode`
--

CREATE TABLE `postcode` (
  `id` binary(16) NOT NULL,
  `code` varchar(10) NOT NULL,
  `city_id` binary(16) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `postcode`
--

INSERT INTO `postcode` (`id`, `code`, `city_id`, `date_created`, `date_deleted`) VALUES
(0x4c2ea2f2781d11efbd13fc3497e6e6d5, '28001', 0x4650f423781d11efbd13fc3497e6e6d5, '2024-09-21 13:27:49', NULL),
(0x4c2ebae6781d11efbd13fc3497e6e6d5, '75001', 0x46510b47781d11efbd13fc3497e6e6d5, '2024-09-21 13:27:49', NULL),
(0x4c2ebca0781d11efbd13fc3497e6e6d5, '10115', 0x46510ccd781d11efbd13fc3497e6e6d5, '2024-09-21 13:27:49', NULL);

--
-- Disparadores `postcode`
--
DELIMITER $$
CREATE TRIGGER `before_insert_postcode` BEFORE INSERT ON `postcode` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `report`
--

CREATE TABLE `report` (
  `id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  `admin_id` binary(16) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL,
  `type` enum('incident','suggestion','complaint') NOT NULL,
  `capture` enum('photo','video') NOT NULL,
  `state` enum('pending','processing','resolved') DEFAULT 'pending',
  `category` enum('waste','lighting','roads','others') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `report`
--

INSERT INTO `report` (`id`, `user_id`, `admin_id`, `description`, `latitude`, `longitude`, `date_created`, `date_deleted`, `type`, `capture`, `state`, `category`) VALUES
(0x3a44dc97781e11efbd13fc3497e6e6d5, 0x602bea7e781d11efbd13fc3497e6e6d5, NULL, 'Streetlight not working', 40.416775, -3.703790, '2024-09-21 13:34:29', NULL, 'incident', 'photo', 'pending', 'lighting'),
(0x3a4506e8781e11efbd13fc3497e6e6d5, 0x602bf9a6781d11efbd13fc3497e6e6d5, NULL, 'Trash left uncollected', 48.856613, 2.352222, '2024-09-21 13:34:29', NULL, 'complaint', 'video', 'pending', 'waste'),
(0x8fa64240781e11efbd13fc3497e6e6d5, 0x602bea7e781d11efbd13fc3497e6e6d5, NULL, 'Streetlight not working', 40.416775, -3.703790, '2024-09-21 13:36:52', NULL, 'incident', 'photo', 'pending', 'lighting'),
(0x8fa64ecb781e11efbd13fc3497e6e6d5, 0x602bf9a6781d11efbd13fc3497e6e6d5, NULL, 'Trash left uncollected', 48.856613, 2.352222, '2024-09-21 13:36:52', NULL, 'complaint', 'video', 'pending', 'waste');

--
-- Disparadores `report`
--
DELIMITER $$
CREATE TRIGGER `before_insert_report` BEFORE INSERT ON `report` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role`
--

CREATE TABLE `role` (
  `id` binary(16) NOT NULL,
  `name` enum('admin','user') NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `role`
--

INSERT INTO `role` (`id`, `name`, `date_created`, `date_deleted`) VALUES
(0x562280c1781d11efbd13fc3497e6e6d5, 'admin', '2024-09-21 13:28:06', NULL),
(0x56228e76781d11efbd13fc3497e6e6d5, 'user', '2024-09-21 13:28:06', NULL);

--
-- Disparadores `role`
--
DELIMITER $$
CREATE TRIGGER `before_insert_role` BEFORE INSERT ON `role` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `statistic`
--

CREATE TABLE `statistic` (
  `id` binary(16) NOT NULL,
  `admin_id` binary(16) NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_date` timestamp NULL DEFAULT NULL,
  `total_reports` int(11) NOT NULL,
  `total_resolved` int(11) NOT NULL,
  `total_pending` int(11) NOT NULL,
  `total_processing` int(11) NOT NULL,
  `date_deleted` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `statistic`
--

INSERT INTO `statistic` (`id`, `admin_id`, `start_date`, `end_date`, `total_reports`, `total_resolved`, `total_pending`, `total_processing`, `date_deleted`) VALUES
(0x45f75152781e11efbd13fc3497e6e6d5, 0x602bea7e781d11efbd13fc3497e6e6d5, '2024-09-21 13:34:48', NULL, 100, 80, 10, 10, NULL);

--
-- Disparadores `statistic`
--
DELIMITER $$
CREATE TRIGGER `before_insert_statistic` BEFORE INSERT ON `statistic` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tracking`
--

CREATE TABLE `tracking` (
  `id` binary(16) NOT NULL,
  `report_id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL,
  `previous_state` enum('pending','processing','resolved') NOT NULL,
  `new_state` enum('pending','processing','resolved') DEFAULT NULL,
  `notification` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tracking`
--

INSERT INTO `tracking` (`id`, `report_id`, `user_id`, `date_created`, `date_deleted`, `previous_state`, `new_state`, `notification`) VALUES
(0x4e375d0a781e11efbd13fc3497e6e6d5, 0x3a44dc97781e11efbd13fc3497e6e6d5, 0x602bea7e781d11efbd13fc3497e6e6d5, '2024-09-21 13:35:02', NULL, 'pending', 'processing', 0),
(0x4e377ed9781e11efbd13fc3497e6e6d5, 0x3a4506e8781e11efbd13fc3497e6e6d5, 0x602bf9a6781d11efbd13fc3497e6e6d5, '2024-09-21 13:35:02', NULL, 'pending', 'resolved', 1);

--
-- Disparadores `tracking`
--
DELIMITER $$
CREATE TRIGGER `before_insert_tracking` BEFORE INSERT ON `tracking` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` binary(16) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `second_lastname` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `authentication` enum('email','gmail','facebook') DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `confidentiality` tinyint(1) NOT NULL DEFAULT 1,
  `section` enum('lighting','roads','furniture','others') DEFAULT NULL,
  `role_id` binary(16) NOT NULL,
  `city_id` binary(16) NOT NULL,
  `postcode_id` binary(16) NOT NULL,
  `country_id` binary(16) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_deleted` timestamp NULL DEFAULT NULL,
  `dni` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `firstname`, `lastname`, `second_lastname`, `address`, `phone`, `password`, `authentication`, `email`, `confidentiality`, `section`, `role_id`, `city_id`, `postcode_id`, `country_id`, `date_created`, `date_deleted`, `dni`) VALUES
(0x602bea7e781d11efbd13fc3497e6e6d5, 'John', 'Doe', NULL, 'Calle Mayor 1', '123456789', 'password123', 'email', 'john@example.com', 1, 'roads', 0x562280c1781d11efbd13fc3497e6e6d5, 0x4650f423781d11efbd13fc3497e6e6d5, 0x4c2ea2f2781d11efbd13fc3497e6e6d5, 0x323dd4ad781d11efbd13fc3497e6e6d5, '2024-09-21 13:28:23', NULL, '12345678X'),
(0x602bf9a6781d11efbd13fc3497e6e6d5, 'Jane', 'Smith', 'Taylor', 'Rue de Rivoli 2', '987654321', 'password456', 'gmail', 'jane@example.com', 1, 'lighting', 0x56228e76781d11efbd13fc3497e6e6d5, 0x46510b47781d11efbd13fc3497e6e6d5, 0x4c2ebae6781d11efbd13fc3497e6e6d5, 0x323de13c781d11efbd13fc3497e6e6d5, '2024-09-21 13:28:23', NULL, '87654321Y');

--
-- Disparadores `user`
--
DELIMITER $$
CREATE TRIGGER `before_insert_user` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_city_country` (`country_id`);

--
-- Indices de la tabla `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_history_user` (`user_id`),
  ADD KEY `FK_history_report` (`report_id`);

--
-- Indices de la tabla `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_media_user` (`user_id`),
  ADD KEY `FK_media_report` (`report_id`);

--
-- Indices de la tabla `postcode`
--
ALTER TABLE `postcode`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_postcode_city` (`city_id`);

--
-- Indices de la tabla `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_report_user` (`user_id`),
  ADD KEY `FK_report_admin` (`admin_id`);

--
-- Indices de la tabla `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `statistic`
--
ALTER TABLE `statistic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_statistic_admin` (`admin_id`);

--
-- Indices de la tabla `tracking`
--
ALTER TABLE `tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_tracking_report` (`report_id`),
  ADD KEY `FK_tracking_user` (`user_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `FK_user_role` (`role_id`),
  ADD KEY `FK_user_city` (`city_id`),
  ADD KEY `FK_user_postcode` (`postcode_id`),
  ADD KEY `FK_user_country` (`country_id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `FK_city_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `city_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`);

--
-- Filtros para la tabla `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `FK_history_report` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_history_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `history_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`);

--
-- Filtros para la tabla `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `FK_media_report` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_media_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `media_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`);

--
-- Filtros para la tabla `postcode`
--
ALTER TABLE `postcode`
  ADD CONSTRAINT `FK_postcode_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `postcode_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`);

--
-- Filtros para la tabla `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `FK_report_admin` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_report_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `statistic`
--
ALTER TABLE `statistic`
  ADD CONSTRAINT `FK_statistic_admin` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistic_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `tracking`
--
ALTER TABLE `tracking`
  ADD CONSTRAINT `FK_tracking_report` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_tracking_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tracking_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`),
  ADD CONSTRAINT `tracking_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_user_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_user_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_user_postcode` FOREIGN KEY (`postcode_id`) REFERENCES `postcode` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`),
  ADD CONSTRAINT `user_ibfk_3` FOREIGN KEY (`postcode_id`) REFERENCES `postcode` (`id`),
  ADD CONSTRAINT `user_ibfk_4` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
