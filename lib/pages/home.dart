import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names_app/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 1),
    Band(id: '1', name: 'Los Redondos', votes: 0),
    Band(id: '1', name: 'Mika', votes: 5),
    Band(id: '1', name: 'Nek', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bandnames', style: TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
            itemCount: bands.length,
            itemBuilder: (BuildContext context, int index) =>
                _bandTile(bands[index])),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 1,
          onPressed: addNewBand,
        ));
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction ');
        print('id: ${band.name}');
      },
      background: Container(
          padding: EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Delete Band',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          )),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20.0)),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();
    if (Platform.isAndroid) {
      // Android
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                  child: Text('Add'),
                  textColor: Colors.blue,
                  elevation: 5,
                  onPressed: () => addBandToList(textController.text))
            ],
          );
        },
      );
    }
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Text('New band name'),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Add'),
                    onPressed: () => addBandToList(textController.text)),
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: Text('Dismiss'),
                    onPressed: () => Navigator.pop(context))
              ],
            );
          });
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      //Podemos agregar
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
