
import 'package:command_runner/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:wikipedia/wikipedia.dart';
import 'dart:async';

class GetArticleCommand extends Command {
  GetArticleCommand({required this.logger});
  final Logger logger;

  @override
  String get description => 'get a article by command';

  @override
  String? get valueHelp => 'I dont know';


  @override
  String get name => 'article';

  @override
  String get defaultValue => 'cat';

  @override
  bool get requiresArguments => true;

  @override
  // TODO: implement help
  String? get help => 'Print article detail by article title';


  @override
  FutureOr<Object?> run(ArgResults args)async {
    try{
      var title = args.commandArg?? defaultValue;
      final List<Article> articleList= await getArticleByTitle(title);
      final article= articleList.first;
      final buffer = StringBuffer('\n===${article.title.titleText}===\n\n');
      buffer.write(article.extract.split(' ').take(500).join(' '));
      return buffer.toString();

    }on FormatException catch(e){
      logger..warning(e.message)..warning(e.source)..info(usage);
      return e.message;
    }

  }



}