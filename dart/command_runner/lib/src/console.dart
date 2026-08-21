import 'dart:io';

const String ansiEscapeLiteral = '\x1B';

/// Splits strings on '\n' characters, then writes each line to the console
/// [duration] defines how many milliseconds there will be betweetn each line print

Future<void> write(String text, {int duration=50}) async {
  final List<String> lines = text.split('\n');
  for (final String l in lines){
    await _delayedPrint('$l \n', duration: duration);
  }
}



Future<void> _delayedPrint(String text, {int duration=0}) async {
  return Future<void>.delayed(
    Duration(microseconds: duration),
      ()=>stdout.write(text),
  );
}


/// RGB formatted colors that are used to style input
///
/// All colors from Dart's band styleguide
///
/// As a demo , only includes colors this program cares about.
///If you want to use more colors, add them here

enum ConsoleColor{
  lightBlue(184, 234, 254),
  red(242, 93,80),
  yellow(249,248,196),
  grey(240,240,240),
  white(255,255,255);

  const ConsoleColor(this.r, this.g, this.b);

  final int r;
  final int g;
  final int b;

  String get enableForeground => '$ansiEscapeLiteral[38;2;$r;$g;${b}m';

  String get enableBackground => '$ansiEscapeLiteral[48;2;$r;$g;${b}m';

  static String get reset => '$ansiEscapeLiteral[0m';

  String applyForeground(String text){
    return '$ansiEscapeLiteral[38;2;$r;$g;${b}m$text$reset';
  }

  String applyBackground(String text){
    return '$ansiEscapeLiteral[48;2;$r;$g;${b}m$text$ansiEscapeLiteral[0m';
  }

}



extension TextRenderUtils on String {
  String get errorText=>ConsoleColor.red.applyBackground(this);
  String get instructionText=> ConsoleColor.yellow.applyBackground(this);
  String get titleText=> ConsoleColor.lightBlue.applyBackground(this);

  List<String> splitLineByLength(int length){
    final List<String> words = split(' ');
    final List<String> output = <String>[];
    final StringBuffer stringBuffer = StringBuffer();
    for(int i=0; i<words.length;i++){
      final String word = words[i];
      if(stringBuffer.length + word.length<=length){
        stringBuffer.write(word.trim());
        if(stringBuffer.length+1<=length){
          stringBuffer.write(' ');
        }
      }

      if(i+1<words.length && words[i+1].length + stringBuffer.length+1>length){
        output.add(stringBuffer.toString().trim());
        stringBuffer.clear();
      }
    }
    output.add(stringBuffer.toString().trim());
    return output;
  }
}