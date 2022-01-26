package team.pjt.dona;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ComController {
	//컴패니
	
	@RequestMapping("Company")
	public String Company() {
	
		return  "company/intro";

	}
}
