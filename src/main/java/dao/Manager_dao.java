package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConection;
import common.DBConnection;
import dto.Manager_dto;
import dto.Missing_dto;

public class Manager_dao {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;


/*-----------------------------------봉사 상세 보기-----------------------------------------------------------------------------*/	
	/*조건별*/	
	//전체 조회
	public ArrayList<Manager_dto> getVolAllSearch(String gubun,String search){
		ArrayList<Manager_dto> VAS_list = new ArrayList<>();
		String query="select no, title, voname, volunteersite, local, to_char(start_date,'yyyy-mm-dd') start_date,\r\n" + 
				"	to_char(end_date,'yyyy-mm-dd') end_date, to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal,\r\n" + 
				"	CASE WHEN total >= goal THEN 'complete' END AS state1,\r\n" + 
				"	CASE WHEN to_char(CURRENT_DATE, 'yyyy-MM-dd') <= to_char(end_date,'yyyy-MM-dd') THEN 'Proceeding'\r\n" + 
				"	WHEN to_char(end_date,'yyyy-MM-dd') < to_char(CURRENT_date,'yyyy-mm-dd') THEN 'end'\r\n" + 
				"	END AS STATE2 from volunteer\r\n" + 
				"	where local like '%"+gubun+"%'" ;
		
		if(search.equals("ing")) query += " AND to_char(end_date,'yyyy-MM-dd') >= to_char(CURRENT_date,'yyyy-mm-dd') \r\n" ; 
		else if(search.equals("end")) query += " AND to_char(end_date,'yyyy-MM-dd') < to_char(CURRENT_date,'yyyy-mm-dd') \r\n" ; 
		else if(search.equals("goal")) query += " AND total >= goal \r\n" ; 
		
		 query += " order by end_date desc";

	
		
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				String no 				= rs.getString("no");
				String vol_title 		= rs.getString("title");
				String vol_name 			= rs.getString("voname");
				String vol_site 		= rs.getString("volunteersite");
				String do_category 		= rs.getString("local");
				String do_today 		= rs.getString("today");
				String vol_start_date 	= rs.getString("start_date");
				String vol_end_date 		= rs.getString("end_date");
				int vol_total 			= rs.getInt("total");
				int vol_goal 			= rs.getInt("goal");
				
				VAS_list.add(new Manager_dto(no, vol_title, vol_name, vol_site, do_category, do_today, vol_start_date, vol_end_date, vol_total, vol_goal));
				/*오늘날짜를 받기 위해 today를 생성해야 되서 봉사 목록을 사용함*/
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getVolAllSearch 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return VAS_list;
	}	
	
	
	
	
/*--------------------------------------봉사 목록-------------------------------------------------------------------------------*/	
	//오늘의 봉사 일정 목록
	public ArrayList<Manager_dto> getVolToday(String search){
		ArrayList<Manager_dto> VT_list = new ArrayList<>();
		String query="select today_total, today_com, today_end\r\n" + 
				"	from(\r\n" + 
				"	select count(to_char(end_date,'yyyy-mm-dd')) as today_total from volunteer\r\n" + 
				"	where to_char(CURRENT_date,'yyyy-mm-dd') = to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and local like '%"+search+"%'),\r\n" + 
				"\r\n" + 
				"	(select count(to_char(end_date,'yyyy-mm-dd')) as today_com from volunteer\r\n" + 
				"	where to_char(CURRENT_date,'yyyy-mm-dd') = to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and total >= goal\r\n" + 
				"	and local like '%"+search+"%'),\r\n" + 
				"\r\n" + 
				"	(select count(to_char(end_date,'yyyy-mm-dd')) as today_end from volunteer\r\n" + 
				"	where to_char(CURRENT_date,'yyyy-mm-dd') = to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and total < goal\r\n" + 
				"	and local like '%"+search+"%')";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int end_vol 	= rs.getInt("today_total");
				int total_vol 	= rs.getInt("today_com");
				int start_vol 	= rs.getInt("today_end");
				
				VT_list.add(new Manager_dto(end_vol, total_vol, start_vol));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getVolToday 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return VT_list;
	}
	
