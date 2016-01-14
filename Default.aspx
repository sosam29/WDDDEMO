<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebDropDownDemo.Default" %>
<%@ Register Assembly="Infragistics4.Web.v15.2, Version=15.2.20152.2042, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.Web.UI.ListControls" TagPrefix="ig" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.9.1.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
        <script type="text/javascript">
            //var Global variable;*
            var olditemstring = "";
            var newitemstring = "";

  <%--  function WDD1_Closed(sender, eventArgs) {
        var  txt2display= unique(newitemstring.split(","));
        populateDropDown(txt2display)    
        }
    function populateDropDown(list) {
        clearSelection();
        var resultval = $find('<%= WDD2.ClientID %>');
        for (var i = 0; i < list.length - 1; i++) {
            var item = resultval.get_items().createItem();
            item.set_text(list[i]);
            item.set_value(list[i]);
            //alert(list[i]);
            setTimeout(function () {
                resultval.get_items().add(item);
            }, 5000);
        }
    }--%>
            <%-- function clearSelection() {
            var dropDown =$find('<%= WDD2.ClientID %>');
            dropDown.set_currentValue('', true);
            var items = dropDown.get_items();
            for (var i = 0; i < items.length-1; i++) {
                var item = items.getItem(i);
                if (item.isSelected() && item != null) {
                    item.unselect();
                    item.inactivate();                        
                }
            }
        } 
        function unique(arr) {
            var u = {}, a = [];
            for (var i = 0, l = arr.length; i < l; ++i) {
                if (!u.hasOwnProperty(arr[i])) {
                    a.push(arr[i]);
                    u[arr[i]] = 1;
                }
            }
            return a;
        }
        function ArrNoDupe(a) {
            var temp = {};
            for (var i = 0; i < a.length; i++)
                temp[a[i]] = true;
            var r = [];
            for (var k in temp)
                r.push(k);
            return r;
        }
       <%-- --function WDD1_SelectionChanged(sender, eventArgs) {
            var olditems = eventArgs.getOldSelection();
            var newitems = eventArgs.getNewSelection();
            for (var i = 0; i < olditems.length; i++) {
                if (olditems != null) {
                    olditemstring += olditems[i].get_text() + ",";
                }
            }
            for (var i = 0; i < newitems.length; i++) {
                if (newitems != null) {
                    newitemstring += newitems[i].get_text() + ",";
                }
            }
            //alert(newitemstring);
            var childDropDown = $find('<%= WDD2.ClientID%>');
            childDropDown.loadItems(eventArgs.getNewSelection()[0].get_value(), false);
        }--%>
            var newitemcollection = "";
            function parent_SelectionChanged(sender, eventArgs) {
                var childDropDown = $find('<%=child.ClientID %>');
                var newItems = eventArgs.getNewSelection();
               // var newitemcollection = "";

                for (i = 0; i < newItems.length; i++)
                    newitemcollection += newItems[i].get_text().trim() + ",";

               // childDropDown.loadItems(sender.lastValue);
            }

            Array.prototype.contains = function (v) {
                for (var i = 0; i < this.length; i++) {
                    if (this[i] === v) return true;
                }
                return false;
            };

            Array.prototype.unique = function () {
                var arr = [];
                for (var i = 0; i < this.length-1; i++) {
                    if (!arr.contains(this[i].trim())) {
                        arr.push(this[i]);
                    }
                }
                return arr;
            }
            function populateDropDown() {
                var parentWDD = $find('<%= parent.ClientID %>');
                var ispopulated = false;
                var selectedItem = parentWDD.get_selectedItem();
                var selectedItemText = parentWDD._lastVal;
                alert(selectedItemText);
                var arr = selectedItemText.split(',');
                var uniqueNames = arr.unique();

                if (arr.length-1 > 1) {
                   // uniqueNames.sort();
                    ispopulated = true;
                }
                // tried to convert and bind array to wdd as json datasrc
                //but still does not work!!! Help me Lord what I am missing!!!

                <%--                var myJsonString = JSON.stringify(uniqueNames);
                var datasource;
                datasource = myJsonString;
                if (datasource && datasource.length > 0)
                {
                    var childWdd = $find('<%= child.ClientID %>');
                    childWdd.set_dataSource(datasource);
                    childWdd.dataBind();
                }--%>

                if (ispopulated) {
                    var childWDD = $find('<%= child.ClientID %>');
                    var ddl = $get("DDL1");
                    // to clean the dropdown list
                    var length = ddl.options.length;
                    for (i = 0; i < length; i++) {
                        ddl.options[i] = null;
                        ddl.innerHTML = null;
                    }
                    var txtbox = $get("txtbox");
                    var txtcontent = "";
                    for (var i = 0; i < arr.length; i++) {
                        txtcontent += arr[i] + "\n";
                        //populate the dropdown list
                        var item = childWDD.get_items().createItem();
                        item.set_text(arr[i].toString());
                        item.set_value(i);
                        childWDD.get_items().add(item);
                        childWDD.set_selectedItemIndex(0)
                        var option = document.createElement("option");
                        option.text = option.value = arr[i];
                        ddl.add(option, 0);
                    }
                    txtbox.value= txtcontent;
                }

            }
    </script>
        <%--         <ig:WebDropDown ID="WDD1" 
                    runat="server" 
                    Width="300px"
                    EnableClosingDropDownOnSelect="false"
                    TextField="Title"
                    ValueField="ID"
                    EnableMultipleSelection="true"
                    DropDownContainerWidth="300px"                    
                    ClientEvents-SelectionChanged="WDD1_SelectionChanged">
                    <%--ClientEvents-DropDownClosed="WDD1_Closed">-
             <Items>
                 <ig:DropDownItem Text="DropDown Item 1" Value="1" Selected="False"></ig:DropDownItem>
                 <ig:DropDownItem Text="DropDown Item 2" Value="2" Selected="False"></ig:DropDownItem>
                 <ig:DropDownItem Text="DropDown Item 3" Value="3" Selected="False"></ig:DropDownItem>
                 <ig:DropDownItem Text="DropDown Item 4" Value="4" Selected="False"></ig:DropDownItem>
                 <ig:DropDownItem Text="DropDown Item 5" Value="5" Selected="False"></ig:DropDownItem>
             </Items>
         </ig:WebDropDown><p/>--%>           
        <%-- <ig:WebDropDown ID="WDD2" 
                    runat="server" 
                    Width="200px"
                    TextField="Text" 
                    ValueField="Value"
                    EnableAutoFiltering="Client"
                    EnableAutoCompleteFirstMatch="false" 
                    EnableDropDownAsChild="false"                    
                    DropDownContainerWidth="200px" 
                    DropDownContainerHeight="200px" 
                    >
         </ig:WebDropDown>--%>
        <br />
         <ig:WebDropDown ID="parent" runat="server" Width="200px" CurrentValue="ID" EnableMultipleSelection="true">
            <ClientEvents SelectionChanged="parent_SelectionChanged" />
               <Items>
                 <ig:DropDownItem Text="DropDown Item 1" Value="1" Selected="False"></ig:DropDownItem>
                 <ig:DropDownItem Text="DropDown Item 2" Value="2" Selected="False"></ig:DropDownItem>
                 <ig:DropDownItem Text="DropDown Item 3" Value="3" Selected="False"></ig:DropDownItem>
                 <ig:DropDownItem Text="DropDown Item 4" Value="4" Selected="False"></ig:DropDownItem>
                 <ig:DropDownItem Text="DropDown Item 5" Value="5" Selected="False"></ig:DropDownItem>
             </Items>
        </ig:WebDropDown>
        <br />
        <ig:WebDropDown ID="child" runat="server" Width="200px" EnableMultipleSelection="false"
            ClientEvents-DropDownOpening="populateDropDown" 
            MultipleSelectionType="Checkbox" CurrentValue="DSE">
        </ig:WebDropDown>
        <p/>
            <asp:DropDownList ID="DDL1" runat="server" Width="200px">
            </asp:DropDownList>
        <p/>
    <asp:Button Text="text" ID="btnTxt" runat="server" /><p/>
    <asp:TextBox runat="server" ID="txtbox" TextMode="MultiLine" Width="400px" Height="100px" />  
    </form>
</body>


</html>
