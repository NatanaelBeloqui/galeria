// models/produto.dart
/// Modelo de dados para um produto da galeria
class Produto {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final String emoji; // Representa o produto visualmente
  final int cor; // Color value (ARGB)

  const Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.emoji,
    required this.cor,
  });
}

/// Lista de produtos de exemplo para a galeria
final List<Produto> produtos = [
  Produto(
    id: 'tenis-01',
    nome: 'Tênis Runner Pro',
    descricao:
        'Tênis de corrida de alto desempenho com amortecimento avançado e cabedal respirável. '
        'Ideal para longas distâncias e treinos intensos.',
    preco: 349.90,
    emoji: '👟',
    cor: 0xFF1565C0,
  ),
  Produto(
    id: 'mochila-02',
    nome: 'Mochila Urban XL',
    descricao:
        'Mochila espaçosa com compartimentos organizados, porta notebook de 15" e '
        'material impermeável. Perfeita para o dia a dia.',
    preco: 189.90,
    emoji: '🎒',
    cor: 0xFF2E7D32,
  ),
  Produto(
    id: 'relogio-03',
    nome: 'Smartwatch Elite',
    descricao:
        'Relógio inteligente com monitor cardíaco, GPS integrado e autonomia de 7 dias. '
        'Resistente à água até 50 metros.',
    preco: 799.00,
    emoji: '⌚',
    cor: 0xFF6A1B9A,
  ),
  Produto(
    id: 'fone-04',
    nome: 'Fone Bluetooth NC',
    descricao:
        'Fone de ouvido com cancelamento de ruído ativo, 30h de bateria e '
        'áudio de alta fidelidade. Conforto premium para longas sessões.',
    preco: 459.00,
    emoji: '🎧',
    cor: 0xFFBF360C,
  ),
  Produto(
    id: 'oculos-05',
    nome: 'Óculos UV400',
    descricao:
        'Óculos de sol com lentes polarizadas, proteção UV400 e armação leve '
        'em acetato. Design moderno para o dia a dia.',
    preco: 129.90,
    emoji: '🕶️',
    cor: 0xFF00695C,
  ),
  Produto(
    id: 'garrafa-06',
    nome: 'Garrafa Thermo 1L',
    descricao:
        'Garrafa térmica em aço inox com dupla parede a vácuo. Mantém bebidas '
        'quentes por 12h e frias por 24h. Tampa hermética.',
    preco: 89.90,
    emoji: '🍶',
    cor: 0xFFC62828,
  ),
];