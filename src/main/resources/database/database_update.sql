-- START SQL STATEMENTS DATE --> 16/08/2023
CREATE TABLE INGREDIENT (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text UNIQUE NOT NULL,
    kilocalories smallint NOT NULL,
    protein_amount smallint NOT NULL,
    carbohydrates_amount smallint NOT NULL,
    fat_amount smallint NOT NULL,
    entity_version bigint NOT NULL DEFAULT 0
);

CREATE TABLE ALLERGENIC (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL UNIQUE,
    entity_version bigint NOT NULL DEFAULT 0
);

CREATE TABLE RECIPE (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text,
    ingredients_description text,
    entity_version bigint NOT NULL DEFAULT 0
);

CREATE TABLE RECIPE_INGREDIENT (
    id_ingredient bigint,
    id_recipe bigint,
    entity_version bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (id_ingredient, id_recipe),
    FOREIGN KEY (id_ingredient) references INGREDIENT(id),
    FOREIGN KEY (id_recipe) references RECIPE(id)
);

CREATE TABLE RECIPE_ALLERGENIC (
    id_recipe bigint,
    id_allergenic bigint,
    entity_version bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (id_recipe, id_allergenic),
    FOREIGN KEY (id_recipe) references RECIPE(id),
    FOREIGN KEY (id_allergenic) references ALLERGENIC(id)
);

CREATE TABLE RECIPE_ELABORATION_STEP (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    step_number smallint NOT NULL,
    step_description text NOT NULL,
    entity_version bigint NOT NULL DEFAULT 0
);

CREATE TABLE RECIPE_RECIPE_ELABORATION_STEP (
    id_elaboration_step bigint,
    id_recipe bigint,
    entity_version bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (id_elaboration_step, id_recipe),
    FOREIGN KEY (id_elaboration_step) references RECIPE_ELABORATION_STEP(id),
    FOREIGN KEY (id_recipe) references RECIPE(id)
);

CREATE TABLE SALUHUD_USER_FITNESS_DATA (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    weight real,
    height real,
    biological_sex text,
    age smallint,
    body_composition text,
    recommended_daily_water_liters smallint,
    recommended_sleep_hours smallint,
    recommended_daily_steps smallint,
    daily_kilocalories_objective smallint,
    body_mass_index text,
    entity_version bigint NOT NULL DEFAULT 0
);

CREATE TABLE SALUHUD_USER (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    username text NOT NULL UNIQUE,
    password text NOT NULL,
    email text NOT NULL UNIQUE,
    name text NOT NULL,
    surname text,
    phone_number text UNIQUE,
    entity_version bigint NOT NULL DEFAULT 0
);

CREATE TABLE SALUHUD_USER_SALUHUD_USER_FITNESS_DATA (
    id_saluhud_user bigint,
    id_user_fitness_data bigint NOT NULL UNIQUE,
    entity_version bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (id_saluhud_user),
    FOREIGN KEY (id_user_fitness_data) references SALUHUD_USER_FITNESS_DATA(id),
    FOREIGN KEY (id_saluhud_user) references SALUHUD_USER(id)
);

-- Crea la tabla del historial de sueño
CREATE TABLE SLEEP_HISTORICAL (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint NOT NULL,
    entity_version bigint NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES SALUHUD_USER(id)
);

-- Crea la tabla de entrada del historial de sueño
CREATE TABLE SLEEP_HISTORICAL_ENTRY (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    sleep_historical_id bigint NOT NULL,
    entry_date date NOT NULL,
    hours_slept smallint NOT NULL,
    minutes_slept smallint NOT NULL,
    sleep_evaluation VARCHAR(255) NOT NULL,
    entity_version bigint NOT NULL DEFAULT 0,
    FOREIGN KEY (sleep_historical_id) REFERENCES SLEEP_HISTORICAL(id)
);

-- Crea la tabla del historial de pasos diarios
CREATE TABLE DAILY_STEPS_HISTORICAL (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint NOT NULL,
    entity_version bigint NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES SALUHUD_USER(id)
);

-- Crea la tabla de entrada del historial de pasos diarios
CREATE TABLE DAILY_STEPS_HISTORICAL_ENTRY (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    daily_steps_historical_id bigint NOT NULL,
    entry_date date NOT NULL,
    done_steps smallint NOT NULL,
    kilo_calories_burned real NOT NULL,
    steps_evaluation VARCHAR(255) NOT NULL,
    entity_version bigint NOT NULL DEFAULT 0,
    FOREIGN KEY (daily_steps_historical_id) REFERENCES DAILY_STEPS_HISTORICAL(id)
);

-- Crea la tabla del historial de peso
CREATE TABLE WEIGHT_HISTORICAL (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint NOT NULL,
    entity_version bigint NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES SALUHUD_USER(id)
);

-- Crea la tabla de entrada del historial de peso
CREATE TABLE WEIGHT_HISTORICAL_ENTRY ( 
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    weight_historical_id bigint NOT NULL,
    entry_date date NOT NULL,
    weight_entry real NOT NULL,
    height_entry real NOT NULL,
    kilo_calories_objective_entry real NOT NULL,
    entity_version bigint NOT NULL DEFAULT 0,
    FOREIGN KEY (weight_historical_id) REFERENCES WEIGHT_HISTORICAL(id)
);

-- Crea la tabla para el database update
CREATE TABLE SALUHUD_SYSTEM_METADATA ( 
    id bigint PRIMARY KEY,
    database_version varchar(255) NOT NULL,
    database_date date NOT NULL,
    mobile_app_expected_version varchar(255) NOT NULL,
    backend_expected_version varchar(255) NOT NULL,
    updated_by_saluhud_database_updater_version varchar(255) NOT NULL,
    entity_version bigint NOT NULL DEFAULT 0
);

INSERT INTO ALLERGENIC(name) VALUES ('GLUTEN');
INSERT INTO ALLERGENIC(name) VALUES ('CRUSTACEAN');
INSERT INTO ALLERGENIC(name) VALUES ('EGG');
INSERT INTO ALLERGENIC(name) VALUES ('FISH');
INSERT INTO ALLERGENIC(name) VALUES ('PEANUT');
INSERT INTO ALLERGENIC(name) VALUES ('SOYA_BEAN');
INSERT INTO ALLERGENIC(name) VALUES ('CELERY');
INSERT INTO ALLERGENIC(name) VALUES ('MUSTARD');
INSERT INTO ALLERGENIC(name) VALUES ('SESAME_SEED');
INSERT INTO ALLERGENIC(name) VALUES ('SULFUR_DIOXIDE_AND_SULPHITES');
INSERT INTO ALLERGENIC(name) VALUES ('LUPIN_BEAN');
INSERT INTO ALLERGENIC(name) VALUES ('NUTS');
INSERT INTO ALLERGENIC(name) VALUES ('MOLLUSK');
INSERT INTO ALLERGENIC(name) VALUES ('LACTOSE');
-- END SQL STATEMENTS DATE --> 16/08/2023

INSERT INTO SALUHUD_SYSTEM_METADATA(id, database_version, database_date, mobile_app_expected_version, backend_expected_version, updated_by_saluhud_database_updater_version) VALUES (1, '1.0.0', '2023-08-16', '1.0.0', '1.0.0', 'NONE');

