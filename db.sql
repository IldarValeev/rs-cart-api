create type cart_status as enum ('OPEN', 'ORDERED');

create table users (
  id uuid primary key default uuid_generate_v4(),
  name varchar(50) not null,
  email varchar(50),
  password varchar(50) not null,
  unique (name)
)

create table carts (
    id uuid primary key default uuid_generate_v4(),
    user_id uuid not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    status cart_status default 'OPEN',
    foreign key (user_id) references users (id) on delete cascade
)

create table cart_items (
    cart_id uuid not null,
    product_id uuid not null,
    count integer not null,
    foreign key (cart_id) references carts (id) on delete cascade
)

create table orders (
    id uuid primary key default uuid_generate_v4(),
    cart_id uuid not null,
    payment json,
    delivery json,
    comments text,
    status text,
    total integer,
    foreign key (cart_id) references carts (id) on delete cascade
)

insert into users (name, email, password) values
('Bob', 'bob@gmail.com', 'qwe'),
('Peter', 'peter@gmail.com', 'qwe'),
('Jim', 'jim@gmail.com', 'qwe')


-- Insert test data into 'carts' table with manually generated UUIDv4 values
INSERT INTO carts (id, user_id, created_at, updated_at, status)
VALUES
    ('d04a10d1-91e7-4d57-a47f-74f4c88f2a6e', '1a23758a-6f0e-45c4-a8f3-fc25e35f0de3', '2024-05-01', '2024-05-01', 'OPEN'),
    ('25c9a4c1-10cf-4c61-895d-05e42e7079b7', 'e048f636-5d0d-436e-a732-a7a2e17da55d', '2024-05-02', '2024-05-02', 'ORDERED');

-- Insert test data into 'cart_items' table with manually generated UUIDv4 values for product_id and cart_id from 'carts' table
INSERT INTO cart_items (cart_id, product_id, count)
VALUES
    ('d04a10d1-91e7-4d57-a47f-74f4c88f2a6e', '581f64a2-bc06-4d9e-9b2b-25b7de07c4a4', 3),
    ('d04a10d1-91e7-4d57-a47f-74f4c88f2a6e', '23cc1a5c-4f65-426b-8493-3f6aa46eb041', 1),
    ('25c9a4c1-10cf-4c61-895d-05e42e7079b7', '9a1727d3-d585-46ec-b22e-8d17413f9cd0', 2);
