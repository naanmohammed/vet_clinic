/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered = true AND escape_attempts <= 3;
SELECT date_of_birth FROM animals WHERE name IN ('Augmon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 and 17.3;


BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;


SELECT full_name, name FROM owners o JOIN animals a ON o.id = a.owner_id WHERE o.full_name = 'Melody Pond';
SELECT a.name AS Animal_Name, s.name AS Species FROM animals a JOIN species s ON s.id = a.species_id WHERE s.name = 'pokemon';
SELECT o.full_name AS Owner_Name, a.name AS Animal_Name from owners o LEFT JOIN animals a on o.id = a.owner_id;
SELECT s.name AS Species_Name, COUNT(a.id) AS Animal_Count From species s LEFT JOIN animals a ON s.id = a.species_id GROUP BY s.name;
SELECT a.name AS Digimon_name FROM animals a JOIN owners o ON a.owner_id = o.id  JOIN species s on a.species_id = s.id WHERE s.name = 'digimon' AND o.full_name = 'Jennifer Orwell';
SELECT a.name as Dean_Pets_Non_Escaped FROM animals a JOIN owners o ON a.owner_id =o.id WHERE o.full_name = 'Dean Winchester' and a.escape_attempts = 0;
SELECT o.full_name as Owner_With_Most_Animals, COUNT(a.id) AS Animal_Count from owners o JOIN animals a ON o.id = a.owner_id GROUP 
BY o.full_name ORDER BY Animal_Count DESC LIMIT 1;