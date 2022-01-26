package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import dto.Manager_dto;

public class Manager_dao {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;


	
/*기부 상세 조회----------------------------------------------------------------------------------------*/
	/*조건별*/	
	//전체 조회
	public ArrayList<Manager_dto> getDonaAllSearch(String gubun,String search){
		ArrayList<Manager_dto> DAS_list = new ArrayList<>();
		String query="select no, title, dominator, search, to_char(start_date,'yyyy-mm-dd') start_date,\r\n" + 
				"	to_char(end_date,'yyyy-mm-dd') end_date, to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal,\r\n" + 
				"	CASE WHEN total >= goal THEN 'complete' END AS state1,\r\n" + 
				"	CASE WHEN to_char(CURRENT_DATE, 'yyyy-MM-dd') <= to_char(end_date,'yyyy-MM-dd') THEN 'Proceeding'\r\n" + 
				"	WHEN end_date < to_char(CURRENT_date,'yyyy-mm-dd') THEN 'end'\r\n" + 
				"	END AS STATE2 from donation"+
				"	where search like '%"+gubun+"%' " ;
		
		if(search.equals("ing")) query += " AND end_date >= to_char(CURRENT_date,'yyyy-mm-dd') \r\n" ; 
		else if(search.equals("end")) query += " AND end_date < to_char(CURRENT_date,'yyyy-mm-dd') \r\n" ; 
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
/*-------------------------------------------------------------------------------------------------*/
	//*오늘  기부 일정*/
	public ArrayList<Manager_dto> getToday(String search){
		ArrayList<Manager_dto> TD_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date, \r\n" + 
						"total, goal from donation\r\n" + 
						"where to_char(CURRENT_date,'yyyy-mm-dd') = end_date\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TD_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getToday 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TD_list;
	}
	
	//*오늘  기부 달성*/
	public ArrayList<Manager_dto> getTodayComplete(String search){
		ArrayList<Manager_dto> TDC_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
						"total, goal from donation\r\n" + 
						"where to_char(CURRENT_date,'yyyy-mm-dd') = end_date\r\n" + 
						"and total >= goal\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TDC_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getTodayComplete 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TDC_list;
	}
	
	//*오늘  기부 미달*/
	public ArrayList<Manager_dto> getTodayDeadline(String search){
		ArrayList<Manager_dto> TDD_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date, to_char(end_date,'yyyy-mm-dd') end_date, \r\n" + 
						"search, total, goal  from donation\r\n" + 
						"where to_char(CURRENT_date,'yyyy-mm-dd') = end_date\r\n" + 
						"and total < goal\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TDD_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getTodayDeadline 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TDD_list;
	}
	
	
	//*이번주  기부 기간 만료*/
	public ArrayList<Manager_dto> getThisWeekDeadline(String search){
		ArrayList<Manager_dto> TWD_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
						"search, goal, total from donation\r\n" + 
						"where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= end_date\r\n" + 
						"and end_date < to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TWD_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getThisWeekDeadline 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TWD_list;
	}
	
	//*이번주  기부 달성완료*/
	public ArrayList<Manager_dto> getThisWeekComplete(String search){
		ArrayList<Manager_dto> TWC_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
						"search, total, goal from donation\r\n" + 
						"where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= end_date\r\n" + 
						"and end_date <= TO_CHAR(TRUNC(sysdate+6 , 'd'),'yyyy-mm-dd')\r\n" + 
						"and total >= goal and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TWC_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getThisWeekComplete 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TWC_list;
	}
	
	//*이번주  기부 진행중*/
	public ArrayList<Manager_dto> getThisWeekProceeding(String search){
		ArrayList<Manager_dto> TWP_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
						"search, total, goal from donation\r\n" + 
						"where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= end_date\r\n" + 
						"and end_date <= TO_CHAR(TRUNC(sysdate+6 , 'd'),'yyyy-mm-dd')\r\n" + 
						"and end_date >= to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TWP_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getThisWeekProceeding 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TWP_list;
	}
	
	//*이번주  기부일정*/
	public ArrayList<Manager_dto> getThisWeek(String search){
		ArrayList<Manager_dto> TW_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
						"search, total, goal from donation\r\n" + 
						"where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= end_date\r\n" + 
						"and end_date <= TO_CHAR(TRUNC(sysdate+6 , 'd'),'yyyy-mm-dd')\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TW_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getThisWeek 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TW_list;
	}
	
	//*이번달 기부  마감*/
	public ArrayList<Manager_dto> getThisMonthDeadline(String search){
		ArrayList<Manager_dto> TMD_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
						"search, goal, total from donation\r\n" + 
						"where to_char(sysdate,'yyyy-mm') || '-01' <= end_date\r\n" + 
						"and end_date < to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TMD_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getThisMonthDeadline 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TMD_list;
	}	
	
	//*이번달 기부달성 현황*/
	public ArrayList<Manager_dto> getThisMonthComplete(String search){
		ArrayList<Manager_dto> TMC_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
						"search, total, goal from donation\r\n" + 
						"where to_char(sysdate,'yyyy-mm') || '-01' <= end_date\r\n" + 
						"and end_date <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
						"and total >= goal\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TMC_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getThisMonthComplete 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TMC_list;
	}
	
	
	//*이번달 진행중 기부현황*/
	public ArrayList<Manager_dto> getThisMonthProceeding(String search){
		ArrayList<Manager_dto> TMP_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
						"search, goal, total from donation\r\n" + 
						"where to_char(sysdate,'yyyy-mm') || '-01' <= end_date\r\n" + 
						"and end_date <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
						"and end_date >= to_char(CURRENT_date,'yyyy-mm-dd')\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TMP_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getThisMonthProceeding 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return TMP_list;
	}
	
	//*이번달 총 기부 일정*/
	public ArrayList<Manager_dto> getThisMonth(String search){
		ArrayList<Manager_dto> TM_list = new ArrayList<>();
		String query="select to_char(start_date,'yyyy-mm-dd') start_date,to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
						"search, total, goal from donation\r\n" + 
						"where to_char(sysdate,'yyyy-mm') || '-01' <= end_date\r\n" + 
						"and end_date <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
						"and search like '%"+search+"%'\r\n" + 
						"order by end_date asc";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String do_start_date 	= rs.getString("start_date");
				String do_end_date 		= rs.getString("end_date");
				int do_total 			= rs.getInt("total");
				int do_goal 			= rs.getInt("goal");
				
				TM_list.add(new Manager_dto(do_start_date, do_end_date, do_total, do_goal));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("\n\n--------------------------------------------");
			System.out.println("getThisMonth 메소드에서 에러가 발생했습니다.");
			System.out.println("실행한 qury : "+query);
			System.out.println("--------------------------------------------\n\n");
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return TM_list;
	}

	
	//이번달 달성완료 기부 목록  //초단위가 들어가기 때문에 전부 to_char로 일단위까지만 처리한다.
	public ArrayList<Manager_dto> getCompleteMonthDona(String search){
		ArrayList<Manager_dto> CMD_list = new ArrayList<>();
		String query="select no, title, dominator, to_char(start_date,'yyyy-mm-dd') start_date,\r\n" + 
				"	to_char(end_date,'yyyy-mm-dd') end_date, to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal from donation\r\n" + 
				"	where to_char(sysdate,'yyyy-mm') || '-01' <= end_date\r\n" + 
				"	and end_date <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
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
				"	where to_char(sysdate,'yyyy-mm') || '-01' <= end_date\r\n" + 
				"	and end_date <= to_char(LAST_DAY(sysdate),'yyyy-mm-dd')\r\n" + 
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
//---------------------------------home 내용-------------------------------------------------------------------------------------------	
	
	//이번주 진행중인 봉사 상황 (기간이 지나지 않은 것만 표시) //초단위가 들어가기 때문에 전부 to_char로 일단위까지만 처리한다.
			public ArrayList<Manager_dto> getProceedingWeekVol(){
				ArrayList<Manager_dto> PWV_list = new ArrayList<>();
				String query="select title, voname, volunteersite, to_char(start_date,'yyyy-MM-dd') as start_date,\r\n" + 
							"to_char(end_date,'yyyy-MM-dd') as end_date, total, goal from volunteer\r\n" + 
							"where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= end_date\r\n" + 
							"and end_date <= TO_CHAR(TRUNC(sysdate+6 , 'd'),'yyyy-mm-dd')\r\n" + 
							"and to_char(start_date,'yyyy-MM-dd') <= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
							"and to_char(end_date,'yyyy-MM-dd') >= to_char(CURRENT_DATE, 'yyyy-MM-dd')\r\n" + 
							"ORDER BY end_date asc";
				try {
					con = DBConnection.getConnection();
					ps = con.prepareStatement(query);
					rs = ps.executeQuery();
					
					while(rs.next()) {
						String vol_title 		= rs.getString("title");
						String volname 			= rs.getString("voname");
						String vol_site 		= rs.getString("volunteersite");
						String vol_start_date 	= rs.getString("start_date");
						String vol_end_date 	= rs.getString("end_date");
						int vol_total 			= rs.getInt("total");
						int vol_goal 			= rs.getInt("goal");
						
						PWV_list.add(new Manager_dto(vol_title, volname, vol_site, vol_start_date, vol_end_date, vol_total, vol_goal));
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
			String query="select no, title, dominator, to_char(start_date,'yyyy-mm-dd') start_date,\r\n" + 
					"	to_char(end_date,'yyyy-mm-dd') end_date,\r\n" + 
					"    to_char(CURRENT_DATE, 'yyyy-MM-dd') today, total, goal\r\n" + 
					"	from donation\r\n" + 
					"	where TO_CHAR(TRUNC(sysdate, 'd'),'yyyy-mm-dd') <= end_date\r\n" + 
					"	and end_date <= TO_CHAR(TRUNC(sysdate+6 , 'd'),'yyyy-mm-dd')\r\n" + 
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
		ArrayList<Manager_dto> vol_list = new ArrayList<>();
		String query="select a.e_date,a.total,b.s_date\r\n" + 
				"from(\r\n" + 
				"    select count(end_date) e_date,sum(total) total from volunteer\r\n" + 
				"    where end_date = to_char(CURRENT_DATE, 'yyyy-MM-dd')) a,\r\n" + 
				"    (select count(start_date) s_date from volunteer\r\n" + 
				"    where start_date = to_char(CURRENT_DATE, 'yyyy-MM-dd')) b";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int end_vol = rs.getInt("e_date");
				int total_vol = rs.getInt("total");
				int start_vol = rs.getInt("s_date");
				
				vol_list.add(new Manager_dto(end_vol, total_vol, start_vol));
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
		
		return vol_list;
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
