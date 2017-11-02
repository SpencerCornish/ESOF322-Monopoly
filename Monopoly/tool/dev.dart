library tool.dev;

import 'package:dart_dev/dart_dev.dart'
    show dev, config, TestRunnerConfig, Environment;

main(List<String> args) async {
  // https://github.com/Workiva/dart_dev

  // Perform task configuration here as necessary.

  // Available task configurations:
  config.analyze
    ..strong = true
    ..hints = true
    ..entryPoints = ['lib/', 'lib/src/', 'test/'];

  // config.copyLicense
  config.coverage
    ..html = true
    ..pubServe = true;

  // config.docs
  // config.examples
  config.format..paths = ['lib/src/', 'test/'];
  config.test
    ..pubServe = true
    ..platforms = ['content-shell']
    ..unitTests = ["test/unit/generated_runner_test.dart"];

  config.genTestRunner.configs = [
    new TestRunnerConfig(
      genHtml: true,
      env: Environment.browser,
      directory: 'test/unit/',
      filename: 'generated_runner_test',
    )
  ];

  await dev(args);
}
