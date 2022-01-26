package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import common.DBConnection;
import dto.Dona_dto;
import dto.Local_dto;

public class Local_dao {
	
	Connection con 			= null;
	PreparedStatement ps 	= null;
	ResultSet rs 			= null;


	//기부 데이터 삭제
	public int LocalDelete(String no){
		int result = 0;
		String query = 
				"DELETE FROM localnews \r\n" + 
				"WHERE no = '"+no+"'";
		try {
			con 	= DBConnection.getConnection();
			ps 		= con.prepareStatement(query);
			result 	= ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("DonaDelete() 메소드 실패");
			System.out.println("query : "+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}return result;
	}
	
	
	//기부 수정하기
	public int LocalUpdate(Local_dto dto) {
		int result = 0;
		String query = 
				"UPDATE localnews\r\n" + 
				"SET \r\n" + 
				"title 							= '"+dto.getTitle()+"',\r\n" + 
				"news_name						= '"+dto.getNews_name()+"',\r\n" + 
				
				"reg_date						= '"+dto.getReg_date()+"',\r\n" + 
				"content 						= '"+dto.getContent()+"',\r\n" + 
				"attach 						= '"+dto.getAttach()+"',\r\n" + 
				"search 						= '"+dto.getSearch()+"'\r\n" + 

				"where no 						= '"+dto.getNo()+"'";
		try {
			con 	= DBConnection.getConnection();
			ps 		= con.prepareStatement(query);
			result 	= ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("LocalUpdate() 메소드 실패");
			System.out.println("query : "+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}return result;
	}
	
	
	//자료실 상세보기
		public Local_dto LocalView(String no) {
			Local_dto dto = null;
			String query = 
			"select "+ 
			"no, title, news_name, "+
			"to_char(reg_date,'yyyy-MM-dd'), content, attach, search, hit, reg_id " +
			"from localnews " +
			"where no = '"+no+"'";
			
			try {
				con 	= DBConnection.getConnection();
				ps 		= con.prepareStatement(query);
				rs 		= ps.executeQuery();
				if(rs.next()) {
					String num 			= rs.getString(1);
					String title 		= rs.getString(2);
					String news_name 		= rs.getString(3);
					
					String reg_date	= rs.getString(4);
					
					String content 		= rs.getString(5);
					String attach 		= rs.getString(6);
					String search 		= rs.getString(7);
					
					int hit 			= rs.getInt(8);
					String reg_id 		= rs.getString(9);
					dto = new Local_dto(num,title,news_name,reg_date,content,attach,search,hit,reg_id);
				}
			}catch(SQLException e) {
				System.out.println("LocalView() 메소드 실패");
				System.out.println("query : "+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}return dto;
		}
	
	
	
	//조회수	
	public void setHitCount(String no) {
		int result = 0;
		String query =
				"update localnews "+
				"set hit = hit + 1 "+
				"where no = '"+no+"'";
		
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("setHitCount() 메소드 오류");
			System.out.println("query"+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}	
	}
	
	
	//게시글 번호 생성
	public String getMaxNo() {
		String no = "";
		String query =
				"select max(no) from localnews ";
		
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				no = rs.getString(1);
			}
			if (no.equals("")) {
				no = "N001";
			}else {
				String n = no.substring(1);
				int num = Integer.parseInt(n);
				num += 1;
				DecimalFormat df = new DecimalFormat("N000");
				no = df.format(num);
				
			}
		}catch(SQLException e){
			System.out.println("notice getMaxNo() 메소드 오류");
			System.out.println("query"+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
			
		}
		
		return no;
	}		
	//조회 카운트
		public int getTotalCount(String search) {
			int count = 0;
			String query =
					"select count(*) \r\n" + 
					"from localnews\r\n" + 
					"where search like '%"+search+"%' \r\n" ; 
					
		
			try {
				con = DBConnection.getConnection();
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
				DBConnection.closeDB(con, ps, rs);
				
			}
			return count;
		}	
	
// 기부 저장 메소드//	
	public int LocalSave(Local_dto dto) {
		int result = 0;
		String query =
				"INSERT INTO \r\n" + 
				"localnews \r\n" + 
				"VALUES \r\n" + 
				"('"+dto.getNo()+"','"+dto.getTitle()+"','"+dto.getNews_name()+"', '"+dto.getReg_date()+"','"+dto.getContent()+"','"+dto.getAttach()+"','"+dto.getSearch()+"',0,'"+dto.getReg_id()+"')";
	
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
			
		}catch(SQLException e){
			System.out.println("LocalSave() 메소드 오류");
			System.out.println("query : "+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
			
		}
		return result;
	}
	
	//리스트 전체 조회 + 검색기능 + 페이징
	public ArrayList<Local_dto> LocalList(String search1,int start, int end){
		ArrayList<Local_dto> dtos = new ArrayList<Local_dto>();
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
				"no, title, news_name, \r\n" + 
				"to_char(reg_date,'yyyy-MM-dd'), content, attach, search, hit, reg_id\r\n" + 
				"from localnews\r\n" + 
				"where search like '%"+search1+"%'\r\n" + 
				"order by no desc" +
				") a \r\n" + 
				")\r\n" + 
				"where rnum >="+start+" and rnum<= "+end+"";
		
			try {
				con 	= DBConnection.getConnection();
				ps 		= con.prepareStatement(query);
				rs 		= ps.executeQuery();
				while(rs.next()) {
					String no 			= rs.getString(2);
					String title 		= rs.getString(3);
					String news_name 	= rs.getString(4);
					
					String reg_date 	= rs.getString(5);
					
					String content 		= rs.getString(6);
					String attach 		= rs.getString(7);
					String search 		= rs.getString(8);
					
					int hit 			= rs.getInt(9);
					String reg_id 		= rs.getString(10);
					Local_dto dto = new Local_dto(no,title,news_name,reg_date,content,attach,search,hit,reg_id);
					dtos.add(dto);
					
				}
			}catch(SQLException e) {
				System.out.println("LocalList() 메소드 실패");
				System.out.println("query : "+ query);
				e.printStackTrace();
				
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
		return dtos;
	}		
	
	
}
