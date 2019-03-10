package utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateConvertUtil {
	public static String getFormatDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String str_date = sdf.format(date);
		return str_date;
	}
}
