
<script type="text/javascript">
    $(document).ready(function () {
        if (window.goSamples)
            goSamples();  // init for these samples -- you don't need to call this
        var $ = go.GraphObject.make;  // for conciseness in defining templates

        myDiagram =
                $(go.Diagram, "myDiagram", // must be the ID or reference to div
                        {
                            initialContentAlignment: go.Spot.Center,
                            // make sure users can only create trees
                            validCycle: go.Diagram.CycleDestinationTree,
                            // users can select only one part at a time
                            maxSelectionCount: 1,
                            layout:
                                    $(go.TreeLayout,
                                            {
                                                treeStyle: go.TreeLayout.StyleLastParents,
                                                arrangement: go.TreeLayout.ArrangementHorizontal,
                                                // properties for most of the tree:
                                                angle: 90,
                                                layerSpacing: 35,
                                                // properties for the "last parents":
                                                alternateAngle: 90,
                                                alternateLayerSpacing: 35,
                                                alternateAlignment: go.TreeLayout.AlignmentBus,
                                                alternateNodeSpacing: 20
                                            }),
                            // support editing the properties of the selected person in HTML
//                            "ChangedSelection": onSelectionChanged,
//                            "TextEdited": onTextEdited,
                            // enable undo & redo
                            "undoManager.isEnabled": true
                        });

        // when the document is modified, add a "*" to the title and enable the "Save" button
        myDiagram.addDiagramListener("Modified", function(e) {
            var button = document.getElementById("SaveButton");
            if (button) button.disabled = !myDiagram.isModified;
            var idx = document.title.indexOf("*");
            if (myDiagram.isModified) {
                if (idx < 0) document.title += "*";
            } else {
                if (idx >= 0) document.title = document.title.substr(0, idx);
            }
        });

        var levelColors = ["#AC193D/#BF1E4B", "#2672EC/#2E8DEF", "#8C0095/#A700AE", "#5133AB/#643EBF",
            "#008299/#00A0B1", "#D24726/#DC572E", "#008A00/#00A600", "#094AB2/#0A5BC4"];

        // override TreeLayout.commitNodes to also modify the background brush based on the tree depth level
        myDiagram.layout.commitNodes = function() {
            go.TreeLayout.prototype.commitNodes.call(myDiagram.layout);  // do the standard behavior
            // then go through all of the vertexes and set their corresponding node's Shape.fill
            // to a brush dependent on the TreeVertex.level value
            myDiagram.layout.network.vertexes.each(function(v) {
                if (v.node) {
                    var level = v.level % (levelColors.length);
                    var colors = levelColors[level].split("/");
                    var shape = v.node.findObject("SHAPE");
                    if (shape) shape.fill = $(go.Brush, "Linear", { 0: colors[0], 1: colors[1], start: go.Spot.Left, end: go.Spot.Right });
                }
            });
        }

        // when a node is double-clicked, add a child to it
        function nodeDoubleClick(e, obj) {
            var clicked = obj.part;
            if (clicked !== null) {
                var thisemp = clicked.data;
                myDiagram.startTransaction("add employee");
                var nextkey = (myDiagram.model.nodeDataArray.length + 1).toString();
                var newemp = { key: nextkey, name: "(new person)", title: "", parent: thisemp.key };
                myDiagram.model.addNodeData(newemp);
                myDiagram.commitTransaction("add employee");
            }
        }

        // this is used to determine feedback during drags
        function mayWorkFor(node1, node2) {
            if (!(node1 instanceof go.Node)) return false;  // must be a Node
            if (node1 === node2) return false;  // cannot work for yourself
            if (node2.isInTreeOf(node1)) return false;  // cannot work for someone who works for you
            return true;
        }

        // This function provides a common style for most of the TextBlocks.
        // Some of these values may be overridden in a particular TextBlock.
        function textStyle() {
            return { font: "9pt  Segoe UI,sans-serif", stroke: "white" };
        }

        // This converter is used by the Picture.
        function findHeadShot(key) {
            if (key > 16) return ""; // There are only 16 images on the server
            return "images/HS" + key + ".png"
        };


        // define the Node template
        myDiagram.nodeTemplate =
                $(go.Node, "Auto",
                        { doubleClick: nodeDoubleClick },
                        { // handle dragging a Node onto a Node to (maybe) change the reporting relationship
                            mouseDragEnter: function (e, node, prev) {
                                var diagram = node.diagram;
                                var selnode = diagram.selection.first();
                                if (!mayWorkFor(selnode, node)) return;
                                var shape = node.findObject("SHAPE");
                                if (shape) {
                                    shape._prevFill = shape.fill;  // remember the original brush
                                    shape.fill = "darkred";
                                }
                            },
                            mouseDragLeave: function (e, node, next) {
                                var shape = node.findObject("SHAPE");
                                if (shape && shape._prevFill) {
                                    shape.fill = shape._prevFill;  // restore the original brush
                                }
                            },
                            mouseDrop: function (e, node) {
                                var diagram = node.diagram;
                                var selnode = diagram.selection.first();  // assume just one Node in selection
                                if (mayWorkFor(selnode, node)) {
                                    // find any existing link into the selected node
                                    var link = selnode.findTreeParentLink();
                                    if (link !== null) {  // reconnect any existing link
                                        link.fromNode = node;
                                    } else {  // else create a new link
                                        diagram.toolManager.linkingTool.insertLink(node, node.port, selnode, selnode.port);
                                    }
                                }
                            }
                        },
                        // for sorting, have the Node.text be the data.name
                        new go.Binding("text", "name"),
                        // bind the Part.layerName to control the Node's layer depending on whether it isSelected
                        new go.Binding("layerName", "isSelected", function(sel) { return sel ? "Foreground" : ""; }).ofObject(),
                        // define the node's outer shape
                        $(go.Shape, "Rectangle",
                                {
                                    name: "SHAPE", fill: "white", stroke: null,
                                    // set the port properties:
                                    portId: "", fromLinkable: true, toLinkable: true, cursor: "pointer"
                                }),
                        $(go.Panel, "Horizontal",
                                $(go.Picture,
                                        {
                                            name: 'Picture',
                                            desiredSize: new go.Size(39, 50),
                                            margin: new go.Margin(6, 8, 6, 10),
                                        },
                                        new go.Binding("source", "key", findHeadShot)),
                                // define the panel where the text will appear
                                $(go.Panel, "Table",
                                        {
                                            maxSize: new go.Size(150, 999),
                                            margin: new go.Margin(6, 10, 0, 3),
                                            defaultAlignment: go.Spot.Left
                                        },
                                        $(go.RowColumnDefinition, { column: 2, width: 4 }),
                                        $(go.TextBlock, textStyle(),  // the name
                                                {
                                                    row: 0, column: 0, columnSpan: 5,
                                                    font: "12pt Segoe UI,sans-serif",
                                                    editable: true, isMultiline: false,
                                                    minSize: new go.Size(10, 16)
                                                },
                                                new go.Binding("text", "name").makeTwoWay()),
                                        $(go.TextBlock, "Title: ", textStyle(),
                                                { row: 1, column: 0 }),
                                        $(go.TextBlock, textStyle(),
                                                {
                                                    row: 1, column: 1, columnSpan: 4,
                                                    editable: true, isMultiline: false,
                                                    minSize: new go.Size(10, 14),
                                                    margin: new go.Margin(0, 0, 0, 3)
                                                },
                                                new go.Binding("text", "title").makeTwoWay()),
                                        $(go.TextBlock, textStyle(),
                                                { row: 2, column: 0 },
                                                new go.Binding("text", "key", function(v) {return "ID: " + v;})),
                                        $(go.TextBlock, textStyle(),
                                                { row: 2, column: 3, },
                                                new go.Binding("text", "parent", function(v) {return "Boss: " + v;})),
                                        $(go.TextBlock, textStyle(),  // the comments
                                                {
                                                    row: 3, column: 0, columnSpan: 5,
                                                    font: "italic 9pt sans-serif",
                                                    wrap: go.TextBlock.WrapFit,
                                                    editable: true,  // by default newlines are allowed
                                                    minSize: new go.Size(10, 14)
                                                },
                                                new go.Binding("text", "comments").makeTwoWay())
                                )  // end Table Panel
                        ) // end Horizontal Panel
                );  // end Node

        // define the Link template
        myDiagram.linkTemplate =
                $(go.Link, go.Link.Orthogonal,
                        { corner: 5, relinkableFrom: true, relinkableTo: true },
                        $(go.Shape, { strokeWidth: 4, stroke: "#00a4a4" }));  // the link shape

        // read in the JSON-format data from the "mySavedModel" element
        load();
    });

    // Allow the user to edit text when a single node is selected
    function onSelectionChanged(e) {
        var node = e.diagram.selection.first();
        if (node instanceof go.Node) {
            updateProperties(node.data);
        } else {
            updateProperties(null);
        }
    }

    // Update the HTML elements for editing the properties of the currently selected node, if any
    function updateProperties(data) {
        if (data === null) {
            document.getElementById("propertiesPanel").style.display = "none";
            document.getElementById("name").value = "";
            document.getElementById("title").value = "";
            document.getElementById("comments").value = "";
        } else {
            document.getElementById("propertiesPanel").style.display = "block";
            document.getElementById("name").value = data.name || "";
            document.getElementById("title").value = data.title || "";
            document.getElementById("comments").value = data.comments || "";
        }
    }

    // This is called when the user has finished inline text-editing
    function onTextEdited(e) {
        var tb = e.subject;
        if (tb === null || !tb.name) return;
        var node = tb.part;
        if (node instanceof go.Node) {
            updateProperties(node.data);
        }
    }

    // Update the data fields when the text is changed
    function updateData(text, field) {
        var node = myDiagram.selection.first();
        // maxSelectionCount = 1, so there can only be one Part in this collection
        var data = node.data;
        if (node instanceof go.Node && data !== null) {
            var model = myDiagram.model;
            model.startTransaction("modified " + field);
            if (field === "name") {
                model.setDataProperty(data, "name", text);
            } else if (field === "title") {
                model.setDataProperty(data, "title", text);
            } else if (field === "comments") {
                model.setDataProperty(data, "comments", text);
            }
            model.commitTransaction("modified " + field);
        }
    }

    // Show the diagram's model in JSON format
    function save() {
        document.getElementById("mySavedModel").value = myDiagram.model.toJson();
        myDiagram.isModified = false;
    }
    function load() {
        myDiagram.model = go.Model.fromJson(document.getElementById("mySavedModel").value);
    }
