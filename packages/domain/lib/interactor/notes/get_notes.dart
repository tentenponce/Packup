import 'package:domain/base/use_case_no_param.dart';
import 'package:domain/repository/notes_repository.dart';

class GetNotes extends UseCaseNoParam<String> {
  GetNotes({
    required NotesRepository notesRepository,
  }) : _notesRepository = notesRepository;

  final NotesRepository _notesRepository;

  @override
  Future<String> invoke() {
    return Future.value(_notesRepository.getNote());
  }
}
