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
CREATE TABLE HOLDS (
    id NUMBER(6,0),
    patron_id NUMBER(6,0),
    collection_id NUMBER(6,0),
    date_created DATE,
    card_number NUMBER(10,0),
    status VARCHAR2(255),
    CONSTRAINT PK_HOLDS PRIMARY KEY (id)
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

INSERT INTO patrons VALUES(
   patron_id_seq.NEXTVAL, 121053, 'Bob', 'Bumble', '12-May-50', '123 Sesame St.', '416-457-6527', 'bbumble@somewhere.com', 2, 'b_bmbl', '123abc'
);
INSERT INTO patrons VALUES(
   patron_id_seq.NEXTVAL, 121323, 'Cassandra', 'Cory', '04-Jun-56', '124 Sesame St', '416-773-7914', 'ccory@somewhere.com', 5, 'c_cry', '234bcd'
);
INSERT INTO patrons VALUES(
   patron_id_seq.NEXTVAL, 121330, 'Davendra', 'Davis', '14-Sep-67', '125 Sesame St.', '647-586-6546', 'ddavis@somewhere.com', 3, 'd_dvs', '345cde'
);
INSERT INTO patrons VALUES(
   patron_id_seq.NEXTVAL, 121409, 'Eric', 'Ellroy', '27-Dec-84', '126 Sesame St.', '416-757-2864', 'eellroy@somewhere.com', 1, 'e_ellry', '456def'
);
INSERT INTO patrons VALUES(
   patron_id_seq.NEXTVAL, 121591, 'Femi', 'Ferris', '08-Jul-96', '127 Sesame St.', '905-535-8529', 'fferris@somewhere.com', 1, 'f_frrs', '567efg'
);
INSERT INTO patrons VALUES(
   patron_id_seq.NEXTVAL, 121647, 'Gary', 'Gimble', '18-Mar-04', '128 Sesame St.', '647-425-7932', 'ggimble@somewhere.com', 6, 'g_gmbl', '678fgh'
);

-- Add data / CHECKOUTS

INSERT INTO checkouts (
   id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date
) VALUES (
   1, 3, 121330, 3, 5, '01-Nov-24', '15-Nov-24'
);
INSERT INTO checkouts (
   id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date
) VALUES (
   2, 3, 121330, 5, 5, '01-Nov-24', '15-Nov-24'
);
INSERT INTO checkouts (
   id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date
) VALUES (
   4, 4, 121409, 11, 4, '22-Oct-24', '05-Nov-24'
);
INSERT INTO checkouts VALUES (
   5, 1, 121053, 13, 3, '17-Oct-24', '31-Oct-24', '23-Oct-24'
);
INSERT INTO checkouts VALUES (
   6, 1, 121053, 9, 3, '17-Oct-24', '31-Oct-24', '20-Oct-24'
);

-- Add data / BRANCH

INSERT INTO branch VALUES(
   1, 'Rexdale', '2243 Kipling Avenue Toronto, ON  M9W 4L5', '416-394-5200'
);
INSERT INTO branch VALUES(
   2, 'Parkdale', '1303 Queen Street West Toronto, ON  M6K 1L6', '416-393-7686'
);
INSERT INTO branch VALUES(
   3, 'Gerrard/Ashdale', '1432 Gerrard Street East Toronto, ON  M4L 1Z6', '416-393-7717'
);
INSERT INTO branch VALUES(
   4, 'High Park', '228 Roncesvalles Avenue Toronto, ON  M6R 2L7', '416-393-7671'
);
INSERT INTO branch VALUES(
   5, 'Leaside', '165 McRae Drive Toronto, ON  M4G 1S8', '416-396-3835'
);
INSERT INTO branch VALUES(
   6, 'Mount Pleasant', '599 Mt. Pleasant Road Toronto, ON  M4S 2M5', '416-393-7737'
);

-- Add data / BOOK_STATUS

INSERT INTO book_status VALUES (1, 'In library');
INSERT INTO book_status VALUES (2, 'Checked out');
INSERT INTO book_status VALUES (3, 'On hold');
INSERT INTO book_status VALUES (4, 'In transit');
INSERT INTO book_status VALUES (5, 'Lost');
INSERT INTO book_status VALUES (6, 'Removed');

-- Add data / GENRE

INSERT INTO genre VALUES (1, 'General Fiction');
INSERT INTO genre VALUES (2, 'Historical Fiction');
INSERT INTO genre VALUES (3, 'Horror');
INSERT INTO genre VALUES (4, 'Fantasy');
INSERT INTO genre VALUES (5, 'Mysteries / Suspense  / Thrillers');
INSERT INTO genre VALUES (6, 'Romance');
INSERT INTO genre VALUES (7, 'Science Fiction');
INSERT INTO genre VALUES (8, 'Graphic Novels');
INSERT INTO genre VALUES (9, 'Arts and Photography');
INSERT INTO genre VALUES (10, 'Biography');
INSERT INTO genre VALUES (11, 'Business and Finance');
INSERT INTO genre VALUES (12, 'Careers and Job Searching');
INSERT INTO genre VALUES (13, 'Computers and Technology');
INSERT INTO genre VALUES (14, 'Crafts, Hobbies and Home');
INSERT INTO genre VALUES (15, 'Food and Drink');
INSERT INTO genre VALUES (16, 'French');
INSERT INTO genre VALUES (17, 'Health and Wellness');
INSERT INTO genre VALUES (18, 'History');
INSERT INTO genre VALUES (19, 'Music and Performing Arts');
INSERT INTO genre VALUES (20, 'Parenting and Relationships');
INSERT INTO genre VALUES (21, 'Philosophy and Religion');
INSERT INTO genre VALUES (22, 'Politics, Government and Law');
INSERT INTO genre VALUES (23, 'Science and the Environment');
INSERT INTO genre VALUES (24, 'Social Issues');
INSERT INTO genre VALUES (25, 'Sports and Games');
INSERT INTO genre VALUES (26, 'Travel');

-- Add data / LANGUAGE

INSERT INTO language VALUES (1, 'English');
INSERT INTO language VALUES (2, 'French');
INSERT INTO language VALUES (3, 'Chinese');
INSERT INTO language VALUES (4, 'Tamil');
INSERT INTO language VALUES (5, 'Hindi');
INSERT INTO language VALUES (6, 'Russian');
INSERT INTO language VALUES (7, 'Polish');
INSERT INTO language VALUES (8, 'German');
INSERT INTO language VALUES (9, 'Korean');
INSERT INTO language VALUES (10, 'Greek');
INSERT INTO language VALUES (11, 'Tagalog');
INSERT INTO language VALUES (12, 'Spanish');
INSERT INTO language VALUES (13, 'Urdu');
INSERT INTO language VALUES (14, 'Somali');

-- Add data / HOLDS

INSERT INTO holds VALUES (1, 1, 24, '21-Sep-24', 121053, 9, 'waiting');
INSERT INTO holds VALUES (2, 2, 6, '22-Dec-15', 121323, 3, 'waiting');
INSERT INTO holds VALUES (3, 7, 7, '24-Nov-01', 121673, 1, 'ready');
INSERT INTO holds VALUES (4, 2, 15, '24-Nov-02', 121323, 3, 'ready');
INSERT INTO holds VALUES (5, 5, 5, '24-Nov-03', 121591, 1, 'waiting');
INSERT INTO holds VALUES (6, 8, 17, '24-Nov-04', 121699, 6, 'ready');
INSERT INTO holds VALUES (7, 8, 18, '24-Nov-05', 121699, 8, 'ready');
INSERT INTO holds VALUES (8, 9, 22, '24-Nov-06', 121725, 8, 'waiting');
INSERT INTO holds VALUES (9, 6, 3, '24-Nov-07', 121647, 5, 'waiting');
INSERT INTO holds VALUES (10, 4, 8, '24-Nov-08', 121409, 2, 'waiting');