</script>
<div id="sample">
    <div id="myDiagram" style="background-color: #222222; border: solid 1px black; height: 500px"></div>
    %{--<div>--}%
        %{--<textarea id="mySavedModel" style="width:0%;height:0px" >{ "class": "go.TreeModel",--}%
        %{--"nodeDataArray": [--}%
        %{--{"key":"1", "name":"Stella Payne Diaz", "title":"CEO"},--}%
        %{--{"key":"2", "name":"Luke Warm", "title":"VP Marketing/Sales", "parent":"1"},--}%
        %{--{"key":"3", "name":"Meg Meehan Hoffa", "title":"Sales", "parent":"2"},--}%
        %{--{"key":"4", "name":"Peggy Flaming", "title":"VP Engineering", "parent":"1"},--}%
        %{--{"key":"5", "name":"Saul Wellingood", "title":"Manufacturing", "parent":"4"},--}%
        %{--{"key":"6", "name":"Al Ligori", "title":"Marketing", "parent":"2"},--}%
        %{--{"key":"7", "name":"Dot Stubadd", "title":"Sales Rep", "parent":"3"},--}%
        %{--{"key":"8", "name":"Les Ismore", "title":"Project Mgr", "parent":"5"},--}%
        %{--{"key":"9", "name":"April Lynn Parris", "title":"Events Mgr", "parent":"6"},--}%
        %{--{"key":"10", "name":"Xavier Breath", "title":"Engineering", "parent":"4"},--}%
        %{--{"key":"11", "name":"Anita Hammer", "title":"Process", "parent":"5"},--}%
        %{--{"key":"12", "name":"Billy Aiken", "title":"Software", "parent":"10"},--}%
        %{--{"key":"13", "name":"Stan Wellback", "title":"Testing", "parent":"10"},--}%
        %{--{"key":"14", "name":"Marge Innovera", "title":"Hardware", "parent":"10"},--}%
        %{--{"key":"15", "name":"Evan Elpus", "title":"Quality", "parent":"5"},--}%
        %{--{"key":"16", "name":"Lotta B. Essen", "title":"Sales Rep", "parent":"3"}--}%
        %{--]--}%
        %{--}--}%
        %{--</textarea>--}%
    %{--</div>--}%
</div>



%{--</body>--}%
%{--</html>--}%
