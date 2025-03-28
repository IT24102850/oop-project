package com.studentregistration.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    public static String hashPassword(String plainText) {
        return BCrypt.hashpw(plainText, BCrypt.gensalt());
    }

    public static boolean verifyPassword(String plainText, String hashed) {
        return BCrypt.checkpw(plainText, hashed);
    }
}