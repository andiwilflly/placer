import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Search': 'Search',
          'Submit': 'Submit',
          'Select language': 'Select language',
          'Please enter some text': 'Please enter some text',
          'Latitude': 'Latitude',
          'Longitude': 'Longitude',
          'Draw polygon': 'Draw polygon',
        },
        'ru_RU': {
          'Search': 'Поиск',
          'Submit': 'Сохранить',
          'Select language': 'Выбрать язык',
          'Please enter some text': 'Введите какой-то текст',
          'Latitude': 'Широта',
          'Longitude': 'Долгота',
          'Draw polygon': 'Рисовать полигон',
        },
        'ua_UA': {
          'Search': 'Пошук',
          'Submit': 'Зберегти',
          'Select language': 'Вибрати мову',
          'Please enter some text': 'Введiть якийсь текст',
          'Latitude': 'Широта',
          'Longitude': 'Довгота',
          'Draw polygon': 'Малювати полiгон',
        }
      };
}
