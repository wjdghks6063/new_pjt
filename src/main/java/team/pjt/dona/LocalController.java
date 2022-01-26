package team.pjt.dona;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import command.local.LocalDelete;
import command.local.LocalList;
import command.local.LocalUpdate;
import command.local.LocalView;
import command.local.LocalWrite;
import common.Command;
import common.CommonSummerNote;
import common.CommonUtil;

@Controller
public class LocalController {

	//기부 삭제
			@RequestMapping("LocalDelte")
			public String LocalDelete(HttpServletRequest request) {
			Command local = new LocalDelete();
			local.execute(request);
			return  "common_alert_page";

			}
		
		//기부 수정
		@RequestMapping("LocalUpdate")
		public String LocalUpdate(HttpServletRequest request) {
		Command local = new LocalUpdate();
		local.execute(request);
		return  "common_alert_page";

		}
		//기부 썸머노트
		@RequestMapping("LocalSummerNoteImgUpload")
		public void DonaSummerNote(HttpServletRequest request, HttpServletResponse response) {
			CommonSummerNote localNote = new CommonSummerNote();
			localNote.execute("local",request, response);
		}
		//첨부 썸머노트 때문에 따로 만든 기부 글쓰기
		@RequestMapping("LocalSave")
			public String LocalSave(HttpServletRequest request) {
			//도나 등록//
			Command local = new LocalWrite();
			local.execute(request);
			return  "common_alert_page";
		
		}
		//기본 기부 들
		@RequestMapping("LocalNews")
			public String LocalNews(HttpServletRequest request) {
			String gubun = request.getParameter("t_gubun");
//			System.out.println("gubun : "+gubun);
			
			if(gubun == null) gubun = "List";
			String viewPage="";	
			if(gubun.equals("List")) {
				//기부 기본화면 리스트//
				Command local = new LocalList();
				local.execute(request);
				viewPage="local/local_list";
				
			}else if(gubun.equals("WriteForm")) {
				//글쓰기 양식으로//
				String today = CommonUtil.getToday();
				
				viewPage="local/local_write";
			}else if(gubun.equals("View")) {
				//기부 뷰
				Command local = new LocalView();
				local.execute(request);
				viewPage="local/local_view";
			}else if(gubun.equals("UpdateForm")) {
				//기부 뷰
				Command local = new LocalView();
				local.execute(request);
				viewPage="local/local_update";
			}else if(gubun.equals("Delete")) {
				/*노티스 삭제
				Command noti = new NoticeDelete();
				noti.execute(request);
				viewPage="common_alert_page";*/
			}
			
			
				
				return viewPage;
	
		}
	
}
