<%@ page title="BikeTour - FAQ" culture="de-DE" uiculture="de-DE" language="C#" autoeventwireup="true" masterpagefile="~/Master.master" inherits="FAQ, App_Web_ng55utgi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pagepadding">
        <h5 id="h1_ClassForum" runat="server">
            <asp:Label ID="lblHead" runat="server" meta:resourcekey="lblHead">
            </asp:Label>
        </h5>
        <%--OnPageIndexChanging="grd_ParticipantsList_PageIndexChanging" 
                    onrowcommand="grd_ParticipantsList_RowCommand" 
                    onrowdatabound="grd_ParticipantsList_RowDataBound" 
                    onsorting="grd_ParticipantsList_Sorting"--%>
        <div class="GridWrap">
            <asp:GridView ID="grd_FAQList" runat="server" Width="100%" AutoGenerateColumns="False"
                EmptyDataText="Keine Datensätze gefunden!" AllowPaging="True" OnPageIndexChanging="grd_FAQList_PageIndexChanging">
                <Columns>
                    <%--<asp:TemplateField HeaderText="FAQ ID">
                        <HeaderTemplate>
                            <asp:Label ID="lblgrdFAQId" runat="server" meta:ResourceKey="lblgrdFAQId"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbl_FAQId" runat="server" Text='<%# Eval("FAQId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Description">
                        <HeaderTemplate>
                            <asp:Label ID="lblgrdQuestion" runat="server" meta:ResourceKey="lblQuestion"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbl_FQAQuestion" runat="server" Text='<%# Eval("FAQQuestion") %>'></asp:Label>
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
                </Columns>
            </asp:GridView>
        </div>
        <asp:SqlDataSource ID="sdsForum" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
            SelectCommand="" SelectCommandType="Text"></asp:SqlDataSource>
    </div>
    </asp:Content>
