package team.pjt.dona;


import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.Member_dao;
import mail.MailContent;
import net.nurigo.java_sdk.examples.Message.ExampleSend;

@Controller 
public class MemberController {
	
	@RequestMapping("bunho")
		public String bunho(HttpServletRequest request){
		int check_num = 0;
		check_num = (int)(Math.random()*899)+100;

			String bunho_1 = request.getParameter("t_bunho_1");
			String bunho_2 = request.getParameter("t_bunho_2");
			String bunho_3 = request.getParameter("t_bunho_3");
			
			String bunho = bunho_1+bunho_2+bunho_3;
			
			ExampleSend.sendMessage(bunho,check_num);
			
			request.setAttribute("t_bunho_1", bunho_1);
			request.setAttribute("t_bunho_2", bunho_2);
			request.setAttribute("t_bunho_3", bunho_3);
			request.setAttribute("t_check_num", check_num);
			System.out.println(check_num);
			
		return "member/non_member_donate";
		
	}
	@RequestMapping("bunho2")
	public String bunho2(HttpServletRequest request){

		return "member/join_bunho_injung";
}
	@RequestMapping("bunho3")
	public String bunho3(HttpServletRequest request){
		int check_num = 0;
		check_num = (int)(Math.random()*899)+100;
		String tell = request.getParameter("t_tell");
		Member_dao dao = new Member_dao();
		int result = dao.getTellCount(tell);
		String msg="";
		
		if(result==1) {
			System.out.println("연락처 중복");
			msg="연락처 중복";
			request.setAttribute("t_msg", msg);
			return "member/join_bunho_injung";
		}else {
			ExampleSend.sendMessage(tell,check_num);
			request.setAttribute("t_tell", tell);
			request.setAttribute("t_check_num", check_num);
			System.out.println(check_num);
			msg="인증번호가 발송되었습니다";
			request.setAttribute("t_msg", msg);
			request.setAttribute("t_tell", tell);
			return "member/join_bunho_injung";
		}
	
}
	@RequestMapping("Bunho_find_id")
	public String Bunho_find_id(HttpServletRequest request){
		int check_num = 0;
		check_num = (int)(Math.random()*899)+100;
		String name = request.getParameter("t_name_tell");
		String tell = request.getParameter("t_tell");
		Member_dao dao = new Member_dao();
		String found_id = dao.getIdFind(name,tell);
		String msg="";
		
		if(found_id.equals("")) {
			msg="가입된 정보가 없습니다";
			System.out.println("msg: "+msg);
			request.setAttribute("t_msg", msg);
			request.setAttribute("t_tell", tell);
			request.setAttribute("t_name_tell", name);
			return "member/find_id";
		}else {
			ExampleSend.sendMessage(tell,check_num);
			request.setAttribute("t_tell", tell);
			request.setAttribute("t_check_num", check_num);
			System.out.println(check_num);
			msg="인증번호가 발송되었습니다";
			request.setAttribute("t_msg", msg);
			request.setAttribute("t_tell", tell);
			request.setAttribute("t_name_tell", name);
			request.setAttribute("t_found_id", found_id);
			return "member/find_id";
		}
	
}
	@RequestMapping("Email_find_id")
	public String Email_find_id(HttpServletRequest request) {
		int check_num = 0;
		check_num = (int)(Math.random()*899)+100;
		String name = request.getParameter("t_name_email");
		String email = request.getParameter("t_email");
		Member_dao dao = new Member_dao();
		String found_id_2 = dao.getIdFindEmail(name,email);
		String msg_2="";
		System.out.println(found_id_2);
		if(found_id_2.equals("")) {
			msg_2="가입된 정보가 없습니다";
			System.out.println("msg2 : "+msg_2);
			request.setAttribute("t_msg_2", msg_2);
			request.setAttribute("t_email", email);
			request.setAttribute("t_name_email", name);
			System.out.println(email);
			System.out.println(name);
			return "member/find_id";
		}else {
			boolean mail_ok_gubun = true;
			MailContent ms = new MailContent();
			String mailSet_Server="smtp.naver.com";
			String mailSet_ID="chlchlrnsrns"; // 보내는 메일 아이디
			String mailSet_PW="Q54MFWQE46RF"; // 보내는 메일 비밀번호
			
			String mailFromName ="IseeU 인증번호 안내";
			String mailFromAddress ="chlchlrnsrns@naver.com";  // 보내는 사람 이메일주소
			String mailTo   = email;
							
			String mailTitle =" IseeU 인증번호";
			String content = 	
					" <table width='400' height='200' border='0' > "+
					" <tr> "+
					" 	<td colspan='2' height='100' align='center'>"+name+"님 비빌번호 안내</td> "+
					" </tr> "+
					" <tr>"+
					" 	<td width='120' align='center'>인증번호</td> "+
					" 	<td width='280' align='left'>"+
					"        <font size='5' color='red'>"+check_num+"</font> 입니다</td> "+
					" </tr> "+
					" </table> ";
			ms.setMail(mailSet_Server, mailSet_ID, mailSet_PW);  
			try {
				ms.sendMail(mailFromName, mailFromAddress,mailTo, mailTitle, content);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				mail_ok_gubun=false;
				e.printStackTrace();
			} 
	
			msg_2="인증번호가 발송되었습니다";
			request.setAttribute("t_msg_2", msg_2);
			request.setAttribute("t_email", email);
			request.setAttribute("t_name_email", name);
			request.setAttribute("t_found_id_2", found_id_2);
			request.setAttribute("t_check_num_2", check_num);
			System.out.println(check_num);
			return "member/find_id";
		}
		
	}
}