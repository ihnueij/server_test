package example;

import java.net.URLEncoder;

public class HanConv {
    public static String toKor(String str) {
        if ((str == null) || (str.equals("null"))) {
            return str;
        }
        try {
            return new String(str.getBytes("8859_1"), "UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
            return str;
        }
    }

    public static String toKorTwo(String str) {
        if ((str == null) || (str.equals("null"))) {
            return str;
        }
        try {
            String result = null;
            result = URLEncoder.encode(str, "UTF-8");
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return str;
        }
    }
}
