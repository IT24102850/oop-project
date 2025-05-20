<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %> <!-- Added this line -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Future-Ready Education Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

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
            overflow-x: hidden;
            line-height: 1.7;
            scroll-behavior: smooth;
        }

        h1, h2, h3 {
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        ::selection {
            background: var(--primary-color);
            color: var(--dark-color);
        }

        /* Preloader */
        .preloader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--darker-color);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }

        .preloader.fade-out {
            opacity: 0;
        }

        .loader {
            width: 80px;
            height: 80px;
            border: 5px solid transparent;
            border-top-color: var(--primary-color);
            border-bottom-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 1.5s linear infinite;
            position: relative;
        }

        .loader:before {
            content: '';
            position: absolute;
            top: 10px;
            left: 10px;
            right: 10px;
            bottom: 10px;
            border: 5px solid transparent;
            border-top-color: var(--secondary-color);
            border-bottom-color: var(--secondary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite reverse;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Header Section - Holographic Effect */
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.2);
            transition: var(--transition);
        }

        .header.scrolled {
            padding: 10px 0;
            background: rgba(10, 15, 36, 0.95);
        }

        .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 5%;
            max-width: 1600px;
            margin: 0 auto;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-color);
            text-decoration: none;
            transition: var(--transition);
            position: relative;
        }

        .logo:hover {
            color: var(--primary-color);
            transform: scale(1.05);
        }

        .logo img {
            height: 45px;
            transition: var(--transition);
            filter: drop-shadow(0 0 5px var(--glow-color));
        }

        .logo:hover img {
            transform: rotate(15deg) scale(1.1);
            filter: drop-shadow(0 0 10px var(--glow-color));
        }

        .logo:after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            transition: var(--transition);
        }

        .logo:hover:after {
            width: 100%;
        }

        .navbar ul {
            list-style: none;
            display: flex;
            gap: 35px;
        }

        .navbar ul li a {
            position: relative;
            font-family: 'Poppins', sans-serif;
            text-decoration: none;
            color: var(--text-color);
            font-weight: 500;
            font-size: 1.1rem;
            transition: var(--transition);
            padding: 8px 0;
            overflow: hidden;
        }

        .navbar ul li a:before {
            content: '';
            position: absolute;
            width: 100%;
            height: 2px;
            bottom: 0;
            left: -100%;
            background: linear-gradient(90deg, transparent, var(--primary-color));
            transition: var(--transition);
        }

        .navbar ul li a:hover {
            color: var(--primary-color);
            text-shadow: 0 0 10px var(--glow-color);
        }

        .navbar ul li a:hover:before {
            left: 100%;
        }

        .auth-buttons {
            display: flex;
            gap: 20px;
        }

        .btn {
            padding: 14px 32px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            font-size: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            transition: var(--transition);
            z-index: -1;
        }

        .btn:hover:before {
            width: 100%;
        }

        .btn-login {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--text-color);
        }

        .btn-login:hover {
            color: var(--dark-color);
            border-color: transparent;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
        }

        .btn-signup {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            border: 2px solid transparent;
        }

        .btn-signup:hover {
            background: transparent;
            color: var(--primary-color);
            border-color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
        }

        /* Hero Section - Futuristic Hologram Effect */
        .hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            min-height: 100vh;
            padding: 180px 5% 100px;
            position: relative;
            overflow: hidden;
        }

        .hero:before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(0, 242, 254, 0.05) 0%, transparent 70%);
            animation: rotate 60s linear infinite;
            z-index: -1;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .hero-content {
            max-width: 700px;
            z-index: 2;
            animation: fadeInUp 1s ease-out;
        }

        .hero-title {
            font-size: 4.5rem;
            margin-bottom: 30px;
            line-height: 1.2;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
            animation: textGlow 3s infinite alternate;
            position: relative;
        }

        .hero-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .hero-subtext {
            font-size: 1.4rem;
            margin-bottom: 40px;
            color: var(--text-muted);
            animation: fadeInUp 1s ease-out 0.2s both;
        }

        .hero-cta {
            display: flex;
            gap: 30px;
            margin-top: 50px;
            animation: fadeInUp 1s ease-out 0.4s both;
        }

        .cta-button {
            padding: 18px 36px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            font-size: 1.2rem;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .cta-button:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            transition: var(--transition);
            z-index: -1;
        }

        .cta-button:hover:before {
            width: 100%;
        }

        .primary-cta {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            box-shadow: 0 10px 25px rgba(0, 242, 254, 0.4);
        }

        .primary-cta:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 15px 35px rgba(0, 242, 254, 0.6);
        }

        .secondary-cta {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .secondary-cta:hover {
            color: var(--dark-color);
            border-color: transparent;
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 15px 35px rgba(0, 242, 254, 0.3);
        }

        .hero-visual {
            position: relative;
            width: 650px;
            height: 650px;
            z-index: 1;
            animation: fadeInRight 1s ease-out;
        }

        .holographic-circle {
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(0, 242, 254, 0.1) 0%, transparent 70%);
            box-shadow: 0 0 100px rgba(0, 242, 254, 0.2);
            animation: pulse 6s infinite alternate;
        }

        .holographic-circle:before {
            content: '';
            position: absolute;
            top: 10%;
            left: 10%;
            right: 10%;
            bottom: 10%;
            border-radius: 50%;
            border: 3px solid rgba(0, 242, 254, 0.3);
            animation: rotate 20s linear infinite reverse;
        }

        .holographic-circle:after {
            content: '';
            position: absolute;
            top: 20%;
            left: 20%;
            right: 20%;
            bottom: 20%;
            border-radius: 50%;
            border: 2px dashed rgba(0, 242, 254, 0.2);
            animation: rotate 30s linear infinite;
        }

        .hologram {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 80%;
            height: 80%;
            background: url('./images/hero-image.png') center/contain no-repeat;
            filter: drop-shadow(0 0 20px var(--glow-color)) hue-rotate(0deg);
            animation: hueRotate 8s infinite linear, float 6s ease-in-out infinite;
        }

        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        .floating-element {
            position: absolute;
            background: var(--glass-bg);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.5rem;
            color: var(--primary-color);
            animation: float 6s ease-in-out infinite;
        }

        .floating-element:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 10%;
            left: 5%;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 70%;
            left: 10%;
            animation-delay: 1s;
        }

        .floating-element:nth-child(3) {
            width: 60px;
            height: 60px;
            top: 30%;
            left: 80%;
            animation-delay: 2s;
        }

        .particles {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }

        .particle {
            position: absolute;
            width: 3px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 50%;
            opacity: 0.6;
            filter: blur(1px);
            animation: particleMove linear infinite;
        }

        @keyframes particleMove {
            0% {
                transform: translateY(0) translateX(0);
                opacity: 0;
            }
            10% {
                opacity: 0.6;
            }
            90% {
                opacity: 0.6;
            }
            100% {
                transform: translateY(-1000px) translateX(200px);
                opacity: 0;
            }
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 50px rgba(0, 242, 254, 0.2);
            }
            100% {
                box-shadow: 0 0 100px rgba(0, 242, 254, 0.4);
            }
        }

        @keyframes hueRotate {
            0% {
                filter: drop-shadow(0 0 20px var(--glow-color)) hue-rotate(0deg);
            }
            100% {
                filter: drop-shadow(0 0 20px var(--glow-color)) hue-rotate(360deg);
            }
        }

        /* Features Section - Interactive Cards */
        .features {
            padding: 150px 5%;
            background: linear-gradient(to bottom, transparent, var(--darker-color));
            position: relative;
            z-index: 2;
        }

        .features:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('./images/grid-pattern.png') center/cover;
            opacity: 0.05;
            z-index: -1;
        }

        .section-title {
            text-align: center;
            font-size: 3rem;
            margin-bottom: 100px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
            animation: fadeInUp 1s ease-out;
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
            max-width: 1300px;
            margin: 0 auto;
        }

        .feature-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 50px 40px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            position: relative;
            overflow: hidden;
            z-index: 1;
            animation: fadeInUp 1s ease-out;
        }

        .feature-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
            z-index: -1;
            opacity: 0;
            transition: var(--transition);
        }

        .feature-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
            border-color: rgba(0, 242, 254, 0.4);
        }

        .feature-card:hover:before {
            opacity: 1;
        }

        .feature-icon {
            font-size: 4rem;
            margin-bottom: 30px;
            color: var(--primary-color);
            transition: var(--transition);
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.2);
            filter: drop-shadow(0 0 10px var(--glow-color));
        }

        .feature-title {
            font-size: 1.8rem;
            margin-bottom: 20px;
            color: var(--text-color);
            transition: var(--transition);
        }

        .feature-card:hover .feature-title {
            color: var(--primary-color);
        }

        .feature-desc {
            color: var(--text-muted);
            font-size: 1.1rem;
            transition: var(--transition);
        }

        .feature-card:hover .feature-desc {
            color: var(--text-color);
        }

        /* Stats Section - Animated Counters */
        .stats {
            padding: 120px 5%;
            background: linear-gradient(to bottom, transparent, var(--dark-color));
            position: relative;
        }

        .stats:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('./images/dots-pattern.png') center/cover;
            opacity: 0.05;
            z-index: -1;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 50px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .stat-item {
            text-align: center;
            position: relative;
            padding: 40px 20px;
            background: var(--card-bg);
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            transition: var(--transition);
            animation: fadeInUp 1s ease-out;
        }

        .stat-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
            border-color: rgba(0, 242, 254, 0.4);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: var(--primary-color);
        }

        .stat-number {
            font-size: 4rem;
            font-weight: 700;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            transition: var(--transition);
        }

        .stat-item:hover .stat-number {
            text-shadow: 0 0 20px var(--glow-color);
        }

        .stat-label {
            font-size: 1.3rem;
            color: var(--text-muted);
            transition: var(--transition);
        }

        .stat-item:hover .stat-label {
            color: var(--text-color);
        }

        /* CTA Section - Parallax Effect */
        .cta-section {
            padding: 180px 5%;
            text-align: center;
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, rgba(10, 15, 36, 0.9), rgba(5, 9, 22, 0.9)), url('./images/cta-bg.jpg') center/cover fixed;
        }

        .cta-container {
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
            animation: fadeInUp 1s ease-out;
        }

        .cta-title {
            font-size: 3.5rem;
            margin-bottom: 40px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
        }

        .cta-subtext {
            font-size: 1.4rem;
            color: var(--text-muted);
            margin-bottom: 60px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        .cta-button {
            padding: 20px 45px;
            border-radius: 50px;
            font-size: 1.3rem;
            font-weight: 600;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            border: none;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 15px 35px rgba(0, 242, 254, 0.4);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .cta-button:before {
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

        .cta-button:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 45px rgba(0, 242, 254, 0.6);
        }

        .cta-button:hover:before {
            width: 100%;
        }

        .cta-bg-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        .cta-bg-element {
            position: absolute;
            border-radius: 50%;
            background: rgba(0, 242, 254, 0.1);
            filter: blur(20px);
        }

        .cta-bg-element:nth-child(1) {
            width: 300px;
            height: 300px;
            top: -100px;
            left: -100px;
            animation: float 8s ease-in-out infinite;
        }

        .cta-bg-element:nth-child(2) {
            width: 200px;
            height: 200px;
            bottom: -50px;
            right: -50px;
            animation: float 10s ease-in-out infinite reverse;
        }

        /* Footer - Holographic Grid */
        .footer {
            background: var(--darker-color);
            padding: 100px 5% 50px;
            border-top: 1px solid rgba(0, 242, 254, 0.1);
            position: relative;
            overflow: hidden;
        }

        .footer:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('./images/grid-pattern.png') center/cover;
            opacity: 0.03;
            z-index: 0;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 50px;
            max-width: 1300px;
            margin: 0 auto 60px;
            position: relative;
            z-index: 1;
        }

        .footer-col {
            position: relative;
        }

        .footer-logo {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 25px;
            display: inline-block;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
        }

        .footer-logo:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .footer-about {
            color: var(--text-muted);
            margin-bottom: 30px;
            font-size: 1.1rem;
            line-height: 1.8;
        }

        .social-links {
            display: flex;
            gap: 20px;
        }

        .social-link {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--glass-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-color);
            transition: var(--transition);
            font-size: 1.3rem;
            border: 1px solid rgba(0, 242, 254, 0.1);
        }

        .social-link:hover {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
            border-color: transparent;
        }

        .footer-title {
            font-size: 1.5rem;
            margin-bottom: 30px;
            color: var(--text-color);
            position: relative;
            padding-bottom: 15px;
        }

        .footer-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 20px;
            position: relative;
            padding-left: 20px;
        }

        .footer-links li:before {
            content: '»';
            position: absolute;
            left: 0;
            color: var(--primary-color);
            transition: var(--transition);
        }

        .footer-links a {
            color: var(--text-muted);
            text-decoration: none;
            transition: var(--transition);
            font-size: 1.1rem;
            display: inline-block;
        }

        .footer-links li:hover:before {
            transform: translateX(5px);
        }

        .footer-links a:hover {
            color: var(--primary-color);
            transform: translateX(5px);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 50px;
            border-top: 1px solid rgba(0, 242, 254, 0.1);
            color: var(--text-muted);
            font-size: 1rem;
            position: relative;
            z-index: 1;
        }

        .footer-bottom a {
            color: var(--primary-color);
            text-decoration: none;
            transition: var(--transition);
        }

        .footer-bottom a:hover {
            text-shadow: 0 0 10px var(--glow-color);
        }

        /* Scroll To Top Button */
        .scroll-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.5rem;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 5px 20px rgba(0, 242, 254, 0.4);
            z-index: 999;
            opacity: 0;
            visibility: hidden;
            transform: translateY(20px);
        }

        .scroll-top.active {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .scroll-top:hover {
            transform: translateY(-5px) scale(1.1);
            box-shadow: 0 10px 25px rgba(0, 242, 254, 0.6);
        }

        /* Review Form Section */
        .review-form-section {
            padding: 120px 5%;
            background: linear-gradient(to bottom, transparent, var(--darker-color));
            position: relative;
            z-index: 2;
        }

        .review-form-container {
            max-width: 600px;
            margin: 0 auto;
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 40px;
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            animation: fadeInUp 1s ease-out;
        }

        .review-form-container h3 {
            font-size: 2rem;
            margin-bottom: 30px;
            text-align: center;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
        }

        .review-form-container h3:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .review-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .review-form input,
        .review-form textarea {
            padding: 15px;
            border-radius: 8px;
            border: 1px solid rgba(0, 242, 254, 0.3);
            background: var(--glass-bg);
            color: var(--text-color);
            font-size: 1rem;
            outline: none;
            transition: var(--transition);
        }

        .review-form input:focus,
        .review-form textarea:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 10px var(--glow-color);
        }

        .review-form textarea {
            resize: vertical;
            min-height: 120px;
        }

        .review-form button {
            padding: 15px;
            border-radius: 50px;
            border: none;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .review-form button:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
        }

        /* Previous Reviews Slideshow Styling */
        .previous-reviews-container {
            max-width: 900px;
            margin: 0 auto;
            margin-bottom: 80px;
        }

        .previous-reviews-title {
            font-size: 2rem;
            text-align: center;
            margin-bottom: 40px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
        }

        .previous-reviews-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .reviews-slideshow {
            position: relative;
            width: 100%;
            height: 400px;
            overflow: hidden;
            margin-bottom: 60px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
        }

        .review-slide {
            position: absolute;
            width: 100%;
            height: 100%;
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }

        .review-slide.active {
            opacity: 1;
        }

        .previous-review-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 30px;
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            transition: var(--transition);
            text-align: center;
            max-width: 600px;
        }

        .previous-review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
            border-color: rgba(0, 242, 254, 0.4);
        }

        .previous-review-card .review-text {
            font-size: 1.3rem;
            color: var(--text-color);
            margin-bottom: 15px;
            font-style: italic;
        }

        .previous-review-card .review-author {
            font-size: 1.1rem;
            color: var(--primary-color);
            font-weight: 600;
        }

        .previous-review-card .review-timestamp {
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-top: 10px;
        }

        /* Responsive Adjustments */
        @media (max-width: 1200px) {
            .hero-title {
                font-size: 3.8rem;
            }

            .hero-visual {
                width: 550px;
                height: 550px;
            }
        }

        @media (max-width: 992px) {
            .hero {
                flex-direction: column;
                text-align: center;
                padding-top: 200px;
                padding-bottom: 100px;
            }

            .hero-content {
                margin-bottom: 80px;
                max-width: 100%;
            }

            .hero-cta {
                justify-content: center;
            }

            .hero-visual {
                width: 100%;
                max-width: 500px;
                height: 400px;
                margin: 0 auto;
            }

            .section-title {
                font-size: 2.5rem;
                margin-bottom: 70px;
            }

            .cta-title {
                font-size: 2.8rem;
            }
        }

        @media (max-width: 768px) {
            .navbar {
                display: none;
            }

            .hero-title {
                font-size: 3rem;
            }

            .hero-subtext {
                font-size: 1.2rem;
            }

            .hero-cta {
                flex-direction: column;
                gap: 20px;
            }

            .cta-button {
                width: 100%;
                justify-content: center;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .footer-grid {
                grid-template-columns: 1fr;
                gap: 40px;
            }

            .review-form-container {
                padding: 20px;
            }

            .review-form input,
            .review-form textarea {
                font-size: 0.9rem;
            }

            .review-form button {
                font-size: 1rem;
            }

            .reviews-slideshow {
                height: 350px;
            }

            .previous-review-card .review-text {
                font-size: 1.2rem;
            }

            .previous-review-card .review-author {
                font-size: 1rem;
            }

            .previous-review-card .review-timestamp {
                font-size: 0.8rem;
            }
        }

        @media (max-width: 576px) {
            .auth-buttons {
                display: none;
            }

            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtext {
                font-size: 1.1rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .cta-title {
                font-size: 2.2rem;
            }

            .cta-subtext {
                font-size: 1.1rem;
            }

            .footer-logo {
                font-size: 1.8rem;
            }

            .previous-reviews-title {
                font-size: 1.8rem;
            }

            .reviews-slideshow {
                height: 300px;
            }

            .previous-review-card {
                padding: 20px;
            }

            .previous-review-card .review-text {
                font-size: 1.1rem;
            }

            .previous-review-card .review-author {
                font-size: 0.9rem;
            }

            .previous-review-card .review-timestamp {
                font-size: 0.7rem;
            }

            .review-form-container {
                padding: 20px;
            }

            .review-form input,
            .review-form textarea {
                font-size: 0.9rem;
            }

            .review-form button {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Preloader -->
<div class="preloader">
    <div class="loader"></div>
</div>

<!-- Header Section -->
<header class="header">
    <div class="container">
        <a href="#" class="logo">
            <img src="./images/favicon-32x32.png" alt="NexoraSkill Logo">
            <span>NexoraSkill</span>
        </a>

        <nav class="navbar">
            <ul>
                <li><a href="#home">Home</a></li>
                <li><a href="courses.jsp">Courses</a></li>
                <li><a href="aboutus.jsp">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <a href="logIn.jsp" class="btn btn-login"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="signUp.jsp" class="btn btn-signup"><i class="fas fa-user-plus"></i> Sign Up</a>
        </div>
    </div>
</header>

<!-- Hero Section -->
<section class="hero" id="home">
    <div class="hero-content">
        <h1 class="hero-title">Transform Your Future With NexoraSkill</h1>
        <p class="hero-subtext">The most advanced platform for skill development and career advancement. Join thousands of students mastering cutting-edge technologies.</p>
        <div class="hero-cta">
            <a href="${pageContext.request.contextPath}/courses.jsp" class="cta-button primary-cta">
                <i class="fas fa-rocket"></i> Explore Courses
            </a>
            <a href="${pageContext.request.contextPath}/signUp.jsp" class="cta-button secondary-cta">
                <i class="fas fa-user-graduate"></i> Apply Now
            </a>
        </div>
    </div>
    <div class="hero-visual">
        <div class="holographic-circle"></div>
        <div class="hologram"></div>
        <div class="floating-elements">
            <div class="floating-element"><i class="fas fa-atom"></i></div>
            <div class="floating-element"><i class="fas fa-code"></i></div>
            <div class="floating-element"><i class="fas fa-microchip"></i></div>
        </div>
        <div class="particles" id="particles-js"></div>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <h2 class="section-title">Why Choose NexoraSkill?</h2>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-bolt"></i>
            </div>
            <h3 class="feature-title">Cutting-Edge Curriculum</h3>
            <p class="feature-desc">Learn the latest technologies with courses updated weekly to match industry demands. Our AI-driven platform adapts to tech trends in real-time.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-chalkboard-teacher"></i>
            </div>
            <h3 class="feature-title">Expert Instructors</h3>
            <p class="feature-desc">Learn directly from industry leaders at top tech companies. Get mentorship from professionals who shape the future of technology.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-laptop-code"></i>
            </div>
            <h3 class="feature-title">Hands-On Projects</h3>
            <p class="feature-desc">Build portfolio-worthy projects using professional tools and workflows. Our VR coding labs simulate real-world development environments.</p>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats">
    <div class="stats-container">
        <div class="stat-item">
            <div class="stat-icon"><i class="fas fa-users"></i></div>
            <div class="stat-number" data-count="12500">0</div>
            <div class="stat-label">Students Enrolled</div>
        </div>
        <div class="stat-item">
            <div class="stat-icon"><i class="fas fa-book-open"></i></div>
            <div class="stat-number" data-count="180">0</div>
            <div class="stat-label">Courses Available</div>
        </div>
        <div class="stat-item">
            <div class="stat-icon"><i class="fas fa-star"></i></div>
            <div class="stat-number" data-count="98">0</div>
            <div class="stat-label">Satisfaction Rate</div>
        </div>
        <div class="stat-item">
            <div class="stat-icon"><i class="fas fa-headset"></i></div>
            <div class="stat-number">24/7</div>
            <div class="stat-label">Support Available</div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
    <div class="cta-bg-elements">
        <div class="cta-bg-element"></div>
        <div class="cta-bg-element"></div>
    </div>
    <div class="cta-container">
        <h2 class="cta-title">Ready to Launch Your Tech Career?</h2>
        <p class="cta-subtext">Join our community of future innovators and gain access to the most advanced learning platform on the planet.</p>
        <a href="${pageContext.request.contextPath}/signUp.jsp" class="cta-button">
            <i class="fas fa-user-astronaut"></i> Start Learning Now
        </a>
    </div>
</section>

<!-- Review Form Section -->
<section class="review-form-section">
    <div class="review-form-container">
        <h3>Submit a Review</h3>
        <form class="review-form" id="reviewForm" action="${pageContext.request.contextPath}/index.jsp" method="POST">
            <input type="text" name="reviewerName" placeholder="Your Name" required maxlength="50">
            <textarea name="reviewText" placeholder="Your Review" required maxlength="500"></textarea>
            <button type="submit"><i class="fas fa-paper-plane"></i> Submit Review</button>
        </form>
        <!-- Display Feedback Message -->
        <div id="feedbackMessage" class="feedback-message" style="display: ${not empty feedbackMessage ? 'block' : 'none'}; color: ${feedbackMessageType == 'error' ? '#ff4d7e' : '#00f2fe'}; margin-top: 15px; text-align: center;">
            ${feedbackMessage}
        </div>
    </div>
</section>

<%--
    Handle Form Submission
--%>
<%
    String reviewerName = request.getParameter("reviewerName");
    String reviewText = request.getParameter("reviewText");
    boolean formSubmitted = reviewerName != null && reviewText != null;

    if (formSubmitted) {
        reviewerName = reviewerName.trim();
        reviewText = reviewText.trim();

        // Initialize feedback attributes
        String feedbackMessage = null;
        String feedbackMessageType = "success";

        if (reviewerName.isEmpty() || reviewText.isEmpty()) {
            feedbackMessage = "Name and review are required.";
            feedbackMessageType = "error";
        } else if (reviewerName.length() > 50 || reviewText.length() > 500) {
            feedbackMessage = "Name must be 50 characters or less, and review must be 500 characters or less.";
            feedbackMessageType = "error";
        } else {
            String filePath = application.getRealPath("/WEB-INF/data/reviews.txt");
            File file = new File(filePath);
            File parentDir = file.getParentFile();
            if (!parentDir.exists() && !parentDir.mkdirs()) {
                feedbackMessage = "Error: Could not create directory for reviews.";
                feedbackMessageType = "error";
            } else {
                String entry = reviewerName + "|" + reviewText;
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                    writer.write(entry);
                    writer.newLine();
                    feedbackMessage = "Review saved successfully.";
                } catch (IOException e) {
                    feedbackMessage = "Error saving review: " + e.getMessage();
                    feedbackMessageType = "error";
                }
            }
        }

        // Set feedback attributes in request scope
        request.setAttribute("feedbackMessage", feedbackMessage);
        request.setAttribute("feedbackMessageType", feedbackMessageType);

        // If successful, reload the page to reflect the new review
        if ("success".equals(feedbackMessageType)) {
            response.sendRedirect(request.getRequestURI());
            return;
        }
    }
%>

<!-- Previous Reviews Section -->
<div class="previous-reviews-container">
    <h3 class="previous-reviews-title">What Our Students Are Saying</h3>



    <%-- Display Previous Reviews --%>
    <div class="reviews-slideshow" id="reviews-slideshow">
        <%
            String filePath = application.getRealPath("/WEB-INF/data/reviews.txt");
            List<String[]> reviews = new ArrayList<>();
            try {
                File file = new File(filePath);
                if (file.exists()) {
                    try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                        String line;
                        while ((line = reader.readLine()) != null) {
                            String[] parts = line.split("\\|", 2);
                            if (parts.length == 2) {
                                reviews.add(parts);
                            }
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("<script>alert('Error reading reviews: " + e.getMessage() + "');</script>");
            }

            if (reviews.isEmpty()) {
        %>
        <div class="review-slide active">
            <div class="previous-review-card">
                <p class="review-text">"No reviews yet. Be the first to share your experience!"</p>
                <p class="review-author">– NexoraSkill Team</p>
            </div>
        </div>
        <%
        } else {
            for (int i = 0; i < reviews.size(); i++) {
                String[] review = reviews.get(i);
                String className = (i == 0) ? "review-slide active" : "review-slide";
        %>
        <div class="<%= className %>">
            <div class="previous-review-card">
                <p class="review-text">"<%= review[1] %>"</p>
                <p class="review-author">– <%= review[0] %></p>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-grid">
        <div class="footer-col">
            <a href="#" class="footer-logo">NexoraSkill</a>
            <p class="footer-about">The premier platform for future-ready education. We're revolutionizing how the world learns technology through immersive, interactive experiences.</p>
            <div class="social-links">
                <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
        <div class="footer-col">
            <h3 class="footer-title">Quick Links</h3>
            <ul class="footer-links">
                <li><a href="#home">Home</a></li>
                <li><a href="courses.jsp">Courses</a></li>
                <li><a href="registration.jsp">Registration</a></li>
                <li><a href="aboutus.jsp">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h3 class="footer-title">Tech Tracks</h3>
            <ul class="footer-links">
                <li><a href="#">AI & Machine Learning</a></li>
                <li><a href="#">Blockchain Development</a></li>
                <li><a href="#">Quantum Computing</a></li>
                <li><a href="#">Cybersecurity</a></li>
                <li><a href="#">Cloud Architecture</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h3 class="footer-title">Company</h3>
            <ul class="footer-links">
                <li><a href="#">Careers</a></li>
                <li><a href="#">Press</a></li>
                <li><a href="#">Investors</a></li>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms of Service</a></li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2023 NexoraSkill. All rights reserved. | Designed with <i class="fas fa-heart" style="color: var(--accent-color);"></i> for the future of education</p>
    </div>
</footer>

<!-- Scroll To Top Button -->
<div class="scroll-top">
    <i class="fas fa-arrow-up"></i>
</div>

<!-- Scripts -->
<script>
    // Preloader
    window.addEventListener('load', function() {
        const preloader = document.querySelector('.preloader');
        preloader.classList.add('fade-out');
        setTimeout(() => {
            preloader.style.display = 'none';
        }, 500);
    });

    // Header Scroll Effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('.header');
        if (window.scrollY > 100) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // Animated Counter
    const counters = document.querySelectorAll('.stat-number');
    const speed = 200;

    function animateCounters() {
        counters.forEach(counter => {
            const target = +counter.getAttribute('data-count');
            const count = +counter.innerText;
            const increment = target / speed;

            if (count < target) {
                counter.innerText = Math.ceil(count + increment);
                setTimeout(animateCounters, 1);
            } else {
                counter.innerText = target;
            }
        });
    }

    const statsSection = document.querySelector('.stats');
    const observer = new IntersectionObserver((entries) => {
        if (entries[0].isIntersecting) {
            animateCounters();
            observer.unobserve(statsSection);
        }
    }, { threshold: 0.5 });

    observer.observe(statsSection);

    // Scroll To Top Button
    const scrollTop = document.querySelector('.scroll-top');
    window.addEventListener('scroll', function() {
        if (window.scrollY > 300) {
            scrollTop.classList.add('active');
        } else {
            scrollTop.classList.remove('active');
        }
    });

    scrollTop.addEventListener('click', function() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    // Particle System
    document.addEventListener('DOMContentLoaded', function() {
        const particlesContainer = document.getElementById('particles-js');
        const particleCount = 100;

        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.classList.add('particle');
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            const size = Math.random() * 4 + 1;
            particle.style.width = size + 'px';
            particle.style.height = size + 'px';
            particle.style.opacity = Math.random() * 0.7 + 0.1;
            particle.style.animationDuration = Math.random() * 25 + 15 + 's';
            particle.style.animationDelay = Math.random() * 5 + 's';
            particlesContainer.appendChild(particle);
        }
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({ behavior: 'smooth' });
        });
    });

    // Slideshow Functionality
    const slides = document.querySelectorAll('.review-slide');
    let currentSlide = 0;

    function showSlide(index) {
        slides.forEach((slide, i) => {
            slide.classList.remove('active');
            if (i === index) slide.classList.add('active');
        });
    }

    function nextSlide() {
        currentSlide = (currentSlide + 1) % slides.length;
        showSlide(currentSlide);
    }

    if (slides.length > 1) {
        setInterval(nextSlide, 5000);
    }
    showSlide(currentSlide);

    // Review Form Submission (Simplified)
    document.getElementById('reviewForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const form = this;
        const reviewerName = form.querySelector('input[name="reviewerName"]').value.trim();
        const reviewText = form.querySelector('textarea[name="reviewText"]').value.trim();

        if (!reviewerName || !reviewText) {
            alert('Please fill in both fields.');
            return;
        }

        // Submit the form directly to let JSP handle it
        form.submit();
    });
</script>
</body>
</html>