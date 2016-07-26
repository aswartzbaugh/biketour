<%@ page culture="de-DE" uiculture="de-DE" title="Bike Tour - Participating Cities" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="AppAdmin_ParticipatingCityAdmin, App_Web_ekadcbkj" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../_css/AdminLayout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () { $("[id$=btnDelete]").hide(); });
        function Confirm(obj) {
            var Ok = confirm('Confirm Delete ?');
            if (Ok) {
                $("[id$=hdn_CityId]").val(obj);
                $("[id$=btnDeleteCity]").trigger("click");
                return true;
            }
            else {
                return false;
            }
        }

        function getStringVal() {
            var retval = "testMosi";

            alert(retval);
        }

    </script>
    <script language="javascript" type="text/javascript">

        function ValidateFileUpload(Source, args) {
            var fuData = document.getElementById('<%= fuCityImage.ClientID %>');
            var FileUploadPath = fuData.value;

            var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
            if (Extension == "gif" || Extension == "jpeg" || Extension == "jpg" || Extension == "png" || Extension == "bmp") {
                args.IsValid = true; // Valid file type
                FileUploadPath == '';
            }
            else {
                args.IsValid = false; // Not valid file type
            }
        }
    </script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?v=3.1&sensor=false&language=de"></script>
    <script type="text/javascript">
        var latlng = new google.maps.LatLng(37.09024, -95.71289);
        function initialize() {

            var myOptions =
            {
                zoom: 8,
                center: latlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP

            };
            var map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);
            var marker = new google.maps.Marker({
                position: latlng,
                map: map,
                title: "You are hered!",
                draggable: true
            });

            google.maps.event.addListener(marker, "dragend", function () {
                var point = marker.getPosition();

                document.getElementById("<%=txtLatitude.ClientID%>").value = point.lat().toFixed(5);
                document.getElementById("<%=txtLongitude.ClientID%>").value = point.lng().toFixed(5);
            });
        }


        function place(lat, lng) {

            latlng = new google.maps.LatLng(lat, lng);
            var myOptions =
            {
                zoom: 8,
                center: latlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            document.getElementById("<%=txtLatitude.ClientID%>").value = lat;
            document.getElementById("<%=txtLongitude.ClientID%>").value = lng;

            document.getElementById('ContentPlaceHolder1_hdnLatitude').value = lat;
            document.getElementById('ContentPlaceHolder1_hdnLongitude').value = lng;

            var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

            var marker = new google.maps.Marker({
                position: latlng,
                map: map,
                title: "You are here!",
                draggable: true
            });

            google.maps.event.addListener(marker, "dragend", function () {
                var point = marker.getPosition();
                document.getElementById("<%=txtLatitude.ClientID%>").value = point.lat().toFixed(5);
                document.getElementById("<%=txtLongitude.ClientID%>").value = point.lng().toFixed(5);

                document.getElementById('ContentPlaceHolder1_hdnLatitude').value = point.lat().toFixed(5);
                document.getElementById('ContentPlaceHolder1_hdnLongitude').value = point.lng().toFixed(5);
            });
            document.getElementById("message").innerHTML = "";
        }

        function GetLocations() {
            if (document.getElementById('ContentPlaceHolder1_txt_City').value != "") {
                var latlng = new google.maps.LatLng(37.09024, -95.71289);
                var myOptions = {
                    zoom: 8,
                    center: latlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

                //var address = document.getElementById('ContentPlaceHolder1_txtLocality').value + ' ' + document.getElementById('ContentPlaceHolder1_ddlCity').value + ' ' + document.getElementById('ContentPlaceHolder1_txtZip').value + ' ' + document.getElementById('ContentPlaceHolder1_ddlState').value + ' ' + document.getElementById('ContentPlaceHolder1_ddlCountry').value;
                var address = document.getElementById('ContentPlaceHolder1_txt_City').value + ' Germany';

                var geocoder;
                geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': address }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        if (results.length > 1) {
                            document.getElementById("message").innerHTML = "Did you mean:";
                            // Loop through the results
                            for (var i = 0; i < results.length; i++) {
                                document.getElementById("message").innerHTML += "<br>" + (i + 1) + ": <a href='javascript:place(" + results[0].geometry.location.lat().toFixed(5) + "," + results[0].geometry.location.lng().toFixed(5) + ")'>" + results[i].formatted_address + "<\/a>";
                            }
                        }
                        else {
                            document.getElementById("message").innerHTML = "";
                            place(results[0].geometry.location.lat().toFixed(5), results[0].geometry.location.lng().toFixed(5));
                            document.getElementById("ContentPlaceHolder1_rfvPreview").style.display = "none";
                        }
                    }
                    else {
                        alert("Geocode was not successful for the following reason: " + status);
                        document.getElementById("<%=txtLatitude.ClientID%>").value = '';
                        document.getElementById("<%=txtLongitude.ClientID%>").value = '';
                    }
                });
            } else {
                alert(document.getElementById("<%=lblMsgEnterCity.ClientID%>").innerHTML);
                document.getElementById("<%=txtLatitude.ClientID%>").value = '';
                document.getElementById("<%=txtLongitude.ClientID%>").value = '';
            }
        }
    </script>
    <script type="text/javascript">
        initialize();
    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
 <asp:Label ID="lblMsgEnterCity" runat="server" meta:ResourceKey="lblMsgEnterCity" style="display:none;"></asp:Label>
   
    <div class="container">
        <h5>
            <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">City Master</asp:Label>
        </h5>
        <div class="AdminContWrap">
            <asp:Panel ID="pnl_AddCity" runat="server" Visible="false" DefaultButton="btn_Save">
                <div class="frmBox">
                    <asp:LinkButton ID="lbtnAddCity" runat="server" meta:ResourceKey="lbtnAddCity" Visible="false"
                        CssClass="linkbtn right" OnClick="lbtnAddCity_Click"></asp:LinkButton>
                    <table cellpadding="0" cellspacing="5">
                        <tr>
                            <td>
                                <asp:Label ID="lbl_City" runat="server" meta:ResourceKey="lbl_City" CssClass="GlbLbl"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCity" runat="server" DataSourceID="sdsCityDropdown" DataTextField="CityName"
                                    DataValueField="CityId">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsCityDropdown" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="SELECT '0' as [CityId], 'Select City' as [CityName]  union all SELECT [CityId], [CityName] FROM [CityMaster] WHERE ([IsActive] = @IsActive) order by CityName">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="true" Name="IsActive" Type="Boolean" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="rfvCityDdl" runat="server" ErrorMessage="Please select City"
                                    Display="Dynamic" ControlToValidate="ddlCity" InitialValue="0" CssClass="error"
                                    meta:ResourceKey="rfvCityDdl"></asp:RequiredFieldValidator>
                                <br />
                                <asp:TextBox ID="txt_City" runat="server" CssClass="Glbtxt"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="<br/>Please Enter City Name"
                                    CssClass="error" Display="Dynamic" ControlToValidate="txt_City" ValidationGroup="save"
                                    meta:ResourceKey="RequiredFieldValidator1"></asp:RequiredFieldValidator>
                            </td>
                            <td rowspan="6">
                                <br />
                                <div id="map_canvas" style="width: 395px; height: 250px">
                                </div>
                                <br />
                                <div id="message" style="width: 100%">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_CityGer" runat="server" meta:ResourceKey="lbl_CityGer" CssClass="GlbLbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_CityGer" runat="server" CssClass="Glbtxt"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCityImage" runat="server" meta:ResourceKey="lblCityImage" CssClass="GlbLbl"></asp:Label>
                            </td>
                            <td>
                                <asp:FileUpload ID="fuCityImage" runat="server" />
                                <asp:HiddenField ID="hdnImageName" runat="server" />
                                <br />
                                <asp:CustomValidator ID="custvImage" runat="server" ControlToValidate="fuCityImage"
                                    ClientValidationFunction="ValidateFileUpload" meta:ResourceKey="custvImage" ErrorMessage="Please select valid gif/jpeg/jpg/png/bmp file"
                                    CssClass="error" Display="Dynamic" ValidationGroup="save"></asp:CustomValidator>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCurrentImage" runat="server" Visible="false" meta:ResourceKey="lblCurrentImage"
                                    CssClass="GlbLbl"></asp:Label>
                            </td>
                            <td>
                                <asp:Image ID="imgImage" runat="server" Visible="false" Height="50px" Width="60px"
                                    meta:ResourceKey="imgImage" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="server" meta:ResourceKey="lblMapText"
                                    CssClass="GlbLbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMapText" runat="server" TextMode="MultiLine" MaxLength="90"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsParticipating" runat="server" CssClass="checkbox" meta:ResourceKey="chkIsParticipating" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a id="lnkGetGeoLocations" onclick="GetLocations(); return false;" >
                                    <asp:Label ID="lblbtnPreview" runat="server" CssClass="Globalbtn"  meta:ResourceKey="lblbtnPreview"></asp:Label></a>
                                    <br />
                                <asp:RequiredFieldValidator ID="rfvPreview" runat="server" 
                                    ControlToValidate="txtLongitude" CssClass="error" Display="Dynamic" 
                                    ErrorMessage="Click Preview" meta:ResourceKey="rfvPreview" 
                                    ValidationGroup="save"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLatitude" runat="server"  meta:ResourceKey="lblLatitude"></asp:Label>
                                <asp:TextBox ID="txtLatitude" runat="server" Enabled="false"></asp:TextBox>
                                <asp:HiddenField ID="hdnLatitude" runat="server" />
                            </td>
                            <td>
                                <asp:Label ID="lblLongitude" runat="server" meta:ResourceKey="lblLongitude"></asp:Label>
                                <asp:TextBox ID="txtLongitude" runat="server" Enabled="false"></asp:TextBox>
                                <asp:HiddenField ID="hdnLongitude" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td colspan="2">
                                <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save" ValidationGroup="save"
                                    OnClick="btn_Save_Click" />
                                <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" OnClick="btn_Cancel_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnl_CityList" runat="server" DefaultButton="txtSearchCity">
                <div class="frmBox">
                    <asp:HiddenField ID="hdn_CityId" runat="server" />
                    <asp:Button ID="btn_AddNew" runat="server" meta:ResourceKey="btn_AddNew" CssClass="right"
                        OnClick="btn_AddNew_Click" />
                    <div class="div_SearchBox">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCityName" runat="server" meta:ResourceKey="lblCityName" CssClass="GlbLbl"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSearchBox" runat="server" CssClass="Glbtxt"></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtSearchBox"
                                        MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1" CompletionInterval="100"
                                        ServiceMethod="GetCityNames">
                                    </asp:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblIsParticipatingCity" runat="server" CssClass="GlbLbl left" meta:ResourceKey="lblIsParticipatingCity"></asp:Label>
                                </td>
                                <td style="width: 250px;">
                                    <asp:CheckBox ID="chkIsParticipatingCity" runat="server" Checked="True" TextAlign="Left"
                                        CssClass="checkbox" AutoPostBack="True" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="txtSearchCity" CssClass="left" runat="server" meta:ResourceKey="txtSearchCity"
                                        OnClick="txtSearchCity_Click" />
                                    <asp:Button ID="btn_SearchCancel" runat="server" meta:ResourceKey="btn_SearchCancel"
                                        OnClick="btn_SearchCancel_Click" HeaderStyle-CssClass="gridHeader" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="clear">
                </div>
                <div class="GridWrap">
                    <asp:GridView ID="grd_CityList" runat="server" AutoGenerateColumns="False" DataKeyNames="CityId"
                        Width="100%" DataSourceID="sds_CityList" AllowPaging="True" 
                        PagerStyle-CssClass="width" AllowSorting="True" 
                        HeaderStyle-CssClass="gridHeader" onrowcommand="grd_CityList_RowCommand" 
                        onrowdatabound="grd_CityList_RowDataBound" 
                        onsorting="grd_CityList_Sorting" 
                        onpageindexchanging="grd_CityList_PageIndexChanging" >
                        <EmptyDataTemplate>
                        <asp:Label ID="lblEmptyData" runat="server" meta:ResourceKey="lblEmptyData"></asp:Label>
                    </EmptyDataTemplate>
                        <Columns>
                            <%--<asp:ImageField DataImageUrlField="CityImage" DataImageUrlFormatString="../CityImages/{0}"
                         ControlStyle-Height="50px" ControlStyle-Width="60px" AlternateText="No Image" HeaderText="City Image">
                         </asp:ImageField>--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdImageName" runat="server" meta:ResourceKey="lblgrdImageName"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Image ID="imgImageName" runat="server" Height="70" Width="70" ImageUrl='<%# "../CityImages/" + Eval("CityImage")%>'
                                        meta:ResourceKey="imgImageName" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:BoundField DataField="CityName" HeaderText="City" SortExpression="CityName"   />--%>
                            <asp:TemplateField SortExpression="CityName">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrdCity" runat="server" meta:ResourceKey="lblgrdCity"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdCity" runat="server" meta:ResourceKey="lbtngrdCity" CommandName="sort" CommandArgument="CityName"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdCity" runat="server"> </asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdIspar" runat="server" meta:ResourceKey="lblgrdIspar"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>

                                     <asp:HiddenField ID="hdnisPatrcipating" runat="server"  Value='<%# Eval("IsParticipatingCity") %>' />
                                     <asp:PlaceHolder id="plcisParticipating" runat="server"> </asp:PlaceHolder>
                                    <%--<asp:Label ID="lblIsParticipating" runat="server" Text='<%#("IsParticipatingCity") %>'></asp:Label>--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="50px"><HeaderTemplate>
                                    <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="btn_Edit" runat="server" Text="" CssClass="grdedit" meta:ResourceKey="btn_Edit"
                                        CommandArgument='<%# Eval("CityID") %>' OnClick="btnEdit_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField HeaderStyle-Width="50px"><HeaderTemplate>
                                    <asp:Label ID="lblCityDelete" runat="server" meta:ResourceKey="lblCityDelete"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                 <input type="button" id="but1" class="grddel" onclick="Confirm('<%# Eval("CityID") %>    ')"
                                        title="Delete" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                        <asp:Button ID="btnDeleteCity" runat="server" Text="" CssClass="hide" meta:ResourceKey="btn_DeleteCity"
                                        CommandArgument='<%# Eval("CityID") %>' OnClick="btnDeleteCity_Click"  />
                    <asp:SqlDataSource ID="sds_CityList" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                        SelectCommand="select cityid,
			Cityname,CityImage,
			IsParticipatingCity = (case IsParticipatingCity when 1 then 'yes'
									else 'No' end)
		from  CityMaster
		where IsActive = 1 and CityName LIKE '%'+(CASE @SearchCityName WHEN ' ' THEN Cityname ELSE @SearchCityName END)+'%' and IsParticipatingCity=@IsParticipantCity 
        order by Cityname ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtSearchBox" DefaultValue=" " Name="SearchCityName"
                                PropertyName="Text" />
                            <asp:ControlParameter ControlID="chkIsParticipatingCity" Name="IsParticipantCity"
                                PropertyName="Checked" DefaultValue="" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
            <%--<asp:Button ID="btntest" runat="server" Text="Test" onclick="btntest_Click" />--%>
            <asp:Button ID="btnDelete" runat="server" meta:ResourceKey="btnDelete" CssClass="hide" OnClick="btnDelete_Click"
                Style="display: none;" />
        </div>
    </div>
</asp:content>
