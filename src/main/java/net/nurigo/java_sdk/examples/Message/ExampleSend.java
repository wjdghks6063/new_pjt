package net.nurigo.java_sdk.examples.Message;

import java.util.HashMap;
import org.json.simple.JSONObject;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException; 
 
/** 
 * @class ExampleSend
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API PHP
 */
public class ExampleSend {
  public static void sendMessage(String bunho, int check_num){
    String api_key = "NCSJASZRKFGFDPDX";
    String api_secret = "4OUK77XL03NZBQ1RVRW6LKQNGNAHBBKZ";
    
    Message coolsms = new Message(api_key, api_secret);

    // 4 params(to, from, type, text) are mandatory. must be filled
    HashMap<String, String> params = new HashMap<String, String>();
    params.put("to", bunho);
    params.put("from", "01098748874");
    params.put("type", "SMS");
    params.put("text", "[I see U] 인증번호 : "+check_num);
    params.put("app_version", "test app 1.2"); // application name and version

    try {
      JSONObject obj = (JSONObject) coolsms.send(params);
      System.out.println(obj.toString());
    } catch (CoolsmsException e) {
      System.out.println(e.getMessage());
      System.out.println(e.getCode());
    }
  }
}