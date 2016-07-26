<%@ page title="Bike Tour - Student Profile" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="Student_MyProfile, App_Web_ydinyeuu" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script type="text/javascript">
     $(document).ready(function () { $("[id$=btnDelete]").hide(); });
     function Confirm(obj) {
         var Ok = confirm('Wollen Sie löschen?');
         if (Ok) {
             $("[id$=hdn_ClassAdminId]").val(obj);
             $("[id$=btnDelete]").trigger("click");
             return true;
         }
         else {
             return false;
         }
     }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
           <h5>
            <asp:Label ID="lblMyProfile" runat="server" meta:ResourceKey="lblMyProfile"></asp:Label>
           </h5>
            <div class="AdminContWrap">
            <div class="frmBox">
            <asp:Panel ID="pnl_MyProfile" runat="server" Visible="false">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_FirstName" runat="server" CssClass="gltxt" ></asp:TextBox>
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
                            <asp:TextBox ID="txt_LastName" runat="server" CssClass="gltxt" ></asp:TextBox>
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
                                ControlToValidate="txtSchool"  meta:ResourceKey="rfvSchool"  ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtClass" runat="server" CssClass="gltxt" Enabled="False" ></asp:TextBox><span class="error"></span>
                            <asp:RequiredFieldValidator ID="rfvClass" runat="server"
                                ControlToValidate="txtClass" meta:ResourceKey="rfvClass" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="gltxt" ></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                ControlToValidate="txtEmail" meta:ResourceKey="rfvEmail" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                                CssClass="error" Display="Dynamic" meta:ResourceKey="rev_Email"
                                ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$" ValidationGroup="Submit">
                            </asp:RegularExpressionValidator>
                        </td>
                    </tr>
                   
                    <tr>
                        <td>&nbsp;</td>
                        <td><asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save" CssClass="glbtn" ValidationGroup="Submit" 
                                onclick="btn_Update_Click" />
                            <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" CssClass="glbtn"  
                                onclick="btn_Cancel_Click" />
                        
                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <asp:HiddenField ID="hdn_MyProfileId" runat="server" />

            <asp:HiddenField ID="hdn_ClassID" runat="server" />
            <asp:HiddenField ID="hdn_SchoolID" runat="server" />
            <asp:HiddenField ID="hdn_CityID" runat="server" />

            <asp:Panel ID="pnl_AdminList" runat="server">

            </asp:Panel>
            </div>
        </div>
</asp:Content>

