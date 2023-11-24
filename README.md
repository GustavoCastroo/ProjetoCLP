# ProjetoCLP
 
Desenvolver um sistema utilizando a linguagem escolhida pela equipe no seminário. O sistema deve apresentar
um menu em linha de comando que permite a inclusão, alteração, remoção e visualização dos dados das entidades
abaixo. As classes das entidades devem conter apenas atributos e métodos que manipulam os dados. A interface
em linha de comando deve ser implementada em uma ou mais classes separadas:

1. Pessoa (abstrata): nome (String), endereço (String);
2. Cliente (subclasse de Pessoa): rg (String), data de nascimento (Date);
3. Produto: código (int), nome (String), valor (float);
4. Totalizavel (abstrata ou interface): define um método abstrato chamado total que retorna o valor total
(float);
5. Venda (subclasse de Totalizavel): número (int), data (Date), cliente (Cliente), itens (lista ou array de
ItemVenda). O método total deve calcular a soma dos totais de cada item.
    • ItemVenda (subclasse de Totalizavel): produto (Produto), valor (float), quantidade (int). O valor é copiado
    do valor do produto no momento da venda, assim, mesmo que o valor do produto mude posteriormente,
    as vendas mantêm o valor do momento em que foram realizadas). O método total deve calcular o valor
    vezes a quantidade.

Detalhes importantes:

    • Não precisa ter interface gráfica nem persistir os dados em arquivo ou banco de dados;

    • Não é necessário haver opções no menu para entidades abstratas;

    • Não é necessário implementar a alteração de Venda e ItemVenda.

    • ItemVenda não aparece no menu. Cada ItemVenda existe apenas dentro de uma Venda. Portanto, o
    cadastro de ItemVenda é feito dentro do cadastro de uma Venda e, ao excluir uma venda, todos os seus
    ItemVenda também são excluídos. A visualização de ItemVenda é feita a partir da visualização da Venda
    a qual pertencem;