DELIMITER //

CREATE TRIGGER before_insert_country
BEFORE INSERT ON country
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER before_insert_city
BEFORE INSERT ON city
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER before_insert_postcode
BEFORE INSERT ON postcode
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER before_insert_role
BEFORE INSERT ON role
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER before_insert_user
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER before_insert_media
BEFORE INSERT ON media
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER before_insert_report
BEFORE INSERT ON report
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER before_insert_statistic
BEFORE INSERT ON statistic
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER before_insert_tracking
BEFORE INSERT ON tracking
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER before_insert_history
BEFORE INSERT ON history
FOR EACH ROW
BEGIN
   IF NEW.id IS NULL THEN
      SET NEW.id = UUID_TO_BIN(UUID());
   END IF;
END;
//

CREATE TRIGGER update_user_dni
AFTER INSERT ON media
FOR EACH ROW
BEGIN
    IF NEW.dni IS NOT NULL THEN
        UPDATE user
        SET dni = NEW.dni
        WHERE id = NEW.user_id AND dni IS NULL;
    END IF;
END //

DELIMITER ;