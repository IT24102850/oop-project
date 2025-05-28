Student Course Registration System
A web application for managing student registrations and course enrollments, built with Java, JSP, and Servlets.
Overview
This project simplifies student enrollment and course management, offering a dynamic platform for students and administrators. It leverages JSP for server-side rendering and is deployed on Apache Tomcat. Data persistence is achieved through file handling, using text files instead of a database like MySQL.
Features

User Authentication: Students can sign up (e.g., email, password) and log in securely, with data stored in text files (e.g., students.txt, user_data.txt).
Course Request Management: Students submit course requests via JSP forms, which are reviewed by administrators.
Admin Interface: Admins use a JSP-based dashboard to approve/reject requests and manage profiles.

Technologies

Java
JSP (JavaServer Pages)
Servlets
Apache Tomcat
HTML/CSS/JavaScript
File Handling (for data persistence)

Installation

Clone the repository:  git clone https://github.com/IT24102850/oop-project.git


Install Apache Tomcat on your local machine.
Deploy the project to Tomcat’s webapps directory.
Start Tomcat and access the application at:  http://localhost:8080/student-registration/



Author
Hasiru Chamika - IT24102850, Undergraduate at SLIIT, passionate about software engineering and IoT.
Last Updated
May 28, 2025, at 09:38 PM +0530
License
MIT License
Future Enhancements

Explore integrating a database like MySQL for more robust data persistence.
Deploy the application on a cloud platform like Heroku for a live demo.

