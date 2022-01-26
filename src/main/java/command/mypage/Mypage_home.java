package command.mypage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import common.CommonUtil;
import dao.Member_dao;
import dao.Mypage_dao;
import dto.Member_dto;
import dto.Mypage_dto;

public class Mypage_home implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Mypage_dao my_dao = new Mypage_dao();		
		Mypage_dto my_dto = null;
		//윗쪽 후원금액 처리
		String id = request.getParameter("t_id");
		my_dto = my_dao.Mypage_home_history_dona(id);
		String today=CommonUtil.getToday2();
		String week = CommonUtil.getWeek();
		
			//위쪽 총금액 처리
			Mypage_dto total_amount_dto = null;
			total_amount_dto = my_dao.Mypage_home_total_amount(id);
			
			//위쪽 오늘 금액 처리
			Mypage_dto today_amount_dto = null;
			today_amount_dto = my_dao.Mypage_home_today_amount(id,week,today);
			
			//주간 봉사참여횟수
			int week_count = my_dao.Mypage_home_week_vol(id,week,today);
			//총 봉사 참여횟수
			int total_count = my_dao.Mypage_home_total_vol(id);
			
			//새소식 
			ArrayList<Mypage_dto> notifi_dtos = my_dao.getNotificationList(id);
			
			//notification yn을 불러오기 위한 Member table 호출
			Member_dao mem_dao = new Member_dao();
			Member_dto mem_dto = mem_dao.getMemberView(id);
			ArrayList<String> day_dtos = new ArrayList<String>();
			String day_account="";
			int count = notifi_dtos.size();
			for(int k=0;k<count;k++) {
			day_account = CommonUtil.dayaccount(notifi_dtos.get(k).getNotif_date()); 
			
			day_dtos.add(day_account);
			}
			
			
		request.setAttribute("t_my_dto", my_dto);
		request.setAttribute("t_total_amount_dto", total_amount_dto);
		request.setAttribute("t_today_amount_dto", today_amount_dto);
		request.setAttribute("t_week_count", week_count);
		request.setAttribute("t_total_count", total_count);
		request.setAttribute("t_notifi_dtos", notifi_dtos);
		request.setAttribute("t_mem_dto", mem_dto);
		request.setAttribute("t_id", id);
		request.setAttribute("t_day_dtos", day_dtos);
		
	}

}
