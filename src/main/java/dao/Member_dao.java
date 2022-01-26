package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.DBConnection;
import dto.Member_dto;

public class Member_dao {
		Connection 			con = null;
		PreparedStatement 	ps 	= null;
		ResultSet 			rs 	= null;
		
		//noti_yn 변환
		public int notifi_yn_change(String id,String notification_yn_past) {
			int result = 0;
			String query="";
			if(notification_yn_past.equals("y")) {
				query = "update member set notification_yn = 'n' where id='"+id+"'";
			}else {
				query = "update member set notification_yn = 'y' where id='"+id+"'";
			}
			   try {
			         con = DBConnection.getConnection();
			         ps = con.prepareStatement(query);
			         result = ps.executeUpdate();
			}catch(SQLException e) {
				System.out.println("notifi_yn_change() 오류");
				System.out.println("query :"+query);
				e.printStackTrace();			
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		
		//notif_yn 값 가져오기
		public String notifi_yn(String id) {
			String notification_yn = "";
			String query = "select notification_yn from member where id ='"+id+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				if(rs.next()){
					notification_yn = rs.getString(1);
				}
			}catch(SQLException e) {
				System.out.println("notifi_yn() 오류");
				System.out.println("query :"+query);
				e.printStackTrace();			
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return notification_yn;
		}
		
		//멤버 수정저장(패스워드 포함) 
		public int memberUpdate2(Member_dto dto){
			int result = 0;
			String query ="update member set name = '"+dto.getName()+"',\r\n" + 
					"                  password = '"+dto.getPassword()+"',\r\n" + 
					"                  email = '"+dto.getEmail()+"',\r\n" + 
					"                  tell = '"+dto.getTell()+"',\r\n" + 
					"                  address_1 = '"+dto.getAddress_1()+"',\r\n" + 
					"                  address_2 = '"+dto.getAddress_2()+"',\r\n" + 
					"                  info_yn = '"+dto.getInfo_yn()+"'\r\n" + 
					"                  where id = '"+dto.getId()+"'";
			
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(SQLException e) {
				System.out.println("memberUpdate()_2 오류");
				System.out.println("query : "+query);
				e.printStackTrace();
			} finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		//멤버 수정저장 (패스워드 미포함)
		public int memberUpdate(Member_dto dto){
			int result = 0;
			String query ="update member set name = '"+dto.getName()+"',\r\n" + 
					"                  email = '"+dto.getEmail()+"',\r\n" + 
					"                  tell = '"+dto.getTell()+"',\r\n" + 
					"                  address_1 = '"+dto.getAddress_1()+"',\r\n" + 
					"                  address_2 = '"+dto.getAddress_2()+"',\r\n" + 
					"                  info_yn = '"+dto.getInfo_yn()+"'\r\n" + 
					"                  where id = '"+dto.getId()+"'";
			
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(SQLException e) {
				System.out.println("memberUpdate() 오류");
				System.out.println("query : "+query);
				e.printStackTrace();
			} finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		 
		// 이메일 수정 중복검사 O
		   public int getEmailCount_update(String email, String id) {
		      int result = 0;
		      String query = "select count(*) from member where email ='"+email+"' and id != '"+id+"'";
		      System.out.println("query : "+query);
		 
		      try {
		         con = DBConnection.getConnection();
		         ps = con.prepareStatement(query);
		         rs = ps.executeQuery();
		         if(rs.next()) {
		            result = rs.getInt(1);
		            System.out.println(result);
		         }
		      }catch(SQLException e){
		         System.out.println("getEmailCount_update() 메소드 오류");
		         System.out.println("query : "+query);
		         e.printStackTrace();
		      }finally {
		         DBConnection.closeDB(con, ps, rs);         
		      }
		      
		      return result;
		   }
		
		// 연락처 수정 중복검사 O
		   public int getTellCount_update(String tell, String id) {
		      int result = 0;
		      String query = "select count(*) from member where tell ='"+tell+"' and id != '"+id+"'";
		      System.out.println("query : "+query);
		 
		      try {
		         con = DBConnection.getConnection();
		         ps = con.prepareStatement(query);
		         rs = ps.executeQuery();
		         if(rs.next()) {
		            result = rs.getInt(1);
		            System.out.println(result);
		         }
		      }catch(SQLException e){
		         System.out.println("getTellCount_update() 메소드 오류");
		         System.out.println("query : "+query);
		         e.printStackTrace();
		      }finally {
		         DBConnection.closeDB(con, ps, rs);         
		      }
		      
		      return result;
		   }
		   
		//회원 상세조회 O
		public Member_dto getMemberView(String id) {
			Member_dto dto = null;
			String query = "select id,name,password,email,tell,info_yn,reg_date,exit_date,exit,address_1,address_2,notification_yn from member where id ='"+id+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				if(rs.next()){
					String idd 		= rs.getString(1);
					String name 	= rs.getString(2);
					String password = rs.getString(3);
					String email 	= rs.getString(4);
					String tell   = rs.getString(5);
					String info_yn = rs.getString(6);
					String reg_date = rs.getString(7);
					String exit = rs.getString(8);
					String exit_date = rs.getString(9);
					String address_1 = rs.getString(10);
					String address_2 = rs.getString(11);
					String notification_yn = rs.getString(12);
					dto = new Member_dto(idd,name,password,email,tell,address_1,address_2,info_yn,reg_date,exit_date,exit,notification_yn);
				}
			}catch(SQLException e) {
				System.out.println("getMemberView() 오류");
				System.out.println("query :"+query);
				e.printStackTrace();			
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return dto;
		
		}
		   //비밀번호 변경저장 : 비번 메일 발송 후 O
		   public int setPassword(String id, String password) {
		      int result = 0;
		      String query ="update member \r\n" + 
		            " set password = '"+password+"'"  + 
		            " where id ='"+id+"' "; 
		      try {
		         con = DBConnection.getConnection();
		         ps  = con.prepareStatement(query);
		         result = ps.executeUpdate();
		      }catch(SQLException e) {
		         System.out.println("setPassword() 오류");
		         System.out.println("query : "+query);
		         e.printStackTrace();
		      } finally {
		         DBConnection.closeDB(con, ps, rs);
		      }      
		      
		      return result;
		   }

		//비밀번호찾기_이름찾기 O
		public String getEmailFindPw(String id, String email,String tell) {
		    String name= "";  
		   	String query = 
		            "select name from member where id = '"+id+"' and email ='"+email+"' and tell='"+tell+"'";
		   			System.out.println(query);
		      try {
		         con = DBConnection.getConnection();
		         ps = con.prepareStatement(query);
		         rs = ps.executeQuery();
		         if(rs.next()) {
		           name = rs.getString(1);
		            System.out.println(name);
		         }
		      }catch(SQLException e){
		         System.out.println("getEmailFindPw() 메소드 오류");
		         System.out.println("query : "+query);
		         e.printStackTrace();
		      }finally {
		         DBConnection.closeDB(con, ps, rs);         
		      }
		      
		      return name;
		   }
		
		//아이디 찾기_번호 O
		   public String getIdFind(String name,String tell) {
			    String find_id = "";  
			   	String query = 
			            "select id from member where name = '"+name+"' and tell ='"+tell+"'";
			 
			      try {
			         con = DBConnection.getConnection();
			         ps = con.prepareStatement(query);
			         rs = ps.executeQuery();
			         if(rs.next()) {
			           find_id = rs.getString(1);
			            System.out.println(find_id);
			         }
			      }catch(SQLException e){
			         System.out.println("getIdFind() 메소드 오류");
			         System.out.println("query : "+query);
			         e.printStackTrace();
			      }finally {
			         DBConnection.closeDB(con, ps, rs);         
			      }
			      
			      return find_id;
			   }
		   
		 //아이디 찾기 이메일 O
		   public String getIdFindEmail(String name,String email) {
			    String find_id = "";  
			   	String query = 
			            "select id from member where name = '"+name+"' and email ='"+email+"'";
			 
			      try {
			         con = DBConnection.getConnection();
			         ps = con.prepareStatement(query);
			         rs = ps.executeQuery();
			         if(rs.next()) {
			           find_id = rs.getString(1);
			            System.out.println(find_id);
			         }
			      }catch(SQLException e){
			         System.out.println("getIdFindEmail() 메소드 오류");
			         System.out.println("query : "+query);
			         e.printStackTrace();
			      }finally {
			         DBConnection.closeDB(con, ps, rs);         
			      }
			      
			      return find_id;
			   }
		   
		   
		// 아이디 중복검사 O
		   public int getIdCount(String id) {
		      int result = 0;
		      String query = 
		            "select count(*)\r\n" + 
		            "from member where id = '"+id+"'";
		      System.out.println("query : "+query);
		 
		      try {
		         con = DBConnection.getConnection();
		         ps = con.prepareStatement(query);
		         rs = ps.executeQuery();
		         if(rs.next()) {
		            result = rs.getInt(1);
		            System.out.println(result);
		         }
		      }catch(SQLException e){
		         System.out.println("getIdCount() 메소드 오류");
		         System.out.println("query : "+query);
		         e.printStackTrace();
		      }finally {
		         DBConnection.closeDB(con, ps, rs);         
		      }
		      
		      return result;
		   }
		   
		// 연락처 중복검사 O
		   public int getTellCount(String tell) {
		      int result = 0;
		      String query = 
		            "select count(*)\r\n" + 
		            "from member where tell = '"+tell+"'";
		      System.out.println("query : "+query);
		 
		      try {
		         con = DBConnection.getConnection();
		         ps = con.prepareStatement(query);
		         rs = ps.executeQuery();
		         if(rs.next()) {
		            result = rs.getInt(1);
		            System.out.println(result);
		         }
		      }catch(SQLException e){
		         System.out.println("getTellCount() 메소드 오류");
		         System.out.println("query : "+query);
		         e.printStackTrace();
		      }finally {
		         DBConnection.closeDB(con, ps, rs);         
		      }
		      
		      return result;
		   }
		   
			// 이메일 중복검사 O
		   public int getEmailCount(String email) {
		      int result = 0;
		      String query = 
		            "select count(*)\r\n" + 
		            "from member where email = '"+email+"'";
		      System.out.println("query : "+query);
		      
		      try {
		         con = DBConnection.getConnection();
		         ps = con.prepareStatement(query);
		         rs = ps.executeQuery();
		         if(rs.next()) {
		            result = rs.getInt(1);
		            System.out.println(result);
		         }
		      }catch(SQLException e){
		         System.out.println("getEmailCount() 메소드 오류");
		         System.out.println("query : "+query);
		         e.printStackTrace();
		      }finally {
		         DBConnection.closeDB(con, ps, rs);         
		      }
		      
		      return result;
		   }
		   
		//로그인O
		public String getLoginName(String id, String password){
			String name="";
			String query="select name \r\n" + 
					" from member \r\n" + 
					" where id ='"+id+"' \r\n" + 
					" and password ='"+password+"'";
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				rs  = ps.executeQuery();
				if(rs.next()) {
					name = rs.getString(1);
				}
			}catch(SQLException e) {
				System.out.println("getLoginName()오류");
				System.out.println("query : "+query);
				e.printStackTrace();
			}finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return name;
		}
		
	
		// 회원가입 O
		public int memberSave(Member_dto dto){
			int result = 0;
			String query ="insert into member (id,name,password,email,tell,address_1,address_2,info_yn,reg_date) \r\n" + 
					"values('"+dto.getId()+"','"+dto.getName()+"','"+dto.getPassword()+"','"+dto.getEmail()+"','"+dto.getTell()+"','"+dto.getAddress_1()+"','"+dto.getAddress_2()+"','"+dto.getInfo_yn()+"','"+dto.getReg_date()+"')";
			
			try {
				con = DBConnection.getConnection();
				ps  = con.prepareStatement(query);
				result = ps.executeUpdate();
			}catch(SQLException e) {
				System.out.println("memberSave() 오류");
				System.out.println("query : "+query);
				e.printStackTrace();
			} finally {
				DBConnection.closeDB(con, ps, rs);
			}
			return result;
		}
		   public String encryptSHA256(String value) throws NoSuchAlgorithmException{
		        String encryptData ="";
		         
		        MessageDigest sha = MessageDigest.getInstance("SHA-256");
		        sha.update(value.getBytes());
		 
		        byte[] digest = sha.digest();
		        for (int i=0; i<digest.length; i++) {
		            encryptData += Integer.toHexString(digest[i] &0xFF).toUpperCase();
		        }
		         
		        return encryptData;
		    }
}
