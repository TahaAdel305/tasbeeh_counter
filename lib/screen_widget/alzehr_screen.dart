import 'package:flutter/material.dart';
import 'package:tasbeeh_counter/core/adhkar_data.dart';
import 'package:tasbeeh_counter/core/theme/app_color.dart';

class alzehr_screen extends StatefulWidget {
  const alzehr_screen({super.key});

  @override
  State<alzehr_screen> createState() => _alzehr_screenState();
}

class _alzehr_screenState extends State<alzehr_screen> {
  late final Future<List<ZikrCategory>> _future;

  @override
  void initState() {
    super.initState();
    _future = loadAdhkar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<ZikrCategory>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('حصل خطأ: ${snapshot.error}'));
            }
            return _CategoriesBody(categories: snapshot.data!);
          },
        ),
      ),
    );
  }
}

IconData _iconFor(String name) {
  if (name.contains('الصباح والمساء')) return Icons.wb_sunny_outlined;
  if (name.contains('الاستيقاظ')) return Icons.wb_twilight;
  if (name.contains('النوم')) return Icons.bedtime_outlined;
  if (name.contains('بعد السلام من الصلاة')) return Icons.mosque_outlined;
  return Icons.menu_book_outlined;
}

class _CategoriesBody extends StatelessWidget {
  final List<ZikrCategory> categories;

  const _CategoriesBody({required this.categories});

  static bool _isMain(ZikrCategory c) =>
      c.name.contains('الصباح والمساء') ||
      c.name.contains('أذكار النوم') ||
      c.name.contains('الاستيقاظ من النوم') ||
      c.name.contains('بعد السلام من الصلاة');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? appcolor.navigationBarDark
        : appcolor.navigationBarLight;

    final accent = isDark ? const Color(0xFF8CCBB3) : const Color(0xFF1F5A4A);

    final mainList = categories.where(_isMain).toList();
    final others = categories.where((c) => !_isMain(c)).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        children: [
          const Text(
            'الأذكار',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          const Text('من كتاب حصن المسلم', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'ابحث في الأذكار',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: cardColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: accent, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'الأذكار الأساسية',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final c in mainList)
                _MainCard(category: c, color: cardColor, accent: accent),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'كل الفئات',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          for (final c in others)
            ListTile(
              title: Text(c.name),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
        ],
      ),
    );
  }
}

class _MainCard extends StatelessWidget {
  final ZikrCategory category;
  final Color color;
  final Color accent;

  const _MainCard({
    required this.category,
    required this.color,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x1F1F5A4A),
                ),
                child: Icon(_iconFor(category.name), color: accent),
              ),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
