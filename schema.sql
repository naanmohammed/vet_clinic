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