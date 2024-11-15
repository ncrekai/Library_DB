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
