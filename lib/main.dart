import 'package:flutter/material.dart' show AppBar, Border, BoxDecoration, BuildContext, Center, Colors, Column, Container, EdgeInsets, FloatingActionButton, Icon, Icons, Key, MainAxisAlignment, MaterialApp, Scaffold, SizedBox, State, StatefulWidget, StatelessWidget, Text, Theme, ThemeData, Widget, runApp;
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'dart:math' show Random;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
      var titulo = 'Chave do Euromilhões';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
        return MaterialApp(
          title: titulo,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: titulo),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> numbers = new List(5);
  List<int> stars = new List(2);
  var rng = new Random();
  int maxStars = 12;
  int maxNumbers = 50;

  void _generateNumbersAndStars() {
    setState(() {
      numbers[0] = 1 + rng.nextInt(maxNumbers);
      numbers[1] = 1 + rng.nextInt(maxNumbers);
      numbers[2] = 1 + rng.nextInt(maxNumbers);
      numbers[3] = 1 + rng.nextInt(maxNumbers);
      numbers[4] = 1 + rng.nextInt(maxNumbers);
      stars[0] = 1 + rng.nextInt(maxStars);
      stars[1] = 1 + rng.nextInt(maxStars);
    });

//Find and replace same numbers
    for (var i = 0; i < numbers.length; i++) {
      while (numbers.indexOf(numbers[i]) < i) {
        numbers[i] = 1 + rng.nextInt(maxNumbers);
      }
    }
    numbers.sort();

//Find and replace same stars
    for (var i = 0; i < stars.length; i++) {
      while (stars.indexOf(stars[i]) < i) {
        stars[i] = 1 + rng.nextInt(maxStars);
      }
    }
    stars.sort();
  }

  @override
  Widget build(BuildContext context) {
        var labelGerados = 'Números gerados:';
        return Scaffold(
          //Render
          backgroundColor: Colors.lightGreen,
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            backgroundColor: Colors.green,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.all(5.0),
                  width: 500.0,
                  child: Text(
                    labelGerados,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              width: 550.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3)),
              child: Text(
                _getNumbersText(),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(5.0),
              width: 500.0,
              child: Text(
                'Estrelas geradas:',
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            new Container(
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 20.0),
              padding: const EdgeInsets.all(10.0),
              width: 550.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3)),
              child: Text(
                _getStarsText(),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
              child: SizedBox(
                width: 150.0,
                height: 150.0,
                child: FloatingActionButton(
                  onPressed: _generateNumbersAndStars,
                  tooltip: 'Sorte',
                  backgroundColor: Colors.amber,
                  child:
                      Icon(Icons.euro_symbol, color: Colors.grey, size: 100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getNumbersText() {
    if (numbers[0] != null) {
      return '${numbers[0]} - ${numbers[1]} - ${numbers[2]} - ${numbers[3]} - ${numbers[4]}';
    } else {
      return 'Premir € para gerar';
    }
  }

  String _getStarsText() {
    if (stars[0] != null) {
      return '${stars[0]} - ${stars[1]} ';
    } else {
      return 'Premir € para gerar';
    }
  }
}
