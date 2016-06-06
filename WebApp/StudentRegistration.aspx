<%@ Page Title="Bike Tour - Student Registration" Culture="de-DE" UICulture="de-DE"
    Language="C#" MasterPageFile="~/SiteMaster/UserMaster.master" AutoEventWireup="true"
    CodeFile="StudentRegistration.aspx.cs" Inherits="StudentRegistration" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="_js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="_js/jquery.corner.js" type="text/javascript"></script>
    <script src="_js/customJs.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager" EnablePageMethods="true" runat="server">
    </asp:ScriptManager>
    <h5>
        <asp:Label ID="lblRegistration" runat="server" meta:ResourceKey="lblRegistration"></asp:Label>
    </h5>
    <div class="AdminContWrap">
        <asp:HiddenField ID="hdnStudentId" runat="server" />
        <asp:Panel ID="pnlAddNew" runat="server">
            <div class="frmBox">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox><span class="error">*</span>
                            <%--<asp:FilteredTextBoxExtender ID="txtFirstName_FilteredTextBoxExtender" 
                                runat="server" Enabled="True" FilterType="UppercaseLetters, LowercaseLetters" 
                                TargetControlID="txtFirstName">
                            </asp:FilteredTextBoxExtender>--%>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" meta:ResourceKey="rfvFirstName"
                                ControlToValidate="txtFirstName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <%--<asp:RegularExpressionValidator ID="revFirstName" runat="server" ControlToValidate="txtFirstName"
                                ErrorMessage="Please Enter Valid First Name" CssClass="error" Display="Dynamic"
                                ValidationExpression="^[a-zA-Z'.\s]{1,40}$" ValidationGroup="Submit"
                                ForeColor="#FF3300">
                            </asp:RegularExpressionValidator>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox><span class="error">*</span>
                            <%--<asp:FilteredTextBoxExtender ID="txtLastName_FilteredTextBoxExtender" 
                                runat="server" Enabled="True" FilterType="UppercaseLetters, LowercaseLetters" 
                                TargetControlID="txtLastName">
                            </asp:FilteredTextBoxExtender>--%>
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" meta:ResourceKey="rfvLastName"
                                ControlToValidate="txtLastName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <%--<asp:RegularExpressionValidator ID="revLastName" runat="server" ControlToValidate="txtLastName"
                                ErrorMessage="Please Enter Valid Last Name" CssClass="error" Display="Dynamic"
                                ValidationExpression="^[a-zA-Z'.\s]{1,40}$" ValidationGroup="Submit"
                                ForeColor="#FF3300">
                            </asp:RegularExpressionValidator>--%>
                        </td>
                    </tr>
                    <%--<tr>
                    <td>
                        <asp:Label ID="lblAddress" runat="server" Text="Address :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Please enter Address"
                            ControlToValidate="txtAddress" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    </td>
                </tr>--%>
                    <tr>
                        <td>
                            <asp:Label ID="lblUsername" runat="server" meta:ResourceKey="lblUsername" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtUsername" runat="server" CssClass="gltxt" OnTextChanged="txtUsername_TextChanged" AutoPostBack="true"></asp:TextBox>
                                    <span class="error">*</span>
                                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                                        meta:ResourceKey="rfvUsername" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:Label runat="server" ID="lblDuplicateUsername" meta:ResourceKey="lblDuplicateUsername" CssClass="error"
                                        Visible="false"></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSelectCity" runat="server" meta:ResourceKey="lblSelectCity"></asp:Label>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="Up_ddlCity" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlCity" runat="server" DataSourceID="sdsCity" DataTextField="CityName"
                                        DataValueField="CityId" AutoPostBack="true">
                                    </asp:DropDownList>
                                    <span class="error">*</span>
                                    <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                        SelectCommand="SELECT [CityId], [Cityname] FROM [CityMaster] WHERE ([IsActive] = 1) and IsParticipatingCity=1 order by Cityname Asc  ">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="true" Name="IsActive" Type="Boolean" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" meta:ResourceKey="rfvCity"
                                        Display="Dynamic" ControlToValidate="ddlCity" InitialValue="0" ValidationGroup="Submit"
                                        CssClass="error"></asp:RequiredFieldValidator>
                                </ContentTemplate>
                                <%--  <Triggers>
                                <asp:PostBackTrigger ControlID="ddlCity" />
                                </Triggers>--%>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="upSchool" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                        DataValueField="SchoolId" AutoPostBack="true">
                                    </asp:DropDownList>
                                    <span class="error">*</span>
                                    <asp:RequiredFieldValidator ID="rfvSchool" runat="server" meta:ResourceKey="rfvSchool"
                                        Display="Dynamic" ControlToValidate="ddlSchool" InitialValue="0" ValidationGroup="Submit"
                                        CssClass="error"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                        SelectCommand="SELECT '0' as [SchoolId], 'Schule' as [School] union all SELECT [SchoolId], [School] FROM [SchoolMaster] 
                            WHERE ([IsActive] = @IsActive and cityid=@cityid) order by SchoolId">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="true" Name="IsActive" Type="Boolean" />
                                            <asp:ControlParameter ControlID="ddlCity" DefaultValue="" Name="cityid" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSelectClass" runat="server" meta:ResourceKey="lblSelectClass"></asp:Label>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="upClass" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlClass" runat="server" DataSourceID="sdsClass" DataTextField="Class"
                                        DataValueField="ClassId">
                                    </asp:DropDownList>
                                    <span class="error">*</span>
                                    <asp:SqlDataSource ID="sdsClass" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                        SelectCommand="SELECT '0' as [ClassId], 'Klasse' as [Class] union all SELECT [ClassId], [Class] 
                            FROM [SchoolClassMaster] WHERE ([IsActive] = @IsActive and schoolid = @schoolid) order by ClassId">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="true" Name="IsActive" Type="Boolean" />
                                            <asp:ControlParameter ControlID="ddlSchool" DefaultValue="" Name="schoolid" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="rfvClass" runat="server" meta:ResourceKey="rfvClass"
                                        Display="Dynamic" ControlToValidate="ddlClass" InitialValue="0" ValidationGroup="Submit"
                                        CssClass="error"></asp:RequiredFieldValidator>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr id="tremail" runat="server" Visible="false">
                        <td>
                            <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox><%--<span class="error">*</span>--%>
                            <%--<asp:RequiredFieldValidator ID="rfvEmail" runat="server" meta:ResourceKey="rfvEmail"
                                Enabled="false" ControlToValidate="txtEmail" ValidationGroup="Submit" CssClass="error"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                                meta:ResourceKey="rev_Email" CssClass="error" Display="Dynamic" ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
                                ValidationGroup="Submit" ForeColor="#FF3300">
                            </asp:RegularExpressionValidator>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPassword" runat="server" meta:ResourceKey="lblPassword"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox><span
                                class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" meta:ResourceKey="rfvPassword"
                                ControlToValidate="txtPassword" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblConfirmPassword" runat="server" meta:ResourceKey="lblConfirmPassword"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox><span
                                class="error">*</span>
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
                            <asp:UpdatePanel ID="Up_btn" runat="server">
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
        <asp:Panel ID="pnlMessage" runat="server" Visible="false">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblMessage" runat="server" meta:ResourceKey="lblMessage"></asp:Label>
                    </td>
                    <td>
                        <a href="Login.aspx">
                            <asp:Label ID="lblLoginDisplay" runat="server" meta:ResourceKey="lblLoginDisplay"></asp:Label></a>
                    </td>
                    <td>
                        <asp:Label ID="lblToContinue" runat="server" meta:ResourceKey="lblToContinue"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
</asp:Content>
