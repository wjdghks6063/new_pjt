package command.vol;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.Command;
import common.CommonUtil;
import dao.Vol_dao;
import dto.Vol_dto;


public class VolWrite implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Vol_dao dao = new Vol_dao();
		
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		int sizeLimit = 1024 * 1024 * 10;
		//String file_dir = CommonUtil.getFile_dir_dona();
		//"C:/Users/jsl505/Desktop/park_work/spring_team_pjt/src/main/webapp/webContent/file_room/dona/";
		 HttpSession session = request.getSession();
	      ServletContext context = session.getServletContext();
	      String file_dir = context.getRealPath("/webContent/file_room/vol/");
	      
	      DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
		MultipartRequest mpr=null;
		try {
			mpr = new MultipartRequest(request,file_dir,sizeLimit,"utf-8",df);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		String no 			= dao.getMaxNo();
		String title 		= mpr.getParameter("t_title");
		String voname 		= mpr.getParameter("t_voname");
		String volunteersite 	= mpr.getParameter("t_volunteersite");
		String start_date 	= CommonUtil.getToday();
		String end_date 	= mpr.getParameter("t_enddate");
		String content 		= mpr.getParameter("t_content");
		String attach 		= mpr.getFilesystemName("t_attach");
		if(attach == null) attach = "";
		String local 		= mpr.getParameter("t_local");
		String ggoal 		= mpr.getParameter("t_goal");
		int goal 			= Integer.parseInt(ggoal);
		
		int total 			= 0;
		int hit 			= 0;
		
		System.out.println(no+"  "+goal+"  "+content+"  "+start_date+"  "+attach+"  "+attach+"  "+local+" "+content);
		
		Vol_dto dto = new Vol_dto(no,title,voname,volunteersite,start_date,end_date,content,attach,local,goal,total,hit);
		int result = dao.VolSave(dto);
		
		if(result==1) {
			request.setAttribute("t_msg", "등록 성공~");
			
		}else {
			request.setAttribute("t_msg", "등록 실패~");
		
		}
			request.setAttribute("t_url", "Volunteer");
	}

}
