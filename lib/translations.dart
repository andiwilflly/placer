import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Search': 'Search',
          'Select language': 'Select language',
        },
        'ru_RU': {
          'Search': 'Поиск',
          'Select language': 'Выбрать язык',
        },
        'ua_UA': {
          'Search': 'Пошук',
          'Select language': 'Вибрати мову',
        }
      };
}
