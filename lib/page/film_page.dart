import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ets_flutter_ppb/db/film_database.dart';
import 'package:ets_flutter_ppb/model/film.dart';
import 'package:ets_flutter_ppb/page/film_edit_page.dart';
import 'package:ets_flutter_ppb/page/film_detail_page.dart';
import 'package:ets_flutter_ppb/widget/film_card_widget.dart';

class FilmsPage extends StatefulWidget {
  const FilmsPage({super.key});

  @override
  State<FilmsPage> createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  late List<Film> films;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshFilms();
  }

  @override
  void dispose() {
    FilmDatabase.instance.close();

    super.dispose();
  }

  Future refreshFilms() async {
    setState(() => isLoading = true);

    films = await FilmDatabase.instance.readAllFilms();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Films',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : films.isEmpty
                  ? const Text(
                      'No Films',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildFilms(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditFilmPage()),
            );

            refreshFilms();
          },
        ),
      );
  Widget buildFilms() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        films.length,
        (index) {
          final film = films[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FilmDetailPage(filmId: film.id!),
                ));

                refreshFilms();
              },
              child: FilmCardWidget(film: film, index: index),
            ),
          );
        },
      ));
}
