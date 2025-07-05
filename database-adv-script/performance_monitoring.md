Performance monitoring 
Continuously monitor and improve the performance of frequently used SQL queries by:

Analyzing execution plans (EXPLAIN, EXPLAIN ANALYZE, or SHOW PROFILE)

Identifying performance bottlenecks

Making informed schema or indexing adjustments

Reporting improvements

Tools Used
EXPLAIN ANALYZE (PostgreSQL) 
Query logs
Indexing commands (CREATE INDEX)


Monitored Queries
1. Retrieve all confirmed bookings for guest users

EXPLAIN ANALYZE
SELECT  
    b.booking_id,
    b.start_date,
    b.total_price,
    u.first_name,
    p.name AS property_name
FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
WHERE 
    b.status = 'confirmed'
    AND u.role = 'guest';
🔎 Analysis Before Optimization
Full table scans on booking and user

Estimated high cost in join due to non-indexed role and status columns

