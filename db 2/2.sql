CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100),
    region_id INTEGER,
    population INTEGER
);