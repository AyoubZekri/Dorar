import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/dorrar_saved_verses_controller.dart';
import '../../controller/ThemeController.dart';
import '../widget/dorrar_saved_verses/saved_verse_card.dart';

class DorrarSavedVersesPage extends StatelessWidget {
  const DorrarSavedVersesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DorrarSavedVersesController controller = Get.put(DorrarSavedVersesController());
    final ThemeController themeController = Get.find();

    return Obx(() {
      bool isDark = themeController.isDarkMode;
      double currentFontSize = controller.fontSize.value;

      return Scaffold(
          backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF5F7FA),
          appBar: AppBar(
            title: const Text(
              'المحفوظات',
              style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: isDark ? const Color(0xFF1F2937) : const Color(0xFF114358),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                onPressed: () => controller.increaseFontSize(),
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                onPressed: () => controller.decreaseFontSize(),
              ),
              IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
                onPressed: () => controller.toggleTheme(),
              ),
            ],
          ),
          body: controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.savedVerses.isEmpty
                  ? Center(
                      child: Text(
                        'لا توجد أبيات محفوظة بعد',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(15),
                      itemCount: controller.savedVerses.length,
                      itemBuilder: (context, index) {
                        var verse = controller.savedVerses[index];
                        String note = verse['note'] ?? '';

                        return Obx(() {
                          bool isPlaying = controller.currentlyPlayingId.value == verse['verse_id'];
                          return SavedVerseCard(
                            verse: verse,
                            isDark: isDark,
                            currentFontSize: currentFontSize,
                            isPlaying: isPlaying,
                            onToggleAudio: () => controller.toggleAudio(verse['verse_id']),
                            onShowNote: () => controller.showNoteDialog(note),
                            onEditNote: () => controller.editNoteDialog(verse),
                            onCopy: () => controller.copyVerse(verse['sadr'] ?? '', verse['ajez'] ?? ''),
                            onRemove: () => controller.removeVerse(verse['id']),
                          );
                        });
                      },
                    ),
      );
    });
  }
}
