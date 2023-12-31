/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BIT,
    weight_kg FLOAT,
);

-- adding species in the table 
ALTER TABLE animals
ADD species VARCHAR(50);

-- day 3
-- Create a table named owners with the following columns: 
CREATE TABLE OWNERS(id SERIAL PRIMARY KEY, full_name VARCHAR(81), age INT);

-- Create a table named species with the following columns: 
CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR(20));

-- Modify animals table: 
    --  Make sure that id is set as autoincremented PRIMARY KEY
    ALTER TABLE animals ALTER COLUMN id SET NOT NULL;
    ALTER TABLE animals ADD CONSTRAINT animals_pk PRIMARY KEY (id);
    -- Remove column species
    ALTER TABLE animals DROP COLUMN species;
    -- Add column species_id which is a foreign key referencing species table
    ALTER TABLE animals ADD species_id INT;
    ALTER TABLE animals ADD CONSTRAINT animal_fk FOREIGN KEY (species_id) REFERENCES species(id);
    -- Add column owner_id which is a foreign key referencing the owners table
    ALTER TABLE animals ADD owner_id INT;
    ALTER TABLE animals ADD CONSTRAINT owners_fk FOREIGN KEY (owner_id) REFERENCES owners(id);