-- START SQL STATEMENTS DATE --> 12/08/2024
ALTER TABLE IF EXISTS INGREDIENT ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS ALLERGENIC ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS RECIPE ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS RECIPE_INGREDIENT ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS RECIPE_ALLERGENIC ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS RECIPE_ELABORATION_STEP ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS RECIPE_RECIPE_ELABORATION_STEP ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS SALUHUD_USER_FITNESS_DATA ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS SALUHUD_USER ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS SALUHUD_USER_SALUHUD_USER_FITNESS_DATA ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS SLEEP_HISTORICAL ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS SLEEP_HISTORICAL_ENTRY ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS DAILY_STEPS_HISTORICAL ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS DAILY_STEPS_HISTORICAL_ENTRY ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS WEIGHT_HISTORICAL ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
ALTER TABLE IF EXISTS WEIGHT_HISTORICAL_ENTRY ADD COLUMN IF NOT EXISTS ENTITY_VERSION BIGINT;
-- END SQL STATEMENTS DATE --> 12/08/2024

UPDATE SALUHUD_SYSTEM_METADATA SET database_version = '1.0.1', database_date = '2024-08-12', mobile_app_expected_version = '1.0.0', backend_expected_version = '1.0.0' WHERE id = 1;

-- START SQL STATEMENTS DATE --> 15/08/2024
ALTER TABLE IF EXISTS SALUHUD_USER ADD COLUMN IF NOT EXISTS NAME TEXT NOT NULL;
ALTER TABLE IF EXISTS SALUHUD_USER ADD COLUMN IF NOT EXISTS SURNAME TEXT;
ALTER TABLE IF EXISTS SALUHUD_USER ADD COLUMN IF NOT EXISTS PHONE_NUMBER TEXT UNIQUE;
-- END SQL STATEMENTS DATE --> 15/08/2024

UPDATE SALUHUD_SYSTEM_METADATA SET database_version = '1.1.0', database_date = '2024-08-15', mobile_app_expected_version = '1.0.0', backend_expected_version = '1.0.0' WHERE id = 1;

-- START SQL STATEMENTS DATE --> 03/10/2024
ALTER TABLE IF EXISTS SLEEP_HISTORICAL_ENTRY ALTER COLUMN SLEEP_EVALUATION TYPE VARCHAR(255);
ALTER TABLE IF EXISTS DAILY_STEPS_HISTORICAL_ENTRY ALTER COLUMN steps_evaluation TYPE VARCHAR(255);
-- END SQL STATEMENTS DATE --> 03/10/2024

UPDATE SALUHUD_SYSTEM_METADATA SET database_version = '1.1.1', database_date = '2024-10-03', mobile_app_expected_version = '1.0.0', backend_expected_version = '1.0.0' WHERE id = 1;

