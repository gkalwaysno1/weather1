import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //print(getFullName('Foo', 'Bar'));
    //test();
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var temp;
  var description;
  var currenty;
  var humidity;
  var windSpeed;

  Future Getweather () async{
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=980df60f9d48ff866d91fbde2a06bae1"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currenty = results['weather'][0]['main'];
      this.windSpeed = results['wind']['speed'];
      this.humidity= results['main']['humidity'];

    });

  }

  @override
  void initState () {
    super.initState();
    this.Getweather();
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
          title: const Text("Weather Report Card")
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            color: Colors.lightBlueAccent,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding
                  (
                  padding: EdgeInsets.only(bottom: 11.0),
                  child: Text(
                    "Current Condition of Bangalore",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 30,
                        fontWeight: FontWeight.w400
                    ),

                  ) ,

                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0 F" : "Loading....",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.6,
                      fontWeight: FontWeight.w700
                  ),


                ),
                Padding
                  (
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currenty != null ? currenty.toString() : "Loading....",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30.6,
                        fontWeight: FontWeight.w200
                    ),

                  ) ,
                )



              ],
            ),



          ),
          Expanded(

              child: Padding(
                padding: EdgeInsets.all(25.6),
                child: ListView(
                  children: [


                    ListTile(
                      title: Text("Humidity (in g/m3)"),
                      trailing: Text(humidity != null ? humidity.toString() : "Loading.."),
                    ),
                    ListTile(
                      title: Text("Clouds"),
                      trailing: Text(description != null ? description.toString() : "Loading.."),
                    ),
                    ListTile(
                      title: Text("Temperature (In Farhenheit)"),
                      trailing: Text(temp != null ? temp.toString() + "\u00B0 F" : "Loading.."),
                    ),
                    ListTile(
                      title: Text("Wind Speed (In knots)"),
                      trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading.."),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}


Future apicall() async{
  final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=57&lon=-2.15&appid=980df60f9d48ff866d91fbde2a06bae1");
  final response = await http.get(url);
  //print(response.body);

  final json = jsonDecode(response.body);
  //print(json['weather'][0]['description']);
  //return (json['weather'][0]['temp']);
  //return "hello";
  final output = {
    'description' : json['weather'][0]['description'],
    'temp' : json['weather'][1]['description']

  };

  return output;
  //final data = ;
}