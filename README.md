# Demo project
Tasks Requirement:

*Backend:
- Setup SQL Server Database
- RESTful API using Spring Boot (validate mandatory): Create, Read, Update, Delete
*Mobile:
- Viewing existing records
- Add new records 
- Modifying existing  records
- Removing unwanted records

# Guide setup project

1. Clone project
2. Setup database (SQL Server) Follow link: https://www.microsoft.com/en-us/sql-server/sql-server-downloads
- Create table user: 
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

3. Setup environment backend (Maven, Spring Boot, Java 17): https://spring.io/guides/gs/spring-boot
4. Setup environment font-end Flutter: https://docs.flutter.dev/get-started/install
