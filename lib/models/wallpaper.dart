class Wallpaper {
  final String? name;
  final String? posterPath;

  Wallpaper({this.name, this.posterPath});

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    var urls = json["urls"] as Map<String, dynamic>;
    return Wallpaper(
      name: json["alt_description"],
      posterPath: urls['regular'] as String?,
    );
  }
}
