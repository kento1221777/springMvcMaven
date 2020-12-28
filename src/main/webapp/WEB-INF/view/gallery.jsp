<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Photo Gallery</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<header>
	<nav class="navbar navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="home">My Home</a>

			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link" href="members">Members</a></li>
					<li class="nav-item active"><a class="nav-link" href="">Gallery</a></li>
				</ul>
			</div>
		</div>
	</nav>
</header>
<div class="container mt-5">
	<form action="" method="post" enctype="multipart/form-data"
		name="form">
		<p>
			ファイル：<input type="file" name="upfile" id="upfile">
			<input type="submit">
		</p>
	</form>

	<!-- 画像の表示 -->
	<div class="row">
		<c:forEach items="${files}" var="file">
			<div class="col-12 col-md-4">
				<img class="img-thumbnail" src="uploads/<c:out value="${file.name}" />">
			</div>
		</c:forEach>
	</div>
</div><!-- /.container -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>