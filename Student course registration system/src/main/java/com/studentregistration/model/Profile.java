package main.java.com.studentregistration.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

public class Profile implements Serializable {
    private static final long serialVersionUID = 1L;

    private String studentId;
    private String displayName;
    private String email;
    private LocalDate dob;
    private String gender;
    private String phone;
    private String address;
    private String degree;
    private LocalDate enrolledDate;
    private double gpa;
    private boolean twoFactorEnabled;

    // Constructors
    public Profile() {
        // Initialize default values if needed
        this.gpa = 0.0;
        this.twoFactorEnabled = false;
    }

    public Profile(String studentId, String displayName, String email) {
        this(); // Call default constructor to initialize defaults
        setStudentId(studentId);
        setDisplayName(displayName);
        setEmail(email);
    }

    // Serialization method for file storage
    public String serialize() {
        return String.join("|",
                Objects.requireNonNull(studentId, "Student ID cannot be null"),
                Objects.requireNonNull(displayName, "Display name cannot be null"),
                Objects.requireNonNull(email, "Email cannot be null"),
                dob != null ? dob.toString() : "",
                gender != null ? gender : "",
                phone != null ? phone : "",
                address != null ? address : "",
                degree != null ? degree : "",
                enrolledDate != null ? enrolledDate.toString() : "",
                Double.toString(gpa),
                Boolean.toString(twoFactorEnabled)
        );
    }

    // Deserialization method for file reading
    public static Profile deserialize(String data) {
        if (data == null || data.trim().isEmpty()) {
            throw new IllegalArgumentException("Profile data cannot be null or empty");
        }

        String[] parts = data.split("\\|", -1); // -1 to keep trailing empty strings

        if (parts.length != 11) {
            throw new IllegalArgumentException("Invalid profile data format. Expected 11 parts but got " + parts.length);
        }

        Profile profile = new Profile(parts[0], parts[1], parts[2]);

        try {
            if (!parts[3].isEmpty()) profile.setDob(LocalDate.parse(parts[3]));
            if (!parts[4].isEmpty()) profile.setGender(parts[4]);
            if (!parts[5].isEmpty()) profile.setPhone(parts[5]);
            if (!parts[6].isEmpty()) profile.setAddress(parts[6]);
            if (!parts[7].isEmpty()) profile.setDegree(parts[7]);
            if (!parts[8].isEmpty()) profile.setEnrolledDate(LocalDate.parse(parts[8]));
            if (!parts[9].isEmpty()) profile.setGpa(Double.parseDouble(parts[9]));
            profile.setTwoFactorEnabled(Boolean.parseBoolean(parts[10]));
        } catch (Exception e) {
            throw new IllegalArgumentException("Error parsing profile data", e);
        }

        return profile;
    }

    // Getters and Setters
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) {
        this.studentId = Objects.requireNonNull(studentId, "Student ID cannot be null");
    }

    public String getDisplayName() { return displayName; }
    public void setDisplayName(String displayName) {
        this.displayName = Objects.requireNonNull(displayName, "Display name cannot be null");
    }

    public String getEmail() { return email; }
    public void setEmail(String email) {
        this.email = Objects.requireNonNull(email, "Email cannot be null");
    }

    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getDegree() { return degree; }
    public void setDegree(String degree) { this.degree = degree; }

    public LocalDate getEnrolledDate() { return enrolledDate; }
    public void setEnrolledDate(LocalDate enrolledDate) { this.enrolledDate = enrolledDate; }

    public double getGpa() { return gpa; }
    public void setGpa(double gpa) {
        if (gpa < 0.0 || gpa > 4.0) {
            throw new IllegalArgumentException("GPA must be between 0.0 and 4.0");
        }
        this.gpa = gpa;
    }

    public boolean isTwoFactorEnabled() { return twoFactorEnabled; }
    public void setTwoFactorEnabled(boolean twoFactorEnabled) {
        this.twoFactorEnabled = twoFactorEnabled;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Profile profile = (Profile) o;
        return Double.compare(profile.gpa, gpa) == 0 &&
                twoFactorEnabled == profile.twoFactorEnabled &&
                Objects.equals(studentId, profile.studentId) &&
                Objects.equals(displayName, profile.displayName) &&
                Objects.equals(email, profile.email) &&
                Objects.equals(dob, profile.dob) &&
                Objects.equals(gender, profile.gender) &&
                Objects.equals(phone, profile.phone) &&
                Objects.equals(address, profile.address) &&
                Objects.equals(degree, profile.degree) &&
                Objects.equals(enrolledDate, profile.enrolledDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(studentId, displayName, email, dob, gender, phone, address,
                degree, enrolledDate, gpa, twoFactorEnabled);
    }

    @Override
    public String toString() {
        return "Profile{" +
                "studentId='" + studentId + '\'' +
                ", displayName='" + displayName + '\'' +
                ", email='" + email + '\'' +
                ", dob=" + dob +
                ", gender='" + gender + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", degree='" + degree + '\'' +
                ", enrolledDate=" + enrolledDate +
                ", gpa=" + gpa +
                ", twoFactorEnabled=" + twoFactorEnabled +
                '}';
    }
}