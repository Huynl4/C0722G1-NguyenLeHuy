package ss17_io_binary_file_serialization.exercise.exercise2;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        String linkInput = "src\\ss17_io_binary_file_serialization\\exercise\\exercise2\\data\\input.csv";
        String linkCoppy = "src\\ss17_io_binary_file_serialization\\exercise\\exercise2\\data\\output.csv";
        List<String> strings = new ArrayList<>();
        strings.add("Hello");
        strings.add("Huy-nl");
        strings.add("HuyNL");
        writeFile(strings, linkInput);
        readFile(strings, linkInput);
        try {
            FileInputStream input = new FileInputStream("src\\ss17_io_binary_file_serialization\\exercise\\exercise2\\data\\input.csv");
            FileOutputStream coppy = new FileOutputStream("src\\ss17_io_binary_file_serialization\\exercise\\exercise2\\data\\output.csv");
            byte[] bytes = new byte[200];
            int length;
            int count = 0;

            while ((length = input.read(bytes)) > 0) {
                coppy.write(bytes, 0, length);
                count += length;
            }
            System.out.println("Tệp có số bytes là: " + count);
            readFile(strings, linkCoppy);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void writeFile(List<String> strings, String link) {
        File file = new File(link);
        try {
            FileOutputStream outPut = new FileOutputStream(file);
            ObjectOutputStream oBoutPut = new ObjectOutputStream(outPut);
            oBoutPut.writeObject(strings);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void readFile(List<String> strings, String link) {
        File file = new File(link);
        try {
            FileInputStream inPut = new FileInputStream(file);
            ObjectInputStream oBinput = new ObjectInputStream(inPut);
            strings = (List<String>) oBinput.readObject();
            for (String i : strings) {
                System.out.println(i);
            }
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
