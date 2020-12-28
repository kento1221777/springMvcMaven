<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Members</title>
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
					<li class="nav-item active""><a class="nav-link" href="">Members</a></li>
					<li class="nav-item"><a class="nav-link" href="gallery">Gallery</a></li>
				</ul>
			</div>
		</div>
	</nav>
</header>
<div class="container mt-5">
	<h1 class="mb-4">会員管理システム</h1>

	<h2 class="mb-4">新規登録</h2>
	氏名：<input type="text" id="add_name">
	　年齢：<input type="number" id="add_age">
	　住所：<input type="text" id="add_address">
	　会員種別：
	<select id="add_typeId">
		<option value="1">通常会員</option>
		<option value="2">プレミアム会員</option>
	</select>
	　<button class="btn btn-primary" id="add_button">登録</button>

	<h2 class="my-4">会員一覧</h2>
	<table id="members" class="table">
	<thead>
		<tr>
			<th>ID</th>
			<th>氏名</th>
			<th>年齢</th>
			<th>住所</th>
			<th>会員種別</th>
			<th>登録日</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${members}" var="member">
		<tr>
			<td><c:out value="${member.id}" /></td>
			<td><c:out value="${member.name}" /></td>
			<td><c:out value="${member.age}" /></td>
			<td><c:out value="${member.address}" /></td>
			<td><c:out value="${member.typeName}" /></td>
			<td><fmt:formatDate value="${member.created}" pattern="yyyy年M月d日" /></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div><!-- /.container -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
// JSP内では、バッククォートが使用不可の模様

// APIのエンドポイント
const API_URL = '<spring:url value="/api/members" />';

// タイムスタンプを「〇年〇月〇日」にフォーマットする
function timestampToYMD(timestamp) {
	const date = new Date(timestamp);
	return date.getFullYear() + '年' + date.getMonth() + '月' + date.getDate() + '日';
}

// テーブルの１行を生成する
function createTableRow(member) {
	console.log(member);
	let element = '<tr>';
	element += '<td>' + member.id + '</td>';
	element += '<td>' + member.name + '</td>';
	element += '<td>' + member.age + '</td>';
	element += '<td>' + member.address + '</td>';
	element += '<td>' + member.typeName + '</td>';
	element += '<td>' + timestampToYMD(member.created) + '</td>';
	element += '</tr>';
	return element;
}

// AJAXで会員データを取得し、テーブル行として挿入する
function showMembers() {
	$.ajax({
		url: API_URL,
		type: 'GET'
	})
	.done((res) => {
		// 一度、<tbody>内を空にする
		$('#members tbody').html("");

		// テーブル行を追加する
		for(member of res) {
			const element = createTableRow(member);
			$('#members tbody').append(element);
		}
	})
	.fail();
}

//AJAXで会員データを追加する
function addMember(member) {
	$.ajax({
		url: API_URL,
		type: 'POST',
		data: JSON.stringify(member),
		contentType: 'application/json;charset=UTF-8'
	})
	.done((res) => {
		console.log(res);
		if(res == 'success') {
			// テーブルを更新する
			showMembers();

			// フォームをクリアする
			$('#add_name').val('');
			$('#add_age').val('');
			$('#add_address').val('');
			$('#add_typeId').val(1);
		}
	})
	.fail();
}

// 新規登録ボタン押下時の処理
$('#add_button').on('click', () => {
	// 会員データの集約
	const member = {};
	member.name = $('#add_name').val();
	member.age = $('#add_age').val();
	member.address = $('#add_address').val();
	member.typeId = $('#add_typeId').val();

	// 会員を追加
	addMember(member);
});
</script>
</body>
</html>