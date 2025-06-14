<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        // Check for remember me cookie on page load
        window.onload = function() {
            const cookies = document.cookie.split(';');
            for (let cookie of cookies) {
                const [name, value] = cookie.trim().split('=');
                if (name === 'rememberUsername') {
                    document.getElementById('username').value = decodeURIComponent(value);
                    document.getElementById('remember').checked = true;
                    break;
                }
            }
        };
    </script>
</head>
<body>
    <div class="login-container">
        <h1>Employee Portal Login</h1>
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Invalid username or password!</div>
        <% } %>
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group remember">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Remember username</label>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>