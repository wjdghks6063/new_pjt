package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.CommonUtil;
import common.DBConnection;
import dto.Mypage_dto;

public class Mypage_dao {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	// 활동내역 오늘날짜 1일짜리 활동내역
	public ArrayList <Mypage_dto> getActivity_vol_1day(String id, String day_1, String day_2,int end){
		ArrayList<Mypage_dto> dtos = new ArrayList<Mypage_dto>();
		String query="select * from (\r\n" + 
				"    select tbl.* , rownum as rnum \r\n" + 
				"        from(\r\n" + 
				"            select * from (select no,title,to_char(vol_date,'YYYY-MM-DD') as vol_date ,to_char(vol_date,'YYYY-MM-DD HH:MI:SS') as second_date from mypage_volun_history where id ='"+id+"') order by vol_date desc \r\n" + 
				"            ) tbl \r\n" + 
				"            )  where vol_date between '"+day_1+"' and '"+day_2+"' and rnum >=1 and rnum <="+end+"";
		System.out.println(query);
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				String no = rs.getString(1);
				String title = rs.getString(2);
				String dona_date = rs.getString(3);
				Mypage_dto dto = new Mypage_dto(no,title,dona_date);
				dtos.add(dto);
			}
				
		}catch(SQLException e) {
			System.out.println("getActivity_vol_1day()오류"+ query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return dtos;	
	}
	
	//활동 봉사 카운트
	public int getTotalcount_vol(String id, String day_1, String day_2){
		int result= 0;
		String query="select count(*) from (\r\n" + 
				"    select tbl.* , rownum as rnum \r\n" + 
				"        from(\r\n" + 
				"            select * from (select no,title,to_char(vol_date,'yyyy-MM-dd') as vol_date ,to_char(vol_date,'yyyy-MM') from mypage_volun_history where id ='"+id+"') order by vol_date desc \r\n" + 
				"            ) tbl \r\n" + 
				"            )  where vol_date between '"+day_1+"' and '"+day_2+"'";
		System.out.println(query);
		try {
			con = DBConnection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
			}catch(SQLException e) {
				System.out.println("getTotalcount_dona()메서드 오류");
				System.out.println("쿼리문 : " +query);
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
		return result;
	}
	
	//활동 기부 카운트
	public int getTotalcount_dona(String id, String day_1, String day_2){
		int result= 0;
		String query="select count(*) from (\r\n" + 
				"    select tbl.* , rownum as rnum \r\n" + 
				"        from(\r\n" + 
				"            select * from (select no,title,to_char(dona_date,'yyyy-MM-dd') as dona_date ,amount, to_char(dona_date,'yyyy-MM') from mypage_dona_history where id ='"+id+"') order by dona_date desc \r\n" + 
				"            ) tbl \r\n" + 
				"            )  where dona_date between '"+day_1+"' and '"+day_2+"'";
		try {
			con = DBConnection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
			}catch(SQLException e) {
				System.out.println("getTotalcount_dona()메서드 오류");
				System.out.println("쿼리문 : " +query);
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
		return result;
	}
	
	// 기부내역 오늘날짜 1일짜리 활동내역
	public ArrayList <Mypage_dto> getActivity_dona_1day(String id, String day_1, String day_2,int end){
		ArrayList<Mypage_dto> dtos = new ArrayList<Mypage_dto>();
		String query="select * from (\r\n" + 
				"    select tbl.* , rownum as rnum \r\n" + 
				"        from(\r\n" + 
				"            select * from (select no,title,to_char(dona_date,'YYYY-MM-DD') as dona_date ,amount, to_char(dona_date,'YYYY-MM-DD HH:MI:SS') as second_date from mypage_dona_history where id ='"+id+"') order by dona_date desc \r\n" + 
				"            ) tbl \r\n" + 
				"            )  where dona_date between '"+day_1+"' and '"+day_2+"' and rnum >=1 and rnum <="+end+"";
		
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				String no = rs.getString(1);
				String title = rs.getString(2);
				String dona_date = rs.getString(3);
				int amount = rs.getInt(4);
				String second_date = rs.getString(5);
				Mypage_dto dto = new Mypage_dto(no,title,dona_date,amount,second_date);
				dtos.add(dto);
			}
				
		}catch(SQLException e) {
			System.out.println("getActivity_dona_1day()오류"+ query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return dtos;	
	}
	
	//활동 전체 페이징 카운트
	public int getTotalcount(String id, String day_1, String day_2){
		int result= 0;
		String query="select count(*) from (\r\n" + 
				"    select tbl.* , rownum as rnum \r\n" + 
				"        from(\r\n" + 
				"            select * from (select no,title,to_char(dona_date,'yyyy-MM-dd') as dona_date ,amount, to_char(dona_date,'yyyy-MM') from mypage_dona_history where id ='"+id+"' union all \r\n" + 
				"select no,title,to_char(vol_date,'yyyy-MM-dd'),dum,to_char(vol_date,'yyyy-MM') from mypage_volun_history where id ='"+id+"' \r\n" + 
				") order by dona_date desc \r\n" + 
				"            ) tbl \r\n" + 
				"            )  where dona_date between '"+day_1+"' and '"+day_2+"'";
		try {
			con = DBConnection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
			}catch(SQLException e) {
				System.out.println("getTotalcount()메서드 오류");
				System.out.println("쿼리문 : " +query);
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
		return result;
	}

	//  활동내역
	public ArrayList <Mypage_dto> getActivity1day(String id, String day_1, String day_2,int end){
		ArrayList<Mypage_dto> dtos = new ArrayList<Mypage_dto>();
		String query="select * from (\r\n" + 
				"    select tbl.* , rownum as rnum \r\n" + 
				"        from(\r\n" + 
				"            select * from (select no,title,to_char(dona_date,'YYYY-MM-DD') as dona_date ,amount, to_char(dona_date,'YYYY-MM') from mypage_dona_history where id ='"+id+"' union all \r\n" + 
				"select no,title,to_char(vol_date,'yyyy-MM-dd'),dum,to_char(vol_date,'YYYY-MM') from mypage_volun_history where id ='"+id+"' \r\n" + 
				") order by dona_date desc \r\n" + 
				"            ) tbl \r\n" + 
				"            )  where dona_date between '"+day_1+"' and '"+day_2+"' and rnum >=1 and rnum <="+end+"";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				String no = rs.getString(1);
				String title = rs.getString(2);
				String dona_date = rs.getString(3);
				int amount = rs.getInt(4);
				String dona_date_month = rs.getString(5);
				Mypage_dto dto = new Mypage_dto(no,title,dona_date,amount,dona_date_month);
				dtos.add(dto);
			}
				
		}catch(SQLException e) {
			System.out.println("getActivity1day()오류"+ query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return dtos;	
	}
	
	//새소식 전체
	public ArrayList<Mypage_dto> getNotificationList_total(String id,String notification_yn){
		ArrayList<Mypage_dto> dtos = new ArrayList<Mypage_dto>();
		String tenago = CommonUtil.get10ago();
		String today = CommonUtil.getToday2();
		String query ="";
		if(notification_yn.equals("y")) {
			query="select * from (\r\n" + 
					"    select tbl.* , rownum as rnum \r\n" + 
					"        from(\r\n" + 
					"            select * from (select no,title,to_char(dona_date,'YYYY-MM-DD-HH24-MI-SS') as dona_date ,amount from mypage_dona_history where id ='"+id+"' union all \r\n" + 
					"select no,title,to_char(start_date,'YYYY-MM-DD-HH24-MI-SS'),dum from donation union all \r\n" + 
					"select no,title,to_char(vol_date,'YYYY-MM-DD-HH24-MI-SS'),dum from mypage_volun_history where id ='"+id+"' union all\r\n" + 
					"select no,title,to_char(start_date,'YYYY-MM-DD-HH24-MI-SS'),dum from volunteer \r\n" + 
					") order by dona_date desc \r\n" + 
					"            ) tbl \r\n" + 
					"            )  where dona_date between '"+tenago+"' and '"+today+"' and rnum >=1 and rnum <=10";
									
		}else {
			query="        select * from (\r\n" + 
					"    select tbl.* , rownum as rnum\r\n" + 
					"        from(\r\n" + 
					"            select * from (select no,title,to_char(dona_date,'YYYY-MM-DD-HH24-MI-SS') as dona_date ,amount from mypage_dona_history where id ='"+id+"') order by dona_date desc\r\n" + 
					"            ) tbl\r\n" + 
					"            ) where dona_date between '"+tenago+"' and '"+today+"' and rnum >=1 and rnum <=10\r\n"; 
		}
		System.out.println("새소식 전체"+query);
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				String no = rs.getString(1);
				String title = rs.getString(2);
				String dona_date = rs.getString(3);
				int amount = rs.getInt(4);
				Mypage_dto dto = new Mypage_dto(no,title,dona_date,amount);
				dtos.add(dto);
			}
				
		}catch(SQLException e) {
			System.out.println("getNotificationList_total()오류"+ query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return dtos;
}
	//새소식 홈
	public ArrayList<Mypage_dto> getNotificationList(String id){
		ArrayList<Mypage_dto> dtos = new ArrayList<Mypage_dto>();
		Member_dao mem_dao = new Member_dao();
		String notification_yn = mem_dao.notifi_yn(id);
		String query ="";
		if(notification_yn.equals("y")) {
			query="      select * from (\r\n" + 
					"    select tbl.* , rownum as rnum\r\n" + 
					"        from(\r\n" + 
					"            select * from (select no,title,to_char(dona_date,'YYYY-MM-DD-HH24-MI-SS') as dona_date ,amount from mypage_dona_history where id ='"+id+"' union all\r\n" + 
					"select no,title,to_char(start_date,'YYYY-MM-DD-HH24-MI-SS'),dum from donation union all\r\n" + 
					"select no,title,to_char(vol_date,'YYYY-MM-DD-HH24-MI-SS'),dum from mypage_volun_history union all\r\n" + 
					"select no,title,to_char(start_date,'YYYY-MM-DD-HH24-MI-SS'),dum from volunteer\r\n" + 
					") order by dona_date desc\r\n" + 
					"            ) tbl\r\n" + 
					"            )\r\n" + 
					"         where rnum >=1 and rnum <=3";
		}else {
			query="        select * from (\r\n" + 
					"    select tbl.* , rownum as rnum\r\n" + 
					"        from(\r\n" + 
					"            select * from (select no,title,to_char(dona_date,'YYYY-MM-DD-HH24-MI-SS"
					+ "') as dona_date ,amount from mypage_dona_history where id ='"+id+"') order by dona_date desc\r\n" + 
					"            ) tbl\r\n" + 
					"            )\r\n" + 
					"         where rnum >=1 and rnum <=3";
		}
		System.out.println(query);
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				String no = rs.getString(1);
				String title = rs.getString(2);
				String dona_date = rs.getString(3);
				int amount = rs.getInt(4);
				Mypage_dto dto = new Mypage_dto(no,title,dona_date,amount);
				dtos.add(dto);
			}
				
		}catch(SQLException e) {
			System.out.println("getNotificationList()오류"+ query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return dtos;
}
	
	//주간 봉사참여
	public int Mypage_home_week_vol(String id,String week, String today) {
		int week_count = 0;
		String query ="select count(*) from mypage_volun_history wHERE TO_CHAR(vol_date, 'yyyy-MM-dd-HH-mm-ss') between '"+week+"' and '"+today+"' and id = '"+id+"'\r\n" + 
				"";
		
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				 week_count = rs.getInt(1);
			}
				
		}catch(SQLException e) {
			System.out.println("Mypage_home_week_vol()오류"+ query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return week_count;
	}
	//전체 봉사참여
	public int Mypage_home_total_vol(String id) {
		int total_count = 0;
		String query ="select count(*) from mypage_volun_history where id = '"+id+"'\r\n" + 
				"";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				total_count = rs.getInt(1);
			}
				
		}catch(SQLException e) {
			System.out.println("Mypage_home_total_vol()오류"+ query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return total_count;
	}
	//일주일 후원금액
		public Mypage_dto Mypage_home_today_amount(String id,String week, String today) {
			Mypage_dto today_amount_dto = null;
			String query ="select sum(amount) from mypage_dona_history wHERE TO_CHAR(dona_date, 'yyyy-MM-dd-HH-mm-ss') between '"+week+"' and '"+today+"' and id = '"+id+"'";
			try {
				con = DBConnection.getConnection();
				ps = con.prepareStatement(query);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					int today_amount = rs.getInt(1);
					today_amount_dto = new Mypage_dto(today_amount,"");
				}
					
			}catch(SQLException e) {
				System.out.println("Mypage_home_today_amount()오류"+ query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			
			return today_amount_dto;
		}
	
	//총 후원금액
	public Mypage_dto Mypage_home_total_amount(String id) {
		Mypage_dto total_amount_dto = null;
		String query ="select sum(a.amount) from mypage_dona_history a, donation b, member c where a.no = b.no and a.id=c.id and a.id ='"+id+"'";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int total_amount = rs.getInt(1);
				total_amount_dto = new Mypage_dto(total_amount);
			}
				
		}catch(SQLException e) {
			System.out.println("Mypage_home_total_amount()오류"+ query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return total_amount_dto;
	}
	 
	//기본적인 마이페이지 후원 리스트 뽀아내기
	public Mypage_dto Mypage_home_history_dona(String id) {
		Mypage_dto my_dto = null;
		String query ="select a.no, a.title, a.dona_date, a.amount from mypage_dona_history a, donation b,member c where a.no = b.no and a.id=c.id and a.id ='"+id+"'";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String no = rs.getString(1);
				String title = rs.getString(2);
				String dona_date = rs.getString(3);
				int amount = rs.getInt(4);
				my_dto = new Mypage_dto(no,title,dona_date,amount);
			}
				
		}catch(SQLException e) {
			System.out.println("Mypage_home_history_dona()오류"+ query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return my_dto;
	}
}
