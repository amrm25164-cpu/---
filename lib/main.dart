
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const NoorAlQuranApp());
}

class NoorAlQuranApp extends StatefulWidget {
  const NoorAlQuranApp({super.key});

  @override
  State<NoorAlQuranApp> createState() => _NoorAlQuranAppState();
}

class _NoorAlQuranAppState extends State<NoorAlQuranApp> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نور القرآن',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F5EF),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(
        darkMode: darkMode,
        onThemeChanged: (value) {
          setState(() => darkMode = value);
        },
      ),
    );
  }
}

class Surah {
  final int number;
  final String name;
  final int verses;

  const Surah(this.number, this.name, this.verses);
}

const List<Surah> surahs = [
  Surah(1, 'الفاتحة', 7),
  Surah(2, 'البقرة', 286),
  Surah(3, 'آل عمران', 200),
  Surah(4, 'النساء', 176),
  Surah(5, 'المائدة', 120),
  Surah(6, 'الأنعام', 165),
  Surah(7, 'الأعراف', 206),
  Surah(8, 'الأنفال', 75),
  Surah(9, 'التوبة', 129),
  Surah(10, 'يونس', 109),
  Surah(11, 'هود', 123),
  Surah(12, 'يوسف', 111),
  Surah(13, 'الرعد', 43),
  Surah(14, 'إبراهيم', 52),
  Surah(15, 'الحجر', 99),
  Surah(16, 'النحل', 128),
  Surah(17, 'الإسراء', 111),
  Surah(18, 'الكهف', 110),
  Surah(19, 'مريم', 98),
  Surah(20, 'طه', 135),
  Surah(21, 'الأنبياء', 112),
  Surah(22, 'الحج', 78),
  Surah(23, 'المؤمنون', 118),
  Surah(24, 'النور', 64),
  Surah(25, 'الفرقان', 77),
  Surah(26, 'الشعراء', 227),
  Surah(27, 'النمل', 93),
  Surah(28, 'القصص', 88),
  Surah(29, 'العنكبوت', 69),
  Surah(30, 'الروم', 60),
  Surah(31, 'لقمان', 34),
  Surah(32, 'السجدة', 30),
  Surah(33, 'الأحزاب', 73),
  Surah(34, 'سبأ', 54),
  Surah(35, 'فاطر', 45),
  Surah(36, 'يس', 83),
  Surah(37, 'الصافات', 182),
  Surah(38, 'ص', 88),
  Surah(39, 'الزمر', 75),
  Surah(40, 'غافر', 85),
  Surah(41, 'فصلت', 54),
  Surah(42, 'الشورى', 53),
  Surah(43, 'الزخرف', 89),
  Surah(44, 'الدخان', 59),
  Surah(45, 'الجاثية', 37),
  Surah(46, 'الأحقاف', 35),
  Surah(47, 'محمد', 38),
  Surah(48, 'الفتح', 29),
  Surah(49, 'الحجرات', 18),
  Surah(50, 'ق', 45),
  Surah(51, 'الذاريات', 60),
  Surah(52, 'الطور', 49),
  Surah(53, 'النجم', 62),
  Surah(54, 'القمر', 55),
  Surah(55, 'الرحمن', 78),
  Surah(56, 'الواقعة', 96),
  Surah(57, 'الحديد', 29),
  Surah(58, 'المجادلة', 22),
  Surah(59, 'الحشر', 24),
  Surah(60, 'الممتحنة', 13),
  Surah(61, 'الصف', 14),
  Surah(62, 'الجمعة', 11),
  Surah(63, 'المنافقون', 11),
  Surah(64, 'التغابن', 18),
  Surah(65, 'الطلاق', 12),
  Surah(66, 'التحريم', 12),
  Surah(67, 'الملك', 30),
  Surah(68, 'القلم', 52),
  Surah(69, 'الحاقة', 52),
  Surah(70, 'المعارج', 44),
  Surah(71, 'نوح', 28),
  Surah(72, 'الجن', 28),
  Surah(73, 'المزمل', 20),
  Surah(74, 'المدثر', 56),
  Surah(75, 'القيامة', 40),
  Surah(76, 'الإنسان', 31),
  Surah(77, 'المرسلات', 50),
  Surah(78, 'النبأ', 40),
  Surah(79, 'النازعات', 46),
  Surah(80, 'عبس', 42),
  Surah(81, 'التكوير', 29),
  Surah(82, 'الانفطار', 19),
  Surah(83, 'المطففين', 36),
  Surah(84, 'الانشقاق', 25),
  Surah(85, 'البروج', 22),
  Surah(86, 'الطارق', 17),
  Surah(87, 'الأعلى', 19),
  Surah(88, 'الغاشية', 26),
  Surah(89, 'الفجر', 30),
  Surah(90, 'البلد', 20),
  Surah(91, 'الشمس', 15),
  Surah(92, 'الليل', 21),
  Surah(93, 'الضحى', 11),
  Surah(94, 'الشرح', 8),
  Surah(95, 'التين', 8),
  Surah(96, 'العلق', 19),
  Surah(97, 'القدر', 5),
  Surah(98, 'البينة', 8),
  Surah(99, 'الزلزلة', 8),
  Surah(100, 'العاديات', 11),
  Surah(101, 'القارعة', 11),
  Surah(102, 'التكاثر', 8),
  Surah(103, 'العصر', 3),
  Surah(104, 'الهمزة', 9),
  Surah(105, 'الفيل', 5),
  Surah(106, 'قريش', 4),
  Surah(107, 'الماعون', 7),
  Surah(108, 'الكوثر', 3),
  Surah(109, 'الكافرون', 6),
  Surah(110, 'النصر', 3),
  Surah(111, 'المسد', 5),
  Surah(112, 'الإخلاص', 4),
  Surah(113, 'الفلق', 5),
  Surah(114, 'الناس', 6),
];

