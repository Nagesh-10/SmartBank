<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Transfer Funds - Smart Bank</title>
        <link rel="stylesheet" href="/css/style.css">
    </head>

    <body>
        <nav class="navbar">
            <div style="font-weight: bold; font-size: 1.25rem;">Smart Bank</div>
            <div class="nav-links">
                <a href="/dashboard">Dashboard</a>
                <a href="/transfer" style="color: var(--primary);">Transfer Funds</a>
                <a href="/loans">Loans</a>
                <a href="/logout">Logout</a>
            </div>
        </nav>

        <div class="container">
            <h1>Transfer Funds</h1>

            <div class="card" style="max-width: 600px;">
                <c:if test="${not empty error}">
                    <div
                        style="background: var(--danger); color: white; padding: 1rem; border-radius: 8px; margin-bottom: 2rem;">
                        ${error}
                    </div>
                </c:if>

                <form action="/transfer" method="post">
                    <div class="form-group">
                        <label>Recipient Account Number or UPI ID</label>
                        <input type="text" name="recipientIdentifier"
                            placeholder="Enter Account Number or UPI ID (e.g. 12345@smartbank)" required>
                    </div>
                    <div class="form-group">
                        <label>Amount</label>
                        <input type="number" name="amount" min="1" step="0.01" required>
                    </div>
                    <button type="submit" class="btn">Transfer Money</button>
                </form>
            </div>
        </div>
    </body>

    </html>