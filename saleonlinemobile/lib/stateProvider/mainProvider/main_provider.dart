import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/fileService/file_repo_controller.dart';
import 'package:saleonlinemobile/stateProvider/homeState/home_state_provider.dart';

class MainProvider {
  static provider() {
    return [
      ChangeNotifierProvider(create: (_) => FileRepoController()),
      ChangeNotifierProvider(create: (_) => HomeStateProvider())
    ];
  }
}
