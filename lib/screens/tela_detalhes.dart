// screens/tela_detalhes.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../widgets/widgets_customizados.dart';

// ============================================================
// TELA DE DETALHES — destino da transição Hero
// Contém: Hero animation (destino) + Animação Explícita
// (rotação do emoji com AnimationController + Tween)
// ============================================================
class TelaDetalhes extends StatefulWidget {
  final Produto produto;

  const TelaDetalhes({super.key, required this.produto});

  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes>
    with SingleTickerProviderStateMixin {
  // --- ANIMAÇÃO EXPLÍCITA ---
  // Controller controla o progresso de 0.0 → 1.0
  late AnimationController _controller;

  // Tween de rotação: 0 a 2π (uma volta completa = 360°)
  late Animation<double> _rotacaoAnim;

  // Tween de escala: 0.5 → 1.0 (aparece crescendo)
  late Animation<double> _escalaAnim;

  @override
  void initState() {
    super.initState();

    // Controller com duração de 800ms
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this, // sincroniza com o refresh da tela (SingleTickerProviderStateMixin)
    );

    // Rotação com curva elástica — dá aquele "quique" no final
    _rotacaoAnim = Tween<double>(
      begin: 0.0,
      end: 2 * pi, // uma volta completa
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    // Escala com curva bounceOut — cresce com "salto"
    _escalaAnim = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));

    // Inicia a animação assim que a tela é construída
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // SEMPRE limpar o controller!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cor = Color(widget.produto.cor);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // ── App Bar com Hero ──────────────────────────────
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: cor,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Fundo colorido com CustomPainter (BÔNUS)
                  CustomPaint(
                    painter: FundoCircularPainter(cor: cor),
                    child: Container(color: cor),
                  ),

                  // ANIMAÇÃO EXPLÍCITA: AnimatedBuilder reconstrói
                  // apenas este widget a cada frame (eficiente!)
                  Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _escalaAnim.value,
                          child: Transform.rotate(
                            angle: _rotacaoAnim.value,
                            child: child,
                          ),
                        );
                      },
                      // child NÃO é reconstruído a cada frame — apenas transformado
                      child: Hero(
                        // HERO ANIMATION — destino (mesma tag da tela de lista!)
                        tag: 'produto-emoji-${widget.produto.id}',
                        child: Text(
                          widget.produto.emoji,
                          style: const TextStyle(fontSize: 100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Conteúdo ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho: nome + BadgePreco (widget customizado)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.produto.nome,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // BadgePreco — widget customizado reutilizável
                      BadgePreco(preco: widget.produto.preco, corFundo: cor),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Descrição
                  Text(
                    widget.produto.descricao,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.75),
                          height: 1.6,
                        ),
                  ),

                  const SizedBox(height: 32),

                  // Botões de ação (widgets customizados reutilizáveis)
                  Row(
                    children: [
                      Expanded(
                        // BotaoDestaque — widget customizado (FilledButton)
                        child: BotaoDestaque(
                          texto: 'Comprar',
                          icone: Icons.shopping_cart_rounded,
                          cor: cor,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${widget.produto.nome} adicionado!'),
                                backgroundColor: cor,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      // BotaoDestaque — widget customizado (outlined)
                      BotaoDestaque(
                        texto: 'Salvar',
                        icone: Icons.favorite_border_rounded,
                        cor: cor,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${widget.produto.nome} salvo!'),
                              backgroundColor: cor,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        outlined: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Replay da animação
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        // Volta ao início e toca novamente
                        _controller.reset();
                        _controller.forward();
                      },
                      icon: Icon(Icons.replay_rounded, color: cor),
                      label: Text(
                        'Repetir animação',
                        style: TextStyle(color: cor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
