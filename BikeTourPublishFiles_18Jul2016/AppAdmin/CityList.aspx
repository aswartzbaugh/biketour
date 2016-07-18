<%@ page title="Bike Tour - City List" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="AppAdmin_CityList, App_Web_x1fc3qah" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="container">
        <h5>
            <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
            </asp:Label></h5>
        <div class="AdminContWrap">
            <div class="frmBox">
                <div class="div_SearchBox">
                    <table border="0">
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
                            <td colspan="2">
                                <asp:UpdatePanel ID="Up_button" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="txtSearchCity" runat="server" meta:ResourceKey="txtSearchCity" OnClick="txtSearchCity_Click" />
                                        <asp:Button ID="btn_SearchCancel" runat="server" meta:ResourceKey="btn_SearchCancel"
                                            OnClick="btn_SearchCancel_Click" />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="txtSearchCity" />
                                        <asp:PostBackTrigger ControlID="btn_SearchCancel" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="GridWrap">
                <%-- <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>--%>
                <%--<asp:TextBox ID="txtSearchBox" runat="server"></asp:TextBox>
            <asp:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtSearchBox"
                MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1" CompletionInterval="100"
                ServiceMethod="GetCityNames">
            </asp:AutoCompleteExtender>
            
            <asp:Button ID="txtSearchCity" runat="server" Text="Search City" OnClick="txtSearchCity_Click" />--%>
                <asp:UpdatePanel ID="Up_grdCityList" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="grdCityList" runat="server" AutoGenerateColumns="False" DataKeyNames="CityId"
                             AllowPaging="True" Width="100%" AllowSorting="true"
                            HeaderStyle-CssClass="gridHeader" EmptyDataText="No Record" 
                            onrowcommand="grdCityList_RowCommand" onrowdatabound="grdCityList_RowDataBound" 
                            onsorting="grdCityList_Sorting" 
                            onpageindexchanging="grdCityList_PageIndexChanging">
                            <Columns>
                                <%--<asp:BoundField DataField="CityName" HeaderText="CityName" 
                SortExpression="CityName" />--%>
                                <asp:TemplateField HeaderText="City Name" SortExpression="CityName">
                                    <HeaderTemplate>
                                        <%--<asp:Label ID="lblgrdCityName" runat="server" meta:ResourceKey="lblgrdCityName"></asp:Label>--%>
                                        <asp:LinkButton ID="lbtngrdCityName" runat="server" meta:ResourceKey="lbtngrdCityName" CommandName="sort" CommandArgument="CityName"></asp:LinkButton>
                                        <asp:PlaceHolder id="phtgrdCityName" runat="server"> </asp:PlaceHolder>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblCityName" runat="server" Text='<%# Eval("CityName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Content">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblgrdContent" runat="server" meta:ResourceKey="lblgrdContent"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hlContent" runat="server" ToolTip="Add Details" CssClass="addDetails"
                                            NavigateUrl='<%# String.Format("~/AppAdmin/AddCityContent.aspx?cityid={0}&cityname={1}", Eval("CityId"), Eval("CityName")) %>'
                                            Visible='<%# bool.Parse(Eval("IsAddVisible").ToString()) %>'></asp:HyperLink>
                                        <asp:HyperLink ID="hlEditContent" runat="server" ToolTip="Edit Details" CssClass="editDetails"
                                            NavigateUrl='<%# String.Format("~/AppAdmin/AddCityContent.aspx?cityid={0}&cityname={1}", Eval("CityId"), Eval("CityName")) %>'
                                            Visible='<%# bool.Parse(Eval("IsEditVisible").ToString()) %>'></asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsCityList" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                            SelectCommand="SP_GET_CITYLIST" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtSearchBox" DefaultValue=" " Name="CityName" PropertyName="Text"
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
