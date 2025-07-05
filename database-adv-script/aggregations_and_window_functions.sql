/*Get a list of all users along with how many bookings each one has made. 
Include users even if they have made zero bookings, and show those with the most bookings at the top
-LEFT JOIN 
-    booking b ON u.user_id = b.user_id
-Joins the booking table to the user table.
-LEFT JOIN ensures that all users are included in the result, even if they have no bookings.
-The join is made where the user_id in both tables match (b.user_id = u.user_id).
-b is an alias for the booking table.

-GROUP BY 
-    u.user_id, u.first_name, u.last_name
-Because we’re using an aggregation function (COUNT), we must group the results.
-GROUP BY ensures the count is calculated per user.
-Grouping by user_id, first_name, and last_name allows us to include user details along with the count.

-ORDER BY 
    total_bookings DESC;
-Sorts the results by total_bookings in descending order.
-So users with the most bookings appear first in the output.
*/


SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    "user" u
LEFT JOIN 
    booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;


--Rank properties based on total number of bookings
--Uses: COUNT() + RANK() (window function)
--COUNT(b.booking_id): Counts how many bookings each property has.
--ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank: Assigns a unique rank to each property based on booking count 
--GROUP BY: Ensures the aggregation (COUNT) works per property.
--LEFT JOIN: Includes properties with zero bookings.



SELECT 
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    property p
LEFT JOIN 
    booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name
ORDER BY 
    booking_rank;

