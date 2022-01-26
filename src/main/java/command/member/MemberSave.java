package command.member;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import common.CommonUtil;
import dao.Member_dao;
import dto.Member_dto;

public class MemberSave implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
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

		String reg_date      = CommonUtil.getToday2();
		String address_1 = request.getParameter("t_address_1");
		String address_2 = request.getParameter("t_address_2");
		String info_yn = request.getParameter("t_info_yn");
		
		try {
			password = dao.encryptSHA256(password);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Member_dto dto = new Member_dto(id,name,password,email,tell,address_1,address_2,info_yn,reg_date);
		int result = dao.memberSave(dto);
		String msg="";
		if(result == 1) msg =name+"님 회원가입 되었습니다.";
		else msg = "회원가입 실패하였습니다. 관리자에게 문의바람!";
		
		request.setAttribute("t_result", result);
		request.setAttribute("t_msg", msg);
		request.setAttribute("t_url", "/");
		System.out.println(msg);
		
	}

}