	/*이번주 총 봉사 일정*/
	public ArrayList<Manager_dto> getVolWeek(String search){
		ArrayList<Manager_dto> VW_list = new ArrayList<>();
		String query="select  week_total, week_pro, week_com, week_end\r\n" + 
				"	from(\r\n" + 
				"	select count(to_char(end_date,'yyyy-mm-dd')) as week_total from volunteer\r\n" + 
				"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= TO_CHAR(TRUNC(sysdate,'d')+6,'yyyy-mm-dd')\r\n" + 
				"	and local like '%"+search+"%'),\r\n" + 
				"\r\n" + 
				"	(select count(to_char(end_date,'yyyy-mm-dd')) as week_pro from volunteer\r\n" + 
				"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= TO_CHAR(TRUNC(sysdate,'d')+6,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') >= to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
				"	and local like '%"+search+"%'),\r\n" + 
				"\r\n" + 
				"	(select count(to_char(end_date,'yyyy-mm-dd')) as week_com from volunteer\r\n" + 
				"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= TO_CHAR(TRUNC(sysdate,'d')+6,'yyyy-mm-dd')\r\n" + 
				"	and total >= goal and local like '%"+search+"%'),\r\n" + 
				"\r\n" + 
				"	(select count(to_char(end_date,'yyyy-mm-dd')) as week_end from volunteer\r\n" + 
				"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') < to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
				"	and local like '%"+search+"%')";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				int do_total		= rs.getInt("week_total");
				int do_pro 			= rs.getInt("week_pro");
				int do_com 			= rs.getInt("week_com");
				int do_end 			= rs.getInt("week_end");
				
				VW_list.add(new Manager_dto(do_total, do_pro, do_com, do_end));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getVolWeek 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return VW_list;
	}
	
	/*이번달 총 봉사 일정*/
	public ArrayList<Manager_dto> getVolMonth(String search){
		ArrayList<Manager_dto> VM_list = new ArrayList<>();
		String query="select month_total ,month_pro, month_com, month_end\r\n" + 
				"		from(\r\n" + 
				"		select count(to_char(end_date,'yyyy-mm-dd')) as month_total from volunteer\r\n" + 
				"		where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"		and to_char(end_date,'yyyy-mm-dd') <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
				"		and local like '%"+search+"%'),\r\n" + 
				"\r\n" + 
				"		(select count(to_char(end_date,'yyyy-mm-dd')) as month_pro from volunteer\r\n" + 
				"		where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"		and to_char(end_date,'yyyy-mm-dd') <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
				"		and to_char(end_date,'yyyy-mm-dd') >= to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
				"		and local like '%"+search+"%'),\r\n" + 
				"\r\n" + 
				"		(select count(to_char(end_date,'yyyy-mm-dd')) as month_com from volunteer\r\n" + 
				"		where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"		and to_char(end_date,'yyyy-mm-dd') <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
				"		and total >= goal\r\n" + 
				"		and local like '%"+search+"%'),\r\n" + 
				"\r\n" + 
				"		(select count(to_char(end_date,'yyyy-mm-dd')) as month_end from volunteer\r\n" + 
				"		where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"		and to_char(end_date,'yyyy-mm-dd') < to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
				"		and local like '%"+search+"%')";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				int do_total		= rs.getInt("month_total");
				int do_pro 			= rs.getInt("month_pro");
				int do_com 			= rs.getInt("month_com");
				int do_end 			= rs.getInt("month_end");
				
				VM_list.add(new Manager_dto(do_total, do_pro, do_com, do_end));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getVolMonth 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return VM_list;
	}
	
	//이번달 진행중인 봉사 상황 (기간이 지나지 않은 것만 표시) //초단위가 들어가기 때문에 전부 to_char로 일단위까지만 처리한다.
	public ArrayList<Manager_dto> getProceedingMonthVol(String search){
		ArrayList<Manager_dto> PMV_list = new ArrayList<>();
		String query="select no, title, voname, volunteersite, to_char(start_date,'yyyy-MM-dd') start_date,\r\n" + 
				"		to_char(end_date,'yyyy-MM-dd') end_date, to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal from volunteer\r\n" + 
				"		where to_char(sysdate,'yyyy-MM') || '-01' <= to_char(end_date,'yyyy-MM-dd')\r\n" + 
				"		and to_char(end_date,'yyyy-MM-dd') <= to_char(LAST_DAY(sysdate),'yyyy-MM-dd')\r\n" + 
				"		and to_char(start_date,'yyyy-MM-dd') <= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
				"		and to_char(end_date,'yyyy-MM-dd') >= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
				"		and local like '%"+search+"%' order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String no 				= rs.getString("no");
				String do_title 		= rs.getString("title");
				String do_name 			= rs.getString("voname");
				String do_category 		= rs.getString("volunteersite");
				String do_today 		= rs.getString("today");
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				PMV_list.add(new Manager_dto(no, do_title, do_name, do_category, do_today, do_start_date, do_end_date, do_total, do_goal));
				/*오늘날짜를 받기 위해 today를 생성해야 되서 봉사 목록을 사용함*/
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getProceedingMonthDona 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return PMV_list;
	}
	
