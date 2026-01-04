<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Register - Smart Bank</title>
        <link rel="stylesheet" href="/css/style.css">
    </head>

    <body style="align-items: center; justify-content: center;">
        <div class="card" style="width: 100%; max-width: 500px;">
            <h2 style="text-align: center; margin-bottom: 2rem;">Create Account</h2>

            <c:if test="${not empty error}">
                <div style="color: var(--danger); margin-bottom: 1rem; text-align: center;">${error}</div>
            </c:if>

            <form action="/register" method="post">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" name="phoneNumber" required>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" required>
                </div>
                <button type="submit" class="btn" style="width: 100%;">Register</button>
            </form>
            <p style="text-align: center; margin-top: 1rem;">
                Already have an account? <a href="/login">Login</a>
            </p>
        </div>
    </body>

    </html>