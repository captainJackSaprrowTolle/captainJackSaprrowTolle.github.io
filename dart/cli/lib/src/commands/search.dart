
import 'package:logging/logging.dart';
import 'package:command_runner/command_runner.dart';
import 'package:wikipedia/wikipedia.dart';
import 'dart:async';


class SearchCommand extends Command {
  SearchCommand({required this.logger}){
    addFlag(
      'I-feel-lucky',
      help: 'If true, print the summary of the top article that the search returns.'
    );
  }

  final Logger logger;

  @override
  String get description => 'Search for wikipedia articles.';

  @override
  bool get requiresArguments => true;

  @override
  String get name => 'search';

  @override
  String? get valueHelp => 'search';

  @override
  String? get help =>
  'Prints a list of links to Wikipedia articles that match the given term.';


  @override
  FutureOr<Object?> run(ArgResults args) async {
    ///This code checks for a valid argument,
    ///calls the search() function from the wikipedia package,
    /// formats the results,and returns the results as a string.
    if (requiresArguments &&
        (args.commandArg == null || args.commandArg!.isEmpty)) {
      throw FormatException('Please include a search term', name);
    }

    final buffer = StringBuffer('search results:\n');
    try {

      final SearchResults results = await search(args.commandArg!);

      if (args.flag('I-feel-lucky')) {
        final title = results.results.first.title;
        final Summary article = await getArticleSummaryByTitle(title);
        buffer.writeln('Lucky-you');
        buffer.writeln(article.titles.normalized.titleText);

        if (article.description != null) {
          buffer.writeln(article.description);
        }
        buffer.writeln(article.extract);
        buffer.writeln();
        buffer.writeln('all results:');
      }
      for (var result in results.results) {
        buffer.writeln('${result.url} - ${result.title}');
      }
      return buffer.toString();
    } on FormatException catch(e){
      logger..warning(e.message)..warning(e.source)..info(usage);
      return e.message;
    }
  }

}