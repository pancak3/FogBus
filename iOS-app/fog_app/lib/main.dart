// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fijkplayer/fijkplayer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthKeeper',
      // routes: {'/Player': (context) => Player()},
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  final cameraProtocolController = TextEditingController();
  final cameraAddrController = TextEditingController();
  final cameraPortController = TextEditingController();
  final cameraUsernameController = TextEditingController();
  final cameraPasswordController = TextEditingController();
  final masterIPController = TextEditingController();
  final FijkPlayer player = FijkPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FogBus App Sample"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Welcome to FogBus",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "This is a sample using Fog network",
            ),
          ),
          const SizedBox(height: 20),

          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Enter Your Security Camera Info: ",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: 300,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      autofocus: true,
                      controller: cameraProtocolController,
                      decoration: InputDecoration(
                        labelText: "Protocol",
                        hintText: "Protocol",
                        // icon: Icon(Icons.person)
                      ),
                      validator: (v) {
                        return v.trim().length > 0
                            ? null
                            : "Protocol cannot be empty";
                      }),
                  TextFormField(
                      controller: cameraAddrController,
                      decoration: InputDecoration(
                        labelText: "Address",
                        hintText: "Address",
                      ),
                      // obscureText: true,
                      validator: (v) {
                        return v.trim().length > 0
                            ? null
                            : "Address cannot be empty";
                      }),
                  TextFormField(
                      controller: cameraPortController,
                      decoration: InputDecoration(
                        labelText: "Port",
                        hintText: "Port",
                      ),
                      // obscureText: true,
                      validator: (v) {
                        return v.trim().length > 0
                            ? null
                            : "Port cannot be empty";
                      }),
                  TextFormField(
                      controller: cameraUsernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Username",
                      ),
                      // obscureText: true,
                      validator: (v) {
                        return v.trim().length > 0
                            ? null
                            : "Username cannot be empty";
                      }),
                  TextFormField(
                      controller: cameraPasswordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Password",
                      ),
                      // obscureText: true,
                      validator: (v) {
                        return v.trim().length > 0
                            ? null
                            : "Password cannot be empty";
                      }),
                ],
              )),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                return new Player(
                    cameraProtocolController.text,
                    cameraAddrController.text,
                    cameraPortController.text,
                    cameraUsernameController.text,
                    cameraPasswordController.text);
              }));
              // Navigator.of(context).pushNamed("/Player",
              //     arguments: Args(
              //         cameraAddrController.text, cameraAddrController.text));
            },
            child: const Text('Connect', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 40),
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
              controller: masterIPController,
            ),
          ),
          // const SizedBox(height: 30),
          RaisedButton(
            onPressed: () {
              // final url = myController.text;
              final url = "http://" +
                  masterIPController.text +
                  "/HealthKeeper/RPi/Master/";
              print(url);
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                return new Browser(
                  url: url,
                  title: "Fog Master",
                );
              }));
            },
            child: const Text('Connect', style: TextStyle(fontSize: 20)),
          ),
          // const SizedBox(height: 40),
          // FlatButton(
          //   onPressed: () {
          //     /*...*/
          //   },
          //   child: Text(
          //     "Remove all saved devices",
          //   ),
          // ),
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
    content: Text("Paired with Virtual Device."),
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

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session of Virtual Device"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class Browser extends StatelessWidget {
  const Browser({Key key, this.url, this.title}) : super(key: key);

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

class Player extends StatefulWidget {
  final String protocol;
  final String addr;
  final String port;
  final String username;
  final String password;
  Player(this.protocol, this.addr, this.port, this.username, this.password);
  @override
  State<StatefulWidget> createState() {
    return _Player();
  }
}

class _Player extends State<Player> {
  final FijkPlayer player = FijkPlayer();
  @override
  void initState() {
    super.initState();
    // rtsp://camera:pw12345678@192.168.88.227:554/Streaming/Channels/101
    String url = widget.protocol +
        "://" +
        widget.username +
        ":" +
        widget.password +
        "@" +
        widget.addr +
        ":" +
        widget.port +
        "/Streaming/Channels/101";

    player.setDataSource(url, autoPlay: true);
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Security Camera"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FijkView(player: player),
      ),
    );
  }
}
