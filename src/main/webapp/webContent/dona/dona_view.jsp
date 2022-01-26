<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--##### // Visual & LNB #####-->
<%@ include file = "../common_header2.jsp" %>
<link href="css/sub.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/sub.css" />

<script type="text/javascript">

function moneyChange(){
	var aa = mem.t_email3.value;
	if(aa != ""){
		mem.t_email2.value = aa;
	}else{
		mem.t_email2.value = "";
		mem.t_email2.focus();
	}
	
}
//업데이트 폼으로
	function goUpdateForm(){
	
		list.t_gubun.value="UpdateForm";
		list.method="post";
		list.action="Donation";
		list.submit();
}
//삭제
	function goDelete(){
	if(confirm("정말 지우시겠습니까?")){
		
		list.method="post";
		list.action="DonaDelte";
		list.submit();
}}

//리스트로
	function goList(){
		list.t_gubun.value="List";
		list.method="post";
		list.action="Donation";
		list.submit();
				
	}
//기부하기 버튼
		function goDona(){
		list.t_gubun.value="Dona";
		list.method="post";
		list.action="Donation";
		list.submit();
				
	}



</script>
<form name="list">
	<input type="hidden" name="t_no" value="${t_no}">
	<input type="hidden" name="t_gubun" >
	<input type="hidden" name="t_total" value="${t_total}">
	<input type="hidden" name="t_session_id" >
	<input type="hidden" name="t_dum" >
	<input type="hidden" name="t_search" value="${t_search}">
</form>
<form name="pay">
	<input type="hidden" name="t_donate_moeny">
</form>
<!-- 서브 -->

