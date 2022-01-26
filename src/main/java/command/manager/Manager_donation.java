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
		/*오늘의 기부 내용*/
		request.setAttribute("TD_list_num", dao.getToday(search).size());
		request.setAttribute("TD_list", dao.getToday(search));
		request.setAttribute("TDD_list_num", dao.getTodayDeadline(search).size());
		request.setAttribute("TDD_list", dao.getTodayDeadline(search));
		request.setAttribute("TDC_list_num", dao.getTodayComplete(search).size());
		request.setAttribute("TDC_list", dao.getTodayComplete(search));
		/*이번주 기부내용*/
		request.setAttribute("TWD_list_num", dao.getThisWeekDeadline(search).size());
		request.setAttribute("TWD_list", dao.getThisWeekDeadline(search));
		request.setAttribute("TWC_list_num", dao.getThisWeekComplete(search).size());
		request.setAttribute("TWC_list", dao.getThisWeekComplete(search));
		request.setAttribute("TWP_list_num", dao.getThisWeekProceeding(search).size());
		request.setAttribute("TWP_list", dao.getThisWeekProceeding(search));
		request.setAttribute("TW_list_num", dao.getThisWeek(search).size());
		request.setAttribute("TW_list", dao.getThisWeek(search));
		/*이번달 기부내용*/
		request.setAttribute("TMD_list_num", dao.getThisMonthDeadline(search).size());
		request.setAttribute("TMD_list", dao.getThisMonthDeadline(search));
		request.setAttribute("TMC_list_num", dao.getThisMonthComplete(search).size());
		request.setAttribute("TMC_list", dao.getThisMonthComplete(search));
		request.setAttribute("TMP_list_num", dao.getThisMonthProceeding(search).size());
		request.setAttribute("TMP_list", dao.getThisMonthProceeding(search));
		request.setAttribute("TM_list_num", dao.getThisMonth(search).size());
		request.setAttribute("TM_list", dao.getThisMonth(search));
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
