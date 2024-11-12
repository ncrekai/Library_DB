-- Create tables

CREATE TABLE BOOKS (
    id NUMBER(6),
    isbn NUMBER(15),
    title VARCHAR2(255),
    author_fname VARCHAR2(255),
    author_lname VARCHAR2(255),
    publisher VARCHAR2(255),
    publication_year NUMBER(4),
    language_id NUMBER(3),
    genre_id NUMBER(2),
    CONSTRAINT PK_BOOKS PRIMARY KEY (id)
);
CREATE TABLE COLLECTION (
    id NUMBER(6,0),
    book_id NUMBER(6,0),
    isbn NUMBER(15,0),
    status_id NUMBER(2,0),
    date_acquired DATE,
    language_id NUMBER(3,0),
    branch_id NUMBER(3,0),
    CONSTRAINT PK_COLLECTION PRIMARY KEY (id)
);
CREATE TABLE CHECKOUTS (
    id NUMBER(6,0),
    patron_id NUMBER(6,0),
    card_number NUMBER(10,0),
    collection_id NUMBER(6,0),
    branch_id NUMBER(3,0),
    checkout_date DATE,
    due_date DATE,
    returned_date DATE,
    CONSTRAINT PK_CHECKOUTS PRIMARY KEY (id)
);
CREATE TABLE PATRONS (
    id NUMBER(6,0),
    card_number NUMBER(10,0),
    fname VARCHAR2(255),
    lname VARCHAR2(255),
    dob DATE,
    address VARCHAR2(255),
    phone VARCHAR2(255),
    email VARCHAR2(255),
    branch_id NUMBER(3,0),
    username VARCHAR2(255),
    password VARCHAR2(255),
    CONSTRAINT PK_PATRONS PRIMARY KEY (id)
);
CREATE TABLE BRANCH (
    id NUMBER(3,0),
    name VARCHAR2(255),
    address VARCHAR2(255),
    phone VARCHAR2(255),
    CONSTRAINT PK_BRANCH PRIMARY KEY (id)
);
CREATE TABLE GENRE (
    genre VARCHAR2(255),
    id NUMBER(2,0),
    CONSTRAINT PK_GENRE PRIMARY KEY (id)
);
CREATE TABLE LANGUAGE (
    language VARCHAR2(255),
    id NUMBER(3,0),
    CONSTRAINT PK_LANGUAGE PRIMARY KEY (id)
);
CREATE TABLE BOOK_STATUS (
    book_status VARCHAR2(255),
    id NUMBER(2,0),
    CONSTRAINT PK_BOOK_STATUS PRIMARY KEY (id)
);

-- Add data / BOOKS

INSERT INTO books VALUES (
   book_id_seq.nextval, 9780316229296, 'The fifth season', 'N.K.', 'Jemisin', 'Orbit Books', 2015, 1, 7
);
INSERT INTO books VALUES (
   book_id_seq.nextval, 721914608, 'Heraldic design: its origins, ancient forms and modern usage.', 'Hubert', 'Allcock', 'Tudor Publishing', 1962, 1, 18
);
INSERT INTO books VALUES (
   book_id_seq.nextval, 9780744045567, 'Woodwork step by step : Carpentry techniques made easy', 'Marc', 'Pattenden', 'DK Publishing', 2021, 1, 14
);
INSERT INTO books VALUES (
   book_id_seq.nextval, 440194784, 'Welcome to the monkey house: a collection of short works', 'Kurt', 'Vonnegut', 'Dell', 1977, 1, 1
);
INSERT INTO books VALUES (
   book_id_seq.nextval, 9780316041263, 'Monster', 'A. Lee.', 'Martinez', 'Orbit', 2009, 1, 1
);
INSERT INTO books VALUES (
   book_id_seq.nextval, 9780375725609, 'The devil in the white city : murder, magic, and madness at the fair that changed America', 'Erik', 'Larson', 'Crown Publishers', 2003, 1, 18
);
INSERT INTO books VALUES (
   book_id_seq.nextval, 9782092495001, 'Comme une famille', 'Rachel', 'Corenblit', 'Nathan', 2023, 2, 1
);
INSERT INTO books VALUES (
   book_id_seq.nextval, 2259190537, 'Vittorio, le vampire : roman', 'Anne', 'Rice', 'Plon', 2000, 2, 3
);
INSERT INTO books VALUES (
   book_id_seq.nextval, 9781035400119, 'Murder at the bonfire', 'Penny', 'Blackwell', 'Headline Accent', 2023, 1, 5
);

-- Add data / COLLECTION

INSERT INTO collection VALUES(
   1, 8, 9782092495001, 1, '03-Mar-23', 2, 3
);
INSERT INTO collection VALUES(
   2, 2, 721914608, 1, '24-May-73', 1, 4
);
INSERT INTO collection VALUES(
   3, 6, 9780316041263, 2, '01-Feb-10', 1, 5
);
INSERT INTO collection VALUES(
   4, 10, 9781035400119, 1, '04-Aug-23', 1, 2
);
INSERT INTO collection VALUES(
   5, 7, 9780375725609, 2, '12-Oct-03', 1, 1
);
INSERT INTO collection VALUES(
   6, 7, 9780375725609, 5, '15-Dec-04', 1, 3
);
INSERT INTO collection VALUES(
   7, 1, 9780316229296, 3, '08-Jan-16', 1, 1
);
INSERT INTO collection VALUES(
   8, 1, 9780316229296, 2, '08-Jan-16', 1, 2
);
INSERT INTO collection VALUES(
   9, 4, 583118607, 1, '04-Sep-80', 1, 4
);
INSERT INTO collection VALUES(
   10, 9, 2259190537, 1, '20-Nov-00', 2, 6
);
INSERT INTO collection VALUES(
   11, 5, 440194784, 2, '17-Jun-75', 1, 4
);
INSERT INTO collection VALUES(
   12, 5, 440194784, 1, '30-Aug-80', 1, 6
);
INSERT INTO collection VALUES(
   13, 5, 440194784, 1, '30-Aug-80', 1, 2
);
INSERT INTO collection VALUES(
   14, 3, 9780744045567, 1, '01-May-22', 1, 5
);

-- Add data / PATRONS

-- Add data / CHECKOUTS

-- Add data / BRANCH

-- Add data / BOOK_STATUS

-- Add data / GENRE

-- Add data / LANGUAGE

-- Add data / HOLDS
