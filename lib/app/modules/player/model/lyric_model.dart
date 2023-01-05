class LyricEntity {
  int? songStatus;
  int? lyricVersion;
  String? lyric;
  int? code;

  LyricEntity({this.songStatus, this.lyricVersion, this.lyric, this.code});

  LyricEntity.fromJson(Map<String, dynamic> json) {
    songStatus = json['songStatus'];
    lyricVersion = json['lyricVersion'];
    lyric = json['lyric'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['songStatus'] = songStatus;
    data['lyricVersion'] = lyricVersion;
    data['lyric'] = lyric;
    data['code'] = code;
    return data;
  }
}
