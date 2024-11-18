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

CREATE TABLE language (
  language_id number (3,0),
  language_name varchar2 (255),
  CONSTRAINT language_id_pk PRIMARY KEY (language_id)
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
      REFERENCES book_status (book_status_id),
  CONSTRAINT language_language_id_fk FOREIGN KEY (language_id)
      REFERENCES language (language_id)
);

CREATE TABLE holds (
  hold_id number (10,0),
  patron_id number (6,0),
  card_number number (10,0),
  collection_id number (6,0),
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
  CONSTRAINT language_id_fk FOREIGN KEY (language_id)
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
INSERT INTO branch VALUES(7, 'Albion', '1515 Albion Road Toronto, ON M9V 1B2', '416-394-5170');
INSERT INTO branch VALUES(8, 'Locke', '3083 Yonge Street Toronto, ON M4N 2K7', '416-393-7730');
INSERT INTO branch VALUES(9, 'Runnymede', '2178 Bloor Street West Toronto, ON M65 1M8', '416-393-7697');
INSERT INTO branch VALUES(10, 'St. James Town', '495 Sherbourne Street Toronto, ON M4X 1K7', '416-393-7744');

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
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, 121673, 'Helen', 'Hawkes', '29-May-56', '129 Sesame St.', '416-774-7918', 
    'hhawkes@somewhere.com', 6, 'g_gmbl', '678fgh');
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, '121699', 'Ilsa', 'Ibsen', '09-Nov-79', '130 Sesame St.', '647-686-7546',
    'iibsen@somewhere.com', 8, 'i_ibsn', '890hij');
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, 121725, 'Jamika', 'Jay', '18-May-94', '131 Sesame St.', '416-487-2864', 
    'jjay@somewhere.com', 9, 'j_jy', '901ijk');
INSERT INTO patrons VALUES(patron_id_seq.NEXTVAL, 121751, 'Kip', 'Kotton', '12-Mar-00', '132 Sesame St.', '905-565-6529', 
    'kkotton@somewhere.com', 10, 'k_kttn', '012jkl');


    -- Add data / BOOK_STATUS
INSERT INTO book_status VALUES (1, 'In library');
INSERT INTO book_status VALUES (2, 'Checked out');
INSERT INTO book_status VALUES (3, 'On hold');
INSERT INTO book_status VALUES (4, 'In transit');
INSERT INTO book_status VALUES (5, 'Lost');
INSERT INTO book_status VALUES (6, 'Removed');

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
INSERT INTO collection VALUES(15, 15, 9780786967995, 3, '22-Jul-01', 3, 1);
INSERT INTO collection VALUES(16, 15, 9780786967995, 3, '22-Jul-01', 7, 1);
INSERT INTO collection VALUES(17, 15, 9780786967995, 3, '22-Jul-01', 6, 1);
INSERT INTO collection VALUES(18, 11, 978150329387, 3, '24-Jan-08', 8, 1);
INSERT INTO collection VALUES(19, 12, 9781609522124, 1, '24-May-20', 9, 1);
INSERT INTO collection VALUES(20, 12, 9781609522124, 1, '24-May-21', 5, 1);
INSERT INTO collection VALUES(21, 13, 9780063330658, 1, '24-Aug-20', 10, 1);
INSERT INTO collection VALUES(22, 13, 9780063330658, 2, '24-Aug-20', 8, 1);
INSERT INTO collection VALUES(23, 14, 9781851689378, 1, '12-Sep-24', 7, 1);
INSERT INTO collection VALUES(24, 14, 9781851689378, 5, '12-Sep-24', 9, 1);
INSERT INTO collection VALUES(25, 14, 9781851689378, 1, '12-Sep-24', 1, 1);


-- Add data / CHECKOUTS
INSERT INTO checkouts ( checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date)
    VALUES (1, 3, 121330, 3, 5, '01-Nov-24', '15-Nov-24');
INSERT INTO checkouts (checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date) 
    VALUES (2, 3, 121330, 5, 5, '01-Nov-24', '15-Nov-24');
INSERT INTO checkouts ( checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date)
    VALUES (3, 2, 121323, 8, 2, '28-Oct-24', '11-Nov-24');
