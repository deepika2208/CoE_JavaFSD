package TechM;

import java.sql.*;
import java.util.Scanner;

public class FeeReportSystem {
    private static final String URL = "jdbc:mysql://localhost:3306/feereportsoftware";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static Connection con;

    public static void main(String[] args) {
        try {
            con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Scanner scanner = new Scanner(System.in);
           
            while (true) {
                System.out.println("\nFee Report System");
                System.out.println("1. Login as Admin");
                System.out.println("2. Exit");
                System.out.print("Enter choice: ");
                int choice = scanner.nextInt();
                scanner.nextLine();

                if (choice == 1) {
                    System.out.print("Enter username: ");
                    String username = scanner.next();
                    System.out.print("Enter password: ");
                    String password = scanner.next();
                    if (authenticateAdmin(username, password)) {
                        System.out.println("Login Successful!");
                        showAdminMenu(scanner);
                    } else {
                        System.out.println("Invalid credentials");
                    }
                } else if (choice == 2) {
                    System.out.println("Exiting");
                    break;
                } else {
                    System.out.println("Invalid choice");
                }
            }
            scanner.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static boolean authenticateAdmin(String username, String password) throws SQLException {
        String query = "SELECT 1 FROM admin WHERE username = ? AND password = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }

    private static void showAdminMenu(Scanner scanner) throws SQLException {
        while (true) {
            System.out.println("\nAdmin Menu");
            System.out.println("1. Add Accountant");
            System.out.println("2. View All Accountants");
            System.out.println("3. Manage Student Records");
            System.out.println("4. Logout");
            System.out.print("Enter choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            if (choice == 1) {
                addNewAccountant(scanner);
            } else if (choice == 2) {
                listAllAccountants();
            } else if (choice == 3) {
                manageStudentRecords(scanner);
            } else if (choice == 4) {
                System.out.println("Logging out");
                break;
            } else {
                System.out.println("Invalid choice! Try again.");
            }
        }
    }

    private static void addNewAccountant(Scanner scanner) throws SQLException {
        System.out.print("Enter Name: ");
        String name = scanner.nextLine();
        System.out.print("Enter Email: ");
        String email = scanner.next();
        System.out.print("Enter Phone: ");
        String phone = scanner.next();
        System.out.print("Enter Password: ");
        String password = scanner.next();

        String query = "INSERT INTO accountant(name, email, phone, password) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, password);
        int result = ps.executeUpdate();

        if (result > 0) {
            System.out.println("Accountant added successfully!");
        } else {
            System.out.println("Error adding accountant.");
        }
    }

    private static void listAllAccountants() throws SQLException {
        String query = "SELECT id, name, email, phone FROM accountant";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        System.out.println("\nList of Accountants:");
        while (rs.next()) {
            System.out.println("ID= " + rs.getInt("id") + ", Name= " + rs.getString("name") +
                    ", Email= " + rs.getString("email") + ", Phone= " + rs.getString("phone"));
        }
    }

    private static void manageStudentRecords(Scanner scanner) throws SQLException {
        while (true) {
            System.out.println("\nStudent Management");
            System.out.println("1. Add New Student");
            System.out.println("2. View All Students");
            System.out.println("3. View Students with Pending Fees");
            System.out.println("4. Back to Admin Menu");
            System.out.print("Enter choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            if (choice == 1) {
                registerNewStudent(scanner);
            } else if (choice == 2) {
                listAllStudents();
            } else if (choice == 3) {
                viewPendingFees();
            } else if (choice == 4) {
                break;
            } else {
                System.out.println("Invalid choice! Try again.");
            }
        }
    }

    private static void registerNewStudent(Scanner scanner) throws SQLException {
        System.out.print("Enter Name: ");
        String name = scanner.nextLine();
        System.out.print("Enter Email: ");
        String email = scanner.next();
        System.out.print("Enter Course: ");
        String course = scanner.next();
        System.out.print("Enter Total Fee: ");
        double fee = scanner.nextDouble();
        System.out.print("Enter Paid Fee: ");
        double paid = scanner.nextDouble();
        double due = fee - paid;
        scanner.nextLine();
        System.out.print("Enter Address: ");
        String address = scanner.nextLine();
        System.out.print("Enter Phone: ");
        String phone = scanner.next();

        String query = "INSERT INTO student(name, email, course, fee, paid, due, address, phone) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, course);
        ps.setDouble(4, fee);
        ps.setDouble(5, paid);
        ps.setDouble(6, due);
        ps.setString(7, address);
        ps.setString(8, phone);

        int result = ps.executeUpdate();
        if (result > 0) {
            System.out.println("Student added successfully!");
        } else {
            System.out.println("Error adding student.");
        }
    }

    private static void listAllStudents() throws SQLException {
        String query = "SELECT * FROM student";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        System.out.println("\nList of Students:");
        while (rs.next()) {
            System.out.println("ID= " + rs.getInt("id") + ", Name= " + rs.getString("name") +
                    ", Email= " + rs.getString("email") + ", Course= " + rs.getString("course") +
                    ", Fee= " + rs.getDouble("fee") + ", Paid= " + rs.getDouble("paid") +
                    ", Due= " + rs.getDouble("due") + ", Address= " + rs.getString("address") +
                    ", Phone= " + rs.getString("phone"));
        }
    }

    private static void viewPendingFees() throws SQLException {
        String query = "SELECT id, name, due FROM student WHERE due > 0";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        System.out.println("\nStudents with Pending Fees:");
        while (rs.next()) {
            System.out.println("ID= " + rs.getInt("id") + ", Name= " + rs.getString("name") +
                    ", Due Fee= " + rs.getDouble("due"));
        }
    }
}
