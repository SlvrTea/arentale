
import 'package:arentale/data/repository/PlayerDataRepository.dart';
import 'package:arentale/domain/repository/player_repository.dart';
import 'package:arentale/internal/dependencies/db_module.dart';

import '../../data/repository/MobDataRepository.dart';
import '../../domain/repository/mob_repositry.dart';

class RepositoryModule {
  static late PlayerRepository _playerRepository;
  static MobRepository? _mobRepository;

  static PlayerRepository playerRepository() {
    _playerRepository = PlayerDataRepository(DataBaseModule.dbUtil());
    return _playerRepository;
  }

  static mobRepository() {
    _mobRepository ??= MobDataRepository(DataBaseModule.dbUtil());
    return _mobRepository;
  }
}