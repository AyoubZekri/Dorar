import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/datasource/local/saved_verses_data.dart';
import '../core/functions/Snacpar.dart';
import 'ThemeController.dart';
import 'package:audioplayers/audioplayers.dart';

class DorrarSavedVersesController extends GetxController {
  final SavedVersesData savedVersesData = SavedVersesData();
  var savedVerses = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var fontSize = 22.0.obs;

  final AudioPlayer audioPlayer = AudioPlayer();
  var currentlyPlayingId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedVerses();

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        currentlyPlayingId.value = 0;
      }
    });
  }

  void loadSavedVerses() async {
    isLoading.value = true;
    try {
      List<Map<String, dynamic>> res = await savedVersesData.getSavedVerses();
      savedVerses.value = res;
    } catch (e) {
      print("Error loading saved verses: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void removeVerse(int id) async {
    await savedVersesData.deleteSavedVerseById(id);
    savedVerses.removeWhere((verse) => verse['id'] == id);
    showSnackbar('المحفوظات', 'تم إزالة البيت من المحفوظات', Colors.redAccent);
  }

  void copyVerse(String sadr, String ajez) {
    String textToCopy = "$sadr ... $ajez";
    Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {
      showSnackbar('تم النسخ', 'تم نسخ البيت بنجاح', const Color(0xFF114358));
    });
  }

  void editNoteDialog(Map<String, dynamic> verse) async {
    int verseId = verse['verse_id'];
    String? currentNote = await savedVersesData.getSavedVerseNote(verseId);
    TextEditingController noteController = TextEditingController(text: currentNote);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(Get.context!).scaffoldBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF114358).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_note_rounded,
                  color: Color(0xFF114358),
                  size: 40,
                ),
              ),
              const SizedBox(height: 15.0),
              const Text(
                'تعديل الملاحظة',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Color(0xFF114358),
                ),
              ),
              const SizedBox(height: 15.0),
              TextField(
                controller: noteController,
                maxLines: 4,
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'اكتب ملاحظتك الجديدة هنا...',
                  hintStyle: const TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF114358), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'إلغاء',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        String newNote = noteController.text.trim();
                        await savedVersesData.updateSavedVerseNote(verseId, newNote);
                        Get.back();
                        loadSavedVerses(); // Refresh the list
                        showSnackbar('الملاحظات', 'تم تحديث الملاحظة بنجاح', const Color(0xFF114358));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF114358),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'حفظ التعديل',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNoteDialog(String note) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Theme.of(Get.context!).scaffoldBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.note_alt_rounded,
                  color: Colors.orangeAccent,
                  size: 45,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'الملاحظة',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Color(0xFF114358),
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Text(
                  note,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF114358),
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'إغلاق',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void increaseFontSize() {
    if (fontSize.value < 40.0) {
      fontSize.value += 2.0;
    }
  }

  void decreaseFontSize() {
    if (fontSize.value > 14.0) {
      fontSize.value -= 2.0;
    }
  }

  void toggleTheme() {
    ThemeController themeController = Get.find();
    themeController.toggleTheme(!themeController.isDarkMode);
  }

  void toggleAudio(int verseId) async {
    if (currentlyPlayingId.value == verseId) {
      await audioPlayer.pause();
      currentlyPlayingId.value = 0;
    } else {
      try {
        await rootBundle.load('assets/Voices/$verseId.wav');
        await audioPlayer.play(AssetSource('Voices/$verseId.wav'));
        currentlyPlayingId.value = verseId;
      } catch (e) {
        showSnackbar('تنبيه', 'التلاوة غير متوفرة لهذا المقطع', Colors.orange);
      }
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
