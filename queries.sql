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

SELECT a.name from visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'William Tatcher' ORDER BY v.visit_date DESC LIMIT 1;
SELECT COUNT(DISTINCT a.id) as Distinct_Animal_Count from visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt on v.vet_id = vt.id WHERE vt.name = 'Stephanie Mendez';
SELECT vt.name as Vet_Name, s.name AS Specialization from vets vt LEFT JOIN specializations sn ON sn.vet_id = vt.id LEFT JOIN species s ON sn.species_id = s.id;
SELECT a.name from visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Stephanie Mendez' AND v.visit_date >= '2020-04-01' AND v.visit_date <= '2020-08-30';
SELECT a.name, COUNT(v.animal_id) as Visit_Count from visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id GROUP BY a.name ORDER BY Visit_Count DESC LIMIT 1;
SELECT a.name, visit_date from visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Maisy Smith' ORDER BY visit_date ASC LIMIT 1;
SELECT a.name AS Animal_Name, visit_date, vt.name AS Vet_Name, vt.age as Vet_Age, vt.date_of_graduation as Vet_Graduation_Date from visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id ORDER BY visit_date DESC LIMIT 1;
SELECT COUNT(*) AS non_specialized_visits FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id WHERE sp.vet_id IS NULL;
SELECT s.name AS species_name, COUNT(*) AS visit_count FROM visits v JOIN animals a ON v.animal_id = a.id JOIN species s ON a.species_id = s.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Maisy Smith' GROUP BY s.name ORDER BY visit_count DESC LIMIT 1;
