<%@ page title="BikeTour - About Us" language="C#" masterpagefile="~/Master.master" autoeventwireup="true" inherits="AboutUs, App_Web_avjmsh3w" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <h5 id="h1_ClassForum" runat="server">
  <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
        </asp:Label></h5>
        <div class="frmBox">
            <asp:FormView ID="fvDiscription" runat="server" DataSourceID="sdsDiscription">
                <ItemTemplate>
                <p>
                    <asp:Label ID="DiscriptionLabel" runat="server" 
                        Text='<%# Bind("Description") %>' />
                   </p>

                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="sdsDiscription" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>" 
                SelectCommand="SELECT [Description] FROM [AboutUs] "></asp:SqlDataSource>
        </div>

</asp:Content>