INSERT INTO checkouts (checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date) 
    VALUES (4, 4, 121409, 11, 4, '22-Oct-24', '05-Nov-24');
INSERT INTO checkouts VALUES (5, 1, 121053, 13, 3, '17-Oct-24', '31-Oct-24', '23-Oct-24');
INSERT INTO checkouts VALUES (6, 1, 121053, 9, 3, '17-Oct-24', '31-Oct-24', '20-Oct-24');
INSERT INTO checkouts ( checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date)
    VALUES (7, 6, 121673, 10, 6, '12-Nov-24', '26-Nov-24');
INSERT INTO checkouts ( checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date)
    VALUES (8, 10, 121699, 24, 9, '16-Nov-24', '30-Nov-24');
INSERT INTO checkouts ( checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date)
    VALUES (9, 5, 121725, 14, 1, '16-Nov-24', '30-Nov-24');
INSERT INTO checkouts ( checkout_id, patron_id, card_number, collection_id, branch_id, checkout_date, due_date)
    VALUES (10, 7, 121751, 19, 9, '16-Nov-24', '30-Nov-24');

-- Add data / GENRE
INSERT INTO genre VALUES (1, 'General Fiction');
INSERT INTO genre VALUES (2, 'Historical Fiction');
INSERT INTO genre VALUES (3, 'Horror');
INSERT INTO genre VALUES (4, 'Fantasy');
INSERT INTO genre VALUES (5, 'Mysteries / Suspense / Thrillers');
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
INSERT INTO books VALUES (book_id_seq.nextval, 583118607, 'The knight of the swords', 'Michael', 'Moorcock', 'Mayflower', 1971, 1, 7);
INSERT INTO books VALUES (book_id_seq.nextval, 9781250329387, 'The co-op', 'Tarah', 'Dewitt', 'St. Martins Griffin', 2024, 1, 6);
INSERT INTO books VALUES (book_id_seq.nextval, 9781609522124, 'Paris lost and found: a memoir of love', 'Scott Dominic', 'Carpenter', 'Solas House, Inc.', 2024, 1, 10);
INSERT INTO books VALUES (book_id_seq.nextval, 9780063330658, 'Stacked: the art of the perfect sandwich', 'Owen', 'Han', 'William Morrow', 2024, 1, 15);
INSERT INTO books VALUES (book_id_seq.nextval, 9781851689378, 'Philosophy: a beginner guide', 'Peter', 'Cave', 'Oxford: Oneworld', 2012, 1, 21);
INSERT INTO books VALUES (book_id_seq.nextval, 9780786967995, 'Journeys through the radiant citadel', 'Justice Ramin', 'Arman', 'wizards of the Coast', 2022, 1, 4);

--Add data / HOLDS
INSERT INTO holds VALUES (1, 1, 121053, 24, '21-Sep-24', 'waiting');
INSERT INTO holds VALUES (2, 2, 121323, 6, '22-Dec-15', 'waiting');
INSERT INTO holds VALUES (3, 7, 121673, 7, '24-Nov-01', 'ready');
INSERT INTO holds VALUES (4, 2, 121323, 15, '24-Nov-02', 'ready');
INSERT INTO holds VALUES (5, 5, 121591, 5, '24-Nov-03', 'waiting');
INSERT INTO holds VALUES (6, 8, 121699, 17, '24-Nov-04', 'ready');
INSERT INTO holds VALUES (7, 8, 121699, 18, '24-Nov-05', 'ready');
INSERT INTO holds VALUES (8, 9, 121725, 22, '24-Nov-06', 'waiting');
INSERT INTO holds VALUES (9, 6, 121647, 3, '24-Nov-07', 'waiting');
INSERT INTO holds VALUES (10, 4, 121409, 8, '24-Nov-08', 'waiting');


-- UPDATE COLLECTION -> ID with sequence
BEGIN
    UPDATE COLLECTION
    SET collection_id = collection_id_seq.nextval;
END;

--INDEXES
CREATE INDEX patron_name_idx
    ON patrons(fname, lname);

CREATE INDEX book_title_idx
    ON books(title);

CREATE INDEX author_idx
    ON books(author_fname, author_lname);

CREATE UNIQUE INDEX branch_name_idx
    ON branch(branch_name);

