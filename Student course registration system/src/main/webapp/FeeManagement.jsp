<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 4/19/2025
  Time: 6:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Fee Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #4facfe;
            --accent-color: #ff4d7e;
            --dark-color: #0a0f24;
            --darker-color: #050916;
            --text-color: #ffffff;
            --text-muted: rgba(255,255,255,0.7);
            --glow-color: rgba(0,242,254,0.6);
            --card-bg: rgba(15,23,42,0.95);
            --border-radius: 12px;
            --border-radius-sm: 8px;
            --box-shadow: 0 8px 30px rgba(0,0,0,0.3);
            --box-shadow-hover: 0 12px 40px rgba(0,242,254,0.3);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            --success-color: #00ff88;
            --warning-color: #ffcc00;
            --error-color: #ff4d7e;
            --modal-bg: rgba(10,15,36,0.98);
            --input-focus-glow: 0 0 0 3px rgba(0, 242, 254, 0.3);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(ellipse at bottom, var(--darker-color) 0%, var(--dark-color) 100%);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            padding: 20px;
            line-height: 1.6;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            inset: 0;
            background:
                    radial-gradient(circle at 20% 30%, rgba(0,242,254,0.15) 0%, transparent 25%),
                    radial-gradient(circle at 80% 70%, rgba(79,172,254,0.15) 0%, transparent 25%);
            opacity: 0.4;
            z-index: -1;
            pointer-events: none;
        }

        h1, h2, h3 {
            font-family: 'Orbitron', sans-serif;
            font-weight: 600;
            letter-spacing: 1px;
            margin-bottom: 1.5rem;
        }

        .application-container {
            width: 100%;
            max-width: 1200px;
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border-radius: var(--border-radius);
            border: 1px solid rgba(0,242,254,0.25);
            box-shadow: var(--box-shadow);
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        .application-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                    to bottom right,
                    transparent 0%,
                    transparent 50%,
                    rgba(0, 242, 254, 0.05) 50%,
                    rgba(0, 242, 254, 0.05) 100%
            );
            transform: rotate(30deg);
            pointer-events: none;
            z-index: -1;
        }

        .hud-header {
            font-size: 2.2rem;
            margin-bottom: 1.5rem;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
            display: inline-block;
            padding-bottom: 0.5rem;
        }

        .hud-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60%;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), transparent);
            border-radius: 2px;
        }

        .hud-header i {
            margin-right: 0.8rem;
            font-size: 1.8rem;
        }

        .input-holofield {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .input-holofield label {
            display: block;
            margin-bottom: 0.5rem;
            font-family: 'Orbitron', sans-serif;
            color: var(--primary-color);
            font-size: 1rem;
            font-weight: 500;
        }

        .input-holofield label i {
            margin-right: 0.5rem;
            width: 1.2rem;
            text-align: center;
        }

        .holo-input {
            width: 100%;
            padding: 0.9rem 1.2rem;
            background: rgba(10,15,36,0.7);
            border: 2px solid rgba(0,242,254,0.3);
            border-radius: var(--border-radius-sm);
            color: var(--text-color);
            font-size: 1rem;
            transition: var(--transition);
            font-family: 'Poppins', sans-serif;
        }

        .holo-input:focus {
            border-color: var(--primary-color);
            box-shadow: var(--input-focus-glow);
            outline: none;
        }

        .holo-input::placeholder {
            color: var(--text-muted);
            opacity: 0.7;
        }

        .input-error {
            color: var(--error-color);
            font-size: 0.85rem;
            margin-top: 0.5rem;
            display: none;
            padding-left: 0.5rem;
        }

        .tooltip {
            position: relative;
        }

        .tooltip::after {
            content: attr(data-tooltip);
            position: absolute;
            top: calc(100% + 5px);
            left: 0;
            background: rgba(0,0,0,0.8);
            color: var(--text-color);
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius-sm);
            font-size: 0.85rem;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: var(--transition);
            z-index: 10;
            pointer-events: none;
            font-family: 'Poppins', sans-serif;
            border: 1px solid rgba(0,242,254,0.2);
        }

        .tooltip:hover::after {
            opacity: 1;
            visibility: visible;
            transform: translateY(5px);
        }

        .price-display {
            background: linear-gradient(135deg, rgba(0,242,254,0.1), rgba(79,172,254,0.1));
            padding: 1.5rem;
            border-radius: var(--border-radius);
            border: 1px solid var(--primary-color);
            margin: 2rem 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .price-line {
            display: flex;
            justify-content: space-between;
            padding: 0.8rem 0;
            border-bottom: 1px solid rgba(0,242,254,0.2);
            font-size: 1rem;
        }

        .price-line.total {
            font-weight: 600;
            color: var(--primary-color);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 1rem;
            margin-top: 1.5rem;
            font-size: 1.1rem;
        }

        .submit-button {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: var(--border-radius-sm);
            color: var(--dark-color);
            font-family: 'Orbitron', sans-serif;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.8rem;
            touch-action: manipulation;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .submit-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            opacity: 0;
            transition: var(--transition);
            z-index: -1;
        }

        .submit-button:hover {
            transform: translateY(-3px);
            box-shadow: var(--box-shadow-hover);
        }

        .submit-button:hover::before {
            opacity: 1;
        }

        .submit-button i {
            font-size: 1.1rem;
        }

        .submit-button.secondary {
            background: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }

        .submit-button.secondary:hover {
            background: rgba(0,242,254,0.1);
            color: var(--text-color);
        }

        .submit-button.void-invoice-button {
            background: linear-gradient(135deg, var(--error-color), #ff2d5e);
        }

        .submit-button.cancel-payment-button {
            background: linear-gradient(135deg, var(--warning-color), #ffb700);
        }

        .tab-container {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            border-bottom: 1px solid rgba(0,242,254,0.1);
            padding-bottom: 1rem;
        }

        .tab-label {
            font-family: 'Orbitron', sans-serif;
            font-size: 1rem;
            color: var(--text-muted);
            cursor: pointer;
            padding: 0.8rem 1.5rem;
            border-radius: 30px;
            background: none;
            border: none;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.7rem;
            position: relative;
        }

        .tab-label i {
            font-size: 1.1rem;
        }

        .tab-label:hover {
            color: var(--text-color);
            background: rgba(0,242,254,0.1);
        }

        .tab-label.active {
            color: var(--primary-color);
            background: rgba(0,242,254,0.2);
            box-shadow: 0 0 15px rgba(0,242,254,0.1);
        }

        .tab-label.active::after {
            content: '';
            position: absolute;
            bottom: -1.1rem;
            left: 50%;
            transform: translateX(-50%);
            width: 60%;
            height: 3px;
            background: var(--primary-color);
            border-radius: 2px;
        }

        .tab-section {
            display: none;
            animation: fadeInUp 0.4s ease-out;
        }

        .tab-section.active {
            display: block;
        }

        .payment-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin: 1.5rem 0;
            border-radius: var(--border-radius-sm);
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .payment-table th {
            background: linear-gradient(to right, rgba(0,242,254,0.2), rgba(79,172,254,0.2));
            color: var(--primary-color);
            font-family: 'Orbitron', sans-serif;
            padding: 1rem;
            text-align: left;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .payment-table td {
            padding: 1rem;
            border-bottom: 1px solid rgba(0,242,254,0.1);
            background: rgba(10,15,36,0.6);
            font-size: 0.95rem;
            transition: var(--transition);
        }

        .payment-table tr:last-child td {
            border-bottom: none;
        }

        .payment-table tr:hover td {
            background: rgba(0,242,254,0.15);
            transform: translateX(5px);
        }

        .status-paid { color: var(--success-color); }
        .status-pending { color: var(--warning-color); }
        .status-overdue { color: var(--error-color); }
        .status-canceled { color: var(--accent-color); }

        .notification {
            padding: 1rem;
            border-radius: var(--border-radius-sm);
            margin: 1.5rem 0;
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: slideIn 0.4s ease-out;
            border-left: 4px solid transparent;
            background: rgba(255,255,255,0.05);
        }

        .notification i {
            font-size: 1.3rem;
        }

        .notification.success {
            background: rgba(0,255,136,0.1);
            border-left-color: var(--success-color);
        }

        .notification.error {
            background: rgba(255,77,126,0.1);
            border-left-color: var(--error-color);
        }

        .notification.warning {
            background: rgba(255,204,0,0.1);
            border-left-color: var(--warning-color);
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1rem;
            margin: 1.5rem 0;
        }

        .pagination button {
            padding: 0.7rem 1.2rem;
            min-width: 100px;
        }

        .pagination span {
            font-size: 0.95rem;
            color: var(--text-muted);
        }

        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.8);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(5px);
            animation: fadeIn 0.3s ease-out;
        }

        .modal-content {
            background: var(--modal-bg);
            padding: 2rem;
            border-radius: var(--border-radius);
            width: 90%;
            max-width: 500px;
            border: 1px solid var(--primary-color);
            box-shadow: var(--box-shadow);
            animation: scaleIn 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
        }

        .modal-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
        }

        .modal-content h3 {
            margin-bottom: 1.5rem;
            color: var(--primary-color);
        }

        .modal-content p {
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .modal-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .modal-actions button {
            flex: 1;
        }

        .countdown-timer {
            color: var(--warning-color);
            font-weight: 600;
            font-family: 'Orbitron', sans-serif;
        }

        .countdown-timer.warning {
            color: var(--error-color);
            animation: pulse 1s infinite;
        }

        .countdown-expired {
            color: var(--error-color);
            font-weight: 600;
            opacity: 0.7;
        }

        .loading-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.7);
            z-index: 2000;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(5px);
        }

        .loading-spinner {
            border: 4px solid rgba(255,255,255,0.1);
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            position: relative;
        }

        .loading-spinner::after {
            content: '';
            position: absolute;
            top: -4px;
            left: -4px;
            right: -4px;
            bottom: -4px;
            border: 4px solid transparent;
            border-top-color: var(--secondary-color);
            border-radius: 50%;
            animation: spin 1.5s linear infinite;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        @keyframes scaleIn {
            from { transform: scale(0.9); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .application-container { padding: 1.5rem; }
            .hud-header { font-size: 1.8rem; }
        }

        @media (max-width: 768px) {
            body { padding: 1rem; }
            .application-container { padding: 1.2rem; }
            .tab-container {
                flex-direction: row;
                overflow-x: auto;
                padding-bottom: 0.5rem;
                justify-content: flex-start;
                scrollbar-width: none;
            }
            .tab-container::-webkit-scrollbar { display: none; }
            .tab-label {
                padding: 0.7rem 1.2rem;
                white-space: nowrap;
            }
            .tab-label.active::after {
                bottom: -0.5rem;
            }
            .payment-table { display: block; overflow-x: auto; }
            .modal-content { padding: 1.5rem; }
            .modal-actions { flex-direction: column; }
            .submit-button { padding: 0.9rem; }
        }

        @media (max-width: 480px) {
            .hud-header { font-size: 1.6rem; }
            .tab-label { padding: 0.6rem 1rem; font-size: 0.9rem; }
            .tab-label i { font-size: 1rem; }
            .modal-content { width: 95%; padding: 1.2rem; }
        }
    </style>
</head>
<body>

<div class="application-container">
    <h1 class="hud-header"><i class="fas fa-money-bill-wave"></i> Fee Management</h1>

    <%-- Notification Display --%>
    <c:if test="${not empty message}">
        <div class="notification ${notification}" aria-live="polite" role="alert">
            <i class="fas fa-${notification == 'success' ? 'check-circle' : notification == 'error' ? 'exclamation-circle' : 'exclamation-triangle'}"></i>
            <div><c:out value="${message}" /></div>
        </div>
    </c:if>

    <%-- Tab Navigation --%>
    <div class="tab-container" role="tablist">
        <button class="tab-label active" data-tab="payment-history" role="tab" aria-controls="payment-history" aria-selected="true">
            <i class="fas fa-history"></i> Payment History
        </button>
        <button class="tab-label" data-tab="apply-waiver" role="tab" aria-controls="apply-waiver" aria-selected="false">
            <i class="fas fa-hand-holding-heart"></i> Apply Waiver
        </button>
        <button class="tab-label" data-tab="void-invoice" role="tab" aria-controls="void-invoice" aria-selected="false">
            <i class="fas fa-times-circle"></i> Void Invoice
        </button>
        <button class="tab-label" data-tab="cancel-payment" role="tab" aria-controls="cancel-payment" aria-selected="false">
            <i class="fas fa-ban"></i> Cancel Payment
        </button>
    </div>

    <%-- Payment History Section --%>
    <div id="payment-history" class="tab-section active" role="tabpanel" aria-labelledby="payment-history-tab">
        <h2 class="hud-header"><i class="fas fa-history"></i> Payment History</h2>
        <form id="payment-history-form" action="ViewPaymentHistory" method="get" class="search-form">
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
            <div class="input-holofield tooltip" data-tooltip="Format: S followed by 4 digits (e.g., S1001)">
                <label for="studentId"><i class="fas fa-user-graduate"></i> Student ID</label>
                <input type="text" id="studentId" name="studentId" class="holo-input"
                       placeholder="Enter Student ID (e.g., S1001)" pattern="S[0-9]{4}" required
                       aria-required="true" value="<c:out value='${studentId}' />">
                <div class="input-error" id="studentId-error">Invalid Student ID</div>
            </div>
            <div class="input-holofield">
                <label for="startDate"><i class="fas fa-calendar-alt"></i> Start Date</label>
                <input type="date" id="startDate" name="startDate" class="holo-input" aria-describedby="date-error">
            </div>
            <div class="input-holofield">
                <label for="endDate"><i class="fas fa-calendar-alt"></i> End Date</label>
                <input type="date" id="endDate" name="endDate" class="holo-input" aria-describedby="date-error">
            </div>
            <div id="date-error" class="notification error" style="display: none;" role="alert">End date must be after start date.</div>
            <button type="submit" class="submit-button">
                <i class="fas fa-search"></i> View Payment History
            </button>
            <button type="button" id="export-csv" class="submit-button secondary" style="margin-top: 10px;">
                <i class="fas fa-file-csv"></i> Export as CSV
            </button>
        </form>
        <c:if test="${not empty paymentRecords}">
            <div class="price-display">
                <h3><i class="fas fa-receipt"></i> Payment Records for Student ID: <c:out value="${studentId}" /></h3>
                <table class="payment-table" role="grid">
                    <thead>
                    <tr>
                        <th scope="col">Payment ID</th>
                        <th scope="col">Date</th>
                        <th scope="col">Amount</th>
                        <th scope="col">Method</th>
                        <th scope="col">Status</th>
                        <th scope="col">Cancel Window</th>
                        <th scope="col">Details</th>
                    </tr>
                    </thead>
                    <tbody id="payment-records">
                    <c:forEach var="record" items="${paymentRecords}" begin="${(page - 1) * pageSize}" end="${page * pageSize - 1}">
                        <tr>
                            <td><c:out value="${record.paymentId}" /></td>
                            <td><c:out value="${record.paymentDate}" /></td>
                            <td>$<c:out value="${record.amount}" /></td>
                            <td><c:out value="${record.paymentMethod}" /></td>
                            <td class="status-${fn:toLowerCase(record.status)}"><i class="fas fa-circle"></i> <c:out value="${record.status}" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${record.status != 'CANCELED' && record.canCancel}">
                                        <span class="countdown-timer" data-timestamp="${record.timestamp}"></span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="countdown-expired">Expired</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="submit-button secondary payment-details-button" data-payment-id="${record.paymentId}" aria-label="View details for payment ${record.paymentId}">
                                    <i class="fas fa-info-circle"></i> Details
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="pagination">
                    <c:set var="totalPages" value="${(fn:length(paymentRecords) + pageSize - 1) div pageSize}"/>
                    <button class="submit-button secondary" id="prev-page" <c:if test="${page <= 1}">disabled</c:if> aria-label="Previous page">
                        <i class="fas fa-chevron-left"></i> Previous
                    </button>
                    <span>Page <c:out value="${page}"/> of <c:out value="${totalPages}"/></span>
                    <button class="submit-button secondary" id="next-page" <c:if test="${page >= totalPages}">disabled</c:if> aria-label="Next page">
                        Next <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
                <div class="price-line total">
                    <span>Total Payments:</span>
                    <span>$<c:out value="${totalPayments}" /></span>
                </div>
            </div>
        </c:if>
    </div>

    <%-- Apply Late Fee Waiver Section --%>
    <div id="apply-waiver" class="tab-section" role="tabpanel" aria-labelledby="apply-waiver-tab">
        <h2 class="hud-header"><i class="fas fa-hand-holding-heart"></i> Apply Late Fee Waiver</h2>
        <form id="waiver-form" action="ApplyLateFeeWaiver" method="post">
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
            <div class="input-holofield tooltip" data-tooltip="Format: INV-YYYY-NNN (e.g., INV-2023-001)">
                <label for="waiverInvoiceId"><i class="fas fa-file-invoice-dollar"></i> Invoice ID</label>
                <input type="text" id="waiverInvoiceId" name="invoiceId" class="holo-input"
                       placeholder="Enter Invoice ID (e.g., INV-2023-001)" pattern="INV-[0-9]{4}-[0-9]{3}" required aria-required="true">
                <div class="input-error" id="waiverInvoiceId-error">Invalid or non-existent Invoice ID</div>
            </div>
            <div class="input-holofield">
                <label for="waiverReason"><i class="fas fa-comment-alt"></i> Reason for Waiver</label>
                <select id="waiverReason" name="reason" class="holo-input" required aria-required="true">
                    <option value="">Select a reason...</option>
                    <option value="Financial Hardship">Financial Hardship</option>
                    <option value="Medical Emergency">Medical Emergency</option>
                    <option value="Administrative Error">Administrative Error</option>
                    <option value="Other">Other (please specify)</option>
                </select>
            </div>
            <div class="input-holofield" id="otherReasonContainer" style="display: none;">
                <label for="otherReason"><i class="fas fa-pen"></i> Specify Reason</label>
                <textarea id="otherReason" name="otherReason" class="holo-input"
                          placeholder="Please specify the reason for waiver..." rows="3" aria-describedby="otherReason"></textarea>
            </div>
            <button type="submit" class="submit-button">
                <i class="fas fa-check"></i> Apply Waiver
            </button>
        </form>
    </div>

    <%-- Void Invoice Section --%>
    <div id="void-invoice" class="tab-section" role="tabpanel" aria-labelledby="void-invoice-tab">
        <h2 class="hud-header"><i class="fas fa-times-circle"></i> Void Invoice</h2>
        <form id="void-form" action="VoidInvoice" method="post">
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
            <div class="input-holofield tooltip" data-tooltip="Format: INV-YYYY-NNN (e.g., INV-2023-001)">
                <label for="voidInvoiceId"><i class="fas fa-file-invoice-dollar"></i> Invoice ID</label>
                <input type="text" id="voidInvoiceId" name="invoiceId" class="holo-input"
                       placeholder="Enter Invoice ID to void (e.g., INV-2023-001)" pattern="INV-[0-9]{4}-[0-9]{3}" required aria-required="true">
                <div class="input-error" id="voidInvoiceId-error">Invalid or non-existent Invoice ID</div>
            </div>
            <div class="input-holofield">
                <label for="voidReason"><i class="fas fa-comment-alt"></i> Reason for Void</label>
                <select id="voidReason" name="reason" class="holo-input" required aria-required="true">
                    <option value="">Select a reason...</option>
                    <option value="Duplicate Payment">Duplicate Payment</option>
                    <option value="Cancelled Enrollment">Cancelled Enrollment</option>
                    <option value="Incorrect Amount">Incorrect Amount</option>
                    <option value="Other">Other (please specify)</option>
                </select>
            </div>
            <div class="input-holofield" id="voidOtherReasonContainer" style="display: none;">
                <label for="voidOtherReason"><i class="fas fa-pen"></i> Specify Reason</label>
                <textarea id="voidOtherReason" name="otherReason" class="holo-input"
                          placeholder="Please specify the reason for voiding..." rows="3" aria-describedby="voidOtherReason"></textarea>
            </div>
            <div class="notification warning" aria-live="polite" role="alert">
                <i class="fas fa-exclamation-triangle"></i>
                <div><strong>Warning:</strong> Voiding an invoice cannot be undone. Please verify the invoice ID before proceeding.</div>
            </div>
            <button type="submit" class="submit-button void-invoice-button">
                <i class="fas fa-trash"></i> Confirm Void Invoice
            </button>
        </form>
    </div>

    <%-- Cancel Payment Section --%>
    <div id="cancel-payment" class="tab-section" role="tabpanel" aria-labelledby="cancel-payment-tab">
        <h2 class="hud-header"><i class="fas fa-ban"></i> Cancel Payment</h2>
        <form id="cancel-form" action="CancelPayment" method="post">
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
            <div class="input-holofield tooltip" data-tooltip="Format: PAY-YYYY-NNN (e.g., PAY-2023-001)">
                <label for="paymentId"><i class="fas fa-file-invoice-dollar"></i> Payment ID</label>
                <input type="text" id="paymentId" name="paymentId" class="holo-input"
                       placeholder="Enter Payment ID (e.g., PAY-2023-001)" pattern="PAY-[0-9]{4}-[0-9]{3}" required aria-required="true">
                <div class="input-error" id="paymentId-error">Invalid or non-existent Payment ID</div>
            </div>
            <div class="input-holofield">
                <label for="cancelReason"><i class="fas fa-comment-alt"></i> Reason for Cancellation</label>
                <select id="cancelReason" name="reason" class="holo-input" required aria-required="true">
                    <option value="">Select a reason...</option>
                    <option value="Changed Mind">Changed Mind</option>
                    <option value="Payment Error">Payment Error</option>
                    <option value="Incorrect Amount">Incorrect Amount</option>
                    <option value="Other">Other (please specify)</option>
                </select>
            </div>
            <div class="input-holofield" id="cancelOtherReasonContainer" style="display: none;">
                <label for="cancelOtherReason"><i class="fas fa-pen"></i> Specify Reason</label>
                <textarea id="cancelOtherReason" name="otherReason" class="holo-input"
                          placeholder="Please specify the reason for cancellation..." rows="3" aria-describedby="cancelOtherReason"></textarea>
            </div>
            <div class="notification warning" aria-live="polite" role="alert">
                <i class="fas fa-exclamation-triangle"></i>
                <div><strong>Warning:</strong> Payments can only be canceled within 24 hours of processing.</div>
            </div>
            <button type="submit" class="submit-button cancel-payment-button">
                <i class="fas fa-ban"></i> Confirm Cancel Payment
            </button>
        </form>
    </div>

    <%-- Confirmation Modal for Void Invoice --%>
    <div id="confirmModal" class="modal" style="display: none;" role="dialog" aria-labelledby="confirmModalTitle" tabindex="-1">
        <div class="modal-content">
            <h3 id="confirmModalTitle"><i class="fas fa-exclamation-triangle"></i> Confirm Void Invoice</h3>
            <p>Are you sure you want to void invoice <span id="modalInvoiceId" class="text-highlight"></span>? This action cannot be undone.</p>
            <div class="modal-actions">
                <button id="cancelVoid" class="submit-button secondary" aria-label="Cancel void action">
                    <i class="fas fa-times"></i> Cancel
                </button>
                <button id="confirmVoid" class="submit-button void-invoice-button" aria-label="Confirm void action">
                    <i class="fas fa-check"></i> Confirm
                </button>
            </div>
        </div>
    </div>

    <%-- Payment Details Modal --%>
    <div id="paymentDetailsModal" class="modal" style="display: none;" role="dialog" aria-labelledby="paymentDetailsTitle" tabindex="-1">
        <div class="modal-content">
            <h3 id="paymentDetailsTitle"><i class="fas fa-info-circle"></i> Payment Details</h3>
            <div id="paymentDetailsContent" class="payment-details-content"></div>
            <div class="modal-actions">
                <button id="closeDetails" class="submit-button secondary" aria-label="Close payment details">
                    <i class="fas fa-times"></i> Close
                </button>
            </div>
        </div>
    </div>

    <%-- Loading Overlay --%>
    <div class="loading-overlay" id="loading-overlay">
        <div class="loading-spinner"></div>
    </div>

    <%-- Back to Dashboard --%>
    <a href="admin-dashboard.jsp" class="submit-button secondary" aria-label="Return to admin dashboard" style="margin-top: 2rem;">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<script defer>
    (function() {
        // Utility functions
        const utils = {
            toggleElement: (element, show) => {
                element.style.display = show ? 'block' : 'none';
            },
            showNotification: (container, status, message) => {
                const notification = document.createElement('div');
                notification.className = `notification ${status}`;
                notification.innerHTML = `<i class="fas fa-${status === 'success' ? 'check-circle' : 'exclamation-circle'}"></i><div>${message}</div>`;
                container.prepend(notification);
                setTimeout(() => notification.remove(), 5000);
            },
            sanitizeInput: (input) => {
                const div = document.createElement('div');
                div.textContent = input;
                return div.innerHTML;
            },
            trapFocus: (modal) => {
                const focusable = modal.querySelectorAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
                const first = focusable[0];
                const last = focusable[focusable.length - 1];
                modal.addEventListener('keydown', (e) => {
                    if (e.key === 'Tab') {
                        if (e.shiftKey && document.activeElement === first) {
                            e.preventDefault();
                            last.focus();
                        } else if (!e.shiftKey && document.activeElement === last) {
                            e.preventDefault();
                            first.focus();
                        }
                    }
                });
            }
        };

        // Initialize tabs
        const initTabs = () => {
            const tabLabels = document.querySelectorAll('.tab-label');
            const tabSections = document.querySelectorAll('.tab-section');

            tabLabels.forEach(label => {
                label.addEventListener('click', () => {
                    tabLabels.forEach(l => {
                        l.classList.remove('active');
                        l.setAttribute('aria-selected', 'false');
                    });
                    tabSections.forEach(s => s.classList.remove('active'));

                    label.classList.add('active');
                    label.setAttribute('aria-selected', 'true');
                    document.getElementById(label.dataset.tab).classList.add('active');
                    label.focus();
                });
            });
        };

        // Validate ID via AJAX
        const validateId = async (input, errorElement, endpoint) => {
            const value = utils.sanitizeInput(input.value);
            if (!input.checkValidity()) {
                errorElement.textContent = `Invalid format for ${input.name}`;
                utils.toggleElement(errorElement, true);
                return false;
            }
            try {
                const response = await fetch(`${endpoint}?id=${encodeURIComponent(value)}`, {
                    headers: { 'Accept': 'application/json' }
                });
                const result = await response.json();
                if (!result.exists) {
                    errorElement.textContent = `No ${input.name} found with ID ${value}`;
                    utils.toggleElement(errorElement, true);
                    return false;
                }
                utils.toggleElement(errorElement, false);
                return true;
            } catch {
                utils.toggleElement(errorElement, false);
                return true; // Assume valid if server error
            }
        };

        // Form submission
        const handleFormSubmit = (form) => {
            form.addEventListener('submit', async (e) => {
                e.preventDefault();
                if (!form.checkValidity()) {
                    form.reportValidity();
                    return;
                }

                const button = form.querySelector('.submit-button');
                const originalContent = button.innerHTML;
                button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                button.disabled = true;
                utils.toggleElement(document.getElementById('loading-overlay'), true);

                // Validate IDs
                const idInput = form.querySelector('input[name="invoiceId"], input[name="paymentId"], input[name="studentId"]');
                const errorElement = form.querySelector('.input-error');
                if (idInput && errorElement) {
                    const endpoint = idInput.name === 'studentId' ? 'ValidateStudent' : idInput.name === 'invoiceId' ? 'ValidateInvoice' : 'ValidatePayment';
                    if (!(await validateId(idInput, errorElement, endpoint))) {
                        button.innerHTML = originalContent;
                        button.disabled = false;
                        utils.toggleElement(document.getElementById('loading-overlay'), false);
                        return;
                    }
                }

                try {
                    const formData = new FormData(form);
                    const response = await fetch(form.action, {
                        method: form.method,
                        body: formData,
                        headers: { 'Accept': 'application/json' }
                    });
                    const result = await response.json();
                    utils.showNotification(form, result.status, result.message);
                    if (result.status === 'success') form.reset();
                } catch (error) {
                    utils.showNotification(form, 'error', 'Submission failed. Please try again.');
                } finally {
                    button.innerHTML = originalContent;
                    button.disabled = false;
                    utils.toggleElement(document.getElementById('loading-overlay'), false);
                }
            });
        };

        // Date validation
        const validateDates = () => {
            const form = document.getElementById('payment-history-form');
            const startDate = document.getElementById('startDate');
            const endDate = document.getElementById('endDate');
            const dateError = document.getElementById('date-error');

            form.addEventListener('submit', (e) => {
                if (startDate.value && endDate.value && startDate.value > endDate.value) {
                    e.preventDefault();
                    utils.toggleElement(dateError, true);
                    startDate.focus();
                } else {
                    utils.toggleElement(dateError, false);
                }
            });
        };

        // Reason select handling
        const handleReasonSelect = (selectId, containerId, textareaId) => {
            const select = document.getElementById(selectId);
            const container = document.getElementById(containerId);
            if (select && container) {
                select.addEventListener('change', () => {
                    utils.toggleElement(container, select.value === 'Other');
                    if (select.value !== 'Other') {
                        document.getElementById(textareaId).value = '';
                    }
                });
            }
        };

        // Void invoice modal
        const initVoidModal = () => {
            const voidForm = document.getElementById('void-form');
            const confirmModal = document.getElementById('confirmModal');
            const modalInvoiceId = document.getElementById('modalInvoiceId');
            const cancelVoid = document.getElementById('cancelVoid');
            const confirmVoid = document.getElementById('confirmVoid');

            if (voidForm && confirmModal) {
                voidForm.addEventListener('submit', async (e) => {
                    e.preventDefault();
                    const idInput = document.getElementById('voidInvoiceId');
                    const errorElement = document.getElementById('voidInvoiceId-error');
                    if (!(await validateId(idInput, errorElement, 'ValidateInvoice'))) return;
                    modalInvoiceId.textContent = utils.sanitizeInput(idInput.value);
                    utils.toggleElement(confirmModal, true);
                    utils.trapFocus(confirmModal);
                    confirmVoid.focus();
                });

                cancelVoid.addEventListener('click', () => utils.toggleElement(confirmModal, false));
                confirmVoid.addEventListener('click', () => {
                    utils.toggleElement(confirmModal, false);
                    voidForm.submit();
                });

                confirmModal.addEventListener('click', (e) => {
                    if (e.target === confirmModal) utils.toggleElement(confirmModal, false);
                });

                confirmModal.addEventListener('keydown', (e) => {
                    if (e.key === 'Escape') utils.toggleElement(confirmModal, false);
                });
            }
        };

        // Payment details modal
        const initPaymentDetails = () => {
            const detailsModal = document.getElementById('paymentDetailsModal');
            const detailsContent = document.getElementById('paymentDetailsContent');
            const closeDetails = document.getElementById('closeDetails');

            document.querySelectorAll('.payment-details-button').forEach(button => {
                button.addEventListener('click', async () => {
                    const paymentId = utils.sanitizeInput(button.dataset.paymentId);
                    utils.toggleElement(document.getElementById('loading-overlay'), true);
                    try {
                        const response = await fetch(`PaymentDetails?paymentId=${encodeURIComponent(paymentId)}`, {
                            headers: { 'Accept': 'application/json' }
                        });
                        const result = await response.json();
                        detailsContent.innerHTML = `
                            <div class="detail-row"><strong>Payment ID:</strong> <span>${utils.sanitizeInput(result.paymentId)}</span></div>
                            <div class="detail-row"><strong>Student ID:</strong> <span>${utils.sanitizeInput(result.studentId)}</span></div>
                            <div class="detail-row"><strong>Amount:</strong> <span>$${utils.sanitizeInput(result.amount)}</span></div>
                            <div class="detail-row"><strong>Date:</strong> <span>${utils.sanitizeInput(result.paymentDate)}</span></div>
                            <div class="detail-row"><strong>Method:</strong> <span>${utils.sanitizeInput(result.paymentMethod)}</span></div>
                            <div class="detail-row"><strong>Status:</strong> <span class="status-${result.status.toLowerCase()}">${utils.sanitizeInput(result.status)}</span></div>
                        `;
                    } catch {
                        detailsContent.innerHTML = `<div class="notification error"><i class="fas fa-exclamation-circle"></i> Error loading details for Payment ID: ${paymentId}</div>`;
                    }
                    utils.toggleElement(detailsModal, true);
                    utils.trapFocus(detailsModal);
                    closeDetails.focus();
                    utils.toggleElement(document.getElementById('loading-overlay'), false);
                });
            });

            closeDetails.addEventListener('click', () => utils.toggleElement(detailsModal, false));
            detailsModal.addEventListener('click', (e) => {
                if (e.target === detailsModal) utils.toggleElement(detailsModal, false);
            });
            detailsModal.addEventListener('keydown', (e) => {
                if (e.key === 'Escape') utils.toggleElement(detailsModal, false);
            });
        };

        // Countdown timer
        const startCountdown = (element, timestamp) => {
            const paymentTime = new Date(timestamp).getTime();
            const endTime = paymentTime + (24 * 60 * 60 * 1000); // 24 hours
            const oneHour = 60 * 60 * 1000;

            const interval = setInterval(() => {
                const now = Date.now();
                const timeLeft = endTime - now;

                if (timeLeft <= 0) {
                    clearInterval(interval);
                    element.textContent = 'Expired';
                    element.classList.remove('countdown-timer', 'warning');
                    element.classList.add('countdown-expired');
                    return;
                }

                if (timeLeft <= oneHour) {
                    element.classList.add('warning');
                }

                const hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);
                element.textContent = `${hours}h ${minutes}m ${seconds}s`;
            }, 1000);
        };

        // Initialize countdown timers
        const initCountdownTimers = () => {
            document.querySelectorAll('.countdown-timer').forEach(timer => {
                const timestamp = timer.dataset.timestamp;
                if (timestamp) startCountdown(timer, timestamp);
            });
        };

        // Pagination
        const initPagination = () => {
            const prevPage = document.getElementById('prev-page');
            const nextPage = document.getElementById('next-page');
            const form = document.getElementById('payment-history-form');

            if (prevPage && nextPage && form) {
                prevPage.addEventListener('click', () => {
                    const pageInput = document.createElement('input');
                    pageInput.type = 'hidden';
                    pageInput.name = 'page';
                    pageInput.value = parseInt('${page}') - 1;
                    form.appendChild(pageInput);
                    form.submit();
                });

                nextPage.addEventListener('click', () => {
                    const pageInput = document.createElement('input');
                    pageInput.type = 'hidden';
                    pageInput.name = 'page';
                    pageInput.value = parseInt('${page}') + 1;
                    form.appendChild(pageInput);
                    form.submit();
                });
            }
        };

        // CSV Export
        const initCsvExport = () => {
            const exportButton = document.getElementById('export-csv');
            if (exportButton) {
                exportButton.addEventListener('click', () => {
                    const headers = ['Payment ID', 'Date', 'Amount', 'Method', 'Status'];
                    const rows = [];
                    document.querySelectorAll('#payment-records tr').forEach(row => {
                        const cells = row.querySelectorAll('td');
                        if (cells.length) {
                            rows.push([
                                cells[0].textContent,
                                cells[1].textContent,
                                cells[2].textContent.replace('$', ''),
                                cells[3].textContent,
                                cells[4].textContent.replace(/^\S+\s/, '')
                            ]);
                        }
                    });

                    const csv = [headers.join(','), ...rows.map(row => row.join(','))].join('\n');
                    const blob = new Blob([csv], { type: 'text/csv' });
                    const url = URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = `payment_history_${new Date().toISOString().split('T')[0]}.csv`;
                    a.click();
                    URL.revokeObjectURL(url);
                });
            }
        };

        // Initialize all features
        const init = () => {
            initTabs();
            document.querySelectorAll('form').forEach(handleFormSubmit);
            validateDates();
            handleReasonSelect('waiverReason', 'otherReasonContainer', 'otherReason');
            handleReasonSelect('voidReason', 'voidOtherReasonContainer', 'voidOtherReason');
            handleReasonSelect('cancelReason', 'cancelOtherReasonContainer', 'cancelOtherReason');
            initVoidModal();
            initPaymentDetails();
            initCountdownTimers();
            initPagination();
            initCsvExport();
        };

        document.addEventListener('DOMContentLoaded', init);
    })();
</script>
</body>
</html>