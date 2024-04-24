import 'package:flutter/material.dart';
import 'package:ets_flutter_ppb/db/film_database.dart';
import 'package:ets_flutter_ppb/model/film.dart';
import 'package:ets_flutter_ppb/widget/film_form_widget.dart';

class AddEditFilmPage extends StatefulWidget {
  final Film? film;

  const AddEditFilmPage({
    Key? key,
    this.film,
  }) : super(key: key);

  @override
  State<AddEditFilmPage> createState() => _AddEditFilmPageState();
}

class _AddEditFilmPageState extends State<AddEditFilmPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.film?.title ?? '';
    description = widget.film?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: FilmFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateFilm,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateFilm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.film != null;

      if (isUpdating) {
        await updateFilm();
      } else {
        await addFilm();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateFilm() async {
    final film = widget.film!.copy(
      title: title,
      description: description,
    );

    await FilmDatabase.instance.update(film);
  }

  Future addFilm() async {
    final film = Film(
      title: title,
      description: description,
      gambar: "testing",
      createdTime: DateTime.now(),
    );

    await FilmDatabase.instance.create(film);
  }
}
