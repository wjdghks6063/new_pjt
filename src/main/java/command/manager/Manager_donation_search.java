package command.manager;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import dao.Manager_dao;
import dto.Manager_dto;

public class Manager_donation_search implements Command {
	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String id = request.getParameter("t_id");
		Manager_dao dao = new Manager_dao();
		
		String select = request.getParameter("t_select");
		String search = request.getParameter("t_search");
		
		if(select == null) {
			
			select ="";
			search ="";
		}
		/*--------기부 상세 화면---------------------------------------------------*/
		request.setAttribute("DAS_list_num", dao.getDonaAllSearch(select,search).size());
		ArrayList<Manager_dto> dtos = dao.getDonaAllSearch(select,search); 
		request.setAttribute("DAS_list", dtos); 
		/*request.setAttribute("t_select", select);*/
		request.setAttribute("t_select", select);
		request.setAttribute("t_search", search); /*검색 카테고리 항목 선택 후 검색시 이름이 그대로 있어야 함 /
		
		request.setAttribute("dao", dao);
	
		/*
		ArrayList<Dona_dto> dtos = dao.DonaList(search,start,end);
		request.setAttribute("t_dtos", dtos);
		
		request.setAttribute("t_search", search);
		*/
	}
}
