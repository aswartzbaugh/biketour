<%@ page title="BikeTour - Image Link Master" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" culture="de-DE" uiculture="de-DE" autoeventwireup="true" inherits="AppAdmin_ImageLinkMaster, App_Web_ekadcbkj" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../_css/AdminLayout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () { $("[id$=btnDelete]").hide(); });
        function Confirm(obj) {
            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdnDeleteId]").val(obj);
                $("[id$=btnDelete]").trigger("click");
                return true;
            }
            else {
                return false;
            }
        }

    </script>
    <script language="javascript" type="text/javascript">

        function ValidateFileUpload(Source, args) {
            var fuData = document.getElementById('<%= fuImage.ClientID %>');
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="container">
        <h5>
            <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead"></asp:Label></h5>
        <div class="AdminContWrap">
            <asp:Panel ID="pnlAddLink" runat="server" Visible="false" DefaultButton="btnSave">
                <div class="frmBox">
                    <asp:LinkButton ID="lnkAddLink" runat="server" meta:ResourceKey="lnkAddLink" Visible="false"
                        CssClass="linkbtn right" OnClick="lbtnAddLink_Click"></asp:LinkButton>
                    <table cellpadding="0" cellspacing="5">
                        <tr>
                            <td>
                                <asp:Label ID="lblImage" runat="server" meta:ResourceKey="lblImage" CssClass="GlbLbl"></asp:Label>
                            </td>
                            <td>
                                <asp:FileUpload ID="fuImage" runat="server" /><br /><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvImage" runat="server" ControlToValidate="fuImage"
                                    meta:ResourceKey="rfvImage" CssClass="error" Display="Dynamic" ValidationGroup="OnSave"></asp:RequiredFieldValidator><br />
                                <asp:CustomValidator ID="custvImage" runat="server" ControlToValidate="fuImage" ClientValidationFunction="ValidateFileUpload"
                                    meta:ResourceKey="custvImage" CssClass="error" Display="Dynamic" ValidationGroup="OnSave"></asp:CustomValidator>
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
                                <asp:Label ID="lblImageLink" runat="server" meta:ResourceKey="lblImageLink" CssClass="GlbLbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtImageLink" runat="server" MaxLength="1000" Width="200"></asp:TextBox><span class="error">*</span>
                                <asp:TextBoxWatermarkExtender ID="txtImageLinkTxtBoxWtrmarkExt" runat="server" Enabled="True"
                                    TargetControlID="txtImageLink" WatermarkCssClass="WtrmrkCSS" meta:ResourceKey="txtImageLinkTxtBoxWtrmarkExt">
                                </asp:TextBoxWatermarkExtender>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvtxtImageLink" runat="server" Display="Dynamic"
                                    meta:ResourceKey="rfvtxtImageLink" ControlToValidate="txtImageLink" CssClass="error"
                                    ValidationGroup="OnSave"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblImageText" runat="server" meta:ResourceKey="lblImageText" CssClass="GlbLbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtImageText" runat="server"></asp:TextBox><span class="error">*</span>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvtxtImageText" runat="server" Display="Dynamic"
                                    meta:ResourceKey="rfvtxtImageText" ControlToValidate="txtImageLink" CssClass="error"
                                    ValidationGroup="OnSave"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td colspan="2">
                                <asp:Button ID="btnSave" runat="server" meta:ResourceKey="btnSave" ValidationGroup="OnSave"
                                    OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" meta:ResourceKey="btnCancel" OnClick="btnCancel_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlLinkList" runat="server" DefaultButton="btnSearchImage">
                <div class="frmBox">
                    <asp:HiddenField ID="hdnLinkId" runat="server" />
                    <asp:Button ID="btnAddNew" runat="server" meta:ResourceKey="btnAddNew" CssClass="right"
                        OnClick="btnAddNew_Click" />
                    <div class="div_SearchBox">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblImageNameSearch" runat="server" meta:ResourceKey="lblImageNameSearch"
                                        CssClass="GlbLbl"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSearchBox" runat="server" CssClass="Glbtxt"></asp:TextBox>
                                    <%--<asp:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtSearchBox"
                                        MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1" CompletionInterval="100"
                                        ServiceMethod="GetCityNames">
                                    </asp:AutoCompleteExtender>--%>
                                </td>
                            </tr>
                            <%-- <tr>
                                <td>
                                    <asp:Label ID="lblIsParticipatingCity" runat="server" CssClass="GlbLbl left" Text="Is Participating City"></asp:Label>
                                </td>
                                <td style="width: 250px;">
                                    <asp:CheckBox ID="chkIsParticipatingCity" runat="server" Checked="True" TextAlign="Left"
                                        CssClass="checkbox" AutoPostBack="True" />
                                </td>
                            </tr>--%>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btnSearchImage" CssClass="left" runat="server" meta:ResourceKey="btnSearchImage" />
                                    <asp:Button ID="btnSearchCancel" runat="server" meta:ResourceKey="btnSearchCancel"
                                        HeaderStyle-CssClass="gridHeader" OnClick="btnSearchCancel_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="clear">
                </div>
                <div class="GridWrap">
                    <asp:GridView ID="grdImageLink" runat="server" AutoGenerateColumns="False" Width="100%"
                        PageSize="10" DataSourceID="sdsImageLink" AllowPaging="True" PagerStyle-CssClass="width" AllowSorting="True" HeaderStyle-CssClass="gridHeader"
                        OnPageIndexChanging="grdImageLink_PageIndexChanging">
                        <EmptyDataTemplate>
                        <asp:Label ID="lblEmptyData" runat="server" meta:ResourceKey="lblEmptyData"></asp:Label>
                    </EmptyDataTemplate>
                        <Columns>
                            <%--<asp:BoundField DataField="ImageName" HeaderText="ImageName" SortExpression="ImageName" />--%>
                            <%--<asp:ImageField DataImageUrlField="ImageName" HeaderText="Image" DataImageUrlFormatString="../LinkImages/{0}"
                                ControlStyle-Height="50px" ControlStyle-Width="60px" AlternateText="No Image">
                                
                            </asp:ImageField>--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdImageName" runat="server" meta:ResourceKey="lblgrdImageName"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Image ID="imgImageName" runat="server" Height="50px" Width="60px" ImageUrl='<%# "../LinkImages/" + Eval("ImageName")%>'
                                       meta:ResourceKey="imgImageName" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:BoundField DataField="ImageLink" HeaderText="ImageLink" />--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdImagelink" runat="server" meta:ResourceKey="lblgrdImagelink"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblImageLink" runat="server" Text='<%# Eval("ImageLink") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="ImageText" HeaderText="Image Text" />--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdImageText" runat="server" meta:ResourceKey="lblgrdImageText"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblImageText" runat="server" Text='<%# Eval("ImageText") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" CssClass="grdedit" ToolTip="bearbeiten"
                                        CommandArgument='<%#Eval("ImageLinkId") %>' OnClick="btnEdit_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdDelete" runat="server" meta:ResourceKey="lblgrdDelete"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <input id="btDelete" type="button" class="grddel" title="löschen" onclick="Confirm('<%# Eval("ImageLinkId") %>')" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="gridHeader" />
                        <PagerStyle CssClass="width" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsImageLink" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                        SelectCommand="Select ImageLinkId,ImageName,ImageLink,ImageText from ImageLinkMaster where IsActive = 1 and
ImageText like '%' + rtrim(ltrim(@ImageText)) + '%' order by ImageLinkId desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtSearchBox" Name="ImageText" DefaultValue=" "
                                PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
            <%--<asp:Button ID="btntest" runat="server" Text="Test" onclick="btntest_Click" />--%>
            <asp:Button ID="btnDelete" runat="server" meta:ResourceKey="btnDelete" CssClass="hide" Style="display: none;"
                OnClick="btnDelete_Click" />
            <asp:HiddenField ID="hdnImageName" runat="server" />
            <asp:HiddenField ID="hdnDeleteId" runat="server" />
        </div>
    </div>
</asp:Content>
