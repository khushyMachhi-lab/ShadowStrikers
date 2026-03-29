package com.example.demo.dto;

public class ActivityDTO {
	
	private String title;
    private String description;
    private String timeOrDate;
    private String type;
    private String icon; 

    public ActivityDTO(String title, String description, String timeOrDate, String type, String icon) {
        this.title = title;
        this.description = description;
        this.timeOrDate = timeOrDate;
        this.type = type;
        this.icon = icon;
    }

    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public String getTimeOrDate() { return timeOrDate; }
    public String getType() { return type; }
    public String getIcon() { return icon; }

}
