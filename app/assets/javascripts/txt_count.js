$(function(){
    var countMax = 1000;
    $('textarea').bind('keydown keyup keypress change',function(){
        var thisValueLength = $(this).val().length;
        var countDown = (countMax)-(thisValueLength);
        $('.count').html(countDown);

        if(countDown < 0){
            $('.count').css({color:'#ff0000',fontWeight:'bold'});
        } else {
            $('.count').css({color:'#000000',fontWeight:'normal'});
        }
    });
    $(window).load(function(){
        $('.count').html(countMax);
    });
});

$(function(){
  if ($("#text2").val().length == 0) {
    $("#submit2").prop("disabled", true);
  }
  $("#text2").on("keydown keyup keypress change", function() {
    if ($(this).val().length < 5) {
      $("#submit2").prop("disabled", true);
    } else {
      $("#submit2").prop("disabled", false);
    }
  });
});
