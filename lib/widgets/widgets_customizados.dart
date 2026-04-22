// widgets_customizados.dart
import 'package:flutter/material.dart';

// ============================================================
// WIDGET CUSTOMIZADO 1: BotaoDestaque
// Botão estilizado reutilizável com ícone e texto.
// Recebe parâmetros: texto, ícone, cor e callback.
// Usado em: TelaDetalhes (Comprar) e TelaGaleria (Favoritar)
// ============================================================
class BotaoDestaque extends StatelessWidget {
  final String texto;
  final IconData icone;
  final Color cor;
  final VoidCallback onPressed;
  final bool outlined;

  const BotaoDestaque({
    super.key,
    required this.texto,
    required this.icone,
    required this.cor,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icone, color: cor),
        label: Text(texto, style: TextStyle(color: cor, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: cor, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
    }
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icone),
      label: Text(texto, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      style: FilledButton.styleFrom(
        backgroundColor: cor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

// ============================================================
// WIDGET CUSTOMIZADO 2: BadgePreco
// Badge estilizado para exibir o preço de um produto.
// Recebe parâmetros: preco e corFundo.
// Usado em: CardProduto (galeria) e TelaDetalhes (header)
// ============================================================
class BadgePreco extends StatelessWidget {
  final double preco;
  final Color corFundo;

  const BadgePreco({
    super.key,
    required this.preco,
    required this.corFundo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: corFundo.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

// ============================================================
// CUSTOM PAINTER — BÔNUS
// Desenha um padrão decorativo de círculos concêntricos
// com gradiente, usado como fundo do card de produto.
// ============================================================
class FundoCircularPainter extends CustomPainter {
  final Color cor;

  const FundoCircularPainter({required this.cor});

  @override
  void paint(Canvas canvas, Size size) {
    final centro = Offset(size.width * 0.75, size.height * 0.3);

    // Desenha 3 círculos concêntricos com opacidade decrescente
    for (int i = 3; i >= 1; i--) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(0.06 * i)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(centro, size.width * 0.18 * i, paint);
    }

    // Círculo menor sólido (decorativo)
    final paintSolido = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(centro, size.width * 0.12, paintSolido);

    // Arco decorativo no canto inferior esquerdo
    final paintArco = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rect = Rect.fromCircle(
      center: Offset(-size.width * 0.05, size.height * 1.05),
      radius: size.width * 0.5,
    );
    canvas.drawArc(rect, -1.2, 1.5, false, paintArco);
  }

  @override
  bool shouldRepaint(FundoCircularPainter oldDelegate) =>
      oldDelegate.cor != cor; // Repinta somente se a cor mudar
}
