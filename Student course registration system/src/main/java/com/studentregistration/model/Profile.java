package com.studentregistration.model;

public class Profile {
    private String studentId;
    private String name;
    private String nemail;
    private String dob;
    private String gender;
    private String phone;
    private String address;
    private String degree;
    private String enrolled;
    private String gpa;
    private String passwordStatus;
    private String twoFAStatus;
    private String imagePath;

    // Default Constructor
    public Profile() {
        this.studentId = "";
        this.name = "";
        this.nemail = "";
        this.dob = "";
        this.gender = "";
        this.phone = "";
        this.address = "";
        this.degree = "";
        this.enrolled = "";
        this.gpa = "";
        this.passwordStatus = "••••••••";
        this.twoFAStatus = "Not Enabled";
        this.imagePath = "https://via.placeholder.com/150";
    }

    // Constructor with all fields
    public Profile(String studentId, String name, String email, String dob, String gender, String phone, String address, String degree, String enrolled, String gpa, String passwordStatus, String twoFAStatus, String imagePath) {
        this.studentId = studentId != null ? studentId : "";
        this.name = name != null ? name : "";
        this.nemail = email != null ? email : "";
        this.dob = dob != null ? dob : "";
        this.gender = gender != null ? gender : "";
        this.phone = phone != null ? phone : "";
        this.address = address != null ? address : "";
        this.degree = degree != null ? degree : "";
        this.enrolled = enrolled != null ? enrolled : "";
        this.gpa = gpa != null ? gpa : "";
        this.passwordStatus = passwordStatus != null ? passwordStatus : "••••••••";
        this.twoFAStatus = twoFAStatus != null ? twoFAStatus : "Not Enabled";
        this.imagePath = imagePath != null ? imagePath : "https://via.placeholder.com/150";
    }

    // Getters and Setters
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId != null ? studentId : ""; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name != null ? name : ""; }

    public String getEmail() { return nemail; }
    public void setEmail(String email) { this.nemail = email != null ? email : ""; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob != null ? dob : ""; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender != null ? gender : ""; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone != null ? phone : ""; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address != null ? address : ""; }

    public String getDegree() { return degree; }
    public void setDegree(String degree) { this.degree = degree != null ? degree : ""; }

    public String getEnrolled() { return enrolled; }
    public void setEnrolled(String enrolled) { this.enrolled = enrolled != null ? enrolled : ""; }

    public String getGpa() { return gpa; }
    public void setGpa(String gpa) { this.gpa = gpa != null ? gpa : ""; }

    public String getPasswordStatus() { return passwordStatus; }
    public void setPasswordStatus(String passwordStatus) { this.passwordStatus = passwordStatus != null ? passwordStatus : "••••••••"; }

    public String getTwoFAStatus() { return twoFAStatus; }
    public void setTwoFAStatus(String twoFAStatus) { this.twoFAStatus = twoFAStatus != null ? twoFAStatus : "Not Enabled"; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath != null ? imagePath : "https://via.placeholder.com/150"; }

    // Convert to CSV string for file storage
    public String toCsvString() {
        return String.join(",",
                studentId, name, nemail, dob, gender, phone, address, degree, enrolled, gpa, passwordStatus, twoFAStatus, imagePath);
    }

    // Create Profile from CSV string
    public static Profile fromCsvString(String csvLine) {
        String[] parts = csvLine.split(",", -1); // -1 to include empty trailing fields
        if (parts.length >= 13) {
            return new Profile(
                    parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6],
                    parts[7], parts[8], parts[9], parts[10], parts[11], parts[12]
            );
        }
        return new Profile();
    }
}