	//이번달 달성완료 기부 목록  //초단위가 들어가기 때문에 전부 to_char로 일단위까지만 처리한다.
	public ArrayList<Manager_dto> getCompleteMonthVol(String search){
		ArrayList<Manager_dto> CMV_list = new ArrayList<>();
		String query="select no, title, voname, volunteersite, to_char(start_date,'yyyy-MM-dd') start_date,\r\n" + 
				"    to_char(end_date,'yyyy-MM-dd') end_date, to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal from volunteer\r\n" + 
				"	where to_char(sysdate,'yyyy-MM') || '-01' <= to_char(end_date,'yyyy-MM-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-MM-dd') <= to_char(LAST_DAY(sysdate),'yyyy-MM-dd')\r\n" + 
				"	and total >= goal and local like '%"+search+"%'\r\n" + 
				"	order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String no 				= rs.getString("no");
				String do_title 		= rs.getString("title");
				String do_name 			= rs.getString("voname");
				String do_category 		= rs.getString("volunteersite");
				String do_today 		= rs.getString("today");
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				CMV_list.add(new Manager_dto(no, do_title, do_name, do_category, do_today, do_start_date, do_end_date, do_total, do_goal));
				/*오늘날짜를 받기 위해 today를 생성해야 되서 봉사 목록을 사용함*/
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getCompleteMonthDona 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return CMV_list;
	}
	
/*---------------------------기부 상세 조회 페이지------------------------------------------------------------------------------------*/
	/*조건별*/	
	//전체 조회
	public ArrayList<Manager_dto> getDonaAllSearch(String gubun,String search){
		ArrayList<Manager_dto> DAS_list = new ArrayList<>();
		String query="select no, title, dominator, search, to_char(start_date,'yyyy-mm-dd') start_date,\r\n" + 
				"	to_char(end_date,'yyyy-mm-dd') end_date, to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal,\r\n" + 
				"	CASE WHEN total >= goal THEN 'complete' END AS state1,\r\n" + 
				"	CASE WHEN to_char(CURRENT_DATE, 'yyyy-MM-dd') <= to_char(end_date,'yyyy-MM-dd') THEN 'Proceeding'\r\n" + 
				"	WHEN to_char(end_date,'yyyy-MM-dd') < to_char(CURRENT_date,'yyyy-mm-dd') THEN 'end'\r\n" + 
				"	END AS STATE2 from donation"+
				"	where search like '%"+gubun+"%' " ;
		
		if(search.equals("ing")) query += " AND to_char(end_date,'yyyy-MM-dd') >= to_char(CURRENT_date,'yyyy-mm-dd') \r\n" ; 
		else if(search.equals("end")) query += " AND to_char(end_date,'yyyy-MM-dd') < to_char(CURRENT_date,'yyyy-mm-dd') \r\n" ; 
		else if(search.equals("goal")) query += " AND total >= goal \r\n" ; 
		
		 query += " order by end_date desc";

	
		
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				String no 				= rs.getString("no");
				String do_title 		= rs.getString("title");
				String do_name 			= rs.getString("dominator");
				String do_category 		= rs.getString("search");
				String do_today 		= rs.getString("today");
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				DAS_list.add(new Manager_dto(no, do_title, do_name, do_category, do_today, do_start_date, do_end_date, do_total, do_goal));
				/*오늘날짜를 받기 위해 today를 생성해야 되서 봉사 목록을 사용함*/
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getDonaAllSearch 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return DAS_list;
	}	
	
	
/*-------------------------------기부페이지--------------------------------------------------------------------------------------------*/
	
