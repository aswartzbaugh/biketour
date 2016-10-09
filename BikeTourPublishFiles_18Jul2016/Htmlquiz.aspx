<%@ page language="C#" autoeventwireup="true" inherits="quiz, App_Web_ymnmxjfp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function onParentLoad() {
            //window.top.location.href = getURL() + "Student/HtmlForum.aspx";            
            window.top.location.href = "Student/HtmlForum.aspx"
        }

        function getURL() {
            var arr = window.location.href.split("/");
            delete arr[arr.length - 1];
            return arr.join("/");
        }
    </script>

</head>
<body onload="onParentLoad();">
    <form id="form1" runat="server">
     
        <div>
        </div>
    </form>
</body>
</html>
