package command.local;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.Command;
import common.CommonUtil;
import dao.Local_dao;
import dao.Vol_dao;
import dto.Dona_dto;
import dto.Local_dto;
import dto.Vol_dto;

public class LocalWrite implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub

		Local_dao dao = new Local_dao();
		
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
	      String file_dir = context.getRealPath("/webContent/file_room/local/");
	      
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
		String news_name 		= mpr.getParameter("t_news_name");
		
		String reg_date 	= CommonUtil.getToday();
		
		String content 		= mpr.getParameter("t_content");
		String attach 		= mpr.getFilesystemName("t_attach");
		if(attach == null) attach = "";
		String search 		= mpr.getParameter("t_search");
		
		
		int hit 			= 0;
		String reg_id 		= mpr.getParameter("t_reg_id");
		System.out.println(no+"    "+content+"  "+reg_date+"  "+attach+"  "+attach+"  "+search+" "+content);
		
		Local_dto dto = new Local_dto(no,title,news_name,reg_date,content,attach,search,hit,reg_id);
		int result = dao.LocalSave(dto);
		
		if(result==1) {
			request.setAttribute("t_msg", "등록 성공~");
			
		}else {
			request.setAttribute("t_msg", "등록 실패~");
		
		}
			request.setAttribute("t_url", "LocalNews");
			request.setAttribute("t_result", result);
		
	}

}
