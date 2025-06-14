// Sample data - in a real app, this would come from API calls
let courses = [
    { id: 1, name: "Introduction to Programming", code: "CS101", instructor: "Dr. Smith", students: 45, status: "Active" },
    { id: 2, name: "Database Systems", code: "CS202", instructor: "Prof. Johnson", students: 32, status: "Active" },
    { id: 3, name: "Web Development", code: "CS303", instructor: "Dr. Williams", students: 28, status: "Active" },
    { id: 4, name: "Data Structures", code: "CS104", instructor: "Prof. Brown", students: 0, status: "Inactive" }
];

let users = {
    students: [
        { id: 1, name: "John Doe", email: "john@example.com", courses: 3, status: "Active" },
        { id: 2, name: "Jane Smith", email: "jane@example.com", courses: 2, status: "Active" },
        { id: 3, name: "Mike Johnson", email: "mike@example.com", courses: 1, status: "Inactive" }
    ],
    faculty: [
        { id: 1, name: "Dr. Smith", email: "smith@example.com", courses: 2, status: "Active" },
        { id: 2, name: "Prof. Johnson", email: "johnson@example.com", courses: 1, status: "Active" }
    ],
    admins: [
        { id: 1, name: "Admin User", email: "admin@example.com", lastLogin: "2023-06-10", status: "Active" }
    ]
};

let instructors = [
    { id: 1, name: "Dr. Smith" },
    { id: 2, name: "Prof. Johnson" },
    { id: 3, name: "Dr. Williams" },
    { id: 4, name: "Prof. Brown" }
];

// DOM Ready
document.addEventListener('DOMContentLoaded', function() {
    // Initialize dashboard
    updateQuickStats();
    populateCoursesTable();
    populateUsersTables();
    populateInstructorDropdown();

    // Form submissions
    document.getElementById('add-course-form').addEventListener('submit', handleAddCourse);
    document.getElementById('add-user-form').addEventListener('submit', handleAddUser);
});

// Update quick stats cards
function updateQuickStats() {
    document.getElementById('course-count').textContent = courses.length;
    document.getElementById('student-count').textContent = users.students.length;
    document.getElementById('faculty-count').textContent = users.faculty.length;
    document.getElementById('active-courses').textContent = courses.filter(c => c.status === 'Active').length;
}

