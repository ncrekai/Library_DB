-- CREATE sequence

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

-- UPDATE COLLECTION -> ID with sequence

BEGIN
    UPDATE COLLECTION
    SET id = collection_id_seq.nextval;
END;
