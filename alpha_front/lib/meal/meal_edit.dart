import 'package:flutter/material.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:alpha_front/layout.dart';
import 'package:intl/intl.dart'; // 날짜 포맷(yyyy-MM-dd, M.d(EEE))용

/// MEAL EDIT SCREEN – 아침/점심/저녁 식단 편집
/// --------------------------------------------------------------
///   • ⊕ 버튼으로 빈 카드 추가
///   • 카드 ✎‧✔ 토글 (편집 / 저장 / POST 여부)
///   • 상단 탭(아침‧점심‧저녁) 네비게이션
///   • 하단 "식단 저장" → 현재 탭 카드만 POST (postRealEat / foodinfo)
///   • imageUrl == null ⇒ assets/character.png
///   • amount 변경 시 총 kcal = baseKcal × amount
///   • 카드 배경 White, TextField 글꼴 14
///   • 파일명만 내려오는 이미지 경로 → ApiService.imageBase + 파일명 (CORS 해결)
///   • CORS 차단 시 placeholder 로 graceful‑fallback
/// --------------------------------------------------------------

class MealEdit extends StatefulWidget {
  final int initialIndex;
  final List<Map<String, dynamic>> recommendBreakfastList;
  final List<Map<String, dynamic>> recommendLunchList;
  final List<Map<String, dynamic>> recommendDinnerList;
  final Map<String, dynamic>? fetchedRealEatData;

  // (선택) 실제 섭취 kcal 등을 불러오고 싶다면 날짜를 넘겨받자
  final String mealDate;

  const MealEdit({
    super.key,
    required this.initialIndex,
    required this.recommendBreakfastList,
    required this.recommendLunchList,
    required this.recommendDinnerList,
    required this.mealDate,
    this.fetchedRealEatData,
  });

  @override
  State<MealEdit> createState() => _MealEditState();
}

class _MealEditState extends State<MealEdit> {
  // ───────────────── 탭 & 카드 리스트 ─────────────────
  late final PageController _pageController;
  late int _idx;

  late final List<MealCardData> _breakfast;
  late final List<MealCardData> _lunch;
  late final List<MealCardData> _dinner;

  // (옵션) 실제 섭취 kcal 정보만 필요하면 여기서 GET
Map<String, List<Map<String, dynamic>>> _dateKcal = {};

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex - 1;
    _pageController = PageController(initialPage: _idx);


    // ⬇︎ HomeScreen 에서 이미 만든 리스트 그대로 카드화
    _breakfast =
        widget.recommendBreakfastList.map(MealCardData.fromRecommend).toList();
    _lunch = widget.recommendLunchList.map(MealCardData.fromRecommend).toList();
    _dinner =
        widget.recommendDinnerList.map(MealCardData.fromRecommend).toList();
      _appendFetchedRealEatData(widget.fetchedRealEatData ?? {});
      setState(() {}); 

    // // ⬇︎ “실제 섭취 kcal” 만 필요하다면 가볍게 한 번만 GET
    // _loadRealEatKcal();
  }

  Future<void> _loadRealEatKcal() async {
  try {
    List<dynamic> rawData = await ApiService.fetchkcalData(widget.mealDate);

    final Map<String, List<Map<String, dynamic>>> kcalData = {};

    for (final meal in rawData) {
      if (meal is! Map<String, dynamic>) continue;

      final mealType = meal['mealType'] as String?;
      if (mealType == null) continue;

      kcalData.putIfAbsent(mealType, () => []);
      kcalData[mealType]!.add(meal);
    }

    setState(() {
      _dateKcal = kcalData;
    });
  } catch (e) {
    debugPrint('fetchkcalData 실패: $e');
  }
}

