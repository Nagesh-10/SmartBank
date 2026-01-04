<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Verify OTP - Smart Bank</title>
        <link rel="stylesheet" href="/css/style.css">
    </head>

    <body style="align-items: center; justify-content: center;">
        <div class="card" style="width: 100%; max-width: 400px; text-align: center;">
            <h2 style="margin-bottom: 1rem;">Verify Your Email</h2>
            <p style="margin-bottom: 2rem; color: #666;">
                We have sent a verification code to your email.<br>
                (Check the server console for the simulated code)
            </p>

            <c:if test="${not empty error}">
                <div style="color: var(--danger); margin-bottom: 1rem;">${error}</div>
            </c:if>

            <form action="/verify-otp" method="post">
                <input type="hidden" name="email" value="${email}">
                <div class="form-group">
                    <input type="text" name="otp" placeholder="Enter 6-digit OTP"
                        style="text-align: center; letter-spacing: 5px; font-size: 1.2rem;" required>
                </div>
                <button type="submit" class="btn" style="width: 100%;">Verify</button>
            </form>
        </div>
    </body>

    </html>