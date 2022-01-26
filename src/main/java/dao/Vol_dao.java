package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import common.DBConection;

import dto.Vol_dto;

public class Vol_dao {

	Connection con 			= null;
	PreparedStatement ps 	= null;
	ResultSet rs 			= null;


	//기부 데이터 삭제
	public int VolDelete(String no){
		int result = 0;
		String query = 
				"DELETE FROM volunteer \r\n" + 
				"WHERE no = '"+no+"'";
		try {
			con 	= DBConection.getConnection();
			ps 		= con.prepareStatement(query);
			result 	= ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("VolDelete() 메소드 실패");
			System.out.println("query : "+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
		}return result;
	}
	
	
	//기부 수정하기
	public int VolUpdate(Vol_dto dto) {
		int result = 0;
		String query = 
				"UPDATE volunteer\r\n" + 
				"SET \r\n" + 
				"title 							= '"+dto.getTitle()+"',\r\n" + 
				"voname 						= '"+dto.getVoname()+"',\r\n" + 
				"volunteersite 					= '"+dto.getVolunteersite()+"',\r\n" + 
				"end_date						= '"+dto.getEnd_date()+"',\r\n" + 
				"content 						= '"+dto.getContent()+"',\r\n" + 
				"attach 						= '"+dto.getAttach()+"',\r\n" + 
				"local 							= '"+dto.getLocal()+"',\r\n" + 
				"goal 							= "+dto.getGoal()+"\r\n" + 
				"where no 						= '"+dto.getNo()+"'";
		try {
			con 	= DBConection.getConnection();
			ps 		= con.prepareStatement(query);
			result 	= ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("VolUpdate() 메소드 실패");
			System.out.println("query : "+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
		}return result;
	}
	
	
	//자료실 상세보기
		public Vol_dto VolView(String no) {
			Vol_dto dto = null;
			String query = 
			"select "+ 
			"no, title, voname, volunteersite, "+
			"to_char(start_date,'yyyy-MM-dd'), to_char(end_date,'yyyy-MM-dd'), content, attach, local,goal,total,hit " +
			"from volunteer " +
			"where no = '"+no+"'";
			
			try {
				con 	= DBConection.getConnection();
				ps 		= con.prepareStatement(query);
				rs 		= ps.executeQuery();
				if(rs.next()) {
					String num 			= rs.getString(1);
					String title 		= rs.getString(2);
					String voname 		= rs.getString(3);
					String volunteersite 	= rs.getString(4);
					String start_date	= rs.getString(5);
					String end_date	 	= rs.getString(6);
					String content 		= rs.getString(7);
					String attach 		= rs.getString(8);
					String local 		= rs.getString(9);
					int goal 			= rs.getInt(10);
					int total 			= rs.getInt(11);
					int hit 			= rs.getInt(12);
					dto = new Vol_dto(no,title,voname,volunteersite,start_date,end_date,content,attach,local,goal,total,hit);
				}
			}catch(SQLException e) {
				System.out.println("VolView() 메소드 실패");
				System.out.println("query : "+query);
				e.printStackTrace();
			}finally {
				DBConection.closeDB(con, ps, rs);
			}return dto;
		}
	
	
	
	//조회수	
	public void setHitCount(String no) {
		int result = 0;
		String query =
				"update volunteer "+
				"set hit = hit + 1 "+
				"where no = '"+no+"'";
		
		try {
			con = DBConection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("setHitCount() 메소드 오류");
			System.out.println("query"+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
		}	
	}
	
	
	//게시글 번호 생성
	public String getMaxNo() {
		String no = "";
		String query =
				"select max(no) from volunteer ";
		
		try {
			con = DBConection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				no = rs.getString(1);
			}
			if (no.equals("")) {
				no = "V001";
			}else {
				String n = no.substring(1);
				int num = Integer.parseInt(n);
				num += 1;
				DecimalFormat df = new DecimalFormat("V000");
				no = df.format(num);
				
			}
		}catch(SQLException e){
			System.out.println("notice getMaxNo() 메소드 오류");
			System.out.println("query"+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
			
		}
		
		return no;
	}		
	//조회 카운트
		public int getTotalCount(String search) {
			int count = 0;
			String query =
					"select count(*) \r\n" + 
					"from volunteer\r\n" + 
					"where search like '%"+search+"%' \r\n" ; 
					
		
			try {
				con = DBConection.getConnection();
				ps = con.prepareStatement(query);
				rs = ps.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(SQLException e){
				System.out.println("getTotalCount() 메소드 오류");
				System.out.println("query : "+query);
				e.printStackTrace();
			}finally {
				DBConection.closeDB(con, ps, rs);
				
			}
			return count;
		}	
	
// 기부 저장 메소드//	
	public int VolSave(Vol_dto dto) {
		int result = 0;
		String query =
				"INSERT INTO \r\n" + 
				"volunteer \r\n" + 
				"VALUES \r\n" + 
				"('"+dto.getNo()+"','"+dto.getTitle()+"','"+dto.getVoname()+"', '"+dto.getVolunteersite()+"', '"+dto.getStart_date()+"','"+dto.getEnd_date()+"','"+dto.getContent()+"','"+dto.getAttach()+"','"+dto.getLocal()+"',"+dto.getGoal()+","+dto.getTotal()+",0)";
	
		try {
			con = DBConection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
			
		}catch(SQLException e){
			System.out.println("volSave() 메소드 오류");
			System.out.println("query : "+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
			
		}
		return result;
	}
	
	//리스트 전체 조회 + 검색기능 + 페이징
	public ArrayList<Vol_dto> VolList(String search,int start, int end){
		ArrayList<Vol_dto> dtos = new ArrayList<Vol_dto>();
				/*String query = 
				"select "+ 
				"no, title, doname, dominator, "+
				"to_char(start_date,'yyyy-MM-dd'), to_char(end_date,'yyyy-MM-dd'), content, attach, search,goal,total,hit " +
				"from donation " +
				"where search like '%%' " +
				"order by no desc ";*/
		String query = 
				"SELECT  * FROM\r\n" + 
				"(\r\n" + 
				"select rownum as rnum, a.* from\r\n" + 
				"(\r\n" + 
				"select \r\n" + 
				"no, title, voname,volunteersite, \r\n" + 
				"to_char(start_date,'yyyy-MM-dd'), to_char(end_date,'yyyy-MM-dd'), content, attach, local,goal,total,hit\r\n" + 
				"from volunteer\r\n" + 
				"where local like '%"+search+"%'\r\n" + 
				"order by no desc" +
				") a \r\n" + 
				")\r\n" + 
				"where rnum >="+start+" and rnum<= "+end+"";
		
			try {
				con 	= DBConection.getConnection();
				ps 		= con.prepareStatement(query);
				rs 		= ps.executeQuery();
				while(rs.next()) {
					String no 				= rs.getString(2);
					String title 			= rs.getString(3);
					String voname 			= rs.getString(4);
					String volunteersite 	= rs.getString(5);
					String start_date 		= rs.getString(6);
					String end_date 		= rs.getString(7);
					String content 			= rs.getString(8);
					String attach 			= rs.getString(9);
					String local 			= rs.getString(10);
					int goal 				= rs.getInt(11);
					int total 				= rs.getInt(12);
					int hit 				= rs.getInt(13);
					Vol_dto dto = new Vol_dto(no,title,voname,volunteersite,start_date,end_date,content,attach,local,goal,total,hit);
					dtos.add(dto);
					
				}
			}catch(SQLException e) {
				System.out.println("VolList() 메소드 실패");
				System.out.println("query : "+ query);
				e.printStackTrace();
				
			}finally {
				DBConection.closeDB(con, ps, rs);
			}
		return dtos;
	}		
	
}
