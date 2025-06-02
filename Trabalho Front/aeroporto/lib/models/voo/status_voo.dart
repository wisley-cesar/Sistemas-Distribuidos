enum StatusVoo {
  PROGRAMADO,
  EMBARQUE,
  CONCLUIDO;

  static fromJson(json) {
    switch (json) {
      case 'PROGRAMADO':
        return StatusVoo.PROGRAMADO;
      case 'EMBARQUE':
        return StatusVoo.EMBARQUE;
      case 'CONCLUIDO':
        return StatusVoo.CONCLUIDO;
      default:
        throw Exception('StatusVoo desconhecido: $json');
    }
  }

  toJson() {
    switch (this) {
      case StatusVoo.PROGRAMADO:
        return 'PROGRAMADO';
      case StatusVoo.EMBARQUE:
        return 'EMBARQUE';
      case StatusVoo.CONCLUIDO:
        return 'CONCLUIDO';
    }
  }
}
