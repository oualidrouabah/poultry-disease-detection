import 'package:djaaja_siha/langage_constant.dart';
import 'package:flutter/material.dart';

class ChangeInformationScreen extends StatefulWidget {
  final String? title;
  final String? content;
  const ChangeInformationScreen({super.key, this.title, this.content});

  @override
  State<ChangeInformationScreen> createState() => _ChangeInformationScreenState();
}

class _ChangeInformationScreenState extends State<ChangeInformationScreen> {
  String? _title;

  final TextEditingController _textFieldController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _title=widget.title;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [
              Color.fromARGB(31, 255, 255, 255),
              Color.fromARGB(38, 0, 238, 107)
            ], // red to yellow
            tileMode: TileMode.mirror, // repeats the gradient over the canvas
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    icon:const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.sentiment_satisfied_alt, size: 55, color: Colors.yellow),
              ),
              const SizedBox(height: 20),
              Text(
                translation(context).hello,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                translation(context).enternew,
                style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                  controller: _textFieldController,
                  cursorColor: Theme.of(context).primaryColor,
                  style:TextStyle(color: Theme.of(context).primaryColor),
                  decoration: InputDecoration(
                    hintStyle:TextStyle(color: Theme.of(context).primaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
                    ),
                    prefixIconColor: WidgetStateColor.resolveWith((states) =>
                            states.contains(WidgetState.focused)
                            ? Theme.of(context).primaryColor
                            : Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                    ),
                    labelText: _title,
                    labelStyle:TextStyle(
                      color:  Theme.of(context).primaryColor,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1), 
                    ),
                  ),
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  print('change $_title');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize:const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
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