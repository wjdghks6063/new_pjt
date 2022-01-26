package command.local;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import dao.Dona_dao;
import dao.Local_dao;
import dto.Dona_dto;
import dto.Local_dto;

public class LocalView implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Local_dao dao = new Local_dao();
		String no = request.getParameter("t_no");
		dao.setHitCount(no);
		Local_dto dto = dao.LocalView(no);
		
		request.setAttribute("t_dto", dto);
		request.setAttribute("t_no", no);
	}

}
