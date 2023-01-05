abstract class PlaylistRepository {
  Future<List<Map<String, String>>> fetchInitialPlaylist();

  Future<Map<String, String>> fetchAnotherSong();
}

class DemoPlaylist extends PlaylistRepository {
  static DemoPlaylist? _instance;

  // 私有的命名构造函数
  DemoPlaylist._internal();

  static DemoPlaylist? getInstance() {
    if (_instance == null) {
      _instance = DemoPlaylist._internal();
    }

    return _instance;
  }

  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist(
      {int length = 3}) async {
    return List.generate(length, (index) => _nextSong());
  }

  @override
  Future<Map<String, String>> fetchAnotherSong() async {
    return _nextSong();
  }

  var _songIndex = 0;
  static const _maxSongNumber = 16;

  Map<String, String> _nextSong() {
    _songIndex = (_songIndex % _maxSongNumber) + 1;
    return {
      'id': _songIndex.toString().padLeft(3, '0'),
      'title': 'Song $_songIndex',
      'album': 'SoundHelix',
      'url':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$_songIndex.mp3',
    };
  }
}
