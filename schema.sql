CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name varchar(50),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species varchar(50);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(255),
    age int
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(255)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id int;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id); 
ALTER TABLE animals ADD COLUMN owner_id int;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name varchar(50),
    age int,
    date_of_graduation date
);

CREATE TABLE specializations (
    vet_id int REFERENCES vets (id),
    species_id int REFERENCES species (id),
    PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
    animal_id int REFERENCES animals (id),
    vet_id int REFERENCES vets (id),
    visit_date date,
    PRIMARY KEY (animal_id, vet_id, visit_date)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);


CREATE INDEX animals_id_idx ON visits (animal_id ASC);
CREATE INDEX email_id_idx ON owners (email ASC);
CREATE INDEX vets_id_idx ON visits (vet_id);