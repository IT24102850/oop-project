package com.studentregistration.model;

public class Review {
    private int id; // Added ID field
    private String author;
    private String text;

    public Review(int id, String author, String text) {
        this.id = id;
        this.author = (author != null) ? author.trim() : "";
        this.text = (text != null) ? text.trim() : "";
    }

    public Review(String author, String text) {
        this(-1, author, text); // ID will be set when reading from file
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = (author != null) ? author.trim() : "";
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = (text != null) ? text.trim() : "";
    }

    @Override
    public String toString() {
        return author + "|" + text;
    }

    public static Review fromString(String line) {
        if (line == null || line.trim().isEmpty()) {
            return null;
        }
        String[] parts = line.split("\\|", 2);
        if (parts.length == 2 && !parts[0].trim().isEmpty() && !parts[1].trim().isEmpty()) {
            return new Review(parts[0], parts[1]);
        }
        return null;
    }
}