<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 4/19/2025
  Time: 6:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        /* CSS Styles */
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #4facfe;
            --accent-color: #ff4d7e;
            --dark-color: #0a0f24;
            --darker-color: #050916;
            --text-color: #ffffff;
            --text-muted: rgba(255,255,255,0.7);
            --hover-color: #00c6fb;
            --glow-color: rgba(0, 242, 254, 0.6);
            --card-bg: rgba(15, 23, 42, 0.9);
            --glass-bg: rgba(255, 255, 255, 0.08);
            --border-radius: 16px;
            --box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            --success-color: #00ff88;
            --warning-color: #ffcc00;
            --error-color: #ff4d7e;
            --modal-bg: rgba(10, 15, 36, 0.95);
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
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
            line-height: 1.6;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                    radial-gradient(circle at 20% 30%, rgba(0, 242, 254, 0.1) 0%, transparent 20%),
                    radial-gradient(circle at 80% 70%, rgba(79, 172, 254, 0.1) 0%, transparent 20%),
                    url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path fill="none" stroke="rgba(0,242,254,0.05)" stroke-width="0.5" d="M0,0 L100,0 L100,100 L0,100 Z" /></svg>');
            background-size: 50px 50px;
            opacity: 0.5;
            z-index: -1;
        }

        h1, h2, h3 {
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            letter-spacing: 1.5px;
            margin-bottom: 1rem;
        }

        .application-container {
            width: 100%;
            max-width: 1200px;
            background: var(--card-bg);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            padding: 40px;
            position: relative;
            overflow: hidden;
            z-index: 1;
            animation: fadeIn 0.8s ease-out;
        }

        .application-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, var(--primary-color), transparent);
            animation: scan 20s linear infinite;
            opacity: 0.05;
            z-index: -1;
        }

        .hud-header {
            font-size: 2.5rem;
            margin-bottom: 30px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
            position: relative;
            display: inline-block;
        }

        .hud-header::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), rgba(0, 242, 254, 0.2));
            border-radius: 2px;
        }

        .input-holofield {
            margin-bottom: 25px;
            position: relative;
        }

        .input-holofield label {
            display: block;
            margin-bottom: 10px;
            font-family: 'Orbitron', sans-serif;
            color: var(--primary-color);
            font-size: 1.1rem;
            letter-spacing: 1px;
        }

        .holo-input {
            width: 100%;
            padding: 15px 20px;
            background: rgba(10, 15, 36, 0.6);
            border: 2px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            color: var(--text-color);
            font-size: 1.1rem;
            transition: var(--transition);
            font-family: 'Poppins', sans-serif;
        }

        .holo-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 20px rgba(0, 242, 254, 0.3);
            outline: none;
            background: rgba(10, 15, 36, 0.8);
        }

        .holo-input::placeholder {
            color: var(--text-muted);
            opacity: 0.7;
        }

        .price-display {
            background: rgba(0, 242, 254, 0.1);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid var(--primary-color);
            margin: 30px 0;
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.6s ease-out;
        }

        .price-display::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, transparent, rgba(0, 242, 254, 0.05), transparent);
            z-index: -1;
        }

        .price-line {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
            padding: 10px 0;
            border-bottom: 1px solid rgba(0, 242, 254, 0.2);
            font-size: 1.1rem;
        }

        .price-line.total {
            font-weight: 600;
            color: var(--primary-color);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 15px;
            margin-top: 25px;
        }

        .submit-button {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: var(--border-radius);
            color: var(--dark-color);
            font-family: 'Orbitron', sans-serif;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .submit-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            transition: var(--transition);
            z-index: -1;
        }

        .submit-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 242, 254, 0.4);
        }

        .submit-button:hover::before {
            width: 100%;
        }

        .submit-button.secondary {
            background: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            margin-top: 10px;
        }

        .submit-button.secondary:hover {
            background: rgba(0, 242, 254, 0.1);
        }

        .submit-button.void-invoice-button {
            background: var(--error-color);
        }

        .submit-button.void-invoice-button:hover {
            box-shadow: 0 15px 30px rgba(255, 77, 126, 0.4);
        }

        /* Tab navigation styles */
        .tab-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .tab-label {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.2rem;
            color: var(--text-muted);
            cursor: pointer;
            transition: var(--transition);
            padding: 12px 24px;
            border-radius: 50px;
            position: relative;
            overflow: hidden;
            background: none;
            border: none;
            color: var(--text-muted);
        }

        .tab-label::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            transition: var(--transition);
        }

        .tab-label:hover {
            color: var(--text-color);
            background: rgba(0, 242, 254, 0.1);
        }

        .tab-label.active {
            color: var(--primary-color);
            text-shadow: 0 0 10px var(--glow-color);
            background: rgba(0, 242, 254, 0.1);
        }

        .tab-label.active::before {
            width: 100%;
        }

        .tab-section {
            display: none;
            animation: fadeInUp 0.5s ease-out;
        }

        .tab-section.active {
            display: block;
        }

        /* Payment Records Table */
        .payment-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin: 20px 0;
            overflow: hidden;
            border-radius: var(--border-radius);
        }

        .payment-table th {
            background: rgba(0, 242, 254, 0.2);
            color: var(--primary-color);
            font-family: 'Orbitron', sans-serif;
            padding: 15px;
            text-align: left;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .payment-table td {
            padding: 15px;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            background: rgba(10, 15, 36, 0.5);
        }

        .payment-table tr:last-child td {
            border-bottom: none;
        }

        .payment-table tr:hover td {
            background: rgba(0, 242, 254, 0.1);
        }

        .status-paid {
            color: var(--success-color);
            font-weight: 600;
        }

        .status-pending {
            color: var(--warning-color);
            font-weight: 600;
        }

        .status-overdue {
            color: var(--error-color);
            font-weight: 600;
        }

        /* Notification styles */
        .notification {
            padding: 15px 20px;
            border-radius: var(--border-radius);
            margin: 20px 0;
            display: flex;
            align-items: center;
            gap: 15px;
            animation: slideIn 0.5s ease-out;
        }

        .notification.success {
            background: rgba(0, 255, 136, 0.1);
            border-left: 4px solid var(--success-color);
        }

        .notification.error {
            background: rgba(255, 77, 126, 0.1);
            border-left: 4px solid var(--error-color);
        }

        .notification.warning {
            background: rgba(255, 204, 0, 0.1);
            border-left: 4px solid var(--warning-color);
        }

        .notification i {
            font-size: 1.5rem;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin: 20px 0;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s ease-out;
        }

        .modal-content {
            background: var(--modal-bg);
            padding: 30px;
            border-radius: var(--border-radius);
            width: 90%;
            max-width: 500px;
            border: 1px solid var(--primary-color);
            box-shadow: var(--box-shadow);
        }

        .modal-actions {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        .modal-actions .submit-button {
            margin-top: 0;
            flex: 1;
        }

        /* Floating elements */
        .floating-element {
            position: absolute;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(0,242,254,0.1) 0%, transparent 70%);
            z-index: -1;
            animation: float 15s infinite ease-in-out;
        }

        .floating-element:nth-child(1) {
            top: 10%;
            left: 5%;
            width: 150px;
            height: 150px;
            animation-duration: 20s;
        }

        .floating-element:nth-child(2) {
            bottom: 15%;
            right: 10%;
            width: 200px;
            height: 200px;
            animation-duration: 25s;
        }

        /* Animations */
        @keyframes scan {
            0% { transform: translateY(-100%) rotate(45deg); }
            100% { transform: translateY(100%) rotate(45deg); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .application-container {
                padding: 30px;
            }

            .hud-header {
                font-size: 2.2rem;
            }
        }

        @media (max-width: 768px) {
            .hud-header {
                font-size: 1.8rem;
            }

            .application-container {
                padding: 20px;
            }

            .tab-container {
                flex-direction: column;
                gap: 10px;
            }

            .tab-label {
                width: 100%;
                text-align: center;
            }

            .payment-table {
                display: block;
                overflow-x: auto;
            }

            .modal-content {
                padding: 20px;
            }

            .modal-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<!-- Floating background elements -->
<div class="floating-element"></div>
<div class="floating-element"></div>

<div class="application-container">
    <h1 class="hud-header">Fee Management</h1>

    <!-- Tab Navigation -->
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
    </div>

    <!-- Payment History Section -->
    <div id="payment-history" class="tab-section active" role="tabpanel" aria-labelledby="payment-history-tab">
        <h2 class="hud-header">
            <i class="fas fa-history"></i> Payment History
        </h2>

        <form id="payment-history-form" class="search-form">
            <div class="input-holofield">
                <label for="studentId"><i class="fas fa-user-graduate"></i> Student ID</label>
                <input type="text" id="studentId" name="studentId" class="holo-input"
                       placeholder="Enter Student ID (e.g., S1001)" pattern="S[0-9]{4}" required>
            </div>
            <div class="input-holofield">
                <label for="startDate"><i class="fas fa-calendar-alt"></i> Start Date</label>
                <input type="date" id="startDate" name="startDate" class="holo-input">
            </div>
            <div class="input-holofield">
                <label for="endDate"><i class="fas fa-calendar-alt"></i> End Date</label>
                <input type="date" id="endDate" name="endDate" class="holo-input">
            </div>
            <button type="submit" class="submit-button">
                <i class="fas fa-search"></i> View Payment History
            </button>
        </form>

        <!-- Sample Notification -->
        <div class="notification success" aria-live="polite">
            <i class="fas fa-check-circle"></i>
            <div>Payment history loaded successfully.</div>
        </div>

        <!-- Sample Payment Records -->
        <div class="price-display">
            <h3>
                <i class="fas fa-receipt"></i> Payment Records for Student ID: S1001
            </h3>
            <table class="payment-table">
                <thead>
                <tr>
                    <th>Invoice ID</th>
                    <th>Date</th>
                    <th>Amount</th>
                    <th>Payment Method</th>
                    <th>Status</th>
                    <th>Details</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>INV-2023-001</td>
                    <td>2023-10-15</td>
                    <td>$500.00</td>
                    <td>Credit Card</td>
                    <td class="status-paid"><i class="fas fa-circle"></i> Paid</td>
                    <td>
                        <button class="submit-button secondary payment-details-button">
                            <i class="fas fa-info-circle"></i> Details
                        </button>
                    </td>
                </tr>
                <tr>
                    <td>INV-2023-002</td>
                    <td>2023-11-01</td>
                    <td>$300.00</td>
                    <td>Bank Transfer</td>
                    <td class="status-pending"><i class="fas fa-circle"></i> Pending</td>
                    <td>
                        <button class="submit-button secondary payment-details-button">
                            <i class="fas fa-info-circle"></i> Details
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="pagination">
                <button class="submit-button secondary" disabled>Previous</button>
                <button class="submit-button secondary">Next</button>
            </div>
            <div class="price-line total">
                <span>Total Payments:</span>
                <span>$800.00</span>
            </div>
        </div>
    </div>

    <!-- Apply Late Fee Waiver Section -->
    <div id="apply-waiver" class="tab-section" role="tabpanel" aria-labelledby="apply-waiver-tab">
        <h2 class="hud-header">
            <i class="fas fa-hand-holding-heart"></i> Apply Late Fee Waiver
        </h2>

        <form id="waiver-form">
            <div class="input-holofield">
                <label for="waiverInvoiceId"><i class="fas fa-file-invoice-dollar"></i> Invoice ID</label>
                <input type="text" id="waiverInvoiceId" name="invoiceId" class="holo-input"
                       placeholder="Enter Invoice ID (e.g., INV-2023-001)" pattern="INV-[0-9]{4}-[0-9]{3}" required>
            </div>
            <div class="input-holofield">
                <label for="waiverReason"><i class="fas fa-comment-alt"></i> Reason for Waiver</label>
                <select id="waiverReason" name="reason" class="holo-input" required>
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
                          placeholder="Please specify the reason for waiver..." rows="3"></textarea>
            </div>
            <button type="submit" class="submit-button">
                <i class="fas fa-check"></i> Apply Waiver
            </button>
        </form>
    </div>

    <!-- Void Invoice Section -->
    <div id="void-invoice" class="tab-section" role="tabpanel" aria-labelledby="void-invoice-tab">
        <h2 class="hud-header">
            <i class="fas fa-times-circle"></i> Void Invoice
        </h2>

        <form id="void-form">
            <div class="input-holofield">
                <label for="voidInvoiceId"><i class="fas fa-file-invoice-dollar"></i> Invoice ID</label>
                <input type="text" id="voidInvoiceId" name="invoiceId" class="holo-input"
                       placeholder="Enter Invoice ID to void (e.g., INV-2023-001)" pattern="INV-[0-9]{4}-[0-9]{3}" required>
            </div>
            <div class="input-holofield">
                <label for="voidReason"><i class="fas fa-comment-alt"></i> Reason for Void</label>
                <select id="voidReason" name="reason" class="holo-input" required>
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
                          placeholder="Please specify the reason for voiding..." rows="3"></textarea>
            </div>
            <div class="notification warning" aria-live="polite">
                <i class="fas fa-exclamation-triangle"></i>
                <div><strong>Warning:</strong> Voiding an invoice cannot be undone. Please verify the invoice ID before proceeding.</div>
            </div>
            <button type="submit" class="submit-button void-invoice-button">
                <i class="fas fa-trash"></i> Confirm Void Invoice
            </button>
        </form>
    </div>

    <!-- Confirmation Modal -->
    <div id="confirmModal" class="modal" style="display: none;">
        <div class="modal-content">
            <h3>Confirm Void Invoice</h3>
            <p>Are you sure you want to void invoice <span id="modalInvoiceId"></span>? This action cannot be undone.</p>
            <div class="modal-actions">
                <button id="cancelVoid" class="submit-button secondary">Cancel</button>
                <button id="confirmVoid" class="submit-button void-invoice-button">Confirm</button>
            </div>
        </div>
    </div>

    <!-- Back to Dashboard -->
    <a href="admin-dashboard.html" class="submit-button secondary">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<script>
    // Tab switching functionality
    document.addEventListener('DOMContentLoaded', function() {
        const tabLabels = document.querySelectorAll('.tab-label');
        const tabSections = document.querySelectorAll('.tab-section');

        tabLabels.forEach(label => {
            label.addEventListener('click', function() {
                // Remove active class from all labels and sections
                tabLabels.forEach(l => {
                    l.classList.remove('active');
                    l.setAttribute('aria-selected', 'false');
                });
                tabSections.forEach(s => s.classList.remove('active'));

                // Add active class to clicked label and corresponding section
                this.classList.add('active');
                this.setAttribute('aria-selected', 'true');
                const tabId = this.getAttribute('data-tab');
                document.getElementById(tabId).classList.add('active');
            });
        });

        // Form submission handling
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                const button = this.querySelector('.submit-button');
                const originalContent = button.innerHTML;
                button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                button.disabled = true;

                // Simulate form submission
                setTimeout(() => {
                    button.innerHTML = originalContent;
                    button.disabled = false;

                    // Show success notification
                    const notification = document.createElement('div');
                    notification.className = 'notification success';
                    notification.setAttribute('aria-live', 'polite');
                    notification.innerHTML = `
                        <i class="fas fa-check-circle"></i>
                        <div>Operation completed successfully</div>
                    `;
                    this.parentNode.insertBefore(notification, this.nextSibling);

                    // Remove notification after 5 seconds
                    setTimeout(() => {
                        notification.style.opacity = '0';
                        setTimeout(() => notification.remove(), 300);
                    }, 5000);
                }, 1500);
            });
        });

        // Show/hide other reason field based on selection
        const waiverReason = document.getElementById('waiverReason');
        const otherReasonContainer = document.getElementById('otherReasonContainer');

        if (waiverReason && otherReasonContainer) {
            waiverReason.addEventListener('change', function() {
                otherReasonContainer.style.display = this.value === 'Other' ? 'block' : 'none';
                if (this.value !== 'Other') {
                    document.getElementById('otherReason').value = '';
                }
            });
        }

        const voidReason = document.getElementById('voidReason');
        const voidOtherReasonContainer = document.getElementById('voidOtherReasonContainer');

        if (voidReason && voidOtherReasonContainer) {
            voidReason.addEventListener('change', function() {
                voidOtherReasonContainer.style.display = this.value === 'Other' ? 'block' : 'none';
                if (this.value !== 'Other') {
                    document.getElementById('voidOtherReason').value = '';
                }
            });
        }

        // Void invoice confirmation modal
        const voidForm = document.getElementById('void-form');
        const confirmModal = document.getElementById('confirmModal');
        const modalInvoiceId = document.getElementById('modalInvoiceId');
        const cancelVoid = document.getElementById('cancelVoid');
        const confirmVoid = document.getElementById('confirmVoid');

        if (voidForm && confirmModal) {
            voidForm.addEventListener('submit', function(e) {
                e.preventDefault();
                const invoiceId = document.getElementById('voidInvoiceId').value;
                modalInvoiceId.textContent = invoiceId;
                confirmModal.style.display = 'flex';
            });

            cancelVoid.addEventListener('click', function() {
                confirmModal.style.display = 'none';
            });

            confirmVoid.addEventListener('click', function() {
                confirmModal.style.display = 'none';
                voidForm.submit();
            });
        }

        // Close modal when clicking outside
        confirmModal.addEventListener('click', function(e) {
            if (e.target === confirmModal) {
                confirmModal.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>
