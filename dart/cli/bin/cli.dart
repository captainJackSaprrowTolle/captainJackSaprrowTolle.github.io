import 'package:cli/cli.dart';
import 'package:command_runner/command_runner.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

const version = '0.0.1';


void main(List<String> arguments) {
  // print('Hello world: ${cli.calculate()}!');
  // if (arguments.isEmpty || arguments.first=='help'){
  //     printUsage();
  //   }
  // else if (arguments.first=='version'){
  //     print('Dartpida CLI version: $version');
  //   }
  // else if(arguments.first=='wikipedia'){
  //   final inputArgus = arguments.length>1? arguments.sublist(1):null;
  //   searchWikipedia(inputArgus);
  // }
  // else{
  //     printUsage();
  //   }
  final errorLogger=initialFileLogger('errors');
  var commandRunner = CommandRunner(
    onOutput:  (String output) async {
          await write(output);
    },
    onError: (Object error){
      if(error is Error){
        errorLogger.severe(
          '[Error] ${error.toString()}\n ${error.stackTrace}',
        );
        throw error;
      }
      if(error is Exception){
        errorLogger.warning(error);
      }
    }
  )..addCommand(HelpCommand())
  ..addCommand(SearchCommand(logger:errorLogger))
  ..addCommand(GetArticleCommand(logger:errorLogger));

  commandRunner.run(arguments);

  
}


void printUsage(){
  print("The following commands are valid: 'help', 'version','search <ARTICLE-TITLE>'");
}

Future<String> fetchWikipediaArticle(String articleTitle) async{
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle'
  );
  final response =  await http.get(url);
  if(response.statusCode==200){
    return response.body;
  }
  return 'Failed to fetch article: $articleTitle,  status code: ${response.statusCode}';

}


void searchWikipedia(List<String>? arguments) async {// ? 表示可以是null,声明之后遇到null不会报错
  final String articleTitle; 
  if (arguments==null || arguments.isEmpty){//先判断空输入，再判断空列表
    print("Please provide an article title.");
    final inputFromStdin = stdin.readLineSync();
    if(inputFromStdin==null || inputFromStdin.isEmpty){
      print("No article title provided.");
      return;
    }
    articleTitle =inputFromStdin;

  }else{
    print("received arguments length: ${arguments.length}");
    articleTitle = arguments.join(' ');
  }

  print("Searching Wikipedia for article: $articleTitle");
  var articleContent = await fetchWikipediaArticle(articleTitle);
  print(articleContent);
}