	//오늘의 기부 일정 목록
		public ArrayList<Manager_dto> getDoToday(String search){
			ArrayList<Manager_dto> DT_list = new ArrayList<>();
			String query="select today_total, today_com, today_end\r\n" + 
					"	from(\r\n" + 
					"	select count(to_char(end_date,'yyyy-mm-dd')) as today_total from donation\r\n" + 
					"	where to_char(CURRENT_date,'yyyy-mm-dd') = to_char(end_date,'yyyy-mm-dd')\r\n" + 
					"	and search like '%"+search+"%'),\r\n" + 
					"	\r\n" + 
					"	(select count(to_char(end_date,'yyyy-mm-dd')) as today_com from donation\r\n" + 
					"	where to_char(CURRENT_date,'yyyy-mm-dd') = to_char(end_date,'yyyy-mm-dd')\r\n" + 
					"	and total >= goal\r\n" + 
					"	and search like '%"+search+"%'),\r\n" + 
					"\r\n" + 
					"	(select count(to_char(end_date,'yyyy-mm-dd')) as today_end from donation\r\n" + 
					"	where to_char(CURRENT_date,'yyyy-mm-dd') = to_char(end_date,'yyyy-mm-dd')\r\n" + 
					"	and total < goal\r\n" + 
					"	and search like '%"+search+"%')";
			try {
				con = DBConnection.getConnection();
				ps = con.prepareStatement(query);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					int end_vol 	= rs.getInt("today_total");
					int total_vol 	= rs.getInt("today_com");
					int start_vol 	= rs.getInt("today_end");
					
					DT_list.add(new Manager_dto(end_vol, total_vol, start_vol));
				}
			} catch(SQLException e) {
				e.printStackTrace();
				System.out.println("\n\n--------------------------------------------");
				System.out.println("getDoToday 메소드에서 에러가 발생했습니다.");
				System.out.println("실행한 qury : "+query);
				System.out.println("--------------------------------------------\n\n");
			} finally {
				DBConnection.closeDB(con, ps, rs);
			}
			
			return DT_list;
		}
	
	
	/*이번주 총 기부 일정*/
	public ArrayList<Manager_dto> getDoWeek(String search){
		ArrayList<Manager_dto> DW_list = new ArrayList<>();
		String query="select  week_total, week_pro, week_com, week_end\r\n" + 
				"from(\r\n" + 
				"	select count(to_char(end_date,'yyyy-mm-dd')) as week_total from donation\r\n" + 
				"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= TO_CHAR(TRUNC(sysdate,'d')+6,'yyyy-mm-dd')\r\n" + 
				"	and search like '%"+search+"%'),\r\n" + 
				"    \r\n" + 
				"	(select count(to_char(end_date,'yyyy-mm-dd')) as week_pro from donation\r\n" + 
				"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= TO_CHAR(TRUNC(sysdate,'d')+6,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') >= to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
				"	and search like '%"+search+"%'),\r\n" + 
				"\r\n" + 
				"    (select count(to_char(end_date,'yyyy-mm-dd')) as week_com from donation\r\n" + 
				"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= TO_CHAR(TRUNC(sysdate,'d')+6,'yyyy-mm-dd')\r\n" + 
				"	and total >= goal and search like '%"+search+"%'),\r\n" + 
				"    \r\n" + 
				"    (select count(to_char(end_date,'yyyy-mm-dd')) as week_end from donation\r\n" + 
				"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') < to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
				"	and search like '%"+search+"%')";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				int do_total		= rs.getInt("week_total");
				int do_pro 			= rs.getInt("week_pro");
				int do_com 			= rs.getInt("week_com");
				int do_end 			= rs.getInt("week_end");
				
				DW_list.add(new Manager_dto(do_total, do_pro, do_com, do_end));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getDoWeek 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return DW_list;
	}
	
	
	
	
	/*이번달 총 기부 일정*/
	public ArrayList<Manager_dto> getDoMonth(String search){
		ArrayList<Manager_dto> DM_list = new ArrayList<>();
		String query="select month_total ,month_pro, month_com, month_end\r\n" + 
				"from(\r\n" + 
				"	select count(to_char(end_date,'yyyy-mm-dd')) as month_total from donation\r\n" + 
				"	where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
				"	and search like '%"+search+"%'),\r\n" + 
				"    \r\n" + 
				"	(select count(to_char(end_date,'yyyy-mm-dd')) as month_pro from donation\r\n" + 
				"	where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') >= to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
				"	and search like '%"+search+"%'),\r\n" + 
				"    \r\n" + 
				"    (select count(to_char(end_date,'yyyy-mm-dd')) as month_com from donation\r\n" + 
				"	where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
				"	and total >= goal\r\n" + 
				"	and search like '%"+search+"%'),\r\n" + 
				"    \r\n" + 
				"    (select count(to_char(end_date,'yyyy-mm-dd')) as month_end from donation\r\n" + 
				"	where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') < to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
				"	and search like '%"+search+"%')";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				int do_total		= rs.getInt("month_total");
				int do_pro 			= rs.getInt("month_pro");
				int do_com 			= rs.getInt("month_com");
				int do_end 			= rs.getInt("month_end");
				
				DM_list.add(new Manager_dto(do_total, do_pro, do_com, do_end));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getDoMonth 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return DM_list;
	}
	
	
	
	//이번달 달성완료 기부 목록  //초단위가 들어가기 때문에 전부 to_char로 일단위까지만 처리한다.
	public ArrayList<Manager_dto> getCompleteMonthDona(String search){
		ArrayList<Manager_dto> CMD_list = new ArrayList<>();
		String query="select no, title, dominator, to_char(start_date,'yyyy-mm-dd') start_date,\r\n" + 
				"	to_char(end_date,'yyyy-mm-dd') end_date, to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal from donation\r\n" + 
				"	where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
				"	and total >= goal and search like '%"+search+"%'\r\n" + 
				"	order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String no 				= rs.getString("no");
				String do_title 		= rs.getString("title");
				String do_name 			= rs.getString("dominator");
				String do_today 		= rs.getString("today");
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				CMD_list.add(new Manager_dto(no, do_title, do_name, do_today, do_start_date, do_end_date, do_total, do_goal));
				/*오늘날짜를 받기 위해 today를 생성해야 되서 봉사 목록을 사용함*/
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getCompleteMonthDona 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return CMD_list;
	}
	
	//이번달 진행중인 기부 상황 (기간이 지나지 않은 것만 표시) //초단위가 들어가기 때문에 전부 to_char로 일단위까지만 처리한다.
	public ArrayList<Manager_dto> getProceedingMonthDona(String search){
		ArrayList<Manager_dto> PMD_list = new ArrayList<>();
		String query="select no, title, dominator, to_char(start_date,'yyyy-mm-dd') start_date,\r\n" + 
				"	to_char(end_date,'yyyy-mm-dd') end_date, to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal from donation\r\n" + 
				"	where to_char(sysdate,'yyyy-mm') || '-01' <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-mm-dd') <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
				"	and to_char(start_date,'yyyy-MM-dd') <= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
				"	and to_char(end_date,'yyyy-MM-dd') >= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
				"	and search like '%"+search+"%' order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String no 				= rs.getString("no");
				String do_title 		= rs.getString("title");
				String do_name 			= rs.getString("dominator");
				String do_today 		= rs.getString("today");
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				PMD_list.add(new Manager_dto(no, do_title, do_name, do_today, do_start_date, do_end_date, do_total, do_goal));
				/*오늘날짜를 받기 위해 today를 생성해야 되서 봉사 목록을 사용함*/
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getProceedingMonthDona 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return PMD_list;
	}
