CREATE TABLE person (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE account (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    person1_id BIGINT NOT NULL REFERENCES person(id),
    person2_id BIGINT NOT NULL REFERENCES person(id)
);

CREATE TABLE payment (
    id BIGSERIAL PRIMARY KEY,
    account_id BIGINT NOT NULL REFERENCES account(id),
    paid_by_id BIGINT NOT NULL REFERENCES person(id),
    description VARCHAR(255) NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    own_share_percentage INT NOT NULL DEFAULT 50,
    date DATE NOT NULL
);

CREATE TABLE account_person (
    account_id BIGINT,
    person_id BIGINT
);