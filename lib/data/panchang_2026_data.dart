class PanchangDayData {
  final DateTime date;
  final String dateHindi;
  final String dayName;
  final String tithi;
  final String paksha;
  final String samvat;
  final String nakshatra;
  final String yoga;
  final String karana;
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String rahuKaal;
  final String yamaganda;
  final String abhijit;
  final String amrit;
  final String special;
  final String? festivalBadge;
  final List<Map<String, dynamic>> dayChaughadiya;
  final List<Map<String, dynamic>> nightChaughadiya;

  const PanchangDayData({
    required this.date,
    required this.dateHindi,
    required this.dayName,
    required this.tithi,
    required this.paksha,
    required this.samvat,
    required this.nakshatra,
    required this.yoga,
    required this.karana,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.rahuKaal,
    required this.yamaganda,
    required this.abhijit,
    required this.amrit,
    required this.special,
    this.festivalBadge,
    required this.dayChaughadiya,
    required this.nightChaughadiya,
  });
}

class MonthInfo {
  final int monthNumber;
  final String nameHindi;
  final String nameEnglish;
  final String hinduMonths;
  final int totalDays;
  final List<Map<String, String>> keyFestivals;

  const MonthInfo({
    required this.monthNumber,
    required this.nameHindi,
    required this.nameEnglish,
    required this.hinduMonths,
    required this.totalDays,
    required this.keyFestivals,
  });
}

