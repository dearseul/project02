<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="project.vo.*"
    import ="project.Dao.*"
    %>
<%request.setCharacterEncoding("UTF-8");
String path = request.getContextPath();
String customer_id = (String)session.getAttribute("id");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=path %>/css/reset.css">
    <link type ="text/css" rel="stylesheet" href="<%=path%>/css/main_upper.css">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <title>베스트</title>
    <style>
    body {font-family: 'Noto Sans KR', sans-serif;}

    #mypage { width: 1200px; margin:100px auto; }
    
    /*left-profile*/
    .left-profile { float: left; box-sizing: border-box; width: 25%; margin-right: 5%;  padding: 10px; background-color: #eee; border-radius: 20px; }
    .wrap-name { margin-top: 30px; font-size: 25px; color: #333; text-align: center;}
    .wrap-name .user-name { font-weight: 700; }
    .wrap-img-profile { margin:20px auto 0; width: 200px; height: 200px; border-radius: 500px; overflow: hidden; text-align: center; }
    .img-profile { width: 100%; }
    .wrap-point {  text-align: center;}
    .wrap-point li { display: inline-block; background: #555; color: #fff; border-radius: 3px; padding: 5px 10px; }
    .btn-profile {   display: block; width: 100%; margin: 10px 0px; padding: 10px 0px;  background: #fff;  border: 1px solid #999; font-size: 13px;border-radius: 5px;}
    
    /*right-order*/
    .right-order { width: 70%; float: left; }
    .box-order { overflow: hidden; padding: 10px; margin-bottom: 20px; border:1px solid #ddd; border-radius: 10px; }
    .order-detail {float: left; width: 70%;  padding: 10px; height: 200px; border:1px solid #ddd; border-radius: 10px 0px 0px 10px; box-sizing: border-box;}
    .date-order { color: #222; font-size: 24px; margin-bottom: 20px;}
    .status-order { margin-top: 10px;  font-size: 17px; color:rgb(53, 197, 240); font-weight: 700;}
    .date-arrive { margin-left: 10px; color: #444;font-weight: 500; }
    .prod-order { margin-top: 20px; overflow: hidden; }
    .img-order { width: 100px; float: left; }
    .text-order {padding-left: 10px; float: left; }
    .prod-name { margin-top: 10px; }
    .order-price { margin-top: 10px; margin-right: 5px; display: inline-block; color: #777;}
    .order-cnt {margin-top: 10px;  display: inline-block; color: #777;}

    /*order-btn*/
    .wrap-btn-order { float: left; width: 30%; padding: 20px;height: 200px; border:1px solid #ddd; border-left:none; border-radius: 0px 10px 10px 0px; box-sizing: border-box; }
    .btn-order { width: 100%; display: block;  margin-bottom: 10px;  padding: 7px ; background-color: #fff; border:1px solid #ddd;  border-radius:5px;color: #333;}
    </style>
    <script>
        $(document).ready(function(){
            $('.list-btn-best>li').click(function(){
                $(this).addClass('on');
                $(this).siblings().removeClass('on');
            });
            $('.btn-best-01').click(function(){
                $('.list-best-01').show();
                $('.list-best-02').hide();
            });
            $('.btn-best-02').click(function(){
                $('.list-best-02').show();
                $('.list-best-01').hide();
            });
        });
    </script>
 
</head>

<%
	String product_name = request.getParameter("prodname");
	String product_id = request.getParameter("prodid");
	String proc = request.getParameter("proc");
	String prodname = request.getParameter("prodname2");
	String prodid = request.getParameter("prodid2");
	String pass = (String)session.getAttribute("pw");
	
	String[] result_index = request.getParameterValues("index00");
	String[] result_cnt = request.getParameterValues("cnt00");
%>
<body>
<jsp:include page="/main_upper.jsp" flush="false"/>
   <div id="mypage">
   

        <section class="left-profile">
            <div class="wrap-name">
                <h2><span class="user-name">이탁구</span>님 안녕하세요</h2>
            </div>
            <div class="wrap-img-profile">
                <img class="img-profile" src="<%=path%>/images/img_profile.png" alt="">
            </div>
          <%-- <div class="wrap-point">
                <ul>
                    <li class="box-coupon">쿠폰 <span class="coupon-cnt">1</span>개</li>
                    <li class="box-point">포인트 <span class="coupon-cnt">1000</span></li>
                </ul>
            </div>--%>  
            <a href="<%=path%>/sub/customService/oneQuestion.jsp"><button class="btn-profile btn-question">1:1 문의하기</button></a>
            <button class="btn-profile btn-edit">개인정보 확인/수정</button>
            <button class="btn-profile btn-shipinfo">배송지 관리</button>
        </section>
        <section class="right-order">
        
        <jsp:useBean id="c" class="project.vo.Customer" scope="session"/>
		<jsp:setProperty property="*" name="c" />
		
		<jsp:useBean id="prod" class="project.vo.Products" scope="session"></jsp:useBean>
		<jsp:setProperty property="*" name="prod"/>
				<jsp:useBean id="pr" class="project.vo.Purchase_record"></jsp:useBean>
				<jsp:setProperty property="*" name="pr"/>
		<jsp:useBean id="daop" class="project.dao_payment_page.Dao_payment_page"/>
		    <c:set var="plist" value="${daop.getMyPro(customer_id) }"></c:set>
			<% log(customer_id); 
			%>

            <div class="box-order">
                <div class="date-order"><span class="date-order-v">2021.02.26</span>주문</div>
                <div class="order-detail">
                    <div class="status-order">구매완료<span class="date-arrive"></span></div>
                    <div class="prod-order">
                        <a href="NewFile.jsp"><img class="img-order" src="<%=path%>/images/detail_img2.jpg" alt=""></a>
                        <div class="text-order">
                            <p class="prod-name">볼볼홈파티 그릇</p>
                            <p class="order-price">40000원</p><p class="order-cnt">2개</p>
                        </div>
                    </div>
                </div>
                <div class="wrap-btn-order">
                    <button class="btn-order on">배송조회</button>
                    <a href="<%=path %>/sub/Product/goodsReview.jsp"><button class="btn-order">구매후기 쓰기</button></a>
                    <a href="<%=path %>/sub/Product/goodsQuestion.jsp"><button class="btn-order">판매자 문의하기</button></a>
                </div>
            </div>

                        <div class="box-order">
                <div class="date-order"><span class="date-order-v">2021.02.26</span>주문</div>
                <div class="order-detail">
                    <div class="status-order">구매완료<span class="date-arrive"></span></div>
                    <div class="prod-order">
                        <a href="NewFile.jsp"><img class="img-order" src="<%=path%>/images/detail_img3.jpg" alt=""></a>
                        <div class="text-order">
                            <p class="prod-name">볼볼홈파티 주병세트</p>
                            <p class="order-price">8700원</p><p class="order-cnt">1개</p>
                        </div>
                    </div>
                </div>
                <div class="wrap-btn-order">
                    <button class="btn-order on">배송조회</button>
                    <a href="<%=path %>/sub/Product/goodsReview.jsp"><button class="btn-order">구매후기 쓰기</button></a>
                    <a href="<%=path %>/sub/Product/goodsQuestion.jsp"><button class="btn-order">판매자 문의하기</button></a>
                </div>
            </div>
                    <div class="box-order">
                <div class="date-order"><span class="date-order-v">2021.02.26</span>주문</div>
                <div class="order-detail">
                    <div class="status-order">구매완료<span class="date-arrive"></span></div>
                    <div class="prod-order">
                        <a href="NewFile.jsp"><img class="img-order" src="<%=path%>/images/bowl06.jpg" alt=""></a>
                        <div class="text-order">
                            <p class="prod-name">그릇6</p>
                            <p class="order-price">9000원</p><p class="order-cnt">1개</p>
                        </div>
                    </div>
                </div>
                <div class="wrap-btn-order">
                    <button class="btn-order on">배송조회</button>
                    <a href="<%=path %>/sub/Product/goodsReview.jsp"><button class="btn-order">구매후기 쓰기</button></a>
                    <a href="<%=path %>/sub/Product/goodsQuestion.jsp"><button class="btn-order">판매자 문의하기</button></a>
                </div>
            </div>
        </section>
    </div>
</body>
</html>