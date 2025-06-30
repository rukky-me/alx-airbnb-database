INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
  (gen_random_uuid(), 'John', 'Walker', 'john@example.com', 'hashed_pwd1', '1234567890', 'guest'),
  (gen_random_uuid(), 'Sammy', 'Gabriel', 'sammy@example.com', 'hashed_pwd2', '0987654321', 'host');

INSERT INTO property (property_id, host_id, name, description, location, pricepernight)
VALUES 
  (gen_random_uuid(), (SELECT user_id FROM users WHERE email='sammy@example.com'), 'Cozy Cabin', 'Quiet place in the woods', 'Oregon', 120.00);

INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES 
  (gen_random_uuid(),
   (SELECT property_id FROM property LIMIT 1),
   (SELECT user_id FROM users WHERE email='john@example.com'),
   '2025-07-01', '2025-07-05', 480.00, 'confirmed');

INSERT INTO payment (payment_id, booking_id, amount, payment_method)
VALUES 
  (gen_random_uuid(), (SELECT booking_id FROM booking LIMIT 1), 480.00, 'credit_card');

INSERT INTO review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
  (gen_random_uuid(),
   (SELECT property_id FROM property LIMIT 1),
   (SELECT user_id FROM users WHERE email = 'john@example.com'),
   5,
   'Absolutely loved the downtown apartment! Clean and convenient.',
   NOW()),

  (gen_random_uuid(),
   (SELECT property_id FROM property LIMIT 1),
   (SELECT user_id FROM users WHERE email = 'sammy@example.com'),
   4,
   'Beautiful villa, but the wifi has issues.',
   NOW());


INSERT INTO message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
  (gen_random_uuid(),
   (SELECT user_id FROM users WHERE email = 'sammy@example.com'),
   (SELECT user_id FROM users WHERE email = 'john@example.com'),
   'Hi John, is the apartment available for July 10-15?',
   NOW() - INTERVAL '1 day'),

  (gen_random_uuid(),
   (SELECT user_id FROM users WHERE email = 'john@example.com'),
   (SELECT user_id FROM users WHERE email = 'sammy@example.com'),
   'Yes, Sammy! It is available. Looking forward to hosting you.',
   NOW() - INTERVAL '1 day' + INTERVAL '5 minutes');

