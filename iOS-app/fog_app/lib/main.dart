// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthKeeper',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HealthKeeper"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Welcome to",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "HealthKeeper",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Your health manager using Fog network",
            ),
          ),
          const SizedBox(height: 70),
          RaisedButton(
            onPressed: () {
              showAlertDialog(context);
            },
            child: const Text('Pair Sensor', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 70),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Enter address of Master: ",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            width: 200,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: 'Master Address'),
            ),
          ),
          // const SizedBox(height: 30),
          RaisedButton(
            onPressed: () {},
            child: const Text('Connect', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 80),
          FlatButton(
            onPressed: () {
              /*...*/
            },
            child: Text(
              "Remove all saved devices",
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              "Developed by CLOUDS Lab",
            ),
          ),
        ],
      )),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context, true),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Success!"),
    content: Text("Connected to Virtual Device."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
