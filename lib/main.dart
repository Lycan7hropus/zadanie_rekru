import 'dart:developer';
import 'result.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final _textEditingController = TextEditingController();
  String _message = "";


  void navigateToResult(int result) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Result(result: result)),
    );
  }

  void _submitText() {
    setErrorMessage("");
    String text = _textEditingController.text;
    try {
      int result = findOutlier(_splitText(text));
      navigateToResult(result);
    } catch (e) {
      setErrorMessage(e.toString());
    }
  }

  int findOutlier(List<int> numbers) {
    //https://zetcode.com/dart/filter-list/
    int evenCount = numbers.where((number) {
      return number.isEven;
    }).length;
    int oddCount = numbers.length - evenCount;
    int outlier = 0;

    if (evenCount == 1 || oddCount == 1) {
      if (evenCount == 1) {
        for (int i = 0; i < numbers.length; i++) {
          if (numbers[i].isEven) {
            outlier = numbers[i];
            break;
          }
        }
      } else {
        for (int i = 0; i < numbers.length; i++) {
          if (numbers[i].isOdd) {
            outlier = numbers[i];
            break;
          }
        }
      }
    } else if (evenCount == 0 || oddCount == 0) {
      throw ArgumentError('The input array does not contain any outliers.');
    } else {
      throw ArgumentError('The input array contains multiple outliers.');
    }

    return outlier;
  }

  void setErrorMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  List<int> _splitText(String text) {
    if (text == null || text.isEmpty) {
      setErrorMessage('Input text cannot be null or empty.');
      throw ArgumentError('Input text cannot be null or empty.');
    }

    List<String> splitList = text.split(',');
    List<int> result = [];

    for (var item in splitList) {
      String trimmedItem = item.trim();
      if (trimmedItem.isNotEmpty) {
        if (int.tryParse(trimmedItem) == null) {
          setErrorMessage('Input text must contain only integer values.');
          throw ArgumentError('Input text must contain only integer values.');
        }
        result.add(int.parse(trimmedItem));
      }
    }

    if (result.isEmpty) {
      setErrorMessage('Input text does not contain any valid elements.');
      throw ArgumentError('Input text does not contain any valid elements.');
    }

    return result;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Enter some text',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _submitText,
                    child: const Text('Submit'),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
