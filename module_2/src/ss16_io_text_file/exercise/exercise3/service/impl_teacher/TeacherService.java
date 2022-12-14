package ss16_io_text_file.exercise.exercise3.service.impl_teacher;

import ss16_io_text_file.exercise.exercise3.model.Teacher;
import ss16_io_text_file.exercise.exercise3.utils.exception.PersonException;

import java.io.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class TeacherService implements ITeacherService {
    private static Scanner scanner = new Scanner(System.in);
    private static List<Teacher> teacherList = new ArrayList<>();
    @Override
    public void addTeacher() throws IOException {
        teacherList = getAllTeacher();
        Teacher teacher = infoTeacher();
        teacherList.add(teacher);
        System.out.println("Thêm mới thành công. ");
        writeTeacher();
    }



    @Override
    public void displayTeacher() {
        for (Teacher teacher : teacherList) {
            System.out.println(teacher);
        }
    }

    @Override
    public void removeTeacher() {
        System.out.println("Nhập mã giáo viên cần xóa: ");
        String code = scanner.nextLine();
        boolean flagDelete = false;
        for (int i = 0; i < teacherList.size(); i++) {
            if (teacherList.get(i).getCode().equals(code)) {
                System.out.println("Bạn muốn xóa giáo viên này không ? Nhập Y: yes, N: no ");
                String choice = scanner.nextLine();
                if (choice.equals("Y")) {
                    teacherList.remove(i);
                    System.out.println("Xóa thành công!");
                }
                flagDelete = true;
                break;
            }
        }
        if (!flagDelete) {
            System.out.println("Không tìm thấy giáo viên cần xóa!");
        }

    }

    @Override
    public void searchTeacher() {
        System.out.println("Nhập tên cần kiểm tra: ");
        Scanner scanner = new Scanner(System.in);
        String str = scanner.nextLine();
        for (Teacher teacher : teacherList) {
            if (teacher.getName().contains(str)) {
                System.out.println(teacher);
            }
        }
    }

    public Teacher infoTeacher() {
        String code;
        while (true) {
            try {
                System.out.println("Mời nhập mã giáo viên: ");
                code = scanner.nextLine();
                PersonException.codeCheck(code);
                break;
            } catch (PersonException e) {
                System.out.println(e.getMessage());
            }
        }
        String name;
        while (true) {
            try {
                System.out.println("Mời nhập tên giáo viên: ");
                name = scanner.nextLine();
                PersonException.nameCheck(name);
                break;
            } catch (PersonException e) {
                System.out.println(e.getMessage());
            }
        }


        String gender;
        while (true) {
            try {
                System.out.println("Mời nhập giới tính giáo viên: ");
                gender = scanner.nextLine();
                if (gender.equals("Nam")) {
                    gender = "Nam";
                } else if (gender.equals("Nữ")) {
                    gender = "Nữ";
                } else {
                    gender = "Phi giới tính";
                }
                PersonException.genderCheck(gender);
                break;
            } catch (PersonException e) {
                System.out.println("Nhập sai định dạng, nhập lại");
            }
        }
        LocalDate dateOfBirth;

        while (true) {
            try {
                System.out.println("Nhập ngày tháng năm sinh giáo viên: ");
                dateOfBirth = LocalDate.parse(scanner.nextLine(),DateTimeFormatter.ofPattern("dd/MM/yyyy"));
                PersonException.dateCheck(dateOfBirth);
                break;
            } catch (PersonException e) {
                System.out.println("Ngày sai định dạng, nhập lại.");
            }
        }

        System.out.println("Mời bạn nhập chuyên môn Giáo viên: ");
        String technique = scanner.nextLine();
        return new Teacher(code, name, gender, dateOfBirth, technique);
    }

    private List<Teacher> getAllTeacher() throws IOException {
        File file = new File("src\\ss16_io_text_file\\exercise\\exercise3\\data\\fileReadTeacher");
        FileReader fileReader = new FileReader(file);
        BufferedReader bufferedReader = new BufferedReader(fileReader);
        String line;
        List<Teacher> teacherList = new ArrayList<>();
        String[] info;
        Teacher teacher;
        while ((line = bufferedReader.readLine()) != null) {
            info = line.split(",");
            teacher = new Teacher(info[0], info[1], info[2], LocalDate.parse(info[3], DateTimeFormatter.ofPattern("dd/MM/yyyy")), info[4]);
            teacherList.add(teacher);
        }
        bufferedReader.close();
        return teacherList;
    }

    public void writeTeacher() throws IOException {
        File file1 = new File("src\\ss16_io_text_file\\exercise\\exercise3\\data\\fileReadTeacher");
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(file1));
        for (Teacher t : teacherList) {
            bufferedWriter.write(t.getInfo());
            bufferedWriter.newLine();
        }
        bufferedWriter.close();
    }
}

