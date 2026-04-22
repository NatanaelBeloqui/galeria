// main.dart
import 'package:flutter/material.dart';
import 'screens/tela_galeria.dart';

void main() {
  runApp(const GaleriaAnimacoesApp());
}

// ============================================================
// APP PRINCIPAL — configura Material Design 3
// ============================================================
class GaleriaAnimacoesApp extends StatelessWidget {
  const GaleriaAnimacoesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeria de Animações',
      debugShowCheckedModeBanner: false,

      // ── Material Design 3 — OBRIGATÓRIO ──────────────────
      theme: ThemeData(
        useMaterial3: true, // Habilita MD3
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0), // Azul como cor base
          brightness: Brightness.light,
        ),
      ),

      // Tema escuro também configurado com MD3
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.dark,
        ),
      ),

      themeMode: ThemeMode.system, // Segue o sistema do dispositivo

      home: const TelaGaleria(),
    );
  }
}