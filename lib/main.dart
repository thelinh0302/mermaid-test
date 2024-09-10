import 'package:flutter/material.dart';
import 'dart:html';

import 'package:markdown/markdown.dart' as md;
import 'package:mermaid/mermaid.dart';

const String mermaidExample = """
[Class Diagram](http://mermaid-js.github.io/mermaid/#/./classDiagram)
----
```mermaid
erDiagram
    USER {
  int UserID
  string Role
}

TENANT {
  int TenantID
}

FAN {
  int FanID
}

CREATOR {
  int CreatorID
}

ESCROW_RULES {
  int RuleID
}

WALLET {
  int WalletID
}

CONTENT_REQUEST {
  int RequestID
}

CONTENT {
  int ContentID
}

PAYMENT {
  int PaymentID
}

IDENTITY_PROVIDER {
  int ProviderID
}

BLOCKCHAIN_TRANSACTION {
  int TransactionID
}

USER ||--o{ TENANT : "is a"
USER ||--o{ FAN : "is a"
USER ||--o{ CREATOR : "is a"

TENANT ||--o{ ESCROW_RULES : "sets up"
USER ||--|| IDENTITY_PROVIDER : "uses"
USER ||--|| WALLET : "has"
FAN ||--o{ CONTENT_REQUEST : "makes"
CONTENT_REQUEST ||--|| CONTENT : "produces"
CREATOR ||--o{ CONTENT : "uploads"
FAN ||--o{ PAYMENT : "makes"

PAYMENT ||--o| BLOCKCHAIN_TRANSACTION : "includes"
CONTENT ||--o{ FAN : "delivers to"
```
""";

final nullSanitizer_SVGCantBeInsertedWithoutIt = NullTreeSanitizer();

void main() {
  MermaidApi.initialize(Config(
    securityLevel: SecurityLevel.Strict,
    // theme: Theme.Forest,
    logLevel: LogLevel.Error,
    startOnLoad: false,
    arrowMarkerAbsolute: true,
    flowchart: FlowChartConfig(htmlLabels: true),
    sequence: SequenceDiagramConfig(),
    gnatt: GnattConfig(),
  ));

  final htmlDiv = document.getElementById('html');

  htmlDiv?.setInnerHtml(
    md.markdownToHtml(
      mermaidExample,
      extensionSet: md.ExtensionSet.gitHubWeb,
    ),
    treeSanitizer: nullSanitizer_SVGCantBeInsertedWithoutIt,
  );

  mermaidRender(htmlDiv?.querySelectorAll('code.language-mermaid'));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // backgroundColor: ,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  @override
  void sanitizeTree(Node node) {}
}
