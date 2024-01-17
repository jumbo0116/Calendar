package model.display;

import java.sql.Date;

public class Display {
	private String Id;
	private String date;
	private String name;
	private String type;
	private String description;
	private String color;

	public Display() {
	}

	public Display(String Id,String date,String name,String type,String description,String color) {
		this.description = description;
		this.Id = Id;
		this.date = date;
		this.name = name;
		this.type = type;
		this.color = color;
	}

	public String getDescription() {
		return description;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getId() {
		return Id;
	}

	public void setId(String id) {
		Id = id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}