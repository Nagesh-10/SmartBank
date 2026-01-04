<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Savings Goals - Smart Bank</title>
            <link rel="stylesheet" href="/css/style.css">
        </head>

        <body>
            <nav class="navbar">
                <div style="font-weight: bold; font-size: 1.25rem;">Smart Bank</div>
                <div class="nav-links">
                    <a href="/dashboard">Dashboard</a>
                    <a href="/transfer">Transfer Funds</a>
                    <a href="/loans">Loans</a>
                    <a href="/savings" style="color: var(--primary);">Savings</a> <!-- Added link -->
                    <a href="/logout">Logout</a>
                </div>
            </nav>

            <div class="container">
                <h1>Savings Goals</h1>

                <c:if test="${not empty param.success}">
                    <div
                        style="background: var(--success); color: white; padding: 1rem; border-radius: 8px; margin-bottom: 2rem;">
                        ${param.success}
                    </div>
                </c:if>

                <div class="card">
                    <h2>Create New Goal</h2>
                    <form action="/savings/add" method="post"
                        style="display: grid; grid-template-columns: 1fr 1fr auto; gap: 1rem; align-items: end;">
                        <div class="form-group" style="margin-bottom: 0;">
                            <label>Goal Name</label>
                            <input type="text" name="goalName" placeholder="e.g. New Car" required>
                        </div>
                        <div class="form-group" style="margin-bottom: 0;">
                            <label>Target Amount</label>
                            <input type="number" name="targetAmount" min="100" required>
                        </div>
                        <button type="submit" class="btn">Add Goal</button>
                    </form>
                </div>

                <div class="card">
                    <h2>My Goals</h2>
                    <c:if test="${empty goals}">
                        <p>You haven't set any savings goals yet.</p>
                    </c:if>
                    <c:if test="${not empty goals}">
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 1.5rem;">
                            <c:forEach items="${goals}" var="g">
                                <div style="border: 1px solid #e5e7eb; padding: 1.5rem; border-radius: 8px;">
                                    <h3 style="margin-top: 0;">${g.goalName}</h3>
                                    <div style="color: var(--text-muted); margin-bottom: 0.5rem;">Target</div>
                                    <div style="font-size: 1.25rem; font-weight: bold; margin-bottom: 1rem;">
                                        <fmt:formatNumber value="${g.targetAmount}" type="currency"
                                            currencySymbol="$" />
                                    </div>
                                    <div
                                        style="background: #e5e7eb; height: 8px; border-radius: 4px; overflow: hidden;">
                                        <c:set var="percent" value="${(g.savedAmount / g.targetAmount) * 100}" />
                                        <div style="width: ${percent}%; background: var(--success); height: 100%;">
                                        </div>
                                    </div>
                                    <div
                                        style="text-align: right; font-size: 0.875rem; margin-top: 0.5rem; color: var(--text-muted);">
                                        Saved:
                                        <fmt:formatNumber value="${g.savedAmount}" type="currency" currencySymbol="$" />
                                        (${String.format("%.0f", percent)}%)
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </body>

        </html>