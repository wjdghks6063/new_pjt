package team.pjt.dona;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import command.vol.VolDelete;
import command.vol.VolList;
import command.vol.VolUpdate;
import command.vol.VolView;
import command.vol.VolWrite;
import common.Command;
import common.CommonSummerNote;
import common.CommonUtil;

@Controller
public class VolController {
	//봉사 삭제
			@RequestMapping("VolDelte")
			public String VolDelete(HttpServletRequest request) {
			Command vol = new VolDelete();
			vol.execute(request);
			return  "common_alert_page";

			}
		
		//봉사 수정
		@RequestMapping("VolUpdate")
		public String VolUpdate(HttpServletRequest request) {
		Command vol = new VolUpdate();
		vol.execute(request);
		return  "common_alert_page";

		}
		//봉사 썸머노트
		@RequestMapping("VolSummerNoteImgUpload")
		public void DonaSummerNote(HttpServletRequest request, HttpServletResponse response) {
			CommonSummerNote volNote = new CommonSummerNote();
			volNote.execute("vol",request, response);
		}
		//첨부 썸머노트 때문에 따로 만든 봉사 글쓰기
		@RequestMapping("VolSave")
			public String VolSave(HttpServletRequest request) {
			//도나 등록//
			Command vol = new VolWrite();
			vol.execute(request);
			return  "common_alert_page";
		
		}
		//기본 봉사 들
		@RequestMapping("Volunteer")
			public String Volunteer(HttpServletRequest request) {
			String gubun = request.getParameter("t_gubun");
			System.out.println("gubun : "+gubun);
			
			if(gubun == null) gubun = "List";
			String viewPage="";	
			if(gubun.equals("List")) {
				//봉사 기본화면 리스트//
				Command vol = new VolList();
				vol.execute(request);
				viewPage="vol/vol_list";
				
			}else if(gubun.equals("WriteForm")) {
				//글쓰기 양식으로//
				String today = CommonUtil.getToday();
				
				viewPage="vol/vol_write";
			}else if(gubun.equals("View")) {
				//봉사 뷰
				Command dona = new VolView();
				dona.execute(request);
				viewPage="vol/vol_view";
			}else if(gubun.equals("UpdateForm")) {
				//봉사 뷰
				Command dona = new VolView();
				dona.execute(request);
				viewPage="vol/vol_update";
			}
			
			
				
				return viewPage;
			}

}
