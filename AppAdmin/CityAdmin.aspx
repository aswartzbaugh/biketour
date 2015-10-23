<%@ Page Culture="de-DE" UICulture="de-DE" Title="Bike Tour - City Admin" Language="C#"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="CityAdmin.aspx.cs"
    Inherits="AppAdmin_CityAdmin" %>

<%@ Register Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () { $("[id$=btnDelete]").hide(); });
        function Confirm(obj) {
            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdn_CityAdminId]").val(obj);
                $("[id$=btnDelete]").trigger("click");
                return true;
            }
            else {
                return false;
            }
        }
    </script>
    <script type="text/javascript">
        function pageLoad() {
            var DropDownCheckBoxes = $find("<%=ddcb_City.ClientID %>");
            DropDownCheckBoxes._element.tabIndex = 3;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div class="container">
        <h5>
            <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
            </asp:Label></h5>
        <div class="AdminContWrap">
            <asp:Panel ID="pnl_AddAdmin" runat="server" Visible="false" DefaultButton="btn_Save">
                <div class="frmBox">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_FirstName" runat="server" TabIndex="1"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txt_FirstName"
                                    ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvFirstName"></asp:RequiredFieldValidator>
                               <%-- <asp:RegularExpressionValidator runat="server" ControlToValidate="txt_FirstName"
                                    ValidationGroup="Submit" ID="regFirstName1" CssClass="error" ValidationExpression="^[a-zA-Z]*$"
                                    Display="Dynamic" meta:ResourceKey="regFirstName1" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_LastName" runat="server" TabIndex="2"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txt_LastName"
                                    ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvLastName"></asp:RequiredFieldValidator>
                                <%--<asp:RegularExpressionValidator runat="server" ControlToValidate="txt_LastName" ValidationGroup="Submit"
                                    ID="Rfv_Lastname" CssClass="error" ValidationExpression="^[a-zA-Z]*$" Display="Dynamic"
                                    meta:ResourceKey="Rfv_Lastname" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCity" runat="server" meta:ResourceKey="lblCity"></asp:Label>
                            </td>
                            <td>
                                <cc1:DropDownCheckBoxes ID="ddcb_City" runat="server" AddJQueryReference="True" CssClass="left"
                                    TabIndex="3" DataSourceID="sds_CityToCheckBoxList" DataTextField="CityName" DataValueField="CityId"
                                    RepeatDirection="Horizontal" UseButtons="False" UseSelectAllNode="True">
                                    <Style SelectBoxWidth="190" DropDownBoxBoxWidth="190" DropDownBoxBoxHeight="120"></Style>
                                </cc1:DropDownCheckBoxes>
                                <span class="error left">*</span>
                                <cc1:ExtendedRequiredFieldValidator ID="rfv_ddcbCity" runat="server" ControlToValidate="ddcb_City"
                                    Display="Dynamic" CssClass="error" ValidationGroup="Submit" ForeColor="Red" meta:ResourceKey="rfv_ddcbCity"></cc1:ExtendedRequiredFieldValidator>
                                <asp:SqlDataSource ID="sds_CityToCheckBoxList" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="SP_GET_CITIES_FORCITYADMIN" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdn_CityAdminId" DefaultValue="0" Name="CITYADMINID"
                                            PropertyName="Value" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <div class="clear">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblAddress" runat="server" meta:ResourceKey="lblAddress"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAddress" runat="server" TabIndex="4"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress"
                                    ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvAddress"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server" TabIndex="5"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                    ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvEmail"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                                    CssClass="error" Display="Dynamic" ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
                                    ValidationGroup="Submit" meta:ResourceKey="rev_Email">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr runat="server" id="tr_password">
                            <td>
                                <asp:Label ID="lblPassword" runat="server" meta:ResourceKey="lblPassword"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" TabIndex="6"></asp:TextBox><span
                                    class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                                    ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvPassword"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr runat="server" id="tr_Conpassword">
                            <td>
                                <asp:Label ID="lblConfirmPassword" runat="server" meta:ResourceKey="lblConfirmPassword"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" TabIndex="7"></asp:TextBox><span
                                    class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                                    ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvConfirmPassword"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmpvalPassword" runat="server" Display="Dynamic" ValidationGroup="Submit"
                                    Type="String" Operator="Equal" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                                    CssClass="error" meta:ResourceKey="cmpvalPassword"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btn_Save" CssClass="Left" runat="server" meta:resourceKey="btn_Save"
                                    TabIndex="8" ValidationGroup="Submit" OnClick="btn_Save_Click" />
                                <asp:Button ID="btn_Cancel" runat="server" meta:resourceKey="btn_Cancel" OnClick="btn_Cancel_Click"
                                    TabIndex="9" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asp:HiddenField ID="hdn_CityAdminId" runat="server" Value="0" />
            <asp:Panel ID="pnl_AdminList" runat="server" DefaultButton="btn_Search">
                <div class="frmBox">
                    <asp:Button ID="btn_AddNew" runat="server" meta:resourceKey="btn_AddNew" OnClick="btn_AddNew_Click"
                        CssClass="right" />
                    <div class="div_SearchBox">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_SearchName" runat="server" meta:ResourceKey="lbl_SearchName" CssClass="GlbLbl"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_SearchName" runat="server" CssClass="Glbtxt"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_SearchCity" runat="server" meta:ResourceKey="lbl_SearchCity" CssClass="GlbLbl"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddl_SearchCity" runat="server" DataSourceID="sds_SearchCities"
                                        DataTextField="CityName" DataValueField="CityId">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="sds_SearchCities" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                        SelectCommand="SELECT [CityId], [CityName] FROM [CityMaster] Where IsActive=1 order by cityname">
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btn_Search" runat="server" meta:ResourceKey="btn_Search" OnClick="btn_Search_Click" />
                                    <asp:Button ID="btn_SearchCancel" runat="server" meta:ResourceKey="btn_SearchCancel"
                                        OnClick="btn_SearchCancel_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="GridWrap">
                    <asp:GridView ID="grd_CityAdminList" runat="server" AutoGenerateColumns="False" DataKeyNames="CityAdminId"
                        AllowPaging="true" DataSourceID="sds_CityAdminList" EmptyDataText="No Records!"
                        Width="100%" AllowSorting="true" HeaderStyle-CssClass="gridHeader" 
                        onrowcommand="grd_CityAdminList_RowCommand" 
                        onrowdatabound="grd_CityAdminList_RowDataBound" 
                        onsorting="grd_CityAdminList_Sorting">
                        <Columns>
                            <%--<asp:BoundField DataField="CityAdminId" HeaderText="CityAdminId" 
                         InsertVisible="False" ReadOnly="True" SortExpression="CityAdminId" />--%>
                            <%-- <asp:TemplateField HeaderText="Name" SortExpression="uName">
                       <ItemTemplate>
                           <asp:Label ID="lbl_Name" runat="server" Text='<%# Bind("uName") %>' ToolTip="Name"></asp:Label>
                       </ItemTemplate>
                       </asp:TemplateField> --%>
                            <%--<asp:BoundField DataField="uName" HeaderText="Name" ReadOnly="True"   SortExpression="uName"  />--%>
                            <asp:TemplateField HeaderText="Name">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrduName" runat="server" meta:ResourceKey="lblgrduName"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrduName" runat="server" meta:ResourceKey="lbtngrduName" CommandName="sort" CommandArgument="uName"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrduName" runat="server"> </asp:PlaceHolder> 
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbluName" runat="server" Text='<%# Bind("uName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />--%>
                            <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrdEmail" runat="server" meta:ResourceKey="lblgrdEmail"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdEmail" runat="server" meta:ResourceKey="lbtngrdEmail" CommandName="sort" CommandArgument="Email"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdEmail" runat="server"> </asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Password">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrdEmail" runat="server" meta:ResourceKey="lblgrdEmail"></asp:Label>--%>
                                    <asp:Label ID="lblPassword" runat="server" Text="Password" ></asp:Label>
                                    
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblShowPassword" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>







                            <%--<asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />--%>
                            <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrdAddress" runat="server" meta:ResourceKey="lblgrdAddress"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdAddress" runat="server" meta:ResourceKey="lbtngrdAddress" CommandName="sort" CommandArgument="Address"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdAddress" runat="server"> </asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="Cities" HeaderText="Cities" ReadOnly="True" SortExpression="Cities" />--%>
                            <asp:TemplateField HeaderText="Cities" SortExpression="Cities">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrdCities" runat="server" meta:ResourceKey="lblgrdCities"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdCities" runat="server" meta:ResourceKey="lbtngrdCities" CommandName="sort" CommandArgument="Cities"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdCities" runat="server"> </asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCities" runat="server" Text='<%# Eval("Cities") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="50px">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="btn_Edit" runat="server" Text="" CssClass="grdedit" ToolTip="bearbeiten"
                                        CommandArgument='<%# Eval("CityAdminId") %>' OnClick="btnEdit_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <asp:SqlDataSource ID="sds_CityAdminList" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                    SelectCommand="SP_GET_ALLCITY_ADMINS" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txt_SearchName" DefaultValue=" " Name="AdminName"
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="ddl_SearchCity" DefaultValue="0" Name="CityId" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="hide" OnClick="btnDelete_Click"
                Style="display: none;" />
        </div>
    </div>
</asp:Content>
