<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Smart Bank</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body style="align-items: center; justify-content: center;">
    <div class="card" style="width: 100%; max-width: 400px;">
        <h2 style="text-align: center; margin-bottom: 2rem;">Smart Bank</h2>
        
        <c:if test="${not empty error}">
            <div style="color: var(--danger); margin-bottom: 1rem; text-align: center;">${error}</div>
        </c:if>
        <c:if test="${not empty param.success}">
            <div style="color: var(--success); margin-bottom: 1rem; text-align: center;">${param.success}</div>
        </c:if>

        <form action="/login" method="post">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" class="btn" style="width: 100%;">Login</button>
        </form>
        <p style="text-align: center; margin-top: 1rem;">
            Don't have an account? <a href="/register">Register</a>
        </p>
    </div>
</body>
</html>
