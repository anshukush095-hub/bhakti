import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/ad_banner_widget.dart';

class ChalisaItem {
  final String title;
  final String deity;
  final String day;
  final String imagePath;
  final String content;

  const ChalisaItem({
    required this.title,
    required this.deity,
    required this.day,
    required this.imagePath,
    required this.content,
  });
}

class ChalisaSangrahScreen extends StatefulWidget {
  const ChalisaSangrahScreen({super.key});

  @override
  State<ChalisaSangrahScreen> createState() => _ChalisaSangrahScreenState();
}

class _ChalisaSangrahScreenState extends State<ChalisaSangrahScreen> {
  int _selectedIndex = 0;
  double _fontSize = 15.0;
  late FlutterTts _tts;
  bool _isPlaying = false;

  final List<ChalisaItem> _chalisas = [
    const ChalisaItem(
      title: 'श्री हनुमान चालीसा',
      deity: 'बजरंगबली हनुमान',
      day: 'मंगलवार एवं शनिवार',
      imagePath: 'assets/images/om_logo.jpg',
      content:
          '॥ दोहा ॥\n'
          'श्रीगुरु चरन सरोज रज निज मनु मुकुरु सुधारि।\n'
          'बरनउँ रघुबर बिमल जसु जो दायकु फल चारि॥\n'
          'बुद्धिहीन तनु जानिके सुमिरौ पवन-कुमार।\n'
          'बल बुधि बिद्या देहु मोहिं हरहु कलेस बिकार॥\n\n'
          '॥ चौपाई ॥\n'
          'जय हनुमान ज्ञान गुन सागर। जय कपीस तिहुँ लोक उजागर॥ १ ॥\n'
          'रामदूत अतुलित बल धामा। अंजनि-पुत्र पवनसुत नामा॥ २ ॥\n'
          'महाबीर बिक्रम बजरंगी। कुमति निवार सुमति के संगी॥ ३ ॥\n'
          'कंचन बरन बिराज सुबेसा। कानन कुंडल कुंचित केसा॥ ४ ॥\n'
          'हाथ बज्र औ ध्वजा बिराजै। काँधे मूँज जनेऊ साजै॥ ५ ॥\n'
          'संकर सुवन केसरीनंदन। तेज प्रताप महा जग बंदन॥ ६ ॥\n'
          'बिद्यावान गुनी अति चातुर। राम काज करिबे को आतुर॥ ७ ॥\n'
          'प्रभु चरित्र सुनिबे को रसिया। राम लखन सीता मन बसिया॥ ८ ॥\n'
          'सूक्ष्म रूप धरि सियहिं दिखावा। बिकट रूप धरि लंक जरावा॥ ९ ॥\n'
          'भीम रूप धरि असुर सँहारे। रामचंद्र के काज संवारे॥ १० ॥\n'
          'लाय सजीवन लखन जियाये। श्रीरघुबीर हरषि उर लाये॥ ११ ॥\n'
          'रघुपति कीन्ही बहुत बड़ाई। तुम मम प्रिय भरतहि सम भाई॥ १२ ॥\n'
          'सहस बदन तुम्हरो जस गावैं। अस कहि श्रीपति कंठ लगावैं॥ १३ ॥\n'
          'सनकादिक ब्रह्मादि मुनीसा। नारद सारद सहित अहीसा॥ १४ ॥\n'
          'जम कुबेर दिगपाल जहाँ ते। कबि कोबिद कहि सके कहाँ ते॥ १५ ॥\n'
          'तुम उपकार सुग्रीवहिं कीन्हा। राम मिलाय राज पद दीन्हा॥ १६ ॥\n'
          'तुम्हरो मंत्र बिभीषन माना। लंकेस्वर भए सब जग जाना॥ १७ ॥\n'
          'जुग सहस्र जोजन पर भानू। लील्यो ताहि मधुर फल जानू॥ १८ ॥\n'
          'प्रभु मुद्रिका मेलि मुख माहीं। जलधि लाँघि गये अचरज नाहीं॥ १९ ॥\n'
          'दुर्गम काज जगत के जेते। सुगम अनुग्रह तुम्हरे तेते॥ २० ॥\n'
          'राम दुआरे तुम रखवारे। होत न आज्ञा बिनु पैसारे॥ २१ ॥\n'
          'सब सुख लहै तुम्हारी सरना। तुम रक्षक काहू को डर ना॥ २२ ॥\n'
          'आपन तेज सम्हारो आपै। तीनों लोक हाँक तें काँपै॥ २३ ॥\n'
          'भूत पिसाच निकट नहिं आवै। महाबीर जब नाम सुनावै॥ २४ ॥\n'
          'नासै रोग हरै सब पीरा। जपत निरंतर हनुमत बीरा॥ २५ ॥\n'
          'संकट तें हनुमान छुड़ावै। मन क्रम बचन ध्यान जो लावै॥ २६ ॥\n'
          'सब पर राम तपस्वी राजा। तिन के काज सकल तुम साजा॥ २७ ॥\n'
          'और मनोरथ जो कोई लावै। सोइ अमित जीवन फल पावै॥ २८ ॥\n'
          'चारों जुग परताप तुम्हारा। है परसिद्ध जगत उजियारा॥ २९ ॥\n'
          'साधु संत के तुम रखवारे। असुर निकंदन राम दुलारे॥ ३० ॥\n'
          'अष्ट सिद्धि नौ निधि के दाता। अस बर दीन जानकी माता॥ ३१ ॥\n'
          'राम रसायन तुम्हरे पासा। सदा रहो रघुपति के दासा॥ ३२ ॥\n'
          'तुम्हरे भजन राम को पावै। जनम जनम के दुख बिसरावै॥ ३३ ॥\n'
          'अंत काल रघुबर पुर जाई। जहाँ जन्म हरि-भक्त कहाई॥ ३४ ॥\n'
          'और देवता चित्त न धरई। हनुमत सेइ सर्ब सुख करई॥ ३५ ॥\n'
          'संकट कटै मिटै सब पीरा। जो सुमिरै हनुमत बलबीरा॥ ३६ ॥\n'
          'जै जै जै हनुमान गोसाईं। कृपा करहु गुरुदेव की नाईं॥ ३७ ॥\n'
          'जो सत बार पाठ कर कोई। छूटहि बंदि महा सुख होई॥ ३८ ॥\n'
          'जो यह पढ़ै हनुमान चालीसा। होय सिद्धि साखी गौरीसा॥ ३९ ॥\n'
          'तुलसीदास सदा हरि चेरा। कीजै नाथ हृदय मँह डेरा॥ ४० ॥\n\n'
          '॥ दोहा ॥\n'
          'पवनतनय संकट हरन मंगल मूरति रूप।\n'
          'राम लखन सीता सहित हृदय बसहु सुर भूप॥',
    ),
    const ChalisaItem(
      title: 'श्री शिव चालीसा',
      deity: 'भगवान देवाधिदेव महादेव',
      day: 'सोमवार एवं प्रदोष व्रत',
      imagePath: 'assets/images/festival_shivratri.jpg',
      content:
          '॥ दोहा ॥\n'
          'जय गणेश गिरिजा सुवन, मंगल मूल सुजान।\n'
          'कहत अयोध्यादास तुम, देहु अभय वरदान॥\n\n'
          '॥ चौपाई ॥\n'
          'जय गिरिजा पति दीन दयाला। सदा करत संतन प्रतिपाला॥\n'
          'भाल चन्द्रमा सोहत नीके। कानन कुण्डल नागफनी के॥\n'
          'अंग गौर शिर गंग बहाये। मुण्डमाल तन क्षार लगाये॥\n'
          'वस्त्र खाल बाघम्बर सोहे। छवि को देख नाग मुनि मोहे॥\n'
          'मैना मातु की ह्वै दुलारी। बाम अंग सोहत छवि न्यारी॥\n'
          'कर त्रिशूल सोहत शुचि भाल। करत सदा शत्रुन क्षयकारी॥\n'
          'नन्दी भृङ्गी नृत्य करावैं। ताल मृदंग आनन्द बजावैं॥\n'
          'देवन जबहीं जाय पुकारा। तब ही तुम प्रभु आप संभारा॥\n'
          'त्रिपुरारी त्रिशूल जब मारा। शंखासुर दैत्य संहारा॥\n'
          'अमृत मंथन सुर असुर उपाया। विष पीकर नीलकण्ठ कहलाया॥\n'
          'जो यह पाठ करे मन लाई। ताको होत सदा सुखदाई॥\n\n'
          '॥ दोहा ॥\n'
          'नित नेम कर प्रातः ही, पाठ करौ चालीस।\n'
          'तुम मेरी मनोकामना, पूर्ण करो जगदीश॥',
    ),
    const ChalisaItem(
      title: 'श्री दुर्गा चालीसा',
      deity: 'आदिशक्ति मां भगवती',
      day: 'शुक्रवार एवं नवरात्रि',
      imagePath: 'assets/images/festival_navratri.jpg',
      content:
          '॥ नमो नमो दुर्गे सुख करनी, नमो नमो अम्बे दुःख हरनी ॥\n'
          'निरंकार है ज्योति तुम्हारी, तिहूँ लोक फैली उजियारी॥\n'
          'शशि ललाट मुख महाविशाला, नेत्र लाल भृकुटि विकराला॥\n'
          'रूप मातु को अधिक सुहावे, दरश करत जन अति सुख पावे॥\n'
          'तुम संसार शक्ति लै कीना, पालन हेतु अन्न धन दीना॥\n'
          'अन्नपूर्णा हुई जग पाला, तुम ही आदि सुन्दरी बाला॥\n'
          'प्रलयकाल सब नाशनहारी, तुम गौरी शिवशंकर प्यारी॥\n'
          'शिव योगी तुम्हरे गुण गावें, ब्रह्मा विष्णु तुम्हें नित ध्यावें॥\n'
          'रूप सरस्वती को तुम धारा, दे सुबुद्धि ऋषि मुनिन उबारा॥\n'
          'महिषासुर नृप अति अभिमानी, जेहि अघ भार मही अकुलानी॥\n'
          'रूप कराल कालिका धारा, सेन सहित तुम तिनहिं संहारा॥\n'
          'परी गाढ़ संतन पर जब जब, भई सहाय मातु तुम तब तब॥',
    ),
    const ChalisaItem(
      title: 'श्री गणेश चालीसा',
      deity: 'विघ्नहर्ता श्री गणेश',
      day: 'बुधवार एवं संकष्टी चतुर्थी',
      imagePath: 'assets/images/festival_ganesha.jpg',
      content:
          '॥ दोहा ॥\n'
          'जय गणपति सदगुण सदन, कविवर बदन कृपाल।\n'
          'विघ्न हरण मंगल करण, जय जय गिरिजालाल॥\n\n'
          '॥ चौपाई ॥\n'
          'जय जय जय गणपति गणराजू। मंगल भरण करण शुभ काजू॥\n'
          'जय गजबदन सदन सुखदाता। विश्व विनायक बुद्धि विधाता॥\n'
          'वक्र तुण्ड शुचि शुण्ड सुहावन। तिलक त्रिपुण्ड भाल मन भावन॥\n'
          'राजित मणि मुक्तन उर माला। स्वर्ण मुकुट शिर नयन विशाला॥\n'
          'ऋद्धि सिद्धि तव चँवर सुढारहिं। मूषक वाहन सोहत द्वारहिं॥\n'
          'कहत अयोध्यादास प्रभु, कीजै मो पर नेह।\n'
          'विद्या बुद्धि विवेक बल, सब विधि मंगल देह॥',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() {
    _tts = FlutterTts();
    _tts.setLanguage('hi-IN');
    _tts.setSpeechRate(0.48);
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _tts.stop();
      setState(() => _isPlaying = false);
    } else {
      final current = _chalisas[_selectedIndex];
      setState(() => _isPlaying = true);
      await _tts.speak(current.content);
    }
  }

  void _shareChalisa() {
    final current = _chalisas[_selectedIndex];
    Share.share(
      '🕉️ *${current.title}* (${current.deity})\n\n'
      '${current.content}\n\n'
      '🚩 पावन *पूजा विधि (Puja Vidhi)* ऐप से साझा किया गया:\n'
      'https://play.google.com/store/apps/details?id=com.apratech.pujavidhi',
      subject: current.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.isDarkMode;
    final currentChalisa = _chalisas[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('पावन चालीसा संग्रह'),
        actions: [
          IconButton(
            tooltip: 'आकार छोटा करें (A-)',
            icon: const Icon(Icons.text_decrease_rounded),
            onPressed: () {
              if (_fontSize > 12) setState(() => _fontSize -= 1.5);
            },
          ),
          IconButton(
            tooltip: 'आकार बड़ा करें (A+)',
            icon: const Icon(Icons.text_increase_rounded),
            onPressed: () {
              if (_fontSize < 24) setState(() => _fontSize += 1.5);
            },
          ),
          IconButton(
            tooltip: 'चालीसा शेयर करें',
            icon: const Icon(Icons.share_rounded),
            onPressed: _shareChalisa,
          ),
        ],
      ),
      body: Column(
        children: [
          // Chalisa Selection Chips Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: isDark ? AppColors.bgDarkCard : const Color(0xFFF9F6F0),
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _chalisas.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedIndex;
                  return ChoiceChip(
                    label: Text(
                      _chalisas[index].title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.white70 : AppColors.primaryMaroon),
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.primaryMaroon,
                    backgroundColor: isDark ? AppColors.bgDark : Colors.white,
                    side: BorderSide(
                      color: isSelected ? AppColors.primaryMaroon : AppColors.borderSubtle,
                    ),
                    onSelected: (val) {
                      if (val) {
                        _tts.stop();
                        setState(() {
                          _selectedIndex = index;
                          _isPlaying = false;
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ),

          // Main Chalisa Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primarySaffron.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'पुण्य फलदायी: ${currentChalisa.day}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryMaroon,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    currentChalisa.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryMaroon,
                    ),
                  ),
                  Text(
                    'आराध्य: ${currentChalisa.deity}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppColors.textDarkSecondary : AppColors.textMedium,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Floating Audio Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.bgDarkCard : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isPlaying ? Colors.red.shade700 : AppColors.primaryMaroon,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: _toggleAudio,
                          icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
                          label: Text(
                            _isPlaying ? 'रोकें (Pause)' : 'श्रवण करें (Listen)',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Full Sacred Verses Text
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.bgDarkCard : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
                      ),
                    ),
                    child: SelectableText(
                      currentChalisa.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _fontSize,
                        height: 1.8,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF2C241B),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AdBannerWidget(),
    );
  }
}
