

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../model/summary.dart';

Future<Summary> getRandomArticleSummary() async {
   final http.Client client = http.Client();
   try{
      final Uri uri = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/page/random/summary'
      );
      final http.Response response = await client.get(uri);
      if(response.statusCode==200){
        final Map<String, Object?> responseMap= jsonDecode(response.body) as Map<String, Object?>;
        return Summary.fromJson(responseMap);
      }else{
        throw HttpException(
          '[WikipediaApiClient.getRandomArticleSummary]'
              'statusCode=${response.statusCode}, body=${response.body}'
        );
      }
   }on FormatException{
    rethrow;
   }finally{
     client.close();
   }
}


Future<Summary> getArticleSummaryByTitle(String articleTitle) async{
    final http.Client client = http.Client();
    try{
      final Uri uri = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/page/summary/$articleTitle',
      );
      final http.Response response = await client.get(uri);
      if(response.statusCode==200){
        final Map<String, Object?> responseJson= jsonDecode(response.body) as Map<String, Object?>;
        return Summary.fromJson(responseJson);
      }else{
        throw HttpException(
          '[WikipediaApiClient.getArticleSummaryByTitle]'
              'statusCode=${response.statusCode}, body=${response.body}'
        );
      }
    }on FormatException{rethrow;}finally{client.close();}
}

