import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GameData {
  String levelName;
  List<dynamic>? questions;

  GameData({required this.levelName});

  Future<void> getQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(levelName);
    if (jsonString != null) {
      questions = jsonDecode(jsonString);
    } else {
      // في حال عدم وجود أسئلة محفوظة، قم بتحميل الأسئلة الافتراضية حسب المستوى
      switch (levelName) {
        case 'المستوى 1':
          questions = [
            {'ar': 'تفاحة', 'en': 'apple'},
            {'ar': 'شجرة', 'en': 'tree'},
            {'ar': 'قطة', 'en': 'cat'},
            {'ar': 'كلب', 'en': 'dog'},
            {'ar': 'بيت', 'en': 'house'},
          ];
          break;
        case 'المستوى 2':
          questions = [
            {'ar': 'سيارة', 'en': 'car'},
            {'ar': 'طائرة', 'en': 'plane'},
            {'ar': 'دراجة', 'en': 'bicycle'},
            {'ar': 'قطار', 'en': 'train'},
            {'ar': 'قارب', 'en': 'boat'},
          ];
          break;
        case 'المستوى 3':
          questions = [
            {'ar': 'هاتف', 'en': 'phone'},
            {'ar': 'حاسوب', 'en': 'computer'},
            {'ar': 'تلفاز', 'en': 'television'},
            {'ar': 'كاميرا', 'en': 'camera'},
            {'ar': 'مكبر صوت', 'en': 'speaker'},
          ];
          break;
        // يمكنك إضافة المزيد من المستويات هنا
        default:
          questions = [
            {'ar': 'كتاب', 'en': 'book'},
            {'ar': 'قلم', 'en': 'pen'},
            {'ar': 'كرسي', 'en': 'chair'},
          ];
          break;
      }
    }
  }
}
