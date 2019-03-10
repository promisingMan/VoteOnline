package converts;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import org.springframework.core.convert.converter.Converter;

public class MyDateConverter implements Converter<String, Date> {

	@Override
	public Date convert(String source) {
		SimpleDateFormat sdf = getSimpleDate(source);
		Date bithday = new Date();
		try {
			bithday = sdf.parse(source);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		return bithday;
	}

	private SimpleDateFormat getSimpleDate(String source) {
		SimpleDateFormat sdf = new SimpleDateFormat();
		if (Pattern.matches("^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}$", source)) {
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		} else if (Pattern.matches("^\\d{4}/\\d{2}/\\d{2} \\d{2}:\\d{2}:\\d{2}$", source)) {
			sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		} else if (Pattern.matches("^\\d{4}\\d{2}\\d{2} \\d{2}:\\d{2}:\\d{2}$", source)) {
			sdf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		}
		return sdf;
	}

}
