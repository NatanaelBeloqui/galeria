// screens/tela_galeria.dart
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../screens/tela_detalhes.dart';
import '../widgets/widgets_customizados.dart';

// ============================================================
// TELA DA GALERIA — tela principal (origem do Hero)
// Contém: Animação Implícita (AnimatedContainer nos cards)
//         Hero animation (origem)
//         AnimatedOpacity (fade da mensagem de boas-vindas)
// ============================================================
class TelaGaleria extends StatefulWidget {
  const TelaGaleria({super.key});

  @override
  State<TelaGaleria> createState() => _TelaGaleriaState();
}

class _TelaGaleriaState extends State<TelaGaleria> {
  // Controla qual card está "expandido" (AnimatedContainer)
  String? _idExpandido;

  // Controla visibilidade da mensagem de boas-vindas (AnimatedOpacity)
  bool _mostrarBoasVindas = true;

  @override
  void initState() {
    super.initState();
    // Esconde a mensagem de boas-vindas após 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _mostrarBoasVindas = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text(
          '🛍️ Galeria de Produtos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: Column(
        children: [
          // ── ANIMAÇÃO IMPLÍCITA 1: AnimatedOpacity ────────
          // Mensagem de boas-vindas que desaparece sozinha após 3s
          AnimatedOpacity(
            opacity: _mostrarBoasVindas ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              height: _mostrarBoasVindas ? 52 : 0,
              child: Container(
                width: double.infinity,
                color: colorScheme.primaryContainer,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: Text(
                  '✨ Toque em um produto para ver os detalhes!',
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // ── Grade de produtos ─────────────────────────────
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                final estaExpandido = _idExpandido == produto.id;
                final cor = Color(produto.cor);

                return GestureDetector(
                  // Toque simples: expande/colapsa o card
                  onTap: () {
                    setState(() {
                      _idExpandido = estaExpandido ? null : produto.id;
                    });
                  },
                  // Toque longo: navega para a tela de detalhes
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TelaDetalhes(produto: produto),
                      ),
                    );
                  },
                  child: _CardProduto(
                    produto: produto,
                    cor: cor,
                    estaExpandido: estaExpandido,
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // NavigationBar M3 — componente obrigatório do Material Design 3
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Galeria',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded),
            label: 'Salvos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Perfil',
          ),
        ],
        onDestinationSelected: (_) {}, // Apenas demonstração
      ),
    );
  }
}

// ============================================================
// CARD DE PRODUTO — contém a Hero (origem) e AnimatedContainer
// Extraído como widget separado para melhor organização
// ============================================================
class _CardProduto extends StatelessWidget {
  final Produto produto;
  final Color cor;
  final bool estaExpandido;

  const _CardProduto({
    required this.produto,
    required this.cor,
    required this.estaExpandido,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          // ── ANIMAÇÃO IMPLÍCITA 2: AnimatedContainer ───────
          // Quando expandido: card fica maior e muda cor do fundo
          AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              // Cor muda sutilmente ao expandir
              color: estaExpandido
                  ? cor.withOpacity(0.15)
                  : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: estaExpandido ? cor : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Header colorido com CustomPainter (BÔNUS) ─
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      // Fundo com CustomPainter decorativo
                      CustomPaint(
                        painter: FundoCircularPainter(cor: cor),
                        child: Container(color: cor),
                      ),

                      // HERO ANIMATION — origem
                      // Ao navegar para TelaDetalhes, este widget
                      // "voa" até o destino com a mesma tag
                      Center(
                        child: Hero(
                          tag: 'produto-emoji-${produto.id}',
                          child: Text(
                            produto.emoji,
                            style: const TextStyle(fontSize: 52),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Informações do produto ─────────────────
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          produto.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),

                        // ANIMAÇÃO IMPLÍCITA 3: AnimatedContainer
                        // Mostra o preço e botão apenas quando expandido
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          height: estaExpandido ? 56 : 28,
                          child: estaExpandido
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // BadgePreco — widget customizado reutilizável
                                    BadgePreco(preco: produto.preco, corFundo: cor),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Segure para detalhes',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: cor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                )
                              : BadgePreco(preco: produto.preco, corFundo: cor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}