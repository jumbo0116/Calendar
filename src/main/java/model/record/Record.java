package model.record;

import java.sql.Date;

public class Record {
	private String Id;            //帳號   	
	private Date  date;           //日期
	private String itemName;      //名稱
	private String type;          //項目
	private int amount;           //金額
	private String account;       //帳戶
	private String note;          //備註


	public Record() {
	}

	public Record(String Id,Date date,String itemName,String type,int amount,String account,String note) {
		this.Id = Id;
		this.date = date;
		this.itemName = itemName;
		this.type = type;
		this.amount = amount;
		this.account = account;
		this.note = note;
	}

	public String getId() {
		return Id;
	}

	public void setId(String id) {
		Id = id;
	}
	
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	
}