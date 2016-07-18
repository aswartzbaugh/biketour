<%@ page culture="de-DE" uiculture="de-DE" title="BikeTour - Quiz Questions" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="AppAdmin_AddQuizTests, App_Web_lniogwaq" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function Confirm(obj) {
            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdnQuizId]").val(obj);
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
    <asp:HiddenField ID="hdnQuizId" runat="server" />
    <asp:Button ID="btnDelete" runat="server" Text="" OnClick="btnDelete_Click" Style="display: none;" />
    <div class="container">
        <h5>
        <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
            </asp:Label></h5>
        <div class="AdminContWrap">
            <asp:Panel ID="pnl_UploadQuiz" runat="server">
                <div class="frmBox">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_QuizName" runat="server" meta:ResourceKey="lbl_QuizName"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_QuizTest" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    CssClass="error" Display="Dynamic" ControlToValidate="txt_QuizTest" 
                                    ValidationGroup="Upload" meta:ResourceKey="RequiredFieldValidator1">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_City" runat="server" meta:ResourceKey="lbl_City"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddl_City" runat="server" DataSourceID="sdsCity" DataTextField="CityName"
                                    DataValueField="CityId">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="SELECT [CityId], [CityName] FROM [CityMaster] 
                                where IsActive=1 and IsParticipatingCity=1
                                and CityId NOT IN(select CityId from QuizTests where IsActive=1)
                                Order by CityName"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" 
                                    Display="Dynamic" ControlToValidate="ddl_City" InitialValue="0" ValidationGroup="Upload"
                                    CssClass="error" meta:ResourceKey="rfvCity">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_Select" runat="server" meta:ResourceKey="lbl_Select"></asp:Label>
                            </td>
                            <td>
                                <asp:FileUpload ID="fu_UploadQuiz" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btn_Upload" runat="server" meta:ResourceKey="btn_Upload" OnClick="btn_Upload_Click"
                                    ValidationGroup="Upload" />
                                <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" OnClick="btn_Cancel_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnl_QuizList" runat="server">
                <br />
                <div class="GridWrap">
                    <asp:GridView ID="grd_QuizList" runat="server" AutoGenerateColumns="False" DataKeyNames="QuizId"
                        DataSourceID="sdsQuiz" HeaderStyle-CssClass="gridHeader" Width="100%" EmptyDataText="No Records!"
                        onsorting="grd_Sorting" onrowdatabound="grd_QuizList_RowDataBound" 
                        onrowcommand="grd_QuizList_RowCommand">
                        <Columns>
                            <%--<asp:BoundField DataField="QuizId" HeaderText="QuizId" InsertVisible="False" 
                         ReadOnly="True" SortExpression="QuizId" />--%>
                            <asp:TemplateField HeaderText="QuizId" SortExpression="QuizId" InsertVisible="False">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblQuizId" runat="server" meta:ResourceKey="lblQuizId"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtnQuizId" runat="server" CommandName="sort" meta:ResourceKey="lbtnQuizId" CommandArgument="QuizId"></asp:LinkButton>
                                    <asp:PlaceHolder id="pdtQuizID" runat="server"> </asp:PlaceHolder> 
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblQuizId" runat="server" Text='<%# Eval("QuizId") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="QuizName" HeaderText="Quiz Name" 
                         SortExpression="QuizName" />--%>
                            <asp:TemplateField HeaderText="Quiz File" SortExpression="QuizName">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblQuizfile" runat="server" meta:ResourceKey="lblQuizfile"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtnQuizFile" runat="server" CommandName="sort" meta:ResourceKey="lbtnQuizFile" CommandArgument="QuizName"></asp:LinkButton>
                                    <asp:PlaceHolder id="pdtQuizFile" runat="server"></asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblQuizfile" runat="server" Text='<%# Eval("QuizName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="QuizFile" HeaderText="Quiz File" 
                         SortExpression="QuizFile" />--%>
                            <asp:TemplateField HeaderText="Quiz File" SortExpression="QuizFile">
                                <HeaderTemplate>
                                   <%-- <asp:Label ID="lblQuizFile1" runat="server" meta:ResourceKey="lblQuizFile1"></asp:Label>--%>
                                   <asp:LinkButton ID="lbtnQuizFile1" runat="server" CommandName="sort" meta:ResourceKey="lbtnQuizFile1" CommandArgument="QuizFile"></asp:LinkButton>
                                    <asp:PlaceHolder id="pdtQuizFile1" runat="server"></asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblQuizFile1" runat="server" Text='<%# Eval("QuizFile") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="CityName" HeaderText="City Name" 
                         SortExpression="City Name" />--%>
                            <asp:TemplateField SortExpression="City Name">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrdCityName" runat="server" meta:ResourceKey="lblgrdCityName"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtnCityName" runat="server" CommandName="sort" meta:ResourceKey="lbtnCityName" CommandArgument="CityName"></asp:LinkButton>
                                    <asp:PlaceHolder id="pdtCityName" runat="server"></asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCityName" runat="server" Text='<%# Eval("CityName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <HeaderTemplate>
                                    <asp:Label ID="lblDelete" runat="server" meta:ResourceKey="lblDelete"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <input type="button" id="but1" class="grddel" onclick="Confirm('<%# Eval("QuizId") %>')"
                                        title="löschen" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsQuiz" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                        SelectCommand="SELECT QT.QuizId, QT.QuizName, QT.QuizFile, CM.CityName
                    FROM QuizTests QT LEFT OUTER JOIN CityMaster CM ON QT.CityId=CM.CityId
                    WHERE QT.IsActive=1"></asp:SqlDataSource>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
