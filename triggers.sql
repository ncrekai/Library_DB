--CREATE triggers

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
