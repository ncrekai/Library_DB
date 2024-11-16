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

--PROCEDURE TO UPDATE DUE_DATE ON THE CHECKOUTS TABLE
create or replace PROCEDURE UPDATE_DUE_DATE_TABLE(
    param_checkout_id IN checkouts.checkout_id%TYPE,
    param_patron_id IN checkouts.patron_id%TYPE)
AS 
    lv_new_due_date DATE;
BEGIN
    lv_new_due_date := RETURN_NEW_DUE_DATE_SF(param_checkout_id, param_patron_id);
UPDATE CHECKOUTS
        SET due_date = lv_new_due_date
        WHERE checkout_id = param_checkout_id
            AND patron_id = param_patron_id;
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
