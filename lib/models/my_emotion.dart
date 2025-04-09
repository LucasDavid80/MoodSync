class MyEmotion {
  final String emocao;
  final String descricao;
  final DateTime data;

  MyEmotion({
    required this.emocao,
    required this.descricao,
    required this.data,
  });

  // Converte a instância para um mapa (para salvar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'emocao': emocao,
      'descricao': descricao,
      'data': data.toIso8601String(), // Salva a data como string ISO 8601
    };
  }

  // Cria uma instância de MyEmotion a partir de um mapa (para recuperar do banco de dados)
  factory MyEmotion.fromMap(Map<String, dynamic> map) {
    return MyEmotion(
      emocao: map['emocao'],
      descricao: map['descricao'],
      data: DateTime.parse(
        map['data'],
      ), // Converte a string ISO 8601 de volta para DateTime
    );
  }
}
