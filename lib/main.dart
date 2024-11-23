import 'package:flutter/material.dart';
import 'about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brandtnerhof',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Brandtnerhof Waidring'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[AboutWidget()],
      ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Image.asset('assets/brandtnerhof_logo.gif'),
            Container(
                child: Text(
              'Willkommen auf dem Brandtnerhof',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            )),
            // buildWebcamButtons(),
            // buildTemperatureGalleryButtons(),
            // buildAppartmentButtons(),
            // buildRoomButtons(),
            // buildBookingButtons(),
            buildContactInformation(),
          ],
        ));
  }

  Container buildContactInformation() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Kontakt:\n',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: <Widget>[
                Text(
                  'Elisabeth und\nDieter Jungvogel\nStrub 14\nA-6384 Waidring\n'
                  'Österreich',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () {} //=> android_intent.Intent()
                  //   ..setAction(android_action.Action.ACTION_VIEW)
                  //   ..setData(Uri(
                  //       scheme: 'geo',
                  //       path: '47.58222,12.62509',
                  //       queryParameters: {'z': '18'}))
                  //   ..startActivity(),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Tel.: +43 5353 5427',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () {} // => android_intent.Intent()
                  //   ..setAction(android_action.Action.ACTION_DIAL)
                  //   ..setData(Uri(scheme: 'tel', path: '+43 5353 5427'))
                  //   ..startActivity(),
                ),
              ],
            ),
            Text(
              'Fax.: +43 5353 54273',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: <Widget>[
                Text(
                  'Email: office@brandtnerhof.at',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.mail),
                  onPressed: () {} //=> android_intent.Intent()
                  //   ..setAction(android_action.Action.ACTION_SEND)
                  //   ..setType("message/rfc822")
                  //   ..putExtra(Extra.EXTRA_EMAIL, ["office@brandtnerhof.at"])
                  //   ..putExtra(
                  //       Extra.EXTRA_SUBJECT, "Anfrage über Brandtnerhof App")
                  //   ..startActivity(),
                ),
              ],
            ),
          ],
        ));
  }

}
