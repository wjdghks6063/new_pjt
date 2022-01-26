<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ include file="../common_header.jsp" %>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> </code>
    <!--페이지 css-->
    <link href="css/mypage-menu.css" rel="stylesheet">
    <link href="css/mypage-home.css" rel="stylesheet">
    <!--script 밑에 body와 </div> 있음-->

<script>
	function MemberinfoUpdate(){
		
		Swal.fire({
	  		icon: 'success',
			  title: '<div style="font-size:25px;font-family:Dongle;color:#A9A9A9;"> 개인정보 수정을 위해 <br><br>이동하시겠습니까? </div>',
			  padding: '3em',
			  color: '#A9A9A9',
			  confirmButtonColor: 'gray',
			  showCancelButton: true,
			  confirmButtonText: '네',
			  cancelButtonText: '아니오',
			  cancelButtonColor: '#A9A9A9',
			  reverseButtons: true
	  		}).then((result) => {
				if (result.isConfirmed) { 
					
					member.method="post";
					member.action="Mypage_update";
					member.submit();
				  }else{
					        }
					}) 
	}
</script>
	<form name="member">
	<input type="hidden" name="t_id" value="${session_id}">
    <div class="my-page-box">
        <div class="my-list-left">
            <div class="my-profile">
                <div class="my_profile_nickname">
                    <span class="ellipsis" id="nickNameArea">${session_name}</span>
                </div>
                <div class="my_profile_id" id="maskingIdArea">${session_id}</div>
                <div class="setting_button" style="float:right;"><a href="javascript:MemberinfoUpdate()" title="정보수정"><i class="fas fa-cog"></i></a></div>
            </div>
            <div id="lnb" class="my_lnb" role="menu">
                <a href="Mypage_home?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_home" aria-current="true">MY홈</a> 
                <a href="Mypage_news?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_notification" aria-current="false">내 소식</a>
                <a href="Mypage_activity?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_activity" aria-current="false">활동내역</a> 
                <a href="Mypage_regular_payment?t_id=${session_id}" role="menuitem" id="my_lnb_item" class="my_lnb_item" aria-current="false">정기결제관리</a>
                <a href="Mypage_year?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_tax" aria-current="false">연말정산</a>
            </div>
        </div>
        
            <!--후원 금액 표시 -->
        <div role="main" id="content" class="my_content">
            <div class="my_summary_wrap" id="mySummaryAll">
                <div class="my_summary_box">
                    <div class="my_summary_title">
                        <h3 class="title">주간 후원금액</h3>  
                        <span class="number_wrap"><span class="number" id="myCashTotal"><fmt:formatNumber value="${t_today_amount_dto.getToday_amount()}" pattern="#,###"/> </span>원</span>
                    </div>
                       <div class="my_summary_title">
                        <h3 class="title">주간 봉사횟수</h3><span class="number_wrap"><strong class="number" id="mySponTotal"> ${t_week_count} </strong>회</span>
                </div>
                </div>
                <div class="my_summary_box">
                    <div class="my_summary_title">
                        <h3 class="title">총 후원금액</h3><span class="number_wrap"><strong class="number" id="mySponTotal"><fmt:formatNumber value="${t_total_amount_dto.getTotal_amount()}" pattern="#,###"/> </strong>원</span>
                    </div>
                    <div class="my_summary_title">
                        <h3 class="title">총 봉사횟수</h3><span class="number_wrap"><strong class="number" id="mySponTotal"> ${t_total_count}</strong>회</span>
                </div>
                </div>
            </div>
        

                <!-- 내 소식 -->
            <div class="my_recent_news_wrap" id="my_notification">
                <h3 class="my_recent_news_title">내 소식</h3><span class="my_recent_news_count"></span>
                <p class="my_recent_news_guide"><i class="fas fa-exclamation-circle"></i> 결제 알림은 마케팅 알림 수신 동의 여부와 관계없이 발송됩니다.</p><div class="my_recent_news_feed">
                    <ol class="list_news" id="my_notification_list">
                      <c:choose>
                      <c:when test = "${t_mem_dto.getNotification_yn() eq 'y'}">
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
                                </p><p>
                                				
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
                                								
                                								<c:choose>
                                								<c:when test="${notifi_dtos.getNotifi_amount() > 1}">
                                								</c:when>
                                								<c:otherwise>
                                								</c:otherwise>
                                								</c:choose>
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
			                    
			                            <c:choose>
                                            	
                                            	<c:when test="${fn:substring(notifi_dtos.getNotif_no(),0,1) eq 'V'}">
                                            		<li class="item_news type_funding_vol">
                                            	</c:when>
                                            	<c:when test="${fn:substring(notifi_dtos.getNotif_no(),0,1) eq 'D'}">
                                            		<li class="item_news type_funding">
                                            	</c:when>
                                            	</c:choose>
			                       
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
                </div><a href="Mypage_news?t_id=${session_id}" class="my_recent_news_link">더보기 <i class="fas fa-chevron-right"></i></a>
            </div>
        </div>
    </div>
