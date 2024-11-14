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
