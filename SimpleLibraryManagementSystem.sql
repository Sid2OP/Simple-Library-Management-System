
-- Creating Database --
CREATE DATABASE BookManagement;
USE BookManagement;

-- Creating Tables --
CREATE TABLE books (
  id INT PRIMARY KEY,
  title VARCHAR(255),
  author VARCHAR(255),
  publication_date DATE,
  ISBN VARCHAR(13)
);

INSERT INTO books (id, title, author, publication_date, ISBN) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', '1960-07-11', '9780061120084'),
(2, '1984', 'George Orwell', '1949-06-08', '9780451524935'),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', '9780743273565'),
(4, 'Pride and Prejudice', 'Jane Austen', '1813-01-28', '9780141439511');

CREATE TABLE authors (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  biography TEXT
);

INSERT INTO authors (id, name, biography) VALUES
(1, 'Harper Lee', 'Harper Lee was an American novelist known for her Pulitzer Prize-winning novel, To Kill a Mockingbird.'),
(2, 'George Orwell', 'George Orwell was a British novelist, essayist, and critic known for his dystopian novel, 1984.'),
(3, 'F. Scott Fitzgerald', 'F. Scott Fitzgerald was an American novelist and short story writer known for his novels and stories that capture the essence of the Jazz Age.'),
(4, 'Jane Austen', 'Jane Austen was an English novelist known for her novels of manners and romance, such as Pride and Prejudice.');

CREATE TABLE publishers (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255)
);

INSERT INTO publishers (id, name, address) VALUES
(1, 'J.B. Lippincott & Co.', 'Philadelphia, PA'),
(2, 'Secker and Warburg', 'London, UK'),
(3, 'Charles Scribner\'s Sons', 'New York, NY'),
(4, 'T. Egerton', 'London, UK');

CREATE TABLE genres (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  description TEXT
);

INSERT INTO genres (id, name, description) VALUES
(1, 'Fiction', 'Novels and short stories that are not based on real events.'),
(2, 'Classics', 'Novels and works of literature considered to be of high importance and influence.'),
(3, 'Mystery', 'Novels and stories that involve solving a puzzle or uncovering a hidden truth.'),
(4, 'Rockstory', 'Novels and stories that focus on the relationship between characters.');


CREATE TABLE book_genres (
  id INT PRIMARY KEY,
  book_id INT,
  genre_id INT,
  FOREIGN KEY (book_id) REFERENCES books(id),
  FOREIGN KEY (genre_id) REFERENCES genres(id)
);

INSERT INTO book_genres (id, book_id, genre_id) VALUES
(1, 1, 2), -- To Kill a Mockingbird is a Classic
(2, 2, 1), -- 1984 is Fiction
(3, 3, 2), -- The Great Gatsby is a Classic
(4, 4, 4); -- Pride and Prejudice is Rockstory

-- Creating Database --
create database PatronManagement;
use patronManagement;

