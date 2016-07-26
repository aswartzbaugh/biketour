<%@ page title="BikeTour - City Content" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="AppAdmin_AddCityContent, App_Web_1d3e1omr" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../UserControl/GoogleMapForASPNet.ascx" TagName="GoogleMapForASPNet"
    TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <div class="container">
         <h5 id="h1_ClassForum" runat="server">
         <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
         </asp:Label></h5>
    <div class="AdminContWrap">
        <asp:HiddenField ID="hdnCityId" runat="server" />
        <div class="CityName">
            <center><asp:Label ID="lblCityName" runat="server" Font-Size="XX-Large"></asp:Label></center>
        </div>

        <div class="frmBox">
            <table width="100%">
                        <tr>
                            <td>
                                <asp:FileUpload ID="fuPictureUpload" runat="server" />
                                <asp:Button ID="btnUploadPicture" runat="server" meta:ResourceKey="btnUploadPicture"
                                    OnClick="btnUploadPicture_Click"  ValidationGroup="Upload"  />
                                
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RequiredFieldValidator ID="rfv" runat="server" ValidationGroup="Upload" 
                                    ControlToValidate="fuPictureUpload" CssClass="error" Display="Dynamic" 
                                     meta:ResourceKey="rfv"></asp:RequiredFieldValidator>
                                <asp:DataList ID="dlPictures" runat="server" RepeatDirection="Horizontal" DataKeyField="" RepeatColumns="4">
                                    <ItemTemplate>
                                    <div class="galeryimg">
                                     <asp:Button ID="btnDelete" runat="server" meta:ResourceKey="btnDelete" CssClass="grddel Right"
                                                        OnClick="btnDelete_Click" CommandArgument='<%#Eval("ImageName") + "," + Eval("ImagePath") %>' />
                                        <table>
                                            <tr>
                                                <td>
                                               
                                                    <asp:Image ID="imgCity" runat="server" ImageUrl='<%# GetImageURL(Eval("ImageName").ToString(),Eval("CityId").ToString()) %>' Height="120"
                                                        Width="175" />
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hdnImageName" runat="server" Value='<%#Eval("ImageName") %>' />
                                                    <asp:HiddenField ID="hdnImagePath" runat="server" Value='<%#Eval("ImagePath") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtImageInfo" runat="server" MaxLength="100" Text='<%# Eval("ImageText") %>'></asp:TextBox>
                                                    <asp:TextBoxWatermarkExtender ID="txtImageInfo_TextBoxWatermarkExtender" runat="server"
                                                        Enabled="True" meta:ResourceKey="txtImageInfo_TextBoxWatermarkExtender" WatermarkCssClass="WtrmrkCSS" TargetControlID="txtImageInfo">
                                                    </asp:TextBoxWatermarkExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                        </div>
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                        </tr>
                    </table>
            <br />
        </div>

        <div class="frmBox">
        <div class="upload">
            <asp:TextBox ID="txtCityInfo" runat="server" TextMode="MultiLine" Wrap="true" Width="100%"></asp:TextBox>
            <asp:TextBoxWatermarkExtender ID="txtCityInfo_TextBoxWatermarkExtender" runat="server"
                Enabled="True" TargetControlID="txtCityInfo" meta:ResourceKey="txtCityInfo_TextBoxWatermarkExtender"
                WatermarkCssClass="WtrmrkCSS">
            </asp:TextBoxWatermarkExtender>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" 
                 ControlToValidate="txtCityInfo" ValidationGroup="Save" CssClass="error" meta:ResourceKey="RequiredFieldValidator11"></asp:RequiredFieldValidator>
            
        </div>
        <div >
            <table border="0" cellpadding="0" cellspacing="0" width="65%">
                <tr>
                    <td>
                     <asp:TextBox ID="txtVideoUrl" runat="server" MaxLength="200" Width="500"></asp:TextBox>
                        <asp:TextBoxWatermarkExtender ID="txtVideoUrl_TextBoxWatermarkExtender" runat="server"
                            Enabled="True" TargetControlID="txtVideoUrl" WatermarkCssClass="WtrmrkCSS" meta:ResourceKey="txtVideoUrl_TextBoxWatermarkExtender">
                        </asp:TextBoxWatermarkExtender>
                       
                    </td>
                    <td>
                    <asp:Button ID="btnVideoUpload" runat="server" meta:ResourceKey="btnVideoUpload"
                            OnClick="btnVideoUpload_Click" ValidationGroup="Video" />
                    </td>
                </tr>
                <tr>
                <td>
                 <asp:RequiredFieldValidator ID="rfvVideo" runat="server"
                            ControlToValidate="txtVideoUrl" ValidationGroup="Video" CssClass="error" meta:ResourceKey="rfvVideo"></asp:RequiredFieldValidator>
                </td>
                <td></td>
                </tr>
            </table>
        
                      
                        
        
        </div>
        </div>

        <div class="CityMoreInfo">
            <table width="100%">
                <tr>
                    <td  width="50%" >
                        <div id="div_Video" runat="server" visible="false">
                            <iframe runat="server" id="ifrm" src="" frameborder="0" width="100%" height="300">
                            </iframe>
                        </div>
                    </td>
                    <td width="50%">
                        <div id="div_Map" runat="server" visible="false">
                        <uc1:GoogleMapForASPNet ID="GoogleMapForASPNet1" runat="server" />
                        </div>
                    </td>
                </tr>
            </table>
            <br />
        </div>

        <div class="btnList">
            <%--<asp:Button ID="btnSave" runat="server" meta:ResourceKey="btnSave" OnClientClick="javascript:return confirm('Are you sure you want to save details ?');" OnClick="btnSave_Click" />--%>
                <asp:Button ID="Button1" runat="server" meta:ResourceKey="btnSave" OnClick="btnSave_Click"  ValidationGroup="Save" />
                <asp:Button ID="btnBack" runat="server" meta:ResourceKey="btnBack" OnClick="btnBack_Click" />
                <asp:Button ID="btnDelete" runat="server" meta:ResourceKey="btnDelete" onclick="btnDelete_Click1" Visible="false" />


        </div>
        
        
    </div>

    </div>
</asp:Content>