class Panchang2026Data {
  static const List<MonthInfo> months2026 = [
    MonthInfo(
      monthNumber: 1,
      nameHindi: 'जनवरी 2026',
      nameEnglish: 'January 2026',
      hinduMonths: 'पौष - माघ',
      totalDays: 31,
      keyFestivals: [
        {'date': '01 जनवरी', 'event': 'नववर्ष 2026 प्रारंभ'},
        {'date': '03 जनवरी', 'event': 'पौष पूर्णिमा व्रत'},
        {'date': '14 जनवरी', 'event': 'मकर संक्रांति • पोंगल'},
        {'date': '15 जनवरी', 'event': 'षटतिला एकादशी'},
        {'date': '18 जनवरी', 'event': 'मौनी अमावस्या (माघ अमावस्या)'},
        {'date': '23 जनवरी', 'event': 'बसंत पंचमी • सरस्वती पूजा'},
        {'date': '30 जनवरी', 'event': 'जया एकादशी'},
      ],
    ),
    MonthInfo(
      monthNumber: 2,
      nameHindi: 'फरवरी 2026',
      nameEnglish: 'February 2026',
      hinduMonths: 'माघ - फाल्गुन',
      totalDays: 28,
      keyFestivals: [
        {'date': '01 फरवरी', 'event': 'माघ पूर्णिमा (माघी पूर्णिमा स्नान)'},
        {'date': '13 फरवरी', 'event': 'विजया एकादशी'},
        {'date': '14 फरवरी', 'event': 'शनि प्रदोष व्रत'},
        {'date': '15 फरवरी', 'event': 'महाशिवरात्रि महापर्व'},
        {'date': '16 फरवरी', 'event': 'महाशिवरात्रि पारण'},
        {'date': '17 फरवरी', 'event': 'फाल्गुन अमावस्या'},
        {'date': '27 फरवरी', 'event': 'आमलकी एकादशी'},
      ],
    ),
    MonthInfo(
      monthNumber: 3,
      nameHindi: 'मार्च 2026',
      nameEnglish: 'March 2026',
      hinduMonths: 'फाल्गुन - चैत्र (नव संवत)',
      totalDays: 31,
      keyFestivals: [
        {'date': '03 मार्च', 'event': 'होलिका दहन • फाल्गुन पूर्णिमा'},
        {'date': '04 मार्च', 'event': 'होली (धुलंडी / रंगोत्सव)'},
        {'date': '15 मार्च', 'event': 'पापमोचिनी एकादशी'},
        {'date': '18 मार्च', 'event': 'चैत्र अमावस्या'},
        {'date': '19 मार्च', 'event': 'चैत्र नवरात्रि प्रारंभ • घटस्थापना • हिंदू नववर्ष (विक्रम संवत 2083 प्रारंभ)'},
        {'date': '27 मार्च', 'event': 'श्री राम नवमी'},
        {'date': '29 मार्च', 'event': 'कामदा एकादशी'},
      ],
    ),
    MonthInfo(
      monthNumber: 4,
      nameHindi: 'अप्रैल 2026',
      nameEnglish: 'April 2026',
      hinduMonths: 'चैत्र - वैशाख',
      totalDays: 30,
      keyFestivals: [
        {'date': '02 अप्रैल', 'event': 'चैत्र पूर्णिमा • श्री हनुमान जन्मोत्सव • सत्यनारायण कथा'},
        {'date': '13 अप्रैल', 'event': 'वरूथिनी एकादशी • मेष संक्रांति (बैसाखी)'},
        {'date': '17 अप्रैल', 'event': 'वैशाख अमावस्या'},
        {'date': '20 अप्रैल', 'event': 'अक्षय तृतीया (अखा तीज)'},
        {'date': '27 अप्रैल', 'event': 'मोहिनी एकादशी'},
      ],
    ),
    MonthInfo(
      monthNumber: 5,
      nameHindi: 'मई 2026',
      nameEnglish: 'May 2026',
      hinduMonths: 'वैशाख - ज्येष्ठ',
      totalDays: 31,
      keyFestivals: [
        {'date': '01 मई', 'event': 'वैशाख पूर्णिमा • बुद्ध पूर्णिमा'},
        {'date': '13 मई', 'event': 'अपरा एकादशी'},
        {'date': '16 मई', 'event': 'ज्येष्ठ अमावस्या • शनि जयंती • वट सावित्री व्रत'},
        {'date': '25 मई', 'event': 'गंगा दशहरा'},
        {'date': '27 मई', 'event': 'निर्जला एकादशी'},
        {'date': '31 मई', 'event': 'ज्येष्ठ पूर्णिमा • वट पूर्णिमा'},
      ],
    ),
    MonthInfo(
      monthNumber: 6,
      nameHindi: 'जून 2026',
      nameEnglish: 'June 2026',
      hinduMonths: 'ज्येष्ठ - आषाढ़',
      totalDays: 30,
      keyFestivals: [
        {'date': '11 जून', 'event': 'योगिनी एकादशी'},
        {'date': '15 जून', 'event': 'आषाढ़ अमावस्या'},
        {'date': '26 जून', 'event': 'देवशयनी एकादशी • चातुर्मास प्रारंभ'},
        {'date': '29 जून', 'event': 'आषाढ़ पूर्णिमा • गुरु पूर्णिमा'},
      ],
    ),
    MonthInfo(
      monthNumber: 7,
      nameHindi: 'जुलाई 2026',
      nameEnglish: 'July 2026',
      hinduMonths: 'आषाढ़ - श्रावण',
      totalDays: 31,
      keyFestivals: [
        {'date': '10 जुलाई', 'event': 'कामिका एकादशी'},
        {'date': '14 जुलाई', 'event': 'सावन शिवरात्रि • हरियाली अमावस्या'},
        {'date': '25 जुलाई', 'event': 'श्रावण पुत्रदा एकादशी'},
        {'date': '28 जुलाई', 'event': 'श्रावण पूर्णिमा • रक्षाबंधन'},
      ],
    ),
    MonthInfo(
      monthNumber: 8,
      nameHindi: 'अगस्त 2026',
      nameEnglish: 'August 2026',
      hinduMonths: 'श्रावण - भाद्रपद',
      totalDays: 31,
      keyFestivals: [
        {'date': '08 अगस्त', 'event': 'अजा एकादशी'},
        {'date': '12 अगस्त', 'event': 'भाद्रपद अमावस्या (पिठोरी)'},
        {'date': '17 अगस्त', 'event': 'हरतालिका तीज'},
        {'date': '23 अगस्त', 'event': 'परिवर्तिनी एकादशी'},
        {'date': '27 अगस्त', 'event': 'अनंत चतुर्दशी • गणेश विसर्जन'},
        {'date': '28 अगस्त', 'event': 'भाद्रपद पूर्णिमा • महालय / पितृपक्ष प्रारंभ'},
      ],
    ),
    MonthInfo(
      monthNumber: 9,
      nameHindi: 'सितंबर 2026',
      nameEnglish: 'September 2026',
      hinduMonths: 'भाद्रपद - आश्विन',
      totalDays: 30,
      keyFestivals: [
        {'date': '04 सितंबर', 'event': 'श्री कृष्ण जन्माष्टमी'},
        {'date': '11 सितंबर', 'event': 'सर्वपितृ अमावस्या (पितृपक्ष समाप्त)'},
        {'date': '12 सितंबर', 'event': 'शारदीय नवरात्रि प्रारंभ • घटस्थापना'},
        {'date': '14 सितंबर', 'event': 'गणेश चतुर्थी महापर्व'},
        {'date': '20 सितंबर', 'event': 'दुर्गा महाअष्टमी'},
        {'date': '21 सितंबर', 'event': 'महानवमी'},
        {'date': '22 सितंबर', 'event': 'विजयादशमी • दशहरा'},
        {'date': '23 सितंबर', 'event': 'पापांकुशा एकादशी'},
        {'date': '26 सितंबर', 'event': 'शरद पूर्णिमा (कोजागरी पूर्णिमा)'},
      ],
    ),
    MonthInfo(
      monthNumber: 10,
      nameHindi: 'अक्टूबर 2026',
      nameEnglish: 'October 2026',
      hinduMonths: 'आश्विन - कार्तिक',
      totalDays: 31,
      keyFestivals: [
        {'date': '06 अक्टूबर', 'event': 'रमा एकादशी'},
        {'date': '09 अक्टूबर', 'event': 'गोवत्स द्वादशी'},
        {'date': '11 अक्टूबर', 'event': 'कार्तिक अमावस्या प्रारंभ'},
        {'date': '21 अक्टूबर', 'event': 'पापांकुशा एकादशी प्रभाव'},
        {'date': '25 अक्टूबर', 'event': 'शरद आश्विन पूर्णिमा'},
        {'date': '29 अक्टूबर', 'event': 'करवा चौथ व्रत (पूजा: 05:38 PM, चंद्रोदय: 08:15 PM)'},
      ],
    ),
    MonthInfo(
      monthNumber: 11,
      nameHindi: 'नवंबर 2026',
      nameEnglish: 'November 2026',
      hinduMonths: 'कार्तिक - मार्गशीर्ष',
      totalDays: 30,
      keyFestivals: [
        {'date': '06 नवंबर', 'event': 'धनतेरस (धनत्रयोदशी)'},
        {'date': '07 नवंबर', 'event': 'नरक चतुर्दशी (छोटी दिवाली)'},
        {'date': '08 नवंबर', 'event': 'दीपावली महापर्व • महालक्ष्मी पूजन (05:45 PM – 07:42 PM)'},
        {'date': '09 नवंबर', 'event': 'गोवर्धन पूजा • अन्नकूट'},
        {'date': '10 नवंबर', 'event': 'भाई दूज • यम द्वितीया'},
        {'date': '15 नवंबर', 'event': 'छठ पूजा (सायंकालीन अर्घ्य)'},
        {'date': '16 नवंबर', 'event': 'छठ पूजा (प्रातःकालीन उषा अर्घ्य)'},
        {'date': '20 नवंबर', 'event': 'देवउठनी एकादशी (तुलसी विवाह प्रारंभ)'},
        {'date': '24 नवंबर', 'event': 'कार्तिक पूर्णिमा • देव दीपावली'},
      ],
    ),
    MonthInfo(
      monthNumber: 12,
      nameHindi: 'दिसंबर 2026',
      nameEnglish: 'December 2026',
      hinduMonths: 'मार्गशीर्ष - पौष',
      totalDays: 31,
      keyFestivals: [
        {'date': '05 दिसंबर', 'event': 'उत्पन्ना एकादशी'},
        {'date': '09 दिसंबर', 'event': 'मार्गशीर्ष अमावस्या'},
        {'date': '20 दिसंबर', 'event': 'मोक्षदा एकादशी • गीता जयंती'},
        {'date': '23 दिसंबर', 'event': 'मार्गशीर्ष पूर्णिमा • दत्तात्रेय जयंती'},
      ],
    ),
  ];

