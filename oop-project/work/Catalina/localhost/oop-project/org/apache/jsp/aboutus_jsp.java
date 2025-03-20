/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/11.0.5
 * Generated at: 2025-03-20 00:45:54 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class aboutus_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports,
                 org.apache.jasper.runtime.JspSourceDirectives {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(4);
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile jakarta.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public boolean getErrorOnELNotFound() {
    return false;
  }

  public jakarta.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final jakarta.servlet.http.HttpServletRequest request, final jakarta.servlet.http.HttpServletResponse response)
      throws java.io.IOException, jakarta.servlet.ServletException {

    if (!jakarta.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final jakarta.servlet.jsp.PageContext pageContext;
    jakarta.servlet.http.HttpSession session = null;
    final jakarta.servlet.ServletContext application;
    final jakarta.servlet.ServletConfig config;
    jakarta.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    jakarta.servlet.jsp.JspWriter _jspx_out = null;
    jakarta.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>About Us - NexoraSkill</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"${pageContext.request.contextPath}/css/aboutus.css\">\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css\">\r\n");
      out.write("    <link rel=\"icon\" type=\"image/png\" href=\"${pageContext.request.contextPath}/images/favicon.ico\">\r\n");
      out.write("    <style>\r\n");
      out.write("        /* General Reset */\r\n");
      out.write("        * { margin: 0; padding: 0; box-sizing: border-box; }\r\n");
      out.write("\r\n");
      out.write("        body {\r\n");
      out.write("            font-family: 'Poppins', sans-serif; background-color: #0a192f; color: #ffffff; line-height: 1.6;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .container { width: 90%; max-width: 1200px; margin: 0 auto; }\r\n");
      out.write("\r\n");
      out.write("        /* Header Section */\r\n");
      out.write("        .header {\r\n");
      out.write("            display: flex; justify-content: space-between; align-items: center; padding: 20px;\r\n");
      out.write("            background-color: #0a192f;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* Logo */\r\n");
      out.write("        .logo img { height: 40px; }\r\n");
      out.write("\r\n");
      out.write("        /* Navigation Menu */\r\n");
      out.write("        .navbar {\r\n");
      out.write("            position: fixed; /* Fixes the navbar at the top */\r\n");
      out.write("            top: 0; /* Positions it at the top */\r\n");
      out.write("            left: 0; /* Aligns it to the left edge */\r\n");
      out.write("            width: 100%; /* Ensures it spans the full width */\r\n");
      out.write("            z-index: 1000; /* Ensures it stays above other content */\r\n");
      out.write("            display: flex;\r\n");
      out.write("            justify-content: center; /* Centers the navbar horizontally */\r\n");
      out.write("            padding: 10px 0; /* Adds some padding for better spacing */\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .navbar ul {\r\n");
      out.write("            list-style: none;\r\n");
      out.write("            display: flex;\r\n");
      out.write("            gap: 20px;\r\n");
      out.write("            margin: 0;\r\n");
      out.write("            padding: 0;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .navbar ul li {\r\n");
      out.write("            display: inline-block;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .navbar ul li a {\r\n");
      out.write("            text-decoration: none;\r\n");
      out.write("            color: #ffffff;\r\n");
      out.write("            font-weight: 500;\r\n");
      out.write("            transition: color 0.3s ease;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .navbar ul li a:hover {\r\n");
      out.write("            color: #009acd;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* Authentication Buttons */\r\n");
      out.write("        .auth-buttons {\r\n");
      out.write("            display: flex;\r\n");
      out.write("            gap: 10px;\r\n");
      out.write("            position: absolute;  /* Positions the buttons relative to the page */\r\n");
      out.write("            top: 20px;           /* Adjust as needed */\r\n");
      out.write("            right: 20px;         /* Aligns buttons to the right */\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .btn-login, .btn-signup {\r\n");
      out.write("            padding: 10px 20px;\r\n");
      out.write("            border-radius: 5px;\r\n");
      out.write("            text-decoration: none;\r\n");
      out.write("            font-weight: 500;\r\n");
      out.write("            transition: background-color 0.3s ease, color 0.3s ease;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .btn-login {\r\n");
      out.write("            color: #ffffff;\r\n");
      out.write("            border: 1px solid #009acd;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .btn-login:hover {\r\n");
      out.write("            background-color: #009acd;\r\n");
      out.write("            color: #121212;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .btn-signup {\r\n");
      out.write("            background-color: #009acd;\r\n");
      out.write("            color: #121212;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .btn-signup:hover {\r\n");
      out.write("            background-color: #0077a3;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* About Us Section */\r\n");
      out.write("        .about-us {\r\n");
      out.write("            padding: 80px 0;\r\n");
      out.write("            text-align: center;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .section-title {\r\n");
      out.write("            font-size: 2.5rem;\r\n");
      out.write("            margin-bottom: 20px;\r\n");
      out.write("            color: #00bfff; /* Neon blue color */\r\n");
      out.write("            text-shadow: 0 0 10px #00bfff, 0 0 20px #00bfff; /* Neon glow effect */\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .section-description {\r\n");
      out.write("            font-size: 1.2rem;\r\n");
      out.write("            max-width: 800px;\r\n");
      out.write("            margin: 0 auto 40px;\r\n");
      out.write("            color: #a0aec0; /* Light gray for contrast */\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* Features Grid */\r\n");
      out.write("        .features {\r\n");
      out.write("            display: grid;\r\n");
      out.write("            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));\r\n");
      out.write("            gap: 30px;\r\n");
      out.write("            margin-top: 40px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .feature-item {\r\n");
      out.write("            background: rgba(0, 191, 255, 0.1); /* Semi-transparent neon blue background */\r\n");
      out.write("            padding: 20px;\r\n");
      out.write("            border-radius: 10px;\r\n");
      out.write("            border: 1px solid #00bfff; /* Neon blue border */\r\n");
      out.write("            box-shadow: 0 0 10px rgba(0, 191, 255, 0.5); /* Neon glow */\r\n");
      out.write("            transition: transform 0.3s ease, box-shadow 0.3s ease;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .feature-item:hover {\r\n");
      out.write("            transform: translateY(-10px);\r\n");
      out.write("            box-shadow: 0 0 20px rgba(0, 191, 255, 0.8); /* Stronger glow on hover */\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .feature-title {\r\n");
      out.write("            font-size: 1.5rem;\r\n");
      out.write("            margin-bottom: 10px;\r\n");
      out.write("            color: #00bfff; /* Neon blue color */\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .feature-description {\r\n");
      out.write("            font-size: 1rem;\r\n");
      out.write("            color: #a0aec0; /* Light gray for contrast */\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* Responsive Design */\r\n");
      out.write("        @media (max-width: 768px) {\r\n");
      out.write("            .navbar ul {\r\n");
      out.write("                flex-direction: column;\r\n");
      out.write("                gap: 10px;\r\n");
      out.write("                text-align: center;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            .auth-buttons {\r\n");
      out.write("                flex-direction: column;\r\n");
      out.write("                gap: 10px;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            .features {\r\n");
      out.write("                grid-template-columns: 1fr; /* Stack features in one column on small screens */\r\n");
      out.write("            }\r\n");
      out.write("        }\r\n");
      out.write("    </style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<!-- Header Section -->\r\n");
      out.write("<header class=\"header\">\r\n");
      out.write("    <div class=\"container\">\r\n");
      out.write("        <div class=\"logo\">\r\n");
      out.write("            <img src=\"./images/favicon-32x32.png\" alt=\"NexoraSkill Logo\">\r\n");
      out.write("        </div>\r\n");
      out.write("        <!-- Navigation Menu -->\r\n");
      out.write("        <nav class=\"navbar\">\r\n");
      out.write("            <ul>\r\n");
      out.write("                <li><a href=\"index.jsp\">Home</a></li>\r\n");
      out.write("                <li><a href=\"courses.jsp\">Courses</a></li>\r\n");
      out.write("                <li><a href=\"registration.jsp\">Registration</a></li>\r\n");
      out.write("                <li><a href=\"aboutus.jsp\" class=\"active\">About Us</a></li>\r\n");
      out.write("                <li><a href=\"contact.jsp\">Contact</a></li>\r\n");
      out.write("            </ul>\r\n");
      out.write("        </nav>\r\n");
      out.write("\r\n");
      out.write("        <!-- Authentication Buttons -->\r\n");
      out.write("        <div class=\"auth-buttons\">\r\n");
      out.write("            <a href=\"logIn.jsp\" class=\"btn-login\">Login</a>\r\n");
      out.write("            <a href=\"signUp.jsp\" class=\"btn-signup\">Sign Up</a>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</header>\r\n");
      out.write("\r\n");
      out.write("<!-- About Us Section -->\r\n");
      out.write("<section class=\"about-us\">\r\n");
      out.write("    <div class=\"container\">\r\n");
      out.write("        <h2 class=\"section-title\">About Us</h2>\r\n");
      out.write("        <p class=\"section-description\">\r\n");
      out.write("            We are a leading platform for student course registration, dedicated to helping students achieve their academic goals. Our mission is to provide a seamless and intuitive experience for course selection, registration, and progress tracking.\r\n");
      out.write("        </p>\r\n");
      out.write("        <div class=\"features\">\r\n");
      out.write("            <div class=\"feature-item\">\r\n");
      out.write("                <h3 class=\"feature-title\">Easy Registration</h3>\r\n");
      out.write("                <p class=\"feature-description\">\r\n");
      out.write("                    Our system ensures a hassle-free course registration process for all students.\r\n");
      out.write("                </p>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"feature-item\">\r\n");
      out.write("                <h3 class=\"feature-title\">Wide Range of Courses</h3>\r\n");
      out.write("                <p class=\"feature-description\">\r\n");
      out.write("                    Choose from hundreds of courses across various disciplines to suit your interests.\r\n");
      out.write("                </p>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"feature-item\">\r\n");
      out.write("                <h3 class=\"feature-title\">24/7 Support</h3>\r\n");
      out.write("                <p class=\"feature-description\">\r\n");
      out.write("                    Our dedicated support team is always available to assist you with any queries.\r\n");
      out.write("                </p>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</section>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof jakarta.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
