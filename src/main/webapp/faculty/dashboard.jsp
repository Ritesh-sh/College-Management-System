<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard</title>
    <link id="theme-style" rel="stylesheet" href="../css/<%= getTheme(request) %>.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        h1 {
            margin: 0;
            color: #333;
        }
        .btn {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-left: 10px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        #assignment-form {
            background-color: #f9f9f9;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
            display: none;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .course-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .course-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            transition: transform 0.3s ease;
        }
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .course-link {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }
        .course-link:hover {
            text-decoration: underline;
        }
        .theme-selector {
            margin-bottom: 20px;
        }
    </style>
    <script>
        function changeTheme(theme) {
            document.getElementById('theme-style').href = `../css/${theme}.css`;
            // Set cookie for 30 days
            document.cookie = `theme=${theme}; max-age=${30*24*60*60}; path=/`;
        }
    </script>
</head>
<body>
    <div class="container">
        <header>
            <h1>Teacher Dashboard</h1>
            <div>
                <div class="theme-selector">
                    <button onclick="changeTheme('light')">Light</button>
                    <button onclick="changeTheme('dark')">Dark</button>
                    <button onclick="changeTheme('blue')">Blue</button>
                </div>
                <button id="grade-submissions-btn" class="btn">Grade Submissions</button>
                <button id="create-assignment-btn" class="btn">Create Assignment</button>
            </div>
        </header>

        <form id="assignment-form">
            <div class="form-group">
                <label for="assignment-title">Assignment Title:</label>
                <input type="text" id="assignment-title" name="title" required>
            </div>
            <div class="form-group">
                <label for="due-date">Due Date:</label>
                <input type="date" id="due-date" name="dueDate" required>
            </div>
            <div class="form-group">
                <label for="assignment-description">Description:</label>
                <textarea id="assignment-description" name="description" rows="4"></textarea>
            </div>
            <button type="submit" class="btn">Save Assignment</button>
        </form>

        <h2>Your Courses</h2>
        <div class="course-list">
            <!-- Hardcoded course examples instead of using JSTL -->
            <div class="course-card">
                <h3><a href="#" class="course-link" data-course="math101">Mathematics 101</a></h3>
                <p>Introduction to Basic Mathematics</p>
                <p><strong>Students:</strong> 32</p>
            </div>
            <div class="course-card">
                <h3><a href="#" class="course-link" data-course="eng201">English 201</a></h3>
                <p>Advanced English Composition</p>
                <p><strong>Students:</strong> 28</p>
            </div>
            <div class="course-card">
                <h3><a href="#" class="course-link" data-course="sci301">Science 301</a></h3>
                <p>Physical Sciences</p>
                <p><strong>Students:</strong> 24</p>
            </div>
            <div class="course-card">
                <h3><a href="#" class="course-link" data-course="hist101">History 101</a></h3>
                <p>World History</p>
                <p><strong>Students:</strong> 30</p>
            </div>
        </div>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", () => {
        const createBtn = document.getElementById("create-assignment-btn");
        const gradeBtn = document.getElementById("grade-submissions-btn");
        const form = document.getElementById("assignment-form");

        // Toggle assignment form display
        createBtn.addEventListener("click", () => {
            form.style.display = form.style.display === "none" || form.style.display === "" ? "block" : "none";
        });

        // Handle assignment form submission
        form.addEventListener("submit", (e) => {
            e.preventDefault();
            const title = document.getElementById("assignment-title").value;
            const dueDate = document.getElementById("due-date").value;
            const description = document.getElementById("assignment-description").value;

            if (title && dueDate) {
                alert(`Assignment "${title}" created with due date: ${dueDate}`);
                form.reset();
                form.style.display = "none";
            } else {
                alert("Please fill in all required fields.");
            }
        });

        // Grading submissions button
        gradeBtn.addEventListener("click", () => {
            window.location.href = "grade-submissions.jsp";
        });

        // Handle course link clicks
        const courseLinks = document.querySelectorAll(".course-link");
        courseLinks.forEach(link => {
            link.addEventListener("click", (e) => {
                e.preventDefault();
                const course = e.target.getAttribute("data-course");
                window.location.href = `course-details.jsp?course=${course}`;
            });
        });
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