CREATE INDEX genre_name_idx
    ON genre(genre_name);

CREATE UNIQUE INDEX email_idx
    ON patrons(email);

CREATE UNIQUE INDEX phone_idx
    ON patrons(patron_phone);

--PACKAGE CONTAINING 3 PROCEDURES AND 3 FUNCTIONS
CREATE OR REPLACE PACKAGE LIBRARY_PKG 
    AS 
    PROCEDURE DISPLAY_BORROW_HISTORY(
        param_patron_id IN patrons.patron_id%TYPE,
        param_card_number IN patrons.card_number%TYPE);
    FUNCTION RETURN_NEW_DUE_DATE_SF(
        param_checkout_id IN checkouts.checkout_id%TYPE,
        param_patron_id IN checkouts.patron_id%TYPE) 
        RETURN DATE;
    PROCEDURE UPDATE_DUE_DATE_TABLE(
        param_checkout_id IN checkouts.checkout_id%TYPE,
        param_patron_id IN checkouts.patron_id%TYPE);
    PROCEDURE BOOK_SEARCH_SP(
        search_filter IN VARCHAR2,
        unspecific_param IN VARCHAR2);
    FUNCTION LOGIN_CHECK_SF(
        param_username IN patrons.username%TYPE,
        param_password IN patrons.password%TYPE) 
        RETURN VARCHAR2;
    FUNCTION CHECK_BOOK_AVAILABILITY(
        param_collection_id IN collection.collection_id%TYPE,
        param_book_id IN collection.book_id%TYPE) 
        RETURN VARCHAR2;
END LIBRARY_PKG;

