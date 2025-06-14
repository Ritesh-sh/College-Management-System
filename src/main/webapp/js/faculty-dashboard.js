// Simple Faculty Dashboard JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Create Assignment button functionality
    const createAssignBtn = document.getElementById('create-assignment-btn');
    if (createAssignBtn) {
        createAssignBtn.addEventListener('click', function() {
            alert('Create Assignment form would open here');
        });
    }

    // Grade Submissions button functionality
    const gradeBtn = document.getElementById('grade-submissions-btn');
    if (gradeBtn) {
        gradeBtn.addEventListener('click', function() {
            alert('Grade Submissions interface would open here');
        });
    }

    // Course navigation
    const courseLinks = document.querySelectorAll('.course-link');
    courseLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const courseName = this.getAttribute('data-course');
            alert('Navigating to course: ' + courseName);
        });
    });

    // Simple form submission
    const assignmentForm = document.getElementById('assignment-form');
    if (assignmentForm) {
        assignmentForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const title = document.getElementById('assignment-title').value;
            const dueDate = document.getElementById('due-date').value;

            if (title && dueDate) {
                alert(`Assignment "${title}" created with due date: ${dueDate}`);
                this.reset();
            } else {
                alert('Please fill out all required fields');
            }
        });
    }
});