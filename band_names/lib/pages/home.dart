import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = new TextEditingController();
  List<Band> bands = [
    Band(id: '1', name: 'Guns and Roses', votes: 18),
    Band(id: '2', name: 'Aerosmith', votes: 10),
    Band(id: '3', name: 'Nirvana', votes: 11),
    Band(id: '4', name: 'Roxette', votes: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames'),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBands,
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) {
          Band banda = bands[i];
          return _listTileBand(banda);
        },
      ),
    );
  }

  Widget _listTileBand(Band banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (deleted) {
        print('eliminado banda');
      },
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(banda.name.substring(0, 1)),
        ),
        title: Text(banda.name),
        trailing: Text(banda.votes.toString()),
      ),
    );
  }

  addNewBands() {
    (!Platform.isAndroid)
        ? showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  MaterialButton(
                    onPressed: () => addBandToList(controller.text),
                    child: Text('Save Band'),
                    color: Colors.black,
                  )
                ],
                title: Text('Insert your band name:'),
                content: TextField(
                  controller: controller,
                ),
              );
            })
        : showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => addBandToList(controller.text),
                    child: Text('Save Band'),
                    //color: Colors.black,
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: Text('Back'),
                  )
                ],
                title: Text('Insert your band name:'),
                content: CupertinoTextField(
                  controller: controller,
                ),
              );
            });
  }

  addBandToList(String nameBand) {
    if (nameBand.length > 0) {
      this.bands.add(
          new Band(id: DateTime.now().toString(), name: nameBand, votes: 0));
      setState(() {});
      Navigator.pop(context);
    } else {}
  }
}
