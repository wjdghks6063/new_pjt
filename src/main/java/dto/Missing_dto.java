package dto;

public class Missing_dto {
	private String no, name, age, gender, lost_date,lost_time,lost_area, lost_place, 
				   lat, lng, content, attach, reg_info, reg_date, 
				   guardian_tell;
	private int hit;

	// 상세보기
	public Missing_dto(String no, String name, String age, String gender, String lost_date, String lost_time, String lost_area,
			String lost_place, String lat, String lng, String content, String attach, String reg_info, String reg_date,
			int hit, String guardian_tell) {
		super();
		this.no = no;
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.lost_date = lost_date;
		this.lost_time = lost_time;
		this.lost_area = lost_area;
		this.lost_place = lost_place;
		this.lat = lat;
		this.lng = lng;
		this.content = content;
		this.attach = attach;
		this.reg_info = reg_info;
		this.reg_date = reg_date;
		this.hit = hit;
		this.guardian_tell=guardian_tell;
	}

	
	// 등록
	public Missing_dto(String no, String name, String age, String gender, String lost_date, String lost_time,String lost_area,
			String lost_place, String lat, String lng, String content, String attach, String reg_info, String reg_date,
			int hit) {
		super();
		this.no = no;
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.lost_date = lost_date;
		this.lost_time = lost_time;
		this.lost_area = lost_area;
		this.lost_place = lost_place;
		this.lat = lat;
		this.lng = lng;
		this.content = content;
		this.attach = attach;
		this.reg_info = reg_info;
		this.reg_date = reg_date;
		this.hit = hit;
	}



	public String getLost_time() {
		return lost_time;
	}


	public String getNo() {
		return no;
	}



	public String getName() {
		return name;
	}



	public String getAge() {
		return age;
	}



	public String getGender() {
		return gender;
	}



	public String getLost_date() {
		return lost_date;
	}



	public String getLost_area() {
		return lost_area;
	}



	public String getLost_place() {
		return lost_place;
	}



	public String getLat() {
		return lat;
	}



	public String getLng() {
		return lng;
	}



	public String getContent() {
		return content;
	}



	public String getAttach() {
		return attach;
	}



	public String getReg_info() {
		return reg_info;
	}



	public String getReg_date() {
		return reg_date;
	}



	public String getGuardian_tell() {
		return guardian_tell;
	}



	public int getHit() {
		return hit;
	}

	



}
