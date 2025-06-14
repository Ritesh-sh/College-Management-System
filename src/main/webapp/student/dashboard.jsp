
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        /* Header Styles */
        .dashboard-header {
            background-color: #2c3e50;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .logo h1 {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .user-controls {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .theme-selector button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #3498db;
            color: white;
            transition: background-color 0.3s;
        }

        .theme-selector button:hover {
            background-color: #2980b9;
        }

        .user-info {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .user-info a {
            color: #ecf0f1;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .user-info a:hover {
            text-decoration: underline;
        }

        /* Dashboard Container */
        .dashboard-container {
            display: flex;
            max-width: 1200px;
            margin: 2rem auto;
            gap: 2rem;
        }

        /* Navigation Styles */
        .dashboard-nav {
            width: 250px;
            background-color: #ffffff;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .dashboard-nav ul {
            list-style: none;
        }

        .dashboard-nav li {
            margin: 0.5rem 0;
        }

        .dashboard-nav a {
            text-decoration: none;
            color: #2c3e50;
            font-weight: 500;
            display: block;
            padding: 0.75rem;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .dashboard-nav a:hover {
            background-color: #e8ecef;
        }

        /* Main Content */
        .dashboard-main {
            flex: 1;
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .dashboard-section {
            margin-bottom: 2rem;
        }

        .dashboard-section h2 {
            font-size: 1.8rem;
            color: #2c3e50;
            margin-bottom: 1rem;
        }

        /* Stats Container */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .stat-card {
            background-color: #3498db;
            color: white;
            padding: 1.5rem;
            border-radius: 8px;
            text-align: center;
        }

        .stat-card h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .stat-count {
            font-size: 1.8rem;
            font-weight: bold;
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #e8ecef;
        }

        th {
            background-color: #f1f3f5;
            font-weight: 600;
            color: #2c3e50;
        }

        .text-center {
            text-align: center;
        }

        /* Button Styles */
        .btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        /* Footer Styles */
        .dashboard-footer {
            text-align: center;
            padding: 1rem;
            background-color: #2c3e50;
            color: white;
            margin-top: 2rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
                margin: 1rem;
            }

            .dashboard-nav {
                width: 100%;
            }

            .dashboard-main {
                padding: 1rem;
            }
        }
    </style>
    <script>
        function changeTheme(theme) {
            document.getElementById('theme-style').href = `../css/${theme}.css`;
            // Set cookie for 30 days
            document.cookie = `theme=${theme}; max-age=${30*24*60*60}; path=/`;
        }

        function toggleSection(sectionId) {
            const section = document.getElementById(sectionId);
            const sections = document.querySelectorAll('.dashboard-section');

            sections.forEach(s => {
                if (s.id !== sectionId) {
                    s.style.display = 'none';
                }
            });

            section.style.display = section.style.display === 'none' || section.style.display === '' ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <header class="dashboard-header">
        <div class="logo">
            <h1>Learning Management System</h1>
        </div>
        <div class="user-controls">
            <div class="theme-selector">
                <button onclick="changeTheme('light')">Light</button>
                <button onclick="changeTheme('dark')">Dark</button>
                <button onclick="changeTheme('blue')">Blue</button>
            </div>
            <div class="user-info">
                <span>Welcome, <%= currentUser.getName() %></span>
                <a href="profile.jsp">Profile</a>
                <a href="logout">Logout</a>
            </div>
        </div>
    </header>

    <div class="dashboard-container">
        <nav class="dashboard-nav">
            <ul>
                <li><a href="#" onclick="toggleSection('overview-section'); return false;">Dashboard Overview</a></li>
                <li><a href="#" onclick="toggleSection('courses-section'); return false;">My Courses</a></li>
                <li><a href="#" onclick="toggleSection('assignments-section'); return false;">Assignments</a></li>
                <li><a href="#" onclick="toggleSection('grades-section'); return false;">Grades</a></li>
            </ul>
        </nav>

        <main class="dashboard-main">
            <!-- Dashboard Overview Section -->
            <section id="overview-section" class="dashboard-section">
                <h2>Dashboard Overview</h2>
                <div class="stats-container">
                    <div class="stat-card">
                        <h3>Enrolled Courses</h3>
                        <p class="stat-count">4</p>
                    </div>
                    <div class="stat-card">
                        <h3>Pending Assignments</h3>
                        <p class="stat-count">3</p>
                    </div>
                    <div class="stat-card">
                        <h3>Average Grade</h3>
                        <p class="stat-count">85%</p>
                    </div>
                </div>

                <div class="upcoming-assignments">
                    <h3>Upcoming Deadlines</h3>
                    <table class="assignment-table">
                        <thead>
                            <tr>
                                <th>Assignment</th>
                                <th>Course</th>
                                <th>Due Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Project Proposal</td>
                                <td>Computer Science 101</td>
                                <td>2025-04-25</td>
                                <td>Pending</td>
                            </tr>
                            <tr>
                                <td>Essay Draft</td>
                                <td>English Literature</td>
                                <td>2025-04-27</td>
                                <td>Pending</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="recent-announcements">
                    <h3>Recent Announcements</h3>
                    <div class="announcement-list">
                        <div class="announcement-item">
                            <h4>Guest Lecture Scheduled</h4>
                            <p class="announcement-meta">
                                <span>Course: Computer Science 101</span>
                                <span>Posted: 2025-04-20</span>
                            </p>
                            <p>Join us for a guest lecture on AI advancements this Friday.</p>
                        </div>
                        <div class="announcement-item">
                            <h4>Exam Schedule Posted</h4>
                            <p class="announcement-meta">
                                <span>Course: Mathematics 201</span>
                                <span>Posted: 2025-04-19</span>
                            </p>
                            <p>Midterm exam schedule is now available.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- My Courses Section -->
            <section id="courses-section" class="dashboard-section" style="display: none;">
                <h2>My Courses</h2>
                <div class="course-grid">
                    <p>You are not enrolled in any courses.</p>
                    <a href="browse-courses.jsp" class="btn">Browse Available Courses</a>
                </div>
            </section>

            <!-- Assignments Section -->
            <section id="assignments-section" class="dashboard-section" style="display: none;">
                <h2>Assignments</h2>
                <div class="filter-controls">
                    <select id="assignment-filter">
                        <option value="all">All Assignments</option>
                        <option value="pending">Pending</option>
                        <option value="submitted">Submitted</option>
                        <option value="graded">Graded</option>
                    </select>
                </div>
                <table class="assignments-table">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Course</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th>Grade</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6" class="text-center">No assignments found!</td>
                        </tr>
                    </tbody>
                </table>
            </section>

            <!-- Grades Section -->
            <section id="grades-section" class="dashboard-section" style="display: none;">
                <h2>Grades</h2>
                <div class="grades-container">
                    <div class="overall-grade">
                        <h3>Overall GPA</h3>
                        <div class="grade-circle">
                            <span>3.7</span>
                        </div>
                    </div>
                    <div class="course-grades">
                        <h3>Course Grades</h3>
                        <table class="grades-table">
                            <thead>
                                <tr>
                                    <th>Course</th>
                                    <th>Grade</th>
                                    <th>Details</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="3" class="text-center">No grades available!</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <footer class="dashboard-footer">
        <p>© 2025 Learning Management System. All rights reserved.</p>
    </footer>

    <script>
        // Display the overview section by default
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('overview-section').gradle style.display = 'block';

            // Set up the assignment filter
            const assignmentFilter = document.getElementById('assignment-filter');
            if (assignmentFilter) {
                assignmentFilter.addEventListener('change', function() {
                    const value = this.value;
                    const rows = document.querySelectorAll('.assignment-row');

                    rows.forEach(row => {
                        if (value === 'all') {
                            row.style.display = '';
                        } else {
                            row.style.display = row.classList.contains(value) ? '' : 'none';
                        }
                    });
                });
            }
        });
    </script>
</body>
</html>

<%!
    private String getTheme(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("theme")) {
                    return cookie.getValue();
                }
            }
        }
        return "light"; // default theme
    }
%>