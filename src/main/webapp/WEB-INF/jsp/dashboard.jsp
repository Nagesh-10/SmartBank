<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Dashboard - Smart Bank</title>
            <link rel="stylesheet" href="/css/style.css">
        </head>

        <body>
            <nav class="navbar">
                <div style="font-weight: bold; font-size: 1.25rem;">Smart Bank</div>
                <div class="nav-links">
                    <a href="/dashboard" style="color: var(--primary);">Dashboard</a>
                    <a href="/transfer">Transfer Funds</a>
                    <a href="/loans">Loans</a>
                    <a href="/savings">Savings</a>
                    <a href="/logout">Logout</a>
                </div>
            </nav>

            <div class="container">
                <h1>Welcome, ${user.fullName}</h1>

                <c:if test="${not empty param.success}">
                    <div
                        style="background: var(--success); color: white; padding: 1rem; border-radius: 8px; margin-bottom: 2rem;">
                        ${param.success}
                    </div>
                </c:if>

                <div class="card">
                    <h2>Account Summary</h2>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 1rem;">
                        <div>
                            <label>Account Number</label>
                            <div style="font-size: 1.5rem; font-weight: bold;">${account.accountNumber}</div>
                        </div>
                        <div>
                            <label>Available Balance</label>
                            <div style="font-size: 1.5rem; font-weight: bold; color: var(--success);">
                                <fmt:formatNumber value="${account.balance}" type="currency" currencySymbol="$" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <h2>Recent Transactions</h2>
                    <c:if test="${empty recentTransactions}">
                        <p>No recent transactions.</p>
                    </c:if>
                    <c:if test="${not empty recentTransactions}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Description</th>
                                    <th>Type</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentTransactions}" var="t">
                                    <tr>
                                        <td>
                                            <fmt:formatDate value="${t.utilDate}" pattern="MMM dd, yyyy HH:mm" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${t.type == 'TRANSFER_OUT'}">
                                                    Transfer to ${t.destinationAccountNumber}
                                                </c:when>
                                                <c:when test="${t.type == 'TRANSFER_IN'}">
                                                    Received from ${t.sourceAccountNumber}
                                                </c:when>
                                                <c:otherwise>${t.type}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${t.type}</td>
                                        <td
                                            style="font-weight: bold; color: ${t.type == 'TRANSFER_OUT' || t.type == 'WITHDRAWAL' ? 'var(--danger)' : 'var(--success)'}">
                                            <fmt:formatNumber value="${t.amount}" type="currency" currencySymbol="$" />
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