//---------------------------------home 화면 ----------------------------------------------------------------------------------------------	
	
	//이번주 진행중인 봉사 상황 (기간이 지나지 않은 것만 표시) //초단위가 들어가기 때문에 전부 to_char로 일단위까지만 처리한다.
			public ArrayList<Manager_dto> getProceedingWeekVol(){
				ArrayList<Manager_dto> PWV_list = new ArrayList<>();
				String query="select no, title, voname, volunteersite, to_char(start_date,'yyyy-MM-dd') as start_date,\r\n" + 
						"	to_char(end_date,'yyyy-MM-dd') as end_date, total, goal from volunteer\r\n" + 
						"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
						"	and to_char(end_date,'yyyy-mm-dd') <= TO_CHAR(TRUNC(sysdate,'d')+6,'yyyy-mm-dd')\r\n" + 
						"	and to_char(start_date,'yyyy-MM-dd') <= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
						"	and to_char(end_date,'yyyy-MM-dd') >= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
						"	ORDER BY end_date asc";
				try {
					con = DBConnection.getConnection();
					ps = con.prepareStatement(query);
					rs = ps.executeQuery();
					
					while(rs.next()) {
						String no 				= rs.getString("no");
						String do_title 		= rs.getString("title");
						String do_name 			= rs.getString("voname");
						String do_today 		= rs.getString("volunteersite");
						String do_start_date 	= rs.getString("start_date");
						String do_end_date 		= rs.getString("end_date");
						int do_total 			= rs.getInt("total");
						int do_goal 			= rs.getInt("goal");
						
						PWV_list.add(new Manager_dto(no, do_title, do_name, do_today, do_start_date, do_end_date, do_total, do_goal));
					}
				} catch(SQLException e) {
					e.printStackTrace();
					System.out.println("\n\n--------------------------------------------");
					System.out.println("getProceedingWeekVol 메소드에서 에러가 발생했습니다.");
					System.out.println("실행한 qury : "+query);
					System.out.println("--------------------------------------------\n\n");
				} finally {
					DBConnection.closeDB(con, ps, rs);
				}
				
				return PWV_list;
			}
	
	
	//이번주 진행중인 기부 상황 (기간이 지나지 않은 것만 표시) //초단위가 들어가기 때문에 전부 to_char로 일단위까지만 처리한다.
		public ArrayList<Manager_dto> getProceedingWeekDona(){
			ArrayList<Manager_dto> PWD_list = new ArrayList<>();
			String query="select no, title, dominator, to_char(start_date,'yyyy-mm-dd') start_date, \r\n" + 
					"	to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
					"	to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal\r\n" + 
					"	from donation\r\n" + 
					"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= to_char(end_date,'yyyy-mm-dd')\r\n" + 
					"	and to_char(end_date,'yyyy-mm-dd') <= TO_CHAR(TRUNC(sysdate,'d')+6,'yyyy-mm-dd')\r\n" + 
					"	and to_char(start_date,'yyyy-MM-dd') <= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
					"	and to_char(end_date,'yyyy-MM-dd') >= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
					"	ORDER BY end_date asc";
			try {
				con = DBConnection.getConnection();
				ps = con.prepareStatement(query);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					String no 				= rs.getString("no");
					String do_title 		= rs.getString("title");
					String do_name 			= rs.getString("dominator");
					String do_today 		= rs.getString("today");
					String do_start_date 	= rs.getString("start_date");
					String do_end_date 		= rs.getString("end_date");
					int do_total 			= rs.getInt("total");
					int do_goal 			= rs.getInt("goal");
					
					PWD_list.add(new Manager_dto(no, do_title, do_name, do_today, do_start_date, do_end_date, do_total, do_goal));
					/*오늘날짜를 받기 위해 today를 생성해야 되서 봉사 목록을 사용함*/
				}
			} catch(SQLException e) {
				e.printStackTrace();
				System.out.println("\n\n--------------------------------------------");
				System.out.println("getProceedingWeekDona 메소드에서 에러가 발생했습니다.");
				System.out.println("실행한 qury : "+query);
				System.out.println("--------------------------------------------\n\n");
			} finally {
				DBConnection.closeDB(con, ps, rs);
			}
			
			return PWD_list;
		}
	
	//오늘의 봉사 일정 목록
	public ArrayList<Manager_dto> getVolToday(){
		ArrayList<Manager_dto> Vol_list = new ArrayList<>();
		String query="select a.e_date,a.total,b.s_date\r\n" + 
				"	from(\r\n" + 
				"	select count(to_char(end_date,'yyyy-mm-dd')) e_date,sum(total) total from volunteer\r\n" + 
				"	where to_char(end_date,'yyyy-mm-dd') = to_char(CURRENT_DATE, 'yyyy-MM-dd')) a,\r\n" + 
				"	(select count(to_char(start_date,'yyyy-mm-dd')) s_date from volunteer\r\n" + 
				"	where to_char(start_date,'yyyy-mm-dd') = to_char(CURRENT_DATE, 'yyyy-MM-dd')) b";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int end_vol = rs.getInt("e_date");
				int total_vol = rs.getInt("total");
				int start_vol = rs.getInt("s_date");
				
				Vol_list.add(new Manager_dto(end_vol, total_vol, start_vol));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getVolToday 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return Vol_list;
	}
	
	
	//오늘의 기부 목록 (아동,노인 카테고리 포함, 일간 금액 표시)
	public ArrayList<Manager_dto> getSearchList() {
		ArrayList<Manager_dto> list = new ArrayList<>();
		String query="select a.search_name as search, nvl(b.total_money,0) as item_money\r\n" + 
					" from dona_category a,\r\n" + 
					" (select search, to_char(dona_date, 'yyyy-MM-dd'), sum(amount) AS total_money\r\n" + 
					" from mypage_dona_history\r\n" + 
					" where to_char(dona_date, 'yyyy-MM-dd') = to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
					" GROUP BY  search, to_char(dona_date, 'yyyy-MM-dd')) b\r\n" + 
					" where a.search_code = b.search(+)\r\n" + 
					" order by a.search_name asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String search_code = rs.getString(1);
				int item_money = rs.getInt(2);
				
				list.add(new Manager_dto(search_code, item_money));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getSearchList 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return list;
	}
	
}
