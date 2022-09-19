package ss0_exercise.mvc.controler;

import ss0_exercise.mvc.service.impl_student.IStudentService;
import ss0_exercise.mvc.service.impl_student.StudentService;

import java.util.Scanner;

public class StudentController {
    private static IStudentService iStudentService = new StudentService();
    private static Scanner scanner = new Scanner(System.in);

    public static void menuStudent() {
        while (true) {
            System.out.println("----------------------------------------------------");
            System.out.println("Chào mừng bạn đến với chương trình quản lý CodyGym. ");
            System.out.println("1. Thêm mới học sinh.");
            System.out.println("2. Hiển thị danh sách học sinh. ");
            System.out.println("3. Xóa học sinh. ");
            System.out.println("4. Quay lại Menu. ");
            System.out.println("5. Thoát. ");
            int choice = Integer.parseInt(scanner.nextLine());
            switch (choice) {
                case 1:
                    iStudentService.addStudent();
                    break;
                case 2:
                    iStudentService.displayAllStudent();
                    break;
                case 3:
                    iStudentService.removeStudent();
                    break;
                case 4:
                    PersonController.menuPerson();
                    break;
                case 5:
                    System.exit(0);
                default:
                    System.out.println("Bạn đã nhập sai!Vui lòng nhập đúng!");
            }
        }
    }
}