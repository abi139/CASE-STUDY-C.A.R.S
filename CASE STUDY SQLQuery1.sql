------------------------------------------------------------------CASE STUDY (Crime Analysis and Reporting System) CARS---------------------------------------------------------------------------------------------------
--CREATE DATABASE
CREATE DATABASE CARS

USE CARS

---CREATE TABLES

/**1. Schema design:
Entities:
1. Incidents:
• IncidentID (Primary Key)
• IncidentType (e.g., Robbery, Homicide, Theft)
• IncidentDate
• Location (Geospatial Data: Latitude and Longitude)
• Description
• Status (e.g., Open, Closed, Under Investigation)
• VictimID (Foreign Key, linking to Victims)
• SuspectId(Foreign Key, Linking to Suspect) ***/

CREATE TABLE Incidents(
IncidentID int Primary Key not null,
IncidentType varchar(20) not null,
IncidentDate date not null,
Locationn varchar(20) not null,
Descriptionn text,
statuss varchar(20) not null,
VictimID int ,
foreign key (VictimID) references Victims(VictimID),
SuspectID int ,
foreign key (SuspectID) references Suspects(SuspectID))

alter table Incidents
alter column VictimID
foreign key (VictimID) references Victims(VictimID) on delete cascade


/***Victims:
• VictimID (Primary Key)
• FirstName
• LastName
• DateOfBirth
• Gender
• Contact Information (e.g., Address, Phone Number)***/CREATE TABLE Victims(VictimID int Primary key not null,V_FirstName varchar(20) not null,V_LastName varchar(20) not null,V_DateOfBirth date not null,V_Gender varchar not null,V_Address varchar(100) ,V_Phone varchar(10))/***3. Suspects:
• SuspectID (Primary Key)
• FirstName
• LastName
• DateOfBirth
• Gender
• Contact Information ***/create table Suspects(SuspectID int Primary Key not null,S_FirstName varchar(20) not null,S_LastName varchar(20) not null,S_DateOfBirth date not null,S_Gender varchar not null,S_Addresss varchar(50) not null,S_Phone varchar(10) not null)/**4. Law Enforcement Agencies:
• AgencyID (Primary Key)
• AgencyName
• Jurisdiction
• Contact Information
• Officer(s) (Link to Officers within the agency) ***/CREATE TABLE Agencies(AgencyID int Primary key not null,AgencyName varchar(20) not null,Jurisdication varchar(100),Phone varchar(10) not null)--Officer(s) (Link to Officers within the agency)alter table Agenciesadd OfficerID int ,foreign key (OfficerID) references Officers(OfficerID)/***5. Officers:
• OfficerID (Primary Key)
• FirstName
• LastName
• BadgeNumber
• Rank
• Contact Information
• AgencyID (Foreign Key, linking to Law Enforcement Agencies) ***/CREATE TABLE Officers(OfficerID int Primary key not null,Off_FirstName varchar(20) not null,Off_LastName varchar(20) not null,BadgeNumber int not null,Ranks int not null,Off_Phone varchar(10) not null,AgencyID int ,foreign key (AgencyID) references Agencies(AgencyID))/***6. Evidence:
• EvidenceID (Primary Key)
• Description
• Location Found
• IncidentID (Foreign Key, linking to Incidents)****/CREATE TABLE Evidence(EvidenceID int Primary key not null,Descriptionn varchar(100) not null,Location_Found varchar(50),IncidentID int,foreign key (IncidentID) references Incidents(IncidentID))/***7. Reports:
• ReportID (Primary Key)
• IncidentID (Foreign Key, linking to Incidents)
• ReportingOfficer (Foreign Key, linking to Officers)
• ReportDate
• ReportDetails
• Status (e.g., Draft, Finalized)***/CREATE TABLE Reports(ReportID int Primary key not null,IncidentID int,foreign key (IncidentID) references Incidents(IncidentID),ReportingOfficer int ,Foreign key (ReportingOfficer) references Officers(OfficerID),ReportDate date,ReportDetails text,Report_status varchar(20))------------------INSERT VALUES TO EACH TABLE---------------------------------insert into Incidents(IncidentID,IncidentType,IncidentDate,Locationn,Descriptionn,statuss,VictimID,SuspectID) values
(1, 'Robbery', '2024-01-15','Mumbai','Armed Robbery','Open', 101, 201),
(2, 'Homicide', '2024-02-20','Chennai', 'Murder case','Closed', 102, 202),
(3, 'Theft', '2024-03-10','Bihar','Shoplifting','Under Investigation', NULL, 203),
(4, 'Assault', '2023-04-05','Haryana','Physical altercation','Open', 104, 204),
(5, 'Robbery', '2023-05-18','Delhi','Street Robbery', 'Closed', 105, 205);
INSERT INTO Victims (VictimID, V_FirstName, V_LastName, V_DateOfBirth, V_Gender, V_Address,V_Phone) VALUES
(101, 'John', 'Doe', '1985-07-10', 'M', '123 Main St,Chennai', '9876543210'),
(102, 'Jane', 'Smith', '1978-12-05', 'F', '456 Elm St,Trichy','8976543210'),
(103, 'Michael','Johnson', '1990-03-20', 'M', '789 Oak St,Bihar','7896543210'),
(104, 'Emily', 'Brown', '1995-09-15', 'F', '321 Pine St, Delhi','6789054321'),
(105, 'David', 'Wilson', '1982-05-30', 'M','567 Maple St,Agra','5678904321');

