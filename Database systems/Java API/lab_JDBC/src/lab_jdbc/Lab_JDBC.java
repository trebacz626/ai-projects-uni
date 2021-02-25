/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lab_jdbc;

import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kacper
 */
public class Lab_JDBC {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Connection conn = null;
        String connectionString
                = "jdbc:oracle:thin:@//admlab2.cs.put.poznan.pl:1521/dblab02_students.cs.pu\n"
                + "t.poznan.pl";
        Properties connectionProps = new Properties();
        connectionProps.put("user", "ai145453");
        connectionProps.put("password", "ai145453");
        try {
            conn = DriverManager.getConnection(connectionString,
                    connectionProps);
            System.out.println("Connected to the database");
        } catch (SQLException ex) {
            Logger.getLogger(Lab_JDBC.class.getName()).log(Level.SEVERE,
                    "Failed to connect to the database", ex);
            System.exit(-1);
        }

        try {
            procedure1(conn);
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Lab_JDBC.class.getName()).log(Level.SEVERE, null, ex);
        }

        System.out.println("Database disconnected");
    }

    static void padding(Connection conn) {
        try ( Statement stmt = conn.createStatement();  ResultSet rs = stmt.executeQuery(
                "select emp_id, surname, LPAD(surname, 12, '*') salary "
                + "from employees ");) {
            while (rs.next()) {
                System.out.println(rs.getInt(1) + " " + rs.getString(2) + " "
                        + rs.getFloat(3));
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void task1(Connection conn) {
        count_all_emplyees(conn);
        count_employees_departments(conn);
    }

    static void count_all_emplyees(Connection conn) {
        try ( Statement stmt = conn.createStatement();  ResultSet rs = stmt.executeQuery(
                "SELECT COUNT(*) FROM EMPLOYEES");) {
            while (rs.next()) {
                System.out.println("There are " + rs.getInt(1) + " employees:");
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void count_employees_departments(Connection conn) {
        try ( Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);  ResultSet rs = stmt.executeQuery(
                "SELECT COUNT(emp_id), dept_name FROM EMPLOYEES inner join departments using(dept_id) group by dept_name");) {
            while (rs.next()) {
                System.out.println("There are " + rs.getInt(1) + " in " + rs.getString(2));
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void task2(Connection conn) {
        select_assistants(conn);
    }

    static void select_assistants(Connection conn) {
        try ( Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);  ResultSet rs = stmt.executeQuery(
                "SELECT name, surname, salary from employees where job='ASSISTANT' ORDER BY SALARY DESC");) {
            rs.last();
            System.out.println(rs.getString(1) + rs.getString(2) + "earns: " + rs.getInt(3));
            rs.relative(-2);
            System.out.println(rs.getString(1) + rs.getString(2) + "earns: " + rs.getInt(3));
            rs.relative(1);
            System.out.println(rs.getString(1) + rs.getString(2) + "earns: " + rs.getInt(3));
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void updates(Connection conn) {
        try ( Statement stmt = conn.createStatement()) {
            int changes;
            changes = stmt.executeUpdate("INSERT INTO employees(emp_id, surname) "
                    + "VALUES(5,'Conerby')");
            System.out.println(changes + " row(s) inserted.");
            changes = stmt.executeUpdate("UPDATE employees SET "
                    + "salary=salary*1.5");
            System.out.println(changes + " row(s) updated.");
            changes = stmt.executeUpdate("DELETE FROM employees WHERE emp_id=5");
            System.out.println(changes + " row(s) deleted.");
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void task3(Connection conn) {
        int[] dismissals = {150, 200, 230};
        String[] newEmployees = {"Candafe", "Rumalle", "Bouchar"};
        try ( Statement stmt = conn.createStatement()) {
            for (int id : dismissals) {
                stmt.executeUpdate("DELETE FROM employees WHERE emp_id=" + id);
            }
            for (String name : newEmployees) {
                stmt.executeUpdate("INSERT INTO employees(emp_id, surname) "
                        + "VALUES((select max(emp_id)+1 from employees),'" + name + "')");
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void nocommit(Connection conn) throws SQLException {
        conn.setAutoCommit(false);
        try ( Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("INSERT INTO employees(emp_id, surname)"
                    + "VALUES(200, 'Bentworth')");
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void task4(Connection conn) throws SQLException {
        conn.setAutoCommit(false);
        all_jobs(conn);
        new_job(conn, "Job1");
        all_jobs(conn);
        conn.rollback();
        all_jobs(conn);
        new_job(conn, "Job2");
        conn.commit();
        all_jobs(conn);
    }

    static void all_jobs(Connection conn) {
        try ( Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);  ResultSet rs = stmt.executeQuery(
                "SELECT name FROM jobs");) {
            System.out.println("All jobs: ");
            while (rs.next()) {
                System.out.println(rs.getString(1));
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void new_job(Connection conn, String jobName) throws SQLException {
        conn.setAutoCommit(false);
        try ( Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("INSERT INTO jobs(name) "
                    + "VALUES('" + jobName + "')");
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void prepared(Connection conn) {
        try ( PreparedStatement pstmt = conn.prepareStatement("SELECT surname FROM employees WHERE emp_id=?");) {
            ResultSet rs;
            pstmt.setInt(1, 120);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString(1));
            }
            rs.close();
            pstmt.setInt(1, 130);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString(1));
            }
            rs.close();
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void task5(Connection conn) {
        String[] surnames = {"Wozniak", "Wilbergton", "Bridgerman"};
        int[] salaries = {1300, 1700, 1500};
        String[] jobs = {"ASSISTANT", "PROFESSOR", "LECTURER"};
        try ( PreparedStatement pstmt = conn.prepareStatement("INSERT INTO employees(emp_id, surname, salary, job)"
                + "VALUES((select max(emp_id)+1 from employees), ?, ?, ?)");) {
            for (int i = 0; i < surnames.length; i++) {
                pstmt.setString(1, surnames[i]);
                pstmt.setInt(2, salaries[i]);
                pstmt.setString(3, jobs[i]);
                pstmt.executeQuery();
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }
//    One by one execution time: 80237135340
//    Batch execution time: 128610641

    static void task6(Connection conn) throws SQLException {
        long startTime, executionTime;
        conn.setAutoCommit(false);
        startTime = System.nanoTime();
        task6OneByOne(conn);
        executionTime = System.nanoTime() - startTime;
        System.out.println("One by one execution time: " + executionTime);
        conn.rollback();
        conn.setAutoCommit(false);
        startTime = System.nanoTime();
        task6Batch(conn);
        executionTime = System.nanoTime() - startTime;
        System.out.println("Batch execution time: " + executionTime);
        conn.rollback();
    }

    static void task6OneByOne(Connection conn) {
        try ( PreparedStatement pstmt = conn.prepareStatement("INSERT INTO employees(emp_id, surname)"
                + "VALUES(?, ?)");) {
            for (int i = 0; i < 2000; i++) {
                pstmt.setInt(1, i + 1000);
                pstmt.setString(2, "Temp");
                pstmt.executeQuery();
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    static void task6Batch(Connection conn) {
        try ( PreparedStatement pstmt = conn.prepareStatement("INSERT INTO employees(emp_id, surname)"
                + "VALUES(?, ?)");) {
            for (int i = 0; i < 2000; i++) {
                pstmt.setInt(1, i + 1000);
                pstmt.setString(2, "Temp");
                pstmt.addBatch();
            }
            pstmt.executeBatch();
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

//DROP PROCEDURE InsertDepartment;
//
//
//CREATE PROCEDURE InsertDepartment (newid number, newName varchar, newAddress varchar) AS
//   BEGIN
//      INSERT INTO DEPARTMENTS(DEPT_ID, DEPT_NAME, ADDRESS) VALUES (newid, newName, newAddress);
//   END;
    static void procedure1(Connection conn) {
        try ( CallableStatement stmt = conn.prepareCall("{call InsertDepartment(?,?,?)}");) {
            stmt.setInt(1, 60);
            stmt.setString(2, "NEW DEPARTMENT");
            stmt.setString(3, "LENSINGTON 3A");
            stmt.execute();
            stmt.close();
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }


}
