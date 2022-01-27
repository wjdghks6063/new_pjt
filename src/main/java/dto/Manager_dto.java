package dto;

public class Manager_dto {
	private String no,search_code, search_name, do_title, do_start_date, do_end_date, dominator, do_name, do_today, do_category,
			vol_title, vol_name, vol_site, vol_start_date, vol_end_date;
	

	private int do_total, do_goal, do_pro, do_com, do_end,
				item_money, start_vol, end_vol, total_vol, vol_total, vol_goal;
	
	//봉사페이지 상세 검색 표시
	public Manager_dto(String no, String vol_title, String vol_name, String vol_site, String do_category, String do_today, String vol_start_date, String vol_end_date,
			int vol_total, int vol_goal) {
		this.no = no;
		this.vol_title = vol_title;
		this.vol_name = vol_name;
		this.vol_site = vol_site;
		this.do_category = do_category;
		this.do_today = do_today;
		this.vol_start_date = vol_start_date;
		this.vol_end_date = vol_end_date;
		this.vol_total = vol_total;
		this.vol_goal = vol_goal;
	}
	
	
	//기부페이지 상세 검색 표시
	public Manager_dto(String no, String do_title, String do_name, String do_category, String do_today, String do_start_date, String do_end_date,
			int do_total, int do_goal) {
		this.no = no;
		this.do_title = do_title;
		this.do_name = do_name;
		this.do_category = do_category;
		this.do_today = do_today;
		this.do_start_date = do_start_date;
		this.do_end_date = do_end_date;
		this.do_total = do_total;
		this.do_goal = do_goal;
	}
	
	
	//이번달 기간 표시
	public Manager_dto(String do_start_date, String do_end_date, int do_total, int do_goal) {
		this.do_start_date = do_start_date;
		this.do_end_date = do_end_date;
		this.do_total = do_total;
		this.do_goal = do_goal;
	}
	
	
	//기부페이지 목록 
	public Manager_dto(String no, String do_title, String do_name, String do_today, String do_start_date, String do_end_date,
			int do_total, int do_goal) {
		this.no = no;
		this.do_title = do_title;
		this.do_name = do_name;
		this.do_today = do_today;
		this.do_start_date = do_start_date;
		this.do_end_date = do_end_date;
		this.do_total = do_total;
		this.do_goal = do_goal;
	}
	
	//오늘의 봉사 일정,오늘의 기부 일정
	public Manager_dto(int end_vol, int total_vol, int start_vol) {
		this.end_vol = end_vol;
		this.total_vol = total_vol;
		this.start_vol = start_vol;
	}
	
	//오늘의 기부 이름과 금액
	public Manager_dto(String search_name, int item_money) {
		super();
		this.search_name = search_name;
		this.item_money = item_money;
	}
	
	/*카운트 용 숫자
	public Manager_dto(String do_end_date, int do_total, int do_goal) {
		this.do_end_date = do_end_date;
		this.do_total = do_total;
		this.do_goal = do_goal;
	}
	*/
	
	//기부 일정 숫자 카운트
	public Manager_dto(int do_total, int do_pro, int do_com, int do_end) {
		this.do_total = do_total;
		this.do_pro = do_pro;
		this.do_com = do_com;
		this.do_end = do_end;
	}
	
	//이번주 진행중 기부 일정
	public Manager_dto(String no, String do_title, String do_name, String do_start_date, String do_end_date,
			int do_total, int do_goal) {
		this.no = no;
		this.do_title = do_title;
		this.do_name = do_name;
		this.do_start_date = do_start_date;
		this.do_end_date = do_end_date;
		this.do_total = do_total;
		this.do_goal = do_goal;
	}
	
	//진행중인 기부 표시
	public Manager_dto(String do_title, String do_start_date, String do_end_date, String dominator, int do_total, int do_goal) {
		this.do_title = do_title;
		this.do_start_date = do_start_date;
		this.do_end_date = do_end_date;
		this.dominator = dominator;
		this.do_total = do_total;
		this.do_goal = do_goal;
	}

	public int getItem_money() {
		return item_money;
	}


	public String getSearch_code() {
		return search_code;
	}


	public String getSearch_name() {
		return search_name;
	}	
	
	public int getStart_vol() {
		return start_vol;
	}


	public int getEnd_vol() {
		return end_vol;
	}


	public int getTotal_vol() {
		return total_vol;
	}

	public String getDo_title() {
		return do_title;
	}

	public String getDo_start_date() {
		return do_start_date;
	}

	public String getDo_end_date() {
		return do_end_date;
	}

	public String getDominator() {
		return dominator;
	}

	public int getDo_total() {
		return do_total;
	}

	public int getDo_goal() {
		return do_goal;
	}

	public String getVol_title() {
		return vol_title;
	}

	public String getVolname() {
		return vol_name;
	}

	public String getVol_site() {
		return vol_site;
	}

	public String getVol_start_date() {
		return vol_start_date;
	}

	public String getVol_end_date() {
		return vol_end_date;
	}

	public int getVol_total() {
		return vol_total;
	}

	public int getVol_goal() {
		return vol_goal;
	}

	public String getNo() {
		return no;
	}

	public String getDo_name() {
		return do_name;
	}

	public String getDo_today() {
		return do_today;
	}

	public String getVol_name() {
		return vol_name;
	}


	public String getDo_category() {
		return do_category;
	}
	
	public int getDo_pro() {
		return do_pro;
	}


	public int getDo_com() {
		return do_com;
	}


	public int getDo_end() {
		return do_end;
	}


	public void setNo(String no) {
		this.no = no;
	}


	public void setSearch_code(String search_code) {
		this.search_code = search_code;
	}


	public void setSearch_name(String search_name) {
		this.search_name = search_name;
	}


	public void setDo_title(String do_title) {
		this.do_title = do_title;
	}


	public void setDo_start_date(String do_start_date) {
		this.do_start_date = do_start_date;
	}


	public void setDo_end_date(String do_end_date) {
		this.do_end_date = do_end_date;
	}


	public void setDominator(String dominator) {
		this.dominator = dominator;
	}


	public void setDo_name(String do_name) {
		this.do_name = do_name;
	}


	public void setDo_today(String do_today) {
		this.do_today = do_today;
	}


	public void setDo_category(String do_category) {
		this.do_category = do_category;
	}


	public void setVol_title(String vol_title) {
		this.vol_title = vol_title;
	}


	public void setVol_name(String vol_name) {
		this.vol_name = vol_name;
	}


	public void setVol_site(String vol_site) {
		this.vol_site = vol_site;
	}


	public void setVol_start_date(String vol_start_date) {
		this.vol_start_date = vol_start_date;
	}


	public void setVol_end_date(String vol_end_date) {
		this.vol_end_date = vol_end_date;
	}


	public void setItem_money(int item_money) {
		this.item_money = item_money;
	}


	public void setStart_vol(int start_vol) {
		this.start_vol = start_vol;
	}


	public void setEnd_vol(int end_vol) {
		this.end_vol = end_vol;
	}


	public void setTotal_vol(int total_vol) {
		this.total_vol = total_vol;
	}


	public void setDo_total(int do_total) {
		this.do_total = do_total;
	}


	public void setDo_goal(int do_goal) {
		this.do_goal = do_goal;
	}


	public void setVol_total(int vol_total) {
		this.vol_total = vol_total;
	}


	public void setVol_goal(int vol_goal) {
		this.vol_goal = vol_goal;
	}
	
	
}