<div class="tab-3" data-swipe='{"type":"case1","start":".active"}'>
			<ul>
				<li data-act='tab' class="item active"><a href="Donation"><span class="in">기부</span></a></li>
				<li data-act='tab' class="item"><a href="Volunteer"><span class="in">봉사</span></a></li>
				<li data-act='tab' class="item"><a href="LocalNews"><span class="in">지역뉴스</span></a></li>
				<li data-act='tab' class="item"><a href="Missing"><span class="in">실종아동</span></a></li>
			</ul>
		</div>

		<div class="board-view ty-2">
			<div class="board-title">
				<h2 class="title" data-addtitle="this">${t_dto.getTitle()}</h2>
				<p class="title-sub">${t_dto.getDoname()}</span> | ${t_dto.getDominator()} | <i class="fa fa-eye"></i>&nbsp ${t_dto.getHit()}</p>
				<span class="date">${t_dto.getStart_date()} ~ ${t_dto.getEnd_date()}</span>
			</div>

			<div class="board-side" data-grid="{&quot;case&quot;:&quot;pin&quot;, &quot;in&quot;:&quot;.board-view&quot;, &quot;except&quot;:&quot;.header-in&quot;}">
				<div class="inner">
					<!-- 일시/정기기부 -->
						<div class="total">
						<c:set var="gage" value="${t_dto.getTotal() / t_dto.getGoal() *100}"/>
							<span class="value"><strong class="num"><fmt:formatNumber  pattern="###" value="${gage}" /></strong> %</span>
							<span class="progress-3 ir-b i-progress-3"><span class="fill ir-b i-progress-3-fill" style="height:${gage}%;"></span></span>
						</div>
						<dl class="text" id="text2">
							<dt><span class="ir-b i-num-give-2"></span>GIVE</dt>
							<dd><em class="num"> <fmt:formatNumber  pattern="###,###,###,###" value="${t_dto.getTotal()}"/> </em> 원</dd>
							<dt><span class="ir-b i-num-person-2"></span>SUPPORTERS</dt>
							<dd>
								<em class="num">내역서있어야함</em> 명
							</dd>
							<dt><span class="ir-b i-num-goal"></span>GOAL</dt>
							<dd><em class="num"><fmt:formatNumber  pattern="###,###,###,###" value="${t_dto.getGoal()}"/></em> 원</dd>
							
							<dt>기부하실 금액</dt>
							
							<dd>
							  <input type="text" name="t_donate_money_1" id="donate_money">
							<select name="t_donate_money"  onchange="moneyChange();">
								<option value="10000">10,000원</option>
								<option value="30000">30,000원</option>
								<option value="50000">50,000원</option>
								<option value="100000">100,000원</option>
								<option value="">직접입력</option>
							</select></dd>
						</dl>

                        
					
					<!-- 결연 후원 신청 -->
					
					
					<div class="control">
						<!-- 공유하기 // -->
                        
                        <div data-dropdown="" class="share">
                            <button type="button" data-act="title" class="btn-share" id="btn-share"><span class="ir i-share">공유</span></button>
                            <div class="share-open" id="share-open show">
                                <div data-act="cont" id="share-cont" class="share-cont" tabindex="-1">
                                    <span class="share-in">
                                        <a href="javascript:;" onclick="" class="item" data-seq="613" data-img-url="" data-share="facebook" data-cate="hope"><span class="ir-b i-facebook-2"></span><span class="in">페이스북</span></a>
                                        <a href="javascript:;" onclick="" class="item" data-seq="613" data-img-url="" data-share="twitter" data-cate="hope"><span class="ir-b ir-b i-twitter-2"></span><span class="in">트위터</span></a>
                                        <a href="javascript:;" onclick="" class="item"><span class="ir-b i-kakao"></span><span class="in">카카오톡</span></a>
                                        <button type="button" class="copy" onclick="clip(); return false;" title="https://www.smilegatefoundation.org/" data-seq="613" data-img-url="" data-share="url" id="sns_url" data-cate="hope"><span class="in-btn">URL 복사</span></button>
                                    </span>
                                </div>
                            </div>
                        </div>
					
								<button type="button" class="btn-act" onclick="goDona()">지금 기부하기</button>
						
					</div>
					
					
				</div>
			</div>
	<style>

	.viewCont{
		
		white-space:pre-wrap;
		padding-top:50px;
		overflow:auto;
		
	}
	</style>
			<div class="board-content">

				<div data-empty="true" style="text-align: center;">
				<div class="viewCont">${t_dto.getContent()}</div>
				
				</div>
			<div class="btn-area">
				<input type="button" onclick="goList()" value="목 록"class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
				<input type="button" onclick="goUpdateForm()" value="수 정" class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
				<input type="button" onclick="goDelete()" value="삭 제"class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
			</div>
        </div>
    </div>

<!-- 댓글 기능 구현 안함-->



<script>
// 

    var kkeys = [], konami = "38,38,40,40,37,39,37,39,66,65";
$(document).keydown(function(e) {
    kkeys.push( e.keyCode );
    if ( kkeys.toString().indexOf( konami ) >= 0 ){
        kkeys = [];
        alert('안녕하세요');
    }
});

/*공유 버튼 클릭 시 창 열리고 다시 클릭시 꺼짐 'id=share-cont' 에 onclick='toggleDiv() 를 집어넣었으나 모달창으로 교체함*/
/*
function toggleDiv() {
  var div = document.getElementById('share-cont');
  if(div.style.display == 'none')  {
    div.style.display = 'block';
  }else {
    div.style.display = 'none';
  }
}
*/

// 팝업 열기
$(document).on("click", "#btn-share", function (e){
  var target = $(".share-open");
  $(target).addClass("show");
});

// 외부영역 클릭 시 팝업 닫기
$(document).mouseup(function (e){
  var LayerPopup = $(".share-open");
  if(LayerPopup.has(e.target).length === 0){
    LayerPopup.removeClass("show");
  }
});

function clip(){

    var url = '';
    var textarea = document.createElement("textarea");
    document.body.appendChild(textarea);
    url = window.document.location.href;
    textarea.value = url;
    textarea.select();
    document.execCommand("copy");
    document.body.removeChild(textarea);
    alert("URL이 복사되었습니다.")
}
</script>

</div>
</body>



<%@ include file = "../common_footer.jsp" %>