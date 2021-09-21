import 'package:flutter/material.dart';

void main() {
  var animal = new Animal(true, true, false);
  print(animal.isSimilar(isFlying: true, isSwimming: true, isRunning: false));

  var animal2 = new Animal(null, true, false);
  print("Animal is flying: ${animal2.isFlying}");
  print("Animal is running: ${animal2.isRunning}");

  animal2.setUndefinedValues(true, true, true);
  print("Animal is flying: ${animal2.isFlying}");
  print("Animal is running: ${animal2.isRunning}");

  var superDog = new SuperDog("white", 50, 1500);
  print("SuperDog is faster: ${(superDog.createSpeedComparator())(10)}");

  var lst = [animal, animal2, superDog];
  print("MyList is empty: ${lst.isEmpty}");
  print("MyList length: ${lst.length}");
  lst[2] = new Animal(null, null, false);
  for(int i = 0; i < lst.length; i++) {
    print("Is flying: ${lst[i].isFlying}  " +
          "Is swimming: ${lst[i].isSwimming}  " +
          "Is running: ${lst[i].isRunning}  ");
  }
  var cat = new Cat("White");
  var cat2 = new Cat("White");
  assert(cat == cat2);
  print("Assertion true");
  runApp(MyApp());
  assert(!superDog.isStronger(15));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Vitalii Hryban'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class Animal {
  bool? _isFlying;
  bool? _isSwimming;
  bool? _isRunning;

  Animal(this._isFlying, this._isSwimming, this._isRunning);

  Animal.origin(this._isFlying, this._isSwimming, this._isRunning);

  bool get isFlying => _isFlying ?? false;

  set isFlying(bool? flying) => _isFlying = flying ?? false;

  bool get isSwimming => _isSwimming ?? false;

  set isSwimming(bool? swimming) => _isSwimming = swimming ?? false;

  bool get isRunning => _isRunning ?? false;

  set isRunning(bool? running) => _isRunning = running ?? false;

  bool isSimilar({bool isFlying: false, bool isSwimming: false, bool isRunning: false}) {
    return (_isFlying == isFlying) && (_isSwimming == isSwimming) &&
        (_isRunning == isRunning);
  }

  void setUndefinedValues(bool isFlying, bool isSwimming, bool isRunning) {
    _isFlying ??= isFlying;
    _isSwimming ??= isSwimming;
    _isRunning ??= isRunning;
  }

}

class Dog extends Animal {
  String color;
  int speed;
  Dog(String color, int speed) : color = color,
                                 speed = speed,
                                 super(false, false, true);

  Function createSpeedComparator() {
    bool comparator(int speed) {
      return this.speed > speed;
    }
    return comparator;
  }

}

class Cat extends Animal {
  String color;

  static Map<String, Cat> cache = new Map<String, Cat>();

  Cat.create(String color) : color = color, super(false, false, true);

  factory Cat(String color, {bool checkCache: true}) {
    if(cache.containsKey(color)) {
      return cache[color] ?? new Cat.create("black");
    } else {
      Cat cat = new Cat.create(color);
      cache[color] = cat;
      return cat;
    }
  }

}

class SuperDog extends Dog with Superman {
  SuperDog(String color, int speed, int power): super(color, speed) {
    this.power = power;
  }
}

mixin Superman {
  int power = 1000;

  bool isStronger(int power) {
    return this.power > power;
  }
}