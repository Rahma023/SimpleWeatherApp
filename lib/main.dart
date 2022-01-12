import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart';
//import 'lib.dart';
void main() => runApp(
  const MaterialApp(
    title: "Weather App",
    home: Home(),
  )
);


class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }
}

class _HomeState extends State<Home>{
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  var http;

  Future getWeather() async{
    var response= await http.get("https://api.openweathermap.org/data/2.5/weather?q=Boston&units=emperialappid=d7e2851e1a7b016a08418e5a363c7615");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  } 


@override
void iniState(){
  super.initState();
  this.getWeather();
}
  @override
  Widget build(BuildContext context){
     var FontAwesomeIcons;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width, 
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:const <Widget> [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Boston",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),

                  ),

                ),
                 Text(
                   //temp!=null? temp.toString()+ "\u00B0":"Loading",
                "52\u00B0",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 40.0,
                   fontWeight: FontWeight.w600,
                 ),
                 ),

                 Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                   // currently !=null ? currently.toString():"Loading",
                   "Rain",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),

                  ),

                )
              ],
              ),

          ),
          Expanded(
            
         //  child: padding(
              child: ListView(
                children: <Widget>[
                  ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerFull),
                    title: const Text("Temperature"),
                    trailing: Text(temp !=null ? temp.toString() + "\u00B0" : "Loading"),
                    
                  ),
                   ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                    title: const Text("weather"),
                    trailing: Text(description != null ? description.toString() : "Loading"),
                    
                  ),
                   ListTile(
                   leading: FaIcon(FontAwesomeIcons.sun), 
                    title: const Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                    
                  ),
                   ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                    title: const Text("Wind Speed"),
                    trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading"),
                    
                  )




                ],),
              //)
            )
          ],
      ),
      
    );
  }
}