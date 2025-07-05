-- Indexes for user table
CREATE INDEX idx_user_user_id ON "user"(user_id);
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_user_role ON "user"(role);

-- Indexes for booking table
CREATE INDEX idx_booking_booking_id ON booking(booking_id);
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_status ON booking(status);
CREATE INDEX idx_booking_created_at ON booking(created_at);

-- Indexes for property table
CREATE INDEX idx_property_property_id ON property(property_id);
CREATE INDEX idx_property_host_id ON property(host_id);
CREATE INDEX idx_property_location ON property(location);
CREATE INDEX idx_property_pricepernight ON property(pricepernight);


/*Measure the query performance before and after adding indexes using EXPLAIN or ANALYZE.*/
-- Before indexing to measure performance.

EXPLAIN ANALYZE
SELECT 
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    "user" u
JOIN 
    booking b ON u.user_id = b.user_id
WHERE 
    u.role = 'guest'
GROUP BY 
    u.user_id
ORDER BY 
    total_bookings DESC;
