import 'package:data/source/local_source.dart';
import 'package:domain/repository/notes_repository.dart';

class NotesRepositoryImpl extends NotesRepository {
  NotesRepositoryImpl({
    required LocalSource localSource,
  }) : _localSource = localSource;

  final LocalSource _localSource;

  @override
  String getNote() {
    return _localSource.get(LocalSource.KEY_GENERAL_NOTES);
  }

  @override
  Future<void> saveNote(String note) {
    return _localSource.save(LocalSource.KEY_GENERAL_NOTES, note);
  }
}
