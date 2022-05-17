CREATE TABLE `owned_vehicles` (
    `owner` VARCHAR(60) NOT NULL,
    `owner_identifier` VARCHAR(255) NOT NULL,
    `plate` varchar(12) NOT NULL,
    `vehicle` longtext,
    `type` VARCHAR(20) NOT NULL DEFAULT 'car',
    `job` VARCHAR(20) NULL DEFAULT NULL,
    `stored` TINYINT(1) NOT NULL DEFAULT '0',
    PRIMARY KEY (`plate`),
    KEY `owner` (`owner`),
    KEY `owner_identifier` (`owner_identifier`)
) ENGINE = InnoDB;