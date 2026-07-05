import 'package:flutter/material.dart';

class SavedVerseCard extends StatelessWidget {
  final Map<String, dynamic> verse;
  final bool isDark;
  final double currentFontSize;
  final VoidCallback onShowNote;
  final VoidCallback onEditNote;
  final VoidCallback onCopy;
  final VoidCallback onRemove;

  const SavedVerseCard({
    Key? key,
    required this.verse,
    required this.isDark,
    required this.currentFontSize,
    required this.onShowNote,
    required this.onEditNote,
    required this.onCopy,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String note = verse['note'] ?? '';
    bool hasNote = note.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.4) : const Color(0xFF114358).withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              '${verse['verse_id']}',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '${verse['chapter_title'] ?? 'الباب'} | رقم ${verse['verse_id']}',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: isDark ? Colors.white70 : const Color(0xFF114358),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (hasNote)
                          InkWell(
                            onTap: onShowNote,
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(Icons.note_alt_rounded, size: 22, color: Colors.orangeAccent),
                            ),
                          ),
                        InkWell(
                          onTap: onEditNote,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(Icons.edit_note_rounded, size: 24, color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF114358)),
                          ),
                        ),
                        InkWell(
                          onTap: onCopy,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(Icons.copy_rounded, size: 20, color: isDark ? Colors.white54 : Colors.grey[600]),
                          ),
                        ),
                        InkWell(
                          onTap: onRemove,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(Icons.bookmark, size: 22, color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF114358)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  verse['sadr'] ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: currentFontSize,
                    fontWeight: FontWeight.w700,
                    color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF114358),
                    height: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 1, width: 40, color: isDark ? Colors.white24 : Colors.black12),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.star_border_rounded, size: 16, color: Color(0xFFD4AF37)),
                      ),
                      Container(height: 1, width: 40, color: isDark ? Colors.white24 : Colors.black12),
                    ],
                  ),
                ),
                Text(
                  verse['ajez'] ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: currentFontSize,
                    fontWeight: FontWeight.w700,
                    color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF1E6C8E),
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
  }
}