class HomePage extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomePage({
    super.key,
    required this.darkMode,
    required this.onThemeChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  String search = '';
  Set<int> favorites = {};
  int lastSurah = 1;

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      favorites = (prefs.getStringList('favorites') ?? [])
          .map((e) => int.tryParse(e) ?? 0)
          .where((e) => e > 0)
          .toSet();
      lastSurah = prefs.getInt('lastSurah') ?? 1;
    });
  }

  Future<void> toggleFavorite(int number) async {
    setState(() {
      if (favorites.contains(number)) {
        favorites.remove(number);
      } else {
        favorites.add(number);
      }
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'favorites',
      favorites.map((e) => e.toString()).toList(),
    );
  }

  void openSurah(Surah surah) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SurahReader(surah: surah),
      ),
    ).then((_) => loadSavedData());
  }

  @override
  Widget build(BuildContext context) {
    final filtered = surahs.where((surah) {
      return surah.name.contains(search) ||
          surah.number.toString() == search.trim();
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'نور القرآن',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'الوضع الليلي',
            onPressed: () =>
                widget.onThemeChanged(!widget.darkMode),
            icon: Icon(
              widget.darkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedTab,
        children: [
          buildHome(filtered),
          buildFavorites(),
          const AzkarPage(),
          buildSettings(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() => selectedTab = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'القرآن',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'المفضلة',
          ),
          NavigationDestination(
            icon: Icon(Icons.spa),
            label: 'الأذكار',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }

  Widget buildHome(List<Surah> filtered) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF00695C), Color(0xFF26A69A)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'اقرأ القرآن الكريم واذكر الله',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed: () => openSurah(surahs[lastSurah - 1]),
                icon: const Icon(Icons.play_arrow),
                label: const Text('متابعة القراءة'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            textDirection: TextDirection.rtl,
            onChanged: (value) => setState(() => search = value),
            decoration: InputDecoration(
              hintText: 'ابحث عن سورة...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final surah = filtered[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${surah.number}'),
                ),
                title: Text(
                  surah.name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${surah.verses} آية',
                  textAlign: TextAlign.right,
                ),
                trailing: IconButton(
                  icon: Icon(
                    favorites.contains(surah.number)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favorites.contains(surah.number)
                        ? Colors.red
                        : null,
                  ),
                  onPressed: () => toggleFavorite(surah.number),
                ),
                onTap: () => openSurah(surah),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildFavorites() {
    final list = surahs
        .where((surah) => favorites.contains(surah.number))
        .toList();

    if (list.isEmpty) {
      return const Center(
        child: Text('لم تضف أي سورة للمفضلة بعد'),
      );
    }

    return ListView(
      children: list.map((surah) {
        return ListTile(
          leading: const Icon(Icons.favorite, color: Colors.red),
          title: Text(surah.name, textAlign: TextAlign.right),
          onTap: () => openSurah(surah),
        );
      }).toList(),
    );
  }

  Widget buildSettings() {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('الوضع الليلي'),
          secondary: const Icon(Icons.dark_mode),
          value: widget.darkMode,
          onChanged: widget.onThemeChanged,
        ),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('عن التطبيق'),
          subtitle: Text('نور القرآن - الإصدار 1.0.0'),
        ),
      ],
    );
  }
}

