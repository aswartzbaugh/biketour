


function ShowAlert() {
    setTimeout(function () {
        $('#alertBox').fadeOut('slow');
        $('#mask').fadeOut("slow");
    }, 7000);
    var msg = $("#alertBox span").html();
    $("#alertBox span:contains('Successfully')").css("background-image", "url(../_images/Success.png)");
    $('#imgClose').click(function () {
        // $('#alertBox').hide(500);
        $('#alertBox').fadeOut("slow");
        $('#mask').fadeOut("slow");
    });
    
    if (msg != "") {
        if (msg != null) {
            $('#alertBox').fadeIn("slow");
            var maskHeight = $(document).height();
            var maskWidth = $(window).width();
            $('#mask').css({ 'width': maskWidth, 'height': maskHeight });
            //$('#mask').fadeIn(1000);
            $('#mask').fadeTo("slow", 0.7);
            $("#alertBox span").html() = null;
            return false;
        }
    }
}
 $('#imgClose').click(function () {
        // $('#alertBox').hide(500);
        $('#alertBox').fadeOut("slow");
        $('#mask').fadeOut("slow");

    });

    function Showpop() {
//        setTimeout(function () {
//            $('#pnlPopUp').fadeOut('slow');
//            $('#mask').fadeOut("slow");
//        }, 5000);
        var msg = $("#pnlPopUp span").html();
        var msg1 = $("#pnlPopUp span").html();

        $("#pnlPopUp span:contains('Successfully')").css("background-image", "url(../_images/Success.png)");
        $('#imgClose').click(function () {
            // $('#alertBox').hide(500);
            $('#alertBox').fadeOut("slow");
            $('#mask').fadeOut("slow");

        });
        if (msg != "") {
            if (msg != null) {
                $('#pnlPopUp').fadeIn("slow");
                var maskHeight = $(document).height();
                var maskWidth = $(window).width();
                $('#mask').css({ 'width': maskWidth, 'height': maskHeight });
                //$('#mask').fadeIn(1000);
                $('#mask').fadeTo("slow", 0.7);
                return false;
                $("#pnlPopUp span").html() = null;
            }
          }
       }

       
//----------------Go Back-------------------//
    function goBack()
  {
      window.history.back();
  }
  //-------End---------Go Back---------------//

  function ShowDtlPop() {
//      setTimeout(function () {
//          $('#alertBox').fadeOut('slow');
//          $('#mask').fadeOut("slow");
//      }, 7000);
      var msg = $("#alertpopBox span").html();
      $("#alertpopBox span:contains('Successfully')").css("background-image", "url(../_images/Success.png)");
      $('#imgClose2').click(function () {
          // $('#alertBox').hide(500);
          $('#alertpopBox').fadeOut("slow");
          $('#mask').fadeOut("slow");
      });

      $('#alertpopBox').fadeIn("slow");
      var maskHeight = $(document).height();
      var maskWidth = $(window).width();
      $('#mask').css({ 'width': maskWidth, 'height': maskHeight });
      //$('#mask').fadeIn(1000);
      $('#mask').fadeTo("slow", 0.7);
      $("#alertpopBox span").html() = null;
      return false;
         
  }