-- START SQL STATEMENTS DATE --> 11/10/2024
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de algodón', 888, 0, 0, 100);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de cacahuete', 887, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de coco', 888, 0, 0, 100);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de colza', 888, 0, 0, 100);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de germen de trigo', 887, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de girasol', 887, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de grano de uva', 887, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de hígado de bacalao', 887, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de lino', 888, 0, 0, 100);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de nuez', 886, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de oliva', 887, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de oliva virgen extra', 888, 0, 0, 100);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de oliva virgen extra, producción ecologica', 888, 0, 0, 100);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de palma', 888, 0, 0, 100);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de sésamo', 888, 0, 0, 100);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceite de soja', 888, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceituna', 120, 1, 1, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aceituna negra, con hueso', 289, 2, 4, 29);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Acelga, cruda', 21, 2, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Acelga, en conserva', 17, 1, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Acelgas, hervidas', 29, 1, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Achicoria, cruda', 19, 0, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Agua de la red', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Agua mineral, mineralización debil', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Agua, con gas, embotellada', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aguacate', 137, 1, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aguacate congelado', 224, 1, 0, 23);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aguardiente', 237, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ajo', 117, 3, 24, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ajo, en polvo', 371, 16, 72, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ajo, frito', 102, 7, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Albahaca', 178, 14, 20, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Albaricoque', 42, 0, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Albondigas en conserva', 142, 6, 6, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Alcachofa, cruda', 23, 2, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Alcachofas en conserva', 18, 2, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Alcaparra', 26, 2, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Alioli', 785, 0, 2, 86);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Almeja', 48, 10, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Almejas en conserva', 81, 17, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Almendra, cruda', 589, 19, 6, 45);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Almendra, cruda, con cáscara', 589, 21, 5, 54);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Almendra, frita, salada', 593, 19, 4, 55);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Almendra, tostada', 590, 22, 6, 52);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Almidón de arroz', 350, 0, 85, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Almidón de maíz', 374, 0, 91, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Almidón de trigo', 354, 0, 86, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Altramuz', 399, 36, 40, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Alubia blanca, en conserva', 94, 6, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Alubia blanca, seca, cruda', 272, 22, 41, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Alubia negra, seca, remojada, hervida', 92, 8, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Anacardo, crudo', 577, 17, 32, 43);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Anchoas en aceite vegetal', 204, 28, 0, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Anguila, al horno', 223, 23, 0, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Anguila, cruda', 219, 19, 0, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Anguila, hervida', 197, 20, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Angula, cruda', 213, 16, 0, 16);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Anís, seco', 265, 0, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Aperitivos de trigo', 509, 10, 58, 25);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Apio, crudo', 11, 0, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Apio, en conserva en salmuera', 9, 0, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Arandano', 33, 0, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Arenque, ahumado', 254, 23, 0, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Arenque, salado', 300, 17, 0, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Arroz', 387, 7, 86, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Arroz con leche', 92, 3, 16, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Arroz hinchado, para el desayuno, enriquecido', 389, 6, 87, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Arroz integral, crudo', 386, 7, 81, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Arroz integral, hervido', 112, 2, 22, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Arroz, hervido', 393, 7, 85, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Atún en aceite de oliva isabel', 180, 26, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Atun en aceite vegetal', 205, 23, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Atún en escabeche', 101, 23, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Atún, al horno', 190, 29, 0, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Atún, al natural', 101, 23, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Atún, crudo', 119, 22, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Atún, plancha', 200, 23, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Avellana', 656, 12, 10, 56);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Avellana, cruda, con cáscara', 639, 12, 10, 61);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Avena, cruda', 401, 16, 66, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Avestruz, solomillo, crudo', 115, 21, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Azafrán', 350, 11, 61, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Azúcar blanca', 408, 0, 100, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Azúcar, moreno', 398, 0, 97, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bacaladilla', 77, 17, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bacalao, ahumado', 80, 18, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bacalao, crudo', 83, 18, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bacalao, fresco, al horno', 100, 22, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bacalao, frito', 75, 16, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bacalao, salado, crudo', 322, 75, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bacalao, salado, remojado, crudo', 110, 26, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bacón, ahumado, a la parrilla', 292, 23, 0, 22);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bacon, crudo, con grasa separable', 546, 8, 0, 57);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bambú, crudo', 34, 2, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Barra chocolate, tipo "bounty"', 492, 4, 58, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Barra de chocolate, tipo "Kit-kat"', 501, 6, 63, 24);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Barra de chocolate, tipo "Mars"', 456, 5, 65, 18);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Barrita cereales con chocolate', 397, 9, 73, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Barrita cereales con frutas', 395, 8, 78, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Barrita cereales maíz y trigo', 431, 7, 68, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Barrita cereales trigo y chocolate', 437, 8, 66, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Batido de chocolate', 83, 2, 9, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Batido de fresa', 66, 2, 11, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Batido de soja', 82, 5, 3, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Batido fermentado de soja', 90, 2, 17, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Batido lácteo de cacao, bajo en calorías', 48, 3, 4, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Batido lácteo, de fresa, bajo en calorías', 112, 3, 22, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bebida de soja', 53, 3, 5, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bebida energética', 5, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bebida isotónica', 32, 0, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Berberechos', 48, 10, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Berberechos en conserva', 48, 10, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Berenjena', 20, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Berenjena, frita, en aceite de girasol', 299, 1, 2, 31);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Berro, crudo', 12, 2, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Besugo', 90, 18, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bígaro, hervido', 95, 20, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bizcocho', 383, 6, 39, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bocadillo', 225, 11, 35, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bogavante', 92, 18, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bogavante, hervido', 104, 22, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bollería, genérico', 448, 7, 52, 23);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bombón', 477, 4, 66, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Boniato, crudo', 101, 1, 23, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bonito del norte, al vapor', 164, 30, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bonito del norte, enlatado en aceite de soja', 206, 32, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bonito en aceite vegetal', 200, 23, 0, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Bonito, enlatado en aceite, escurrido', 204, 26, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Boquerón', 128, 17, 0, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Boquerón, frito', 137, 20, 0, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Borraja', 26, 1, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Breca, cruda', 76, 15, 1, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Brécol, crudo', 26, 3, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Brécol, hervido', 24, 3, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Butifarra', 241, 10, 5, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Caballa, al horno', 249, 16, 0, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Caballa, cruda', 182, 18, 0, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Caballa, enlatada en aceite, escurrida', 208, 14, 0, 16);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cabracho o rascacio, crudo', 92, 19, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cabrito lechal, costillar, asado', 265, 22, 0, 19);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cabrito lechal, costillar, crudo', 225, 17, 0, 17);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cabrito lechal, espalda, cruda', 205, 18, 0, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cabrito lechal, pierna, cruda', 190, 18, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cabrito, parte s/e, crudo, con grasa separable', 114, 19, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cacahuete, crudo, con cáscara', 544, 25, 7, 43);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cacahuete, frito, salado', 592, 26, 8, 50);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cacahuete, tostado, salado', 600, 24, 7, 53);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cacao en polvo, azucarado', 390, 5, 81, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cacao, en polvo, azucarado, bajo en calorías', 386, 9, 67, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Café, con leche', 38, 1, 2, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Café, en grano o molido, descafeinado', 303, 10, 30, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Café, en polvo, sin reconstituir', 111, 18, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Café, en polvo, soluble', 120, 18, 11, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Café, infusión', 2, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Café, infusión, descafeinado', 2, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Café, sucedáneo, soluble', 410, 12, 80, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Calabacín', 17, 1, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Calabacín, asado', 18, 1, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Calabaza, cruda', 32, 1, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Calabaza, hervida', 12, 0, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Calamar, asado', 81, 16, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Calamar, conserva', 89, 17, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Calamar, crudo', 72, 14, 1, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Calamares en aceite vegetal', 217, 22, 0, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Caldo vegetal', 105, 11, 9, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Callos de ternera', 95, 14, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Camarón', 83, 17, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Canela, en polvo', 373, 3, 80, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Canelones', 192, 11, 9, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cangrejo', 124, 19, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cangrejo de río crudo', 125, 19, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cangrejo, en conserva', 99, 19, 1, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Canonigos', 14, 1, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Caqui', 67, 0, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Caracol', 86, 16, 2, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Caramelo', 389, 0, 95, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cardo', 22, 1, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cardo, tallo, en conserva', 14, 0, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de cerdo de capa blanca, cabezada, parte magra, cruda', 165, 21, 3, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de cerdo de capa blanca, cabezada, partes grasa y magra, crudo', 254, 20, 8, 19);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de cerdo de capa blanca, chuleta, parte magra, cruda', 138, 22, 2, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de cerdo de capa blanca, chuleta, partes grasa y magra, cruda', 160, 22, 3, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de cerdo de capa blanca, jamón, parte magra, crudo', 127, 24, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de cerdo de capa blanca, jamón, partes grasa y magra, crudo', 129, 23, 1, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de cerdo de capa blanca, lomo, parte magra, crudo', 124, 24, 1, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de cerdo de capa blanca, lomo, partes grasa y magra, crudo', 142, 24, 2, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de vacuno, cadera, partes magra y grasa, crudo', 288, 21, 0, 19);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de vacuno, costillar, partes magra y grasa, crudo', 288, 22, 0, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de vacuno, lomo, partes magra y grasa, crudo', 288, 26, 0, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de vacuno, rabo, partes magra y grasa, crudo', 288, 24, 0, 18);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de vacuno, carrillera, partes magra y grasa, crudo', 288, 22, 0, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de vacuno, redondo, partes magra y grasa, crudo', 288, 28, 0, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne de vacuno, solomillo, partes magra y grasa, crudo', 288, 26, 0, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carne picada', 244, 15, 0, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carpa, al horno', 149, 20, 0, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Carpa, cruda', 116, 17, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Castaña, cruda', 179, 2, 36, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Castaña, tostada', 225, 4, 39, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cava', 70, 0, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Caviar', 276, 24, 4, 17);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cebada, cruda', 323, 10, 64, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cebolla', 26, 1, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cebolla, asada', 38, 1, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cebolla, hervida', 18, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cebollino, crudo', 25, 3, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cecina', 243, 39, 0, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Centeno, crudo', 408, 14, 79, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Centollo, crudo', 128, 20, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerdo, chuleta, crudo', 211, 19, 0, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerdo, costilla, crudo', 279, 17, 0, 23);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerdo, lomo, asado', 237, 27, 0, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerdo, lomo, crudo', 152, 18, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerdo, panceta, cruda', 467, 12, 0, 46);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerdo, parte sin especificar', 272, 16, 0, 23);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerdo, pierna, cruda, con grasa separable', 212, 19, 0, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerdo, solomillo, asado', 159, 28, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerdo, solomillo, crudo', 131, 21, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales base trigo y chocolate', 385, 8, 81, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de arroz chocolateado', 388, 6, 86, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de arroz y miel', 385, 5, 87, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de arroz, trigo y fruta', 356, 5, 76, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de maíz y miel', 394, 6, 83, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de maíz y trigo', 381, 6, 80, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de maíz, trigo y avena', 416, 6, 80, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de trigo azucarado', 385, 7, 84, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de trigo y arroz', 380, 16, 75, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de trigo y frutas', 367, 8, 71, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de trigo y miel', 397, 5, 88, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de trigo, avena, maiz y miel', 398, 8, 79, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base de trigo, avena, maíz, miel y nueces', 393, 11, 80, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno base muesli', 372, 10, 65, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales desayuno, maíz azucarado', 382, 4, 88, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales para el desayuno, ricos en fibra, tipo "all-bran"', 267, 14, 45, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereales, en polvo, solubles (eko)', 393, 5, 89, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cereza', 63, 0, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerveza con alcohol', 42, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerveza sin alcohol', 26, 0, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerveza, baja en alcohol', 34, 0, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cerveza, oscura, 8°- 9°', 67, 0, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Champiñon', 26, 1, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Champiñones en conserva', 14, 2, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chayote, crudo', 23, 0, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chicle, sin azúcar', 3, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chile, rojo', 34, 1, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chile, verde', 17, 0, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chipiron', 82, 16, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chirimoya', 87, 1, 20, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chirla', 47, 10, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chistorra', 515, 15, 0, 50);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chocolate blanco', 547, 8, 58, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chocolate con leche', 538, 9, 54, 31);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chocolate con leche y almendras', 549, 8, 49, 35);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chocolate con leche y arroz', 517, 6, 63, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chocolate con nueces de macadamia', 590, 7, 47, 41);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chocolate negro, con almendras', 535, 8, 41, 37);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chocolate negro, con azúcar', 532, 2, 63, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chocolate, negro', 543, 4, 64, 29);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Choped pork', 309, 14, 3, 27);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chorizo', 323, 27, 1, 23);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Chufa, cruda', 409, 6, 42, 23);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Churro', 360, 4, 40, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ciervo, parte s/e, crudo, con grasa separable', 105, 22, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cigala', 87, 17, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ciruela, con piel, cruda', 54, 0, 12, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ciruela, sin piel', 47, 0, 11, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Coco, desecado', 588, 6, 11, 58);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Coco, fresco', 373, 3, 15, 33);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Col blanca, cruda', 36, 4, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Col de bruselas, cruda', 35, 4, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Col lombarda, hervida', 18, 1, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Col rizada, cruda', 34, 3, 1, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Coliflor, congelada, cruda', 18, 2, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Coliflor, hervida', 27, 2, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Comino', 419, 17, 45, 18);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Complejo vitaminico', 567, 20, 18, 45);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Coñac', 233, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Conejo de granja, carne, cruda', 132, 20, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Conejo, entero, estofado', 195, 29, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Confitura, frutas s/e, baja en calorías', 226, 0, 55, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Congrio', 102, 19, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Corazón de cordero, crudo', 119, 16, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Corazón de pollo, crudo', 149, 15, 0, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Corazon de vaca, crudo', 105, 17, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Corazón, de cerdo, crudo', 115, 17, 1, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Corazón, de vaca/buey, cocido', 164, 27, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Corazón, de vaca/buey, crudo', 104, 17, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero lechal, costillar, asado', 235, 21, 0, 16);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero lechal, costillar, crudo', 192, 18, 0, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero lechal, espalda, cruda', 190, 19, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero lechal, pierna, cruda', 188, 19, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero ligero, costillar, asado', 274, 21, 0, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero ligero, costillar, crudo', 234, 17, 0, 18);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero ligero, espalda, cruda', 201, 17, 0, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero ligero, pierna, cruda', 184, 18, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero, costilla, crudo', 242, 15, 0, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero, parte sin especificar', 354, 15, 0, 32);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cordero, pierna, con grasa, asada', 223, 25, 0, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Corteza de trigo', 484, 10, 52, 25);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema catalana', 104, 3, 15, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema de almendras', 380, 4, 59, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema de cacahuete', 602, 25, 11, 50);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema de chocolate con avellanas', 544, 5, 56, 33);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema de chocolate y nata', 86, 3, 9, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema de chocolate, baja en calorías', 75, 3, 13, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema de coco', 125, 2, 19, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema de vainilla y mousse de chocolate', 131, 4, 22, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema inglesa', 124, 5, 11, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Crema pastelera', 159, 4, 22, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cremoso san millan', 262, 6, 3, 25);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Croissant', 408, 7, 55, 17);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Croissant de chocolate', 481, 5, 79, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Croquetas de pollo', 154, 5, 20, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cuajada', 87, 4, 6, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cubata', 109, 0, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Cubito de caldo', 251, 15, 5, 18);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Curry', 439, 15, 60, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Dátil', 288, 2, 67, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Donut', 395, 6, 42, 22);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Donut, de chocolate', 454, 4, 51, 25);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Dorada, cruda', 78, 17, 0, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Dorada, plancha', 93, 17, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Empanada de carne', 299, 21, 12, 18);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Empanadilla', 248, 4, 29, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Endibia', 9, 1, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Eneldo, seco', 292, 19, 42, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ensaimada', 458, 5, 38, 31);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ensalada', 19, 1, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ensaladilla rusa', 110, 2, 9, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Escarola', 12, 1, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Espárrago, verde', 25, 2, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Esparragos blancos en conserva', 24, 1, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Espinaca, en conserva', 15, 2, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Espinaca, hervida', 22, 2, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Espinaca, picada, congelada, cruda', 22, 2, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Fabada', 158, 6, 13, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Faneca, cruda', 76, 15, 1, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Flamenquín', 231, 19, 4, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Flan de huevo', 133, 4, 20, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Flan de huevo, bajo en calorías', 77, 5, 7, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Fletan, crudo', 85, 17, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Foie gras', 444, 10, 3, 44);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Frambuesa, cruda', 38, 1, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Fresa', 36, 0, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Fritos de maíz', 566, 6, 51, 37);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Fructosa', 408, 0, 100, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Frutos secos', 566, 1, 25, 51);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Fuet', 475, 19, 5, 42);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galleta ,tipo "digestiva", con chocolate', 513, 6, 66, 24);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galleta salada', 409, 9, 69, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galleta, barquillo, con jalea de frutas', 369, 5, 73, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galleta, cubierta de chocolate', 543, 5, 67, 27);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galleta, genérico', 483, 6, 64, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galleta, tipo "Digestiva"', 468, 6, 63, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galletas integrales', 404, 10, 42, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galletas saladas, con queso', 482, 11, 49, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galletas tipo maria', 479, 7, 69, 19);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galletas, con chocolate, tipo "cookies"', 491, 6, 64, 22);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Galletas, de mantequilla', 484, 7, 68, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gallina, entera, cruda', 231, 17, 0, 18);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gallo', 81, 15, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gamba quisquilla, congelada', 75, 16, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gamba roja, cruda', 90, 18, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gamba, hervida', 96, 19, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Garbanzo, en conserva', 133, 7, 14, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Garbanzo, hervido', 360, 8, 18, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Garbanzo, seco, crudo', 336, 19, 49, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gazpacho', 34, 0, 1, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gelatina', 344, 84, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Germen de trigo', 337, 25, 33, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ginebra', 220, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gofio', 399, 10, 81, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gomasio', 89, 2, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gominola, genérica', 268, 4, 69, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Granada', 63, 1, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Grasa de pollo', 886, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Grelo', 11, 2, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Grosella negra, cruda', 36, 1, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Grosella, cruda', 27, 1, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Guayaba, enlatada en almíbar', 66, 0, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Guayaba, sin piel, cruda', 57, 0, 11, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Guindilla, en polvo', 305, 12, 31, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Guindilla, picante', 45, 1, 6, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Guisante, congelado, crudo', 62, 5, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Guisante, congelado, hervido', 61, 6, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Guisante, seco, crudo', 337, 21, 56, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Guisantes en conserva', 67, 5, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Gusanito', 478, 9, 50, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Haba, fresca', 57, 4, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Haba, frita', 57, 4, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Haba, seca', 358, 26, 58, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Haba, seca, remojada, hervida', 58, 5, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Harina de avena', 353, 15, 57, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Harina de avena, cocida en agua', 46, 1, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Harina de cebada', 361, 10, 74, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Harina de centeno', 359, 8, 75, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Harina de maíz', 329, 8, 66, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Harina de soja', 412, 37, 13, 23);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Harina de trigo', 333, 10, 71, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Harina de trigo, integral', 322, 11, 62, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Helado de chocolate', 228, 3, 28, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Helado de fresa', 200, 3, 27, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Helado de nata', 211, 3, 24, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Higado de pollo, crudo', 137, 22, 1, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Hígado, de cerdo, crudo', 120, 21, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Hígado, de vaca/buey, crudo', 136, 21, 3, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Higos y brevas', 70, 1, 16, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Hinojo', 14, 1, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Hojaldre', 552, 7, 44, 38);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Horchata', 98, 1, 17, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de codorniz, entero, crudo', 154, 13, 0, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de gallina fresco', 150, 12, 0, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de gallina, clara, cruda', 45, 10, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de gallina, escalfado', 147, 12, 0, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de gallina, frito', 185, 13, 0, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de gallina, hervido, duro', 145, 12, 0, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de gallina, pasado por agua', 144, 12, 0, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de gallina, revuelto, con mantequilla', 229, 10, 0, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de gallina, yema, cruda', 356, 16, 2, 31);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de gallina, yema, desecada', 664, 31, 2, 59);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de pato, crudo', 163, 14, 0, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Huevo de pavo, entero, crudo', 164, 13, 1, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Infusión', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Jalea real', 266, 0, 65, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Jamón asado', 266, 26, 0, 17);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Jamón cocido, categoría s/e', 114, 21, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Jamón cocido, enlatado', 126, 18, 1, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Jamón ibérico de bellota', 335, 33, 0, 22);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Jamón ibérico de cebo', 303, 32, 0, 19);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Jamón serrano', 319, 28, 0, 22);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Jengibre', 52, 1, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Judía blanca', 242, 21, 34, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Judía pinta', 247, 23, 35, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Judía verde, congelada, cruda', 29, 1, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Judía verde, cruda', 28, 2, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Judia verde, hervida', 84, 1, 3, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Judías blancas, cocidas', 324, 21, 54, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Judias verdes en conserva', 12, 1, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Jurel, crudo', 112, 15, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Kebab', 305, 8, 16, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Kefir', 64, 3, 4, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ketchup', 104, 3, 21, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Kiwi', 52, 1, 10, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lacón', 214, 19, 9, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Langosta', 91, 18, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Langostino', 112, 24, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lasaña', 138, 6, 10, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Laurel, hoja', 304, 7, 48, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche condensada, entera, con azúcar', 336, 8, 53, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche de almendra', 353, 14, 60, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche de cabra', 65, 3, 4, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche de coco', 209, 2, 2, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche de oveja', 100, 5, 5, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche de vaca, desnatada, condensada, con azúcar', 287, 10, 60, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche de vaca, entera', 65, 3, 4, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche en polvo, semidesnatada', 445, 29, 43, 16);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche fermentada, bifidobacterium, entera, natural', 63, 3, 4, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche materna', 69, 1, 7, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche merengada', 84, 3, 10, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche, desnatada, pasteurizada', 34, 3, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Leche, semidesnatada, pasteurizada', 46, 3, 4, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lechuga', 16, 1, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lecitina de soja', 503, 0, 8, 53);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lengua de cerdo, cruda', 157, 16, 0, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lengua de cordero, cruda', 192, 15, 0, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lengua, de buey, cruda', 219, 14, 3, 16);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lengua, de ternera, cruda', 136, 17, 0, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lenguado', 79, 16, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lenguado, al horno', 74, 16, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lenguado, frito', 93, 17, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lenguado, plancha', 135, 15, 0, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lenteja, en conserva', 74, 6, 11, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lenteja, hervida', 333, 23, 54, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lenteja, seca, cruda', 310, 24, 48, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Licor apricot', 249, 0, 30, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Licor benedictine', 260, 0, 33, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Licor curaçao', 317, 0, 30, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Licor de café', 345, 0, 46, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Licor de crema 15-17% vol.', 324, 0, 20, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Licores de frutas', 227, 0, 35, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Liebre, entera, cruda', 193, 29, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lija, cruda', 136, 18, 0, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lima, cruda', 8, 0, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Limonada', 12, 0, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Litchi, crudo', 67, 0, 14, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lombarda', 22, 1, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lomo embuchado', 323, 34, 0, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Longaniza', 346, 25, 0, 27);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lubina', 85, 18, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Lucio, al horno', 95, 21, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Macedonia de frutas, conserva en su jugo', 107, 0, 25, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Magdalena', 387, 6, 39, 22);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Maíz, en mazorca, congelado, crudo', 95, 3, 18, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Maíz, en mazorca, crudo', 392, 8, 85, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mandarina', 40, 0, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mandarina, congelada', 42, 0, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mango, crudo', 59, 0, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Manteca', 879, 0, 0, 99);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mantequilla salada', 733, 0, 0, 82);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mantequilla, baja en calorías', 503, 3, 0, 55);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Manzana', 50, 0, 12, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Margarina de maíz', 718, 0, 0, 80);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Margarina, baja en calorías', 363, 1, 0, 40);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Masa de hojaldre, cruda', 410, 4, 31, 29);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mayonesa con aceite de girasol', 700, 1, 5, 75);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mayonesa, aceite de oliva', 785, 2, 0, 87);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mayonesa, aceite de soja', 710, 1, 0, 79);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mayonesa, baja en calorías', 298, 1, 10, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mejillon', 61, 10, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mejillón, en conserva, al natural', 83, 12, 2, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mejillón, en escabeche', 168, 10, 0, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mejillón, hervido', 112, 18, 3, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Melocotón', 39, 0, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Melocotón en almíbar', 58, 0, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Melocotón, desecado', 272, 3, 61, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Melón', 27, 0, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Membrillo, crudo', 29, 0, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Menestra de verduras, congelada', 45, 3, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Menta, fresca', 44, 3, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Merluza fresca', 65, 11, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Merluza, congelada, cruda', 85, 16, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Merluza, rebozada, frita', 149, 10, 3, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mermelada de albaricoque', 15, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mermelada de albaricoque y melocotón, baja en calorías', 222, 0, 53, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mermelada de ciruela', 15, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mermelada de frambuesa', 253, 0, 60, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mermelada de fresa', 250, 0, 59, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mermelada de fresa, baja en calorías', 222, 0, 53, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mermelada de grosella roja', 242, 0, 58, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mermelada de mora', 242, 0, 58, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mermelada de naranja', 19, 0, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mero, crudo', 88, 19, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mero, plancha', 147, 14, 0, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Miel', 315, 0, 76, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mijo', 345, 11, 64, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Miso', 209, 11, 26, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mojo picon', 712, 0, 1, 78);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Molleja de cordero', 132, 15, 0, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Morcilla', 324, 11, 3, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Morcilla, frita', 307, 12, 15, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mortadela', 295, 14, 3, 25);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mostaza', 133, 5, 5, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mousse de chocolate', 247, 5, 37, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mousse de queso fresco, con frutas', 135, 5, 16, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mousse de queso fresco, desnatado, azucarado', 106, 8, 11, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mousse de queso fresco, desnatado, con frutas', 117, 5, 19, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mousse de yogur, con frutas', 145, 3, 17, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mousse de yogur, natural', 166, 4, 15, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Muesli', 383, 9, 61, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mújol, al horno', 148, 24, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Mújol, crudo', 128, 15, 0, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nabo, pelado, crudo', 19, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Napolitana, rellena con crema de cacao', 468, 7, 49, 27);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Naranja', 38, 0, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nata montada', 304, 2, 3, 31);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nata, líquida, para cocinar, 18% de grasa', 202, 2, 3, 19);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Natillas sabor vainilla', 104, 3, 15, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nécora', 124, 19, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de albaricoque, envasado', 58, 0, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de ciruela', 15, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de frutas exóticas, envasado', 55, 0, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de mango, envasado', 57, 0, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de maracuyá, envasado', 53, 0, 12, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de melocotón', 17, 0, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de naranja, envasado', 42, 0, 10, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de pera, envasado', 65, 0, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de piña', 22, 0, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Néctar de pomelo', 15, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nectarina', 43, 1, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Níscalo, crudo', 14, 1, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Níspero, con piel, crudo', 53, 0, 12, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nispero, conserva en su jugo', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nispero, sin piel , congelado', 39, 0, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nuez', 595, 14, 3, 63);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nuez moscada', 547, 5, 49, 36);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Nuez, cruda, con cáscara', 595, 14, 3, 59);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Oca, sin piel, asada', 276, 29, 0, 17);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Orégano, seco', 418, 11, 68, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ostra, cruda', 64, 8, 2, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Paella', 173, 12, 17, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Paella marinera', 123, 3, 25, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Palmera', 536, 5, 61, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Palmito, en conserva', 47, 2, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Palometa, cruda', 126, 20, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Palomitas de maíz, sin aceite, sin sal', 343, 12, 62, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan blanco, de barra', 240, 8, 47, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan blanco, de barra, sin sal', 263, 8, 53, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan blanco, de molde, tostado', 249, 7, 45, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan blanco, frito', 260, 8, 51, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan blanco, tipo "baguette"', 271, 8, 55, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan blanco, tostado', 305, 10, 59, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan blanco, tostado sin sal', 305, 10, 59, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan de avena', 271, 8, 48, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan de cebada', 199, 6, 39, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan de centeno', 221, 6, 45, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan de leche', 416, 10, 52, 18);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan de maíz', 314, 7, 48, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan integral', 251, 10, 44, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan integral, de molde, tostado', 251, 10, 44, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan integral, sin sal', 251, 10, 44, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan integral, tostado', 269, 10, 48, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan rallado', 259, 8, 51, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan tostado integral', 305, 10, 59, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pan, tipo hamburguesa', 266, 7, 47, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Panceta, frita', 737, 4, 0, 80);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Panga, cruda', 67, 13, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Papaya, cruda', 33, 0, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Paraguaya', 46, 0, 10, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pasta alimenticia, con huevo, cruda', 375, 13, 69, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pasta alimenticia, con huevo, hervida', 126, 4, 22, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pasta alimenticia, con vegetales, cruda', 340, 12, 67, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pasta alimenticia, cruda', 353, 12, 70, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pasta alimenticia, integral, cruda', 347, 13, 66, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pasta alimenticia, integral, hervida', 122, 4, 23, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pasta alimenticia, rellena con carne, hervida', 101, 4, 12, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pasta de fruta', 258, 1, 62, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pasta de sésamo', 593, 18, 0, 58);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pastas de te', 348, 8, 58, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pastel', 401, 5, 49, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pastel con fruta confitada', 369, 5, 57, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pastel de chocolate', 440, 5, 41, 27);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pastel de manzana', 383, 3, 57, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Patata, asada', 206, 4, 46, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Patata, cruda', 73, 2, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Patata, frita con aceite s/e, sin sal', 290, 3, 30, 17);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Patata, hervida', 75, 2, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Patata, prefrita, congelada', 270, 4, 32, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Patata, salteada con aceite girasol', 135, 1, 13, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Patatas chips, "lights"', 459, 7, 57, 22);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Patatas, fritas, chips', 538, 6, 49, 34);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pate de higado de cerdo, 30% de grasa', 339, 14, 5, 29);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Paté de pimienta', 290, 11, 11, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pato, entero, asado', 189, 25, 0, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pato, entero, crudo', 138, 19, 0, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pavo, crudo', 158, 20, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pavo, fiambre', 148, 15, 0, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pavo, fiambre, bajo en grasa', 101, 19, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pavo, muslo, con piel, crudo', 151, 18, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pavo, pechuga, con piel, crudo', 107, 24, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pavo, pechuga, sin piel, a la plancha', 145, 29, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pepinillos en vinagre', 16, 1, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pepino', 12, 0, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pera', 45, 0, 10, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pera, enlatada en almíbar', 62, 0, 14, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Perca, al horno', 98, 21, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Perca, cruda', 90, 18, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Percebe', 60, 13, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Perdiz, cruda', 112, 22, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Perejil, fresco', 35, 3, 2, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pescadilla, congelada, cruda', 55, 11, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pescadilla, rebozada en harina, frita', 177, 18, 3, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pescado, genérico', 96, 20, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Petit líquido, sabor fresa', 79, 2, 14, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Petit suïsse, cereales y fruta', 166, 7, 16, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Petit suisse, chocolate', 175, 4, 24, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Petit suisse, fresa', 128, 7, 16, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Petit Suisse, natural azucarado', 122, 7, 14, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pez espada, crudo', 111, 18, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pez espada, emperador, plancha', 148, 16, 1, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pichón, sin piel, asado', 178, 37, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pijota, cruda', 65, 11, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pimentón, en polvo', 331, 14, 38, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pimienta, blanca', 232, 10, 42, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pimienta, negra', 230, 11, 38, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pimiento morrón, en conserva', 30, 1, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pimiento rojo, crudo', 29, 1, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pimiento, frito', 20, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Piña', 49, 0, 11, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Piña en almíbar', 65, 0, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Piña, enlatada en su jugo', 50, 0, 11, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Piñon', 683, 14, 4, 62);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Piñón, crudo, con cáscara', 682, 14, 3, 68);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pipa de calabaza', 603, 30, 10, 47);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pipa de girasol', 574, 27, 20, 43);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pipas de girasol, peladas, con sal', 627, 17, 12, 56);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pistacho', 594, 17, 15, 49);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pizza, precocinada', 211, 8, 22, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Plátano', 89, 1, 20, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Platija, al vapor', 102, 19, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Platija, cruda', 83, 17, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo empanado, frito', 228, 17, 5, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, ala, con piel, cruda', 217, 18, 0, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, entero, con piel, asado', 177, 32, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, entero, con piel, crudo', 167, 20, 0, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, fiambre', 140, 19, 2, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, fiambre, bajo en grasa', 87, 18, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, frito', 202, 17, 0, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, muslo, con piel, asado', 227, 26, 0, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, muslo, con piel, crudo', 110, 19, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, parte sin especificar', 166, 19, 0, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, pechuga, con piel, crudo', 105, 23, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pollo, pechuga, plancha', 146, 22, 0, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pomelo', 26, 0, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Preparado lácteo con omega 3', 53, 3, 5, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pudding de pasas', 297, 4, 47, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Puerro, crudo y congelado', 24, 1, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Puerro, en conserva', 26, 2, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pulmón, de cerdo, crudo', 82, 14, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pulmón, de cordero, crudo', 91, 16, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pulmón, de ternera, crudo', 88, 16, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pulpo', 91, 17, 1, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Pulpo, hervido', 69, 13, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Puré de patata y queso, en copos', 462, 10, 70, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Puré de patata, con verduras, en copos', 361, 4, 74, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Puré de patata, en copos', 361, 8, 78, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Puré de patatas y champiñones, en copos', 389, 10, 75, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Puré, de patata, con leche', 95, 2, 13, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso afuegal pitu', 469, 26, 0, 40);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso ahumado de aliva', 408, 25, 0, 34);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso azul', 351, 21, 0, 29);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso brie', 343, 17, 0, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso cabra, curado', 464, 27, 0, 39);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso cabrales', 377, 21, 0, 32);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Camembert 20-30% MG/ES', 201, 24, 0, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso camembert 60% mg/es', 350, 13, 0, 33);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso cantabria', 356, 21, 0, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso casín', 368, 23, 0, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Castellano', 459, 26, 0, 39);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso cebreiro', 258, 14, 0, 22);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Cheddar', 405, 26, 0, 33);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso curado, genérico', 450, 35, 0, 34);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de aracena', 390, 21, 0, 33);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de arzúa', 397, 22, 2, 34);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de bola', 336, 20, 0, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de cádiz', 308, 16, 0, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de Castilla-La Mancha, oveja y cabra', 406, 21, 0, 35);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de Castilla-La Mancha, oveja, vaca y cabra', 413, 23, 0, 35);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de castilla-león, oveja y vaca', 410, 22, 0, 35);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de murcia, al vino', 440, 23, 0, 38);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de tenerife', 342, 19, 0, 29);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso de tiétar', 398, 21, 0, 35);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso edam', 336, 20, 0, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso emmental', 367, 27, 0, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso en porciones', 310, 18, 2, 25);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso flor de guía', 387, 27, 0, 31);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso fresco de burgos', 198, 12, 2, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso fresco, cabra', 298, 19, 1, 23);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso fresco, desnatado, con frutas', 96, 8, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso fundido, extragraso (>60% MG/ES)', 325, 9, 2, 31);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso gata-hurdes', 385, 21, 0, 33);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso gaztazarra', 328, 18, 0, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Gouda', 326, 20, 0, 27);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso grazalema', 376, 21, 0, 32);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Gruyer', 375, 23, 0, 31);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso herreño', 367, 24, 0, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Ibores', 402, 23, 0, 34);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Mahón', 406, 24, 0, 34);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso majorero', 360, 25, 0, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso manchego', 389, 28, 0, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso manchego, en aceite', 467, 26, 0, 40);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso mozzarella', 223, 19, 0, 16);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso munster', 333, 19, 0, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso para untar', 361, 15, 2, 32);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso para untar, con finas hierbas', 251, 6, 3, 23);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso para untar, con salmón', 258, 7, 3, 24);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso para untar, natural, bajo en calorías', 142, 14, 4, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso parmesano', 367, 32, 0, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso pasiego', 296, 14, 0, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso pedroches', 339, 24, 0, 27);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso peñamellera', 365, 23, 0, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso picón', 386, 22, 0, 33);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso porrúa', 381, 23, 0, 32);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Raclette', 356, 25, 0, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso rallado, genérico', 395, 26, 0, 32);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso roquefort', 354, 15, 0, 32);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso San Simón', 443, 26, 0, 37);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso semicurado, genérico', 390, 29, 0, 30);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso serrat', 411, 23, 0, 35);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso servilleta', 324, 22, 0, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Tetilla', 374, 21, 0, 32);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso tierno, genérico', 332, 26, 0, 25);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso torta del casar', 362, 18, 0, 32);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso tupí', 609, 19, 0, 59);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Queso Zamorano', 484, 26, 0, 42);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Quinoa, cruda', 306, 13, 49, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Rábano', 16, 0, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Rabo de toro', 200, 18, 0, 14);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Rape, a la parrilla', 95, 22, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Rape, crudo', 70, 15, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Rape, plancha', 87, 17, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Raya, cruda', 98, 20, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco "tipo gaseosa"', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco con gas, sabor cola, sin cafeina', 44, 0, 10, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco con gas, sabor cola, sin cafeina, bajo en calorías', 1, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco de té', 37, 0, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco de té, bajo en calorías', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco tipo "tónica"', 38, 0, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco, con gas, sabor naranja', 44, 0, 10, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco, sabor cola', 44, 0, 10, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco, sabor cola, bajo en calorías', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco, sabor limón, con gas', 46, 0, 11, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Refresco, sabor naranja, sin gas', 39, 0, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Regaliz', 325, 3, 71, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Remolacha, en conserva', 30, 1, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Repollo', 26, 1, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Requesón', 102, 12, 3, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Riñón, de cordero, crudo', 95, 16, 0, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Riñón, de ternera, crudo', 107, 16, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Rodaballo', 98, 16, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Rollito de primavera', 251, 8, 27, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Romero', 345, 5, 46, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ron', 232, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Rosquilla', 350, 7, 49, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Rúcula', 31, 2, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sal de mar', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sal yodada', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salami', 435, 17, 1, 40);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salchicha de pollo fresca', 307, 13, 0, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salchicha, fresca', 307, 13, 0, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salchicha, tipo "frankfurt"', 288, 12, 1, 26);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salchicha, tipo país, a la plancha', 386, 18, 0, 34);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salchicha, tipo viena', 274, 10, 2, 25);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salchichón', 422, 25, 2, 34);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salema, cruda', 104, 12, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salmón', 182, 18, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salmón ahumado', 181, 25, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salmón, plancha', 180, 20, 0, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salmonete', 90, 14, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa agridulce', 121, 0, 23, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa al curry', 78, 0, 9, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa al roquefort', 452, 7, 0, 47);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa barbacoa', 178, 1, 37, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa bechamel', 152, 4, 10, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa boloñesa', 145, 8, 3, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa carbonara', 305, 7, 2, 29);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa de queso', 110, 5, 8, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa de soja', 64, 8, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa napolitana', 76, 1, 6, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa siciliana, picante', 67, 1, 5, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salsa vinagreta, con aceite de oliva', 639, 0, 0, 71);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Salvado de trigo', 190, 15, 21, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('San jacobo, congelado', 238, 4, 25, 13);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sandía', 20, 0, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sangría', 71, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sardina', 140, 18, 0, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sardina, asada', 256, 16, 0, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sardina, enlatada, en aceite, escurrida', 237, 23, 0, 15);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sardina, enlatada, en escabeche', 131, 15, 0, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sargo, crudo', 100, 15, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Seitán', 124, 24, 2, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Semilla de lino', 567, 18, 28, 42);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sémola de trigo, cruda', 350, 12, 70, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sémola de trigo, hervida', 55, 2, 11, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sepia', 81, 17, 0, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sésamo, semilla', 562, 19, 10, 50);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sesos, de cerdo, crudos', 123, 10, 0, 9);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sesos, de cordero, crudos', 136, 10, 0, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sesos, de ternera, crudos', 119, 10, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Seta', 26, 1, 4, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Seta, plancha', 13, 1, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sidra', 50, 0, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sobao', 438, 5, 46, 25);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sobrasada', 598, 12, 0, 61);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Soda', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sofrito', 210, 1, 4, 20);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Soja, fresca', 159, 13, 11, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Soja, frita', 141, 13, 10, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Soja, germinada, en conserva', 13, 2, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Soja, seca, cruda', 351, 35, 9, 18);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Soja, seca, remojada, hervida', 137, 14, 3, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sopa de sobre maravilla', 333, 12, 62, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Sopa de sobre, sin reconstituir', 321, 10, 58, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Suplemento proteico', 394, 87, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Surimi', 91, 14, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tabasco', 15, 1, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tapioca, hervida', 127, 0, 31, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Té, infusión, con leche', 38, 1, 2, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tenca, cruda', 92, 17, 3, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tequila', 264, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ternera, costilla, cruda', 140, 20, 0, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ternera, lomo, crudo, con grasa separable', 112, 20, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ternera, parte s/e, asada', 222, 29, 0, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ternera, parte sin especificar, cruda, con grasa separable', 255, 16, 0, 21);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ternera, solomillo, asado', 157, 28, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Ternera, solomillo, sin grasa, crudo', 110, 20, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tocino', 665, 8, 0, 71);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tofu', 119, 11, 3, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tomate', 19, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tomate frito', 84, 1, 5, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tomate, asado', 19, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tomate, maduro, pelado y triturado, enlatado', 36, 2, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tomate, maduro, puré', 73, 4, 12, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tomillo, seco', 336, 9, 57, 7);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Torta de aceite', 152, 1, 21, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Tortilla, a la francesa', 170, 14, 0, 12);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Trigo, entero, crudo', 314, 11, 61, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Trucha', 91, 15, 0, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Trucha, ahumada', 198, 21, 0, 6);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Trufa, cruda', 94, 9, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Turrón, tipo Alicante', 486, 13, 44, 28);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Uva blanca', 68, 0, 16, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Uva blanca, congelada', 70, 0, 16, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Uva negra, cruda', 72, 0, 15, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Uva pasa', 297, 2, 69, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vaca/buey, parte s/e, asado', 231, 31, 0, 11);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vaca/buey, parte s/e, estofado', 196, 30, 0, 8);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vaca/buey, solomillo, a la plancha', 167, 28, 0, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vaca/buey, solomillo, crudo', 136, 23, 0, 4);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vacuno, hígado, crudo', 132, 21, 2, 5);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vacuno, mollejas, crudas', 128, 22, 1, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vainilla', 53, 0, 12, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vermut, s/e', 140, 0, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vieira', 86, 19, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vieja, cruda', 84, 12, 4, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vinagre balsámico', 71, 0, 17, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vinagre de manzana', 4, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vinagre de vino', 4, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vino blanco', 61, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vino dulce, tipo oporto', 132, 0, 14, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vino rosado', 67, 0, 1, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vino tinto', 71, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Vodka', 233, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Volador, crudo', 88, 21, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Whisky', 245, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur griego', 139, 6, 5, 10);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur líquido, "tipo actimel"', 63, 3, 4, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur líquido, aromatizado sabor s/e', 76, 2, 12, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur líquido, con frutas s/e', 88, 2, 14, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur líquido, entero, con cereales', 114, 2, 20, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur líquido, natural, azucarado', 70, 3, 11, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, búlgaro', 74, 5, 5, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, aromatizado sabor s/e', 64, 5, 7, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con cereales', 51, 4, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con cereales, manzana y ciruela', 71, 3, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con cereza y frambuesa', 40, 3, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con ciruela, albaricoque y fibra', 58, 4, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con fresa, grosella y fibra', 58, 4, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con frutas', 71, 3, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con frutas del bosque', 40, 3, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con frutas tropicales', 40, 3, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con manzana', 40, 3, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con melocotón y maracuyá', 40, 3, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con melocotón, frambuesa y fibra', 58, 4, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, con piña y pomelo', 40, 3, 5, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, sabor natural', 46, 4, 6, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, sabor natural, azucarado', 77, 4, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, desnatado, sabor vainilla', 107, 5, 17, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, enriquecido, con frutas', 122, 2, 21, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, enriquecido, natural', 64, 3, 3, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, enriquecido, natural, azucarado', 100, 3, 13, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, enriquecido, natural, con nata', 66, 3, 4, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, enriquecido, sabor, s/e', 198, 3, 37, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, entero, con cereales y fresas', 92, 3, 11, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, entero, con fresas', 121, 2, 21, 2);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, entero, con frutas del bosque', 90, 3, 11, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, líquido, desnatado, natural', 65, 3, 12, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, líquido, entero, con fresas', 91, 3, 12, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, líquido, entero, con frutas', 90, 3, 11, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, líquido, entero, sabor fresa', 116, 5, 15, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, líquido, entero, sabor fresa y plátano', 116, 5, 15, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, líquido, entero, sabor frutas del bosque', 116, 5, 15, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Yogur, líquido, entero, sabor piña y coco', 116, 5, 15, 3);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zamburiñas', 78, 15, 1, 1);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zanahoria, cruda', 34, 0, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de grosella negra', 34, 0, 7, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de grosella roja', 55, 0, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de lima, envasado', 15, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de limón, fresco', 17, 0, 3, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de mango', 42, 0, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de manzana', 45, 0, 11, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de naranja', 41, 0, 9, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de piña', 46, 0, 10, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de piña y uva', 55, 0, 13, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de pomelo, envasado', 38, 0, 8, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de tomate, fresco', 16, 0, 2, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de uva', 0, 0, 0, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de uva y melocotón', 51, 0, 12, 0);
INSERT INTO INGREDIENT (name, kilocalories, protein_amount, carbohydrates_amount, fat_amount) VALUES ('Zumo de zanahoria, fresco', 23, 0, 4, 0);
-- END SQL STATEMENTS DATE --> 11/10/2024

