import 'package:test/test.dart';
import 'package:wikipedia/src/model/article.dart';
import 'package:wikipedia/src/model/search_results.dart';
import 'dart:io';
import 'dart:convert';

import 'package:wikipedia/src/model/summary.dart';

const String dartLangSummaryJson='./test/test_data/dart_lang_summary.json';
const String catExtractJson='./test/test_data/cat_extract.json';
const String openSearchResponseJson='./test/test_data/open_search_response.json';

void main() {
    group('Deserialized example JSON response from wikipedia API', (){
      test('Deserialized Dart Programing language page summary example data from '
          'json file into a Summary Object',() async{
        final String pageSummaryInput =
        await File(dartLangSummaryJson).readAsString();
        final Map<String, Object?> pageSummaryMap=jsonDecode(pageSummaryInput) as Map<String,Object?>;
        final Summary summary=Summary.fromJson(pageSummaryMap);
        expect(summary.titles.canonical, 'Dart_(programming_language)');
      });

      test('Deserializing Cat article from json file into an Article Object',() async{
          final String catExtractInput = await File(catExtractJson).readAsString();
          final Map<String, Object?> catExtractMap=jsonDecode(catExtractInput) as Map<String, Object?>;
          final List<Article> catArticleList = Article.listFromJson(catExtractMap);
          expect(catArticleList[0].title, 'Cat');
      });

      test('Deserialize Open Search results example data from json file into an SearchResults object', ()async{
        final String searchResultInput= await File(openSearchResponseJson).readAsString();
        final List searchResultMap=jsonDecode(searchResultInput);
        final SearchResults searchResults=SearchResults.fromJson(searchResultMap);
        expect(searchResults.results.first.title,'Dart');
      });
    });
}
