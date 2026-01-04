# Smart Bank Management System

## Overview
A comprehensive online banking platform enabling users to manage accounts, transfer funds, and apply for loans. Includes an Admin portal for managing loan requests.

## Tech Stack
- **Backend**: Spring Boot 3.2 (Spring MVC, Spring Data JPA)
- **Frontend**: JSP, JSTL, CSS
- **Database**: MySQL
- **Server**: Apache Tomcat (Embedded)

## Prerequisites
- Java 17 or higher
- MySQL Server running on localhost:3306

## Setup & Running
1. **Database Setup**:
   - Ensure MySQL is running.
   - Values in `src/main/resources/application.properties` are set to `root` / `root`. Update if your MySQL password is different.
   - The application will automatically create the database `smart_bank_db` and all tables.

2. **Run the Application**:
   - Open the project in your IDE (IntelliJ IDEA or Eclipse).
   - Run the `SmartBankSystemApplication` class.
   - OR run via command line: `mvn spring-boot:run`

3. **Access the App**:
   - URL: `http://localhost:8080/`
   - **Register** a new user.
   - **Login** with your credentials.
   - Note: The first registered user is a CUSTOMER. To make an ADMIN, manually update the `role` column in the `users` table to `ADMIN` or register a user and modify the database.

## Features
- **User**:
  - Dashboard with Balance and Recent Transactions.
  - Fund Transfer to other accounts.
  - Loan Application.
  - View Loan Status.
- **Admin**:
  - View all pending loans.
  - Approve or Reject loans.
  - View all loan history.
