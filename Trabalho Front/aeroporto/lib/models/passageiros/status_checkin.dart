enum StatusCheckin {
  PENDENTE,
  REALIZADO;

  static fromJson(json) {
    switch (json) {
      case 'PENDENTE':
        return StatusCheckin.PENDENTE;
      case 'REALIZADO':
        return StatusCheckin.REALIZADO;
    }
  }
}
