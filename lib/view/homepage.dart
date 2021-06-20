import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieWithRiverpod/model/movieModel.dart';
import 'package:movieWithRiverpod/viewModel/movieService.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = true;
  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovies();
  return movies;
});

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('TMDB'),
      ),
      body: watch(moviesFutureProvider).when(
          error: (e, s) {
            return Text('OPPS!!!');
          },
          loading: () => Center(
                child: CircularProgressIndicator(),
              ),
          data: (movies) {
            return GridView.extent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
              children: movies.map((movie) => Text(movie.title)).toList(),
            );
          }),
    );
  }
}
