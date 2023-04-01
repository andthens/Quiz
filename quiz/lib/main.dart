import 'package:flutter/material.dart';
import 'Custom/Landing.dart';
import 'Custom/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Quiz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      
        title: Text(widget.title),
      ),
      body: LoginScreen(),
        
      //    Column(
          
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       const Text(
      //         'Welcome to the Quiz',
      //       ),
      //       const Text('Instructions'),
      //      FloatingActionButton(onPressed: Navigator.push(
      //                                       context,
      //                                       MaterialPageRoute(
      //                                           builder: (context) =>
      //                                              landing())););
      //     ],
       
      // ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
