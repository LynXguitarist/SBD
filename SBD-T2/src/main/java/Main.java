import java.sql.*;

public class Main {

    private static Connection conn;

    public static void main(String[] args) {
        try {
            connect();

            System.out.println("Exec 1: ");
            exec1();

            System.out.println("Exec 2: ");
            exec2(10);

            System.out.println("Exec 3: ");
            exec3("", "");

            conn.close();
        } catch (SQLException e) {
            System.out.println("Exception: ");
            e.getStackTrace();
        }
    }

    private static void connect() throws SQLException {
        System.out.println("Connecting...");
        //load the driver
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        //Create connection
        conn = DriverManager.getConnection("jdbc:oracle:thin:@10.170.138.40:1521:orclE", "sbd42764", "42765");
    }

    private static void exec1() throws SQLException {
        PreparedStatement query = conn.prepareStatement("SELECT * FROM alunos");
        ResultSet rs = query.executeQuery(); //ResultSet is a Cursor

        while (rs.next()) { //In the beginning, points to before the first row
            PreparedStatement courseQuery = conn.prepareStatement("SELECT * FROM cursos WHERE cursos.cod_curso = ?");
            courseQuery.setRowId(1, rs.getRowId("cod_curso"));
            ResultSet course_rs = courseQuery.executeQuery(); //ResultSet is a Cursor

            String name = rs.getString("nome"); //get by column label
            String sex = rs.getString("sexo");
            String courseName = course_rs.getString("nome");

            if (sex.equals("F"))
                System.out.println(name + " está inscrita em " + courseName);
            else
                System.out.println(name + " está inscrito em " + courseName);

            courseQuery.close();
            course_rs.close();
        }

        rs.close();
        query.close();
    }

    private static void exec2(int N) throws SQLException {
        PreparedStatement query = conn.prepareStatement("SELECT DISTINCT cod_cadeira, COUNT(*) FROM alunos " +
                "INNER JOIN inscricoes ON alunos.num_aluno = inscricoes.num_aluno WHERE row_num = ?");
        query.setInt(1, N);
        ResultSet rs = query.executeQuery(); //ResultSet is a Cursor

        while (rs.next()) { //In the beginning, points to before the first row
            RowId num_aluno = rs.getRowId("num_aluno");
            System.out.println(num_aluno);
        }

        rs.close();
        query.close();
    }

    private static void exec3(String studentName, String subjectName) throws SQLException {
        PreparedStatement studentQuery = conn.prepareStatement("SELECT * FROM alunos WHERE alunos.nome LIKE ? || '%'");
        studentQuery.setString(1, studentName);
        ResultSet studentRs = studentQuery.executeQuery(); //ResultSet is a Cursor

        PreparedStatement subjectQuery = conn.prepareStatement("SELECT * FROM alunos WHERE alunos.nome LIKE ? || '%'");
        subjectQuery.setString(1, subjectName);
        ResultSet subjectRs = subjectQuery.executeQuery(); //ResultSet is a Cursor

        if (!studentRs.isBeforeFirst())
            throw new SQLException("Nome de aluno não existe");

        if (!subjectRs.isBeforeFirst())
            throw new SQLException("Nome da cadeira não existe");

        while (studentRs.next()) { //In the beginning, points to before the first row
            RowId studentId = studentRs.getRowId("num_aluno");

            while(subjectRs.next()) {
                RowId courseId = subjectRs.getRowId("cod_curso");
                RowId subjectId = subjectRs.getRowId("cod_cadeira");

                PreparedStatement create = conn.prepareStatement("Insert into inscricoes values (" +
                        "SEQ_INSCRICOES.nextval, ?, ?, ?, CURRENT_DATE, null, null)");
                create.setRowId(1, studentId);
                create.setRowId(2, courseId);
                create.setRowId(3, subjectId);

                create.executeUpdate();
            }
        }

        studentRs.close();
        subjectRs.close();
        studentQuery.close();
        subjectQuery.close();
    }

}
