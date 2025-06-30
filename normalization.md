# Database Normalization Steps to Achieve Third Normal Form (3NF)

## Introduction
This document explains explanation of the normalization steps, a review of the database schema against normalization principles, to be sure it passes the Third Normal Form (3NF). 

## Normalization Principles 

* **First Normal Form (1NF):**
    * Each table must have a primary key.
    * Each column must contain atomic (single, indivisible) values.i.e each attribute must hold a piece of information
    * There should be no repeating groups of columns.

* **Second Normal Form (2NF):**
    * Must already be in 1NF, i.e must pass INF
    * All non-key attributes must be fully functionally dependent on the *entire* primary key. (Applies mainly to tables with composite primary keys).

* **Third Normal Form (3NF):**
    * Must already be in 2NF and passes 2NF.
    * There are no transitive dependencies; that is, no non-key attribute is dependent on another non-key attribute, but must depend only on the primary kery

## Schema Review and Normalization Steps

We reviewed each entity (table) in the provided schema against the 1NF, 2NF, and 3NF rules.

### 1. `User` Table

* **Schema:**
    * `user_id` (PK)
    * `first_name`
    * `last_name`
    * `email` (UNIQUE)
    * `password_hash`
    * `phone_number`
    * `role` (ENUM)
    * `created_at`

**1NF Check:** All attributes (`first_name`, `email`, etc.) store single, atomic values. `user_id` serves as a clear primary key. So it Passes 1NF.
**2NF Check:** `user_id` is a simple (non-composite) primary key. All other attributes directly describe the `user_id` and are fully dependent on it. So it Passes 2NF.
**3NF Check:** There are no discernible transitive dependencies. For example, `phone_number` depends on `user_id`, not on `email` (another non-key attribute). All non-key attributes directly describe the `user_id`. The attributes do not depends on one another but only on the primary key. So it Passes 3NF.

### 2. `Property` Table

* **Schema:**
    * `property_id` (PK)
    * `host_id` (FK → User)
    * `name`
    * `description`
    * `location`
    * `pricepernight`
    * `created_at`
    * `updated_at`

* **1NF Check:** All attributes appear atomic. `property_id` is a clear primary key. 
* **2NF Check:** `property_id` is a simple primary key. All attributes directly describe the `property_id`. 
* **3NF Check:** The primary consideration for 3NF here is the `location` attribute.
    * **Assumption:** We assume `location` stores an atomic string (e.g., "Near Eiffel Tower, Paris"). In this context, it directly depends on `property_id` and does not have internal non-key dependencies.
    * **Potential Improvement (Beyond Strict 3NF if `location` were composite):** If `location` were 
### 3. `Booking` Table

* **Schema:**
    * `booking_id` (PK)
    * `property_id` (FK)
    * `user_id` (FK)
    * `start_date`
    * `end_date`
    * `total_price`
    * `status` (ENUM)
    * `created_at`

* **1NF Check:** All attributes are atomic. `booking_id` is the primary key. **Passes 1NF.**
* **2NF Check:** `booking_id` is a simple primary key. All attributes are fully dependent on `booking_id`. **Passes 2NF.**
* **3NF Check:** There are no transitive dependencies. `total_price` is a calculated value specific to this booking and depends on `booking_id`, not on `start_date` or `end_date` as non-key attributes. **Passes 3NF.**

### 4. `Payment` Table

* **Schema:**
    * `payment_id` (PK)
    * `booking_id` (FK)
    * `amount`
    * `payment_date`
    * `payment_method`

* **1NF Check:** All attributes are atomic. `payment_id` is the primary key. **Passes 1NF.**
* **2NF Check:** `payment_id` is a simple primary key. All attributes are fully dependent on `payment_id`. **Passes 2NF.**
* **3NF Check:** No transitive dependencies. All attributes directly describe the payment identified by `payment_id`. **Passes 3NF.**

### 5. `Review` Table

* **Schema:**
    * `review_id` (PK)
    * `property_id` (FK)
    * `user_id` (FK)
    * `rating` (1–5)
    * `comment`
    * `created_at`

* **1NF Check:** All attributes are atomic. `review_id` is the primary key. **Passes 1NF.**
* **2NF Check:** `review_id` is a simple primary key. All attributes are fully dependent on `review_id`. **Passes 2NF.**
* **3NF Check:** No transitive dependencies. All attributes directly describe the review. **Passes 3NF.**

### 6. `Message` Table

* **Schema:**
    * `message_id` (PK)
    * `sender_id` (FK → User)
    * `recipient_id` (FK → User)
    * `message_body`
    * `sent_at`

* **1NF Check:** All attributes are atomic. `message_id` is the primary key. **Passes 1NF.**
* **2NF Check:** `message_id` is a simple primary key. All attributes are fully dependent on `message_id`. **Passes 2NF.**
* **3NF Check:** No transitive dependencies. All attributes directly describe the message. **Passes 3NF.**

