<!-- README.md -->

# 🛍️ Galeria de Animações — Aula 9

Projeto Flutter desenvolvido para a **Atividade Prática da Aula 9** da disciplina de Desenvolvimento para Dispositivos Móveis — 5ª Fase ADS, Faculdade Senac Joinville (2026/1).

## 📱 Sobre o Projeto

Aplicativo de **Galeria de Produtos** que demonstra diferentes tipos de animações e componentes customizados em Flutter, com Material Design 3 habilitado.

---

## ✅ Requisitos Implementados

### 1. Animação Implícita

Três animações implícitas foram implementadas na `TelaGaleria`:

- **`AnimatedOpacity`** — mensagem de boas-vindas que aparece ao entrar na tela e desaparece automaticamente após 3 segundos com fade suave (600ms, `Curves.easeOut`).
- **`AnimatedContainer`** (borda e cor de fundo) — ao tocar em um card, ele ganha borda colorida e fundo levemente tintado (350ms, `Curves.easeInOut`).
- **`AnimatedContainer`** (altura) — dentro do card expandido, a área de preço cresce para exibir uma dica extra (300ms, `Curves.easeOut`).

### 2. Animação Explícita

Implementada na `TelaDetalhes` usando:

- `AnimationController` com `SingleTickerProviderStateMixin` — duração de 800ms.
- `Tween<double>` para rotação (0 → 2π) com `Curves.elasticOut`.
- `Tween<double>` para escala (0.4 → 1.0) com `Curves.bounceOut`.
- `AnimatedBuilder` — reconstrói apenas o widget do emoji, não a árvore inteira.
- `dispose()` chamado corretamente no `_TelaDetalhesState`.

O emoji do produto entra girando e crescendo com efeito elástico ao abrir a tela de detalhes.

### 3. Hero Animation

- **Origem:** `Hero(tag: 'produto-emoji-${produto.id}')` dentro de cada `_CardProduto` na `TelaGaleria`.
- **Destino:** mesma `tag` dentro do `AnimatedBuilder` na `TelaDetalhes`.
- Tags são únicas por produto (usam o `id` do produto).
- Ativada com **toque longo** em qualquer card da galeria.

### 4. Material Design 3

Configurado no `main.dart`:

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF1565C0),
    brightness: Brightness.light,
  ),
)
```

Componentes M3 utilizados:
- `NavigationBar` (substitui `BottomNavigationBar`)
- `FilledButton` (dentro do `BotaoDestaque`)
- `OutlinedButton` (variante do `BotaoDestaque`)

### 5. Widgets Customizados Reutilizáveis

Dois widgets customizados em `lib/widgets/widgets_customizados.dart`:

**`BotaoDestaque`** — botão estilizado com ícone, texto e cor configuráveis. Suporta modo preenchido (`FilledButton`) e contornado (`OutlinedButton`). Usado em:
- `TelaDetalhes` → botão "Comprar" e botão "Salvar"

**`BadgePreco`** — badge arredondado para exibir preço com cor de fundo configurável. Usado em:
- `_CardProduto` (galeria) → preço no card
- `TelaDetalhes` → preço no cabeçalho

Ambos aceitam parâmetros e usam `const` constructor.

---

## 🎨 BÔNUS — CustomPainter

`FundoCircularPainter` em `lib/widgets/widgets_customizados.dart`:

- Desenha **3 círculos concêntricos** com opacidade decrescente (`canvas.drawCircle`).
- Desenha um **arco decorativo** no canto inferior esquerdo (`canvas.drawArc`).
- `shouldRepaint()` retorna `true` apenas quando a cor muda.
- Usado como fundo decorativo em: `_CardProduto` e `TelaDetalhes`.

---

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                          # Configuração MD3 e entrada do app
├── models/
│   └── produto.dart                   # Modelo de dados + lista de produtos
├── screens/
│   ├── tela_galeria.dart              # Tela principal (animações implícitas + Hero origem)
│   └── tela_detalhes.dart             # Tela de detalhes (animação explícita + Hero destino)
└── widgets/
    └── widgets_customizados.dart      # BotaoDestaque, BadgePreco, FundoCircularPainter
```

---

## 🚀 Como executar

```bash
flutter pub get
flutter run
```

Requisitos: Flutter SDK 3.x ou superior.

---

## 👥 Autores

- Miguel Antônio
- Natanael Beloqui

Faculdade Senac Joinville — ADS 5ª Fase — 2026/1
