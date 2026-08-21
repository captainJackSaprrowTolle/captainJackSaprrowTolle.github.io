
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/search_results.dart';

Future<SearchResults> search(String searchTerm) async {
  final http.Client client= http.Client();
  try{
    final Uri uri = Uri.https(
        'en.wikipedia.org',
        'w/api.php',
        <String, Object?>{
          'action': 'opensearch',
          'format': 'json',
          'search': searchTerm,
        });
    final http.Response response = await client.get(uri);
    if(response.statusCode==200){
      final List responseJson = jsonDecode(response.body) as List<Object?>;
      return SearchResults.fromJson(responseJson);
    }else{
      throw HttpException(
          '[WikipediaApiClient.search]'
              'statusCode=${response.statusCode}, body=${response.body}'
      );
    }

  }on FormatException{rethrow;}finally{client.close();}
}