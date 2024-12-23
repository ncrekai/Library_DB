--FUNCTION TO CHECK IF USERNAME AND PASSWORDS MATCH
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
        --DBMS_OUTPUT.PUT_LINE('Invalid Username or Password!');
        success_message := 'Invalid Username or Password!';
        RETURN success_message;
END LOGIN_CHECK_SF;
--CREATE functions

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
