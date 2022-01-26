package dto;

public class Member_dto {
	String id, name,password,email,tell,address_1,address_2,info_yn,reg_date,exit_date,exit,notification_yn;

	//멤버 수정 저장(패스워드미포함)
	public Member_dto(String id, String name, String email, String tell, String address_1, String address_2,
			String info_yn) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.tell = tell;
		this.address_1 = address_1;
		this.address_2 = address_2;
		this.info_yn = info_yn;
	}
	
	//멤버 수정 저장(패스워드포함)
	public Member_dto(String id, String name, String password, String email, String tell, String address_1, String address_2,
			String info_yn) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.email = email;
		this.tell = tell;
		this.address_1 = address_1;
		this.address_2 = address_2;
		this.info_yn = info_yn;
	}




	public Member_dto(String id, String name, String password, String email, String tell, String address_1,String address_2,
			String info_yn, String reg_date, String exit_date, String exit, String notification_yn) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.email = email;
		this.tell = tell;
		this.address_1 = address_1;
		this.address_2 = address_2;
		this.info_yn = info_yn;
		this.reg_date = reg_date;
		this.exit_date = exit_date;
		this.exit = exit;
		this.notification_yn = notification_yn;
	}
	
	
	

	public Member_dto(String id, String name, String password, String email, String tell, String address_1,String address_2,
			String info_yn, String reg_date) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.email = email;
		this.tell = tell;
		this.address_1 = address_1;
		this.address_2 = address_2;
		this.info_yn = info_yn;
		this.reg_date = reg_date;
	}




	public String getId() {
		return id;
	}




	public void setId(String id) {
		this.id = id;
	}




	public String getName() {
		return name;
	}




	public void setName(String name) {
		this.name = name;
	}




	public String getPassword() {
		return password;
	}




	public void setPassword(String password) {
		this.password = password;
	}




	public String getEmail() {
		return email;
	}




	public void setEmail(String email) {
		this.email = email;
	}




	public String getTell() {
		return tell;
	}




	public void setTell(String tell) {
		this.tell = tell;
	}




	public String getAddress_1() {
		return address_1;
	}




	public void setAddress_1(String address_1) {
		this.address_1 = address_1;
	}




	public String getAddress_2() {
		return address_2;
	}




	public void setAddress_2(String address_2) {
		this.address_2 = address_2;
	}




	public String getInfo_yn() {
		return info_yn;
	}




	public void setInfo_yn(String info_yn) {
		this.info_yn = info_yn;
	}




	public String getReg_date() {
		return reg_date;
	}




	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}




	public String getExit_date() {
		return exit_date;
	}




	public void setExit_date(String exit_date) {
		this.exit_date = exit_date;
	}




	public String getExit() {
		return exit;
	}




	public void setExit(String exit) {
		this.exit = exit;
	}

	public String getNotification_yn() {
		return notification_yn;
	}

	public void setNotification_yn(String notification_yn) {
		this.notification_yn = notification_yn;
	}


	
	
}
