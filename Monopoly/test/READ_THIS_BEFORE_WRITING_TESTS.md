https://pub.dartlang.org/packages/test#writing-tests

Things different than the instructions above (Since we are using an open-source lib from Workiva called `dart_dev` to make testing easier)

Running tests: `pub run dart_dev test`
Running an individual test: `pub run dart_dev test -n "${test_name}"`

If you create a new test file, you have to regenerate the runner by typing: `pub run dart_dev gen-test-runner`
**This is not needed if the file already exists :-)**
