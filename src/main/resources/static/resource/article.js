$(function () {
  $('.setting-btn').on('click', function (e) {
    e.stopPropagation();
    $(this).closest('li').find('.setting-a').toggle();
  });

  $(document).on('click', function () {
    $('.setting-a').hide();
  });
});


