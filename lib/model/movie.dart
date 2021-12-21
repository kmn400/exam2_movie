class Movie {
  final String poster;
  final String title;

  Movie({
    required this.poster,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        poster: 'https://image.tmdb.org/t/p/w500' + json['poster_path'],
        title: json['title']);
  }
}
