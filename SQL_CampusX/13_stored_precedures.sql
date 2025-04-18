
USE campusx1;

# CALL hello_world()

USE zomato;

CREATE PROCEDURE add_user (
   IN input_name VARCHAR(255),
   IN input_email VARCHAR(255),
   OUT message VARCHAR(255)
)
BEGIN
    -- check if input_email exists in users table. 
    DECLARE user_count INTEGER;
    SELECT COUNT(*) INTO user_count FROM users WHERE email = input_email;
    
    IF user_count = 0 THEN 
        INSERT INTO users (name, email) VALUES (input_name, input_email);
        SET message = "User Inserted";
    ELSE
        SET message = "Email already exists";
    END IF;
END

-- Calling the Procedure
SET @message = ''; 
CALL add_user('Ankit', 'ankit123@gmail.com', @message)
SELECT @message -- Printing the output.

--
CREATE PROCEDURE place_order (
    IN input_user_id INTEGER,
    IN input_r_id INTEGER,
    OUT total_amount INTEGER
)
BEGIN
    -- insert into orders table. 
    DECLARE new_order_id INTEGER; -- declaring a new variable.
    DECLARE f_id1 INTEGER;
    DECLARE f_id2 INTEGER;

    SET f_id1 = SUBSTRING_INDEX(input_f_ids, ',', 1);
    SET f_id2 = SUBSTRING_INDEX(input_f_ids, ',', -1)

    SELECT MAX(order_id) + 1 INTO new_order_id FROM orders;

    SELECT SUM(price) FROM menu
    WHERE r_id = input_r_Id AND f_id (f_id1, f_id2)

    -- Insert into order_details table. 
    INSER INTO orders (order_id, user_id, r_id, amount, date) VALUES
    (new_order_id, input_user_id, input_r_id, total_amount, DATE(NOW()));

    INSERT INTO order_details (order_id, f_id) VALUES
    (new_order_id, f_id1), (new_order_id, f_id2)
END

-- Transactions.
-- Commit, Rollback and Savepoint. 
-- Commit -> to save the change permanently, cannot be rollback.
-- Rollback -> used to undo the change made by a transaction.
-- Savepoint -> used to mark a specific point within a transaction where a rollback can be performed.


-- What is Autocommit ?
-- automatically commits each invidiual db transaction as soon as it completed, rather than an requires explicit commit command to be issued. 

START TRANSACTIONS 



-- ACID properties of a transaction?
-- 1. 
