package ss2_loop_in_java.exercise;

import java.util.Scanner;

//hiển thị 20 số nguyên tố đầu tiên
public class ShowFirst20Primes {
    public static void main(String[] args) {
//        Scanner input = new Scanner(System.in);
        int number = 20;
        int count = 0;
        int n = 2;
        while (count < number) {
            int value = 0;
            for (int i = 2; i < n; i++) {
                if (n % i == 0) {
                    value += 1;
                }
            }
            if (value == 0) {
                System.out.println(n);
                count++;
            }
            n++;
        }
    }
}
