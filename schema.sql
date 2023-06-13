CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name varchar(50),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
);
