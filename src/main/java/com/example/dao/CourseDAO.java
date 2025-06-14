package com.example.dao;

import com.example.model.Course;
import com.example.util.DatabaseUtil; // or DBUtil if you chose Solution 2
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {
    public List<Course> getAllCourses() throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.name as instructor_name FROM courses c LEFT JOIN users u ON c.instructor_id = u.id";

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setCode(rs.getString("code"));
                course.setName(rs.getString("name"));
                course.setDescription(rs.getString("description"));
                course.setInstructorId(rs.getInt("instructor_id"));
                course.setInstructorName(rs.getString("instructor_name"));
                course.setStartDate(rs.getDate("start_date"));
                course.setEndDate(rs.getDate("end_date"));
                course.setStatus(rs.getString("status"));
                courses.add(course);
            }
        }
        return courses;
    }

    public boolean addCourse(Course course) throws SQLException {
        String sql = "INSERT INTO courses (code, name, description, instructor_id, start_date, end_date, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, course.getCode());
            stmt.setString(2, course.getName());
            stmt.setString(3, course.getDescription());
            stmt.setInt(4, course.getInstructorId());
            stmt.setDate(5, new java.sql.Date(course.getStartDate().getTime()));
            stmt.setDate(6, new java.sql.Date(course.getEndDate().getTime()));
            stmt.setString(7, course.getStatus());

            return stmt.executeUpdate() > 0;
        }
    }

    // Add more methods as needed:
    public Course getCourseById(int id) throws SQLException {
        // Implementation here
    }

    public boolean updateCourse(Course course) throws SQLException {
        // Implementation here
    }

    public boolean deleteCourse(int id) throws SQLException {
        // Implementation here
    }
}