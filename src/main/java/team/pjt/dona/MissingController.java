package team.pjt.dona;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import command.missing.MissingDelete;
import command.missing.MissingList;
import command.missing.MissingSave;
import command.missing.MissingUpdate;
import command.missing.MissingView;
import common.Command;
import common.CommonSummerNote;
import dao.Missing_dao;

@Controller
public class MissingController {
	@Autowired
	Missing_dao missingDddao;
/*
 
create table missing_find(
    no varchar2(5) not null, 			--번호 :M0001
    name varchar2(100) not null,		--성명
    age varchar2(3) not null,           --나이
	gender varchar2(1) not null, 		--성별 f:여 m:남
	lost_date date not null,          	--실종일자
	lost_time varchar2(2) not null,    --실종시간
	lost_area varchar2(20) not null,  	--실종지역
	lost_place varchar2(100) not null, 	--실종장소
	lat varchar2(20) not null, 			--위도
	lng varchar2(20) not null,  		--경도
    content  CLOB,                     	--내용 
    attach varchar2(100) not null,     	--첨부사진
    reg_info varchar2(20) not null,     --등록자
    reg_date date not null,            	--등록일
    hit number(5) default 0,           	-- 조회수
    CONSTRAINT pk_missing primary key(no)
);
 
 *첨부파일 폴더: webContent / file_room / missing 
 *썸머노트 폴더: webContent / file_room / missing_summernote
 
  
 */
	
	
	//실종 썸머노트
	@RequestMapping("MissingSummerNoteImgUpload")
	public void DonaSummerNote(HttpServletRequest request, HttpServletResponse response) {
		CommonSummerNote donaNote = new CommonSummerNote();
		donaNote.execute("missing",request, response);
	}	
	
	// 실종등록 첨부
	@RequestMapping("MissingSave")
	public String missingSave(HttpServletRequest request) {
		Command miss = new MissingSave();
		miss.execute(request);
		return "common_alert_page";
	}

	// 실종수정  첨부
	@RequestMapping("MissingUpdate")
	public String issingUpdate(HttpServletRequest request) {
		Command miss = new MissingUpdate();
		miss.execute(request);
		return "common_alert_page";
	}
	
	
	//실종아동
	@RequestMapping("Missing")
		public String Donation(HttpServletRequest request) {
		String gubun = request.getParameter("t_gubun");
 		
		if(gubun == null) gubun = "List";
		String viewPage="";	 
		if(gubun.equals("List")) {
		    Command dona = new MissingList();
			dona.execute(request); 
			viewPage="missing/missing_list";
		}else if(gubun.equals("WriteForm")) {
			//글쓰기
			viewPage="missing/missing_write";
		}else if(gubun.equals("View")) {
			// 뷰
			Command dona = new MissingView();
			dona.execute(request);
			viewPage="missing/missing_view";
		}else if(gubun.equals("UpdateForm")) {
			//수정폼
			Command dona = new MissingView();
			dona.execute(request);
			viewPage="missing/missing_update";
		}else if(gubun.equals("Delete")) {
			// 삭제
			Command dona = new MissingDelete();
			dona.execute(request);
			viewPage="common_alert_page";
		}
		return viewPage;
	}
}
