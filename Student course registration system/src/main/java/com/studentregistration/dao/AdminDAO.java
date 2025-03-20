import java.io.*;
import java.util.ArrayList;
import java.util.List;

class Admin {
    private int id;
    private String username;
    private String password;

    public Admin(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
}

public class AdminDAO {
    private static final String FILE_PATH = "admin.txt";

    // Add an admin
    public void addAdmin(Admin admin) {
        try {
            FileWriter writer = new FileWriter(FILE_PATH, true);
            writer.write(admin.getId() + "," + admin.getUsername() + "," + admin.getPassword() + "\n");
            writer.close();
        } catch (IOException e) {
            System.out.println("Error writing to file.");
        }
    }

    // Get all admins
    public List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        try {
            FileReader reader = new FileReader(FILE_PATH);
            BufferedReader br = new BufferedReader(reader);
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                admins.add(new Admin(Integer.parseInt(data[0]), data[1], data[2]));
            }
            br.close();
        } catch (IOException e) {
            System.out.println("Error reading file.");
        }
        return admins;
    }

    public static void main(String[] args) {
        AdminDAO dao = new AdminDAO();

        // Adding an admin
        dao.addAdmin(new Admin(1, "admin1", "pass123"));

        // Reading admins
        List<Admin> admins = dao.getAllAdmins();
        for (Admin a : admins) {
            System.out.println(a.getId() + " " + a.getUsername() + " " + a.getPassword());
        }
    }
}
