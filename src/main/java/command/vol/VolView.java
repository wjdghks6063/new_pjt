package command.vol;

import javax.servlet.http.HttpServletRequest;

import common.Command;

import dao.Vol_dao;

import dto.Vol_dto;

public class VolView implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Vol_dao dao = new Vol_dao();
		String no = request.getParameter("t_no");
		dao.setHitCount(no);
		Vol_dto dto = dao.VolView(no);
		
		request.setAttribute("t_dto", dto);
		request.setAttribute("t_no", no);
	}

}
