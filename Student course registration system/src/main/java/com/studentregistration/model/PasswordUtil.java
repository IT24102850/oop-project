package com.studentregistration.util;

import org.mindrot.jbcrypt.BCrypt;
import java.util.regex.Pattern;

public class PasswordUtil {
    private static final int BCRYPT_ROUNDS = 12;
    private static final Pattern BCRYPT_PATTERN = Pattern.compile("\\A\\$2[ayb]\\$\\d{2}\\$[./0-9A-Za-z]{53}");

    public static String hashPassword(String plainText) {
        if (plainText == null || plainText.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be empty");
        }
        return BCrypt.hashpw(plainText, BCrypt.gensalt(BCRYPT_ROUNDS));
    }

    public static boolean verifyPassword(String plainText, String hashed) {
        if (!BCRYPT_PATTERN.matcher(hashed).matches()) {
            throw new IllegalArgumentException("Invalid hash format");
        }
        return BCrypt.checkpw(plainText, hashed);
    }

    public static boolean isPasswordStrong(String password) {
        // Minimum 8 chars, at least 1 uppercase, 1 lowercase, 1 number, 1 special char
        String pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$";
        return password != null && password.matches(pattern);
    }
}