void _appendFetchedRealEatData(Map<String, dynamic> fetchedRealEatData) {
  if (fetchedRealEatData.isEmpty) return;

  fetchedRealEatData.forEach((key, value) {
    final mealType = key.toUpperCase();
    final List<dynamic> meals = value;

    for (final meal in meals) {
      final mealData = MealCardData(
        name: meal['mealName'] ?? '', // 수정
        baseKcal: (meal['calories'] ?? 0).toDouble(), // 수정
        amountStr: (meal['amount'] ?? '1').toString(), // 실제 데이터에 없으면 '1'
        imageUrl: meal['mealPhoto'] ?? null, // 수정
        isPosting: true,
        isEditing: false,
        isChecked: true,
        fromRecommend: false,
          );
      switch (mealType) {
        case 'BREAKFAST':
          _breakfast.add(mealData);
          break;
        case 'LUNCH':
          _lunch.add(mealData);
          break;
        case 'DINNER':
          _dinner.add(mealData);
          break;
        default:
          break;
      }
    }
  });
}


  //------------------------------------------------------------------
  // SAVE -------------------------------------------------------------
  //------------------------------------------------------------------
  Future<void> _save() async {
    final now = DateTime.now();
    List<MealCardData> list;
    String mealType;
    switch (_idx) {
      case 0:
        list = _breakfast;
        mealType = 'BREAKFAST';
        break;
      case 1:
        list = _lunch;
        mealType = 'LUNCH';
        break;
      default:
        list = _dinner;
        mealType = 'DINNER';
    }

    for (final card in list) {
      if (!card.isPosting) continue;
      if (card.fromRecommend) {
        await ApiService.postRealEat(
          recipeId: card.recipeId!,
          mealDate: now,
          mealType: mealType,
          calories: card.totalKcal,
        );
      } else {
        await ApiService.foodinfo(
          card.name,
          card.totalKcal,
          card.amountStr,
          now,
          mealType,
          card.imageUrl ?? '',
        );
      }
    }

    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Layout()));
  }

  //------------------------------------------------------------------
  // UI ---------------------------------------------------------------
  //------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(33.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: BaseAppBar(title: '식단 편집', appBar: AppBar()),
        body: Column(
          children: [
            _MealTabs(
                current: _idx,
                onTap: (i) {
                  _pageController.animateToPage(i,
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOut);
                }),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (v) => setState(() => _idx = v),
                children: [
                  MealListEditor(items: _breakfast),
                  MealListEditor(items: _lunch),
                  MealListEditor(items: _dinner),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3CB196),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _save,
                  child:
                      const Text('식단 저장', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//====================================================================
// MEAL TABS ----------------------------------------------------------
//====================================================================
class _MealTabs extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;
  const _MealTabs({required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const labels = ['아침', '점심', '저녁'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: List.generate(3, (i) {
          final sel = i == current;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: sel ? const Color(0xff3CB196) : Colors.white,
                  side: const BorderSide(color: Color(0xff3CB196)),
                ),
                onPressed: () => onTap(i),
                child: Text(labels[i],
                    style: TextStyle(
                      fontFamily: 'Pretendard-regular',
                      fontSize: 16,
                      color: sel ? Colors.white : const Color(0xff3CB196),
                    )),
              ),
            ),
          );
        }),
      ),
    );
  }
}

//====================================================================
// LIST EDITOR --------------------------------------------------------
//====================================================================
class MealListEditor extends StatefulWidget {
  final List<MealCardData> items;
  const MealListEditor({super.key, required this.items});

  @override
  State<MealListEditor> createState() => _MealListEditorState();
}

class _MealListEditorState extends State<MealListEditor> {
  void _addBlank() => setState(() => widget.items.add(MealCardData.blank()));

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      itemCount: widget.items.length + 1,
      itemBuilder: (c, i) => i == widget.items.length
          ? Center(
              child: IconButton(
                icon: const Icon(Icons.add_circle,
                    size: 36, color: Color(0xff3CB196)),
                onPressed: _addBlank,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MealCard(
                data: widget.items[i],
                onChanged: () => setState(() {}),
              ),
            ),
    );
  }
}

//====================================================================
// MODEL --------------------------------------------------------------
//====================================================================
class MealCardData {
  bool isEditing;
  bool isPosting;
  bool fromRecommend;
  int? recipeId;
  String? imageUrl;
  bool isChecked;

  String name;
  String amountStr;
  double baseKcal;

  MealCardData({
    this.isEditing = false,
    this.isPosting = false,
    this.fromRecommend = false,
    this.recipeId,
    this.imageUrl,
    this.isChecked = false,
    required this.name,
    required this.amountStr,
    required this.baseKcal,
  });

  factory MealCardData.fromDayData(Map<String, dynamic> j) => MealCardData(
        name: j['name'] ?? '',
        amountStr: (j['amount'] ?? '1').toString(),
        baseKcal: (j['calories'] as num?)?.toDouble() ?? 0,
        imageUrl: _resolveImage(j['imageUrl'] as String?),
        isEditing: false,
        isPosting: false,
      );

