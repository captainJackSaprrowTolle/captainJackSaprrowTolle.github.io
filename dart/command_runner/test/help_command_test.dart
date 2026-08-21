import 'package:command_runner/command_runner.dart';
import 'package:test/test.dart';

void main() {
  group('HelpCommand', () {
    test('name/description/help 字段正确', () {
      final help = HelpCommand();

      expect(help.name, 'help');
      expect(help.description, 'Prints usage information to the command line.');
      expect(help.help, 'Prints this usage information');
    });

    test('构造函数注册了 verbose flag 和 command option', () {
      final help = HelpCommand();

      final verbose = help.options.firstWhere((o) => o.name == 'verbose');
      expect(verbose.abbr, 'v');

      final command = help.options.firstWhere((o) => o.name == 'command');
      expect(command.abbr, 'c');
    });

    test('run() 返回包含 runner.usage 的字符串', () async {
      final help = HelpCommand();
      help.runner = CommandRunner();

      final output = await help.run(ArgResults());

      expect(output, help.runner.usage);
    });
  });
}
