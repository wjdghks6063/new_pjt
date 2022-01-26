package command.missing;

import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import common.CommonUtil;
import dao.Missing_dao;
import dto.Missing_dto;

public class MissingList implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		Missing_dao dao = new Missing_dao();
		
		String lost_area 		= request.getParameter("t_lost_area");
		String lost_date_start 	= request.getParameter("t_lost_date_start");
		String lost_date_end 	= request.getParameter("t_lost_date_end");
		String gender 			= request.getParameter("t_gender");
 
		if(lost_area == null) {
			Calendar mon = Calendar.getInstance();
			mon.add(Calendar.MONTH , -1);
			String beforeMonth = new java.text.SimpleDateFormat("yyyy-MM-dd").format(mon.getTime());				
			
			lost_area ="대전";
			lost_date_start = beforeMonth; //오늘날짜 부터 한달 전
			lost_date_end = CommonUtil.getToday();
			gender ="all";
		}	
		
		/* paging start*/
		String nowPage = request.getParameter("t_nowPage");
		int current_page = 0; // 현재페이지 번호
		int total_page = 0;    // 전체 페이지 수
		int total_count = dao.getTotalCount(lost_area,lost_date_start,lost_date_end,gender); // 전체 행수 21
		int list_setup_count = 10;  //한페이지당 출력 행수 
		
		if(nowPage == null || nowPage.equals("")) current_page = 1; 
		else current_page = Integer.parseInt(nowPage);
		
		total_page = total_count / list_setup_count;  // 몫 : 2
		int rest = 	total_count % list_setup_count;   // 나머지:1
		if(rest !=0) total_page = total_page + 1;     // 3
		
		int start = (current_page -1) * list_setup_count + 1;
		int end   = current_page * list_setup_count;
		
		// 넘버링 순서
		int order = total_count - ((current_page-1) * list_setup_count);
		/* paging end*/			

		ArrayList<Missing_dto> dtos = dao.getMissingList(lost_area, lost_date_start,lost_date_end,gender,start,end); 
		
		/* 지역별 지도 중심 위치 좌표
		// 대전JSL 36.32726796209588, 127.40736201995023
		// 서울시청 37.56592564927031, 126.97804425449569
		// 대구시청 35.87158715263924, 128.60177155550676
		// 부산시청 35.179835430196796, 129.07498636436745 
		*/
		//default : 대전
		String mapLat="36.32726796209588";
		String mapLng="127.40736201995023";
		if(lost_area.equals("서울")) {
			mapLat = "37.56592564927031";
			mapLng = "126.97804425449569";			
		} else if(lost_area.equals("대구")) {
			mapLat = "35.87158715263924";
			mapLng = "128.60177155550676";			
		} else if(lost_area.equals("부산")) {
			mapLat = "35.179835430196796";
			mapLng = "129.07498636436745";			
		}
		request.setAttribute("t_mapLat", mapLat);
		request.setAttribute("t_mapLng", mapLng);		
		
		request.setAttribute("t_dtos", dtos);
		request.setAttribute("t_lost_area", lost_area);
		request.setAttribute("t_lost_date_start", lost_date_start);
		request.setAttribute("t_lost_date_end", lost_date_end);
		request.setAttribute("t_gender", gender);
		request.setAttribute("t_current_page", current_page); 
		request.setAttribute("t_total_page", total_page);
		request.setAttribute("t_total_count", total_count);
		request.setAttribute("t_order", order);		
	}
}
