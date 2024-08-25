import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Temperature Conversion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// const List<String> units = ['Celsius', 'Fahrenheit', 'Kelvin'];

enum Units{
  celsius('Celsius', '°C'),
  fahrenheit('Fahrenheit', '°F'),
  kelvin('Kelvin', 'K');

  const Units(this.name, this.symbol);
  final String name;
  final String symbol;
}

class _MyHomePageState extends State<MyHomePage> {
  final numberController1 = TextEditingController();
  final numberController2 = TextEditingController();
  late Units selectedUnit1 = Units.celsius;
  late Units selectedUnit2 = Units.fahrenheit;


  double _temperatureCtoF(double input){
    return input * (9/5) + 32;
  }
  double _temperatureFtoC(double input){
    return (input - 32) * (5/9);
  }
  double _temperatureCtoK(double input){
    return input + 273.15;
  }
  double _temperatureKtoC(double input){
    return input - 273.15;
  }
  double _temperatureFtoK(double input){
    return (input - 32) * (5/9) + 273.15;
  }
  double _temperatureKtoF(double input){
    return (input - 273.15) * (9/5) + 32;
  }

  double _temperatureConverter(double input, Units unitIn, Units unitOut){
    switch (unitIn){
      case Units.celsius:
        switch (unitOut) {
          case Units.celsius:
            return input;
          case Units.fahrenheit:
            return _temperatureCtoF(input);
          case Units.kelvin:
            return _temperatureCtoK(input);
        }
      case Units.fahrenheit:
        switch (unitOut) {
          case Units.celsius:
            return _temperatureFtoC(input);
          case Units.fahrenheit:
            return input;
          case Units.kelvin:
            return _temperatureFtoK(input);
        }
      case Units.kelvin:
        switch (unitOut) {
          case Units.celsius:
            return _temperatureKtoC(input);
          case Units.fahrenheit:
            return _temperatureKtoF(input);
          case Units.kelvin:
            return input;
        }
    }
  }

  void _textChanger1(){
    numberController2.text = _temperatureConverter(double.parse(numberController1.text), selectedUnit1, selectedUnit2).toString();
  }
  void _textChanger2(){
    numberController1.text = _temperatureConverter(double.parse(numberController2.text), selectedUnit2, selectedUnit1).toString();
  }


  @override
  void initState(){
    super.initState();
    // numberController1.addListener(_textChanger1);
    // numberController2.addListener(_textChanger2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 100, top: 8, right: 8, left: 8),
              child: Row(
              children: <Widget>[
                Expanded(child: TextField(
                  controller: numberController1,
                  onChanged: (_) => _textChanger1(),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(child: DropdownMenu<Units>(
                    dropdownMenuEntries: Units.values
                        .map<DropdownMenuEntry<Units>>(
                            (Units unit) {
                          return DropdownMenuEntry<Units>(
                            value: unit,
                            label: unit.name,
                          );
                        }).toList(),
                    initialSelection: Units.celsius,
                    label: const Text('Unit'),
                    onSelected: (unit) {
                      setState(() {
                        selectedUnit1 = unit!;
                        _textChanger1();
                      });},
                      )
                  ),
                ),
              ]),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: TextField(
                    controller: numberController2,
                    onChanged: (text) => _textChanger2(),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(child: DropdownMenu<Units>(
                      dropdownMenuEntries: Units.values
                          .map<DropdownMenuEntry<Units>>(
                              (Units unit) {
                            return DropdownMenuEntry<Units>(
                              value: unit,
                              label: unit.name,
                            );
                          }).toList(),
                      initialSelection: Units.fahrenheit,
                      label: const Text('Unit'),
                      onSelected: (unit) {
                        setState(() {
                        selectedUnit2 = unit!;
                        _textChanger2();
                        });
                      },

                    )
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
