-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT description FROM crime_scene_reports WHERE street = "Chamberlin Street" AND year =2020 AND month = 7 AND day = 28;
Theft of the CS50 duck took place at 10:15am at the Chamberlin Street courthouse.
Interviews were conducted today with three witnesses who were present at the time — each of their interview
transcripts mentions the courthouse.

SELECT name, transcript FROM interviews WHERE year =2020 AND month = 7 AND day = 28;

name | transcript
Jose | “Ah,” said he, “I forgot that I had not seen you for some weeks. It is a little souvenir from the King of Bohemia
in return for my assistance in the case of the Irene Adler papers.”
Eugene | “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having
gone to the ball.”
Barbara | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.”
He looked from one to the other of us, as if uncertain which to address.
Ruth | Sometime within ten minutes of the theft, I saw the thief get into a car in the courthouse parking lot and drive away.
If you have security footage from the courthouse parking lot, you might want to look for cars that left the parking lot in that
time frame.
Eugene | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at the courthouse,
I was walking by the ATM on Fifer Street and saw the thief there withdrawing some money.
Raymond | As the thief was leaving the courthouse, they called someone who talked to them for less than a minute.
In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.

SELECT license_plate, activity FROM courthouse_security_logs
WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <=25

license_plate | activity
5P2BI95 | exit
94KL13X | exit
6P58WS2 | exit
4328GD8 | exit
G412CB7 | exit
L93JTIZ | exit
322W7JE | exit
0NTHK55 | exit


SELECT account_number, transaction_type FROM atm_transactions
WHERE year = 2020 AND month = 7 AND day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw"

account_number | transaction_type
28500762 | withdraw
28296815 | withdraw
76054385 | withdraw
49610011 | withdraw
16153065 | withdraw
25506511 | withdraw
81061156 | withdraw
26013199 | withdraw

SELECT caller, receiver, duration FROM phone_calls
WHERE year = 2020 AND month = 7 AND day = 28

SELECT caller, receiver, duration FROM phone_calls
WHERE year = 2020 AND month = 7 AND day = 28 AND duration < 60

caller | receiver | duration
(130) 555-0289 | (996) 555-8899 | 51
(499) 555-9472 | (892) 555-8872 | 36
(367) 555-5533 | (375) 555-8161 | 45
(499) 555-9472 | (717) 555-1342 | 50
(286) 555-6063 | (676) 555-6554 | 43
(770) 555-1861 | (725) 555-3243 | 49
(031) 555-6622 | (910) 555-3251 | 38
(826) 555-1652 | (066) 555-9701 | 55
(338) 555-6650 | (704) 555-2131 | 54

SELECT id FROM airports WHERE city = "Fiftyville"

8

SELECT person_id FROM bank_accounts
WHERE account_number IN(SELECT account_number FROM atm_transactions
WHERE year = 2020 AND month = 7 AND day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw"
)

SELECT destination_airport_id, hour, minute FROM flights
WHERE origin_airport_id = 8 AND day = 29 AND month = 7 AND year = 2020 ORDER BY hour, minute ASC

destination_airport_id | hour | minute
4 | 8 | 20

1 | 9 | 30
11 | 12 | 15
9 | 15 | 20
6 | 16 | 0

SELECT city FROM airports WHERE id = 4
London

SELECT passport_number FROM passengers WHERE flight_id IN (SELECT id FROM flights
WHERE origin_airport_id = 8 AND destination_airport_id = 4 AND day = 29 AND month = 7 AND year = 2020 AND hour = 8 AND minute = 20 )
7214083635
1695452385
5773159633
1540955065
8294398571
1988161715
9878712108
8496433585



SELECT name FROM people WHERE
license_plate IN(SELECT license_plate FROM courthouse_security_logs
WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <=25
)

INTERSECT

SELECT name FROM people WHERE phone_number IN(SELECT caller FROM phone_calls
WHERE year = 2020 AND month = 7 AND day = 28 AND duration < 60)AND passport_number IN(SELECT passport_number FROM passengers WHERE flight_id IN (SELECT id FROM flights
WHERE origin_airport_id = 8 AND destination_airport_id = 4 AND day = 29 AND month = 7 AND year = 2020 AND hour = 8 AND minute = 20 ))

INTERSECT
SELECT name FROM people WHERE passport_number IN(SELECT passport_number FROM passengers WHERE flight_id IN (SELECT id FROM flights
WHERE origin_airport_id = 8 AND destination_airport_id = 4 AND day = 29 AND month = 7 AND year = 2020 AND hour = 8 AND minute = 20 ))

INTERSECT
SELECT name FROM people WHERE id IN (SELECT person_id FROM bank_accounts
WHERE account_number IN(SELECT account_number FROM atm_transactions
WHERE year = 2020 AND month = 7 AND day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw"
));

SELECT name FROM people
WHERE phone_number IN(SELECT receiver FROM phone_calls
WHERE year = 2020 AND month = 7 AND day = 28 AND duration < 60 AND caller =(SELECT phone_number FROM people WHERE name = "Ernest"))

