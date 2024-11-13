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