  /// 총 kcal = 1인분 kcal × 인분수
  double get totalKcal =>
      baseKcal * (int.tryParse(amountStr.isEmpty ? '1' : amountStr) ?? 1);

  // 이미지 경로 보정 (CORS-safe CDN prefix)
  static const String _cdnBase =
      'https://cdn.example.com/'; // TODO: 실제 CDN 도메인으로 교체
  static String? _resolveImage(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    if (raw.startsWith('http')) return raw;
    return _cdnBase + raw;
  }

  factory MealCardData.fromRecommend(Map<String, dynamic> j) => MealCardData(
        fromRecommend: true,
        recipeId: j['id'] as int?,
        imageUrl: j['foodImage'],
        name: j['name'] ?? '',
        amountStr: (j['amount'] ?? '1').toString(),
        baseKcal: (j['calories'] as num).toDouble(),
      );

  factory MealCardData.blank() => MealCardData(
        isEditing: true,
        name: '',
        amountStr: '1',
        baseKcal: 0,
      );
}

//====================================================================
// CARD ---------------------------------------------------------------
//====================================================================
class MealCard extends StatefulWidget {
  final MealCardData data;
  final VoidCallback onChanged;
  const MealCard({super.key, required this.data, required this.onChanged});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _amountCtrl;
  late final TextEditingController _kcalCtrl;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.data.name);
    _amountCtrl = TextEditingController(text: widget.data.amountStr);
    _kcalCtrl = TextEditingController(
        text: widget.data.baseKcal == 0 ? '' : widget.data.baseKcal.toString());
    loadImage(widget.data.imageUrl.toString());
  }

  Future<void> loadImage(String imagePath) async {
    try {
      final result = await ApiService.getImage(imagePath);
      imageUrl = result;
    } catch (e) {
      debugPrint('이미지 불러오기 실패: $e');
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    _kcalCtrl.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (widget.data.isEditing) {
        widget.data
          ..name = _nameCtrl.text
          ..amountStr = _amountCtrl.text.isEmpty ? '1' : _amountCtrl.text
          ..baseKcal = double.tryParse(_kcalCtrl.text) ?? widget.data.baseKcal;
      }
      widget.data.isEditing = !widget.data.isEditing;
      widget.onChanged();
    });
  }

  void _togglePost() {
    setState(() {
      widget.data.isPosting = !widget.data.isPosting;
      widget.onChanged();
    });
  }

  void _onAmountChanged(String v) {
    setState(() {
      widget.data.amountStr = v.isEmpty ? '1' : v;
    });
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _Thumb(url: imageUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  d.isEditing
                      ? TextField(
                          controller: _nameCtrl,
                          style: const TextStyle(fontSize: 14),
                          decoration: const InputDecoration(
                              hintText: '음식명',
                              isDense: true,
                              border: UnderlineInputBorder()),
                        )
                      : Text(_nameCtrl.text,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      d.isEditing
                          ? Flexible(
                              child: TextField(
                                controller: _amountCtrl,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintText: '인분',
                                    isDense: true,
                                    border: UnderlineInputBorder()),
                                onChanged: _onAmountChanged,
                              ),
                            )
                          : Text('${_amountCtrl.text} 인분'),
                      const SizedBox(width: 12),
                      d.isEditing
                          ? Flexible(
                              child: TextField(
                                controller: _kcalCtrl,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintText: '칼로리(1인분)',
                                    isDense: true,
                                    border: UnderlineInputBorder()),
                              ),
                            )
                          : Text('${d.totalKcal.toStringAsFixed(0)} kcal'),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: _toggleEdit),
                IconButton(
                  icon: Icon(
                    d.isPosting
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    size: 20,
                    color: const Color(0xff3CB196),
                  ),
                  onPressed: _togglePost,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//====================================================================
// THUMBNAIL ----------------------------------------------------------
//====================================================================
class _Thumb extends StatelessWidget {
  final String? url;
  const _Thumb({this.url});

  @override
  Widget build(BuildContext context) {
    final placeholder = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset('../assets/images/character.png',
          width: 72, height: 72, fit: BoxFit.cover),
    );

    if (url == null || url!.isEmpty) return placeholder;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url!,
        width: 72,
        height: 72,
        fit: BoxFit.cover,
        // 오류(CORS) 시 placeholder 교체
        errorBuilder: (_, __, ___) => placeholder,
      ),
    );
  }
}
