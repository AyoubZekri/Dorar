import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/dorrar_home_controller.dart';
import '../../core/functions/Snacpar.dart';
import '../widget/dorrar_home_widgets.dart';

class DorrarHomePage extends StatelessWidget {
  const DorrarHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DorrarHomeController controller = Get.put(DorrarHomeController());
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark 
                ? [const Color(0xFF111827), const Color(0xFF1F2937)]
                : [const Color(0xFFF5F7FA), const Color(0xFFC3CFE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Header Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF374151) : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/images/Logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'الدرر اللوامع',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF114358),
                        fontFamily: 'Amiri',
                      ),
                    ),
                    Text(
                      'في مقرأ الإمام نافع',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : const Color(0xFF1E6C8E),
                        fontFamily: 'Amiri',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              
              // Buttons Section
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CustomHomeButton(
                      title: 'نبذة عن الكتاب',
                      icon: Icons.info_outline,
                      onTap: () {
                        controller.goToOverview();
                      },
                    ),
                    CustomHomeButton(
                      title: 'الأبواب',
                      icon: Icons.list_alt,
                      onTap: () {
                        controller.goToChapters();
                      },
                    ),
                    CustomHomeButton(
                      title: 'المحفوظات',
                      icon: Icons.bookmark_outline_rounded,
                      onTap: () {
                        controller.goToSavedVerses();
                      },
                    ),
                    CustomHomeButton(
                      title: 'الوضع الليلي',
                      icon: Icons.dark_mode,
                      onTap: () {
                        controller.toggleDarkMode();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
