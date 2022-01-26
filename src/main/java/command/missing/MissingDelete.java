package command.missing;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.Command;
import common.CommonUtil;
import dao.Missing_dao;

public class MissingDelete implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		Missing_dao dao = new Missing_dao();
		String missingDir = "/webContent/file_room/missing/";
		
		String no = request.getParameter("t_no");
		String df = request.getParameter("t_attach");
		int result = dao.missingDelete(no);
		
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		String uploadFilePath = context.getRealPath(missingDir);			
		String file_dir = uploadFilePath;		
		
		if(result == 1) {
			if(!df.equals("")) {
				File delFile = new File(file_dir, df);
				delFile.delete();
			}
		}		
		String msg ="";
		if(result ==0) {
			msg =" 삭제 실패 ~ ";	
		}else {
			msg ="실종 등록 삭제 되었습니다.";
		}
		request.setAttribute("t_msg", msg);
		request.setAttribute("t_url", "Missing");		

	}

}
