<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        .error-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ff6b6b;
            border-radius: 5px;
            background-color: #fff5f5;
        }
        .error-title {
            color: #ff6b6b;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1 class="error-title">An Error Occurred</h1>
        <p>We're sorry, but something went wrong while processing your request.</p>

        <% if (exception != null) { %>
            <h3>Error Details:</h3>
            <p><%= exception.getMessage() %></p>
            <pre>
                <% exception.printStackTrace(new java.io.PrintWriter(out)); %>
            </pre>
        <% } %>

        <p>Please try again later or contact support if the problem persists.</p>
        <a href="login.jsp">Return to Login Page</a>
    </div>
</body>
</html>