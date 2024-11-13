CREATE TABLE branch (
  branch_id number (3,0),
  branch_name varchar2 (255),
  branch_address varchar2 (255),
  branch_phone varchar2 (255),
  CONSTRAINT branch_id_pk PRIMARY KEY (branch_id)
);

CREATE TABLE patrons (
  patron_id number (6,0),
  card_number number (10,0),
  fname varchar2 (255),
  lname varchar2 (255),
  dob date,
  patron_address varchar2 (255),
  patron_phone varchar2 (255),
  email varchar2 (255),
  branch_id number (3,0),
  username varchar2 (255),
  password varchar2 (255),
  CONSTRAINT patron_id_pk PRIMARY KEY (patron_id),
  CONSTRAINT patrons_branch_id_fk FOREIGN KEY (branch_id)
      REFERENCES branch (branch_id)
);

CREATE TABLE book_status (
  book_status_id number (2,0),
  book_status_description varchar2 (255),
  CONSTRAINT book_status_id_pk PRIMARY KEY (book_status_id)
);

CREATE TABLE collection (
  collection_id number (6,0),
  book_id number (6,0),
  isbn number (15,0),
  book_status_id number (2,0),
  date_acquired Date,
  branch_id number (3,0),
  language_id number (3,0),
  CONSTRAINT collection_id_pk PRIMARY KEY (collection_id),
  CONSTRAINT collection_branch_id_fk FOREIGN KEY (branch_id)
      REFERENCES branch (branch_id),
  CONSTRAINT book_status_id FOREIGN KEY (book_status_id)
      REFERENCES book_status (book_status_id)
);

CREATE TABLE holds (
  hold_id number (10,0),
  patron_id number (6,0),
  card_number number (10,0),
  collection_id number (6,0),
  book_id number (6,0),
  date_created date,
  hold_status varchar2 (255),
  CONSTRAINT hold_id_pk PRIMARY KEY (hold_id),
  CONSTRAINT holds_patron_id_fk FOREIGN KEY (patron_id)
      REFERENCES patrons (patron_id),
  CONSTRAINT collection_id_fk FOREIGN KEY (collection_id)
      REFERENCES collection (collection_id)
);

CREATE TABLE checkouts (
  checkout_id number (6,0),
  patron_id number (6,0),
  card_number number (10,0),
  collection_id number (6,0),
  branch_id number (3,0),
  checkout_date date,
  due_date date,
  returned_date date,
  CONSTRAINT checkout_id_pk PRIMARY KEY (checkout_id),
  CONSTRAINT checkouts_patron_id_fk FOREIGN KEY (patron_id)
      REFERENCES patrons (patron_id)
);

CREATE TABLE checkouts_collection (
  checkout_id number (6,0),
  collection_id number (6,0),
  CONSTRAINT checkout_collection_id_pk PRIMARY KEY (checkout_id, collection_id),
  CONSTRAINT checkout_id_fk FOREIGN KEY (checkout_id)
      REFERENCES checkouts (checkout_id),
  CONSTRAINT checkouts_collection_id_fk FOREIGN KEY (collection_id)
      REFERENCES collection (collection_id)
);

CREATE TABLE genre (
  genre_id number (2,0),
  genre_name varchar2 (255),
  CONSTRAINT genre_id_pk PRIMARY KEY (genre_id)
);

CREATE TABLE language (
  language_id number (3,0),
  language_name varchar2 (255),
  CONSTRAINT language_id_pk PRIMARY KEY (language_id)
);

CREATE TABLE books (
  book_id number (6,0),
  isbn number (15,0),
  title varchar2 (255),
  author_fname varchar2 (255),
  author_lname varchar2 (255),
  publisher varchar2 (255),
  publication_year number (4,0),
  language_id number (3,0),
  genre_id number (2,0),
  CONSTRAINT book_id_pk PRIMARY KEY (book_id),
  CONSTRAINT genre_id_fk FOREIGN KEY (genre_id)
      REFERENCES genre (genre_id),
  CONSTRAINT language_id FOREIGN KEY (language_id)
      REFERENCES language (language_id)
);

--Sequences
CREATE SEQUENCE book_id_seq 
    MINVALUE 1
    MAXVALUE 999999
    INCREMENT BY 1;

CREATE SEQUENCE patron_id_seq 
    MINVALUE 1
    MAXVALUE 999999
    INCREMENT BY 1;

CREATE SEQUENCE collection_id_seq 
    MINVALUE 1
    MAXVALUE 999999
    INCREMENT BY 1;

-- Add data / BRANCH
INSERT INTO branch VALUES (1, 'Rexdale', '2243 Kipling Avenue Toronto, ON  M9W 4L5', '416-394-5200');
INSERT INTO branch VALUES (2, 'Parkdale', '1303 Queen Street West Toronto, ON  M6K 1L6', '416-393-7686');
INSERT INTO branch VALUES (3, 'Gerrard/Ashdale', '1432 Gerrard Street East Toronto, ON  M4L 1Z6', '416-393-7717');
INSERT INTO branch VALUES(4, 'High Park', '228 Roncesvalles Avenue Toronto, ON  M6R 2L7', '416-393-7671');
INSERT INTO branch VALUES(5, 'Leaside', '165 McRae Drive Toronto, ON  M4G 1S8', '416-396-3835');
INSERT INTO branch VALUES(6, 'Mount Pleasant', '599 Mt. Pleasant Road Toronto, ON  M4S 2M5', '416-393-7737');