// Populate courses table
function populateCoursesTable() {
    const tableBody = document.querySelector('#courses-table tbody');
    tableBody.innerHTML = '';

    courses.forEach(course => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${course.code}</td>
            <td>${course.name}</td>
            <td>${course.instructor}</td>
            <td>${course.students}</td>
            <td><span class="status-badge ${course.status.toLowerCase()}">${course.status}</span></td>
            <td>
                <button class="btn-sm btn-edit" onclick="editCourse(${course.id})"><i class="fas fa-edit"></i></button>
                <button class="btn-sm btn-delete" onclick="deleteCourse(${course.id})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });
}

// Populate users tables
function populateUsersTables() {
    populateUserTable('students', users.students);
    populateUserTable('faculty', users.faculty);
    populateUserTable('admins', users.admins);
}

function populateUserTable(type, userList) {
    const tableBody = document.querySelector(`#${type}-tab tbody`);
    if (!tableBody) return;

    tableBody.innerHTML = '';

    userList.forEach(user => {
        const row = document.createElement('tr');

        let extraColumns = '';
        if (type === 'admins') {
            extraColumns = `<td>${user.lastLogin}</td>`;
        } else {
            extraColumns = `<td>${user.courses}</td>`;
        }

        row.innerHTML = `
            <td>${user.id}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
            ${extraColumns}
            <td><span class="status-badge ${user.status.toLowerCase()}">${user.status}</span></td>
            <td>
                <button class="btn-sm btn-edit" onclick="editUser('${type}', ${user.id})"><i class="fas fa-edit"></i></button>
                <button class="btn-sm btn-delete" onclick="deleteUser('${type}', ${user.id})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });
}

// Populate instructor dropdown
function populateInstructorDropdown() {
    const dropdown = document.getElementById('course-instructor');
    dropdown.innerHTML = '<option value="">Select Instructor</option>';

    instructors.forEach(instructor => {
        const option = document.createElement('option');
        option.value = instructor.id;
        option.textContent = instructor.name;
        dropdown.appendChild(option);
    });
}

// Modal functions
function showAddCourseModal() {
    document.getElementById('add-course-modal').style.display = 'block';
    document.getElementById('course-name').focus();
}

function showAddUserModal() {
    document.getElementById('add-user-modal').style.display = 'block';
    document.getElementById('user-role').focus();
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// Tab functions
function openTab(evt, tabName) {
    const tabContents = document.getElementsByClassName('tab-content');
    for (let i = 0; i < tabContents.length; i++) {
        tabContents[i].style.display = 'none';
    }

    const tabButtons = document.getElementsByClassName('tab-btn');
    for (let i = 0; i < tabButtons.length; i++) {
        tabButtons[i].className = tabButtons[i].className.replace(' active', '');
    }

    document.getElementById(tabName).style.display = 'block';
    evt.currentTarget.className += ' active';
}

// Toggle user fields based on role
function toggleUserFields() {
    const role = document.getElementById('user-role').value;
    document.getElementById('student-fields').style.display = role === 'student' ? 'block' : 'none';
    document.getElementById('faculty-fields').style.display = role === 'faculty' ? 'block' : 'none';
}

// Form handlers
function handleAddCourse(e) {
    e.preventDefault();

    const name = document.getElementById('course-name').value;
    const code = document.getElementById('course-code').value;
    const description = document.getElementById('course-description').value;
    const instructorId = document.getElementById('course-instructor').value;
    const startDate = document.getElementById('course-start-date').value;

    const instructor = instructors.find(i => i.id == instructorId);

    // Add new course (in a real app, this would be an API call)
    const newCourse = {
        id: courses.length + 1,
        name: name,
        code: code,
        description: description,
        instructor: instructor ? instructor.name : '',
        students: 0,
        status: "Active"
    };

    courses.push(newCourse);

    // Update UI
    populateCoursesTable();
    updateQuickStats();
    closeModal('add-course-modal');
    document.getElementById('add-course-form').reset();

    // Show success message
    alert('Course added successfully!');
}

function handleAddUser(e) {
    e.preventDefault();

    const role = document.getElementById('user-role').value;
    const name = document.getElementById('user-name').value;
    const email = document.getElementById('user-email').value;
    const username = document.getElementById('user-username').value;
    const password = document.getElementById('user-password').value;

    // Add new user (in a real app, this would be an API call)
    const newUser = {
        id: users[role + 's'].length + 1,
        name: name,
        email: email,
        status: "Active"
    };

    if (role === 'student') {
        newUser.studentId = document.getElementById('student-id').value;
        newUser.courses = 0;
    } else if (role === 'faculty') {
        newUser.department = document.getElementById('faculty-department').value;
        newUser.courses = 0;
    } else if (role === 'admin') {
        newUser.lastLogin = new Date().toISOString().split('T')[0];
    }

    users[role + 's'].push(newUser);

    // Update UI
    populateUsersTables();
    updateQuickStats();
    closeModal('add-user-modal');
    document.getElementById('add-user-form').reset();

    // Show success message
    alert(`${role.charAt(0).toUpperCase() + role.slice(1)} added successfully!`);
}

// CRUD operations
function editCourse(id) {
    const course = courses.find(c => c.id === id);
    if (!course) return;

    // In a real app, we'd show an edit modal
    alert(`Editing course: ${course.name}\nThis would open an edit form in a real application.`);
}

function deleteCourse(id) {
    if (confirm('Are you sure you want to delete this course?')) {
        courses = courses.filter(c => c.id !== id);
        populateCoursesTable();
        updateQuickStats();
        alert('Course deleted successfully!');
    }
}

function editUser(type, id) {
    const userList = users[type];
    const user = userList.find(u => u.id === id);
    if (!user) return;

    // In a real app, we'd show an edit modal
    alert(`Editing user: ${user.name}\nThis would open an edit form in a real application.`);
}

function deleteUser(type, id) {
    if (confirm('Are you sure you want to delete this user?')) {
        users[type] = users[type].filter(u => u.id !== id);
        populateUsersTables();
        updateQuickStats();
        alert('User deleted successfully!');
    }
}