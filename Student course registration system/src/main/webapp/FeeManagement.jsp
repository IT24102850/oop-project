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
    <%-- Note: Consider hosting Font Awesome locally for production to reduce external dependencies --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" defer>
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #4facfe;
            --accent-color: #ff4d7e;
            --dark-color: #0a0f24;
            --text-color: #ffffff;
            --text-muted: rgba(255,255,255,0.7);
            --glow-color: rgba(0,242,254,0.6);
            --card-bg: rgba(15,23,42,0.9);
            --border-radius: 12px;
            --box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            --transition: all 0.3s ease;
            --success-color: #00ff88;
            --warning-color: #ffcc00;
            --error-color: #ff4d7e;
            --modal-bg: rgba(10,15,36,0.95);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(ellipse at bottom, #050916 0%, var(--dark-color) 100%);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            padding: 16px;
            line-height: 1.5;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 20% 30%, rgba(0,242,254,0.1) 0%, transparent 20%), radial-gradient(circle at 80% 70%, rgba(79,172,254,0.1) 0%, transparent 20%);
            opacity: 0.3;
            z-index: -1;
        }

        h1, h2, h3 {
            font-family: 'Orbitron', sans-serif;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .application-container {
            width: 100%;
            max-width: 1100px;
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            border: 1px solid rgba(0,242,254,0.2);
            box-shadow: var(--box-shadow);
            padding: 24px;
            position: relative;
        }

        .hud-header {
            font-size: 2rem;
            margin-bottom: 20px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
        }

        .hud-header::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60%;
            height: 3px;
            background: var(--primary-color);
            border-radius: 2px;
        }

        .input-holofield {
            margin-bottom: 20px;
            position: relative;
        }

        .input-holofield label {
            display: block;
            margin-bottom: 8px;
            font-family: 'Orbitron', sans-serif;
            color: var(--primary-color);
            font-size: 1rem;
        }

        .holo-input {
            width: 100%;
            padding: 12px 16px;
            background: rgba(10,15,36,0.6);
            border: 2px solid rgba(0,242,254,0.3);
            border-radius: var(--border-radius);
            color: var(--text-color);
            font-size: 1rem;
            transition: var(--transition);
        }

        .holo-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 15px var(--glow-color);
            outline: none;
        }

        .holo-input::placeholder {
            color: var(--text-muted);
        }

        .input-error {
            color: var(--error-color);
            font-size: 0.9rem;
            margin-top: 4px;
            display: none;
        }

        .tooltip::after {
            content: attr(data-tooltip);
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            background: var(--dark-color);
            color: var(--text-color);
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 0.9rem;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: var(--transition);
            z-index: 10;
        }

        .tooltip:hover::after {
            opacity: 1;
            visibility: visible;
        }

        .price-display {
            background: rgba(0,242,254,0.1);
            padding: 20px;
            border-radius: var(--border-radius);
            border: 1px solid var(--primary-color);
            margin: 24px 0;
        }

        .price-line {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid rgba(0,242,254,0.2);
            font-size: 1rem;
        }

        .price-line.total {
            font-weight: 600;
            color: var(--primary-color);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 12px;
            margin-top: 20px;
        }

        .submit-button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: var(--border-radius);
            color: var(--dark-color);
            font-family: 'Orbitron', sans-serif;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            touch-action: manipulation;
        }

        .submit-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px var(--glow-color);
        }

        .submit-button.secondary {
            background: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }

        .submit-button.secondary:hover {
            background: rgba(0,242,254,0.1);
        }

        .submit-button.void-invoice-button {
            background: var(--error-color);
        }

        .submit-button.cancel-payment-button {
            background: var(--warning-color);
        }

        .tab-container {
            display: flex;
            justify-content: center;
            gap: 16px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .tab-label {
            font-family: 'Orbitron', sans-serif;
            font-size: 1rem;
            color: var(--text-muted);
            cursor: pointer;
            padding: 10px 20px;
            border-radius: 30px;
            background: none;
            border: none;
            transition: var(--transition);
        }

        .tab-label:hover {
            color: var(--text-color);
            background: rgba(0,242,254,0.1);
        }

        .tab-label.active {
            color: var(--primary-color);
            background: rgba(0,242,254,0.1);
        }

        .tab-section {
            display: none;
            animation: fadeInUp 0.5s ease-out;
        }

        .tab-section.active {
            display: block;
        }

        .payment-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin: 16px 0;
            border-radius: var(--border-radius);
            overflow: hidden;
        }

        .payment-table th {
            background: rgba(0,242,254,0.2);
            color: var(--primary-color);
            font-family: 'Orbitron', sans-serif;
            padding: 12px;
            text-align: left;
            font-size: 0.9rem;
        }

        .payment-table td {
            padding: 12px;
            border-bottom: 1px solid rgba(0,242,254,0.1);
            background: rgba(10,15,36,0.5);
            font-size: 0.9rem;
        }

        .payment-table tr:hover td {
            background: rgba(0,242,254,0.1);
        }

        .status-paid { color: var(--success-color); }
        .status-pending { color: var(--warning-color); }
        .status-overdue { color: var(--error-color); }
        .status-canceled { color: var(--accent-color); }

        .notification {
            padding: 12px 16px;
            border-radius: var(--border-radius);
            margin: 16px 0;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.5s ease-out;
        }

        .notification.success {
            background: rgba(0,255,136,0.1);
            border-left: 4px solid var(--success-color);
        }

        .notification.error {
            background: rgba(255,77,126,0.1);
            border-left: 4px solid var(--error-color);
        }

        .notification.warning {
            background: rgba(255,204,0,0.1);
            border-left: 4px solid var(--warning-color);
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin: 16px 0;
        }

        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.7);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: var(--modal-bg);
            padding: 24px;
            border-radius: var(--border-radius);
            width: 90%;
            max-width: 450px;
            border: 1px solid var(--primary-color);
            box-shadow: var(--box-shadow);
        }

        .modal-actions {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }

        .countdown-timer { color: var(--warning-color); font-weight: 600; }
        .countdown-timer.warning { color: var(--error-color); }
        .countdown-expired { color: var(--error-color); font-weight: 600; }

        .loading-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .loading-spinner {
            border: 4px solid var(--text-muted);
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }

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

        @media (max-width: 992px) {
            .application-container { padding: 20px; }
            .hud-header { font-size: 1.8rem; }
        }

        @media (max-width: 768px) {
            .application-container { padding: 16px; }
            .tab-container { flex-direction: column; gap: 8px; }
            .tab-label { width: 100%; text-align: center; padding: 12px; }
            .payment-table { display: block; overflow-x: auto; white-space: nowrap; }
            .modal-content { padding: 16px; }
            .modal-actions { flex-direction: column; }
            .submit-button { font-size: 0.9rem; padding: 12px; }
        }
    </style>
