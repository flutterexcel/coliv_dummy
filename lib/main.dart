import 'dart:convert';
import 'dart:math';
import 'package:flutter_colivhq_dummy/pop_up.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_colivhq_dummy/model.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: MyPopUpPage(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ActivityListModel? data1;
  bool circular = true;
  var token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE1MWJiNGJkMWQwYzYxNDc2ZWIxYjcwYzNhNDdjMzE2ZDVmODkzMmIiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiRXVnZW5pbyBGZXJyYW50ZSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaWlUM2ZRRU9sdUdxdnBNQ0REZ2w5V0xrN2ltckliOTdJZmg3SkxTN0V5dkt1UTJGQ0l0RkxRUjE1R1JHUXVnN2h0Nll0d2FfWWJJRHZEd0x4eXgwbGh2RVRzT3g5NmhkOUZUV1pRTnZRRFIteHYxM3ZuZHVRMXNweGRwampwWVJGdkdhUUgwLWtVTGQteXhLeTFFaEdNdVdVZjZNa2ZjcUJzRFJSUzU0V1oyZEdWeERMUXkzem5YdmZONnQ5SGc3VXdmVlZtVU1OYXI0M1lPaDdaZWJPVFUtTDFUVzlSZjc0aEZlcU0xUFh3dE92OU5uakkyaFR2SkR1RU9SWTdGOENvUEpwVS1jNE5Kd19Qd3Zyc0tjOGpqOWNxbFRNU0lnTHU2QnFMd0NTV1ZWbkRNZFhaVFNMWVlreC01NXJXdnhiZENJXzNiM0Y3WUJxcXhDNmxmLWNzQTBVcWg1ZmdMYkpFSWhsNERGanMzVlpyc3lSVENsbGp4ZlBiRUtqNDkxUU94ZkRjbUl0QUUwT2FzRFdtSzNVYlh5M1o3U2NyT1dIVlNIOEVjX1JZbjhPZ0toT1hOTmhPUE5Ldm1NbVZnWjFIVXhadS0tNDhpem80eDExWU1rMld4eExUZGdJbDVmWHM2X0FIajdYaTBFRW1CeV9QR2p0TmxDQUJJZzBXbjgwQkdsTDBzNFJZaW9KZV9XbVo1MGRZUGZJOGZnS1B6b1N5MWhMM3A0YzZHR0tzZU1KekxSOEpXZGlUbklWZGFLMXowSGpyRl8xMkI1Vi1UN1lJeHVqQUpKQVBpbjRxNDZ4X1JLUm5lc1lVWjRzUG92cWJReXE5NXJla1FxUVcyZEo0eGFOWXpoUVRpWktRQUZBX1dQV2hPU09SMDhWa2ZEYk1TTlFNS0JJa2FCREdjUWdkUWRTUksxMkxfS2FrdHpvLWtvLTFobEcxMGlXMmdXOU5yVmo5SEdyd3dUaEkyX3lOZzN3YUljMTZfWkJsQmJGdWdCZHhNUmg3NlFsZ0gwUjJmQT1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9jb2xpdmhxLWRldiIsImF1ZCI6ImNvbGl2aHEtZGV2IiwiYXV0aF90aW1lIjoxNjg5MDczMDk0LCJ1c2VyX2lkIjoiNWY4VXYzRGtTdlN6aTZmbHZUSTBMU3JjdTgwMiIsInN1YiI6IjVmOFV2M0RrU3ZTemk2Zmx2VEkwTFNyY3U4MDIiLCJpYXQiOjE2ODkzMTU0MjcsImV4cCI6MTY4OTMxOTAyNywiZW1haWwiOiJldWdlbmlvQGNhc2FtaWEuY28iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwNzcwMDI4ODEyODA1NjM5ODAwMyJdLCJlbWFpbCI6WyJldWdlbmlvQGNhc2FtaWEuY28iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.GBiB_niHPCUTZb7jqIQQMuLHdkEKgnj_7-rfYKXOpHdPJafusrZMCplGkOfT9NZt7CIPI7Gvson5qGhvrkaww0rQBtGi3pbcD4U1N45uDXWYRtCwn3Z1UrUks74aUmuR97JfDZ_IfkyNiv5lS4YdljU4OlPT-C7icXM8I8_uGkbiZ9SC3opB-ZVEzjgF9-wN9PyX9ZKizMiOfT6IyuQsudMTO2GzlMDYwlOtKkKDHwn46LWHPeB7z0nm2FBZBzkKj8kecsGbsj9VqeVMMO_5Sb6g3VgCllFz5Ys1VKKw2eqjv7irlncZc74if9WoX-7sk_lU6mYaxGbOvbiNDxRWsg';

