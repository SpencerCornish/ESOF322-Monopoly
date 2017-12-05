@TestOn('browser')
library test.unit.generated_runner_test;

// Generated by `pub run dart_dev gen-test-runner -d test/unit/ -e Environment.browser --genHtml`

import './src/components/board/board_test.dart' as src_components_board_board_test;
import './src/components/game_factory/bozeman_game_factory_test.dart' as src_components_game_factory_bozeman_game_factory_test;
import './src/components/game_factory/standard_game_factory_test.dart' as src_components_game_factory_standard_game_factory_test;
import './src/components/player/player_test.dart' as src_components_player_player_test;
import './src/components/tiles/tile_test.dart' as src_components_tiles_tile_test;
import 'package:test/test.dart';

void main() {
  src_components_board_board_test.main();
  src_components_game_factory_bozeman_game_factory_test.main();
  src_components_game_factory_standard_game_factory_test.main();
  src_components_player_player_test.main();
  src_components_tiles_tile_test.main();
}