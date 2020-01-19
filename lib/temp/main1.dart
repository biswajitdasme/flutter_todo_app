import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Exploring UI widgets",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Basic List View"),
        ),
        body: getLongListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => debugPrint("Fab clicked"),
          child: Icon(Icons.add),
          tooltip: 'Add One More Item',
        ),
      )));
}

void showSnackbar(BuildContext context, String item) {
  var snackbar = SnackBar(
    content: Text("You clicked $item"),
    action: SnackBarAction(
      label: "UNDO",
      onPressed: () {
        debugPrint("Performing dummy undo");
      },
    ),
  );
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(snackbar);
}

List<String> getListElements() {
  var items = List<String>.generate(1000, (counter) => "Item $counter");

  return items;
}

Widget getLongListView() {
  var listItems = getListElements();

  var listView = ListView.builder(itemBuilder: (context, index) {
    return ListTile(
      leading: Icon(Icons.arrow_right),
      title: Text(listItems[index]),
      onTap: () {
        showSnackbar(context, listItems[index]);
      },
    );
  });

  return listView;
}

Widget getListView() {
  var listView = ListView(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.landscape),
        title: Text("Landscape"),
        subtitle: Text("Beautiful View"),
        trailing: Icon(Icons.wb_sunny),
        onTap: () => debugPrint("Landscap tapped"),
      ),
      ListTile(
        leading: Icon(Icons.laptop_chromebook),
        title: Text("Windows"),
      ),
      ListTile(
        leading: Icon(Icons.phone),
        title: Text("Phone"),
      ),
    ],
  );
  return listView;
}
