package ss16_io_text_file.exercise.exercise3.controler;

import ss16_io_text_file.exercise.exercise3.service.impl_teacher.ITeacherService;
import ss16_io_text_file.exercise.exercise3.service.impl_teacher.TeacherService;
import ss16_io_text_file.exercise.exercise3.utils.exception.PersonException;

import java.io.IOException;
import java.util.Scanner;

public class TeacherController {
    private static ITeacherService iTeacherService = new TeacherService();
    private static Scanner scanner = new Scanner(System.in);

    public static void menuTeacher() throws IOException, PersonException {
        while (true) {
            System.out.println("---------------------------------------------------");
            System.out.println("Chào mừng bạn đến với chương trình quản lý CodyGym.");
            System.out.println("1. Thêm mới giáo viên.");
            System.out.println("2. Hiển thị danh sách giáo viên. ");
            System.out.println("3. Xóa giáo viên. ");
            System.out.println("4. Quay lại Menu. ");
            System.out.println("5. Tìm kiếm. ");
            System.out.println("6. Thoát. ");
            int choice = Integer.parseInt(scanner.nextLine());
            switch (choice) {
                case 1:
                    iTeacherService.addTeacher();
                    break;
                case 2:
                    iTeacherService.displayTeacher();
                    break;
                case 3:
                    iTeacherService.removeTeacher();
                    break;
                case 4:
                    PersonController.menuPerson();
                    break;
                case 5:
                    iTeacherService.searchTeacher();
                    break;
                case 6:
                    System.exit(0);
                default:
                    System.out.println("Bạn nhập sai rồi! Vui lòng nhập lại!");
            }
        }
    }
}

