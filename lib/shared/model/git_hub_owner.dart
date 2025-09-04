import 'package:json_annotation/json_annotation.dart';

part 'git_hub_owner.g.dart';

/// GitHubリポジトリを所有するオーナー
@JsonSerializable()
class GitHubOwner {
  GitHubOwner({this.name = "", this.iconUrl});

  /// 名前
  @JsonKey(name: "login")
  final String name;

  /// アイコンのURL
  @JsonKey(name: "avatar_url")
  final String? iconUrl;

  /// JSONからインスタンス生成
  factory GitHubOwner.fromJson(Map<String, dynamic> json) =>
      _$GitHubOwnerFromJson(json);

  /// JSON形式(Map)に変換
  Map<String, dynamic> toJson() => _$GitHubOwnerToJson(this);
}
