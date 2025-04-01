package model;

import java.time.LocalDate;

public class Review {
    private int id;
    private String title;
    private String content;
    private int rating;
    private String category;
    private LocalDate date;
    private int userId;

    // Constructors
    public Review() {
        this.date = LocalDate.now();
    }

    public Review(String title, String content, int rating, String category, int userId) {
        this.title = title;
        this.content = content;
        this.rating = rating;
        this.category = category;
        this.userId = userId;
        this.date = LocalDate.now();
    }

    // Getters and Setters
    public int getId() {
        return id;
    }







    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", rating=" + rating +
                ", category='" + category + '\'' +
                ", date=" + date +
                '}';
    }
}
