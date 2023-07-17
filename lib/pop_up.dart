import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_colivhq_dummy/model2.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyPopUpPage extends StatefulWidget {
  MyPopUpPage({super.key});

  @override
  State<MyPopUpPage> createState() => _MyPopUpPageState();
}

class _MyPopUpPageState extends State<MyPopUpPage> {
  // method for post data
  int curr = 0;
  late final List<BottomNavigationBarItem> items;
  late PopUpData? data2;
  var token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE0ZWI4YTNiNjgzN2Y2MTU4ZWViNjA3NmU2YThjNDI4YTVmNjJhN2IiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiRXVnZW5pbyBGZXJyYW50ZSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaWlUM2ZRRU9sdUdxdnBNQ0REZ2w5V0xrN2ltckliOTdJZmg3SkxTN0V5dkt1UTJGQ0l0RkxRUjE1R1JHUXVnN2h0Nll0d2FfWWJJRHZEd0x4eXgwbGh2RVRzT3g5NmhkOUZUV1pRTnZRRFIteHYxM3ZuZHVRMXNweGRwampwWVJGdkdhUUgwLWtVTGQteXhLeTFFaEdNdVdVZjZNa2ZjcUJzRFJSUzU0V1oyZEdWeERMUXkzem5YdmZONnQ5SGc3VXdmVlZtVU1OYXI0M1lPaDdaZWJPVFUtTDFUVzlSZjc0aEZlcU0xUFh3dE92OU5uakkyaFR2SkR1RU9SWTdGOENvUEpwVS1jNE5Kd19Qd3Zyc0tjOGpqOWNxbFRNU0lnTHU2QnFMd0NTV1ZWbkRNZFhaVFNMWVlreC01NXJXdnhiZENJXzNiM0Y3WUJxcXhDNmxmLWNzQTBVcWg1ZmdMYkpFSWhsNERGanMzVlpyc3lSVENsbGp4ZlBiRUtqNDkxUU94ZkRjbUl0QUUwT2FzRFdtSzNVYlh5M1o3U2NyT1dIVlNIOEVjX1JZbjhPZ0toT1hOTmhPUE5Ldm1NbVZnWjFIVXhadS0tNDhpem80eDExWU1rMld4eExUZGdJbDVmWHM2X0FIajdYaTBFRW1CeV9QR2p0TmxDQUJJZzBXbjgwQkdsTDBzNFJZaW9KZV9XbVo1MGRZUGZJOGZnS1B6b1N5MWhMM3A0YzZHR0tzZU1KekxSOEpXZGlUbklWZGFLMXowSGpyRl8xMkI1Vi1UN1lJeHVqQUpKQVBpbjRxNDZ4X1JLUm5lc1lVWjRzUG92cWJReXE5NXJla1FxUVcyZEo0eGFOWXpoUVRpWktRQUZBX1dQV2hPU09SMDhWa2ZEYk1TTlFNS0JJa2FCREdjUWdkUWRTUksxMkxfS2FrdHpvLWtvLTFobEcxMGlXMmdXOU5yVmo5SEdyd3dUaEkyX3lOZzN3YUljMTZfWkJsQmJGdWdCZHhNUmg3NlFsZ0gwUjJmQT1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9jb2xpdmhxLWRldiIsImF1ZCI6ImNvbGl2aHEtZGV2IiwiYXV0aF90aW1lIjoxNjg5MDczMDk0LCJ1c2VyX2lkIjoiNWY4VXYzRGtTdlN6aTZmbHZUSTBMU3JjdTgwMiIsInN1YiI6IjVmOFV2M0RrU3ZTemk2Zmx2VEkwTFNyY3U4MDIiLCJpYXQiOjE2ODk1OTYzMjksImV4cCI6MTY4OTU5OTkyOSwiZW1haWwiOiJldWdlbmlvQGNhc2FtaWEuY28iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwNzcwMDI4ODEyODA1NjM5ODAwMyJdLCJlbWFpbCI6WyJldWdlbmlvQGNhc2FtaWEuY28iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.ef4c9ggX-hK3bMmJ3jyUSgvd7kn9ZglLu9fkPAwSaSn2d6imje5PKTXSNkbv9RTowhSoQx7TmdzuqiXiPyKcLjDVCmiKRjXffNXSmuye2TNaGwL7EZnS_oEslU2zcczvInoIlYitAS9-jIGnqZD1ddSF9Xy2mRHiZjljae-l1t_HkY0uIo1AsXUXy0Pk7uX1Re8bXc5Ss2KINfobWNofqJ0JQ76Pdic9D9opzETfbY5pWdHgVp5OsoTZcEnlcnIDp68WMFyqqW0bQyo6BCmQjfIaqF33MFVB7ysFYELM77_xRnOsUiDmcoCd8KGerKt6QEO5m1fxd7n-Y8P8R6OcCA";

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
        // circular = false;
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
          backgroundColor: Colors.green,
          title: Text(
              maxLines: 1,
              'teteste Follow-up contact Manager',
              style: TextStyle(color: Colors.white)),
          actions: [
            Icon(Icons.edit, color: Colors.white),
            SizedBox(width: 15),
            Icon(Icons.delete, color: Colors.white)
          ]),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 121, 222, 124)),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(children: [
                        Icon(Icons.watch, color: Colors.black),
                        Text(
                          DateFormat('MMM dd,yyy').format(
                                  DateTime.parse(data2!.data.todoDate)) +
                              ',',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                            DateFormat('hh:mm a')
                                .format(DateTime.parse(data2!.data.todoDate)),
                            style: TextStyle(color: Colors.white)),
                        // Text(DateFormat('MMM dd,yyyy')
                        //     .format(DateTime.parse(data2!.data.todoDate + ","))),
                        // Text(DateFormat('hh:mm a')
                        //     .format(DateTime.parse(data2!.data.todoDate)))
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 155, 248, 158),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      //width: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.lightBlue,
                            ),
                          ),
                          Column(
                            children: [
                              Text(data2!.data.members[0].preferredName,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "(" +
                                      data2!.data.members[0].memberFirst +
                                      ' ' +
                                      data2!.data.members[0].memberLast +
                                      ")",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 155, 248, 158),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      //width: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.home,
                            ),
                          ),
                          Column(
                            children: [
                              Text(data2!.data.homeName,
                                  style: TextStyle(color: (Colors.white))),
                              Text(data2!.data.roomName,
                                  style: TextStyle(color: (Colors.white)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 155, 248, 158),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.work,
                            ),
                          ),
                          Text(data2!.data.opportunityName)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(81, 111, 82, 1),
                            borderRadius: BorderRadius.circular(10)),
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      data2!.data.todoOwnerPicture)),
                            ),
                            Text(
                              data2!.data.todoOwnerName,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.horizontal_split_rounded),
                      ),
                      Text(
                        data2!.data.activityType,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.format_align_left_sharp),
                      ),
                      Text(data2!.data.activityDescription,
                          style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'MARK DONE',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'ADD FOLLOW UP ACTIVITY',
                    style: TextStyle(),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'SEND MAIL',
                    style: TextStyle(),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'SHARE',
                    style: TextStyle(),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
      //backgroundColor:Colors.
      bottomNavigationBar:
          BottomNavigationBar(currentIndex: curr, items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.green),
            backgroundColor: Colors.white,
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.window, color: Colors.green),
            backgroundColor: Colors.white,
            label: 'window'),
        BottomNavigationBarItem(
            icon: Icon(Icons.info_sharp, color: Colors.green),
            backgroundColor: Colors.white,
            label: 'information'),
        BottomNavigationBarItem(
            icon: Icon(Icons.event, color: Colors.green),
            backgroundColor: Colors.white,
            label: 'events'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.green),
            backgroundColor: Colors.white,
            label: 'notification'),
      ]),
    );
  }
}
