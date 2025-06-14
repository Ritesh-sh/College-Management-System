<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.DynamicVariable" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Variable Management</title>
    <link rel="stylesheet" href="../css/style.css">
    <link id="theme-style" rel="stylesheet" href="../css/<%= request.getAttribute("theme") != null ?
            ((DynamicVariable)request.getAttribute("theme")).getStringValue() : "light" %>.css">
</head>
<body>
    <div class="admin-dashboard">
        <header class="dashboard-header">
            <!-- Header content same as before -->
        </header>

        <main class="dashboard-content">
            <div class="content-header">
                <h1><i class="fas fa-code"></i> Dynamic Variable Management</h1>
            </div>

            <!-- Variable Creation Form -->
            <section class="content-section">
                <div class="section-header">
                    <h2><i class="fas fa-plus-circle"></i> Create New Variable</h2>
                </div>
                <div class="section-content">
                    <form action="variables" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="form-group">
                            <label for="var-name">Variable Name</label>
                            <input type="text" id="var-name" name="name" required>
                        </div>
                        <div class="form-group">
                            <label for="var-type">Type</label>
                            <select id="var-type" name="type" required>
                                <option value="STRING">String</option>
                                <option value="INTEGER">Integer</option>
                                <option value="BOOLEAN">Boolean</option>
                                <option value="DOUBLE">Double</option>
                                <option value="OBJECT">Object</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="var-value">Value</label>
                            <input type="text" id="var-value" name="value" required>
                        </div>
                        <div class="form-group">
                            <label for="var-scope">Scope</label>
                            <select id="var-scope" name="scope" required>
                                <option value="application">Application</option>
                                <option value="session">Session</option>
                                <option value="request">Request</option>
                            </select>
                        </div>
                        <button type="submit" class="btn-primary">Create Variable</button>
                    </form>
                </div>
            </section>

            <!-- Current Variables -->
            <section class="content-section">
                <div class="section-header">
                    <h2><i class="fas fa-list"></i> Current Variables</h2>
                </div>
                <div class="section-content">
                    <div class="tabs">
                        <button class="tab-btn active" onclick="openTab(event, 'app-vars')">Application</button>
                        <button class="tab-btn" onclick="openTab(event, 'session-vars')">Session</button>
                        <button class="tab-btn" onclick="openTab(event, 'request-vars')">Request</button>
                    </div>

                    <div id="app-vars" class="tab-content" style="display: block;">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Type</th>
                                    <th>Value</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% Map<String, DynamicVariable> appVars = (Map<String, DynamicVariable>)
                                        request.getServletContext().getAttribute("applicationVariables");
                                   if (appVars != null) {
                                       for (Map.Entry<String, DynamicVariable> entry : appVars.entrySet()) { %>
                                        <tr>
                                            <td><%= entry.getKey() %></td>
                                            <td><%= entry.getValue().getType() %></td>
                                            <td><%= entry.getValue().getStringValue() %></td>
                                            <td>
                                                <button class="btn-sm btn-edit" onclick="editVariable('application', '<%= entry.getKey() %>')">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <form action="variables" method="post" style="display: inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="name" value="<%= entry.getKey() %>">
                                                    <input type="hidden" name="scope" value="application">
                                                    <button type="submit" class="btn-sm btn-delete">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                <%   }
                                   } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Similar tables for session and request variables -->
                </div>
            </section>
        </main>
    </div>
</body>
</html>