DROP TABLE IF EXISTS logs;

CREATE TABLE `winter_market`.`logs` (
                                        `id` INT NOT NULL AUTO_INCREMENT,
                                        `date` DATE NULL,
                                        `logger` VARCHAR(50) NULL,
                                        `level` VARCHAR(10) NULL,
                                        `message` VARCHAR(1000) NULL,
                                        PRIMARY KEY (`id`));