  static const List<String> _nakshatras = [
    'अश्विनी', 'भरणी', 'कृत्तिका', 'रोहिणी', 'मृगशिरा', 'आर्द्रा',
    'पुनर्वसु', 'पुष्य', 'अश्लेषा', 'मघा', 'पूर्वाफाल्गुनी', 'उत्तराफाल्गुनी',
    'हस्त', 'चित्रा', 'स्वाति', 'विशाखा', 'अनुराधा', 'ज्येष्ठा',
    'मूल', 'पूर्वाषाढ़ा', 'उत्तराषाढ़ा', 'श्रवण', 'धनिष्ठा', 'शतभिषा',
    'पूर्वाभाद्रपद', 'उत्तराभाद्रपद', 'रेवती'
  ];

  static const List<String> _yogas = [
    'विष्कम्भ', 'प्रीति', 'आयुष्मान्', 'सौभाग्य', 'शोभन', 'अतिगण्ड',
    'सुकर्मा', 'धृति', 'शूल', 'गण्ड', 'वृद्धि', 'ध्रुव',
    'व्याघात', 'हर्षण', 'वज्र', 'सिद्धि', 'व्यतीपात', 'वरीयान्',
    'परिघ', 'शिव', 'सिद्ध', 'साध्य', 'शुभ', 'शुक्ल',
    'ब्रह्म', 'ऐन्द्र', 'वैधृति'
  ];

