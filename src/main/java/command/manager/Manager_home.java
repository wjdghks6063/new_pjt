package command.manager;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import dao.Manager_dao;

public class Manager_home implements Command {
	
	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String id = request.getParameter("t_id");
		Manager_dao dao = new Manager_dao();
		
		request.setAttribute("PWV_list", dao.getProceedingWeekVol());
		request.setAttribute("PWD_list", dao.getProceedingWeekDona());
		request.setAttribute("Vol_list", dao.getVolToday());
		
		request.setAttribute("dao", dao);
		request.setAttribute("list", dao.getSearchList());
	}

}