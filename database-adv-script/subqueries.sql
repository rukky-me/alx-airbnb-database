/*This uses a non-correlated subquery in the WHERE clause.
A non-correlated subquery runs independently of the outer query.
We calculate average ratings per property in a subquery and then filter based on those results.
The subquery selects all property_ids from the review table where the average rating is greater than 4.0.
The outer query selects property details only for those property_ids returned by the subquery.
*/

SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight
FROM 
    property p
WHERE 
    (
        SELECT AVG(r.rating)
        FROM review r
        WHERE r.property_id = p.property_id
    ) > 4.0;

/*A correlated subquery references a column from the outer query (u.user_id) inside the subquery.
The subquery is evaluated once per row in the outer query.
For each user in the outer query, the subquery counts how many bookings they made.
If a user has more than 3 bookings, they are included in the result.*/



SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    user u
WHERE 
    (
        SELECT 
            COUNT(*) 
        FROM 
            booking b
        WHERE 
            b.user_id = u.user_id
    ) > 3;


