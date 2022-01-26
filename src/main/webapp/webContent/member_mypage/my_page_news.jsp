<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
     <%@ include file="../common_header.jsp" %>

    <!--페이지 css-->
    <link href="css/mypage-menu.css" rel="stylesheet">
    <link href="css/mypage-news.css" rel="stylesheet">

<script>
$(document).ready(function(){
	$("#notif_yn_switch").click(function(){ 
	    var urlLocation="Notification_change"; 
	    var id = my_page.t_id.value;
	    var params="t_id="+id;  
	    
	    if(id ==""){
	    	alert("ID 입력 후 눌러주세요 ");
	    	member.t_id.focus();
	    	return;
	    }
		$.ajax({
			type : "POST",
			url : urlLocation,
			data: params,
			dataType : "text",
			error : function(){
				alert('통신실패!!');
			},
			success : function(data){
				//alert("통신데이터 값 : " + data);
				location.reload();
			}
		});
	});
});

</script>
<div id="containar">
    <!-- 마이 페이지 메뉴-->
    <div class="my-page-box">
        <div class="my-list-left">
            <div class="my-profile">
                <div class="my_profile_nickname">
                    <span class="ellipsis" id="nickNameArea">${session_name}</span>
                </div>
                <div class="my_profile_id" id="maskingIdArea">${session_id}</div>
            </div>
            <div id="lnb" class="my_lnb" role="menu"> <!-- aria-current="#" 여부에 따라 색상 불 들어옴-->
                <a href="Mypage_home?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_home" aria-current="false">MY홈</a> 
                <a href="Mypage_news?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_notification" aria-current="true">내 소식</a>
                <a href="Mypage_activity?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_activity" aria-current="false">활동내역</a> 
                <a href="Mypage_regular_payment?t_id=${session_id}" role="menuitem" id="my_lnb_item" class="my_lnb_item" aria-current="false">정기결제관리</a>
                <a href="Mypage_year?t_id=${session_id}"role="menuitem" class="my_lnb_item" id="lnb_my_tax" aria-current="false">연말정산</a>
            </div>
        </div>
        
        <!-- 내용 창 -->
        <form name="my_page">
        	<input type="hidden" name="t_id" value="${session_id}">
        <div role="main" id="content" class="my_content">
            <div class="my_news_wrap">
                <h2 class="my_title">내 소식</h2>
                    <div class="my_news_option">
                        <div class="my_news_receiption" style="margin-top: 7px; margin-right: -5px;">
                            <strong class="title">마케팅 알림</strong> 
                            <input id="noti_agreement" name="t_noti_agreement" type="checkbox" <c:if test="${t_notification_yn eq 'y'}"> checked </c:if> class="input_switch"> 
                            <label for="noti_agreement"  id="notif_yn_switch" class="label_switch"><span class="label_switch_handler"></span></label>
                        </div>
                        <ul class="list_guide">
                            <li class="item_guide highlight">결제 알림은 마케팅 알림 수신 동의 여부와 관계없이 발송됩니다.</li>
                            <li class="item_guide">마케팅 알림 수신을 거부하시면, 결제 외 알림을 받아보실 수 없습니다.</li>
                            <li class="item_guide">최근 7일 동안 수신한 소식이 10개 노출됩니다.</li>
                        </ul>
                    </div>

                <div class="my_news_feed" id="my_notification">
                    <ol class="list_news" id="my_notification_list">
                     <c:choose>
	               			 <c:when test="${t_notification_yn eq 'y'}">	
	               			 <c:forEach items="${t_notifi_dtos}" var="notifi_dtos" varStatus="StatusNm">
			                         <c:choose>
                                            	<c:when test="${fn:substring(notifi_dtos.getNotif_no(),0,1) eq 'D'}">
                                            		<li class="item_news type_funding">
                                            	</c:when>
                                            	<c:when test="${fn:substring(notifi_dtos.getNotif_no(),0,1) eq 'V'}">
                                            		<li class="item_news type_funding_vol">
                                            	</c:when>
                                            	</c:choose>
			                            <div class="card_news">
			                             <a href="javascript:go();" class="link"></a>
			                             <p class="text_content">
		                                	   <c:choose>
					                                <c:when test="${notifi_dtos.getNotifi_amount() > 2}">
					                                	<span><i style="color:gray;"class="fas fa-hand-holding-usd"></i></span> <br>${notifi_dtos.getNotif_title()}	
					                                </c:when>
					                                 <c:when test="${notifi_dtos.getNotifi_amount() eq 2}">
										                <span><i style="color:gray;" class="fas fa-hand-holding-medical"></i></span> <br>${notifi_dtos.getNotif_title()}	
										              </c:when>
					                                <c:otherwise>
					                                		${notifi_dtos.getNotif_title()}	
					                                </c:otherwise>
					                             </c:choose>
		                                </p>
			                                <span class="text_information"><c:choose>
                                								<c:when test="${notifi_dtos.getNotifi_amount() > 2}">
                                									<fmt:parseNumber value = "${notifi_dtos.getNotifi_amount()}" pattern = "000000" var = "notifi_amount"/>
                                									결제금액: <fmt:formatNumber value="${notifi_amount}" pattern="#,###"/>원
                                								</c:when>
                                								<c:when test="${notifi_dtos.getNotifi_amount() eq 2}"> 
                                										참여해주셔서 감사합니다
                                							    </c:when>
                                								<c:otherwise>
	                                									 새로운 도움이 필요해요 
                                								</c:otherwise>
                                								</c:choose>
                                								</span>
                                								
                             <c:forEach items="${t_day_dtos[StatusNm.index]}" varStatus="status" var="day_dtos">
                             <span class="text_information">${day_dtos}</span>
                            </c:forEach>
                            </div>
                        </li>
	                        </c:forEach>
                      	  </c:when>
                      	  <c:otherwise>
                      	  	   		<c:forEach items="${t_notifi_dtos}" var="notifi_dtos" varStatus="StatusNm">
			                        <c:if test="${notifi_dtos.getNotifi_amount() >= 1}">
			                        <li class="item_news type_funding">
			                            <div class="card_news">
			                                <a href="javascript:?()" ></a>
			                                <p class="text_content">
			                                	   	<c:choose>
					                                <c:when test="${notifi_dtos.getNotifi_amount() > 2}">
					                                	<i style="color:gray;" class="fas fa-hand-holding-usd"></i> <br> ${notifi_dtos.getNotif_title()}	
					                                </c:when>
					                                <c:when test="${notifi_dtos.getNotifi_amount() eq 2}">
					                                	<i style="color:gray;" class="fas fa-hand-holding-medical"></i> <br> ${notifi_dtos.getNotif_title()}	
					                                </c:when>
					                                <c:otherwise>
					                                		${notifi_dtos.getNotif_title()}	
					                                </c:otherwise>
				                                </c:choose>
			                                </p>
			                                <span class="text_information">
	           									<fmt:parseNumber value = "${notifi_dtos.getNotifi_amount()}" pattern = "000000" var = "notifi_amount"/>
	           									결제금액: <fmt:formatNumber value="${notifi_amount}" pattern="#,###"/>원
                   							</span>
			                                    <c:forEach items="${t_day_dtos[StatusNm.index]}" varStatus="status" var="day_dtos">
                             <span class="text_information">${day_dtos}</span>
                            </c:forEach>
			                            </div>
			                        </li>
			                        </c:if>
			                        </c:forEach>
                      	  </c:otherwise>
                 </c:choose>
                    </ol>

                </div>
                <!-- 검색 결과가 없거나 활동 내용이 없는 경우 띄울 창 display를 block으로 처리한다.-->
           
            </div>
        </div>
	</form>	
    </div> <!--my-page-box-->



        <script>
            /*메인 header 따라 오기 */
            let header = document.querySelector(".header-header-1");
            let headerHeight = header.offsetHeight;

            window.onscroll = function () {
                let windowTop = window.scrollY;
                if (windowTop >= headerHeight) {
                    header.classList.add("is-scroll");
                } else {
                    header.classList.remove("is-scroll");
                }
            };
            // 

            var kkeys = [],
                konami = "38,38,40,40,37,39,37,39,66,65";
            $(document).keydown(function (e) {
                kkeys.push(e.keyCode);
                if (kkeys.toString().indexOf(konami) >= 0) {
                    kkeys = [];
                    alert('안녕하세요');
                }
            });

            $(document).ready(function() {
                $("#noti_agreement").click(function() { //<input type="checkbox" id="cbx_chkAll"> 가 체크 될 때 작동한다.
                    if($("#noti_agreement").is(":checked")) $(".input_checkbox").prop("checked", true); // 전체 체크가 체크 되었다면 input type 이름이 t_check인 것들은 checked 값이 ture(체크)가 된다.
                    else $(".input_checkbox").prop("checked", false); //input id가 중복 된다면 범위를 지정할수도 있다. .table input[id=t_check] 이런식으로 테이블 범위로만  한정할 수도 있다.
                });
                
                $(".input_checkbox").click(function() { //input name으로 줬었는데 checkbox가 배열로 바뀌면서 name=t_check 나 t_check[] 둘다 인식하지 못해 id로 바꿔줌
                    var total = $(".input_checkbox").length;
                    var checked = $(".input_checkbox:checked").length;

                    if(checked == 0) $("#noti_agreement").prop("checked", false);
                    else $("#noti_agreement").prop("checked", true); 
                });
            });
        </script>

</div>
</body>
<!--footer -->
   <%@ include file="../common_footer.jsp" %>

</div>
</div>
</div>

</html>