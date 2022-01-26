package command.local;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import common.Command;
import common.CommonUtil;
import dao.Dona_dao;
import dao.Local_dao;

public class LocalDelete implements Command {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Local_dao dao = new Local_dao();
		String no = request.getParameter("t_no");
		String attach_name = request.getParameter("t_attach");
		if(attach_name !=(null)){
			File file = new File(CommonUtil.getFile_dir_dona(),attach_name);
			file.delete();
			
		}
		
		int result = dao.LocalDelete(no);
		if(result==1) {
			request.setAttribute("t_msg", "삭제성공~");
			
		}else {
			request.setAttribute("t_msg", "삭제실패~");
		
		}
			request.setAttribute("t_url", "LocalNews");
			request.setAttribute("t_result", result);
	}

}
