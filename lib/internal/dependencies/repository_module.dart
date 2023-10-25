
import 'package:arentale/data/repository/PlayerDataRepository.dart';
import 'package:arentale/domain/repository/player_repository.dart';
import 'package:arentale/internal/dependencies/db_module.dart';

class RepositoryModule {
  static PlayerRepository? _playerRepository;

  static playerRepository() {
    _playerRepository ??= PlayerDataRepository(DataBaseModule.dbUtil());
    return _playerRepository;
  }
}