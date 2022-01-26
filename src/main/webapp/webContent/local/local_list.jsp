<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<!--##### // Visual & LNB #####-->
<%@ include file = "../common_header2.jsp" %>
<script type="text/javascript">
	function goSearch(search){
	
		sear.t_search.value=search;
		sear.method="post";
		sear.action="LocalNews";
		sear.submit();
	}
	
	function goWriteForm(){
		dona.t_gubun.value="WriteForm";
		dona.method="post";
		dona.action="LocalNews";
		dona.submit();
	}
	function goView(no){
		dona.t_no.value=no;
		dona.t_gubun.value="View";
		dona.method="post";
		dona.action="LocalNews";
		dona.submit();
	}
	function goPage(pageNumber){
		pageform.t_nowPage.value = pageNumber;
		pageform.method="post";
		pageform.action="LocalNews";
		pageform.submit();
	}
</script>
<form name="dona">
	<input type="hidden" name="t_no">
	<input type="hidden" name="t_gubun">
</form>
<form name="pageform">
	<input type="hidden" name="t_nowPage">
	<input type="hidden" name="t_list_setup_count" value="${t_gulsu}">
	<input type="hidden" name="t_select" value="${t_select }">
	<input type="hidden" name="t_search" value="${t_search }">

</form>
<div class="tab-3" data-swipe='{"type":"case1","start":".active"}'>
			<ul>
				<li data-act='tab' class="item"><a href="Donation"><span class="in">기부</span></a></li>
				<li data-act='tab' class="item"><a href="Volunteer"><span class="in">봉사</span></a></li>
				<li data-act='tab' class="item active"><a href="LocalNews"><span class="in">지역뉴스</span></a></li>
				<li data-act='tab' class="item"><a href="Missing"><span class="in">실종아동</span></a></li>
			</ul>
		</div>
	
<!-- 서브 페이지-->	
<div class="sub-main">
	
	<div class="sub-search">
	<h3 class="donation-text-box"><a href="" class="donation-text">100% 전하는 기부 <i class="fas fa-chevron-right"></i></a>
		<br>
		<ul class="">
		<form name="sear">
			<input type="hidden" name="t_search">
                    <li class=""><a href="javascript:goSearch('')"  >
					<h1><i class="fas fa-globe-asia"></i></h1>
					전체 검색</a></li>
                    
					<li class=""><a href="javascript:goSearch('donation')" >
					
					<h1><i class="fas fa-child"></i></h1>
					기부</a></li>
                    
					<li class=""><a href="javascript:goSearch('volulteer')">
					<h1><i class="fas fa-user"></i></h1>
					봉사</a></li>
                    
					
		</form>			
				</ul>
	</div>
	<div class="sub-content">
			 <div class="donation-box">
        

		</h3>    
          
		  <!-- table start-->
			<div class="table-box">
				<table class="table">
					<caption></caption>
					<colgroup>
						<col width="25%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
					
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col">메인 사진</th>
							<th scope="col">타이틀</th>
							<th scope="col">뉴스종류</th>
							<th scope="col">기부/봉사</th>
							<th scope="col">등록일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
			<form name="storeArr">		
					<tbody>
			<c:forEach items="${t_dtos}" var="dtos">	
				
					<tr>
					 <input type="hidden" name="t_no" value="${dtos.getNo()}" >
					 <input type="hidden" name="t_reg_id" value="${dtos.getReg_id()}">
											
						<td>
							<a href="javascript:goView('${dtos.getNo()}')">
							<img src="donaimg/local/${dtos.getAttach()}" alt="뉴스1" style=" width:200px;height:100px;"></a></td>
					
						<td><a style="font-size:15px;" href="javascript:goView('${dtos.getNo()}')">${dtos.getTitle()}</a></td>
					
						<td>
                            <span  style="width:100%;height:30px;font-size:15px;">${dtos.getNews_name()}</span>    
                            </td>	
						
						<td>
							<span  style="width:100%;height:30px;font-size:15px;">${dtos.getSearch()}</span>
						</td>
																		
						<td>
							<span  style="width:100%;height:30px;font-size:15px;">${dtos.getReg_date()}</span>
						</td>
						
						<td>
                        	<span  style="width:100%;height:30px;font-size:15px;">${dtos.getHit()}</span>
					    </td>
					</tr>    
			</c:forEach>
<style>
	.buttona{
		width:75px;
		height:30px;
		background:#000080;
		text-align:center;
	}.buttonb{
		width:75px;
		height:30px;
		background:#AA0114;
		text-align:center;
	}
	.buttona:hover {
		background:#32CD32;
	}	
	.buttonb:hover {
		background:#32CD32;
	}

</style>						
		
		
					</tbody>
			
</form>		
				</table>
			</div>
	</div>
	
	<br>
	<div class="paging" id="paging1">	
	<%	int total_page 				= (int)request.getAttribute("t_total_page");
		int current_page 			= (int)request.getAttribute("t_current_page");
		out.print(CommonUtil.pageListPost(current_page, total_page, 5));
		%>
	</div>	
	<br>
	<input type="button" onclick="goWriteForm()" value="글 쓰 기" class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
						
								



</div>	
</div>
	




</div>
</body>
<%@ include file = "../common_footer.jsp" %>