</form>
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
        </script>

</div>
</body>
<!--footer -->
<footer class="footer-box">
    <div class="footer-top">
        <dl class="footer-top-box">
            <dt class="footer-top-notice"><a href="">공지사항</a></dt>
            <dd class="foorer-top-notice-text">
                <a href="">회원 가입시 개인정보 관리 내역에 대해 안내해드립니다.<i class="icon-n"><i class="fab fa-envira"></i></i></a>
            </dd>
        </dl>
        <div class="service-info-box" aria-hidden="false">
            <dl class="service-info-first-line">
                <dt class="service-info-first-line-title">해피빈 안내</dt>
                <dd class="service-info-first-line-item"><a href="">해피빈 소개</a></dd>
                <dd class="service-info-first-line-item"><a href="">해피빈 현황</a></dd>
            </dl>
            <dl class="service-info-first-line">
                <dt class="service-info-first-line-title">제휴∙단체안내</dt>
                <dd class="service-info-first-line-item"><a href="">해피로그 가입</a></dd>
                <dd class="service-info-first-line-item"><a href="">기업제휴 문의</a></dd>
                <dd class="service-info-first-line-item"><a href="">펀딩 개설 신청</a></dd>
            </dl>
        </div>
    </div>

    <div class="footer-info-box">
        <div class="footer-info-inner">
            <ul class="footer-info-list">
                <li class="footer-info-item"><a href="" target="해피빈 이용약관">해피빈 이용약관</a></li>
                <li class="footer-info-item"><a href="" target="개인정보처리방침"><strong>개인정보처리방침</strong></a></li>
                <li class="footer-info-item"><a href="" target="책임의 한계와 법적고지">책임의 한계와 법적고지</a></li>
                <li class="footer-info-item"><a href="" target="고객센터">고객센터</a></li>
                <li class="footer-info-item"><a href="" target="공익제보(행정안전부)">공익제보(행정안전부)</a></li>
            </ul><br>
            <!--ul 끼리 붙어 있어 줄바꿈이 생기지 않아서 넣어줌-->
            <ul class="footer-info-list">
                <li class="footer-info-item">제단법인 굿아이디어</li>
                <li class="footer-info-item">대표 : 최정우</li>
                <li class="footer-info-item">사업자 등록번호 :199-40-91928</li>
                <li class="footer-info-item">통신판매업신고 : 2015-대전충남-1994호</li>
            </ul><br>
            <address class="footer-info-address">대전 충남 대덕대로 150 11층 (갈마동,창원빌딩) 대표전화 : 1588-8282</address>
            <small class="footer-info_notice">
                재능 기부 및 직접기부의 진행과 리워드 제공의 책임은 해당 프로젝트의 개설자에게 있습니다. 굿아이디어는 해당 프로젝트의 당사자가 아니며, 리워드 제공에 대한 책임을 지지 않습니다.
            </small>
            <div class="footer-info-copyright">
                <a href="" class="footer-info-logo">
                    <img src="img/company.png" class="company-logo" alt="LOGO">
                </a> <br>
                <span class="Copyright">Copyright © G&I Corp. All Rights Reserved.</span>
            </div>
        </div>
    </div>

</footer>

</div>
</div>
</div>

</html>