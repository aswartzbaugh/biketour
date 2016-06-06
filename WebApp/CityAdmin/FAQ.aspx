<%@ Page Title="BikeTour - FAQ" Culture="de-DE" UICulture="de-DE" Language="C#" MasterPageFile="~/SiteMaster/AdminMaster.master"
    AutoEventWireup="true" CodeFile="FAQ.aspx.cs" Inherits="FAQ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        function Confirm(obj) {

            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdnFAQId]").val(obj);
                $("[id$=btnDeleteFAQ]").trigger("click");
                return true;
            }
            else {
                return false;
            }
        }

        function successDelete() {
            alert('Deleted Successfully!');
        }
    </script>
    <style type="text/css">
        .style1
        {
            width: 806px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
    <div class="pagepadding">
        <h5 id="h1_ClassForum" runat="server">
            <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
            </asp:Label></h5>
        <asp:UpdatePanel ID="Up_ddlSchool" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnFAQId" runat="server" />
                <div class="frmBox">
                    <table>
                        <tr>                           
                            <td>
                                <asp:Label ID="lblMessage" runat="server" meta:ResourceKey="lblQuestion"></asp:Label><br />
                            </td>
                            <td style="vertical-align: top; padding-top: 5px;" class="style1">
                                <div class="bolgsms">
                                    <asp:TextBox ID="txtQuestion" runat="server" CssClass="blog"
                                        TextMode="SingleLine" Rows="2" Columns="40" Width="830px"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDescription" runat="server" meta:ResourceKey="lblAnswer"></asp:Label>
                            </td>
                             <td style="vertical-align: top; padding-top: 5px;" class="style1">
                                <div class="bolgsms">
                                    <asp:TextBox ID="txtAnswer" runat="server" CssClass="blog"
                                        TextMode="MultiLine" Rows="2" Columns="40" Height="99px" Width="831px"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp
                            </td>
                            <td class="style1">
                                <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" meta:ResourceKey="btnUpdate" />
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanelFAQ" runat="server" UpdateMode="Conditional">
            <%--OnPageIndexChanging="grd_ParticipantsList_PageIndexChanging" 
                    onrowcommand="grd_ParticipantsList_RowCommand" 
                    onrowdatabound="grd_ParticipantsList_RowDataBound" 
                    onsorting="grd_ParticipantsList_Sorting"--%>
            <ContentTemplate>
                <div class="GridWrap">
                    <asp:GridView ID="grd_FAQList" runat="server" Width="100%" AutoGenerateColumns="False"
                        EmptyDataText="Keine Datensätze gefunden!" AllowPaging="True" OnPageIndexChanging="grd_FAQList_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="FAQ ID">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdFAQId" runat="server" meta:ResourceKey="lblgrdFAQId" CssClass="hide"
                        Style="display: none;"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_FAQId" runat="server" Text='<%# Eval("FAQId") %>' CssClass="hide"
                        Style="display: none;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdQuestion" runat="server" meta:ResourceKey="lblQuestion"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_FQAQuestion" runat="server" Text='<%# Eval("FAQQuestion") %>' ></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdAnswer" runat="server" meta:ResourceKey="lblAnswer"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_FQAAnswer" runat="server" Text='<%# Eval("FAQAnswer") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblEditFAQ" runat="server" meta:ResourceKey="lblEditFAQ"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="btnEditFAQ" runat="server" Text="" ToolTip="bearbeiten" CssClass="grdedit"
                                        OnClick="btnEditFAQ_Click" CommandArgument='<%# Eval("FAQId") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblDeleteFAQ" runat="server" meta:ResourceKey="lblDeleteFAQ"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <input id="btDelete" type="button" class="grddel" title="löschen" onclick="Confirm('<%# Eval("FAQId") %>    ')" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:Button ID="btnDeleteFAQ" runat="server" Text="" ToolTip="löschen" CssClass="hide"
                        Style="display: none;" OnClick="btnDelete_Click" CommandArgument='<%# Eval("FAQId") %>' />
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnUpdate" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:SqlDataSource ID="sdsForum" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
            SelectCommand="" SelectCommandType="Text"></asp:SqlDataSource>
    </div>
</asp:Content>