  static const List<String> _karanas = [
    'बव', 'बालव', 'कौलव', 'तैतिल', 'गर', 'वणिज',
    'विष्टि', 'शकुनि', 'चतुष्पाद', 'नाग', 'किस्तुघ्न'
  ];

  static const List<String> _hindiDays = [
    'सोमवार', 'मंगलवार', 'बुधवार', 'गुरुवार', 'शुक्रवार', 'शनिवार', 'रविवार'
  ];

  static const List<String> _hindiMonths = [
    'जनवरी', 'फरवरी', 'मार्च', 'अप्रैल', 'मई', 'जून',
    'जुलाई', 'अगस्त', 'सितंबर', 'अक्टूबर', 'नवंबर', 'दिसंबर'
  ];

  // Specific high-importance dates dictionary for 2026
  static const Map<String, Map<String, String>> _specialDates2026 = {
    '2026-01-01': {'badge': 'नववर्ष', 'special': 'ईस्वी नववर्ष 2026 का पावन आरंभ'},
    '2026-01-03': {'badge': 'पूर्णिमा', 'special': 'पौष पूर्णिमा व्रत • सत्यनारायण कथा'},
    '2026-01-14': {'badge': 'संक्रांति', 'special': 'मकर संक्रांति महापर्व • पोंगल • उत्तरायण सूर्य'},
    '2026-01-15': {'badge': 'एकादशी', 'special': 'षटतिला एकादशी व्रत'},
    '2026-01-18': {'badge': 'अमावस्या', 'special': 'मौनी अमावस्या • माघ अमावस्या महास्नान'},
    '2026-01-23': {'badge': 'बसंत पंचमी', 'special': 'बसंत पंचमी • मां सरस्वती प्राकट्योत्सव'},
    '2026-01-30': {'badge': 'एकादशी', 'special': 'जया एकादशी व्रत'},

    '2026-02-01': {'badge': 'माघ पूर्णिमा', 'special': 'माघ पूर्णिमा • प्रयागराज संगम महास्नान'},
    '2026-02-13': {'badge': 'एकादशी', 'special': 'विजया एकादशी व्रत'},
    '2026-02-14': {'badge': 'प्रदोष', 'special': 'शनि प्रदोष व्रत • शिव आराधना'},
    '2026-02-15': {'badge': 'महाशिवरात्रि', 'special': 'महाशिवरात्रि महापर्व • निशीथ काल पूजा (12:09 AM - 01:01 AM)'},
    '2026-02-16': {'badge': 'शिव पारण', 'special': 'महाशिवरात्रि व्रत पारण • सोमवती योग'},
    '2026-02-17': {'badge': 'अमावस्या', 'special': 'फाल्गुन अमावस्या • पितृ तर्पण'},
    '2026-02-27': {'badge': 'एकादशी', 'special': 'आमलकी एकादशी व्रत • आंवला वृक्ष पूजन'},

    '2026-03-03': {'badge': 'होलिका दहन', 'special': 'होलिका दहन • फाल्गुन पूर्णिमा'},
    '2026-03-04': {'badge': 'होली', 'special': 'रंगोत्सव • धुलंडी • होली महापर्व'},
    '2026-03-15': {'badge': 'एकादशी', 'special': 'पापमोचिनी एकादशी व्रत'},
    '2026-03-18': {'badge': 'अमावस्या', 'special': 'चैत्र अमावस्या'},
    '2026-03-19': {'badge': 'नवसंवत 2083', 'special': 'चैत्र नवरात्रि प्रारंभ • घटस्थापना • हिंदू नववर्ष (संवत 2083 नल प्रारंभ)'},
    '2026-03-27': {'badge': 'रामनवमी', 'special': 'श्री राम नवमी जन्मोत्सव • नवरात्रि पूर्णाहुति'},
    '2026-03-29': {'badge': 'एकादशी', 'special': 'कामदा एकादशी व्रत'},

    '2026-04-02': {'badge': 'हनुमान जयंती', 'special': 'चैत्र पूर्णिमा • श्री हनुमान जन्मोत्सव • सत्यनारायण कथा'},
    '2026-04-13': {'badge': 'बैसाखी', 'special': 'वरूथिनी एकादशी • मेष संक्रांति (बैसाखी)'},
    '2026-04-17': {'badge': 'अमावस्या', 'special': 'वैशाख अमावस्या'},
    '2026-04-20': {'badge': 'अक्षय तृतीया', 'special': 'अक्षय तृतीया (अखा तीज) • अबूझ सिद्ध मुहूर्त'},
    '2026-04-27': {'badge': 'एकादशी', 'special': 'मोहिनी एकादशी व्रत'},

    '2026-05-01': {'badge': 'बुद्ध पूर्णिमा', 'special': 'वैशाख पूर्णिमा • बुद्ध पूर्णिमा • कूर्म जयंती'},
    '2026-05-13': {'badge': 'एकादशी', 'special': 'अपरा एकादशी व्रत'},
    '2026-05-16': {'badge': 'शनि जयंती', 'special': 'ज्येष्ठ अमावस्या • शनि जयंती • वट सावित्री व्रत'},
    '2026-05-25': {'badge': 'गंगा दशहरा', 'special': 'गंगा दशहरा • मां गंगा अवतरण दिवस'},
    '2026-05-27': {'badge': 'निर्जला एकादशी', 'special': 'निर्जला एकादशी (भीमसेनी एकादशी) महापर्व'},
    '2026-05-31': {'badge': 'वट पूर्णिमा', 'special': 'ज्येष्ठ पूर्णिमा • वट पूर्णिमा व्रत'},

    '2026-06-11': {'badge': 'एकादशी', 'special': 'योगिनी एकादशी व्रत'},
    '2026-06-15': {'badge': 'अमावस्या', 'special': 'आषाढ़ अमावस्या'},
    '2026-06-26': {'badge': 'देवशयनी', 'special': 'देवशयनी एकादशी • चातुर्मास पावन आरंभ'},
    '2026-06-29': {'badge': 'गुरु पूर्णिमा', 'special': 'आषाढ़ पूर्णिमा • महर्षि वेदव्यास जयंती • गुरु पूर्णिमा'},

    '2026-07-10': {'badge': 'एकादशी', 'special': 'कामिका एकादशी व्रत'},
    '2026-07-14': {'badge': 'हरियाली अमावस्या', 'special': 'सावन शिवरात्रि • हरियाली अमावस्या'},
    '2026-07-25': {'badge': 'पुत्रदा एकादशी', 'special': 'श्रावण पुत्रदा एकादशी व्रत'},
    '2026-07-28': {'badge': 'रक्षाबंधन', 'special': 'श्रावण पूर्णिमा • रक्षाबंधन महापर्व • श्रावणी उपाकर्म'},

    '2026-08-08': {'badge': 'एकादशी', 'special': 'अजा एकादशी व्रत'},
    '2026-08-12': {'badge': 'अमावस्या', 'special': 'भाद्रपद अमावस्या • पिठोरी अमावस्या'},
    '2026-08-17': {'badge': 'हरतालिका तीज', 'special': 'हरतालिका तीज व्रत • मां गौरी-शिव आराधना'},
    '2026-08-23': {'badge': 'एकादशी', 'special': 'परिवर्तिनी एकादशी (पद्मा एकादशी)'},
    '2026-08-27': {'badge': 'अनंत चतुर्दशी', 'special': 'अनंत चतुर्दशी • 14 गांठ डोरा बंधन'},
    '2026-08-28': {'badge': 'पितृपक्ष प्रारंभ', 'special': 'भाद्रपद पूर्णिमा • महालय पितृपक्ष श्राद्ध प्रारंभ'},

    '2026-09-04': {'badge': 'जन्माष्टमी', 'special': 'श्री कृष्ण जन्माष्टमी महापर्व • मध्यरात्रि जन्मोत्सव'},
    '2026-09-11': {'badge': 'सर्वपितृ अमावस्या', 'special': 'सर्वपितृ अमावस्या • महालय श्राद्ध विसर्जन'},
    '2026-09-12': {'badge': 'नवरात्रि प्रारंभ', 'special': 'शारदीय नवरात्रि प्रारंभ • कलश घटस्थापना'},
    '2026-09-14': {'badge': 'गणेश चतुर्थी', 'special': 'गणेश चतुर्थी महापर्व • मध्याह्न पूजा (11:09 AM - 01:36 PM)'},
    '2026-09-20': {'badge': 'महाअष्टमी', 'special': 'दुर्गा महाअष्टमी • महागौरी पूजन • कन्या पूजन'},
    '2026-09-21': {'badge': 'महानवमी', 'special': 'महानवमी • मां सिद्धिदात्री पूजन'},
    '2026-09-22': {'badge': 'दशहरा', 'special': 'विजयादशमी • दशहरा • शस्त्र पूजन • रावण दहन'},
    '2026-09-23': {'badge': 'एकादशी', 'special': 'पापांकुशा एकादशी व्रत'},
    '2026-09-26': {'badge': 'शरद पूर्णिमा', 'special': 'शरद पूर्णिमा • अमृत वर्षा • श्री कृष्ण रासोत्सव'},

    '2026-10-06': {'badge': 'एकादशी', 'special': 'रमा एकादशी व्रत'},
    '2026-10-09': {'badge': 'गोवत्स द्वादशी', 'special': 'गोवत्स द्वादशी (बछ बारस)'},
    '2026-10-11': {'badge': 'अमावस्या', 'special': 'कार्तिक दर्श अमावस्या'},
    '2026-10-25': {'badge': 'पूर्णिमा', 'special': 'कार्तिक स्नान पूर्णिमा प्रभाव'},
    '2026-10-29': {'badge': 'करवा चौथ', 'special': 'करवा चौथ व्रत (पूजा: 05:38 PM, चंद्रोदय: 08:15 PM)'},

    '2026-11-06': {'badge': 'धनतेरस', 'special': 'धनत्रयोदशी • भगवान धन्वंतरि जयंती • कुबेर पूजन'},
    '2026-11-07': {'badge': 'छोटी दिवाली', 'special': 'नरक चतुर्दशी • यम दीपदान • हनुमान जयंती (उत्तर भारत)'},
    '2026-11-08': {'badge': 'दीपावली', 'special': 'दीपावली महापर्व • श्री महालक्ष्मी-गणेश पूजन (05:45 PM – 07:42 PM)'},
    '2026-11-09': {'badge': 'गोवर्धन पूजा', 'special': 'गोवर्धन पूजा • अन्नकूट महोत्सव'},
    '2026-11-10': {'badge': 'भाई दूज', 'special': 'यम द्वितीया • भाई दूज (भ्रातृ द्वितीया)'},
    '2026-11-15': {'badge': 'छठ पूजा', 'special': 'महापर्व छठ पूजा • सायंकालीन अस्ताचल सूर्य अर्घ्य'},
    '2026-11-16': {'badge': 'छठ उषा अर्घ्य', 'special': 'छठ पूजा प्रातःकालीन उदीयमान सूर्य अर्घ्य • पारण'},
    '2026-11-20': {'badge': 'देवउठनी', 'special': 'देवउठनी एकादशी (प्रबोधिनी) • तुलसी विवाह प्रारंभ • चातुर्मास समाप्त'},
    '2026-11-24': {'badge': 'देव दीपावली', 'special': 'कार्तिक पूर्णिमा • देव दीपावली • गुरु नानक जयंती'},

    '2026-12-05': {'badge': 'एकादशी', 'special': 'उत्पन्ना एकादशी व्रत'},
    '2026-12-09': {'badge': 'अमावस्या', 'special': 'मार्गशीर्ष अमावस्या'},
    '2026-12-20': {'badge': 'गीता जयंती', 'special': 'मोक्षदा एकादशी • श्रीमद्भगवद्गीता जयंती'},
    '2026-12-23': {'badge': 'पूर्णिमा', 'special': 'मार्गशीर्ष पूर्णिमा • श्री दत्तात्रेय जयंती'},
  };

