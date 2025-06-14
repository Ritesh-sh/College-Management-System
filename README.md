# College Management System

A Java web application for managing courses, students, and faculty members in an educational institution. This application provides a user-friendly interface for administrators to manage academic resources efficiently.

## 🚀 Features

- **Course Management**: Add, view, update, and delete courses
- **User Management**: Handle student and faculty accounts
- **Database Integration**: MySQL database with connection pooling using HikariCP
- **Error Handling**: Custom error pages for different types of exceptions
- **Dynamic Variables**: Manage system variables through the admin interface

## 🛠️ Technologies Used

- **Backend**: Java Servlets, JDBC
- **Frontend**: JSP, HTML, CSS, JavaScript
- **Database**: MySQL
- **Build Tool**: Maven
- **Dependency Management**: Maven
- **Connection Pooling**: HikariCP

## 📋 Prerequisites

Before you begin, ensure you have met the following requirements:

- Java JDK 8 or higher
- Apache Maven 3.6.0 or higher
- MySQL Server 8.0 or higher
- Tomcat 9.0 or higher
- Git (for version control)

## 🚀 Installation

1. **Clone the repository**
   ```sh
   git clone https://github.com/yourusername/course-management-system.git
   cd course-management-system
   ```

2. **Set up the database**
   - Create a new MySQL database
   - Import the database schema from `database/schema.sql`
   - Update the database configuration in `src/main/resources/database.properties`

3. **Build the project**
   ```sh
   mvn clean package
   ```

4. **Deploy to Tomcat**
   - Copy the generated `target/lab7.war` to your Tomcat's `webapps` directory
   - Start your Tomcat server

5. **Access the application**
   - Open your browser and go to `http://localhost:8080/lab7`
   - Use the admin credentials to log in

## 🏗️ Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/example/
│   │       ├── controllers/    # Servlet controllers
│   │       ├── dao/           # Data Access Objects
│   │       ├── model/         # Data models
│   │       └── util/          # Utility classes
│   ├── resources/             # Configuration files
│   └── webapp/                # Web application files
│       ├── WEB-INF/           # Web configuration
│       └── assets/            # Static resources (CSS, JS, images)
└── test/                     # Test files
```

## 📝 Database Schema

The application uses the following main tables:
- `users`: Stores user information (students and faculty)
- `courses`: Contains course details
- `enrollments`: Manages student course enrollments
- `variables`: System configuration variables

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

- Project Link: [https://github.com/yourusername/course-management-system](https://github.com/yourusername/course-management-system)
