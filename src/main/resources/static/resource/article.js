$(function () {
  $('.setting-btn').on('click', function (e) {
    e.stopPropagation();
    $(this).closest('li').find('.setting-a').toggle();
  });

  $(document).on('click', function () {
    $('.setting-a').hide();
  });
});

$(document).ready(function () {
  // 댓글의 ... 버튼 눌렀을 때 토글 메뉴 열기/닫기
  $(document).on('click', '.cm-setting-btn', function (e) {
    e.stopPropagation(); // 문서 클릭 이벤트 방지

    const $menu = $(this).siblings('.cm-mnd');

    // 다른 열려 있는 메뉴 닫기
    $('.cm-mnd').not($menu).hide();

    // 현재 메뉴 토글
    $menu.toggle();
  });

  // 메뉴 바깥 클릭 시 모두 닫기
  $(document).on('click', function () {
    $('.cm-mnd').hide();
  });

  // 메뉴 안쪽 클릭 시 닫히는 것 방지
  $(document).on('click', '.cm-mnd', function (e) {
    e.stopPropagation();
  });
});


