package dao;

import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConection;
import dto.Missing_dto;


public class Missing_dao{
	Connection con 		 = null;
	PreparedStatement ps = null;
	ResultSet rs 		 = null;
	
	//삭제
	public int missingDelete(String no){
		int result = 0;
		String query = 
				"DELETE FROM missing_find " + 
				"WHERE no = '"+no+"'";
		try {
			con 	= DBConection.getConnection();
			ps 		= con.prepareStatement(query);
			result 	= ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("missingDelete() 메소드 실패");
			System.out.println("query : "+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
		}return result;
	}	
	
	//수정정장
	public int updateMissingClob(Missing_dto dto){
		int result =0;
		String query ="update missing_find \r\n" + 
				"set name ='"+dto.getName()+"',\r\n" + 
				"    age		='"+dto.getAge()+"',\r\n" + 
				"    gender     ='"+dto.getGender()+"',\r\n" + 
				"    lost_date  ='"+dto.getLost_date()+"',\r\n" + 
				"    lost_time  ='"+dto.getLost_time()+"',\r\n" + 
				"    lost_area  ='"+dto.getLost_area()+"',\r\n" + 
				"    lost_place ='"+dto.getLost_place()+"',\r\n" + 
				"    lat        ='"+dto.getLat()+"',\r\n" + 
				"    lng        ='"+dto.getLng()+"',\r\n" + 
				"    content    =? , \r\n" + 
				"    attach     ='"+dto.getAttach()+"' \r\n" + 
				"where no ='"+dto.getNo()+"'";
		try {
		    
			con	= DBConection.getConnection();
			con.setAutoCommit(false); //* 추가  
			StringReader sreader = new StringReader(dto.getContent()); //* 추가 
			ps  = con.prepareStatement(query);
			ps.setCharacterStream(1,sreader, dto.getContent().length()); //* 추가 
			result = ps.executeUpdate();
		    con.commit(); //* 추가 
		    con.setAutoCommit(true);//* 추가 			    
		    
		}catch(SQLException e) {
			System.out.println("notice updateMissingClob()오류~");
			System.out.println(query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
		}
		return result;
	}	

	
	
	//상세 조회
	public Missing_dto getMissingView(String no){
 		Missing_dto dto= null;
		String query=" "+
			" 		select  a.no,a.name,a.age,decode(a.gender,'f','여','남') as gender,to_char(a.lost_date,'yyyy-MM-dd') lost_date, a.lost_time, a.lost_area,a.lost_place,a.lat,a.lng,\r\n" + 
			"				a.content,a.attach,b.name as reg_info,to_char(a.reg_date,'yyyy-MM-dd') reg_date,a.hit, "+
			"				substr(b.tell,1,3)||'-'||substr(b.tell,4,4)||'-'||substr(b.tell,8) as tell " + 
			"		from missing_find a, member b \r\n" + 
			"		where a.reg_info = b.id "+
			" 		and a.no='"+no+"'";

		try {
			con = DBConection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			while(rs.next()){
//				String no			= rs.getString(1);	
				String name         = rs.getString(2);	
				String age			= rs.getString(3);
				String gender       = rs.getString(4);	
				String lost_date    = rs.getString(5);	
				String lost_time    = rs.getString(6);	
				String lost_area    = rs.getString(7);	
				String lost_place   = rs.getString(8);	
				String lat          = rs.getString(9);	
				String lng          = rs.getString(10);	
				String content      = rs.getString(11);		
				String attach       = rs.getString(12);	 	
				String reg_id       = rs.getString(13);	 	 
				String reg_date     = rs.getString(14);	  
				int    hit	        = rs.getInt(15);	
				String guardian_tell= rs.getString(16);	
				dto = new Missing_dto(no,name,age,gender,lost_date,lost_time,lost_area,lost_place,lat,lng,
						content,attach,reg_id,reg_date,hit,guardian_tell);
			} 
		}catch(SQLException e) {
			System.out.println("getMissingView() 오류");
			System.out.println("query :"+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
		}
		return dto;
	}	
	
	// 조회수 증가
	public void setHitCount(String no){
		String query ="update missing_find " + 
					" set hit = hit +1 " + 
					" where no ='"+no+"'";
		try {
			con = DBConection.getConnection();
			ps 	= con.prepareStatement(query);
			ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("setHitCount() 메소드 오류~ ");
			System.out.println("query :"+query);
			e.printStackTrace();
		} finally {
			DBConection.closeDB(con, ps, rs);
		}
	}		
	
	//목록 조회
	public ArrayList<Missing_dto> getMissingList(String s_lost_area, String s_lost_date_start,String s_lost_date_end,String s_gender,int start, int end){
 		ArrayList<Missing_dto> dtos= new ArrayList<>();
		String query=" "+
			"select * from " + 
			"( " + 
			"    select tbl.*, rownum as rnum \r\n" + 
			"    from \r\n" + 
			"    ( " + 
			" 		select  a.no,a.name,a.age,decode(a.gender,'f','여','남') as gender,to_char(a.lost_date,'yyyy-MM-dd') lost_date,a.lost_time,a.lost_area,a.lost_place,a.lat,a.lng,\r\n" + 
			"				a.content,a.attach,b.name as reg_info,to_char(a.reg_date,'yyyy-MM-dd') reg_date,a.hit, "+
			"				substr(b.tell,1,3)||'-'||substr(b.tell,4,4)||'-'||substr(b.tell,8) as tell " + 
			"		from missing_find a, member b \r\n" + 
			"		where a.reg_info = b.id ";
			if(s_lost_area != null) {
				query +=  " and a.lost_area = '"+s_lost_area+"' "+		
						  " and a.lost_date >= '"+s_lost_date_start+"' and a.lost_date <= '"+s_lost_date_end+"' ";
				if(!s_gender.equals("all"))  query +=" and a.gender ='"+s_gender+"'	";
			}
			query +=
			" 		order by a.no desc" +
			"    ) tbl \r\n" + 
			")    \r\n" + 
			"where rnum >="+start+" and rnum <="+end+" ";  

		try {
			con = DBConection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			while(rs.next()){
				String no			= rs.getString(1);	
				String name         = rs.getString(2);	
				String age			= rs.getString(3);
				String gender       = rs.getString(4);	
				String lost_date    = rs.getString(5);	
				String lost_time    = rs.getString(6);	
				String lost_area    = rs.getString(7);	
				String lost_place   = rs.getString(8);	
				String lat          = rs.getString(9);	
				String lng          = rs.getString(10);	
				String content      = rs.getString(11);	
				String attach       = rs.getString(12);	 
				String reg_id       = rs.getString(13);	  
				String reg_date     = rs.getString(14);
				int    hit	        = rs.getInt(15);				
                String guardian_tell= rs.getString(16);	
				Missing_dto dto = new Missing_dto(no,name,age,gender,lost_date,lost_time,lost_area,lost_place,lat,lng,
						content,attach,reg_id,reg_date,hit,guardian_tell);
				dtos.add(dto);
			} 
		}catch(SQLException e) {
			System.out.println("getMissingList() 오류");
			System.out.println("query :"+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
		}
		return dtos;
	}
	
	
	// 조회 카운트
	public int getTotalCount(String s_lost_area, String s_lost_date_start,String s_lost_date_end,String s_gender){
		int count =0;
		String query="select count(*) from missing_find " ; 
				if(s_lost_area != null) {
					query +=  " where lost_area = '"+s_lost_area+"' "+		
							  " and lost_date >= '"+s_lost_date_start+"' and lost_date <= '"+s_lost_date_end+"' ";
					if(!s_gender.equals("all"))  query +=" and gender ='"+s_gender+"'	";
				}
		
		try {
			con = DBConection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		}catch(SQLException e) {
			System.out.println("missing getTotalCount() 오류");
			System.out.println("query :"+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
		}		
		return count;
	}	
	
	// 게시글 번호 생성
	public String getMaxNo(){
		String no ="";
		String query="select 'M'||LPAD(substr(nvl(max(no),'M0000'),2)+1,4,0) "+
				     " from missing_find"; 
		try {
			con = DBConection.getConnection();
			ps  = con.prepareStatement(query);
			rs  = ps.executeQuery();
			if(rs.next()) {
				no = rs.getString(1); 
			}

		}catch(SQLException e) {
			System.out.println("missing getMaxNo() 오류 : "+query);
			e.printStackTrace();
		} finally {
			DBConection.closeDB(con, ps, rs);
		}
		return no;
	}	
	
	//등록 clob
	public int saveMissinClob(Missing_dto dto){
		int result =0;
		String query="insert into missing_find \r\n" + 
				"(no,name,age,gender,lost_date,lost_time,lost_area,lost_place,lat,lng,content,attach,reg_info,reg_date) \r\n" + 
				"values " + 
				"('"+dto.getNo()+"','"+dto.getName()+"','"+dto.getAge()+"','"+dto.getGender()+"','"+dto.getLost_date()+"', '"+dto.getLost_time()+"',"+
				"'"+dto.getLost_area()+"','"+dto.getLost_place()+"','"+dto.getLat()+"', "+
				"'"+dto.getLng()+"',?,'"+dto.getAttach()+"','"+dto.getReg_info()+"','"+dto.getReg_date()+"')";
		try {
			con = DBConection.getConnection();
			con.setAutoCommit(false); //* 추가
			StringReader sreader = new StringReader(dto.getContent()); //* 추가 
			ps  = con.prepareStatement(query);
			ps.setCharacterStream(1,sreader, dto.getContent().length()); //* 추가 
			result = ps.executeUpdate();
		    con.commit(); //* 추가 
		    con.setAutoCommit(true);//* 추가 
		}catch(SQLException e) {
			System.out.println("missing saveMissinClob()오류~");
			System.out.println("query :"+query);
			e.printStackTrace();
		}finally {
			DBConection.closeDB(con, ps, rs);
		}
		return result;
	}	

}









