package util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class OrderIdUtil {
    public static String getId(){
        Date now = new Date();
        SimpleDateFormat f = new SimpleDateFormat("yyyyMMddHHmmss");
        return f.format(now);
    }
}
