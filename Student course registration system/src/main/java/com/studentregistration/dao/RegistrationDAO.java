// In src/main/java/com/studentregistration/dao/RegistrationDAO.java

public class RegistrationDAO {
    private static final String REGISTRATIONS_FILE = "registrations.txt";
    private FileUtils fileUtils;

    public RegistrationDAO() {
        this.fileUtils = new FileUtils();
    }

    // Register a student for a course
    public boolean registerStudentForCourse(Registration registration) {
        try {
            // Check if already registered
            List<Registration> allRegistrations = getAllRegistrations();
            boolean alreadyRegistered = allRegistrations.stream()
                    .anyMatch(r -> r.getStudentId().equals(registration.getStudentId())
                            && r.getCourseId().equals(registration.getCourseId()));

            if (alreadyRegistered) {
                return false;
            }

            // Append new registration to file
            String registrationData = String.format("%s,%s,%s%n",
                    registration.getStudentId(),
                    registration.getCourseId(),
                    registration.getRegistrationDate());

            return fileUtils.appendToFile(REGISTRATIONS_FILE, registrationData);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all courses registered by a student
    public List<Course> getRegisteredCourses(String studentId) {
        List<Course> registeredCourses = new ArrayList<>();
        CourseDAO courseDAO = new CourseDAO();

        try {
            List<Registration> allRegistrations = getAllRegistrations();
            for (Registration reg : allRegistrations) {
                if (reg.getStudentId().equals(studentId)) {
                    Course course = courseDAO.getCourseById(reg.getCourseId());
                    if (course != null) {
                        registeredCourses.add(course);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return registeredCourses;
    }

    // Drop a course for a student
    public boolean dropCourse(String studentId, String courseId) {
        try {
            List<Registration> allRegistrations = getAllRegistrations();
            List<Registration> updatedRegistrations = new ArrayList<>();

            boolean found = false;
            for (Registration reg : allRegistrations) {
                if (!(reg.getStudentId().equals(studentId) && reg.getCourseId().equals(courseId))) {
                    updatedRegistrations.add(reg);
                } else {
                    found = true;
                }
            }

            if (found) {
                // Rewrite the file with updated registrations
                List<String> registrationLines = new ArrayList<>();
                for (Registration reg : updatedRegistrations) {
                    registrationLines.add(String.format("%s,%s,%s",
                            reg.getStudentId(),
                            reg.getCourseId(),
                            reg.getRegistrationDate()));
                }
                return fileUtils.writeLinesToFile(REGISTRATIONS_FILE, registrationLines);
            }
            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to get all registrations
    private List<Registration> getAllRegistrations() throws IOException {
        List<String> lines = fileUtils.readLinesFromFile(REGISTRATIONS_FILE);
        List<Registration> registrations = new ArrayList<>();

        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length >= 3) {
                registrations.add(new Registration(
                        parts[0].trim(),  // studentId
                        parts[1].trim(),  // courseId
                        parts[2].trim()   // registrationDate
                ));
            }
        }

        return registrations;
    }
}
