package model.chart;

public class Chart {
	private String Id;
	private String date;
	private String name;
	private String type;
	private String description;
	
	public Chart() {
		
	}
	
	public Chart(String Id,String date,String name,String type,String description,String color) {
		this.description = description;
		this.Id = Id;
		this.date = date;
		this.name = name;
		this.type = type;		
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
