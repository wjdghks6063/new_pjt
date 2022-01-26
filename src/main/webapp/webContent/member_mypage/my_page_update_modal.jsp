<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate">
<meta http-equiv="Cache-Control" content="post-check=0, pre-check=0">
<meta http-equiv="Pragma" content="No-Cache">

<title>개인정보 수정 : 정보</title>

<link rel="stylesheet" type="text/css" href="../css/member_update.css.css">
<script type="text/javascript">

</script>
<meta name="decorator" content="NEW_USER_MYINFO">
</head>

<body>
<div id="wrap">
	<!-- 스킵네비게이션 : 웹접근성대응-->
	<div id="u_skip">

	</div>
	<!-- //스킵네비게이션 -->


	<div id="container">
		<!-- CONTENTS -->
		<div id="content">
    <div class="c_header">
        <h2>개인정보 수정</h2>
        <p class="contxt"><strong>chlchlrnsrns</strong>님의 개인정보입니다.<br>
		회원정보는 개인정보처리방침에 따라 안전하게 보호되며, 회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다. <a href="http://policy.naver.com/policy/privacy.html" target="_blank" onclick="clickcr(this,'inf.privacy','','',event);">개인정보처리방침</a></p>
    </div>
    <form name="member">
     

        <fieldset>
            <table border="0" class="tbl_model">
                <caption><span class="blind">연락처 수정 입력</span></caption>
                <colgroup>
                    <col style="width:22%"><col>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">
                        <div class="thcell">
						     	  사용자 <span class="word_br">이름</span>
						     </div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <p class="contxt_tit">최병준</p>
                            <p class="contxt_desc">이름이나 생년월일, 성별 등의 정보가 변경되었다면 본인확인을 통해 정보를 수정할 수 있습니다.</p>
                            <p class="btn_area_btm">
                                <a href="javascript:changeName();" class="btn_model"><b class="btn2">수정</b></a>
                            </p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <div class="thcell">휴대전화</div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <p id="p_txt_phoneNo" class="contxt_tit">+82 10-9***-8***</p>
                            <p class="contxt_desc">아이디, 비밀번호 찾기 등 본인확인이 필요한 경우 또는 유료 결제 등 네이버로부터 알림을 받을 때 사용할 휴대전화입니다.</p>
                            <div id="d_phoneNo" style="display:none">
                                <p id="p_txt_phoneNo_changeYn" class="contxt_tit2"><label for="phoneNo">변경할 휴대전화</label></p>
                              
                                    <a href="#" onclick="sendSmsForChangePhoneNo();return false;" class="btn_model"><span class="btn4">인증</span></a>
                                </p>
                                <p id="e_phoneNo" class="contxt_alert"></p>

                                <p class="contxt_tit2"><label for="authNo">인증번호 입력</label></p>
                                <p class="contxt_webctrl">
                                    <input type="text" id="authNo" name="authNo" value=""  maxlength="6" onkeydown="check_num_ajax2('authNo', '2', 'e_authNo','e_phoneNo');" disabled class="focus" style="width:254px">
                                </p>
                                <p id="e_authNo"  class="contxt_alert"></p>

                                <p class="btn_area_btm">
                                    <a href="#" onclick="cancelChange('phoneNo');return false;" class="btn_model"><b id="b_txt_phoneNo_cncl"  class="btn2">수정취소</b></a>
                                    <a href="#" onclick="checkAuthNoForChangePhoneNo();return false;" class="btn_model"><b id="b_txt_phoneNo_reg" class="btn3">수정완료</b></a>
                                </p>
                            </div>
                            <p id="p_phoneNo" class="btn_area_btm">
                                <a href="#" onclick="display('phoneNo');return false;" class="btn_model"><b class="btn2">수정</b></a>
                            </p>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th scope="row">
                        <div class="thcell">
								네이버 계정 <span class="word_br">이메일</span>
							</span></div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <p class="contxt_tit">chlchlrnsrns@naver.com</p>
                            <p class="contxt_desc">네이버 계정의 이메일 주소입니다.</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <div class="thcell">
						     	  연락처 <span class="word_br">이메일</span>
						     </div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <p id="p_txt_myLetterEmail" class="contxt_tit">ch******@n*******.com</p>
                            <p class="contxt_desc">네이버 서비스의 변경/종료 등 네이버의 대부분 안내에 사용할 이메일 주소입니다.</p>
                            <div id="i_myLetterEmail" style="display:none">
                                <p class="contxt_tit2"><label for="confirmMyLetterEmail">현재 이메일</label></p>
                                <p class="contxt_webctrl">
                                    <input type="text" name="confirmMyLetterEmail" id="confirmMyLetterEmail"  style="width:254px">
                                    <a href="#" onclick="doConfirmMyLetterEmail();return false;" class="btn_model"><span class="btn4">확인</span></a>
                                </p>
                                <p id="e_myLetterEmail1" class="contxt_alert"></p>
                                <p class="contxt_desc2">등록된 이메일 주소가 기억나지 않는다면 휴대전화 인증 후 이메일을 수정할 수 있습니다. <a href="#" onclick="userMobile('myLetterEmail');return false;" class="link">휴대전화 인증</a></p>
                            </div>
                            <div id="d_myLetterEmail" style="display:none">
                                <p class="contxt_tit2">변경할 이메일</p>
                                <p class="contxt_desc">변경할 이메일 주소를 입력하세요.(예 : abc@naver.com)</p>
                                <p class="contxt_webctrl">
                                    <input type="text" name="myLetterEmail" id="myLetterEmail" value="" style="width:254px" disabled>
                                    <label id="label_myLetterEmail" for="myLetterEmail" class="email_change_contxt2">변경할 이메일 입력</label>
                                    <a href="#" class="btn_model" onclick="sendAuthNoForEmailAuth('myLetterEmail');return false;"><span class="btn4">인증</span></a>
                                </p>
                                <p id="e_myLetterEmail2" class="contxt_alert" style="display: none;"></p>
                                <p class="contxt_webctrl_box">
                                    <input type="text" id="myLetterEmailAuthNo" style="width:254px" disabled>
                                    <label id="label_myLetterEmailAuthNo" for="myLetterEmailAuthNo" class="email_change_contxt">인증번호 입력</label>
                                </p>
                                <p id="e_myLetterEmail3" class="contxt_alert"></p>
                                <p class="contxt_guide" id="myLetterEmailAuthGuide" >인증번호가 오지 않나요?</p>
                                <p class="contxt_guide_help" id="myLetterEmailAuthGuideHelp" style="display:none">
								네이버가 발송한 메일이 스팸 메일로 분류된 것은 아닌지 확인해 주세요.<br>스팸 메일함에도 메일이 없다면, 다시 한 번 '인증'을 눌러주세요.
							</p>
                                <p class="btn_area_btm">
                                    <a href="#" onclick="cancelChange('myLetterEmail');return false;" class="btn_model"><b class="btn2">수정취소</b></a>
                                    <a href="#" onclick="setEmail();return false;" class="btn_model"><b class="btn3">수정완료</b></a>
                                </p>
                            </div>
                            <p id="p_myLetterEmail" class="btn_area_btm">
                                <a href="#" onclick="display('myLetterEmail');return false;" class="btn_model"><b class="btn2">수정</b></a>
                            </p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <div class="thcell">
						     	  사용자 <span class="word_br">이름</span>
						     </div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <p class="contxt_tit">최병준</p>
                            <p class="contxt_desc">이름이나 생년월일, 성별 등의 정보가 변경되었다면 본인확인을 통해 정보를 수정할 수 있습니다.</p>
                            <p class="btn_area_btm">
                                <a href="javascript:changeName();" class="btn_model"><b class="btn2">수정</b></a>
                            </p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <div class="thcell">
								 정보 <span class="word_br">수신 동의</span>
							</div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <div class="ad_wrap">
                                <div class="ad_check" style="padding-top:25px;">
                                        <input type="radio" name="t_info_yn" id="adMobileCheck" class="ad_checkbox" checked>
                                            <span>동의</span>
                                        <input type="radio"  name="t_info_yn" style="margin-left:30px;" id="adEmailCheck" class="ad_checkbox" >
                                            <span>미동의</span>
                                        </label>
                                </div>
                               
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </fieldset>
    </form>
</div>
<form name="formAuth" method="post" action="/user2/help/changeUserInfo?m=actionUserMobile">
    <input type=hidden name="authRes" value="" />
    <input type=hidden name="token_help" value="bY4HbFi5TDQPTwQ1" />
</form>

	</div>

	<div id="footer">
            풋터

	</div>
</div>


</body>
</html>
