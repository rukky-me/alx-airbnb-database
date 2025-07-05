## Objective
This activity aims to demonstrate proficiency in writing SQL queries using different types of joins (INNER JOIN, LEFT JOIN, and FULL OUTER JOIN) to retrieve data from a relational database for a property booking system. The exercise focuses on understanding how each join type affects the result set and when to use each type appropriately.

## Database Schema Overview
The database consists of five main tables:
1. **User**: Stores user information (guests, hosts, and admins)
2. **Property**: Contains property listings with host information
3. **Booking**: Records booking transactions between users and properties
4. **Payment**: Stores payment information for bookings
5. **Review**: Contains user reviews for properties

## Query Explanations

### 1. INNER JOIN Query: Bookings with User Information
**Purpose**: Retrieve all bookings along with the user details of who made each booking.  
**Explanation**:  
- An INNER JOIN returns only the rows where there's a match in both tables
- We're joining the Booking table with the User table on the user_id field
- This query will only return bookings that have a valid associated user

**Query**:
```sql
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
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id;
```

### 2. LEFT JOIN Query: Properties with Reviews
**Purpose**: Retrieve all properties and their reviews, including properties that haven't received any reviews.  
**Explanation**:  
- A LEFT JOIN returns all rows from the left table (Property) and matched rows from the right table (Review)
- If no match exists, NULL values are returned for the right table's columns
- This ensures we get all properties, even those without reviews

**Query**:
```sql
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id;
```

### 3. FULL OUTER JOIN Query: Users and Bookings
**Purpose**: Retrieve all users and all bookings, including users without bookings and bookings not linked to users.  
**Explanation**:  
- A FULL OUTER JOIN returns all rows when there's a match in either left or right table
- This is useful to see the complete picture of both users and bookings
- Note: MySQL doesn't directly support FULL OUTER JOIN, so we emulate it with a UNION of LEFT and RIGHT joins

**Query**:
```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM 
    User u
RIGHT JOIN 
    Booking b ON u.user_id = b.user_id
WHERE 
    u.user_id IS NULL;
```

