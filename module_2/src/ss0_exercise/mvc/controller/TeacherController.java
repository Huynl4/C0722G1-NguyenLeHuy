package ss0_exercise.mvc.controller;

import ss0_exercise.mvc.service.implTeacher.ITeacherService;
import ss0_exercise.mvc.service.implTeacher.TeacherService;

import java.util.Scanner;

public class TeacherController {
    private static ITeacherService iTeacherService = new TeacherService();
    private static Scanner scanner = new Scanner(System.in);

    public static void menuStudent() {
        while (true) {
            System.out.println("-----------------------------------------");
            System.out.println("Chào mừng đến với chương trình quản lý CodyGym.");
            System.out.println("1. Thêm mới giáo viên.");
            System.out.println("2. Hiển thị danh sách giáo viên. ");
            System.out.println("3. Xóa giáo viên. ");
            System.out.println("4. Thoát. ");
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
                    System.exit(0);
                    return;
            }
        }
    }

    public static void menuTeacher() {
    }
}