// method for post data
  postData() async {
    try {
      var response = await http.post(
          Uri.parse(
              'https://asia-east2-colivhq-dev.cloudfunctions.net/activitiesList'),
          body: jsonEncode(
            {
              "todo": true,
              "completed": false,
              "limit": 10,
              "page": 3,
              "move": false,
              "dateTimeZone": "+5:30",
              "type": "myteam",
              "dateTimeOrder": true
            },
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials":
                "true", // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS",
            'Authorization': 'Bearer $token'
          });
      print(response.body);
      setState(() {
        data1 = ActivityListModel.fromJson(jsonDecode(response.body));
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
          //shadowColor: Color(000000),
          elevation: 20,
          toolbarHeight: 40,
          shadowColor: Colors.black,
          actions: const [
            Row(
              children: [
                Icon(Icons.search, color: Colors.white),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
        body: Row(
          children: [
            Drawer(
              shadowColor: Colors.black,
              elevation: 6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: 300,
                        decoration: BoxDecoration(color: Colors.green),
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    'data:image/jpeg;base64,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')),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Eugenio',
                                    style: TextStyle(color: Colors.white)),
                                GestureDetector(
                                  onTap: postData,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.insert_chart_outlined_rounded,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'MyColivHQ',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.apartment,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Homes',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.bed_outlined,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Rooms',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.people_outline_rounded,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Members',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.work_history_outlined,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Requests',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.report_outlined,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Issues',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.mail_outline,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Services',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.pages,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Bills',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.settings,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Vendors',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Container(
              width: 800,
              child: SingleChildScrollView(
                child: circular
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          PaginatedDataTable(
                              header: Center(
                                child: Text("My Randomly Generated Table"),
                              ),
                              columnSpacing: 15,
                              horizontalMargin: 60,
                              rowsPerPage: 5,
                              columns: [
                                DataColumn(label: Text('DATE')),
                                DataColumn(label: Text('MEMBERS ')),
                                DataColumn(label: Text('ACTIVITY TYPE ')),
                                DataColumn(label: Text('ACTIVITY DESCRIPTION')),
                                DataColumn(label: Text('IMAGE')),
                                DataColumn(label: Text('CHECKBOX')),
                                DataColumn(label: Text('POPUP-MENU')),
                              ],
                              source: MyData(a: data1!))
                          // ],
                          // SingleChildScrollView(
                          //   child: Container(
                          //     // height: MediaQuery.of(context).size.height,
                          //     width: MediaQuery.of(context).size.width - 360,
                          //     child: Column(children: [
                          //       SingleChildScrollView(
                          //         child: Center(
                          //           child: circular
                          //               ? CircularProgressIndicator()
                          //               : ListView.builder(
                          //                   itemCount: data1.data.length,
                          //                   shrinkWrap: true,
                          //                   itemBuilder: (BuildContext context, index) {
                          //                     return Container(
                          //                       height: 100,
                          //                       margin: EdgeInsets.all(3),
                          //                       decoration: const BoxDecoration(
                          //                         //borderRadius:  BorderRadius.all(10),
                          //                         boxShadow: [
                          //                           BoxShadow(
                          //                             color: Colors.black,
                          //                             offset: Offset(
                          //                               5.0,
                          //                               5.0,
                          //                             ), //Offset
                          //                             blurRadius: 10.0,
                          //                             spreadRadius: 2.0,
                          //                           ), //BoxShadow
                          //                           BoxShadow(
                          //                             color: Colors.white,
                          //                             offset: Offset(0.0, 0.0),
                          //                             blurRadius: 0.0,
                          //                             spreadRadius: 0.0,
                          //                           ), //BoxShadow
                          //                         ],
                          //                       ),
                          //                       width: MediaQuery.sizeOf(context).width,
                          //                       child: Container(
                          //                         width: 100,
                          //                         child: ListTile(
                          //                           leading: CircleAvatar(
                          //                               backgroundImage: NetworkImage(data1
                          //                                   .data[index].todoOwnerPicture)),
                          //                           title: Container(
                          //                               width: 30,
                          //                               child: Text(
                          //                                 data1.data[index].homeId == null
                          //                                     ? ""
                          //                                     : data1.data[index].homeId,
                          //                                 maxLines: 1,
                          //                               )),
                          //                           subtitle: Container(
                          //                               width: 30,
                          //                               child: Text(
                          //                                 data1.data[index].activityType ==
                          //                                         null
                          //                                     ? ''
                          //                                     : data1
                          //                                         .data[index].activityType,
                          //                                 maxLines: 1,
                          //                               )),
                          //                           trailing: Container(
                          //                             height: 200,
                          //                             child: Column(
                          //                               children: [
                          //                                 Container(
                          //                                     // width: 120,
                          //                                     child: Text(
                          //                                   data1.data[index].email == null
                          //                                       ? ''
                          //                                       : data1.data[index].email,
                          //                                   overflow: TextOverflow.ellipsis,
                          //                                   softWrap: false,
                          //                                   maxLines: 1,
                          //                                 )),
                          //                                 Container(
                          //                                   height: 19,
                          //                                   // width: 120,
                          //                                   child: Text(
                          //                                     data1.data[index].createdDate ==
                          //                                             null
                          //                                         ? ' '
                          //                                         : data1.data[index]
                          //                                             .createdDate,
                          //                                     overflow: TextOverflow.ellipsis,
                          //                                     softWrap: false,
                          //                                     maxLines: 1,
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     );
                          //                   }),
                          //         ),
                          //       ),
                          //     ]

                          //         ),
                          //   ),
                          // )
                        ],
                      ),
              ),
            )
            // This trailing comma makes auto-formatting nicer for build methods.
          ],
        ));
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }

class MyData extends DataTableSource {
  ValueNotifier<List<bool>> isCheckedList =
      ValueNotifier<List<bool>>(List<bool>.filled(100, false));
  ActivityListModel a;
  late List<Map<String, dynamic>> data;
  MyData({required this.a}) {
    data = List.generate(
        a.data.length,
        (index) => {
              "todo-date": a.data[index].todoDate == null
                  ? ' '
                  : DateFormat('MMM dd,yyyy')
                      .format(DateTime.parse(a.data[index].todoDate!)),
              "todo-time": a.data[index].todoDate == null
                  ? ' '
                  : DateFormat('hh:mm a')
                      .format(DateTime.parse(a.data[index].todoDate!)),

              //  "name": "medha",
              "name": a.data[index].members.isEmpty ||
                      a.data[index].members == null
                  ? ' '
                  : '${a.data[index].members[0].preferredName} ${a.data[index].members[0].memberFirst} ${a.data[index].members[0].memberFirst}',
              "activity-type": a.data[index].activityType == null
                  ? ' '
                  : a.data[index].activityType,
              "activity-description": a.data[index].activityDescription == null
                  ? ' '
                  : a.data[index].activityDescription,
              "owner-image": a.data[index].todoOwnerPicture == null
                  ? ' '
                  : a.data[index].todoOwnerPicture,
              "check-box": '',
              "pop-up-menu-button": a.data[index]
            });
  }
  SampleItem? selectedMenu;
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Column(
        children: [
          Text(data[index]['todo-date'].toString()),
          Text(data[index]['todo-time'].toString())
        ],
      )),
      DataCell(Text(data[index]['name'])),
      DataCell(Text(data[index]['activity-type'])),
      DataCell(Text(data[index]['activity-description'].toString())),
      DataCell(CircleAvatar(
          backgroundImage: NetworkImage(data[index]['owner-image']))),
      DataCell(
        ValueListenableBuilder<List<bool>>(
          valueListenable: isCheckedList,
          builder: (context, value, child) {
            return Checkbox(
              value: value[index],
              onChanged: (bool? newValue) {
                // print('Check Detected');

                value[index] = newValue!;
                isCheckedList.value = value;
                notifyListeners();
              },
            );
          },
        ),
      ),
      DataCell(PopupMenuButton<SampleItem>(
        initialValue: selectedMenu,
        onSelected: (SampleItem item) {},
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<SampleItem>>[
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: Text('Item 1'),
            ),
          ];
        },
      ))
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data.length;
  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
