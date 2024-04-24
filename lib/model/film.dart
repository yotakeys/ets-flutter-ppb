const String tableFilm = 'film';

class FilmFields {
  static final List<String> values = [id, title, description, gambar, time];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String gambar = 'gambar';
  static const String time = 'time';
}

class Film {
  final int? id;
  final String title;
  final String description;
  final String gambar;
  final DateTime createdTime;

  const Film({
    this.id,
    required this.title,
    required this.description,
    required this.gambar,
    required this.createdTime,
  });

  Film copy({
    int? id,
    String? title,
    String? description,
    String? gambar,
    DateTime? createdTime,
  }) =>
      Film(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        gambar: gambar ?? this.gambar,
        createdTime: createdTime ?? this.createdTime,
      );

  static Film fromJson(Map<String, Object?> json) => Film(
        id: json[FilmFields.id] as int?,
        title: json[FilmFields.title] as String,
        description: json[FilmFields.description] as String,
        gambar: json[FilmFields.gambar] as String,
        createdTime: DateTime.parse(json[FilmFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        FilmFields.id: id,
        FilmFields.title: title,
        FilmFields.description: description,
        FilmFields.gambar: gambar,
        FilmFields.time: createdTime.toIso8601String(),
      };
}
