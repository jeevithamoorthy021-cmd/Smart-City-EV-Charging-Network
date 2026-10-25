Smart City EV Charging Network Management

Project Overview

This project demonstrates a Smart City EV Charging Network Management System using PostgreSQL object-relational features and XML.

Objectives

- Store EV user and vehicle information.
- Manage charging stations and socket details.
- Record charging sessions and station logs.
- Represent charging network data using XML.
- Validate XML documents using an XSD schema.

Technologies Used

- PostgreSQL 17
- pgAdmin 4
- XML
- XML Schema Definition (XSD)
- Visual Studio Code

Database Components

- "ev_users" – User information
- "vehicles" – Vehicle details
- "charging_stations" – Station locations and socket information
- "charging_sessions" – Charging session records
- "station_logs" – Station activity logs

Object-Relational Features

- Composite data types
- Arrays
- Primary and foreign keys
- SQL queries and joins

XML Implementation

The "ev_network.xml" file contains charging station, location, socket, user, vehicle, session and log details.

The "ev_network.xsd" file defines the structure and data types used to validate the XML document.

Validation Result

The XML document was successfully validated against the XSD schema using Visual Studio Code.

Screenshots

Project screenshots are included in this repository to demonstrate database queries, XML structure and validation results.

Conclusion

This project demonstrates the use of PostgreSQL and XML to organize and validate information for a smart city EV charging network.
