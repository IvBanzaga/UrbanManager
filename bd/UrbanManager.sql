CREATE TABLE country (
   id BINARY(16) PRIMARY KEY ,
   name VARCHAR(100) NOT NULL,
   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_deleted TIMESTAMP NULL

);

CREATE TABLE city (
   id BINARY(16) PRIMARY KEY ,
   name VARCHAR(100) NOT NULL,
   country_id BINARY(16) NOT NULL,
   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_deleted TIMESTAMP NULL,
   FOREIGN KEY (country_id) REFERENCES country(id)
);

CREATE TABLE postcode (
   id BINARY(16) PRIMARY KEY ,
   code VARCHAR(10) NOT NULL,
   city_id BINARY(16) NOT NULL,
   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_deleted TIMESTAMP NULL,
   FOREIGN KEY (city_id) REFERENCES city(id)
);

CREATE TABLE role (
    id BINARY(16) PRIMARY KEY,
    name ENUM('admin', 'user') NOT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_deleted TIMESTAMP NULL
);

CREATE TABLE user (
   id BINARY(16) PRIMARY KEY ,
   firstname VARCHAR(100) NOT NULL,
   lastname VARCHAR(100) NOT NULL,
   second_lastname VARCHAR(100) NULL,
   address VARCHAR(255) NOT NULL,
   phone VARCHAR(20) NOT NULL,
   password VARCHAR(255) NOT NULL,
   authentication ENUM('email', 'gmail', 'facebook'),
   email VARCHAR(100) UNIQUE NOT NULL,  
   confidentiality BOOLEAN DEFAULT TRUE NOT NULL,
   section ENUM('lighting', 'roads', 'furniture', 'others'),
   role_id BINARY(16) NOT NULL,
   city_id BINARY(16) NOT NULL,
   postcode_id BINARY(16) NOT NULL,
   country_id BINARY(16) NOT NULL,
   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_deleted TIMESTAMP NULL,
   FOREIGN KEY (role_id) REFERENCES role(id),
   FOREIGN KEY (city_id) REFERENCES city(id),
   FOREIGN KEY (postcode_id) REFERENCES postcode(id),
   FOREIGN KEY (country_id) REFERENCES country(id)
   
);

CREATE TABLE media (
   id BINARY(16) PRIMARY KEY ,
   user_id BINARY(16) NOT NULL,
   report_id BINARY(16),
   path VARCHAR(255) NOT NULL,
   type ENUM('photo', 'video', 'file') NOT NULL,
   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_deleted TIMESTAMP NULL,
   FOREIGN KEY (user_id) REFERENCES user(id),
   FOREIGN KEY (report_id) REFERENCES report(id)
);

CREATE TABLE report (
   id BINARY(16) PRIMARY KEY ,
   user_id BINARY(16) NOT NULL,
   admin_id BINARY(16),
   description VARCHAR(500),
   latitude DECIMAL(9, 6) NOT NULL,
   longitude DECIMAL(9, 6) NOT NULL,
   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_deleted TIMESTAMP NULL,
   type ENUM('incident', 'suggestion', 'complaint') NOT NULL,
   capture ENUM('photo', 'video') NOT NULL,
   state ENUM ('pending', 'processing', 'resolved') DEFAULT 'pending',
   category ENUM('waste', 'lighting', 'roads', 'others') NOT NULL,
   FOREIGN KEY (user_id) REFERENCES user(id),
   FOREIGN KEY (admin_id) REFERENCES user(id)
);

CREATE TABLE statistic (
   id BINARY(16) PRIMARY KEY ,
   admin_id BINARY(16) NOT NULL,
   start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   end_date TIMESTAMP NULL,
   total_reports INT NOT NULL,
   total_resolved INT NOT NULL,
   total_pending INT NOT NULL,
   total_processing INT NOT NULL,
   date_deleted TIMESTAMP NULL,
   FOREIGN KEY (admin_id) REFERENCES user(id)
);

CREATE TABLE tracking (
   id BINARY(16) PRIMARY KEY ,
   report_id BINARY(16) NOT NULL,
   user_id BINARY(16) NOT NULL,
   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_deleted TIMESTAMP NULL,
   previous_state ENUM ('pending', 'processing', 'resolved') NOT NULL,
   new_state ENUM ('pending', 'processing', 'resolved') NULL,
   notification BOOLEAN DEFAULT FALSE NOT NULL, 
   FOREIGN KEY (report_id) REFERENCES report(id),
   FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE history (
   id BINARY(16) PRIMARY KEY ,
   user_id BINARY(16) NOT NULL,
   report_id BINARY(16) NOT NULL,
   date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_deleted TIMESTAMP NULL,
   action ENUM('create', 'update', 'delete') NOT NULL,
   FOREIGN KEY (user_id) REFERENCES user(id),
   FOREIGN KEY (report_id) REFERENCES report(id)
);

