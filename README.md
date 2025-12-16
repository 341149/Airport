# ✈️ Airline Management Database System

## 📌 Introduction
The Airline Management Database System is a MySQL-based relational database designed to manage and organize the core operations of an airline.  
It handles information related to airlines, airports, routes, flights, passengers, bookings, tickets, payments, aircrafts, seats, fare classes, and crew assignments.

The system is normalized to reduce data redundancy and ensure data integrity.

---

## 🎯 Objectives
- Design a structured airline database using MySQL
- Manage flight schedules and route details
- Store passenger and booking information
- Handle ticketing and payment records
- Manage aircrafts, seats, fare classes, and crew assignments

---

## 🛠️ Technologies Used
- Database: MySQL  
- SQL Tool: MySQL Workbench / phpMyAdmin  
- Language: SQL  

---

## 🗂️ Database Tables

### Airlines
Stores airline details such as name, IATA code, and country.

### Airports
Stores airport information including city, country, IATA/ICAO codes, latitude, and longitude.

### Aircrafts
Contains aircraft model, registration number, capacity, and airline association.

### Routes
Defines routes between origin and destination airports operated by airlines.

### Flights
Stores flight schedules including departure time, arrival time, aircraft, and status.

### Passengers
Stores passenger personal and identification details.

### Bookings
Tracks booking records created by passengers.

### Payments
Stores payment details linked to bookings.

### Fare Classes
Defines travel classes such as Economy and Business with price multipliers.

### Seats
Tracks seat availability for each flight.

### Tickets
Stores ticket details including fare amount, seat, and booking reference.

### Crew
Stores airline crew details such as pilots and cabin crew.

### Crew Assignments
Assigns crew members to flights with specific roles.

---

## 🔗 Relationships
- One airline operates multiple routes
- One route can have multiple flights
- Each flight uses one aircraft
- One passenger can make multiple bookings
- One booking can generate multiple tickets
- One flight has multiple seats
- Crew members are assigned to flights

---

By Group 12
Jaspreet Singh (341139)
Khyati Bhatia (341149)
Pooja Batra (341161)
