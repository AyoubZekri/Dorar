import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/dorrar_chapters_controller.dart';

class DorrarChaptersPage extends StatelessWidget {
  const DorrarChaptersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DorrarChaptersController controller =
        Get.put(DorrarChaptersController());
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
          backgroundColor:
              isDark ? const Color(0xFF111827) : const Color(0xFFF5F7FA),
          appBar: AppBar(
            title: const Text(
              'أبواب الكتاب',
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
          ),
          body: Obx(() {
            if (controller.chapters.isEmpty) {
              return const SizedBox.shrink(); // Instantly loads without flicker
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: controller.chapters.length,
              itemBuilder: (context, index) {
                var chapter = controller.chapters[index];
                int versesCount = (chapter['verses'] as List?)?.length ?? 0;

                return GestureDetector(
                  onTap: () {
                    controller.goToChapter(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      gradient: isDark
                          ? const LinearGradient(
                              colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : const LinearGradient(
                              colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withOpacity(0.5)
                              : const Color(0xFF114358).withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          // Subtle background watermark icon
                          Positioned(
                            left: -15,
                            bottom: -15,
                            child: Icon(
                              Icons.menu_book_rounded,
                              size: 90,
                              color: isDark
                                  ? Colors.white.withOpacity(0.02)
                                  : const Color(0xFF114358).withOpacity(0.03),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                // Elegant gradient circle for chapter index
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    gradient: isDark
                                        ? const LinearGradient(
                                            colors: [
                                              Color(0xFF38BDF8),
                                              Color(0xFF0284C7)
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : const LinearGradient(
                                            colors: [
                                              Color(0xFF114358),
                                              Color(0xFF1E6C8E)
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDark
                                            ? const Color(0xFF0284C7)
                                                .withOpacity(0.4)
                                            : const Color(0xFF114358)
                                                .withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        fontFamily: 'Amiri',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chapter['title'] ?? '',
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : const Color(0xFF114358),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Amiri',
                                          fontSize: 22,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Verses count pill badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? const Color(0xFF334155)
                                                  .withOpacity(0.5)
                                              : const Color(0xFFE2E8F0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons
                                                  .format_list_numbered_rtl_rounded,
                                              size: 14,
                                              color: isDark
                                                  ? Colors.white70
                                                  : const Color(0xFF475569),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '$versesCount بيت',
                                              style: TextStyle(
                                                color: isDark
                                                    ? Colors.white70
                                                    : const Color(0xFF475569),
                                                fontFamily: 'Cairo',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Premium trailing icon
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1F2937)
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isDark
                                          ? const Color(0xFF334155)
                                          : const Color(0xFFE2E8F0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                    color: isDark
                                        ? const Color(0xFF38BDF8)
                                        : const Color(0xFF114358),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), // ClipRRect
                  ), // Container
                ); // GestureDetector
              },
            );
          }));
  }
}
