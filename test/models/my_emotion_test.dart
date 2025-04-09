import 'package:flutter_test/flutter_test.dart';
import 'package:mood_sync/models/my_emotion.dart';

void main() {
  group('MyEmotion', () {
    test('Deve criar uma instância de MyEmotion corretamente', () {
      final emotion = MyEmotion(
        emocao: 'Feliz',
        descricao: 'Dia muito produtivo',
        data: DateTime(2023, 10, 1),
      );

      expect(emotion.emocao, 'Feliz');
      expect(emotion.descricao, 'Dia muito produtivo');
      expect(emotion.data, DateTime(2023, 10, 1));
    });

    test('Deve converter MyEmotion para Map corretamente', () {
      final emotion = MyEmotion(
        emocao: 'Feliz',
        descricao: 'Dia muito produtivo',
        data: DateTime(2023, 10, 1),
      );

      final map = emotion.toMap();

      expect(map['emocao'], 'Feliz');
      expect(map['descricao'], 'Dia muito produtivo');
      expect(map['data'], '2023-10-01T00:00:00.000'); // Formato ISO 8601
    });

    test('Deve criar MyEmotion a partir de Map corretamente', () {
      final map = {
        'emocao': 'Feliz',
        'descricao': 'Dia muito produtivo',
        'data': '2023-10-01T00:00:00.000',
      };

      final emotion = MyEmotion.fromMap(map);

      expect(emotion.emocao, 'Feliz');
      expect(emotion.descricao, 'Dia muito produtivo');
      expect(emotion.data, DateTime(2023, 10, 1));
    });
  });
}