--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY LIBRARY_PKG 
AS
    PROCEDURE DISPLAY_BORROW_HISTORY(
            param_patron_id IN patrons.patron_id%TYPE,
            param_card_number IN patrons.card_number%TYPE)
        AS 
            CURSOR cur_borrow (param_patron_id IN patrons.patron_id%TYPE, param_card_number IN patrons.card_number%TYPE)IS
                SELECT checkout_id, title, author_fname, author_lname, checkout_date, returned_date
                FROM checkouts JOIN collection USING (collection_id) JOIN books USING (book_id)
                WHERE patron_id = param_patron_id AND card_number = param_card_number
                ORDER BY checkout_date;
            TYPE type_rec IS RECORD(
                checkout_id checkouts.checkout_id%TYPE, 
                title books.title%TYPE, 
                author_fname books.author_fname%TYPE, 
                author_lname books.author_lname%TYPE, 
                checkout_date checkouts.checkout_date%TYPE, 
                returned_date checkouts.returned_date%TYPE);
            rec_borrow type_rec;
            BEGIN
            OPEN cur_borrow (param_patron_id, param_card_number);
            LOOP
            FETCH cur_borrow INTO rec_borrow;
                EXIT WHEN cur_borrow%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('Title: ' || rec_borrow.title);
                DBMS_OUTPUT.PUT_LINE('Author: ' || rec_borrow.author_fname || ' ' || rec_borrow.author_lname);
                DBMS_OUTPUT.PUT_LINE('Date Borrowed: ' || rec_borrow.checkout_date);
                DBMS_OUTPUT.PUT_LINE('Date Returned: ' || rec_borrow.returned_date);
                DBMS_OUTPUT.PUT_LINE(' ');
            END LOOP; 
            CLOSE cur_borrow;
            IF rec_borrow.checkout_id IS NULL THEN
                RAISE NO_DATA_FOUND;
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Borrower has not borrowed any books from the collection');
    END DISPLAY_BORROW_HISTORY;
    
    FUNCTION RETURN_NEW_DUE_DATE_SF(
            param_checkout_id IN checkouts.checkout_id%TYPE,
            param_patron_id IN checkouts.patron_id%TYPE) 
            RETURN DATE
        AS 
            lv_new_due_date DATE;
        CURSOR cur_due IS
            SELECT due_date
            FROM checkouts
            WHERE checkout_id = param_checkout_id
                AND patron_id =  param_patron_id;
        BEGIN
        FOR rec_due_date IN cur_due LOOP
            lv_new_due_date := rec_due_date.due_date + 7;
        END LOOP;
        IF lv_new_due_date IS NULL THEN
            RAISE NO_DATA_FOUND;
        END IF;
        RETURN lv_new_due_date;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Please enter valid values!');
            return null;
    END RETURN_NEW_DUE_DATE_SF;
    
    PROCEDURE UPDATE_DUE_DATE_TABLE(
            param_checkout_id IN checkouts.checkout_id%TYPE,
            param_patron_id IN checkouts.patron_id%TYPE)
        AS 
            lv_new_due_date DATE;
            ex_due_date_update EXCEPTION;
        BEGIN
            lv_new_due_date := RETURN_NEW_DUE_DATE_SF(param_checkout_id, param_patron_id);
            UPDATE CHECKOUTS
                SET due_date = lv_new_due_date
                WHERE checkout_id = param_checkout_id
                    AND patron_id = param_patron_id;
            IF SQL%NOTFOUND THEN
                RAISE ex_due_date_update;
            END IF;
        EXCEPTION
            WHEN ex_due_date_update THEN
            DBMS_OUTPUT.PUT_LINE('checkout ID or patron_id does not exist!');
    END UPDATE_DUE_DATE_TABLE;

    PROCEDURE BOOK_SEARCH_SP(
            search_filter IN VARCHAR2,
            unspecific_param IN VARCHAR2)
        AS 
            cv_search SYS_REFCURSOR;
            lv_input1 VARCHAR2(255) := UPPER(search_filter);
            TYPE type_rec IS RECORD(
                title books.title%TYPE,
                author_fname books.author_fname%TYPE,
                author_lname books.author_lname%TYPE,
                genre_name genre.genre_name%TYPE);
            rec_search type_rec;
        BEGIN
            IF lv_input1 = 'TITLE' THEN
                OPEN cv_search FOR SELECT title, author_fname,author_lname,genre_name
                                FROM books JOIN genre USING (genre_id)
                                WHERE UPPER(title) = UPPER(unspecific_param);
                LOOP
                FETCH cv_search INTO rec_search;
                    EXIT WHEN cv_search%NOTFOUND;
                    DBMS_OUTPUT.PUT_LINE(rec_search.author_fname ||' ' || rec_search.author_lname || ' - ' 
                                        || rec_search.title);
                END LOOP;
            ELSIF lv_input1 = 'AUTHOR' THEN
                OPEN cv_search FOR SELECT title, author_fname,author_lname,genre_name
                                FROM books JOIN genre USING (genre_id)
                                WHERE UPPER(author_fname) = UPPER(unspecific_param)
                                    OR UPPER(author_lname) = UPPER(unspecific_param)
                                    OR UPPER (author_fname || ' ' || author_lname ) = UPPER(unspecific_param);
                LOOP
                FETCH cv_search INTO rec_search;
                    EXIT WHEN cv_search%NOTFOUND;
                    DBMS_OUTPUT.PUT_LINE(rec_search.author_fname ||' ' || rec_search.author_lname || ' - ' 
                                            || rec_search.title);
                END LOOP;
            ELSIF lv_input1 = 'GENRE' THEN
                OPEN cv_search FOR SELECT title, author_fname,author_lname,genre_name
                                FROM books JOIN genre USING (genre_id)
                                WHERE UPPER(genre_name) = UPPER(unspecific_param);
                LOOP
                FETCH cv_search INTO rec_search;
                    EXIT WHEN cv_search%NOTFOUND;
                    DBMS_OUTPUT.PUT_LINE(rec_search.author_fname ||' ' || rec_search.author_lname || ' - ' 
                                            || rec_search.title);
                END LOOP;
            END IF;
            IF rec_search.title IS NULL THEN
                RAISE NO_DATA_FOUND;
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No results found!');
    END BOOK_SEARCH_SP;

    FUNCTION LOGIN_CHECK_SF(
            param_username IN patrons.username%TYPE,
            param_password IN patrons.password%TYPE) 
            RETURN VARCHAR2
        AS 
            success_message VARCHAR2(100);
            CURSOR cur_credentials (param_username IN patrons.username%TYPE,param_password IN patrons.password%TYPE) IS
                SELECT username, password
                FROM patrons
                WHERE username = param_username AND
                      password = param_password;
                TYPE type_credentials IS RECORD
                    (username patrons.username%TYPE,
                    password patrons.password%TYPE);
                rec_credentials type_credentials;
        BEGIN
            OPEN cur_credentials (param_username, param_password);
            LOOP
            FETCH cur_credentials INTO rec_credentials;
                EXIT WHEN cur_credentials%NOTFOUND;
            END LOOP; 
            CLOSE cur_credentials;
            
            IF rec_credentials.username IS NULL AND
                rec_credentials.password IS NULL THEN
                RAISE NO_DATA_FOUND;
            END IF;
            success_message := 'Login Successful!';
            RETURN success_message;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                success_message := 'Invalid Username or Password!';
                RETURN success_message;
    END LOGIN_CHECK_SF;

    FUNCTION CHECK_BOOK_AVAILABILITY(
            param_collection_id IN collection.collection_id%TYPE,
            param_book_id IN collection.book_id%TYPE) 
            RETURN VARCHAR2 
        AS 
            book_availability VARCHAR2(255);
            CURSOR cur_availability(param_collection_id collection.collection_id%TYPE, param_book_id collection.book_id%TYPE) IS
                SELECT collection_id, book_id, title, book_status_description
                FROM books JOIN collection USING (book_id) JOIN book_status USING (book_status_id)
                WHERE collection_id = param_collection_id
                    AND book_id = param_book_id;
            BEGIN
            FOR rec_availability IN cur_availability(param_collection_id, param_book_id) LOOP
                book_availability := rec_availability.book_status_description;
                DBMS_OUTPUT.PUT_LINE(rec_availability.title || ': ' || book_availability);
                END LOOP;
            IF book_availability IS NULL THEN
                    RAISE NO_DATA_FOUND;
                END IF;
          RETURN book_availability;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Availability status not available for entered values!');
                return null;
    END CHECK_BOOK_AVAILABILITY;

