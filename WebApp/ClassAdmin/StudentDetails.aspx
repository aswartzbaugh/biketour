<%@ Page Title="Student Details" Culture="de-DE" UICulture="de-DE" Language="C#"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="StudentDetails.aspx.cs"
    Inherits="ClassAdmin_StudentDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
       <script type="text/javascript">
          // $(document).ready(function () { $("[id$=btnDeleteStudent]").hide(); });
           function Confirm(obj) {
               var Ok = confirm('Wollen Sie löschen?');
               if (Ok) {
                   $("[id$=hdnDeleteId]").val(obj);
                   $("[id$=btnDeleteStudent]").trigger("click");
                   return true;
               }
               else {
                   return false;
               }
           }

           function successDelete()
           {
               alert('Deleted Successfully!');
           }

           function ConfirmAll(message) {

               var Ok = confirm(message);
               if (Ok) {
                   $("[id$=btnDeleteSelectedFiles]").trigger("click");
                   return true;
               }
               else {
                   return false;
               }
           }

           function successFileDelete(message) {
               alert(message);
           }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div class="container">
        <h5>
            <asp:Label ID="lblStudentDetails" runat="server" meta:ResourceKey="lblStudentDetails"></asp:Label>
        </h5>
        <asp:Button ID="btnDeleteFile" runat="server" meta:ResourceKey="btnDeleteFile" 
                                CssClass="linkbtn right" ValidationGroup="Submit" onclick="btnDeleteFile_Click" />

        <asp:HyperLink ID="hlnkBack" runat="server" CssClass="linkbtn right" NavigateUrl="ParticipantList.aspx"
            meta:ResourceKey="hlnkBack"></asp:HyperLink>

            <asp:Button ID="btnDeleteSelectedFiles"  AutoPostBack="True" runat="server" 
                                onclick="btnDeleteSelectedFiles_Click"  CssClass="hide" Style="display: none;"  />
        <div class="clear">
        </div>
        <div class="GridWrap">
            <asp:GridView ID="grdStudentDetails" runat="server" Width="100%" AllowPaging="True"
                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="StudentId"
                HeaderStyle-CssClass="gridHeader" CssClass="gv"
                OnRowCommand="grdStudentDetails_RowCommand"
                OnRowDataBound="grdStudentDetails_RowDataBound"
                OnSorting="grdStudentDetails_Sorting"
                OnSelectedIndexChanging="grdStudentDetails_SelectedIndexChanging"
                OnPageIndexChanging="grdStudentDetails_PageIndexChanging">
                <Columns>
                    <asp:TemplateField SortExpression="NAME">
                        <HeaderTemplate>
                            <asp:LinkButton ID="lblgrdName" runat="server" meta:ResourceKey="lblgrdName" CommandName="Sort"
                                CommandArgument="NAME"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderNAME" runat="server"></asp:PlaceHolder>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblName" runat="server" Text='<%#Eval("NAME") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="NAME" HeaderText="NAME" ReadOnly="True" 
                  SortExpression="NAME" />--%>
                    <asp:TemplateField SortExpression="FileName">
                        <HeaderTemplate>
                            <asp:LinkButton ID="lblgrdFileName" runat="server" meta:ResourceKey="lblgrdFileName"
                                CommandName="Sort" CommandArgument="FileName"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderFileName" runat="server"></asp:PlaceHolder>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblFileName" runat="server" Text='<%#Eval("FileName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:BoundField DataField="FileName" HeaderText="Uploaded File" 
                  SortExpression="FileName" />--%>
                    <asp:TemplateField SortExpression="Kilometer">
                        <HeaderTemplate>
                            <asp:LinkButton ID="lblgrdKilometer" runat="server" meta:ResourceKey="lblgrdKilometer"
                                CommandName="Sort" CommandArgument="Kilometer"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderKilometer" runat="server"></asp:PlaceHolder>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblKilometer" runat="server" Text='<%#Eval("Kilometer") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:BoundField DataField="Kilometer" HeaderText="Kilometer" 
                  SortExpression="Kilometer" />--%>
                    <asp:TemplateField SortExpression="Time">
                        <HeaderTemplate>
                            <asp:LinkButton ID="lblgrdTime" runat="server" meta:ResourceKey="lblgrdTime" CommandName="Sort"
                                CommandArgument="Time"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderTime" runat="server"></asp:PlaceHolder>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblTime" runat="server" Text='<%#Eval("Time") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" />--%>
                    <asp:TemplateField HeaderText="Valid">
                        <HeaderTemplate>
                            <asp:Label ID="lblgrdInValid" runat="server" meta:ResourceKey="lblgrdInValid"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Image ID="imgYes" runat="server" CssClass="grdInValid" Visible='<%# bool.Parse(Eval("IsYesVisible").ToString()) %>' />
                            <asp:Image ID="imgNo" runat="server" CssClass="grdValid" Visible='<%# bool.Parse(Eval("IsNoVisible").ToString()) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblDeleteStudent" runat="server" meta:ResourceKey="lblDeleteStudent"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                             <input id="btDelete" type="button" class="grddel" title="löschen" onclick="Confirm('<%# Eval("StudentUploadId") %>    ')" />                        
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delete">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdDelete" runat="server" meta:ResourceKey="lblgrdDelete"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_Delete" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>                        
                </Columns>
            </asp:GridView>
            <div class="clear"></div>

                <asp:Button ID="btnDeleteStudent" runat="server" Text="" ToolTip="löschen" CssClass="hide"
                                OnClick="btnDeleteStudent_Click" CommandArgument='<%# Eval("StudentUploadId") %>' />
        </div>
        <div>
            <br />
            <h3>
                <asp:Label ID="lblUpdateStud" runat="server" meta:ResourceKey="lblUpdateStud"></asp:Label>
            </h3>
            <asp:Panel ID="pnl_MyProfile" runat="server">
                <table border="0" cellpadding="0" cellspacing="5">
                    <tr>
                        <td>
                            <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_FirstName" runat="server" CssClass="gltxt"></asp:TextBox>
                            <asp:FilteredTextBoxExtender ID="txt_FirstName_FilteredTextBoxExtender"
                                runat="server" Enabled="True" FilterType="UppercaseLetters, LowercaseLetters"
                                TargetControlID="txt_FirstName">
                            </asp:FilteredTextBoxExtender>
                            <span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" meta:ResourceKey="rfvFirstName"
                                ControlToValidate="txt_FirstName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revFirstName" runat="server" ControlToValidate="txt_FirstName"
                                meta:ResourceKey="revFirstName" CssClass="error" Display="Dynamic"
                                ValidationExpression="^[a-zA-Z'.\s]{1,40}$" ValidationGroup="Submit"
                                ForeColor="#FF3300">
                            </asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_LastName" runat="server" CssClass="gltxt"></asp:TextBox>
                            <asp:FilteredTextBoxExtender ID="txt_LastName_FilteredTextBoxExtender"
                                runat="server" Enabled="True" FilterType="UppercaseLetters, LowercaseLetters"
                                TargetControlID="txt_LastName">
                            </asp:FilteredTextBoxExtender>
                            <span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                                ControlToValidate="txt_LastName" meta:ResourceKey="rfvLastName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revLastName" runat="server" ControlToValidate="txt_LastName"
                                meta:ResourceKey="revLastName" CssClass="error" Display="Dynamic"
                                ValidationExpression="^[a-zA-Z'.\s]{1,40}$" ValidationGroup="Submit"
                                ForeColor="#FF3300">
                            </asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblUsername" runat="server" meta:ResourceKey="lblUsername" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtUsername" runat="server" CssClass="gltxt" AutoPostBack="true"
                                        OnTextChanged="txtUsername_TextChanged"></asp:TextBox>
                                    <span class="error">*</span>
                                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                                        ControlToValidate="txtUsername" meta:ResourceKey="rfvUsername" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:Label runat="server" ID="lblDuplicateUsername" meta:ResourceKey="lblDuplicateUsername" CssClass="error"
                                        Visible="false"></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                     <tr>
                        <td><asp:Label ID="lblPassword" runat="server" meta:ResourceKey="lblPassword" CssClass="Glblbl"></asp:Label>
                           </td>
                        <td>
                        
                           <asp:TextBox ID="txtPassword" runat="server" CssClass="gltxt" AutoPostBack="true" 
                                       ></asp:TextBox>
                            <span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                                ControlToValidate="txtPassword" meta:ResourceKey="rfvPassword" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCity" runat="server" meta:ResourceKey="lblCity" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="gltxt" Enabled="false"></asp:TextBox><span class="error"></span>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                                ControlToValidate="txtCity" meta:ResourceKey="rfvCity" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSchool" runat="server" CssClass="gltxt" Enabled="false"></asp:TextBox><span class="error"></span>
                            <asp:RequiredFieldValidator ID="rfvSchool" runat="server"
                                ControlToValidate="txtSchool" meta:ResourceKey="rfvSchool" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtClass" runat="server" CssClass="gltxt" Enabled="False"></asp:TextBox><span class="error"></span>
                            <asp:RequiredFieldValidator ID="rfvClass" runat="server"
                                ControlToValidate="txtClass" meta:ResourceKey="rfvClass" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail" CssClass="Glblbl" Visible="false"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="gltxt" Visible="false"></asp:TextBox><%--<span class="error" >*</span>--%>

                            <%-- Waseem:: Commented as per the requirement in Dec. 2015--%>
                            <%--                               <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                ControlToValidate="txtEmail" meta:ResourceKey="rfvEmail" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                                CssClass="error" Display="Dynamic" meta:ResourceKey="rev_Email"
                                ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$" ValidationGroup="Submit">
                            </asp:RegularExpressionValidator>--%>
                        </td>
                    </tr>

                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save"
                                CssClass="glbtn" ValidationGroup="Submit" OnClick="btn_Save_Click" />

                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <asp:HiddenField ID="hdn_MyProfileId" runat="server" />
               <asp:HiddenField ID="hdnDeleteId" runat="server" />
            <asp:HiddenField ID="hdn_ClassID" runat="server" />
            <asp:HiddenField ID="hdn_SchoolID" runat="server" />
            <asp:HiddenField ID="hdn_CityID" runat="server" />

            <asp:Panel ID="pnl_AdminList" runat="server">
            </asp:Panel>
        </div>
    </div>
</asp:Content>
