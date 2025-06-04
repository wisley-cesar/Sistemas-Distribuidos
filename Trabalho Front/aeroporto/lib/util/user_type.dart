enum UserType {
  FUNCIONARIO('Funcionário'),
  ADMIN('Administrador'),
  PASSAGEIRO('Passageiro');

  final String label;
  const UserType(this.label);

  static UserType fromString(String value) {
    return UserType.values.firstWhere(
      (type) => type.name == value.toUpperCase(),
      orElse: () => UserType.FUNCIONARIO,
    );
  }
}
