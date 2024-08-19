import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  

  final WeatherFactory  _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Pakistan").then((w){
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather API'), backgroundColor: Colors.blue,centerTitle: true,),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(children: [_buildUI()] ),
      )),
    );
  }
   
   Widget _buildUI() {
    if(_weather == null) {
      return  const Center(
        child: CircularProgressIndicator(),
      );
    } return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,        
          children: [
          _locationHeader(),
        
          SizedBox(  height: Get.height * 0.01,  ),
        
            _dateTimeInfo(),
            
          SizedBox(  height: Get.height * 0.01,  ),

          _weatherIcon(),

          SizedBox(  height: Get.height * 0.01,  ),

          _currentTemp(), 

          SizedBox(  height: Get.height * 0.01,  ),

         _extraInfo(),


        ],),
      ),
    );
   }

    Widget _locationHeader(){
      return Text(_weather?.areaName ?? "",
        style: const TextStyle(
          fontWeight: FontWeight.w500, fontSize: 20
        ),
      
      
      );
    }

    Widget _dateTimeInfo(){
      DateTime now = _weather!.date!;
      return Column(
        children: [
          Text(DateFormat("h: mm a").format(now), style: const TextStyle(fontSize: 35),),
        SizedBox(  height: Get.height * 0.03,  ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize:  MainAxisSize.max,
          children: [
          Text(DateFormat("EEEE").format(now), style: const TextStyle(fontSize: 35),),
        SizedBox(  width: Get.width * 0.01,  ),

          Text( '${DateFormat('d.M.y').format(now)}' ,style: const TextStyle(fontSize: 35),),

           
        ],)

        ],
      );
    }

    Widget _weatherIcon(){
      return Column(children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png'))
          ),),
          Text(_weather?.weatherDescription ?? '' , style: const TextStyle(fontSize: 35),)
      ],);
    }

 Widget _currentTemp(){
    return Text('${_weather?.temperature?.celsius?.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 60),);
 }

  Widget _extraInfo(){
     return Container(
      height: 150, width:  Get.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.blue
      ),
      padding: const EdgeInsets.all(8.0) ,
      child:  Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}', style: TextStyle(color: Colors.white, fontSize: 15),),

              Text('Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}', style: TextStyle(color: Colors.white, fontSize: 15),)

          ],),
          SizedBox(
            height: Get.height* 0.02,
          ),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s', style: TextStyle(color: Colors.white, fontSize: 15),),

              Text('Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%', style: TextStyle(color: Colors.white, fontSize: 15),)

          ],)
      ],),
     );

  }
  

}