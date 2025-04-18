
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
    END IF;
END

CALL add_user('Ankit', 'ankit123@gmail.com')
