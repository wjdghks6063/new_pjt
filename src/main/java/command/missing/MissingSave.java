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

public class MissingSave implements Command {

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
		
		String no 			= dao.getMaxNo();
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
		
		String attach = mpr.getFilesystemName("t_attach");
		
	
		if(attach != null){ // 첨부했으면 파일명 변경
			File oldFile = new File(uploadFilePath,attach);// aaa.jpg
			File newFile = new File(uploadFilePath,no+"_"+attach); //M0003_aaa.jpg
			
			oldFile.renameTo(newFile); // oldFile: M0003_aaa.jpg
			attach = newFile.getName(); // file_name : M0003_aaa.jpg
		}		

		Missing_dto dto = new Missing_dto(no,name,age,gender,lost_date,lost_time,lost_area,lost_place,lat,lng,content,attach,reg_id,reg_date,0);
		int result = dao.saveMissinClob(dto);
		if(result == 1) {
			request.setAttribute("t_msg", "실종 등록 되었습니다.~");
		} else {
			request.setAttribute("t_msg", "실종 등록 실패~");
		}
		request.setAttribute("t_url", "Missing");		

	}

}
