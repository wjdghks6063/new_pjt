package command.missing;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import dao.Missing_dao;
import dto.Missing_dto;

public class MissingView implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Missing_dao dao = new Missing_dao();
		String no = request.getParameter("t_no");
		dao.setHitCount(no);
		Missing_dto dto = dao.getMissingView(no);
		
		request.setAttribute("t_dto", dto);
	}

}
