<%@ Page Title="Bike Tour - Upload GPX File" Culture="de-DE" UICulture="de-DE" Language="C#" MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="UploadGpx.aspx.cs" Inherits="Student_UploadGpx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h5 id="h1_ClassSchool" runat="server">
        <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead"></asp:Label>
    </h5>
    <div class="AdminContWrap">
        <div class="frmBox">
            <asp:Label ID="lblMessage" runat="server" Text="" CssClass="CurrentStage" Visible="true"></asp:Label><br />
            <asp:TextBox ID="txtKmsDriven" runat="server" Visible="false"></asp:TextBox>
            <asp:Button ID="btnAddKms" runat="server" meta:ResourceKey="btn_AddKms" Style="width: 160px" OnClick="btnAddKms_Click" Visible="false" />
            <br />
            <asp:FileUpload ID="fu_UploadGpx" runat="server" Visible="true" />
            <asp:Button ID="btn_Upload" runat="server" meta:ResourceKey="btn_Upload"
                OnClick="btn_Upload_Click" Visible="true" Style="width: 160px" />
            <asp:Button ID="btn_Back" runat="server" meta:ResourceKey="btn_Back"
                OnClick="btn_Back_Click" />
            <br />
            <div class="line"></div>
            <div class="GridWrap">
                <asp:GridView ID="grd_Uploads" runat="server" AutoGenerateColumns="False" Width="100%"
                    DataKeyNames="StudentUploadId" DataSourceID="sds_Uploads" EmptyDataText="No Records!" AllowSorting="true" HeaderStyle-CssClass="gridHeader">
                    <Columns>

                        <asp:TemplateField HeaderText="Uploaded File">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdUploadedFile" runat="server" meta:ResourceKey="lblgrdUploadedFile"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <a target="_blank" href='<%# "../GPXFiles/" + Eval("SchoolId") + "/" + Eval("ClassId") + "/" + Eval("StudentId") + "/" + Eval("FileName") %>'
                                    id="GpxDownload" runat="server">
                                    <asp:Label ID="lblGpx" runat="server" Text='<%# Eval("FileName") %>'></asp:Label>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Date" SortExpression="AddedOn">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdDate" runat="server" meta:ResourceKey="lblgrdDate"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblDategrd" runat="server" Text='<%# Eval("AddedOn") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Kilometer" SortExpression="Kilometer">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdKilometer" runat="server" meta:ResourceKey="lblgrdKilometer"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblKilometergrd" runat="server" Text='<%# Eval("Kilometer") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="Time" HeaderText="Time (Hr)" SortExpression="Time" />--%>
                        <asp:TemplateField HeaderText="Time" SortExpression="Time">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdTime" runat="server" meta:ResourceKey="lblgrdTime"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTimegrd" runat="server" Text='<%# Eval("Time") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="AvgSpeed" HeaderText="Speed (KMPH)" 
                    SortExpression="AvgSpeed" />--%>
                        <asp:TemplateField HeaderText="AvgSpeed" SortExpression="AvgSpeed">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdAvgSpeed" runat="server" meta:ResourceKey="lblgrdAvgSpeed"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAvgSpeedgrd" runat="server" Text='<%# Eval("AvgSpeed") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Status">
                            <HeaderTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStatusText" runat="server" Text='<%#  GetApproveStatusText(Eval("ApprovedStatus")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:CheckBoxField DataField="IsValid" HeaderText="IsValid"
                            SortExpression="IsValid" Visible="false" />

                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sds_Uploads" runat="server"
                    ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                    SelectCommand="SP_GET_STUDENT_UPLOADS" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="RoleId" SessionField="UserRoleId"
                            Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="StudentId" SessionField="UserId"
                            Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="ClassAdminId"
                            SessionField="UserId" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="ClassId" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="Speed" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <br />
        </div>
    </div>
</asp:Content>

