import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  
  const ButtonLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Entrar',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
