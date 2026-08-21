
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../model/article.dart';

Future<List<Article>> getArticleByTitle(String title) async{
  final http.Client client = http.Client();
  try{

    final Uri uri = Uri.https(
    'en.wikipedia.org',
    'w/api.php',
      <String, Object?>{
        'action': 'query',
        'format': 'json',
        'titles': title.trim(),
        'prop': 'extracts',
        'explaintext': '',
      }
    );
    final http.Response response= await client.get(uri);
    if(response.statusCode==200){
      final Map<String,Object?> responseJson= jsonDecode(response.body) as Map<String, Object?>;
      return Article.listFromJson(responseJson);
    }
    else{
      throw HttpException(
        '[WikipediaClientApi.getArticleByTitle]'
            'statusCode=${response.statusCode}, body=${response.body}'
      );
    }
  }on FormatException{rethrow;}finally{client.close();}


}