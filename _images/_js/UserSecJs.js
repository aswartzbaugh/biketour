$(function () {
        
     //---------------------------------Refresh on resize---------------------------------------//
        $(window).bind('resize', function () {
            window.location.href = window.location.href;
            
        });
        //----------------End-------------Refresh on resize---------------------------------------//

            if ($(window).width() < 800) {
                //DropDown Menu Mobile/tablet
                $(".menuwrapp ul.menuUl li").click(function () {
                    $(this).find('.Submenu').slideToggle(250);

                    //$("#Child").css('display', 'block');
                    //return false;
                });
            }
            else {
                //DropDown Menu
                $(".menuwrapp ul.menuUl li").hover(function () {
                    $(this).find('.Submenu').stop().slideDown(250);
                    //$("#Child").css('display', 'block');
                    //return false;
                }, function () {
                    $(this).find('.Submenu').stop().slideUp(150);
                });
            }
            
            $("#Menubtn").click(function () {
                $("ul.menuUl").slideToggle(200);
                $(this).toggleClass("MenuHide");
            })
            // example 2 (Gallery)
            $("ul.example2").simplecarousel({
                auto: 4000,
                fade: 400,
                pagination: false,
                //type: 'random'
            });

            //Script for Alternate Gide Style
            $("table.HdtlTbl tr:odd").attr("class", "dtlTableAltr");
            $("table.HdtlTbl2 tr:odd").attr("class", "dtlTableAltr2");
            $("ul.HomeDtlul li:odd").attr("class", "dtlTableAltr");
            

});