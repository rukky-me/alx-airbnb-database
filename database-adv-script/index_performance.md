user table:
user_id – used in JOINs with booking, review, etc.

email – commonly used in WHERE for login/authentication

role – used in filtering by user type

booking table:
booking_id – for joins, filtering

user_id – used in JOINs

property_id – used in JOINs

status – used in filtering

created_at – used in sorting/reports

property table:
property_id – for JOINs

host_id – used in JOINs with user

location – used in searches/filters

pricepernight – may be used in range queries

