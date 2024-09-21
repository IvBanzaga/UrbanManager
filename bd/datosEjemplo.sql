INSERT INTO country (id, name) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), 'Spain'),
(UNHEX(REPLACE(UUID(), '-', '')), 'France'),
(UNHEX(REPLACE(UUID(), '-', '')), 'Germany');

INSERT INTO city (id, name, country_id) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), 'Madrid', (SELECT id FROM country WHERE name = 'Spain')),
(UNHEX(REPLACE(UUID(), '-', '')), 'Paris', (SELECT id FROM country WHERE name = 'France')),
(UNHEX(REPLACE(UUID(), '-', '')), 'Berlin', (SELECT id FROM country WHERE name = 'Germany'));

INSERT INTO postcode (id, code, city_id) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), '28001', (SELECT id FROM city WHERE name = 'Madrid')),
(UNHEX(REPLACE(UUID(), '-', '')), '75001', (SELECT id FROM city WHERE name = 'Paris')),
(UNHEX(REPLACE(UUID(), '-', '')), '10115', (SELECT id FROM city WHERE name = 'Berlin'));

INSERT INTO role (id, name) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), 'admin'),
(UNHEX(REPLACE(UUID(), '-', '')), 'user');

INSERT INTO user (id, firstname, lastname, second_lastname, address, phone, password, authentication, email, confidentiality, section, role_id, city_id, postcode_id, country_id, dni) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), 'John', 'Doe', NULL, 'Calle Mayor 1', '123456789', 'password123', 'email', 'john@example.com', TRUE, 'roads', (SELECT id FROM role WHERE name = 'admin'), (SELECT id FROM city WHERE name = 'Madrid'), (SELECT id FROM postcode WHERE code = '28001'), (SELECT id FROM country WHERE name = 'Spain'), '12345678X'),
(UNHEX(REPLACE(UUID(), '-', '')), 'Jane', 'Smith', 'Taylor', 'Rue de Rivoli 2', '987654321', 'password456', 'gmail', 'jane@example.com', TRUE, 'lighting', (SELECT id FROM role WHERE name = 'user'), (SELECT id FROM city WHERE name = 'Paris'), (SELECT id FROM postcode WHERE code = '75001'), (SELECT id FROM country WHERE name = 'France'), '87654321Y');

INSERT INTO media (id, user_id, report_id, path, type, dni) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), (SELECT id FROM user WHERE email = 'john@example.com'), NULL, '/path/to/photo.jpg', 'photo', '12345678X'),
(UNHEX(REPLACE(UUID(), '-', '')), (SELECT id FROM user WHERE email = 'jane@example.com'), NULL, '/path/to/video.mp4', 'video', '87654321Y');

INSERT INTO statistic (id, admin_id, total_reports, total_resolved, total_pending, total_processing) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), (SELECT id FROM user WHERE email = 'john@example.com'), 100, 80, 10, 10);

INSERT INTO tracking (id, report_id, user_id, previous_state, new_state, notification) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), (SELECT id FROM report WHERE description = 'Streetlight not working'), (SELECT id FROM user WHERE email = 'john@example.com'), 'pending', 'processing', FALSE),
(UNHEX(REPLACE(UUID(), '-', '')), (SELECT id FROM report WHERE description = 'Trash left uncollected'), (SELECT id FROM user WHERE email = 'jane@example.com'), 'pending', 'resolved', TRUE);

INSERT INTO history (id, user_id, report_id, action) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), (SELECT id FROM user WHERE email = 'john@example.com'), (SELECT id FROM report WHERE description = 'Streetlight not working'), 'create'),
(UNHEX(REPLACE(UUID(), '-', '')), (SELECT id FROM user WHERE email = 'jane@example.com'), (SELECT id FROM report WHERE description = 'Trash left uncollected'), 'create');

INSERT INTO report (id, user_id, admin_id, description, latitude, longitude, type, capture, category) VALUES 
(UNHEX(REPLACE(UUID(), '-', '')), (SELECT id FROM user WHERE email = 'john@example.com'), NULL, 'Streetlight not working', 40.416775, -3.703790, 'incident', 'photo', 'lighting'),
(UNHEX(REPLACE(UUID(), '-', '')), (SELECT id FROM user WHERE email = 'jane@example.com'), NULL, 'Trash left uncollected', 48.856613, 2.352222, 'complaint', 'video', 'waste');
