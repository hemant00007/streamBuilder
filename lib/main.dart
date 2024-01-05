import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        primarySwatch: Colors.green, // Set the app's primary theme color to green
      ),
      title: 'StreamBuilder Example',
      home: NumberStreamPage(),
    );
  }
}

class NumberStreamPage extends StatefulWidget {
  @override
  _NumberStreamPageState createState() => _NumberStreamPageState();
}

class _NumberStreamPageState extends State<NumberStreamPage> {
  late StreamController<int> _numberStreamController;

  @override
  void initState() {
    super.initState();

    // Create a stream controller and add numbers to the stream.
    _numberStreamController = StreamController<int>();
    _startAddingNumbers(); // Start adding numbers to the stream.
  }

  void _startAddingNumbers() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 2)); // Delay for 2 seconds.
      _numberStreamController.sink.add(i); // Add the number to the stream.
    }
  }

  @override
  void dispose() {
    _numberStreamController.close(); // Close the stream when disposing.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamBuilder Example'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _numberStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Display a loading indicator when waiting for data.
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Display an error message if an error occurs.
            } else if (!snapshot.hasData) {
              return Text('No data available'); // Display a message when no data is available.
            } else {
              return Text(
                'Latest Number: ${snapshot.data}',
                style: TextStyle(fontSize: 24),
              ); // Display the latest number when data is available.
            }
          },
        ),
      ),
    );
  }
}