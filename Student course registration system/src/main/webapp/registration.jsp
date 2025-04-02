<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Course Application</title>
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
            --hover-color: #00c6fb;
            --glow-color: rgba(0, 242, 254, 0.6);
            --card-bg: rgba(15, 23, 42, 0.8);
            --glass-bg: rgba(255, 255, 255, 0.08);
            --border-radius: 16px;
            --box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            --success-color: #00ff88;
            --warning-color: #ffaa00;
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
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path fill="none" stroke="rgba(0,242,254,0.05)" stroke-width="0.5" d="M0,0 L100,0 L100,100 L0,100 Z" /></svg>');
            background-size: 50px 50px;
            opacity: 0.3;
            z-index: -1;
        }

        h1, h2, h3 {
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            letter-spacing: 1.5px;
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
        }

        .hud-header::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .form-toggle-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin-bottom: 40px;
        }

        .form-toggle-label {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.2rem;
            color: var(--text-muted);
            transition: var(--transition);
        }

        .form-toggle-label.active {
            color: var(--primary-color);
            text-shadow: 0 0 10px var(--glow-color);
        }

        .cyber-toggle {
            position: relative;
            display: inline-block;
            width: 80px;
            height: 40px;
        }

        .cyber-toggle input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .cyber-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: var(--darker-color);
            transition: var(--transition);
            border-radius: 50px;
            border: 2px solid var(--primary-color);
            box-shadow: 0 0 15px rgba(0, 242, 254, 0.3);
        }

        .cyber-slider:before {
            position: absolute;
            content: "";
            height: 30px;
            width: 30px;
            left: 5px;
            bottom: 4px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            transition: var(--transition);
            border-radius: 50%;
        }

        input:checked + .cyber-slider {
            background-color: rgba(0, 242, 254, 0.1);
        }

        input:checked + .cyber-slider:before {
            transform: translateX(38px);
            background: var(--warning-color);
        }

        .form-section {
            display: none;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            animation: fadeInUp 0.5s ease-out;
        }

        .form-section.active {
            display: grid;
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
        }

        .holo-input::placeholder {
            color: var(--text-muted);
        }

        select.holo-input {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2300f2fe'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 20px;
        }

        .price-display {
            background: rgba(0, 242, 254, 0.1);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid var(--primary-color);
            margin: 30px 0;
            position: relative;
            overflow: hidden;
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

        .price-line.total-price {
            font-family: 'Orbitron', sans-serif;
            color: var(--success-color);
            font-size: 1.5rem;
            border-bottom: none;
            margin-top: 25px;
            padding-top: 15px;
            border-top: 1px solid rgba(0, 242, 254, 0.2);
        }

        .payment-methods {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin: 20px 0;
        }

        .payment-method {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
            background: rgba(10, 15, 36, 0.6);
        }

        .payment-method:hover {
            border-color: var(--primary-color);
            background: rgba(0, 242, 254, 0.1);
            transform: translateY(-3px);
        }

        .payment-method input[type="radio"] {
            appearance: none;
            width: 20px;
            height: 20px;
            border: 2px solid var(--primary-color);
            border-radius: 50%;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .payment-method input[type="radio"]:checked {
            background: var(--primary-color);
            box-shadow: 0 0 10px var(--glow-color);
        }

        .payment-method input[type="radio"]:checked::after {
            content: '';
            width: 10px;
            height: 10px;
            background: var(--dark-color);
            border-radius: 50%;
        }

        .payment-icon {
            font-size: 1.5rem;
            color: var(--primary-color);
        }

        .payment-label {
            flex-grow: 1;
            font-size: 1.1rem;
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

        .status-indicator {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 20px 0;
            padding: 15px;
            border-radius: var(--border-radius);
            background: rgba(0, 255, 136, 0.1);
            border: 1px solid var(--success-color);
        }

        .status-indicator.warning {
            background: rgba(255, 170, 0, 0.1);
            border: 1px solid var(--warning-color);
        }

        .status-icon {
            font-size: 1.5rem;
        }

        .status-text {
            font-size: 1.1rem;
        }

        @keyframes scan {
            0% { transform: translateY(-100%) rotate(45deg); }
            100% { transform: translateY(100%) rotate(45deg); }
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

        @keyframes pulse {
            0% { box-shadow: 0 0 10px rgba(0, 242, 254, 0.3); }
            100% { box-shadow: 0 0 20px rgba(0, 242, 254, 0.6); }
        }

        @media (max-width: 992px) {
            .form-section.active {
                grid-template-columns: 1fr;
            }

            .application-container {
                padding: 30px;
            }
        }

        @media (max-width: 768px) {
            .hud-header {
                font-size: 2rem;
            }

            .form-toggle-container {
                flex-direction: column;
                gap: 15px;
            }

            .application-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<div class="application-container">
    <h1 class="hud-header">Course Application</h1>

    <div class="form-toggle-container">
        <span class="form-toggle-label active" id="standardLabel">Standard Enrollment</span>
        <label class="cyber-toggle">
            <input type="checkbox" id="formToggle">
            <span class="cyber-slider"></span>
        </label>
        <span class="form-toggle-label" id="lateLabel">Late Fee Application</span>
    </div>

    <!-- Standard Enrollment Form -->
    <div class="form-section active" id="standardForm">
        <div>
            <div class="input-holofield">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" class="holo-input" placeholder="Enter your full name">
            </div>

            <div class="input-holofield">
                <label for="email">Email Address</label>
                <input type="email" id="email" class="holo-input" placeholder="Enter your email">
            </div>

            <div class="input-holofield">
                <label for="userId">User ID</label>
                <input type="text" id="userId" class="holo-input" placeholder="Enter your user ID">
            </div>
        </div>

        <div>
            <div class="input-holofield">
                <label for="courseSelect">Select Course</label>
                <select id="courseSelect" class="holo-input">
                    <option value="299">Web Development ($299)</option>
                    <option value="399">Data Science ($399)</option>
                    <option value="499">Cyber Security ($499)</option>
                    <option value="599">AI & Machine Learning ($599)</option>
                    <option value="699">Quantum Computing ($699)</option>
                </select>
            </div>

            <div class="price-display">
                <div class="price-line">
                    <span>Course Fee:</span>
                    <span id="courseFee">$299.00</span>
                </div>
                <div class="price-line total-price">
                    <span>Total:</span>
                    <span id="totalFee">$299.00</span>
                </div>
            </div>

            <div class="input-holofield">
                <label>Payment Method</label>
                <div class="payment-methods">
                    <label class="payment-method">
                        <input type="radio" name="payment" checked>
                        <i class="fab fa-cc-visa payment-icon"></i>
                        <span class="payment-label">Credit/Debit Card</span>
                    </label>
                    <label class="payment-method">
                        <input type="radio" name="payment">
                        <i class="fab fa-paypal payment-icon"></i>
                        <span class="payment-label">PayPal</span>
                    </label>
                    <label class="payment-method">
                        <input type="radio" name="payment">
                        <i class="fas fa-university payment-icon"></i>
                        <span class="payment-label">Bank Transfer</span>
                    </label>
                </div>
            </div>

            <button class="submit-button">
                <i class="fas fa-rocket"></i> Confirm Enrollment
            </button>
        </div>
    </div>

    <!-- Late Fee Application Form -->
    <div class="form-section" id="lateFeeForm">
        <div>
            <div class="input-holofield">
                <label for="lateFullName">Full Name</label>
                <input type="text" id="lateFullName" class="holo-input" placeholder="Enter your full name">
            </div>

            <div class="input-holofield">
                <label for="lateEmail">Email Address</label>
                <input type="email" id="lateEmail" class="holo-input" placeholder="Enter your email">
            </div>

            <div class="input-holofield">
                <label for="lateUserId">User ID</label>
                <input type="text" id="lateUserId" class="holo-input" placeholder="Enter your user ID">
            </div>
        </div>

        <div>
            <div class="input-holofield">
                <label for="lateCourseSelect">Select Course</label>
                <select id="lateCourseSelect" class="holo-input">
                    <option value="299">Web Development ($299)</option>
                    <option value="399">Data Science ($399)</option>
                    <option value="499">Cyber Security ($499)</option>
                    <option value="599">AI & Machine Learning ($599)</option>
                    <option value="699">Quantum Computing ($699)</option>
                </select>
            </div>

            <div class="status-indicator warning">
                <i class="fas fa-exclamation-triangle status-icon"></i>
                <span class="status-text">Late fee application requires approval</span>
            </div>

            <div class="price-display">
                <div class="price-line">
                    <span>Course Fee:</span>
                    <span id="lateCourseFee">$299.00</span>
                </div>
                <div class="price-line">
                    <span>Late Fee:</span>
                    <span>$50.00</span>
                </div>
                <div class="price-line total-price">
                    <span>Total:</span>
                    <span id="lateTotalFee">$349.00</span>
                </div>
            </div>

            <div class="input-holofield">
                <label for="lateReason">Reason for Late Fee</label>
                <textarea id="lateReason" class="holo-input" rows="4" placeholder="Please explain your reason for applying after the deadline..."></textarea>
            </div>

            <button class="submit-button">
                <i class="fas fa-paper-plane"></i> Submit Application
            </button>
        </div>
    </div>
</div>

<script>
    // Toggle between forms
    const formToggle = document.getElementById('formToggle');
    const standardForm = document.getElementById('standardForm');
    const lateFeeForm = document.getElementById('lateFeeForm');
    const standardLabel = document.getElementById('standardLabel');
    const lateLabel = document.getElementById('lateLabel');

    formToggle.addEventListener('change', function() {
        if (this.checked) {
            standardForm.classList.remove('active');
            lateFeeForm.classList.add('active');
            standardLabel.classList.remove('active');
            lateLabel.classList.add('active');
        } else {
            lateFeeForm.classList.remove('active');
            standardForm.classList.add('active');
            lateLabel.classList.remove('active');
            standardLabel.classList.add('active');
        }
    });

    // Price calculation for standard form
    const courseSelect = document.getElementById('courseSelect');
    const courseFee = document.getElementById('courseFee');
    const totalFee = document.getElementById('totalFee');

    function updateStandardPrices() {
        const price = courseSelect.value;
        courseFee.textContent = `$${price}.00`;
        totalFee.textContent = `$${price}.00`;
    }

    courseSelect.addEventListener('change', updateStandardPrices);

    // Price calculation for late fee form
    const lateCourseSelect = document.getElementById('lateCourseSelect');
    const lateCourseFee = document.getElementById('lateCourseFee');
    const lateTotalFee = document.getElementById('lateTotalFee');

    function updateLateFeePrices() {
        const price = lateCourseSelect.value;
        const lateFee = 50;
        const total = parseInt(price) + lateFee;

        lateCourseFee.textContent = `$${price}.00`;
        lateTotalFee.textContent = `$${total}.00`;
    }

    lateCourseSelect.addEventListener('change', updateLateFeePrices);

    // Initialize prices
    updateStandardPrices();
    updateLateFeePrices();

    // Form submission handling
    document.querySelectorAll('.submit-button').forEach(button => {
        button.addEventListener('click', function() {
            // Add form submission logic here
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';

            // Simulate form submission
            setTimeout(() => {
                this.innerHTML = this.classList.contains('success') ?
                    '<i class="fas fa-check"></i> Success!' :
                    '<i class="fas fa-rocket"></i> Confirm Enrollment';

                if (!this.classList.contains('success')) {
                    this.classList.add('success');
                    this.innerHTML = '<i class="fas fa-check"></i> Success!';

                    // Create a success message
                    const successMessage = document.createElement('div');
                    successMessage.className = 'status-indicator';
                    successMessage.innerHTML = `
                        <i class="fas fa-check-circle status-icon"></i>
                        <span class="status-text">Application submitted successfully!</span>
                    `;

                    this.parentNode.insertBefore(successMessage, this);

                    // Reset after 3 seconds
                    setTimeout(() => {
                        this.classList.remove('success');
                        this.innerHTML = this === document.querySelector('#standardForm .submit-button') ?
                            '<i class="fas fa-rocket"></i> Confirm Enrollment' :
                            '<i class="fas fa-paper-plane"></i> Submit Application';
                        if (successMessage.parentNode) {
                            successMessage.parentNode.removeChild(successMessage);
                        }
                    }, 3000);
                }
            }, 1500);
        });



        
    });
</script>
</body>
</html>