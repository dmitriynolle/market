SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS users;

CREATE TABLE users
(
    id         INT(11)     NOT NULL AUTO_INCREMENT,
    username   VARCHAR(50) NOT NULL,
    password   CHAR(80)    NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    email      VARCHAR(50) NOT NULL,
    phone      VARCHAR(15) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS roles;

CREATE TABLE roles
(
    id   INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS users_roles;

CREATE TABLE users_roles
(
    user_id INT(11) NOT NULL,
    role_id INT(11) NOT NULL,

    PRIMARY KEY (user_id, role_id),

--  KEY FK_ROLE_idx (role_id),

    CONSTRAINT FK_USER_ID_01 FOREIGN KEY (user_id)
        REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT FK_ROLE_ID FOREIGN KEY (role_id)
        REFERENCES roles (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS categories;

CREATE TABLE categories
(
    id          INT(11)      NOT NULL AUTO_INCREMENT,
    title       VARCHAR(255) NOT NULL,
    description VARCHAR(5000),
    PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS products;

CREATE TABLE products
(
    id                INT(11)       NOT NULL AUTO_INCREMENT,
    category_id       INT(11)       NOT NULL,
    vendor_code       VARCHAR(8)    NOT NULL,
    title             VARCHAR(255)  NOT NULL,
    short_description VARCHAR(1000) NOT NULL,
    full_description  VARCHAR(5000) NOT NULL,
    price             DECIMAL(8, 2) NOT NULL,
    quantity          INT(11)       NOT NULL,
    create_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at         TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT FK_CATEGORY_ID FOREIGN KEY (category_id)
        REFERENCES categories (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS products_images;

CREATE TABLE products_images
(
    id         INT(11)      NOT NULL AUTO_INCREMENT,
    product_id INT(11)      NOT NULL,
    path       VARCHAR(250) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_PRODUCT_ID_IMG FOREIGN KEY (product_id)
        REFERENCES products (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS orders_statuses;

CREATE TABLE orders_statuses
(
    id    INT(11) NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS delivery_addresses;

CREATE TABLE delivery_addresses
(
    id      INT(11)      NOT NULL AUTO_INCREMENT,
    user_id INT(11)      NOT NULL,
    address VARCHAR(500) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_USER_ID_DEL_ADR FOREIGN KEY (user_id)
        REFERENCES users (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders
(
    id                  INT(11)       NOT NULL AUTO_INCREMENT,
    user_id             INT(11)       NOT NULL,
    price               DECIMAL(8, 2) NOT NULL,
    delivery_price      DECIMAL(8, 2) NOT NULL,
    delivery_address_id INT(11)       NOT NULL,
    phone_number        VARCHAR(20)   NOT NULL,
    status_id           INT(11)       NOT NULL,
    delivery_date       TIMESTAMP     NOT NULL,
    create_at           TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at           TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT FK_USER_ID FOREIGN KEY (user_id)
        REFERENCES users (id),
    CONSTRAINT FK_STATUS_ID FOREIGN KEY (status_id)
        REFERENCES orders_statuses (id),
    CONSTRAINT FK_DELIVERY_ADDRESS_ID FOREIGN KEY (delivery_address_id)
        REFERENCES delivery_addresses (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS orders_item;

CREATE TABLE orders_item
(
    id          INT(11)       NOT NULL AUTO_INCREMENT,
    product_id  INT(11)       NOT NULL,
    order_id    INT(11)       NOT NULL,
    quantity    INT           NOT NULL,
    item_price  DECIMAL(8, 2) NOT NULL,
    total_price DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_ORDER_ID FOREIGN KEY (order_id)
        REFERENCES orders (id),
    CONSTRAINT FK_PRODUCT_ID_ORD_IT FOREIGN KEY (product_id)
        REFERENCES products (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO roles (name)
VALUES ('ROLE_EMPLOYEE'),
       ('ROLE_MANAGER'),
       ('ROLE_ADMIN');

INSERT INTO users (username, password, first_name, last_name, email, phone)
VALUES ('admin', '$2a$10$4p6U8Ve1ZjJ/S0Qd9RFyB.hJjpusgdYmTtIIqpHs3k0hfbhDe6cyq', 'Admin', 'Admin', 'admin@gmail.com',
        '+79881111111');

INSERT INTO users_roles (user_id, role_id)
VALUES (1, 1),
       (1, 2),
       (1, 3);

INSERT INTO categories (title)
VALUES ("Телевизоры"),
       ("Ноутбуки");

INSERT INTO orders_statuses (title)
VALUES ("Сформирован");

INSERT INTO products (category_id, vendor_code, title, short_description, full_description, price, quantity)
VALUES (1, "00000001", "LED телевизор SAMSUNG T32E310EX FULL HD",
        "Диагональ: 31.5; разрешение: 1920 x 1080; FULL HD; яркость: 300кд/м2; DVB-T2; DVB-С; VESA 200×200; USB: 1: HDMI: 2 : цвет: черный",
        "Диагональ: 31.5; разрешение: 1920 x 1080; FULL HD; яркость: 300кд/м2; DVB-T2; DVB-С; VESA 200×200; USB: 1: HDMI: 2 : цвет: черный",
        15190.00, 10),
       (1, "00000002", "LED телевизор XIAOMI Mi TV 4A 32 HD READY",
        "Диагональ: 31.5; разрешение: 1366 x 768; HD READY; яркость: 180кд/м2; SMART TV; DVB-T2; DVB-С; разъем Ethernet 1; VESA 100×100; USB: 2: HDMI: 3 : цвет: черный",
        "Диагональ: 31.5; разрешение: 1366 x 768; HD READY; яркость: 180кд/м2; SMART TV; DVB-T2; DVB-С; разъем Ethernet 1; VESA 100×100; USB: 2: HDMI: 3 : цвет: черный",
        11990.00, 10),
       (1, "00000003", "LED телевизор LG 43UK6200PLA Ultra HD 4K",
        "Диагональ: 43; разрешение: 3840 x 2160; Ultra HD 4K; SMART TV; DVB-T2; DVB-С; DVB-S2; разъем Ethernet 1; VESA 200×200; USB: 2: HDMI: 3 : цвет: черный",
        "Диагональ: 43; разрешение: 3840 x 2160; Ultra HD 4K; SMART TV; DVB-T2; DVB-С; DVB-S2; разъем Ethernet 1; VESA 200×200; USB: 2: HDMI: 3 : цвет: черный",
        23990.00, 10),
       (1, "00000004", "LED телевизор XIAOMI Mi TV 4S 50 Ultra HD 4K",
        "Диагональ: 50; разрешение: 3840 x 2160; Ultra HD 4K; SMART TV; DVB-T2; DVB-С; разъем Ethernet 1; VESA 200×300; USB: 3: HDMI: 3 : цвет: черный",
        "Диагональ: 50; разрешение: 3840 x 2160; Ultra HD 4K; SMART TV; DVB-T2; DVB-С; разъем Ethernet 1; VESA 200×300; USB: 3: HDMI: 3 : цвет: черный",
        27990.00, 10),
       (1, "00000005", "LED телевизор XIAOMI Mi TV 4S 43 Ultra HD 4K",
        "Диагональ: 43; разрешение: 3840 x 2160; Ultra HD 4K; яркость: 220кд/м2; SMART TV; DVB-T2; DVB-С; разъем Ethernet 1; VESA 300×300; USB: 2: HDMI: 3 : цвет: черный",
        "Диагональ: 43; разрешение: 3840 x 2160; Ultra HD 4K; яркость: 220кд/м2; SMART TV; DVB-T2; DVB-С; разъем Ethernet 1; VESA 300×300; USB: 2: HDMI: 3 : цвет: черный",
        22990.00, 10),
       (1, "00000006", "LED телевизор LG 49UK6200PLA Ultra HD 4K",
        "Диагональ: 49; разрешение: 3840 x 2160; Ultra HD 4K; SMART TV; DVB-T2; DVB-С; DVB-S2; разъем Ethernet 1; VESA 300×300; USB: 2: HDMI: 3 : цвет: черный",
        "Диагональ: 49; разрешение: 3840 x 2160; Ultra HD 4K; SMART TV; DVB-T2; DVB-С; DVB-S2; разъем Ethernet 1; VESA 300×300; USB: 2: HDMI: 3 : цвет: черный",
        27990.00, 10),
       (1, "00000007", "LED телевизор XIAOMI Mi TV 4S 55 Ultra HD 4K",
        "Диагональ: 55; разрешение: 3840 x 2160; Ultra HD 4K; SMART TV; DVB-T2; DVB-С; разъем Ethernet 1; VESA 300×300; USB: 3: HDMI: 3 : цвет: черный",
        "Диагональ: 55; разрешение: 3840 x 2160; Ultra HD 4K; SMART TV; DVB-T2; DVB-С; разъем Ethernet 1; VESA 300×300; USB: 3: HDMI: 3 : цвет: черный",
        33990.00, 10),
       (1, "00000008", "LED телевизор SAMSUNG UE32M5500AUXRU FULL HD",
        "Диагональ: 32; разрешение: 1920 x 1080; FULL HD; SMART TV; DVB-T2; DVB-С; DVB-S2; разъем Ethernet 1; VESA 100×100; USB: 2: HDMI: 3 : цвет: титан",
        "Диагональ: 32; разрешение: 1920 x 1080; FULL HD; SMART TV; DVB-T2; DVB-С; DVB-S2; разъем Ethernet 1; VESA 100×100; USB: 2: HDMI: 3 : цвет: титан",
        24499.00, 10),
       (1, "00000009", "LED телевизор DIGMA DM-LED24MQ12 HD READY",
        "Диагональ: 24; разрешение: 1366 x 768; HD READY; яркость: 180кд/м2; тюнер DVB-T; DVB-T2; DVB-С; VESA 100×100; USB: 1: HDMI: 1 : цвет: черный",
        "Диагональ: 24; разрешение: 1366 x 768; HD READY; яркость: 180кд/м2; тюнер DVB-T; DVB-T2; DVB-С; VESA 100×100; USB: 1: HDMI: 1 : цвет: черный",
        5990.00, 10),
       (1, "00000010", "LED телевизор TCL L43P8US Ultra HD 4K",
        "Диагональ: 43; разрешение: 3840 x 2160; Ultra HD 4K; яркость: 270кд/м2; SMART TV; DVB-T2; DVB-С; DVB-S2; разъем Ethernet 1; VESA 100×100; USB: 1: HDMI: 2 : цвет: стальной",
        "Диагональ: 43; разрешение: 3840 x 2160; Ultra HD 4K; яркость: 270кд/м2; SMART TV; DVB-T2; DVB-С; DVB-S2; разъем Ethernet 1; VESA 100×100; USB: 1: HDMI: 2 : цвет: стальной",
        23990.00, 10),
       (1, "00000011", "LED телевизор BBK 32LEM-1045/T2C HD READY",
        "Диагональ: 32; разрешение: 1366 x 768; HD READY; яркость: 250кд/м2; тюнер DVB-T; DVB-T2; DVB-С; VESA 100×100; USB: 1: HDMI: 3 : цвет: черный",
        "Диагональ: 32; разрешение: 1366 x 768; HD READY; яркость: 250кд/м2; тюнер DVB-T; DVB-T2; DVB-С; VESA 100×100; USB: 1: HDMI: 3 : цвет: черный",
        9090.00, 10),
       (1, "00000012", "LED телевизор DIGMA DM-LED32MQ10 HD READY",
        "Диагональ: 32; разрешение: 1366 x 768; HD READY; яркость: 180кд/м2; тюнер DVB-T; DVB-T2; DVB-С; VESA 100×100; USB: 1: HDMI: 2 : цвет: черный",
        "Диагональ: 32; разрешение: 1366 x 768; HD READY; яркость: 180кд/м2; тюнер DVB-T; DVB-T2; DVB-С; VESA 100×100; USB: 1: HDMI: 2 : цвет: черный",
        7290.00, 10);

INSERT INTO products_images (product_id, path)
VALUES (1, "312850_v01_s.jpg"),
       (2, "476478_v01_s.jpg"),
       (3, "1002323_v01_s.jpg"),
       (4, "1063858_v01_s.jpg"),
       (5, "1087323_v01_s.jpg"),
       (6, "1164014_v01_s.jpg"),
       (7, "1205501_v01_s.jpg"),
       (8, "1205616_v01_s.jpg"),
       (9, "1376849_v01_s.jpg"),
       (10, "1376863_v01_s.jpg"),
       (11, "1376866_v01_s.jpg"),
       (12, "1390314_v01_s.jpg");

INSERT INTO delivery_addresses (user_id, address)
VALUES (1, "18a Diagon Alley Silen Hill"),
       (1, "4 Privet Drive Tusent");