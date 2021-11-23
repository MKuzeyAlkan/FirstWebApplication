<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FirstWebApplication.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.6.4.js"></script>
    <script src="Scripts/jquery.signalR-2.4.1.js"></script>

    <script src="http://localhost:8080/signalr/hubs"></script>

    <script type="text/javascript">
        var logger;

        $(function() {

            $.connection.hub.url = "http://localhost:8080/signalr";  
  
            logger = $.connection.firstHub;            

            //logger.client.WelcomeMessage = function(msg) {

            //    $("#logui").append("<li>" + msg + "</li>");_mka

            //    console.log(msg);
            //};


            //var logger = $.connection.logHub;

            //logger.client.logMessage = function(msg) {

            //    $("#logui").append("<li>" + msg + "</li>");

            //};

            logger.client.WelcomeMessage = function(msg) {

                //$("#logui").append("<li>" + msg + "</li>");
                console.log(msg);

            };

            logger.client.AreYouReady = function(msg) {

                $("#logui").append("<li>" + msg + "</li>");
                console.log(msg);
                //logger.server.sendmsg("btnHello Clicked : Are you Ready");
            };

            $.connection.hub.stateChanged(function (){
                console.log("stateChanged");
            });

            $.connection.hub.disconnected(function() {
                console.log("disconneted");
            });

            $.connection.hub.start()
                .done(function () {
                    console.log('Now connected, connection ID=' + $.connection.hub.id);
                    
                    
                })
                .fail(function () { console.log("hub start failed"); });        

            $('#btnHello').click(function () {
                        console.log('call server');
                        logger.server.sendmsg("btnHello Clicked");
            });

        });

        

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input type="button" id="btnHello" value="Send message to server" />  
        </div>
        <div>
            <h3>Log Items</h3>
            <asp:listview id="logListView" runat="server" itemplaceholderid="itemPlaceHolder" clientidmode="Static" enableviewstate="false">
                <layouttemplate>
                    <ul id="logui">
                        <li runat="server" id="itemPlaceHolder"></li>
                    </ul>
                </layouttemplate>
                <itemtemplate>
                        <li><span class="logItem"><%#Container.DataItem.ToString() %></span></li>
                </itemtemplate>
            </asp:listview>
        </div>
    </form>
</body>
</html>


<%--https://stackoverflow.com/questions/18143599/can-signalr-be-used-with-asp-net-webforms--%>

