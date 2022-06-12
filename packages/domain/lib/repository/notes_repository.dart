abstract class NotesRepository {
  const NotesRepository();

  Future<void> saveNote(String note);

  String getNote();
}
