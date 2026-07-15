CREATE TABLE person (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE account (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
);

CREATE TABLE payment (
    id BIGSERIAL PRIMARY KEY,
    account_id BIGINT NOT NULL REFERENCES account(id),
    paid_by_id BIGINT NOT NULL REFERENCES person(id),
    description VARCHAR(255) NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    own_share_percentage INT NOT NULL DEFAULT 50,
    date DATE NOT NULL
    income BOOLEAN NOT NULL DEFAULT FALSE;
);

CREATE TABLE account_person (
    account_id BIGINT NOT NULL REFERENCES account(id),
    person_id BIGINT NOT NULL REFERENCES person(id),
    PRIMARY KEY (account_id, person_id)
);