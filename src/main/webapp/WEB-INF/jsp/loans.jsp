<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>My Loans - Smart Bank</title>
            <link rel="stylesheet" href="/css/style.css">
        </head>

        <body>
            <nav class="navbar">
                <div style="font-weight: bold; font-size: 1.25rem;">Smart Bank</div>
                <div class="nav-links">
                    <a href="/dashboard">Dashboard</a>
                    <a href="/transfer">Transfer Funds</a>
                    <a href="/loans" style="color: var(--primary);">Loans</a>
                    <a href="/logout">Logout</a>
                </div>
            </nav>

            <div class="container">
                <h1>Loan Management</h1>

                <c:if test="${not empty param.success}">
                    <div
                        style="background: var(--success); color: white; padding: 1rem; border-radius: 8px; margin-bottom: 2rem;">
                        ${param.success}
                    </div>
                </c:if>

                <div class="card">
                    <h2>Apply for a Loan</h2>
                    <form action="/loans/apply" method="post"
                        style="display: grid; grid-template-columns: 1fr 1fr auto; gap: 1rem; align-items: end;">
                        <div class="form-group" style="margin-bottom: 0;">
                            <label>Amount</label>
                            <input type="number" name="amount" min="100" required>
                        </div>
                        <div class="form-group" style="margin-bottom: 0;">
                            <label>Purpose</label>
                            <input type="text" name="purpose" placeholder="e.g. Home Renovation" required>
                        </div>
                        <button type="submit" class="btn">Apply Now</button>
                    </form>
                </div>

                <div class="card">
                    <h2>My Loan Applications</h2>
                    <c:if test="${empty loans}">
                        <p>You haven't applied for any loans yet.</p>
                    </c:if>
                    <c:if test="${not empty loans}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Date Applied</th>
                                    <th>Purpose</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${loans}" var="l">
                                    <tr>
                                        <td>${l.applicationDate}</td>
                                        <td>${l.purpose}</td>
                                        <td>
                                            <fmt:formatNumber value="${l.amount}" type="currency" currencySymbol="$" />
                                        </td>
                                        <td>
                                            <span class="status-badge status-${l.status.toString().toLowerCase()}">
                                                ${l.status}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>
        </body>

        </html>