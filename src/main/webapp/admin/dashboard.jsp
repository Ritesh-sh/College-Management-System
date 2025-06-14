<%@ page import="com.example.model.User" %>
<%@ page import="com.example.model.Course" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.util.DatabaseUtil" %>

<%
    // Get user from session
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Get stats from database
    int courseCount = DatabaseUtil.getCourseCount();
    int studentCount = DatabaseUtil.getStudentCount();
    int facultyCount = DatabaseUtil.getFacultyCount();
    int activeCourses = DatabaseUtil.getActiveCourseCount();
%>

<!-- Update the stats cards with real data -->
<div class="stat-card">
    <div class="stat-icon" style="background-color: #4e73df;">
        <i class="fas fa-book"></i>
    </div>
    <div class="stat-info">
        <h3>Courses</h3>
        <p id="course-count"><%= courseCount %></p>
    </div>
</div>
<!-- Other stat cards similarly -->