END LIBRARY_PKG;

--CREATE TRIGGERS

-- TRIGGER when Book is CHECKED OUT Part 1 -> Add checkout and due date
create or replace TRIGGER CHECKOUT_1_TRG 
    BEFORE INSERT ON CHECKOUTS 
    FOR EACH ROW
BEGIN
    :new.checkout_date := TO_CHAR(CURRENT_DATE, 'yy-MM-dd');
    :new.due_date := TO_CHAR(CURRENT_DATE + 14, 'yy-MM-dd');
END;

-- TRIGGER when Book is CHECKED OUT Part 2 => Update book status in collection
create or replace TRIGGER CHECKOUT_2_TRG 
    AFTER INSERT ON CHECKOUTS 
    FOR EACH ROW
BEGIN
    UPDATE collection
        SET status_id = 2
        WHERE id = :new.collection_id;
END;

-- TRIGGER when Book is RETURNED Part 1 -> Update book status in collection
create or replace TRIGGER RETURN_TRG_1 
    BEFORE UPDATE OF status_id ON COLLECTION
    FOR EACH ROW
    WHEN (NEW.status_id = 1)
BEGIN
    UPDATE checkouts
        SET returned_date = TO_CHAR(CURRENT_DATE, 'yy-MM-dd')
        WHERE collection_id = :new.id;
END;

-- TRIGGER when Book is RETURNED Part 1 -> If book on hold, update pickup status
create or replace TRIGGER RETURN_TRG_2 
    AFTER UPDATE OF status_id ON COLLECTION
    FOR EACH ROW
    WHEN (NEW.status_id = 1)
BEGIN
    UPDATE holds
        SET status = 'ready'
        WHERE collection_id = :new.id;
END;