class SurahReader extends StatefulWidget {
  final Surah surah;

  const SurahReader({super.key, required this.surah});

  @override
  State<SurahReader> createState() => _SurahReaderState();
}

class _SurahReaderState extends State<SurahReader> {
  List<dynamic> verses = [];
  bool loading = true;
  String? error;
  double fontSize = 25.0;
  final AudioPlayer player = AudioPlayer();
  int? playingVerse;

  @override
  void initState() {
    super.initState();
    loadSurah();
    player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => playingVerse = null);
    });
  }

  Future<void> loadSurah() async {
    try {
      final url = Uri.parse(
        'https://api.alquran.cloud/v1/surah/${widget.surah.number}/quran-uthmani',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 25),
      );

      if (response.statusCode != 200) {
        throw Exception('تعذر تحميل السورة');
      }

      final data = jsonDecode(response.body);
      final loaded = data['data']['ayahs'] as List<dynamic>;

      if (!mounted) return;

      setState(() {
        verses = loaded;
        loading = false;
        error = null;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('lastSurah', widget.surah.number);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        loading = false;
        error = 'تعذر تحميل القرآن. تأكد من اتصال الإنترنت وحاول مرة أخرى.';
      });
    }
  }

  Future<void> playVerse(int index) async {
    try {
      if (playingVerse == index) {
        await player.stop();
        if (mounted) setState(() => playingVerse = null);
        return;
      }

      final number = verses[index]['number'];
      final url = Uri.parse(
        'https://api.alquran.cloud/v1/ayah/$number/ar.alafasy',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 20),
      );

      if (response.statusCode != 200) {
        throw Exception('تعذر تحميل الصوت');
      }

      final data = jsonDecode(response.body);
      final audioUrl = data['data']['audio'] as String;

      await player.stop();
      await player.play(UrlSource(audioUrl));

      if (mounted) setState(() => playingVerse = index);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر تشغيل الصوت، حاول مرة أخرى')),
      );
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سورة ${widget.surah.name}'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'تصغير الخط',
            onPressed: () {
              setState(() {
                fontSize = (fontSize - 2).clamp(14.0, 40.0).toDouble();
              });
            },
            icon: const Icon(Icons.text_decrease),
          ),
          IconButton(
            tooltip: 'تكبير الخط',
            onPressed: () {
              setState(() {
                fontSize = (fontSize + 2).clamp(14.0, 40.0).toDouble();
              });
            },
            icon: const Icon(Icons.text_increase),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(error!, textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              loading = true;
                              error = null;
                            });
                            loadSurah();
                          },
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (widget.surah.number != 1 &&
                        widget.surah.number != 9)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ...List.generate(verses.length, (index) {
                      final verse = verses[index];
                      final text = verse['text'] as String;
                      final verseNumber = verse['numberInSurah'];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                text,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  height: 2.0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    child: Text('$verseNumber'),
                                  ),
                                  IconButton(
                                    tooltip: 'تشغيل أو إيقاف الصوت',
                                    onPressed: () => playVerse(index),
                                    icon: Icon(
                                      playingVerse == index
                                          ? Icons.stop_circle
                                          : Icons.play_circle_fill,
                                      color: Colors.teal,
                                      size: 32,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
    );
  }
}

class AzkarPage extends StatefulWidget {
  const AzkarPage({super.key});

  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  int counter = 0;

  final List<String> azkar = const [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
    'لا إله إلا الله',
    'أستغفر الله العظيم وأتوب إليه',
    'اللهم صل وسلم على نبينا محمد',
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Icon(Icons.spa, size: 70, color: Colors.teal),
        const SizedBox(height: 20),
        const Text(
          'عداد التسبيح',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<int>(
          value: selected,
          decoration: const InputDecoration(
            labelText: 'اختر الذكر',
            border: OutlineInputBorder(),
          ),
          items: List.generate(
            azkar.length,
            (index) => DropdownMenuItem(
              value: index,
              child: Text(azkar[index]),
            ),
          ),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selected = value;
                counter = 0;
              });
            }
          },
        ),
        const SizedBox(height: 30),
        Text(
          '$counter',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => setState(() => counter++),
          child: const Padding(
            padding: EdgeInsets.all(14),
            child: Text('تسبيح +1', style: TextStyle(fontSize: 20)),
          ),
        ),
        OutlinedButton(
          onPressed: () => setState(() => counter = 0),
          child: const Text('إعادة العداد'),
        ),
        const SizedBox(height: 16),
        Text(
          azkar[selected],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 23),
        ),
      ],
    );
  }
}