-- Finding all the animals which ends with mon.
SELECT * from animals WHERE name like '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true ;
-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE NOT name = 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 and 17.3;

-- DAY 2
-- Update the animals table by setting the species column to unspecified.
-- Verify that change was made. Then roll back the change
-- Verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
TABLE animals;
ROLLBACK;
TABLE animals;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
TABLE animals;
COMMIT;
TABLE animals;
-- Delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
TABLE animals;
ROLLBACK;
TABLE animals;
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
DELETE FROM animalsWHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
TABLE animals;
COMMIT;
TABLE animals;
-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT AVG(escape_attempts) FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species,
  MIN(weight_kg) as MIN_WEIGHT,
  MAX(weight_kg) as MAX_WEIGHT
FROM animals
GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,
  AVG(escape_attempts) as Average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- day 3
-- What animals belong to Melody Pond?
SELECT owners.id, full_name, name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals RIGHT JOIN species ON animals.species_id =species.id  WHERE species.name = 'Pokemon'; 
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON owners.id = animals.owner_id;
-- How many animals are there per species?
SELECT species.name, count(species.name) FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM  owners LEFT JOIN animals ON owners.id = animals.owner_id WHERE animals.species_id = 2 AND animals.owner_id = 2; 
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT owners.full_name, animals.name, animals.escape_attempts FROM owners LEFT JOIN animals ON owners.id = animals.owner_id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';
-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) FROM animals RIGHT JOIN owners ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY count DESC;

/* day 4 */

-- Who was the last animal seen by William Tatcher?
SELECT vets.name, vets.id, visits.animals_id,visits.vets_id, visits.date_of_visit, animals.name FROM vets INNER JOIN visits ON vets.id = visits.vets_id JOIN animals ON animals.id = visits.animals_id WHERE vets.id = 1 ORDER BY visits.date_of_visit DESC LIMIT 1; 

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(animals.name) FROM vets INNER JOIN visits ON vets.id = visits.vets_id JOIN animals ON animals.id = visits.animals_id WHERE vets.id = 3 GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON species.id = specializations.species_id ;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM vets LEFT JOIN visits ON vets.id = visits.vets_id LEFT JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT count(vets.name) AS visit_count, animals.name FROM vets LEFT JOIN visits ON vets.id = visits.vets_id LEFT JOIN animals ON visits.animals_id = animals.id GROUP BY animals.name ORDER BY visit_count DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT visits.date_of_visit, animals.name FROM vets LEFT JOIN visits ON vets.id = visits.vets_id INNER JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'Maisy Smith'ORDER BY visits.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, visits.date_of_visit, vets.name, vets.age, vets.date_of_graduation FROM animals RIGHT JOIN visits ON visits.animals_id = animals.id LEFT JOIN vets ON vets.id = visits.vets_id ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits LEFT JOIN vets ON vets.id = visits.vets_id LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id WHERE vets.name = 'Maisy Smith';

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT COUNT(*), species.name FROM vets RIGHT JOIN visits ON vets.id = visits.vets_id LEFT JOIN animals ON animals.id = visits.animals_id LEFT JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name;