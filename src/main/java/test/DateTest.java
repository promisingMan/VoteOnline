package test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTest {
	public static void main(String[] args) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String str_date = sdf.format(new Date());
		System.out.println(str_date);
		Date date = sdf.parse(str_date);
		System.out.println(date);
	}
}
