package team.pjt.dona;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import command.manager.Manager_donation;
import command.manager.Manager_donation_search;
import command.manager.Manager_home;
import command.manager.Manager_volunteer;
import command.manager.Manager_volunteer_search;
import common.Command;
import dao.Manager_dao;
import dto.Manager_dto;

@Controller
public class ManagerController { 
	
/*----더 보기 버튼 예제 테스트  manager_donation_search_more_test.jsp 에서 작동 가능-------------*/	
	
	
	//평소 사용하듯이 dtos.getTotal(); 이런식으로 사용하려면 특별한 기능을 부여해야한다. 
	// @RequestMapping produces="application/text;charset=UTF-8 과 @ResponseBody를 써준다.
	@RequestMapping(value="ManagerListMore",produces="application/text;charset=UTF-8")
	@ResponseBody // ResponseBody를 사용하려면 dto에 getter 말고 setter도 있어야 사용 가능하다.
		public String managerListMore(HttpServletRequest request) {
			Manager_dao dao = new Manager_dao();
			String select = request.getParameter("t_select");
			String search = request.getParameter("t_search");
			if(select == null){
				select = "";
				search = "";
			}
			
			int start = Integer.parseInt(request.getParameter("t_start"));
			int end = Integer.parseInt(request.getParameter("t_end"));
			
			ArrayList<Manager_dto> dtos = dao.getDonaAllSearch(select,search);
			
			/*arraylist를 json으로 사용하려면 objectMapper로 변환시킨다*/
			ObjectMapper mapper = new ObjectMapper();
			String jsonData ="";
			
			try {
				jsonData = mapper.writeValueAsString(dtos); //writeValueAsString 를 사용하면 string type으로 array list가 들어가진다.
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		return jsonData;
	}
/*---------------------------------------------------------------------------------------*/
	
	@RequestMapping("Manager")
	public String Manager(HttpServletRequest request) {
		String gubun = request.getParameter("t_gubun");

		if (gubun == null)
			gubun = "Home";
		String viewPage = "";
		if (gubun.equals("Home")) {
			// 매니저 기본화면 리스트//
			Command manager = new Manager_home();
			manager.execute(request);
			viewPage = "manager/manager_home";

		}else if(gubun.equals("Dona")) {
			//기부 뷰
			Command manager = new Manager_donation();
			manager.execute(request);
			viewPage="manager/manager_donation";
			
		}else if(gubun.equals("Dona_Search")) {
			//기부 검색
			Command manager = new Manager_donation_search();
			manager.execute(request);
			viewPage="manager/manager_donation_search";
			
		}else if(gubun.equals("Vol")) {
			//기부 뷰
			Command manager = new Manager_volunteer();
			manager.execute(request);
			viewPage="manager/manager_volunteer";
			
		}else if(gubun.equals("Vol_Search")) {
			//기부 검색
			Command manager = new Manager_volunteer_search();
			manager.execute(request);
			viewPage="manager/manager_volunteer_search";
			
		}
		
		return viewPage;
	}

}