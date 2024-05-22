-- Début de la transaction
START TRANSACTION;

-- Création d'un nouveau docteur
INSERT INTO doctors (fullName, specialty, medicalSections, matricule, avatarURL, sex)
VALUES ('Dr. Stan', 'Cardiologie', '["Cardiologue"]', '123456789', 'path/to/avatar.png', 'homme');

-- Vérifiez que l'insertion a réussi
SET @last_insert_id = LAST_INSERT_ID();
SELECT @last_insert_id;

-- Création de l'utilisateur correspondant au docteur
INSERT INTO users (name, email, password, role, matricule, address)
VALUES ('Dr. Stan', 'dr.stan@soignemoi.com', SHA2('19962305Vp', 256), 'ROLE_DOCTOR', '123456789', '32400');

-- Vérifiez que l'insertion a réussi
SET @user_last_insert_id = LAST_INSERT_ID();
SELECT @user_last_insert_id;

-- Création de l'agenda pour le docteur
INSERT INTO agendas (doctor_matricule)
VALUES ('123456789');

-- Vérifiez que l'insertion a réussi
SET @agenda_last_insert_id = LAST_INSERT_ID();
SELECT @agenda_last_insert_id;

-- Commit de la transaction si toutes les opérations ont réussi
COMMIT;

-- En cas d'erreur, rollback de la transaction
ROLLBACK;
