package model.register;

public class Register {
	private int    num;          //編號
	private String Id;           //帳號
	private String password;     //密碼
	
	public Register() {
	}
	
	public Register(int num,String Id,String password) {
		this.num = num;
		this.Id = Id;
		this.password = password;
	}
	
	public int getNum() {
		return num;
	}
	
	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return Id;
	}

	public void setId(String Id) {
		this.Id = Id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
