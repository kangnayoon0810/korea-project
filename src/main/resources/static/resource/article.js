$(function(){
	getLikePoint();
})
	
const clickLikePoint = async function () {
	let likePointBtn = $('#likePointBtn > i').hasClass('fa-solid');
	
	await $.ajax({
		url : '/usr/likePoint/clickLikePoint',
		type : 'GET',
		data : {
			relTypeCode : 'article',
			relId : articleId,
			likePointBtn : likePointBtn
		},
	})
	await getLikePoint();
}
		
const getLikePoint = function () {
	$.ajax({
		url : '/usr/likePoint/getLikePoint',
		type : 'GET',
		data : {
			relTypeCode : 'article',
			relId : articleId,
		},
		dataType : 'json',
		success : function (data) {
			$('#likePointCnt').html(data.rsData);
			
			if (data.success) {
				$('#likePointBtn').html(`<i class="fa-solid fa-heart text-red-500"></i>`);
			} else {
				$('#likePointBtn').html(`<i class="fa-regular fa-heart"></i>`);
			}
		},
		error : function (xhr, status, error) {
			console.log(error);
		}
	})
}