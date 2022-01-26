package command.missing;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.Command;
import common.CommonUtil;
import dao.Missing_dao;
import dto.Missing_dto;

public class MissingUpdate implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		Missing_dao dao = new Missing_dao();
		String missingDir = "/webContent/file_room/missing/";
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		String uploadFilePath = context.getRealPath(missingDir);	
		
		int sizeLimit = 1024 * 1024 * 10;		
		MultipartRequest mpr = null;
		try {
			mpr = new MultipartRequest(request,uploadFilePath,sizeLimit,"utf-8",new DefaultFileRenamePolicy());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String no 			= mpr.getParameter("t_no");	
		String name 		= mpr.getParameter("t_name");	
		String age 			= mpr.getParameter("t_age");	
		String gender 		= mpr.getParameter("t_gender");	
		String lost_date 	= mpr.getParameter("t_lost_date");	
		String lost_time 	= mpr.getParameter("t_lost_time");	
		String lost_area 	= mpr.getParameter("t_lost_area");	
		String lost_place 	= mpr.getParameter("t_lost_place");	
		String lat 			= mpr.getParameter("t_lat");	
		String lng 			= mpr.getParameter("t_lng");	
		String content 		= mpr.getParameter("t_content");	
		String reg_id 		= mpr.getParameter("t_reg_id");	
		reg_id = "kimss";
		String reg_date 	= CommonUtil.getToday();
		
		String attach 	= mpr.getFilesystemName("t_attach"); // aaa.hwp
		String dbAttachName ="";
		
		if(attach == null){
			dbAttachName = mpr.getParameter("t_ori_attach");
		} else {
			// 이미지 변경했으면 기존 이미지 삭제
			String oriDelFile = mpr.getParameter("t_ori_attach");
			if(!oriDelFile.equals("")) { // 삭제할 파일이 있다면
				File oriD = new File(uploadFilePath,oriDelFile);
				boolean tf = oriD.delete();
				if(!tf) System.out.println(" 기존 이미지 파일 삭제 오류 "+tf);
			}			
			File oldFile = new File(uploadFilePath,attach);
			File newFile = new File(uploadFilePath, no+"-"+attach); //N025-aaa.hwp
			oldFile.renameTo(newFile);
			dbAttachName = newFile.getName();
		}		
		
		
		Missing_dto dto = new Missing_dto(no,name,age,gender,lost_date,lost_time,lost_area,lost_place,lat,lng,content,dbAttachName,reg_id,reg_date,0);
		int result = dao.updateMissingClob(dto);
		if(result == 1) {
			request.setAttribute("t_msg", "실종 신고 내용 수정 되었습니다.");
		} else {
			request.setAttribute("t_msg", "실종 수정 실패~");
		}
		request.setAttribute("t_url", "Missing");		

	}

}
