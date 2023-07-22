import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bans = [
    Band(id: '1', name: 'LosCafres', votes: 1),
    Band(id: '2', name: 'Resistencia S', votes: 1),
    Band(id: '3', name: 'BobMarley', votes: 4)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bans.length,
          itemBuilder: (BuildContext context, int index) =>
              _bandTile(bans[index])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: newBand,
        elevation: 1,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('id: ${band.id}');
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Text('Delete Band', style: TextStyle(color: Colors.white))),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  newBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      //Android
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New band name'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                    child: Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textController.text))
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text("New band name"),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Add'),
                  isDefaultAction: true,
                  onPressed: () => addBandToList(textController.text)),
              CupertinoDialogAction(
                  child: Text('Dismiss'),
                  isDefaultAction: true,
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 0) {
      this
          .bans
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));

      setState(() {});
    }

    Navigator.pop(context);
  }
}
