import 'package:android_intent_plus/android_intent.dart';
import 'package:brandtnerhof/zimmerview.dart';
import 'package:flutter/material.dart';
import 'webcam.dart';
import 'gallery.dart';
import 'temperature.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade700),
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
          actions: <Widget>[const AboutWidget()],
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Image.asset('assets/brandtnerhof_logo.gif'),
            const Text(
              'Willkommen auf dem Brandtnerhof',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            buildWebcamButtons(),
            buildTemperatureGalleryButtons(),
            buildAppartmentButtons(),
            buildBookingButtons(),
            buildContactInformation(),
          ],
        ));
  }

  Container buildContactInformation() {
    const double fonstsize = 18;
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Kontakt:\n',
              style: TextStyle(fontSize: fonstsize),
            ),
            Row(
              children: <Widget>[
                const Text(
                  'Elisabeth und\nDieter Jungvogel\nStrub 14\nA-6384 Waidring\n'
                  'Österreich',
                  style: TextStyle(fontSize: fonstsize),
                ),
                IconButton(
                    icon: const Icon(Icons.map),
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
                const Text(
                  'Tel.: +43 5353 5427',
                  style: TextStyle(fontSize: fonstsize),
                ),
                IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () {
                      AndroidIntent intent = AndroidIntent(
                        action: 'action_view',
                        data: Uri(scheme: 'tel', path: '+43 5353 5427')
                            .toString(),
                      );
                      intent.launch();
                    }),
              ],
            ),
            const Text(
              'Fax.: +43 5353 54273',
              style: TextStyle(fontSize: fonstsize),
            ),
            Row(
              children: <Widget>[
                const Text(
                  'Email: office@brandtnerhof.at',
                  style: TextStyle(fontSize: fonstsize),
                ),
                IconButton(
                    icon: const Icon(Icons.mail), onPressed: () => openMail()),
              ],
            ),
          ],
        ));
  }

  openMail() {
    const intent = AndroidIntent(
      action: 'android.intent.action.SEND',
      arguments: {
        'android.intent.extra.SUBJECT': "Anfrage über Brandtnerhof App"
      },
      arrayArguments: {
        'android.intent.extra.EMAIL': ["office@brandtnerhof.at"],
      },
      type: 'message/rfc822',
    );
    intent.launch();
  }

  buildAppartmentButtons() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text('Übersicht Appartments'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildRoomButton('Waidring'),
              buildRoomButton('Lofer'),
              buildRoomButton('Penthouse'),
            ],
          ),
        ],
      ),
    );
  }

  buildWebcamButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          const Text('Webcams'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildWebcamButton('Berg', WebcamSelection.berg),
              buildWebcamButton('Tal', WebcamSelection.tal),
              buildWebcamButton('Tal Panorama', WebcamSelection.pantal),
              buildWebcamButton('Felsen', WebcamSelection.felsen),
            ],
          ),
        ],
      ),
    );
  }

  buildWebcamButton(String buttonText, WebcamSelection selection) {
    return TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Webcam(selection: selection),
              settings: RouteSettings(
                arguments: selection,
              ),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            const Icon(
              Icons.videocam,
              size: 40,
            ),
            Text(buttonText)
          ],
        ));
  }

  buildTemperatureGalleryButtons() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildGalleryButton(),
              buildTemperatureButton(),
            ],
          ),
        ],
      ),
    );
  }

  buildGalleryButton() {
    return TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageGallery(),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Icon(
              Icons.collections,
              size: 40,
            ),
            Text('Bildergalerie')
          ],
        ));
  }

  buildTemperatureButton() {
    return TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemperatureView(),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Icon(
              Icons.equalizer,
              size: 40,
            ),
            Text('Temperatur\n(letzte 24h)')
          ],
        ));
  }

  buildRoomButton(String roomName) {
    return TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ZimmerView(roomName: roomName),
              settings: RouteSettings(
                arguments: roomName,
              ),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Icon(
              Icons.home,
              size: 40,
            ),
            Text(roomName)
          ],
        ));
  }

  buildBookingButtons() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text('Buchungsmöglichkeit'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildAvailabilityButton(),
              buildBookingButtonBrowser(),
            ],
          ),
        ],
      ),
    );
  }

  buildBookingButtonBrowser() {
    return TextButton(
      style: TextButton.styleFrom(foregroundColor: Colors.black),
      onPressed: () => openBookingLink(),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            size: 40,
          ),
          Text('Wohnung\nbuchen')
        ],
      ),
    );
  }

  void openBookingLink() {
    final intent = AndroidIntent(
        action: 'action_view',
        data: Uri(
            scheme: "https",
            path:
                "//web4.deskline.net/accommodationpillerseetal/de/accommodation/detail/PIL/e6559a02-6427-45ea-94ae-553a7f630cf6/Brandtnerhof__Betriebe",
            queryParameters: {
              "lkcs": "W5427",
              "customToolboxHide": "true"
            }).toString(),
        package: 'com.android.chrome');
    intent.launch();
  }

  buildAvailabilityButton() {
    return TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => FeratelView(),
          //     settings: RouteSettings(
          //       arguments: FeratelPage.verfuegbarkeit,
          //     ),
          //   ),
          // );
        },
        child: Column(
          children: <Widget>[
            Icon(
              Icons.event,
              size: 40,
            ),
            Text('Verfügbarkeit\nanzeigen')
          ],
        ));
  }
}
