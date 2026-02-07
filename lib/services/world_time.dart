import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time="";
  String flag;
  String url;
  bool isDayTime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    try {
      Response response = await get(
        Uri.parse('https://timeapi.io/api/v1/timezone/zone?timeZone=$url'),
        headers: {"Accept": "application/json"},
      );
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        String datetime = data['local_time'];
        String offset = data['standard_utc_offset_seconds'].toString();


        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(seconds: int.parse(offset)));

        isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
        time = DateFormat.jm().format(now);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch time: $e');
      time = 'Could not get time data';
    }
  }

  @override
  String toString(){
    return 'location: $location, flag: $flag, time: $time, isDayTime: $isDayTime';
  }

}