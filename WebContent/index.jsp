<%--from techtutuorial --%>

<%@page import="com.connection.DbCon"%>
<%@page import="com.dao.HouseDao"%>
<%@page import="com.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("person", auth);
}
HouseDao hd = new HouseDao(DbCon.getConnection());
List<House> houses = hd.getAllHouses();
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>Housing Selector</title>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container">
		<div class="card-header my-3">All Houses</div>
		<div class="row">
			<%
			if (!houses.isEmpty()) {
					for (House h : houses) {
			%>
			<div class="col-md-3 my-3">
				<div class="card w-100 h-100">
					<img class="card-img-top" src="product-image/<%=h.getImage() %>"
						alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%=h.getName() %></h5>
						<h6 class="price">Price: $<%=h.getPrice() %></h6>
						<h6 class="category">Category: <%=h.getCategory() %></h6>
						<div class="mt-3 d-flex justify-content-between">
							<a class="btn btn-dark" href="add-to-cart?id=<%=h.getId()%>">Add to Cart</a> <a
								class="btn btn-primary" href="order-now?quantity=1&id=<%=h.getId()%>">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			} else {
			out.println("There is no houses");
			}
			%>

		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>