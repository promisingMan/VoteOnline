package utils;

import java.util.UUID;

public class UUIDUtil {
	
	public static void main(String[] args) {
		System.out.println(getId());
	}
	
	public static String getId() {
		String id = UUID.randomUUID().toString();
		id = id.substring(0, 8);
		return id;
	}
}