-- Creating Tables --
CREATE TABLE patrons (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE membership_types (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    duration INT
);

CREATE TABLE patron_membership (
    id INT PRIMARY KEY,
    patron_id INT,
    membership_type_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (patron_id) REFERENCES patrons(id),
    FOREIGN KEY (membership_type_id) REFERENCES membership_types(id)
);

CREATE TABLE patron_fines (
    id INT PRIMARY KEY,
    patron_id INT,
    fine_amount DECIMAL(5, 2),
    fine_date DATE,
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

CREATE TABLE patron_payments (
    id INT PRIMARY KEY,
    patron_id INT,
    payment_amount DECIMAL(5, 2),
    payment_date DATE,
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

-- Inserting Data --
INSERT INTO patrons (id, name, email, phone_number, address) VALUES
(1, 'John Doe', 'johndoe@example.com', '123-456-7890', '123 Main St'),
(2, 'Jane Smith', 'janesmith@example.com', '987-654-3210', '456 Elm St'),
(3, 'Bob Johnson', 'bobjohnson@example.com', '555-123-4567', '789 Oak St'),
(4, 'Alice Brown', 'alicebrown@example.com', '111-222-3333', '321 Maple St'),
(5, 'Mike Davis', 'mikedavis@example.com', '444-555-6666', '901 Pine St');

INSERT INTO membership_types (id, name, description, duration) VALUES
(1, 'Basic', 'Access to library materials for 1 year', 365),
(2, 'Premium', 'Access to library materials, digital media, and special events for 1 year', 365),
(3, 'Student', 'Access to library materials for 6 months', 180),
(4, 'Senior', 'Access to library materials for 1 year, with discounts on programs and services', 365),
(5, 'Family', 'Access to library materials for 1 year, for up to 5 family members', 365);

INSERT INTO patron_membership (id, patron_id, membership_type_id, start_date, end_date) VALUES
(1, 1, 1, '2022-01-01', '2023-01-01'),
(2, 2, 2, '2022-06-01', '2023-06-01'),
(3, 3, 3, '2022-09-01', '2023-03-01'),
(4, 4, 4, '2022-03-01', '2023-03-01'),
(5, 5, 5, '2022-12-01', '2023-12-01');

INSERT INTO patron_fines (id, patron_id, fine_amount, fine_date) VALUES
(1, 1, 5.00, '2022-02-01'),
(2, 2, 10.00, '2022-07-01'),
(3, 3, 2.00, '2022-10-01'),
(4, 4, 8.00, '2022-04-01'),
(5, 5, 12.00, '2022-11-01');

INSERT INTO patron_payments (id, patron_id, payment_amount, payment_date) VALUES
(1, 1, 20.00, '2022-01-15'),
(2, 2, 50.00, '2022-06-15'),
(3, 3, 15.00, '2022-09-15'),
(4, 4, 30.00, '2022-03-15'),
(5, 5, 60.00, '2022-12-15');

-- Creating Database --
create database CirculationManagement;
use CirculationManagement;

-- Creating Table --
CREATE TABLE checkouts (
    id INT PRIMARY KEY,
    book_id INT,
    patron_id INT,
    checkout_date DATE,
    due_date DATE,
  FOREIGN KEY (book_id) REFERENCES BookManagement.books(id),
FOREIGN KEY (patron_id) REFERENCES PatronManagement.patrons(id)

);

CREATE TABLE returns (
    id INT PRIMARY KEY,
    checkout_id INT,
    return_date DATE,
    FOREIGN KEY (checkout_id) REFERENCES checkouts(id)
);

CREATE TABLE holds (
    id INT PRIMARY KEY,
    book_id INT,
    patron_id INT,
    hold_date DATE,
    expiration_date DATE,
    FOREIGN KEY (book_id) REFERENCES BookManagement.books(id),
    FOREIGN KEY (patron_id) REFERENCES PatronManagement.patrons(id)
);

CREATE TABLE waitlists (
    id INT PRIMARY KEY,
    book_id INT,
    patron_id INT,
    waitlist_date DATE,
    FOREIGN KEY (book_id) REFERENCES BookManagement.books(id),
    FOREIGN KEY (patron_id) REFERENCES PatronManagement.patrons(id)
);

CREATE TABLE checkout_history (
    id INT PRIMARY KEY,
    book_id INT,
    patron_id INT,
    checkout_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES BookManagement.books(id),
    FOREIGN KEY (patron_id) REFERENCES PatronManagement.patrons(id)
);
-- Adding Data --
INSERT INTO checkouts (id, book_id, patron_id, checkout_date, due_date) VALUES
(1, 1, 1, '2022-01-01', '2022-01-31'),
(2, 2, 2, '2022-02-01', '2022-02-28'),
(3, 3, 3, '2022-03-01', '2022-03-31'),
(4, 4, 4, '2022-04-01', '2022-04-30');


INSERT INTO returns (id, checkout_id, return_date) VALUES
(1, 1, '2022-01-20'),
(2, 2, '2022-02-15'),
(3, 3, '2022-03-25'),
(4, 4, '2022-04-10');



INSERT INTO holds (id, book_id, patron_id, hold_date, expiration_date) VALUES
(1, 1, 1, '2022-01-10', '2022-01-20'),
(2, 2, 2, '2022-02-10', '2022-02-20'),
(3, 3, 3, '2022-03-10', '2022-03-20'),
(4, 4, 4, '2022-04-10', '2022-04-20');





INSERT INTO waitlists (id, book_id, patron_id, waitlist_date) VALUES
(1, 1, 1, '2022-01-05'),
(2, 2, 2, '2022-02-05'),
(3, 3, 3, '2022-03-05'),
(4, 4, 4, '2022-04-05');


INSERT INTO checkout_history (id, book_id, patron_id, checkout_date, return_date) VALUES
(1, 1, 1, '2022-01-01', '2022-01-20'),
(2, 2, 2, '2022-02-01', '2022-02-15'),
(3, 3, 3, '2022-03-01', '2022-03-25'),
(4, 4, 4, '2022-04-01', '2022-04-10');


USE CirculationManagement;

TRUNCATE TABLE checkouts;
TRUNCATE TABLE returns;
TRUNCATE TABLE holds;
TRUNCATE TABLE waitlists;
TRUNCATE TABLE checkout_history;

select *  from checkouts;

INSERT INTO returns (id, checkout_id, return_date) VALUES
(1, 1, '2022-01-15'),
(2, 2, '2022-02-15'),
(3, 3, '2022-03-15'),
(4, 4, '2022-04-15');


INSERT INTO holds (id, book_id, patron_id, hold_date, expiration_date) VALUES
(1, 1, 1, '2022-01-10', '2022-01-20'),
(2, 2, 2, '2022-02-10', '2022-02-20'),
(3, 3, 3, '2022-03-10', '2022-03-20'),
(4, 4, 4, '2022-04-10', '2022-04-20');

INSERT INTO waitlists (id, book_id, patron_id, waitlist_date) VALUES
(1, 1, 1, '2022-01-05'),
(2, 2, 2, '2022-02-05'),
(3, 3, 3, '2022-03-05'),
(4, 4, 4, '2022-04-05');

INSERT INTO checkout_history (id, book_id, patron_id, checkout_date, return_date) VALUES
(1, 1, 1, '2022-01-01', '2022-01-15'),
(2, 2, 2, '2022-02-01', '2022-02-15'),
(3, 3, 3, '2022-03-01', '2022-03-15'),
(4, 4, 4, '2022-04-01', '2022-04-15');

-- Creating Database -- 
create database AcquisitionsManagement;
use AcquisitionsManagement;

-- Creating Table --
CREATE TABLE orders (
    id INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    order_date DATE,
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (book_id) REFERENCES BookManagement.books(id)
);

CREATE TABLE vendors (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    contact_info VARCHAR(255)
);

CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    cost DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (book_id) REFERENCES BookManagement.books(id)
);

CREATE TABLE receipts (
    id INT PRIMARY KEY,
    order_id INT,
    receipt_date DATE,
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE invoices (
    id INT PRIMARY KEY,
    order_id INT,
    invoice_date DATE,
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO orders (id, book_id, quantity, order_date, total_cost) VALUES
(1, 1, 5, '2022-01-01', 100.00),
(2, 2, 10, '2022-02-01', 200.00),
(3, 3, 3, '2022-03-01', 75.00),
(4, 4, 8, '2022-04-01', 160.00);

INSERT INTO vendors (id, name, address, contact_info) VALUES
(1, 'ABC Books', '123 Main St', 'abcbooks@example.com'),
(2, 'DEF Publishers', '456 Elm St', 'defpub@example.com'),
(3, 'GHI Distributors', '789 Oak St', 'ghidist@example.com'),
(4, 'JKL Wholesalers', '321 Maple St', 'jklwhole@example.com');

INSERT INTO order_items (id, order_id, book_id, quantity, cost) VALUES
(1, 1, 1, 5, 20.00),
(2, 2, 2, 10, 20.00),
(3, 3, 3, 3, 25.00),
(4, 4, 4, 8, 20.00);

INSERT INTO receipts (id, order_id, receipt_date, total_cost) VALUES
(1, 1, '2022-01-15', 100.00),
(2, 2, '2022-02-15', 200.00),
(3, 3, '2022-03-20', 75.00),
(4, 4, '2022-04-25', 160.00);

INSERT INTO invoices (id, order_id, invoice_date, total_cost) VALUES
(1, 1, '2022-01-20', 100.00),
(2, 2, '2022-02-20', 200.00),
(3, 3, '2022-03-25', 75.00),
(4, 4, '2022-04-30', 160.00);

create database ReportingAndAnalytics;
use ReportingAndAnalytics;

CREATE TABLE circulation_stats (
    id INT PRIMARY KEY,
    date DATE,
    total_checkouts INT,
    total_returns INT
);

INSERT INTO circulation_stats (id, date, total_checkouts, total_returns) VALUES
(1, '2022-01-01', 100, 50),
(2, '2022-02-01', 120, 60),
(3, '2022-03-01', 110, 55),
(4, '2022-04-01', 130, 65),
(5, '2022-05-01', 140, 70);

CREATE TABLE collection_stats (
    id INT PRIMARY KEY,
    date DATE,
    total_books INT,
    total_authors INT
);

INSERT INTO collection_stats (id, date, total_books, total_authors) VALUES
(1, '2022-01-01', 10000, 500),
(2, '2022-02-01', 10100, 510),
(3, '2022-03-01', 10200, 520),
(4, '2022-04-01', 10300, 530),
(5, '2022-05-01', 10400, 540);

CREATE TABLE patron_stats (
    id INT PRIMARY KEY,
    date DATE,
    total_patrons INT,
    total_membership INT
);

INSERT INTO patron_stats (id, date, total_patrons, total_membership) VALUES
(1, '2022-01-01', 500, 400),
(2, '2022-02-01', 510, 410),
(3, '2022-03-01', 520, 420),
(4, '2022-04-01', 530, 430),
(5, '2022-05-01', 540, 440);

CREATE TABLE fine_stats (
    id INT PRIMARY KEY,
    date DATE,
    total_fines INT,
    total_payments INT
);

INSERT INTO fine_stats (id, date, total_fines, total_payments) VALUES
(1, '2022-01-01', 100, 50),
(2, '2022-02-01', 120, 60),
(3, '2022-03-01', 110, 55),
(4, '2022-04-01', 130, 65),
(5, '2022-05-01', 140, 70);

CREATE TABLE survey_responses (
    id INT PRIMARY KEY,
    date DATE,
    question_id INT,
    response_text VARCHAR(255)
);

INSERT INTO survey_responses (id, date, question_id, response_text) VALUES
(1, '2022-01-01', 1, 'Excellent'),
(2, '2022-02-01', 2, 'Good'),
(3, '2022-03-01', 1, 'Excellent'),
(4, '2022-04-01', 3, 'Fair'),
(5, '2022-05-01', 2, 'Good');