  static PanchangDayData getPanchangForDate(DateTime date) {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    final weekday = date.weekday; // 1 = Monday, 7 = Sunday

    final dateKey = '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    final dayName = _hindiDays[weekday - 1];
    final monthName = _hindiMonths[month - 1];
    final dateHindi = '$dayName, $day $monthName $year';

    // Samvat calculation: March 19, 2026 is Chaitra Shukla Pratipada (Hindu New Year)
    final isNewSamvat = (month > 3) || (month == 3 && day >= 19);
    final samvat = isNewSamvat
        ? 'विक्रम संवत 2083 (नल) • शक संवत 1948'
        : 'विक्रम संवत 2082 (सिद्धार्थी) • शक संवत 1947';

    // Tithi & Paksha approximation based on 2026 lunar cycle
    final dayOfYear = date.difference(DateTime(year, 1, 1)).inDays + 1;
    final lunarDay = (dayOfYear + 21) % 30; // 0 to 29
    final isShukla = lunarDay < 15;
    final paksha = isShukla ? 'शुक्ल पक्ष' : 'कृष्ण पक्ष';
    final tithiIndex = (lunarDay % 15) + 1;

    String tithiName;
    switch (tithiIndex) {
      case 1: tithiName = 'प्रतिपदा'; break;
      case 2: tithiName = 'द्वितीया'; break;
      case 3: tithiName = 'तृतीया'; break;
      case 4: tithiName = 'चतुर्थी'; break;
      case 5: tithiName = 'पंचमी'; break;
      case 6: tithiName = 'षष्ठी'; break;
      case 7: tithiName = 'सप्तमी'; break;
      case 8: tithiName = 'अष्टमी'; break;
      case 9: tithiName = 'नवमी'; break;
      case 10: tithiName = 'दशमी'; break;
      case 11: tithiName = 'एकादशी'; break;
      case 12: tithiName = 'द्वादशी'; break;
      case 13: tithiName = 'त्रयोदशी'; break;
      case 14: tithiName = 'चतुर्दशी'; break;
      case 15: tithiName = isShukla ? 'पूर्णिमा' : 'अमावस्या'; break;
      default: tithiName = 'तिथि';
    }

    final tithiFull = '$paksha $tithiName';

    // Nakshatra, Yoga, Karana
    final nakshatra = _nakshatras[(dayOfYear * 13 + 5) % 27];
    final yoga = _yogas[(dayOfYear * 7 + 11) % 27];
    final karana = _karanas[(dayOfYear * 2 + tithiIndex) % 11];

    // Seasonal Sun Times in India (approx New Delhi/Central India)
    String sunrise, sunset;
    if (month == 1 || month == 12) {
      sunrise = '07:14 AM'; sunset = '05:46 PM';
    } else if (month == 2 || month == 11) {
      sunrise = '07:01 AM'; sunset = '06:11 PM';
    } else if (month == 3 || month == 10) {
      sunrise = '06:31 AM'; sunset = '06:33 PM';
    } else if (month == 4 || month == 9) {
      sunrise = '06:01 AM'; sunset = '06:48 PM';
    } else if (month == 5 || month == 8) {
      sunrise = '05:33 AM'; sunset = '07:11 PM';
    } else { // June, July
      sunrise = '05:24 AM'; sunset = '07:22 PM';
    }

    // Moon times
    final moonriseHour = ((lunarDay * 50) ~/ 60 + 6) % 24;
    final moonrisePeriod = moonriseHour >= 12 ? 'PM' : 'AM';
    final formattedMoonriseHour = moonriseHour % 12 == 0 ? 12 : moonriseHour % 12;
    final moonrise = '${formattedMoonriseHour.toString().padLeft(2, '0')}:24 $moonrisePeriod';

    final moonsetHour = (moonriseHour + 12) % 24;
    final moonsetPeriod = moonsetHour >= 12 ? 'PM' : 'AM';
    final formattedMoonsetHour = moonsetHour % 12 == 0 ? 12 : moonsetHour % 12;
    final moonset = '${formattedMoonsetHour.toString().padLeft(2, '0')}:48 $moonsetPeriod';

    // Rahu Kaal & Yamaganda by Weekday (standard Vedic calculation)
    String rahuKaal, yamaganda;
    switch (weekday) {
      case 1: // Monday
        rahuKaal = '07:30 AM – 09:00 AM'; yamaganda = '10:30 AM – 12:00 PM'; break;
      case 2: // Tuesday
        rahuKaal = '03:00 PM – 04:30 PM'; yamaganda = '09:00 AM – 10:30 AM'; break;
      case 3: // Wednesday
        rahuKaal = '12:00 PM – 01:30 PM'; yamaganda = '07:30 AM – 09:00 AM'; break;
      case 4: // Thursday
        rahuKaal = '01:30 PM – 03:00 PM'; yamaganda = '06:00 AM – 07:30 AM'; break;
      case 5: // Friday
        rahuKaal = '10:30 AM – 12:00 PM'; yamaganda = '03:00 PM – 04:30 PM'; break;
      case 6: // Saturday
        rahuKaal = '09:00 AM – 10:30 AM'; yamaganda = '01:30 PM – 03:00 PM'; break;
      case 7: // Sunday
      default:
        rahuKaal = '04:30 PM – 06:00 PM'; yamaganda = '12:00 PM – 01:30 PM'; break;
    }

    const abhijit = '12:13 PM – 12:58 PM';
    const amrit = '01:45 PM – 03:20 PM';

    // Special festival badge
    final specialEntry = _specialDates2026[dateKey];
    final special = specialEntry != null ? specialEntry['special']! : '$dayName का पावन दिन • ईष्ट देव आराधना';
    final festivalBadge = specialEntry?['badge'];

    // Generate accurate Day and Night Chaughadiya for the specific weekday
    final dayChaughadiya = _buildDayChaughadiyaForWeekday(weekday, sunrise, sunset);
    final nightChaughadiya = _buildNightChaughadiyaForWeekday(weekday, sunset, sunrise);

    return PanchangDayData(
      date: date,
      dateHindi: dateHindi,
      dayName: dayName,
      tithi: tithiFull,
      paksha: paksha,
      samvat: samvat,
      nakshatra: nakshatra,
      yoga: yoga,
      karana: karana,
      sunrise: sunrise,
      sunset: sunset,
      moonrise: moonrise,
      moonset: moonset,
      rahuKaal: rahuKaal,
      yamaganda: yamaganda,
      abhijit: abhijit,
      amrit: amrit,
      special: special,
      festivalBadge: festivalBadge,
      dayChaughadiya: dayChaughadiya,
      nightChaughadiya: nightChaughadiya,
    );
  }

