// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/semantics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HealthKeeper',
        theme: new ThemeData(
          primaryColor: Colors.white,
        ),
        home: Scaffold(
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
                onPressed: () {},
                child:
                    const Text('Pair Sensor', style: TextStyle(fontSize: 20)),
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
        ));
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: <Widget>[
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildSuggestions());
  }

  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final List<Widget> divided = ListTile.divideTiles(
        tiles: tiles,
        context: context,
      ).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }
}
