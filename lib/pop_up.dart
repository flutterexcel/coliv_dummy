import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPopUpPage extends StatefulWidget {
  MyPopUpPage({super.key});

  @override
  State<MyPopUpPage> createState() => _MyPopUpPageState();
}

class _MyPopUpPageState extends State<MyPopUpPage> {
  // method for post data
  var token =
      " eyJhbGciOiJSUzI1NiIsImtpZCI6ImE1MWJiNGJkMWQwYzYxNDc2ZWIxYjcwYzNhNDdjMzE2ZDVmODkzMmIiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiRXVnZW5pbyBGZXJyYW50ZSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaWlUM2ZRRU9sdUdxdnBNQ0REZ2w5V0xrN2ltckliOTdJZmg3SkxTN0V5dkt1UTJGQ0l0RkxRUjE1R1JHUXVnN2h0Nll0d2FfWWJJRHZEd0x4eXgwbGh2RVRzT3g5NmhkOUZUV1pRTnZRRFIteHYxM3ZuZHVRMXNweGRwampwWVJGdkdhUUgwLWtVTGQteXhLeTFFaEdNdVdVZjZNa2ZjcUJzRFJSUzU0V1oyZEdWeERMUXkzem5YdmZONnQ5SGc3VXdmVlZtVU1OYXI0M1lPaDdaZWJPVFUtTDFUVzlSZjc0aEZlcU0xUFh3dE92OU5uakkyaFR2SkR1RU9SWTdGOENvUEpwVS1jNE5Kd19Qd3Zyc0tjOGpqOWNxbFRNU0lnTHU2QnFMd0NTV1ZWbkRNZFhaVFNMWVlreC01NXJXdnhiZENJXzNiM0Y3WUJxcXhDNmxmLWNzQTBVcWg1ZmdMYkpFSWhsNERGanMzVlpyc3lSVENsbGp4ZlBiRUtqNDkxUU94ZkRjbUl0QUUwT2FzRFdtSzNVYlh5M1o3U2NyT1dIVlNIOEVjX1JZbjhPZ0toT1hOTmhPUE5Ldm1NbVZnWjFIVXhadS0tNDhpem80eDExWU1rMld4eExUZGdJbDVmWHM2X0FIajdYaTBFRW1CeV9QR2p0TmxDQUJJZzBXbjgwQkdsTDBzNFJZaW9KZV9XbVo1MGRZUGZJOGZnS1B6b1N5MWhMM3A0YzZHR0tzZU1KekxSOEpXZGlUbklWZGFLMXowSGpyRl8xMkI1Vi1UN1lJeHVqQUpKQVBpbjRxNDZ4X1JLUm5lc1lVWjRzUG92cWJReXE5NXJla1FxUVcyZEo0eGFOWXpoUVRpWktRQUZBX1dQV2hPU09SMDhWa2ZEYk1TTlFNS0JJa2FCREdjUWdkUWRTUksxMkxfS2FrdHpvLWtvLTFobEcxMGlXMmdXOU5yVmo5SEdyd3dUaEkyX3lOZzN3YUljMTZfWkJsQmJGdWdCZHhNUmg3NlFsZ0gwUjJmQT1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9jb2xpdmhxLWRldiIsImF1ZCI6ImNvbGl2aHEtZGV2IiwiYXV0aF90aW1lIjoxNjg5MDczMDk0LCJ1c2VyX2lkIjoiNWY4VXYzRGtTdlN6aTZmbHZUSTBMU3JjdTgwMiIsInN1YiI6IjVmOFV2M0RrU3ZTemk2Zmx2VEkwTFNyY3U4MDIiLCJpYXQiOjE2ODkzMzUxMjksImV4cCI6MTY4OTMzODcyOSwiZW1haWwiOiJldWdlbmlvQGNhc2FtaWEuY28iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwNzcwMDI4ODEyODA1NjM5ODAwMyJdLCJlbWFpbCI6WyJldWdlbmlvQGNhc2FtaWEuY28iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.GUdCYqpwkmpLC2TcMpfvpPJSgPcUp0UB6ldpg3cl4LEKJavtFkuVfCHeP4C8ArnjCAWBsBYe5EyATGcXEwSzbTlQhoFUbcB2rkNPzPKz0qKXgNx-l57Wm3W92Mpeq2jHBQb5LlIwbZVc32jGk6hCV5XX8uTyvSuIJofRkWrZSIrSyTiBKsTXpOFkGtBqj6Sb6PmUvyxFHaE7CjoCSuP4A4olZr9mGhdR-PXcAsfGtcpJwmT0xlGOqI6jpzdjLeiVmN-JvtNAFMtM1oCUKLJkd701wjnxq30MDMJRFEzosF274KNbzxvEHcCFMoKRXVkpJyxUnzVTJnzuryFc-6gLQA";

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
            // 'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            // "Access-Control-Allow-Origin":
            //     "*", // Required for CORS support to work
            // "Access-Control-Allow-Credentials":
            //     "true", // Required for cookies, authorization headers with HTTPS
            // "Access-Control-Allow-Headers":
            //     "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            // "Access-Control-Allow-Methods": "POST, OPTIONS",
            'Authorization': 'Bearer $token'
          });
      print(' done');
      print(response.body);
      setState(() {
        // data1 = ActivityListModel.fromJson(jsonDecode(response.body));
        // circular = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text(
              maxLines: 1,
              'teteste Follow-up contact Manager',
              style: TextStyle(color: Colors.white)),
          actions: [
            Icon(Icons.edit, color: Colors.white),
            SizedBox(width: 15),
            Icon(Icons.delete, color: Colors.white)
          ]),

      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(child: ListTile(leading: Icon(Icons.contacts)));
        },
      ),
      //backgroundColor:Colors.
    );
  }
}
