# Aula 04 — Calculadora de Receita da Lavoura (aula prática guiada)

> **Programação para Dispositivos Móveis** · 6º período — Bacharelado em Sistemas de Informação
> Instituto Federal Goiano — Campus Ceres · Prof. Dr. Paulo César Ferreira Melo

Nesta aula construímos um app **do zero, juntos**, passo a passo. Ao final,
você terá uma calculadora que estima a **receita bruta de um talhão** a
partir da área, da produtividade e da cotação da saca — uma peça que pode
virar uma funcionalidade do **Caderno de Campo do Vale**.

É a mesma fórmula de receita que você já usou nos exercícios de Dart
(`área × produtividade × cotação`), agora com uma tela de verdade: campos
para digitar, um botão para calcular e um resultado em destaque.

---

## O que tem nesta pasta

| Pasta | O que é | Quando usar |
|---|---|---|
| [`projeto-inicial/`](projeto-inicial/) | O **esqueleto** da calculadora, com os passos da aula em branco | É **aqui que a aula acontece**: você completa os passos, no VS Code |

> A solução completa (o app pronto) é disponibilizada pelo professor no
> **Moodle**, após a aula.

---

## Antes de começar

Você precisa do ambiente Flutter instalado (Flutter SDK, VS Code com as
extensões Flutter e Dart, e o Android configurado). Os tutoriais de
instalação estão na pasta `ambiente/`, na raiz do repositório.

Confirme que está tudo certo:

```bash
flutter doctor
```

Você deve ver `[✓]` em **Flutter** e no **Android toolchain**.

---

## Como rodar (VS Code)

O projeto **não versiona** as pastas nativas (`android/`, `ios/`…), que são
geradas por máquina. Por isso, ao abrir pela primeira vez, você as gera
localmente com um comando — é rápido e só se faz uma vez.

1. Abra a pasta [`projeto-inicial/`](projeto-inicial/) no VS Code
   (**Arquivo → Abrir Pasta**).

2. No terminal integrado, dentro da pasta do projeto:

   ```bash
   flutter create .      # gera android/, ios/ e demais pastas nativas
   flutter pub get       # baixa as dependências
   ```

3. Escolha um dispositivo (emulador Android, celular por cabo, ou
   `chrome`/`windows` como alternativa) e rode:

   ```bash
   flutter run
   ```

4. **Deixe o app rodando.** A partir daí, cada vez que você salvar, o
   **hot reload** aplica a mudança na hora. É o que torna a aula guiada
   fluida: você vê cada passo surgir na tela.

> O app já roda desde o primeiro minuto, mostrando só o cabeçalho. Você vai
> preenchendo os passos e vendo a tela crescer.

---

## Como funciona a aula guiada

O professor apresenta um passo, você o completa no mesmo instante, e
seguimos juntos. Cada trecho a completar está marcado no arquivo
`lib/main.dart` com um comentário:

```dart
// TODO PASSO N — ...
```

Vá na ordem dos números. O que já está pronto no esqueleto é o mínimo para
o app rodar e os widgets de apoio (o campo de número e a área de resultado)
— assim a aula foca no que ensina, não em digitar código repetitivo.

### Os passos, em resumo

| Passo | O que você faz |
|---|---|
| 3 | Cria os **controladores** dos três campos (área, produtividade, cotação) |
| 4 | Cria o **estado** do resultado (`_receita`, `_erro`) |
| 5 | Monta os **campos** na tela |
| 6 | Escreve a **função que calcula**, com validação |
| 7 | Adiciona os **botões** Calcular e Limpar |
| 8 | Libera os controladores no **`dispose`** |
| 9 | Escreve a função **Limpar** |
| 10 | Mostra o **resultado** em destaque |

> Os passos 1 e 2 (o app, o tema e a tela com estado) já vêm prontos.

---

## Testando ao final

**Teste feliz:** área `96,4`, produtividade `55`, cotação `128,40`.
O resultado deve ser **R$ 680.776,80**.

**Teste de erro** (tão importante quanto o acerto): deixe um campo vazio,
digite letras no lugar de número, tente um valor negativo. A validação deve
segurar cada caso com uma mensagem clara. Um app de campo recebe dado torto
o tempo todo — prever o erro é parte do trabalho.

---

## Entrega

Faça um commit do seu `projeto-inicial` com a calculadora construída:

```bash
git add .
git commit -m "Aula 04: calculadora de receita da lavoura"
git push
```

O `.gitignore` já ignora as pastas nativas e o `build/`, então o commit
sobe só o que interessa: seu `lib/` e o `pubspec.yaml`.

---

## Desafios opcionais

- **Fácil:** acrescente um campo de custo por hectare e mostre também a
  **receita líquida** (receita menos custo total).
- **Médio:** exiba o resultado também em **alqueires goianos**
  (área ÷ 4,84).
- **Avançado:** adicione um seletor de cultura (soja, milho, sorgo) que
  preenche a cotação com um valor sugerido.

Referência: <https://docs.flutter.dev/cookbook> — receitas prontas para
tarefas comuns, incluindo formulários e validação.
