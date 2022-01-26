package team.pjt.dona;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import command.pay.Mutong_pay;
import common.Command;

@Controller
public class PayController {
	@RequestMapping("/Mutong_pay")
	public String Mypage_home(HttpServletRequest request) {
		Command pay = new Mutong_pay();
		pay.execute(request);
		return "pay/mutong_pay";
	}
}