-- Add data / PATRONS
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, 121053, 'Bob', 'Bumble', '12-May-50', '123 Sesame St.', '416-457-6527', 
    'bbumble@somewhere.com', 2, 'b_bmbl', '123abc');
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, 121323, 'Cassandra', 'Cory', '04-Jun-56', '124 Sesame St', '416-773-7914',
    'ccory@somewhere.com', 5, 'c_cry', '234bcd');
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, 121330, 'Davendra', 'Davis', '14-Sep-67', '125 Sesame St.', '647-586-6546', 
    'ddavis@somewhere.com', 3, 'd_dvs', '345cde');
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, 121409, 'Eric', 'Ellroy', '27-Dec-84', '126 Sesame St.', '416-757-2864', 
    'eellroy@somewhere.com', 1, 'e_ellry', '456def');
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, 121591, 'Femi', 'Ferris', '08-Jul-96', '127 Sesame St.', '905-535-8529', 
    'fferris@somewhere.com', 1, 'f_frrs', '567efg');
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, 121647, 'Gary', 'Gimble', '18-Mar-04', '128 Sesame St.', '647-425-7932', 
    'ggimble@somewhere.com', 6, 'g_gmbl', '678fgh');

    -- Add data / BOOK_STATUS
INSERT INTO book_status VALUES (1, 'In library');
INSERT INTO book_status VALUES (2, 'Checked out');
INSERT INTO book_status VALUES (3, 'On hold');
INSERT INTO book_status VALUES (4, 'In transit');
INSERT INTO book_status VALUES (5, 'Lost');
INSERT INTO book_status VALUES (6, 'Removed');

-- Add data / COLLECTION
INSERT INTO collection VALUES(1, 8, 9782092495001, 1, '03-Mar-23', 2, 3);
INSERT INTO collection VALUES(2, 2, 721914608, 1, '24-May-73', 1, 4);
INSERT INTO collection VALUES(3, 6, 9780316041263, 2, '01-Feb-10', 1, 5);
INSERT INTO collection VALUES(4, 10, 9781035400119, 1, '04-Aug-23', 1, 2);
INSERT INTO collection VALUES(5, 7, 9780375725609, 2, '12-Oct-03', 1, 1);
INSERT INTO collection VALUES(6, 7, 9780375725609, 5, '15-Dec-04', 1, 3);
INSERT INTO collection VALUES(7, 1, 9780316229296, 3, '08-Jan-16', 1, 1);
INSERT INTO collection VALUES(8, 1, 9780316229296, 2, '08-Jan-16', 1, 2);
INSERT INTO collection VALUES(9, 4, 583118607, 1, '04-Sep-80', 1, 4);
INSERT INTO collection VALUES(10, 9, 2259190537, 1, '20-Nov-00', 2, 6);
INSERT INTO collection VALUES(11, 5, 440194784, 2, '17-Jun-75', 1, 4);
INSERT INTO collection VALUES(12, 5, 440194784, 1, '30-Aug-80', 1, 6);
INSERT INTO collection VALUES(13, 5, 440194784, 1, '30-Aug-80', 1, 2);
INSERT INTO collection VALUES(14, 3, 9780744045567, 1, '01-May-22', 1, 5);

-- Add data / CHECKOUTS
INSERT INTO checkouts ( checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date)
    VALUES (1, 3, 121330, 3, 5, '01-Nov-24', '15-Nov-24');
INSERT INTO checkouts (checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date) 
    VALUES (2, 3, 121330, 5, 5, '01-Nov-24', '15-Nov-24');
INSERT INTO checkouts (checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date) 
    VALUES (4, 4, 121409, 11, 4, '22-Oct-24', '05-Nov-24');
INSERT INTO checkouts VALUES (5, 1, 121053, 13, 3, '17-Oct-24', '31-Oct-24', '23-Oct-24');
INSERT INTO checkouts VALUES (6, 1, 121053, 9, 3, '17-Oct-24', '31-Oct-24', '20-Oct-24');

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

-- Add data / BOOKS
INSERT INTO books VALUES (book_id_seq.nextval, 9780316229296, 'The fifth season', 'N.K.', 'Jemisin', 'Orbit Books', 2015, 1, 7);
INSERT INTO books VALUES (book_id_seq.nextval, 721914608, 'Heraldic design: its origins, ancient forms and modern usage.', 'Hubert', 'Allcock', 
        'Tudor Publishing', 1962, 1, 18);
INSERT INTO books VALUES (book_id_seq.nextval, 9780744045567, 'Woodwork step by step : Carpentry techniques made easy', 'Marc', 'Pattenden', 
        'DK Publishing', 2021, 1, 14);
INSERT INTO books VALUES (book_id_seq.nextval, 440194784, 'Welcome to the monkey house: a collection of short works', 'Kurt', 'Vonnegut', 
        'Dell', 1977, 1, 1);
INSERT INTO books VALUES (book_id_seq.nextval, 9780316041263, 'Monster', 'A. Lee.', 'Martinez', 'Orbit', 2009, 1, 1);
INSERT INTO books VALUES (book_id_seq.nextval, 9780375725609, 'The devil in the white city : murder, magic, and madness at the fair that changed America', 
        'Erik', 'Larson', 'Crown Publishers', 2003, 1, 1);
INSERT INTO books VALUES (book_id_seq.nextval, 9782092495001, 'Comme une famille', 'Rachel', 'Corenblit', 'Nathan', 2023, 2, 1);
INSERT INTO books VALUES (book_id_seq.nextval, 2259190537, 'Vittorio, le vampire : roman', 'Anne', 'Rice', 'Plon', 2000, 2, 3);
INSERT INTO books VALUES (book_id_seq.nextval, 9781035400119, 'Murder at the bonfire', 'Penny', 'Blackwell', 'Headline Accent', 2023, 1, 5);

-- UPDATE COLLECTION -> ID with sequence
BEGIN
    UPDATE COLLECTION
    SET collection_id = collection_id_seq.nextval;
END;
