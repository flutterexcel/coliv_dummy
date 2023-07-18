import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model2.dart';

class MyPopUpPage2 extends StatefulWidget {
  const MyPopUpPage2({super.key});

  @override
  State<MyPopUpPage2> createState() => _MyPopUpPage2State();
}

class Item {
  Item(
      {required this.headerText,
      required this.expandedText,
      required this.isExpanded});
  String headerText;
  String expandedText;
  bool isExpanded;
}

class _MyPopUpPage2State extends State<MyPopUpPage2> {
  @override

  final List<Item> _item =List<Item>.generate(4, (index) {
    return Item(headerText: headerText, expandedText: expandedText, isExpanded: isExpanded);
  });
  int curr = 0;
  bool circular = true;
  late final List<BottomNavigationBarItem> items;
  late PopUpData? data2;
  var token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE0ZWI4YTNiNjgzN2Y2MTU4ZWViNjA3NmU2YThjNDI4YTVmNjJhN2IiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiRXVnZW5pbyBGZXJyYW50ZSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaWlUM2ZRRU9sdUdxdnBNQ0REZ2w5V0xrN2ltckliOTdJZmg3SkxTN0V5dkt1UTJGQ0l0RkxRUjE1R1JHUXVnN2h0Nll0d2FfWWJJRHZEd0x4eXgwbGh2RVRzT3g5NmhkOUZUV1pRTnZRRFIteHYxM3ZuZHVRMXNweGRwampwWVJGdkdhUUgwLWtVTGQteXhLeTFFaEdNdVdVZjZNa2ZjcUJzRFJSUzU0V1oyZEdWeERMUXkzem5YdmZONnQ5SGc3VXdmVlZtVU1OYXI0M1lPaDdaZWJPVFUtTDFUVzlSZjc0aEZlcU0xUFh3dE92OU5uakkyaFR2SkR1RU9SWTdGOENvUEpwVS1jNE5Kd19Qd3Zyc0tjOGpqOWNxbFRNU0lnTHU2QnFMd0NTV1ZWbkRNZFhaVFNMWVlreC01NXJXdnhiZENJXzNiM0Y3WUJxcXhDNmxmLWNzQTBVcWg1ZmdMYkpFSWhsNERGanMzVlpyc3lSVENsbGp4ZlBiRUtqNDkxUU94ZkRjbUl0QUUwT2FzRFdtSzNVYlh5M1o3U2NyT1dIVlNIOEVjX1JZbjhPZ0toT1hOTmhPUE5Ldm1NbVZnWjFIVXhadS0tNDhpem80eDExWU1rMld4eExUZGdJbDVmWHM2X0FIajdYaTBFRW1CeV9QR2p0TmxDQUJJZzBXbjgwQkdsTDBzNFJZaW9KZV9XbVo1MGRZUGZJOGZnS1B6b1N5MWhMM3A0YzZHR0tzZU1KekxSOEpXZGlUbklWZGFLMXowSGpyRl8xMkI1Vi1UN1lJeHVqQUpKQVBpbjRxNDZ4X1JLUm5lc1lVWjRzUG92cWJReXE5NXJla1FxUVcyZEo0eGFOWXpoUVRpWktRQUZBX1dQV2hPU09SMDhWa2ZEYk1TTlFNS0JJa2FCREdjUWdkUWRTUksxMkxfS2FrdHpvLWtvLTFobEcxMGlXMmdXOU5yVmo5SEdyd3dUaEkyX3lOZzN3YUljMTZfWkJsQmJGdWdCZHhNUmg3NlFsZ0gwUjJmQT1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9jb2xpdmhxLWRldiIsImF1ZCI6ImNvbGl2aHEtZGV2IiwiYXV0aF90aW1lIjoxNjg5MDczMDk0LCJ1c2VyX2lkIjoiNWY4VXYzRGtTdlN6aTZmbHZUSTBMU3JjdTgwMiIsInN1YiI6IjVmOFV2M0RrU3ZTemk2Zmx2VEkwTFNyY3U4MDIiLCJpYXQiOjE2ODk2NzEzNDksImV4cCI6MTY4OTY3NDk0OSwiZW1haWwiOiJldWdlbmlvQGNhc2FtaWEuY28iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwNzcwMDI4ODEyODA1NjM5ODAwMyJdLCJlbWFpbCI6WyJldWdlbmlvQGNhc2FtaWEuY28iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.TTULKZiGEBDvSE1kMoar8hI215MlkND2HIBkvcvmdWj9_ZDSF75X9Asdz30H2kJKmO-w00x1sSWyxLQirhKTKD4eYjk2Kf3FdKScz1WMy6zm_ydk_zDD6_ekiNaBKbjQj_PSO9RWLhcVy-YqhTR_Q8Y--iTWevsTGzjWFY8GxPIY3Gg5lAYEFnEU09hyivqBWA8WmEscc1DtH6C6v-JNmxS2fPNOiMe953Z-9Ghre8wmyHm0BbRSpAtJwLPwDeGbtKiDobuSeg2zqkn_qvyNC4N1HrcyIWLwmwfBoj94ny5A6NtGszNyQfLbWIDS0qGalrY6C_Pq4kE0MB0mTRn-Cg";

  Future postData() async {
    try {
      var response = await http.post(
          Uri.parse(
              'https://asia-east2-colivhq-dev.cloudfunctions.net/activityDetails'),
          body: jsonEncode(
            {
              "activityId": "bd9718ab-5a2e-4855-8e02-5c0aafa34da0"
              // "todo": true,
              // "completed": false,
              // "limit": 10,
              // "page": 3,
              // "move": false,
              // "dateTimeZone": "+5:30",
              // "type": "myteam",
              // "dateTimeOrder": true
            },
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      print('done');
      print(response.body);
      setState(() {
        data2 = PopUpData.fromJson(jsonDecode(response.body));
        circular = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    postData();
    print('post data called');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data2!.data.opportunityName),
        actions: [
          Icon(Icons.edit),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.delete)
        ],
      ),
      body: circular
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
              children: [
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.perm_contact_calendar),
                      Column(
                        children: [
                          Text(data2!.data.members[0].preferredName),
                          Text('(' +
                              data2!.data.members[0].memberFirst +
                              " " +
                              data2!.data.members[0].memberLast +
                              ")")
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.home),
                      Column(
                        children: [
                          Text(data2!.data.homeName),
                          Text(data2!.data.roomName)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.badge),
                      Text(data2!.data.opportunityName),
                      Icon(Icons.roundabout_left)
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundImage:
                              NetworkImage(data2!.data.todoOwnerPicture)),
                      Text(data2!.data.createdByName),
                      Icon(Icons.roundabout_left)
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Column(
                    children: [
                      Row(children: [
                        Icon(Icons.menu),
                        Text(data2!.data.activityType),
                        Row(children: [
                          Icon(Icons.menu),
                          Text(data2!.data.activityType)
                        ])
                      ])
                    ],
                  ),
                ),
                DropdownButton<Widget>(
                  items: [],
                  onChanged: (value) {},
                )
              ],
            )),
    );
  }
}
