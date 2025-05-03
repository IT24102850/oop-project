<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us | NexoraSkill</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="icon" type="image/png" href="./images/favicon.ico">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
  <!-- Link to styles.css -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
  <style>
    /* Additional Contact Page Specific Styles */
    .contact-hero {
      padding: 180px 5% 100px;
      text-align: center;
      position: relative;
      overflow: hidden;
    }

    .contact-hero:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: radial-gradient(circle, rgba(0, 242, 254, 0.05) 0%, transparent 70%);
      z-index: -1;
    }

    .contact-title {
      font-size: 4rem;
      margin-bottom: 30px;
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
      position: relative;
    }

    .contact-title:after {
      content: '';
      position: absolute;
      bottom: -15px;
      left: 50%;
      transform: translateX(-50%);
      width: 100px;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
      border-radius: 2px;
    }

    .contact-subtext {
      font-size: 1.4rem;
      color: var(--text-muted);
      max-width: 700px;
      margin: 0 auto 50px;
    }

    .contact-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 50px;
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 5% 100px;
    }

    .contact-info {
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      padding: 50px 40px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
      position: relative;
      overflow: hidden;
      z-index: 1;
    }

    .contact-info:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
      z-index: -1;
    }

    .info-item {
      display: flex;
      align-items: flex-start;
      gap: 20px;
      margin-bottom: 30px;
    }

    .info-icon {
      width: 60px;
      height: 60px;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--dark-color);
      font-size: 1.5rem;
      flex-shrink: 0;
    }

    .info-content h3 {
      font-size: 1.5rem;
      margin-bottom: 10px;
      color: var(--primary-color);
    }

    .info-content p, .info-content a {
      color: var(--text-muted);
      transition: var(--transition);
      text-decoration: none;
    }

    .info-content a:hover {
      color: var(--primary-color);
    }

    .contact-form {
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      padding: 50px 40px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
    }

    .form-group {
      position: relative;
      margin-bottom: 30px;
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 15px;
      border: 1px solid rgba(0, 242, 254, 0.3);
      border-radius: 5px;
      background: rgba(10, 15, 36, 0.5);
      color: var(--text-color);
      font-size: 1rem;
      transition: var(--transition);
    }

    .form-group textarea {
      min-height: 150px;
      resize: vertical;
    }

    .form-group input:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: var(--primary-color);
      box-shadow: 0 0 0 2px rgba(0, 242, 254, 0.2);
    }

    .form-group label {
      position: absolute;
      top: 15px;
      left: 15px;
      color: var(--text-muted);
      pointer-events: none;
      transition: var(--transition);
      background: rgba(10, 15, 36, 0.5);
      padding: 0 5px;
    }

    .form-group input:focus + label,
    .form-group input:not(:placeholder-shown) + label,
    .form-group textarea:focus + label,
    .form-group textarea:not(:placeholder-shown) + label {
      top: -10px;
      left: 10px;
      font-size: 12px;
      color: var(--primary-color);
      background: var(--card-bg);
    }

    .submit-btn {
      width: 100%;
      padding: 16px;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: var(--dark-color);
      border: none;
      border-radius: 5px;
      font-size: 1.1rem;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }

    .submit-btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 20px rgba(0, 242, 254, 0.4);
    }

    .alert {
      padding: 15px;
      border-radius: 5px;
      margin-bottom: 30px;
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .alert-success {
      background: rgba(0, 255, 0, 0.1);
      color: #00ff00;
      border: 1px solid #00ff00;
    }

    .alert-error {
      background: rgba(255, 0, 0, 0.1);
      color: #ff0000;
      border: 1px solid #ff0000;
    }

    .map-container {
      height: 400px;
      border-radius: var(--border-radius);
      overflow: hidden;
      margin-top: 50px;
      border: 1px solid rgba(0, 242, 254, 0.3);
      box-shadow: var(--box-shadow);
    }

    .map-container iframe {
      width: 100%;
      height: 100%;
      border: none;
      filter: grayscale(50%) hue-rotate(180deg);
      transition: var(--transition);
    }

    .map-container:hover iframe {
      filter: grayscale(0%) hue-rotate(0deg);
    }

    @media (max-width: 768px) {
      .contact-title {
        font-size: 2.8rem;
      }

      .contact-subtext {
        font-size: 1.2rem;
      }
    }

    @media (max-width: 576px) {
      .contact-title {
        font-size: 2.2rem;
      }

      .contact-subtext {
        font-size: 1.1rem;
      }

      .info-item {
        flex-direction: column;
        gap: 15px;
      }

      .info-icon {
        width: 50px;
        height: 50px;
        font-size: 1.2rem;
      }
    }
  </style>
</head>