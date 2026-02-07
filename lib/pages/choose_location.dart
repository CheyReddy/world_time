import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(location: 'London', flag: 'london.png', url: 'Europe/London'),
    WorldTime(location: 'Chicago', flag: 'chicago.png', url: 'America/Chicago'),
    WorldTime(location: 'Japan', flag: 'tokyo.png', url: 'Asia/Tokyo'),
    WorldTime(location: 'Egypt', flag: 'egypt.png', url: 'Egypt'),
    WorldTime(location: 'Indonesia', flag: 'jakarta.png', url: 'Asia/Jakarta'),
    WorldTime(location: 'India', flag: 'india.png', url: 'Asia/Kolkata'),
    WorldTime(location: 'Nairobi', flag: 'nairobi.png', url: 'Africa/Nairobi'),
    WorldTime(location: 'Korea', flag: 'seoul.png', url: 'Asia/Seoul'),
    WorldTime(location: 'Australia', flag: 'sydney.png', url: 'Australia/Sydney'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
