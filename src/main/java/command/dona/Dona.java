package command.dona;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import common.CommonUtil;
import dao.Dona_dao;
import dto.Dona_dto;

public class Dona implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		Dona_dao dao = new Dona_dao();
		// 기부정보 가져오기

		String no 			= request.getParameter("t_no");
			
		String dona_date 	= CommonUtil.getToday();
		String dona_id 		= request.getParameter("t_session_id");
		String dum 			= request.getParameter("t_dum");
		
		String search 		= request.getParameter("t_search");
		String ttotal		= request.getParameter("t_total");
		int total 			= Integer.parseInt(ttotal);
		
		
		System.out.println(no+"  ");
		//기부하기 기부테이블 갱신(토탈 값만 바뀐다.)
		Dona_dto dto = new Dona_dto(no,total);
		int result = dao.Dona(dto);
		
		if(result==1) {
			request.setAttribute("t_msg", "기부 성공~");
			
		}else {
			request.setAttribute("t_msg", "기부 실패~");
		
		}
			request.setAttribute("t_url", "Donation");
			request.setAttribute("t_result", result);
		//기부테이블은 종료
			
		//멤버테이블 
			
		//기부내역 테이블	
			
	
		
	}

}
