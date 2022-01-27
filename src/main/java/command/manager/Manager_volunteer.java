package command.manager;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import dao.Manager_dao;

public class Manager_volunteer implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String id = request.getParameter("t_id");
		Manager_dao dao = new Manager_dao();
		
		String search = request.getParameter("t_search");
		if(search == null) {
			
		search = "";
		
		}
		/*---기부목록--------------------------------------------------*/
		request.setAttribute("VT_list", dao.getVolToday(search));
		request.setAttribute("VW_list", dao.getVolWeek(search));
		request.setAttribute("VM_list", dao.getVolMonth(search));
		request.setAttribute("CMV_list_num", dao.getCompleteMonthVol(search).size());
		request.setAttribute("CMV_list", dao.getCompleteMonthVol(search));
		request.setAttribute("PMV_list_num", dao.getProceedingMonthVol(search).size());
		request.setAttribute("PMV_list", dao.getProceedingMonthVol(search));
		
		
		request.setAttribute("t_search", search); /*조회 카테고리 항목 클릭시  t_search의 이름 조건으로 불이 켜짐 (아동,노인,장애,재난)*/
	
	}
}
