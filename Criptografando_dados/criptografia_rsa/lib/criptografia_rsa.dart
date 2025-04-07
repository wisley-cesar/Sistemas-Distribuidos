import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';

void gerarHash(String mensagem) {
  var bytes = utf8.encode(mensagem);
  var hash = sha256.convert(bytes);
  print('🔁 Hash da mensagem original: $hash');
}

// Função para calcular o MDC (máximo divisor comum)
int mdc(int a, int b) {
  while (b != 0) {
    int temp = b;
    b = a % b;
    a = temp;
  }
  return a;
}

// Função para calcular o inverso multiplicativo de e mod φ(n)
int inversoModular(int e, int phi) {
  int d = 0, x1 = 0, x2 = 1, y1 = 1;
  int tempPhi = phi;

  while (e > 0) {
    int q = tempPhi ~/ e;
    int temp = e;
    e = tempPhi % e;
    tempPhi = temp;

    int x = x2 - q * x1;
    int y = d - q * y1;

    x2 = x1;
    x1 = x;
    d = y1;
    y1 = y;
  }

  if (tempPhi == 1) {
    return (d + phi) % phi;
  }

  return -1; // erro
}

// Função para criptografar um valor
BigInt cifrar(int msg, BigInt e, BigInt n) {
  return BigInt.from(msg).modPow(e, n);
}

// Função para descriptografar um valor
int decifrar(BigInt cifra, BigInt d, BigInt n) {
  return cifra.modPow(d, n).toInt();
}

void main() {
  // Passo 1: Geração das chaves
  int p = 17;
  int q = 11;
  int n = p * q;
  int phi = (p - 1) * (q - 1);
  int e = 7;
  int d = inversoModular(e, phi);

  print('🔢 P = $p');
  print('🔢 Q = $q');
  print('🔢 N = $n');
  print('🔢 PHI = $phi');
  print('🔑 Chave pública: (e = $e, n = $n)');
  print('🔒 Chave privada: (d = $d, n = $n)');

  // Passo 2: Receber mensagem do usuário
  stdout.write('\n📝 Digite uma mensagem para criptografar: ');
  String mensagem = stdin.readLineSync() ?? "";
  print('🔤 Mensagem original: $mensagem');

  // Converte caracteres para ASCII
  List<int> ascii = mensagem.codeUnits;

  // Converte e, d, n para BigInt
  BigInt bigE = BigInt.from(e);
  BigInt bigD = BigInt.from(d);
  BigInt bigN = BigInt.from(n);

  // Criptografar a mensagem (cada caractere individualmente)
  List<BigInt> cifra = ascii.map((char) => cifrar(char, bigE, bigN)).toList();
  print('\n🔐 Mensagem criptografada (valores RSA): $cifra');

  // Descriptografar a mensagem
  List<int> decifrada = cifra.map((c) => decifrar(c, bigD, bigN)).toList();
  String mensagemOriginal = String.fromCharCodes(decifrada);
  print('🔓 Mensagem descriptografada: $mensagemOriginal');

  // Passo 4: Hash da mensagem original
  gerarHash(mensagem);
}
