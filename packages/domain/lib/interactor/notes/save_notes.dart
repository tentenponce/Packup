import 'package:domain/base/use_case.dart';
import 'package:domain/repository/notes_repository.dart';

class SaveNotes extends UseCase<String, void> {
  SaveNotes({
    required NotesRepository notesRepository,
  }) : _notesRepository = notesRepository;

  final NotesRepository _notesRepository;

  @override
  Future<void> invoke(String param) {
    return _notesRepository.saveNote(param);
  }
}
