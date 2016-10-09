<%@ page language="C#" autoeventwireup="true" inherits="_Default, App_Web_xkabdslp" %>


<%@ Register src="../UserControl/GoogleMapForASPNet.ascx" tagname="GoogleMapForASPNet" tagprefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Bike Tour For Calculating Distance </title>
    <style type="text/css">
        .style1
        {
            height: 30px;
        }
    </style>

    <script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"
        type="text/javascript"></script>

    <script type="text/javascript">
        function OrginAutoComplete() {
            try {
                var input = document.getElementById('TextBox1');
                var autocomplete = new google.maps.places.Autocomplete(input);
                autocomplete.setTypes('changetype-geocode');
            }
            catch (err) {
                // alert(err);
            }
        }


        function DestAutoComplete() {
            try {
                var input = document.getElementById('TextBox2');
                var autocomplete = new google.maps.places.Autocomplete(input);
                autocomplete.setTypes('changetype-geocode');
            }
            catch (err) {
                // alert(err);
            }
        }

//        google.maps.event.addDomListener(window, 'load', OrginAutoComplete);
//        google.maps.event.addDomListener(window, 'load', DestAutoComplete);  
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table cellpadding="0" cellspacing="0" align="center" width="700">
            <tr>
                <td colspan="2" height="40">
                    <b>Distance calculation using Google API</b>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    Enter Orgin Place
                </td>
                <td class="style1">
                    <asp:DropDownList ID="ddlFromCity" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsFromCity" DataTextField="CityName" DataValueField="CityId">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsFromCity" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>" 
                        SelectCommand="SELECT [CityId], [CityName] FROM [CityMaster] WHERE ([IsActive] = @IsActive)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="true" Name="IsActive" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:TextBox ID="TextBox1" runat="server" Width="300" Visible="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td height="30">
                    Enter Destination Place
                </td>
                <td>
                <asp:DropDownList ID="ddlToCity" runat="server" DataSourceID="sdsToCity" 
                        DataTextField="cityname" DataValueField="cityid">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsToCity" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>" SelectCommand="select cityid, cityname from citymaster
where isactive =1 and cityid &lt;&gt; @fromcity">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlFromCity" Name="fromcity" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:TextBox ID="TextBox2" runat="server" Width="300" Visible="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" height="60">
                    <asp:Button ID="btnSearch" runat="server" Text="Calculate Distance" OnClick="btnSearch_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" height="40">
                    <br />
                    <br />
                    <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" height="40"> 
                   <%-- <uc2:GoogleMapForASPNet ID="GoogleMapForASPNet1" runat="server" />--%>
                </td>
                   
            </tr>
        </table>
        <br />
    </div>
    </form>
</body>
</html>