</head>
<body>
<%-- Floating background elements removed to reduce rendering overhead --%>

<div class="application-container">
    <h1 class="hud-header">Fee Management</h1>

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
                <i class="fas fa-download"></i> Export as CSV
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
                    <button class="submit-button secondary" id="prev-page" <c:if test="${page <= 1}">disabled</c:if> aria-label="Previous page">Previous</button>
                    <span>Page <c:out value="${page}"/> of <c:out value="${totalPages}"/></span>
                    <button class="submit-button secondary" id="next-page" <c:if test="${page >= totalPages}">disabled</c:if> aria-label="Next page">Next</button>
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
            <h3 id="confirmModalTitle">Confirm Void Invoice</h3>
            <p>Are you sure you want to void invoice <span id="modalInvoiceId"></span>? This action cannot be undone.</p>
            <div class="modal-actions">
                <button id="cancelVoid" class="submit-button secondary" aria-label="Cancel void action">Cancel</button>
                <button id="confirmVoid" class="submit-button void-invoice-button" aria-label="Confirm void action">Confirm</button>
            </div>
        </div>
    </div>

    <%-- Payment Details Modal --%>
    <div id="paymentDetailsModal" class="modal" style="display: none;" role="dialog" aria-labelledby="paymentDetailsTitle" tabindex="-1">
        <div class="modal-content">
            <h3 id="paymentDetailsTitle">Payment Details</h3>
            <div id="paymentDetailsContent"></div>
            <div class="modal-actions">
                <button id="closeDetails" class="submit-button secondary" aria-label="Close payment details">Close</button>
            </div>
        </div>
    </div>

    <%-- Loading Overlay --%>
    <div class="loading-overlay" id="loading-overlay">
        <div class="loading-spinner"></div>
    </div>

    <%-- Back to Dashboard --%>
    <a href="admin-dashboard.jsp" class="submit-button secondary" aria-label="Return to admin dashboard">
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
                            <p><strong>Payment ID:</strong> ${utils.sanitizeInput(result.paymentId)}</p>
                            <p><strong>Student ID:</strong> ${utils.sanitizeInput(result.studentId)}</p>
                            <p><strong>Amount:</strong> $${utils.sanitizeInput(result.amount)}</p>
                            <p><strong>Date:</strong> ${utils.sanitizeInput(result.paymentDate)}</p>
                            <p><strong>Method:</strong> ${utils.sanitizeInput(result.paymentMethod)}</p>
                            <p><strong>Status:</strong> ${utils.sanitizeInput(result.status)}</p>
                        `;
                    } catch {
                        detailsContent.innerHTML = `<p>Error loading details for Payment ID: ${paymentId}</p>`;
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