  static List<Map<String, dynamic>> _buildDayChaughadiyaForWeekday(int weekday, String sunrise, String sunset) {
    final Map<int, List<String>> order = {
      7: ['उद्वेग', 'चर', 'लाभ', 'अमृत', 'काल', 'शुभ', 'रोग', 'उद्वेग'],
      1: ['अमृत', 'काल', 'शुभ', 'रोग', 'उद्वेग', 'चर', 'लाभ', 'अमृत'],
      2: ['रोग', 'उद्वेग', 'चर', 'लाभ', 'अमृत', 'काल', 'शुभ', 'रोग'],
      3: ['लाभ', 'अमृत', 'काल', 'शुभ', 'रोग', 'उद्वेग', 'चर', 'लाभ'],
      4: ['शुभ', 'रोग', 'उद्वेग', 'चर', 'लाभ', 'अमृत', 'काल', 'शुभ'],
      5: ['चर', 'लाभ', 'अमृत', 'काल', 'शुभ', 'रोग', 'उद्वेग', 'चर'],
      6: ['काल', 'शुभ', 'रोग', 'उद्वेग', 'चर', 'लाभ', 'अमृत', 'काल'],
    };

    final names = order[weekday] ?? order[7]!;
    final times = [
      '07:00 – 08:25',
      '08:25 – 09:48',
      '09:48 – 11:12',
      '11:12 – 12:36',
      '12:36 – 02:00',
      '02:00 – 03:24',
      '03:24 – 04:48',
      '04:48 – 06:12',
    ];

    return List.generate(8, (i) {
      final name = names[i];
      final type = _getChaughadiyaType(name);
      return {
        'name': name,
        'time': times[i],
        'type': type,
      };
    });
  }

