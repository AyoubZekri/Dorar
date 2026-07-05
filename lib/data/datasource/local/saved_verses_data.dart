import '../../../core/class/Sqldb.dart';

class SavedVersesData {
  SQLDB sqlDb = SQLDB();

  SavedVersesData();

  Future<List<Map<String, dynamic>>> getSavedVerses() async {
    List<Map> res =
        await sqlDb.readData('SELECT * FROM SavedVerses ORDER BY id DESC');
    return List<Map<String, dynamic>>.from(res);
  }

  Future<List<Map<String, dynamic>>> getFavoriteIds() async {
    List<Map> res = await sqlDb.readData('SELECT verse_id FROM SavedVerses');
    return List<Map<String, dynamic>>.from(res);
  }

  Future<int> insertSavedVerse(Map<String, dynamic> data) async {
    String chapterTitle = data['chapter_title'] ?? '';
    String sadr = data['sadr'] ?? '';
    String ajez = data['ajez'] ?? '';
    String note = data['note'] ?? '';
    int verseId = data['verse_id'];

    sadr = sadr.replaceAll("'", "''");
    ajez = ajez.replaceAll("'", "''");
    note = note.replaceAll("'", "''");
    chapterTitle = chapterTitle.replaceAll("'", "''");

    return await sqlDb.insertData('''
      INSERT INTO SavedVerses (verse_id, chapter_title, sadr, ajez, note)
      VALUES ($verseId, '$chapterTitle', '$sadr', '$ajez', '$note')
    ''');
  }

  Future<int> deleteSavedVerseById(int id) async {
    return await sqlDb.deleteData('DELETE FROM SavedVerses WHERE id = $id');
  }

  Future<String?> getSavedVerseNote(int verseId) async {
    List<Map> res = await sqlDb.readData('SELECT note FROM SavedVerses WHERE verse_id = $verseId');
    if (res.isNotEmpty) {
      return res.first['note'];
    }
    return null;
  }

  Future<int> updateSavedVerseNote(int verseId, String note) async {
    note = note.replaceAll("'", "''");
    return await sqlDb.updateData("UPDATE SavedVerses SET note = '$note' WHERE verse_id = $verseId", []);
  }

  Future<int> deleteSavedVerseByVerseId(int verseId) async {
    return await sqlDb
        .deleteData('DELETE FROM SavedVerses WHERE verse_id = $verseId');
  }
}