INSERT INTO Suspects (SuspectID, S_FirstName, S_LastName, S_DateOfBirth,S_Gender, S_Addresss,S_Phone) VALUES
(201, 'Mark', 'Johnson', '1992-08-20', 'M', '111 Oak St,Madurai','4567890321'),
(202, 'Sarah', 'Lee', '1980-04-15', 'F', '222 Gandhi St,Bihar','3456789012'),
(203, 'Jason', 'Miller','1987-10-25','M','333 Pine St,Delhi' ,'3546789012'),
(204, 'Lisa', 'White', '1976-06-12', 'F', '444 Nehru St,Chennai','5123467890'),
(205, 'Alex', 'Taylor', '1993-02-28','M','555 Cedar St, Haryana','9786756453');

INSERT INTO Agencies(AgencyID, AgencyName, Jurisdication,Phone ) VALUES
(1, 'CBI', 'Delhi City', '555-1000'),
(2, 'FBI', 'Agra', '555-2000'),
(3, 'Metropolitan Police', 'Bangalore', '555-3000'),
(4, 'Chennai Police', 'Chennai', '555-4000'),
(5, 'DGP', 'Mumbai', '555-5000');

update Agencies 
set OfficerID=
case
when AgencyID=1 then 1
when AgencyID=2 then 2
when AgencyID=3 then 5
when AgencyID=4 then 4
when AgencyID=5 then 3
else null
end

INSERT INTO Officers (OfficerID,Off_FirstName, Off_LastName, BadgeNumber, Ranks, Off_Phone, AgencyID) VALUES
(1, 'Michael', 'Johnson','123',1,'555-1234',1),
(2, 'Sarah', 'Smith', '234',2, '555-5678',1),
(3, 'David', 'Brown', '345',3, '555-9012',3),
(4, 'Emily', 'Lee', '456', 3, '555-3456', 4),
(5, 'John', 'Wilson','678', 4, '555-7890',2);

INSERT INTO Evidence (EvidenceID, Descriptionn, Location_Found, IncidentID) VALUES
(1, 'Fingerprints', 'Inside a glove at the scene', 1),
(2, 'Security camera footage', 'Store surveillance video', 3),
(3, 'DNA samples', 'Found on clothing', 2),
(4, 'Weapon', 'Recovered near crime scene', 4),
(5, 'Footprints', 'Found near the window', 5);

INSERT INTO Reports (ReportID, IncidentID, ReportingOfficer, ReportDate, ReportDetails, Report_status) VALUES
(1, 1, 1, '2024-01-16', 'Initial report', 'Draft'),
(2, 2, 3, '2024-02-21', 'Final report', 'Finalized'),
(3, 3, 2, '2024-03-11', 'Ongoing investigation', 'Draft'),
(4, 4, 4, '2023-04-06', 'Report filed', 'Finalized'),
(5, 5, 5, '2023-05-19', 'Incident report', 'Finalized');



--Create a new incident
INSERT into Incidents(IncidentID,IncidentType,IncidentDate,Locationn,Descriptionn,statuss,VictimID,SuspectID) values
(6,'Arson', '2024-06-30', 'Bangalore', 'Building fire', 'Open', 104, 205);

select* from Incidents

--Update the status of an incident
update Incidents
set statuss='Closed'
where IncidentID=4

--Get a list of incidents within a date range
declare @start_date date
set @start_date='2023-01-01'
select * from Incidents
where IncidentDate between @start_date and getdate() 

--Search for incidents based on various criteria searchIncidents(IncidentType criteria);
select *from Incidents
where IncidentType ='Robbery'

--Generate incident reports generateIncidentReport(); parameters- Incident object ,return type Report object
select *from Reports R
where ReportID in (select IncidentID from Incidents where  IncidentID=2 )










