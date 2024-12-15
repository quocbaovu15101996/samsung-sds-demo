# Demo Project

## Requirements

### Backend
- Setup SQL Server Database
- RESTful API using Spring Boot with mandatory validation:
  - Create
  - Read 
  - Update
  - Delete

### Mobile
- View existing records
- Add new records
- Modify existing records
- Remove unwanted records

## Setup Guide

### 1. Clone Project
```bash
git clone <repository-url>

### 2. Setup database (SQL Server)

1. Install SQL Server from: https://www.microsoft.com/en-us/sql-server/sql-server-downloads
2. Create the user table:
CREATE TABLE test.dbo.app_user (
    id int IDENTITY(1,1) NOT NULL,
    first_name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    last_name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    email varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    phone varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    zip_code varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT PK__app_user__3213E83FDA5CC5EA PRIMARY KEY (id),
    CONSTRAINT UQ__app_user__AB6E616438AC2928 UNIQUE (email)
);
3. Backend Setup
- Install Java 17
- Install Maven
- Follow Spring Boot Getting Started Guide: https://spring.io/guides/gs/spring-boot

4. Frontend Setup

- Follow Flutter Installation Guide: https://docs.flutter.dev/get-started/install
