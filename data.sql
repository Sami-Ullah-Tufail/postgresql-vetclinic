
INSERT INTO animals ( 
    id, 
    name,    
    date_of_birth,    
    escape_attempts,    
    neutered,    
    weight_kg
    )VALUES ('1', 'Agumon', '2020-02-3', 0,true, 10.23),  
    ('2', 'Gabumon', '2018-11-15', 2,true, 8.0),  
    ('3', 'Pikachu', '2021-01-07', 1, false'0', 15.04),  
    ('4', 'Devimon', '2017-05-12', 5, true, 11.0);

    -- day 2 data input 
    INSERT INTO animals (
     id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
  )
VALUES ( '5', 'Charmander', '2020-02-08', -11,  '0', 0),
  ( '6', 'Plantmon', '2021-11-15', -5.7,  '1', 2),
  ('7', 'Squirtle', '1993-04-02', -12.13, '0', 3),
  ('8', 'Angemon', '2005-06-12', -45,  '1', 1),
  ('9', 'Boarmon', '2005-06-07', 20.4, '1', 7),
  ('10', 'Blossom', '1998-10-13', 17,  '1', 3),
  ('11', 'Ditto', '2022-05-14', 22,  '1', 4);

--   day 3
/*Insert the following data into the owners table */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), 
('Jennifer Orwell', 19),
('Bob', 45),('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

/* Insert the following data into the species table  */
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

/* Modify your inserted animals so it includes the species_id value */
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id): 
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');

