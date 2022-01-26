package team.pjt.dona;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import command.mypage.Mypage_activity;
import command.mypage.Mypage_activity_dona;
import command.mypage.Mypage_activity_vol;
import command.mypage.Mypage_home;
import command.mypage.Mypage_view;
import command.mypage.mypage_update;
import common.Command;
import dao.Member_dao;
import dto.Member_dto;

@Controller
public class MypageController {
	@RequestMapping("/Mypage_home")
	public String Mypage_home(HttpServletRequest request) {
		Command mypage = new Mypage_home();
		mypage.execute(request);
		return "member_mypage/my_page_home";
}
	@RequestMapping("/Mypage_update")
	public String Mypage_update(HttpServletRequest request) {
		Command mypage = new mypage_update();
		mypage.execute(request);
		return "member_mypage/my_page_update";
}
	@RequestMapping("/Mypage_news")
	public String Mypage_news(HttpServletRequest request) {
		Command mypage = new Mypage_view();
		mypage.execute(request);
		return "member_mypage/my_page_news";
}
	
	@RequestMapping("/Notification_change")
	public String Notification_change(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("t_id");
		PrintWriter out =null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Member_dao mem_dao = new Member_dao();
		String notification_yn_past = mem_dao.notifi_yn(id);
		int result = mem_dao.notifi_yn_change(id,notification_yn_past);
		
		String msg = result ==1 ? "change" : "fail";
		
		out.print(msg);
		return "member_mypage/my_page_news";
}
	@RequestMapping("/Mypage_activity")
	public String Mypage_activity(HttpServletRequest request) {
		Command mypage = new Mypage_activity();
		mypage.execute(request);
		return "member_mypage/my_page_activity";
}
	@RequestMapping("/Mypage_activity_dona")
	public String Mypage_activity_dona(HttpServletRequest request) {
		Command mypage = new Mypage_activity_dona();
		mypage.execute(request);
		return "member_mypage/my_page_activity_dona";
	}
	@RequestMapping("/Mypage_activity_vol")
	public String Mypage_activity_vol(HttpServletRequest request) {
		Command mypage = new Mypage_activity_vol();
		mypage.execute(request);
		return "member_mypage/my_page_activity_vol";
	}
	
	@RequestMapping("/Mypage_regular_payment")
	public String Mypage_regular_payment(HttpServletRequest request) {
		return "member_mypage/my_page_regular_payment";
}
	@RequestMapping("/Mypage_year")
	public String Mypage_year(HttpServletRequest request) {
		return "member_mypage/my_page_year";
}
	
	@RequestMapping("MemberTellCheck2")
	public void MemberTellCheck2(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");   //얘는 보낼 때 한글값 보내는 것인듯? HTML에서 utf8과 속성이 같도록 response클래스의 setContenttype의 속성을 지정해주는 것
		Member_dao dao = new Member_dao();
		String tell = request.getParameter("t_tell");
		String id = request.getParameter("t_id");
		int count = dao.getTellCount_update(tell,id);
		PrintWriter out =null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String msg = count ==1 ? "연락처가 중복됩니다" : "사용가능";
		
			out.print(msg);
	}
	
	@RequestMapping("MemberEellCheck2")
	public void MemberEellCheck2(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");   //얘는 보낼 때 한글값 보내는 것인듯? HTML에서 utf8과 속성이 같도록 response클래스의 setContenttype의 속성을 지정해주는 것
		Member_dao dao = new Member_dao();
		String email = request.getParameter("t_email");
		String id = request.getParameter("t_id");
		int count = dao.getEmailCount_update(email,id);
		PrintWriter out =null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String msg = count ==1 ? "이메일이 중복됩니다" : "사용가능";
		
			out.print(msg);
	}
	//패스워드 미포함
	@RequestMapping("MemberUpdate")
	public String MemberUpdate(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");   //얘는 보낼 때 한글값 보내는 것인듯? HTML에서 utf8과 속성이 같도록 response클래스의 setContenttype의 속성을 지정해주는 것
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Member_dao dao = new Member_dao();
	
		String id			= request.getParameter("t_id");
		String name         = request.getParameter("t_name");
		String email         = request.getParameter("t_email");
		String tell         =  request.getParameter("t_tell");
		String address_1 = request.getParameter("t_address_1");
		String address_2 = request.getParameter("t_address_2");
		String info_yn = request.getParameter("t_info_yn");
		
		
		Member_dto dto = new Member_dto(id,name,email,tell,address_1,address_2,info_yn);
		int result = dao.memberUpdate(dto);
		String msg="";
		if(result == 1) msg =name+"님 개인정보가 수정되었습니다.";
		else msg = "개인정보 수정에 실패하였습니다. 관리자에게 문의바람!";
		
		request.setAttribute("t_result", result);
		request.setAttribute("t_msg", msg);
		request.setAttribute("t_url", "/Mypage_update");
		request.setAttribute("t_id", id);
	
		
		return "common_alert_page";
	}
	//패스워드 포함
	@RequestMapping("MemberUpdate_2")
	public String MemberUpdate_2(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");   //얘는 보낼 때 한글값 보내는 것인듯? HTML에서 utf8과 속성이 같도록 response클래스의 setContenttype의 속성을 지정해주는 것
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Member_dao dao = new Member_dao();
	
		String id			= request.getParameter("t_id");
		String name         = request.getParameter("t_name");
		String password     = request.getParameter("t_pw");
		String email         = request.getParameter("t_email");
		String tell         =  request.getParameter("t_tell");
		String address_1 = request.getParameter("t_address_1");
		String address_2 = request.getParameter("t_address_2");
		String info_yn = request.getParameter("t_info_yn");
		
		try {
			password = dao.encryptSHA256(password);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Member_dto dto = new Member_dto(id,name,password,email,tell,address_1,address_2,info_yn);
		int result = dao.memberUpdate2(dto);
		String msg="";
		if(result == 1) msg =name+"님 개인정보가 수정되었습니다.";
		else msg = "개인정보 수정에 실패하였습니다. 관리자에게 문의바람!";
		
		request.setAttribute("t_result", result);
		request.setAttribute("t_msg", msg);
		request.setAttribute("t_url", "/Mypage_update");
		request.setAttribute("t_id", id);
	
		return "common_alert_page";
	}
}
