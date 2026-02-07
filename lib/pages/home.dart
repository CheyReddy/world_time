import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;

    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color fontColor = data['isDayTime'] ? Colors.black : Colors.white;
    Color? bgColor = data['isDayTime'] ? Colors.grey : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                Center(
                  child: TextButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'isDayTime': result['isDayTime'],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: fontColor,
                      size: 20.0,
                    ),
                    label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: fontColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
