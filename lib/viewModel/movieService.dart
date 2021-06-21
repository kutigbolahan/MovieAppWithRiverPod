import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieWithRiverpod/model/movieModel.dart';
import 'package:movieWithRiverpod/viewModel/environmentConfig.dart';
import 'package:movieWithRiverpod/viewModel/exceptions.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  final config = ref.read(environmentConfigProvider);

  return MovieService(config, Dio());
});

class MovieService {
  final EnvironmentConfig _environmentConfig;
  final Dio _dio;

  MovieService(this._environmentConfig, this._dio);

  Future<List<Movie>> getMovies() async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/movie/popular?api_key=${_environmentConfig.movieApiKey}&languae=en-US&page=1');
      final results = List<Map<String, dynamic>>.from(response.data['results']);
      List<Movie> movies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);
      return movies;
    } on DioError catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }
}
//b5f9b02d0f5d57d2f87ea214b56f63af
