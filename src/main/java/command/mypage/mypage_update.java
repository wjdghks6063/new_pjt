package command.mypage;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import dao.Member_dao;
import dto.Member_dto;

public class mypage_update implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Member_dao dao = new Member_dao();
		String id = request.getParameter("t_id");
		Member_dto dto = dao.getMemberView(id);
		request.setAttribute("t_dto", dto);
	}

}
