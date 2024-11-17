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
