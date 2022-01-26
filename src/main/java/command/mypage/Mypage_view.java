package command.mypage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import common.CommonUtil;
import dao.Member_dao;
import dao.Mypage_dao;
import dto.Member_dto;
import dto.Mypage_dto;

public class Mypage_view implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Mypage_dao my_dao = new Mypage_dao();		
		String id = request.getParameter("t_id");
		
		
		
		//notification yn을 불러오기 위한 Member table 호출
		Member_dao mem_dao = new Member_dao();
		String notification_yn = mem_dao.notifi_yn(id); 
		
		ArrayList<Mypage_dto> notifi_dtos = my_dao.getNotificationList_total(id,notification_yn);
		
		int count = notifi_dtos.size();
		ArrayList<String> day_dtos = new ArrayList<String>();
		String day_account="";
		for(int k=0;k<count;k++) {
		day_account = CommonUtil.dayaccount(notifi_dtos.get(k).getNotif_date()); 
		day_dtos.add(day_account);
		}
		//System.out.println(dayaccount);
		request.setAttribute("t_notifi_dtos", notifi_dtos);
		request.setAttribute("t_id", id);
		request.setAttribute("t_notification_yn", notification_yn);
		request.setAttribute("t_day_dtos", day_dtos);
		
	}

}
