package command.manager;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import dao.Manager_dao;

public class Manager_donation implements Command {

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
		request.setAttribute("DT_list", dao.getDoToday(search));
		request.setAttribute("DW_list", dao.getDoWeek(search));
		request.setAttribute("DM_list", dao.getDoMonth(search));
		request.setAttribute("CMD_list_num", dao.getCompleteMonthDona(search).size());
		request.setAttribute("CMD_list", dao.getCompleteMonthDona(search));
		request.setAttribute("PMD_list_num", dao.getProceedingMonthDona(search).size());
		request.setAttribute("PMD_list", dao.getProceedingMonthDona(search));
		
		
		request.setAttribute("t_search", search); /*조회 카테고리 항목 클릭시  t_search의 이름 조건으로 불이 켜짐 (아동,노인,장애,재난)*/
	
		/*
		ArrayList<Dona_dto> dtos = dao.DonaList(search,start,end);
		request.setAttribute("t_dtos", dtos);
		
		request.setAttribute("t_search", search);
		*/
	}
}
