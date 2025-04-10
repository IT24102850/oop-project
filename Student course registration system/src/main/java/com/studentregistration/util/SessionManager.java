package com.studentregistration.util;

import com.studentregistration.model.Admin;
import com.studentregistration.model.User;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.servlet.http.HttpSession;

public class SessionManager {
    private static final Map<String, HttpSession> activeSessions = new ConcurrentHashMap<>();
    private static final Map<String, String> adminSessions = new ConcurrentHashMap<>();

    // Add session to tracker
    public static void addSession(User user, HttpSession session) {
        activeSessions.put(session.getId(), session);
        if (user instanceof Admin) {
            adminSessions.put(user.getEmail(), session.getId());
        }
    }

    // Remove session from tracker
    public static void removeSession(String sessionId) {
        HttpSession session = activeSessions.remove(sessionId);
        if (session != null) {
            session.invalidate();
        }
    }

    // Invalidate all sessions for a user
    public static void invalidateUserSessions(String email) {
        if (adminSessions.containsKey(email)) {
            String sessionId = adminSessions.get(email);
            removeSession(sessionId);
            adminSessions.remove(email);
        }
    }

    // Get all active admin sessions
    public static Map<String, String> getActiveAdminSessions() {
        return new ConcurrentHashMap<>(adminSessions);
    }

    // Force password reset by invalidating sessions
    public static void forcePasswordReset(String email) {
        invalidateUserSessions(email);
    }
}