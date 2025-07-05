Query Optimization Report
Objective
Refactor a complex SQL query that retrieves all bookings along with user, property, and payment details to improve performance. This includes:

Writing the initial query (performance.sql)

Analyzing execution using EXPLAIN ANALYZE

Refactoring to reduce execution time

Initial Query (performance.sql)

SELECT  
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,

    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,

    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,

    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date

FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id;
    Performance Analysis (EXPLAIN ANALYZE)



Refactored Optimized Query

SELECT  
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,

    u.first_name,
    u.last_name,
    u.email,

    p.name AS property_name,
    p.location,

    pay.amount,
    pay.payment_method

FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id

WHERE 
    b.status = 'confirmed'
    AND u.role = 'guest';


Optimization Steps
1. Reduced Selected Columns
Removed unnecessary columns (e.g., user.phone_number, property.pricepernight, payment.payment_date) to reduce memory usage and network load.

2. Applied Filtering
Added WHERE clause to return only relevant data:

b.status = 'confirmed'

u.role = 'guest'

This significantly reduced the number of rows scanned and joined.

3. Index Support (from database_index.sql)
Indexed frequently used join/filter columns:

CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_user_role ON "user"(role);
CREATE INDEX idx_booking_status ON booking(status);
