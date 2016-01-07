<%@ Page Title="Bike Tour - Participant List" Culture="de-DE" UICulture="de-DE" Language="C#"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="ParticipantList.aspx.cs"
    Inherits="ClassAdmin_ParticipantList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:HiddenField ID="hdn_ClassAdminId" runat="server" Value="0" />
    <div class="frmBox_2">
        <table width="64%">
            <tr>
                <td>
                    <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                </td>
                <td>
                    <span class="error right">*</span>
                    <asp:UpdatePanel ID="Up_ddlSchool" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                DataValueField="SchoolId" AutoPostBack="true">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSchool" runat="server" meta:ResourceKey="rfvSchool"
                                InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                                CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand=" select sm.SchoolId, sm.School from schoolmaster sm
                                           where sm.IsActive=1
                                           and sm.CityId in(select CityId from CityAdminCities where CityAdminId=@CityAdminId) order by School
                                               ">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CityAdminId" SessionField="UserId" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass"></asp:Label>
                </td>
                <td>
                    <span class="error right">*</span>
                    <asp:UpdatePanel ID="Up_ddlClass" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="True" DataSourceID="sdsClass"
                                DataTextField="Class" DataValueField="ClassId" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsClass" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SP_GET_DISTINCT_CLASSES" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="0" Name="ClassAdminId" Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlSchool" DefaultValue="0" Name="SchoolId" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:RequiredFieldValidator ID="rfvClass" runat="server" meta:ResourceKey="rfvClass"
                                InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="SubmitClass" CssClass="error"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="ddlClass" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <div class="container">
        <h5>
            <asp:Label ID="lblHeader" runat="server" meta:ResourceKey="lblHeader"></asp:Label></h5>
        <div class="AdminContWrap">
            <div class="GridWrap">
                <asp:GridView ID="grd_ParticipantsList" runat="server" Width="100%" AutoGenerateColumns="False"
                     OnRowCreated="grd_ParticipantsList_RowCreated"
                    EmptyDataText="Keine Datensätze gefunden!" AllowPaging="True" 
                    OnPageIndexChanging="grd_ParticipantsList_PageIndexChanging" 
                    onrowcommand="grd_ParticipantsList_RowCommand" 
                    onrowdatabound="grd_ParticipantsList_RowDataBound" 
                    onsorting="grd_ParticipantsList_Sorting">
                    <Columns>
                        <asp:TemplateField HeaderText="Student">
                            <HeaderTemplate>
                                <asp:LinkButton ID="lblgrdStudent" runat="server" meta:ResourceKey="lblgrdStudent"
                                    CommandName="Sort" CommandArgument="STUDENTNAME"></asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderSTUDENTNAME" runat="server"></asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" ForeColor="#0033CC" PostBackUrl='<%#"~/ClassAdmin/StudentDetails.aspx?StudentId="+ Eval("StudentId") %>'
                                    Text='<%# Eval("STUDENTNAME") %>' ToolTip="Student details"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField>
                                    <HeaderTemplate>
                                         <asp:LinkButton ID="lbtngrdUsername" runat="server" meta:ResourceKey="lbtngrdUsername"
                                            CommandName="Sort" ></asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID = "lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                        <asp:TemplateField HeaderText="Confirmed">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdConfirmed" runat="server" meta:ResourceKey="lblgrdConfirmed"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_Confirmed" runat="server" Checked='<%# Eval("IsStatusConfirmed") %>'
                                    AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" Enabled="true" />
                                <asp:Label ID="lbl_StudentId" runat="server" Text='<%# Eval("StudentId") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Active">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdActive" runat="server" meta:ResourceKey="lblgrdActive"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_Active" runat="server" Checked='<%# Eval("IsStatusActive") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />--%>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:LinkButton ID="grdlnkPassword" runat="server" meta:ResourceKey="grdlnkPassword"
                                    CommandName="Sort" CommandArgument="Password"></asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderPassword" runat="server"></asp:PlaceHolder>
                                <%--<asp:Label ID="grdlblPassword" runat="server" meta:ResourceKey="grdlblPassword"></asp:Label>--%>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPassword" runat="server" Text='<%#Eval("Password") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblEditDetails" runat="server" meta:ResourceKey="lblEditDetails"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="btnEditStudDetails" runat="server" Text="" ToolTip="bearbeiten" CssClass="grdedit" 
                                            onclick="btnEditStudDetails_Click" CommandArgument='<%# Eval("StudentId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdParticipants" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                    SelectCommand="SP_GET_ClassParticipantsList" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="0" Name="ClassAdminId" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlClass" DefaultValue="0" Name="classid" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div id="div_ButtonList" runat="server">
                <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save" OnClick="btn_Save_Click" />
            </div>
        </div>
    </div>
</asp:Content>
