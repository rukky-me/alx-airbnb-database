--INNER JOIN Query

-- The INNER JOIN query does the following:
--SELECT statement identifies which columns we need to execute the query. 1 bookings (booking_id etc) and 2. user(user_id etc)
--note that we are combining booking and user information in one view so you know who made which booking.

--FROM booking b: This is the primary (left) table you're querying from.
--Booking is the table with the booking records.
--b is an alias (nickname) used to shorten references in the query — so instead of writing Booking.booking_id, I just wrote b.booking_id.

--INNER JOIN User u ON b.user_id = u.user_id
--This joins the Booking table with the User table.
--User is aliased as u, so you refer to its columns as u.first_name, etc.
--ON b.user_id = u.user_id: This is the join condition — it links each booking to the user who made it using the foreign key relationship.
--Only records where a booking has a matching user (i.e., a valid user_id) will appear in the result. This is shown by b.user_id matching u.user_id.



SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    booking b
INNER JOIN 
    user u ON b.user_id = u.user_id;


--LEFT JOIN Query
--The LEFT JOIN query does the following:
--SELECT tells the database that you're about to list the columns you want to retrieve from property and review in this case.
--note review column is included to show which properties has reviews  and the ones that does note

--FROM Property p
-- This specifies the main (left) table you're pulling data from.
--Property is the table that stores all property listings.
--The alias p makes it easier to reference its columns later (instead of writing Property.property_id, you just write p.property_id like the one earlier).

--LEFT JOIN review r ON p.property_id = r.property_id;
--LEFT JOIN: Returns all rows from the left table (Property).
--If a property has no matching review, the Review columns will be filled with NULL.
--Review r: Specifies the table to join i.e (Review) and gives it an alias r.
--ON p.property_id = r.property_id: This is the join condition — it matches each property to its corresponding reviews.
--Specifically, it checks if the property_id in Property matches the property_id in Review.


SELECT  
    p.property_id,
    p.name,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at
FROM 
    property p
LEFT JOIN 
    review r ON p.property_id = r.property_id
ORDER BY 
    r.created_at DESC;



--OUTER JOIN Query
-- The SELECT : Tells the database that you’re about to specify the columns you want in your result.
--FROM 
--    User u :Specifies the first table (a.k.a. the left table) you're querying from.
--FULL OUTER JOIN 
--    Booking b ON u.user_id = b.user_id : Combines both LEFT JOIN and RIGHT JOIN behaviors.
--Returns all records from both tables
--If a user has bookings, the matching data is displayed in one row.
--If a user has no bookings, their booking fields (b.booking_id, etc.) will be NULL.
--If a booking has no matching user (orphaned), the user fields (u.user_id, etc.) will be NULL.
--Booking b: Specifies the second table you're joining.
--Aliased as b so you can reference its columns as b.start_date, etc.
--ON u.user_id = b.user_id : This is the join condition that links each user to their bookings based on the user_id field (foreign key relationship).


SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price
FROM 
    user u
FULL OUTER JOIN 
    booking b ON u.user_id = b.user_id;

