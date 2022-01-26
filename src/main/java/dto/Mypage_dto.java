package dto;

public class Mypage_dto {

	String dona_no,dona_title,dona_date, vol_no, vol_title, vol_date,dummy, notif_no,notif_title,notif_date,dona_date_month;
	int dona_amount, total_amount,today_amount, notifi_amount,dona_count;
	
	//활동내역 뽑아오기
	
	
	//새소식 뽑아내기
	public Mypage_dto(String notif_no, String notif_title, String notif_date, int notifi_amount) {
		super();
		this.notif_no = notif_no;
		this.notif_title = notif_title;
		this.notif_date = notif_date;
		this.notifi_amount = notifi_amount;
	}

	//총 금액 뽑아내기
	public Mypage_dto(int total_amount) {
		super();
		this.total_amount = total_amount;
	}

	//현재금액 뽑아오기

	public Mypage_dto(int today_amount, String dummy) {
		super();
		this.today_amount = today_amount;
		this.dummy = dummy;
	}


	//vol 활동내역
	public Mypage_dto(String vol_no, String vol_title, String vol_date) {
		super();
		this.vol_no = vol_no;
		this.vol_title = vol_title;
		this.vol_date = vol_date;
	}

	//전체 활동내역 및 dona활동내역
	public Mypage_dto(String dona_no, String dona_title, String dona_date, int dona_amount, String dona_date_month) {
		super();
		this.dona_no = dona_no;
		this.dona_title = dona_title;
		this.dona_date = dona_date;
		this.dona_amount = dona_amount;
		this.dona_date_month = dona_date_month;
	}


	//기본 전체
	public Mypage_dto(String dona_no, String dona_title, String dona_date, String vol_no, String vol_title,
			String vol_date, int dona_amount) {
		super();
		this.dona_no = dona_no;
		this.dona_title = dona_title;
		this.dona_date = dona_date;
		this.vol_no = vol_no;
		this.vol_title = vol_title;
		this.vol_date = vol_date;
		this.dona_amount = dona_amount;
	}
	
	


	public String getDona_no() {
		return dona_no;
	}
	public void setDona_no(String dona_no) {
		this.dona_no = dona_no;
	}
	public String getDona_title() {
		return dona_title;
	}
	public void setDona_title(String dona_title) {
		this.dona_title = dona_title;
	}
	public String getDona_date() {
		return dona_date;
	}
	public void setDona_date(String dona_date) {
		this.dona_date = dona_date;
	}
	public String getVol_no() {
		return vol_no;
	}
	public void setVol_no(String vol_no) {
		this.vol_no = vol_no;
	}
	public String getVol_title() {
		return vol_title;
	}
	public void setVol_title(String vol_title) {
		this.vol_title = vol_title;
	}
	public String getVol_date() {
		return vol_date;
	}
	public void setVol_date(String vol_date) {
		this.vol_date = vol_date;
	}
	public int getDona_amount() {
		return dona_amount;
	}
	public void setDona_amount(int dona_amount) {
		this.dona_amount = dona_amount;
	}


	public int getTotal_amount() {
		return total_amount;
	}


	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}

	public String getDummy() {
		return dummy;
	}

	public void setDummy(String dummy) {
		this.dummy = dummy;
	}

	public int getToday_amount() {
		return today_amount;
	}

	public void setToday_amount(int today_amount) {
		this.today_amount = today_amount;
	}

	public String getNotif_no() {
		return notif_no;
	}

	public void setNotif_no(String notif_no) {
		this.notif_no = notif_no;
	}

	public String getNotif_title() {
		return notif_title;
	}

	public void setNotif_title(String notif_title) {
		this.notif_title = notif_title;
	}

	public String getNotif_date() {
		return notif_date;
	}

	public void setNotif_date(String notif_date) {
		this.notif_date = notif_date;
	}

	public int getNotifi_amount() {
		return notifi_amount;
	}

	public void setNotifi_amount(int notifi_amount) {
		this.notifi_amount = notifi_amount;
	}

	public String getDona_date_month() {
		return dona_date_month;
	}

	public void setDona_date_month(String dona_date_month) {
		this.dona_date_month = dona_date_month;
	}

	public int getDona_count() {
		return dona_count;
	}

	public void setDona_count(int dona_count) {
		this.dona_count = dona_count;
	}
	
	
}
