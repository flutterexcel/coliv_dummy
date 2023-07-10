import 'dart:html';

import 'package:http/http.dart' as http;

const baseUrl = 'https://asia-east2-colivhq-dev.cloudfunctions.net';

class BaseClient {
  var client = http.Client();
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl+ api);
   var response= await client.get(url);
  }
}