UPDATE SALUHUD_SYSTEM_METADATA SET database_version = '1.1.2', database_date = '2024-10-11', mobile_app_expected_version = '1.0.0', backend_expected_version = '1.0.0' WHERE id = 1;

-- START SQL STATEMENTS DATE --> 13/10/2024
-- It is needed to update all previously existent data from all tables to have a version value of 0
-- (default value of JPA Optimistic Locking) if their entity_version is null
UPDATE INGREDIENT SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE ALLERGENIC SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE RECIPE SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE RECIPE_INGREDIENT SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE RECIPE_ALLERGENIC SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE RECIPE_ELABORATION_STEP SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE SALUHUD_USER_FITNESS_DATA SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE SALUHUD_USER SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE SALUHUD_USER_SALUHUD_USER_FITNESS_DATA SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE SLEEP_HISTORICAL SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE SLEEP_HISTORICAL_ENTRY SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE DAILY_STEPS_HISTORICAL SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE DAILY_STEPS_HISTORICAL_ENTRY SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE WEIGHT_HISTORICAL SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
UPDATE WEIGHT_HISTORICAL_ENTRY SET ENTITY_VERSION = 0 WHERE ENTITY_VERSION IS NULL;
-- Add NOT NULL constraint to all version columns of all tables in order to avoid null values next time
ALTER TABLE IF EXISTS INGREDIENT ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS ALLERGENIC ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS RECIPE ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS RECIPE_INGREDIENT ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS RECIPE_ALLERGENIC ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS RECIPE_ELABORATION_STEP ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS RECIPE_RECIPE_ELABORATION_STEP ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS SALUHUD_USER_FITNESS_DATA ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS SALUHUD_USER ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS SALUHUD_USER_SALUHUD_USER_FITNESS_DATA ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS SLEEP_HISTORICAL ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS SLEEP_HISTORICAL_ENTRY ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS DAILY_STEPS_HISTORICAL ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS DAILY_STEPS_HISTORICAL_ENTRY ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS WEIGHT_HISTORICAL ALTER COLUMN ENTITY_VERSION SET NOT NULL;
ALTER TABLE IF EXISTS WEIGHT_HISTORICAL_ENTRY ALTER COLUMN ENTITY_VERSION SET NOT NULL;
-- Set default value of version column to 0 for all tables, in case a data addition comes from outside of JPA
ALTER TABLE IF EXISTS INGREDIENT ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS ALLERGENIC ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS RECIPE ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS RECIPE_INGREDIENT ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS RECIPE_ALLERGENIC ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS RECIPE_ELABORATION_STEP ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS RECIPE_RECIPE_ELABORATION_STEP ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS SALUHUD_USER_FITNESS_DATA ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS SALUHUD_USER ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS SALUHUD_USER_SALUHUD_USER_FITNESS_DATA ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS SLEEP_HISTORICAL ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS SLEEP_HISTORICAL_ENTRY ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS DAILY_STEPS_HISTORICAL ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS DAILY_STEPS_HISTORICAL_ENTRY ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS WEIGHT_HISTORICAL ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
ALTER TABLE IF EXISTS WEIGHT_HISTORICAL_ENTRY ALTER COLUMN ENTITY_VERSION SET DEFAULT 0;
-- END SQL STATEMENTS DATE --> 13/10/2024

UPDATE SALUHUD_SYSTEM_METADATA SET database_version = '1.1.3', database_date = '2024-10-13', mobile_app_expected_version = '1.0.0', backend_expected_version = '1.0.0' WHERE id = 1;