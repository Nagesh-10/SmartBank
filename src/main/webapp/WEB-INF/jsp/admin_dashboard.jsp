<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Admin Dashboard - Smart Bank</title>
            <link rel="stylesheet" href="/css/style.css">
        </head>

        <body>
            <nav class="navbar">
                <div style="font-weight: bold; font-size: 1.25rem;">Smart Bank Admin</div>
                <div class="nav-links">
                    <a href="/admin/dashboard" style="color: var(--primary);">Dashboard</a>
                    <a href="/logout">Logout</a>
                </div>
            </nav>

            <div class="container">
                <h1>Admin Dashboard</h1>

                <div class="card">
                    <h2>Customer Accounts</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Account Number</th>
                                <th>Balance</th>
                                <th>Email</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${allAccounts}" var="acc">
                                <tr>
                                    <td>${acc.user.id}</td>
                                    <td>${acc.user.fullName}</td>
                                    <td>${acc.accountNumber}</td>
                                    <td>
                                        <fmt:formatNumber value="${acc.balance}" type="currency" currencySymbol="$" />
                                    </td>
                                    <td>${acc.user.email}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="card">
                    <h2>Pending Loan Requests</h2>
                    <c:if test="${empty pendingLoans}">
                        <p>No pending loan requests.</p>
                    </c:if>
                    <c:if test="${not empty pendingLoans}">
                        <table>
                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Date</th>
                                    <th>Purpose</th>
                                    <th>Amount</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pendingLoans}" var="l">
                                    <tr>
                                        <td>${l.user.fullName}</td>
                                        <td>${l.applicationDate}</td>
                                        <td>${l.purpose}</td>
                                        <td>
                                            <fmt:formatNumber value="${l.amount}" type="currency" currencySymbol="$" />
                                        </td>
                                        <td>
                                            <form action="/admin/loans/update" method="post" style="display:inline;">
                                                <input type="hidden" name="loanId" value="${l.id}">
                                                <button type="submit" name="status" value="APPROVED" class="btn"
                                                    style="padding: 0.25rem 0.5rem; font-size: 0.8rem; background-color: var(--success);">Approve</button>
                                                <button type="submit" name="status" value="REJECTED"
                                                    class="btn btn-danger"
                                                    style="padding: 0.25rem 0.5rem; font-size: 0.8rem;">Reject</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>

                <div class="card">
                    <h2>Transaction Monitoring (Fraud Detection)</h2>
                    <c:if test="${empty allTransactions}">
                        <p>No transactions found.</p>
                    </c:if>
                    <c:if test="${not empty allTransactions}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Time</th>
                                    <th>Source</th>
                                    <th>Dest</th>
                                    <th>Amount</th>
                                    <th>Type</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${allTransactions}" var="t">
                                    <tr style="${t.amount >= 10000 ? 'background-color: #fee2e2;' : ''}">
                                        <td>
                                            <fmt:formatDate value="${t.utilDate}" pattern="MMM dd, HH:mm" />
                                        </td>
                                        <td>${t.sourceAccountNumber}</td>
                                        <td>${t.destinationAccountNumber}</td>
                                        <td>
                                            <fmt:formatNumber value="${t.amount}" type="currency" currencySymbol="$" />
                                        </td>
                                        <td>${t.type}</td>
                                        <td>
                                            <c:if test="${t.amount >= 10000}">
                                                <span class="status-badge status-rejected">High Value (Fraud
                                                    Check)</span>
                                            </c:if>
                                            <c:if test="${t.amount < 10000}">
                                                <span class="status-badge status-approved">Normal</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>

                <div class="card">
                    <h2>All Loans History</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User</th>
                                <th>Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${allLoans}" var="l">
                                <tr>
                                    <td>${l.id}</td>
                                    <td>${l.user.fullName}</td>
                                    <td>
                                        <fmt:formatNumber value="${l.amount}" type="currency" currencySymbol="$" />
                                    </td>
                                    <td><span
                                            class="status-badge status-${l.status.toString().toLowerCase()}">${l.status}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </body>

        </html>