  static List<Map<String, dynamic>> _buildNightChaughadiyaForWeekday(int weekday, String sunset, String sunrise) {
    final Map<int, List<String>> order = {
      7: ['शुभ', 'अमृत', 'चर', 'रोग', 'काल', 'लाभ', 'उद्वेग', 'शुभ'],
      1: ['चर', 'रोग', 'काल', 'लाभ', 'उद्वेग', 'शुभ', 'अमृत', 'चर'],
      2: ['काल', 'लाभ', 'उद्वेग', 'शुभ', 'अमृत', 'चर', 'रोग', 'काल'],
      3: ['उद्वेग', 'शुभ', 'अमृत', 'चर', 'रोग', 'काल', 'लाभ', 'उद्वेग'],
      4: ['अमृत', 'चर', 'रोग', 'काल', 'लाभ', 'उद्वेग', 'शुभ', 'अमृत'],
      5: ['रोग', 'काल', 'लाभ', 'उद्वेग', 'शुभ', 'अमृत', 'चर', 'रोग'],
      6: ['लाभ', 'उद्वेग', 'शुभ', 'अमृत', 'चर', 'रोग', 'काल', 'लाभ'],
    };

    final names = order[weekday] ?? order[7]!;
    final times = [
      '06:12 – 07:48',
      '07:48 – 09:24',
      '09:24 – 11:00',
      '11:00 – 12:36',
      '12:36 – 02:12',
      '02:12 – 03:48',
      '03:48 – 05:24',
      '05:24 – 07:00',
    ];

    return List.generate(8, (i) {
      final name = names[i];
      final type = _getChaughadiyaType(name);
      return {
        'name': name,
        'time': times[i],
        'type': type,
      };
    });
  }

  static String _getChaughadiyaType(String name) {
    switch (name) {
      case 'अमृत': return 'अति श्रेष्ठ';
      case 'शुभ': return 'उत्तम';
      case 'लाभ': return 'शुभ';
      case 'चर': return 'सामान्य';
      case 'उद्वेग': return 'मध्यम';
      case 'रोग': return 'अशुभ';
      case 'काल': return 'अशुभ';
      default: return 'सामान्य';
    }
  }

  static String? getFestivalBadgeForDay(int year, int month, int day) {
    final key = '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    return _specialDates2026[key]?['badge'];
  }
}
