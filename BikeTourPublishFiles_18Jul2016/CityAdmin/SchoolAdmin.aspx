<%@ page title="BikeTour - City Admin :: School Admin" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="CityAdmin_SchoolAdmin, App_Web_g31xiaah" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () { $("[id$=btnDeletPro]").hide(); });
        function Confirm(obj) {

            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdnSchoolAdminId]").val(obj);
                $("[id$=btnDelete]").trigger("click");
                return true;
            }
            else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:HiddenField ID="hdnSchoolAdminId" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnDelete" runat="server" Text="" OnClick="btnDelete_Click" CssClass="hide" />
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnDelete" />
        </Triggers>
    </asp:UpdatePanel>
    <div class="container">
        <h5>
            <asp:Label ID="lblHeader" runat="server" meta:ResourceKey="lblHeader"></asp:Label></h5>
        <div class="AdminContWrap">
            <asp:Panel ID="pnlAddNew" runat="server">
                <div class="frmBox">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                            DataValueField="SchoolId">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvSchool" runat="server" meta:ResourceKey="rfvSchool"
                                            Display="Dynamic" ControlToValidate="ddlSchool" InitialValue="0" ValidationGroup="Submit"
                                            CssClass="error"></asp:RequiredFieldValidator>
                                        <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                            SelectCommand="SELECT '0' as [SchoolId], 'Select school' as [School] union all SELECT [SchoolId], [School] FROM [SchoolMaster] WHERE ([IsActive] = @IsActive) and CityId=(select CityId from CityAdminMaster where CityAdminId = @CityAdminId)">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="true" Name="IsActive" Type="Boolean" />
                                                <asp:SessionParameter DefaultValue="1" Name="CityAdminId" SessionField="UserId" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="ddlSchool" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" meta:ResourceKey="rfvFirstName"
                                    ControlToValidate="txtFirstName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" meta:ResourceKey="rfvLastName"
                                    ControlToValidate="txtLastName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblAddress" runat="server" meta:ResourceKey="lblAddress"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" meta:ResourceKey="rfvAddress"
                                    ControlToValidate="txtAddress" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" meta:ResourceKey="rfvEmail"
                                    ControlToValidate="txtEmail" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                                    meta:ResourceKey="rev_Email" CssClass="error" Display="Dynamic" ValidationExpression="\^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
                                    ValidationGroup="Submit" ForeColor="#FF3300">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr runat="server" id="tr_password">
                            <td>
                                <asp:Label ID="lblPassword" runat="server" meta:ResourceKey="lblPassword"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" meta:ResourceKey="rfvPassword" 
                                    ControlToValidate="txtPassword" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr runat="server" id="tr_conpassword">
                            <td>
                                <asp:Label ID="lblConfirmPassword" runat="server" meta:ResourceKey="lblConfirmPassword"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" meta:ResourceKey="rfvConfirmPassword" 
                                 
                                    ControlToValidate="txtConfirmPassword" ValidationGroup="Submit" CssClass="error"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmpvalPassword" runat="server" meta:ResourceKey="cmpvalPassword"
                                    Display="Dynamic" ValidationGroup="Submit" Type="String" Operator="Equal" ControlToCompare="txtPassword"
                                    ControlToValidate="txtConfirmPassword" CssClass="error"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnSave" runat="server" meta:ResourceKey="btnSave" OnClick="btnSave_Click"
                                            ValidationGroup="Submit" />
                                        <asp:Button ID="btnCancel" runat="server" meta:ResourceKey="btnCancel" OnClick="btnCancel_Click" />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="btnSave" />
                                        <asp:PostBackTrigger ControlID="btnCancel" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlGrid" runat="server">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnAddNew" runat="server" meta:ResourceKey="btnAddNew" CssClass="right"
                            OnClick="btnAddNew_Click" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnAddNew" />
                    </Triggers>
                </asp:UpdatePanel>
                <div class="clear">
                </div>
                <div class="GridWrap">
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="grdSchoolAdmin" Width="100%" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="SchoolAdminId,SchoolId" AllowSorting="true"
                                HeaderStyle-CssClass="gridHeader" AllowPaging="True" OnPageIndexChanging="grdSchoolAdmin_PageIndexChanging"
                                OnSelectedIndexChanging="grdSchoolAdmin_SelectedIndexChanging" 
                                onrowcommand="grdSchoolAdmin_RowCommand" 
                                onrowdatabound="grdSchoolAdmin_RowDataBound">
                                <Columns>
                                    <%--<asp:BoundField DataField="School" HeaderText="School" SortExpression="School" />--%>
                                    <asp:TemplateField HeaderText="School" SortExpression="School">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="grdlnkSchool" runat="server" meta:ResourceKey="grdlnkSchool" CommandName="Sort" CommandArgument="School"></asp:LinkButton>
                                            <asp:PlaceHolder ID = "placeholderSchool" runat="server"></asp:PlaceHolder>
                                            <%--<asp:Label ID="lblgrdSchool" runat="server" meta:ResourceKey="lblgrdSchool"></asp:Label>--%>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSchoolgrd" runat="server" Text='<%# Eval("School") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />--%>
                                    <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblgrdFirstName" runat="server" meta:ResourceKey="lblgrdFirstName"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblFirstNamegrd" runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />--%>
                                    <asp:TemplateField HeaderText="LastName" SortExpression="LastName">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblgrdLastName" runat="server" meta:ResourceKey="lblgrdLastName"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblLastNamegrd" runat="server" Text='<%# Eval("LastName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />--%>
                                    <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblgrdAddress" runat="server" meta:ResourceKey="lblgrdAddress"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblAddressgrd" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />--%>
                                    <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblgrdEmail" runat="server" meta:ResourceKey="lblgrdEmail"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmailgrd" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# Eval("SchoolAdminId") %>'
                                                CssClass="grdedit" OnClick="btnEdit_Click" ToolTip="Edit" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblgrdDelete" runat="server" meta:ResourceKey="lblgrdDelete"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <input type="button" id="but1" class="grddel" onclick="Confirm('<%# Eval("SchoolAdminId") %>')"
                                                title="" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SP_GET_SCHOOLADMIN" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="0" Name="SchoolAdminId" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
