import 'package:crypt/decryptScreen.dart';
import 'package:crypt/encryptscreen.dart';
import 'package:crypt/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Helper>(create: (_) => Helper()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF192734),
          accentColor: Colors.greenAccent,
          primaryColor: Color(0xFF15202A),
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crypty Crypt'),
          centerTitle: true,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.blueGrey,
            tabs: [
              Text('Encrypt'),
              Text('Decrypt'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: EncryptScreen()),
            Center(child: DecryptScreen()),
          ],
        ),
      ),
    );
  }
}
