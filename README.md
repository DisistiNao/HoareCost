# HoareCost 🚀

Ferramenta de verificação formal e análise de complexidade assintótica desenvolvida em Haskell. Este projeto estende a Lógica de Hoare tradicional para incluir custos de execução, gerando Condições de Verificação (VCs) que são validadas automaticamente pelo solucionador SMT **Z3** através da biblioteca **SBV**.

## Como Compilar e Rodar

No terminal, dentro da pasta raiz do projeto:

1.  **Compilar o projeto:**
    ```bash
    cabal build
    ```

2.  **Executar os casos de teste:**
    ```bash
    cabal run examples
    ```

## Exemplo de Uso: Laço "While"

Para este exemplo, é necessário passar os seguintes valores para o **Oráculo** resolver o exemplo do **Algoritmo de Divisão**:

| Parâmetro | Valor para Copiar e Colar |
| :--- | :--- |
| **Invariant** | `And (PropVar (Eq (Var "X") (Plus (Mult (Var "Q") (Var "Y")) (Var "R")))) (And (PropVar (Gt (Var "Y") (Z))) (PropVar (Ge (Var "R") (Z))))` |
| **Variant** | `Minus (Var "X") (Var "R")` |
| **Num. Iterations**| `Var "X"` |
| **Cost Function** | `S (S (S (S (S (S (S (S (S (S Z)))))))))` |