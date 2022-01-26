package command.mypage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import common.CommonUtil;
import dao.Mypage_dao;
import dto.Mypage_dto;

public class Mypage_activity_vol implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Mypage_dao my_dao = new Mypage_dao();
		String id = request.getParameter("t_id");
		String	day_1 = request.getParameter("calendar_1");
		String	day_2 = request.getParameter("calendar_2");
		String more = request.getParameter("t_more");
	
		
		if(day_2 == null) {
			day_2 = CommonUtil.getToday();
		}
		if(day_1 == null) {
			day_1 = CommonUtil.getToday();
		}
		
	      /* paging start*/
	      String nowPage = request.getParameter("t_nowPage");
	      int current_page = 0; // 현재페이지 번호
	      int total_page = 0;    // 전체 페이지 수
	      int total_count = my_dao.getTotalcount_vol(id,day_1,day_2); 
	      
	      int list_setup_count = 5;  //한페이지당 출력 행수 
	      
	      if(nowPage == null || nowPage.equals("")) current_page = 1; 
	      else current_page = Integer.parseInt(nowPage);
	      
	      total_page = total_count / list_setup_count;  // 몫 : 2
	      int rest =    total_count % list_setup_count;   // 나머지:1
	      if(rest !=0) total_page = total_page + 1;     // 3
	      
	      //int start = (current_page -1) * list_setup_count + 1;
	      int end   = current_page * list_setup_count;      
	      /* paging end*/
	    
	      if(more ==null || more.equals("")) {
				more= "0";
			}
			int more_final = Integer.parseInt(more);
			
	
	      
		ArrayList<Mypage_dto> dtos = my_dao.getActivity_vol_1day(id, day_1, day_2, end+more_final);
		
		int search_count = dtos.size();
		
		if(more != null && total_count > 5) {
			more_final = more_final +5;
		}else {
			more_final = more_final+0;
		}
		if(end+more_final <= 5 && end+more_final > 1) {
			more_final = 0;
		}
		
		request.setAttribute("t_dtos", dtos);
		request.setAttribute("t_day_1", day_1);
		request.setAttribute("t_day_2", day_2);
		request.setAttribute("t_current_page", current_page );
		request.setAttribute("t_total_page", total_page);
		request.setAttribute("t_more", more_final);
		request.setAttribute("t_dtos.size", dtos.size());
		request.setAttribute("t_total_count", total_count);
		request.setAttribute("t_search_count", search_count);
	}

}
