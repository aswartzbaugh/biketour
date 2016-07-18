
$(function () {

    //----------------------Corner Scripts-----------------------// 
    //$('.Menu ul li a').corner("5px");
    //$('.Menu ul li').corner("5px");
    $('.MenuWrap').corner("bottom , 10px");
    $('.Menu ul li .Submenu').corner("bottom , 10px");
    $('.Menu ul li .Submenu li a').corner("1px");
    $('.Menu ul li .Submenu li').corner("1px");
   // $('.container').corner("10px");
   // $('.frmBox').corner("7px");
   // $('.frmBox_2').corner("10px");
    $('.AdminContWrap').corner("7px");
    $('.content').corner("5px");
    $('.glbtn').corner("5px");
    $('.smallglbtn').corner("5px");
    $('.Loginbtn').corner("4px");
    $('.Loginbtn').corner("4px");
    $('.LoginWrap').corner("5px");

    //------------End----------Corner Scripts-----------------------//

    //----------------------Menu Scripts-----------------------//
//    $(".Menu ul li a").css({ backgroundPosition: "-68px 5px" }).hover(function () {
//        $(this).stop().animate({ backgroundPosition: "(32px 5px )" }, { duration: 200 })
//    });
//    $(".Menu ul li a").mouseout(function () {
//        $(this).stop().animate({ backgroundPosition: "(-68px 5px )" }, { duration: 200 })
//    });
    //----------End------------Menu Scripts-----------------------//

    //------------------Submenu Menu Scripts-----------------------//
    $(".Menu ul li").hover(function () {
        $(this).find(".Submenu").slideDown(200);
    }, function () {
        $(this).find(".Submenu").slideUp(100);
    });
    //----------End----Submenu Menu Scripts-----------------------//

    //----------------------RadCombo Scripts-----------------------//
    $(".RadComboBox .rcbReadOnly td.rcbArrowCell a").css({ backgroundPosition: "5px 2px" }).hover(function () {
        $(this).stop().animate({ backgroundPosition: "5px -28px" }, { duration: 200 })
    });
    $(".RadComboBox .rcbReadOnly td.rcbArrowCell a").mouseout(function () {
        $(this).stop().animate({ backgroundPosition: "5px 2px" }, { duration: 200 })
    });
    //---------End-------------RadCombo Scripts-----------------------//

   
    
}); 
