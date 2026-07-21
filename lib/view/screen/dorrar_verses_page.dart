import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/dorrar_verses_controller.dart';
import '../../controller/ThemeController.dart';

class DorrarVersesPage extends StatelessWidget {
  const DorrarVersesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DorrarVersesController controller = Get.put(DorrarVersesController());
    final ThemeController themeController = Get.find();

    return Obx(() {
      bool isDark = themeController.isDarkMode;
      double currentFontSize = controller.fontSize.value; // Register dependency

      return Scaffold(
          backgroundColor:
              isDark ? const Color(0xFF111827) : const Color(0xFFF5F7FA),
          appBar: AppBar(
            title: const Text(
              'الأبيات',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            backgroundColor:
                isDark ? const Color(0xFF1F2937) : const Color(0xFF114358),
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
                icon: const Icon(Icons.remove_circle_outline,
                    color: Colors.white),
                onPressed: () => controller.decreaseFontSize(),
              ),
              IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode,
                    color: Colors.white),
                onPressed: () {
                  controller.toggleTheme();
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Beautiful Chapter Header
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? const LinearGradient(
                          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : const LinearGradient(
                          colors: [Color(0xFF114358), Color(0xFF1E6C8E)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.5)
                          : const Color(0xFF114358).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        controller.chapter['title'] ?? 'بدون عنوان',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Amiri',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Verses List
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(15),
                  itemCount:
                      (controller.chapter['verses'] as List?)?.length ?? 0,
                  itemBuilder: (context, index) {
                    var verse = controller.chapter['verses'][index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.4)
                                : const Color(0xFF114358).withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Watermark of Verse ID
                          Positioned(
                            left: 10,
                            top: 10,
                            child: Text(
                              '${verse['id']}',
                              style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white.withOpacity(0.03)
                                    : const Color(0xFF114358).withOpacity(0.03),
                                fontFamily: 'Amiri',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                // Top action bar
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? const Color(0xFF334155)
                                            : const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        'البيت ${verse['id']}',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: isDark
                                              ? Colors.white70
                                              : const Color(0xFF114358),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                      Row(
                                        children: [
                                          Obx(() {
                                            bool isPlaying = controller.currentlyPlayingId.value == verse['id'];
                                            return InkWell(
                                              onTap: () => controller.toggleAudio(verse['id']),
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: Icon(
                                                  isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                                                  size: 24,
                                                  color: isPlaying
                                                      ? Colors.green
                                                      : (isDark ? Colors.white54 : const Color(0xFF114358).withOpacity(0.7)),
                                                ),
                                              ),
                                            );
                                          }),
                                          const SizedBox(width: 8),
                                          InkWell(
                                            onTap: () => controller.copyVerse(
                                                verse['sadr'] ?? '',
                                                verse['ajez'] ?? ''),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Icon(Icons.copy_rounded,
                                                  size: 20,
                                                  color: isDark
                                                      ? Colors.white54
                                                      : Colors.grey[600]),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Obx(() {
                                          bool isFav = controller.favoriteVerses
                                              .contains(verse['id']);
                                          return Row(
                                            children: [
                                              if (isFav)
                                                InkWell(
                                                  onTap: () => controller
                                                      .editNoteDialog(verse),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Icon(
                                                        Icons.edit_note_rounded,
                                                        size: 24,
                                                        color: isDark
                                                            ? const Color(
                                                                0xFF38BDF8)
                                                            : const Color(
                                                                0xFF114358)),
                                                  ),
                                                ),
                                              if (isFav)
                                                const SizedBox(width: 4),
                                              InkWell(
                                                onTap: () => controller
                                                    .toggleFavorite(verse),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Icon(
                                                    isFav
                                                        ? Icons.bookmark
                                                        : Icons
                                                            .bookmark_outline_rounded,
                                                    size: 22,
                                                    color: isFav
                                                        ? (isDark
                                                            ? const Color(
                                                                0xFF38BDF8)
                                                            : const Color(
                                                                0xFF114358))
                                                        : (isDark
                                                            ? Colors.white54
                                                            : const Color(
                                                                    0xFF114358)
                                                                .withOpacity(
                                                                    0.5)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),

                                // Sadr (First half)
                                Text(
                                  verse['sadr'] ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: currentFontSize,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? const Color(0xFFF8FAFC)
                                        : const Color(0xFF114358),
                                    height: 1.5,
                                  ),
                                ),

                                // Elegant Separator
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 1,
                                          width: 40,
                                          color: isDark
                                              ? Colors.white24
                                              : Colors.black12),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Icon(Icons.star_border_rounded,
                                            size: 16,
                                            color: Color(
                                                0xFFD4AF37)), // Golden touch
                                      ),
                                      Container(
                                          height: 1,
                                          width: 40,
                                          color: isDark
                                              ? Colors.white24
                                              : Colors.black12),
                                    ],
                                  ),
                                ),

                                // Ajez (Second half)
                                Text(
                                  verse['ajez'] ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: currentFontSize,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? const Color(0xFFCBD5E1)
                                        : const Color(0xFF1E6C8E),
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
    );
    });
  }
}