/* PROCEDURES AND FUNCTIONS CODES AS STANDALONE SUBPROGRAM UNITS
    (These functions and procedures were originally made outside the package for testing, 
then subsequently deleted from the database once placed inside the package) 

--FUNCTION TO CHECK IF USERNAME AND LOGIN MATCHES
CREATE OR REPLACE FUNCTION LOGIN_CHECK_SF(
    param_username IN patrons.username%TYPE,
    param_password IN patrons.password%TYPE) 
    RETURN VARCHAR2
AS 
    success_message VARCHAR2(100);
    CURSOR cur_credentials (param_username IN patrons.username%TYPE,param_password IN patrons.password%TYPE) IS
        SELECT username, password
        FROM patrons
        WHERE username = param_username AND
              password = param_password;   
    TYPE type_credentials IS RECORD
        (username patrons.username%TYPE,
        password patrons.password%TYPE);
    rec_credentials type_credentials;
BEGIN
    OPEN cur_credentials (param_username, param_password);
    LOOP
    FETCH cur_credentials INTO rec_credentials;
        EXIT WHEN cur_credentials%NOTFOUND;
    END LOOP; 
    CLOSE cur_credentials;
    
    IF rec_credentials.username IS NULL AND
        rec_credentials.password IS NULL THEN
        RAISE NO_DATA_FOUND;
    END IF;
    
    success_message := 'Login Successful!';
    RETURN success_message;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        success_message := 'Invalid Username or Password!';
        RETURN success_message;
END LOGIN_CHECK_SF;

--FUNCTION TO RETURN A NEW DUE DATE FOR A CHECKED-OUT BOOK
create or replace FUNCTION RETURN_NEW_DUE_DATE_SF(
    param_checkout_id IN checkouts.checkout_id%TYPE,
    param_patron_id IN checkouts.patron_id%TYPE) 
    RETURN DATE
AS 
    lv_new_due_date DATE;
    CURSOR cur_due IS
        SELECT due_date
        FROM checkouts
        WHERE checkout_id = param_checkout_id
            AND patron_id =  param_patron_id;
BEGIN
    FOR rec_due_date IN cur_due LOOP
        lv_new_due_date := rec_due_date.due_date + 7;
    END LOOP;
    IF lv_new_due_date IS NULL THEN
        RAISE NO_DATA_FOUND;
    END IF;
    RETURN lv_new_due_date;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Please enter valid values!');
        return null;
END RETURN_NEW_DUE_DATE_SF;

--FUNCTION TO CHECK FOR BOOK AVAILABILITY
CREATE OR REPLACE FUNCTION CHECK_BOOK_AVAILABILITY(
    param_collection_id IN collection.collection_id%TYPE,
    param_book_id IN collection.book_id%TYPE) 
    RETURN VARCHAR2 
AS 
    book_availability VARCHAR2(255);
    CURSOR cur_availability(param_collection_id collection.collection_id%TYPE, param_book_id collection.book_id%TYPE) IS
        SELECT collection_id, book_id, title, book_status_description
        FROM books JOIN collection USING (book_id) JOIN book_status USING (book_status_id)
        WHERE collection_id = param_collection_id
            AND book_id = param_book_id;
BEGIN
    FOR rec_availability IN cur_availability(param_collection_id, param_book_id) LOOP
        book_availability := rec_availability.book_status_description;
        DBMS_OUTPUT.PUT_LINE(rec_availability.title || ': ' || book_availability);
        END LOOP;
        IF book_availability IS NULL THEN
            RAISE NO_DATA_FOUND;
        END IF;
  RETURN book_availability;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Availability status not available for entered values!');
        return null;
END CHECK_BOOK_AVAILABILITY;

--PROCEDURE TO DISPLAY A PATRON'S BORROWING HISTORY
CREATE OR REPLACE PROCEDURE DISPLAY_BORROW_HISTORY(
    param_patron_id IN patrons.patron_id%TYPE,
    param_card_number IN patrons.card_number%TYPE)
AS 
    CURSOR cur_borrow (param_patron_id IN patrons.patron_id%TYPE, param_card_number IN patrons.card_number%TYPE)IS
        SELECT checkout_id, title, author_fname, author_lname, checkout_date, returned_date
        FROM checkouts JOIN collection USING (collection_id) JOIN books USING (book_id)
        WHERE patron_id = param_patron_id AND card_number = param_card_number
        ORDER BY checkout_date;
    TYPE type_rec IS RECORD(
        checkout_id checkouts.checkout_id%TYPE, 
        title books.title%TYPE, 
        author_fname books.author_fname%TYPE, 
        author_lname books.author_lname%TYPE, 
        checkout_date checkouts.checkout_date%TYPE, 
        returned_date checkouts.returned_date%TYPE);
    rec_borrow type_rec;
BEGIN
    OPEN cur_borrow (param_patron_id, param_card_number);
    LOOP
    FETCH cur_borrow INTO rec_borrow;
        EXIT WHEN cur_borrow%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Title: ' || rec_borrow.title);
        DBMS_OUTPUT.PUT_LINE('Author: ' || rec_borrow.author_fname || ' ' || rec_borrow.author_lname);
        DBMS_OUTPUT.PUT_LINE('Date Borrowed: ' || rec_borrow.checkout_date);
        DBMS_OUTPUT.PUT_LINE('Date Returned: ' || rec_borrow.returned_date);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP; 
    CLOSE cur_borrow;
    
    IF rec_borrow.checkout_id IS NULL THEN
        RAISE NO_DATA_FOUND;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Borrower has not borrowed any books from the collection');
END DISPLAY_BORROW_HISTORY;

--PROCEDURE TO UPDATE THE CHECKOUTS TABLE WITH A NEW DUE_DATE
create or replace PROCEDURE UPDATE_DUE_DATE_TABLE(
    param_checkout_id IN checkouts.checkout_id%TYPE,
    param_patron_id IN checkouts.patron_id%TYPE)
AS 
    lv_new_due_date DATE;
    ex_due_date_update EXCEPTION;  
BEGIN
    lv_new_due_date := RETURN_NEW_DUE_DATE_SF(param_checkout_id, param_patron_id);
    
    UPDATE CHECKOUTS
        SET due_date = lv_new_due_date
        WHERE checkout_id = param_checkout_id
            AND patron_id = param_patron_id;
    IF SQL%NOTFOUND THEN
        RAISE ex_due_date_update;
    END IF;    
EXCEPTION
    WHEN ex_due_date_update THEN
    DBMS_OUTPUT.PUT_LINE('checkout ID or patron_id does not exist!');   
END UPDATE_DUE_DATE_TABLE;

--PROCEDURE TO SEARCH FOR BOOKS ACCORDING TO USER INPUT
CREATE OR REPLACE PROCEDURE BOOK_SEARCH_SP(
    search_filter IN VARCHAR2,
    unspecific_param IN VARCHAR2)
AS 
    cv_search SYS_REFCURSOR;
    lv_input1 VARCHAR2(255) := UPPER(search_filter);
   TYPE type_rec IS RECORD(
        title books.title%TYPE,
        author_fname books.author_fname%TYPE,
        author_lname books.author_lname%TYPE,
        genre_name genre.genre_name%TYPE);
    rec_search type_rec;
BEGIN
    IF lv_input1 = 'TITLE' THEN
        OPEN cv_search FOR SELECT title, author_fname,author_lname,genre_name
                        FROM books JOIN genre USING (genre_id)
                        WHERE UPPER(title) = UPPER(unspecific_param);
        LOOP
        FETCH cv_search INTO rec_search;
            EXIT WHEN cv_search%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(rec_search.author_fname ||' ' || rec_search.author_lname || ' - ' || rec_search.title);
        END LOOP;
    ELSIF lv_input1 = 'AUTHOR' THEN
        OPEN cv_search FOR SELECT title, author_fname,author_lname,genre_name
                        FROM books JOIN genre USING (genre_id)
                        WHERE UPPER(author_fname) = UPPER(unspecific_param)
                            OR UPPER(author_lname) = UPPER(unspecific_param)
                            OR UPPER (author_fname || ' ' || author_lname ) = UPPER(unspecific_param);
        LOOP
        FETCH cv_search INTO rec_search;
            EXIT WHEN cv_search%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(rec_search.author_fname ||' ' || rec_search.author_lname || ' - ' || rec_search.title);
        END LOOP;
    ELSIF lv_input1 = 'GENRE' THEN
        OPEN cv_search FOR SELECT title, author_fname,author_lname,genre_name
                        FROM books JOIN genre USING (genre_id)
                        WHERE UPPER(genre_name) = UPPER(unspecific_param);
        LOOP
        FETCH cv_search INTO rec_search;
            EXIT WHEN cv_search%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(rec_search.author_fname ||' ' || rec_search.author_lname || ' - ' || rec_search.title);
        END LOOP;
    END IF;
    IF rec_search.title IS NULL THEN
        RAISE NO_DATA_FOUND;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No results found!');
END BOOK_SEARCH_SP;
*/
