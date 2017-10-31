library tool.dev;

import 'package:dart_dev/dart_dev.dart'
    show dev, config, TestRunnerConfig, Environment;

main(List<String> args) async {
  // https://github.com/Workiva/dart_dev

  // Perform task configuration here as necessary.

  // Available task configurations:
  // config.analyze
  // config.copyLicense
  // config.coverage
  // config.docs
  // config.examples
  // config.format
  config.test
    ..pubServe = true
    ..platforms = ['content-shell'];

  config.genTestRunner.configs = [
    new TestRunnerConfig(genHtml: true, env: Environment.browser)
  ];

  await dev(args);
}
