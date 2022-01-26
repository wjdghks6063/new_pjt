package command.local;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import common.CommonUtil;
import dao.Local_dao;
import dto.Local_dto;

public class LocalList implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Local_dao dao = new Local_dao();
		//검색기능
		
		String search = request.getParameter("t_search");//기부뉴스냐 봉사뉴스냐
		if(search == null) {
			
			search = "";
		}
		//페이징
		//페이지기능
				String nowPage = request.getParameter("t_nowPage");
				int current_page = 0; //현재 페이지번호
				
				String gulsu = request.getParameter("t_list_setup_count"); 		
				if(gulsu == null){ gulsu="7";}
				int list_setup_count = Integer.parseInt(gulsu); //몇개씩 조회해 올것인가?
						
				int total_count = dao.getTotalCount(search); //전체 행수, 전체 게시글의 수
					
				int total_page = total_count / list_setup_count; //전체 페이지 수	(전체행수 나누기 나누고 싶은 수)	
				int rest = total_count % list_setup_count;//
				if(rest !=0) total_page = total_page+1;
					
				if(nowPage == null){ current_page = 1; 
				}else current_page = Integer.parseInt(nowPage);
				
				int start = (current_page-1)*list_setup_count+1;
				int end = current_page * list_setup_count;
				int k=0;
				int number = total_count-(list_setup_count * (current_page-1));
				String pageView = CommonUtil.pageListPost(current_page, total_page, 2);
				
			
				request.setAttribute("t_gulsu", gulsu);
				request.setAttribute("t_list_setup_count", list_setup_count);
				request.setAttribute("t_total_page", total_page);
				request.setAttribute("t_current_page", current_page);
				request.setAttribute("t_number", number);
				request.setAttribute("t_pageView", pageView);
				request.setAttribute("t_total_count", total_count);
		
		
		
				ArrayList<Local_dto> dtos = dao.LocalList(search,start,end);
				request.setAttribute("t_dtos", dtos);
				
				request.setAttribute("t_search", search);
	}

}
