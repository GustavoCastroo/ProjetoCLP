unit ClassMain;

interface
uses
  SysUtils, System.Generics.Collections, ClassCliente, ClassProduto, ClassVenda, ClassItemVenda;
type
  TMain = class    // Definicao do tipo de TMain
  // T = Type

  private          // Declaracao dos atributos
    FClientes: TObjectList<TCliente>;
    FProdutos: TObjectList<TProduto>;
    FVendas: TObjectList<TVenda>;
    // F = Field

  public          // Assinaturas dos metodos
    constructor Create;
    procedure AdicionarCliente;
    procedure AdicionarProduto;
    procedure AdicionarVenda;
    procedure AdicionarItemVenda(venda: TVenda);
    procedure AlterarCliente;
    procedure AlterarProduto;
    procedure RemoverCliente;
    procedure RemoverProduto;
    procedure RemoverVenda;
    procedure RemoverItemVenda(venda: TVenda);
    procedure VisualizarClientes;
    procedure VisualizarProdutos;
    procedure VisualizarVendas;
    function PesquisaCliente(rg: string): TCliente;
    function PesquisaProduto(codigo: integer): TProduto;
    function PesquisaVenda(numero: integer): TVenda;

  end;
implementation

  constructor TMain.Create;             // Instanciacao dos atributos
  begin
    inherited Create;
    FClientes := TObjectList<TCliente>.Create;
    FProdutos := TObjectList<TProduto>.Create;
    FVendas := TObjectList<TVenda>.Create;
  end;

  procedure TMain.AdicionarCliente;
  var           // Declaracao das variaveis locais
    cliente: TCliente;
    padrao_data: TDateTime;
    nome: string;
    rg: string;
    endereco: string;
    data_nascimento: string;
  begin
    repeat      // Garante que um RG seja inserido
      writeln('Digite o RG do Cliente: ');
      readln(rg);

      if rg = '' then
      begin
        writeln('O RG não pode ser vazio!');
      end;
    until rg <> '';

    // Verifica se o RG ja esta no sistema
    cliente := PesquisaCliente(rg);

    if cliente <> nil then
    begin
      writeln('Esse RG já está cadastrado!');
      // Forca que a execucao do metodo seja encerrada
      Exit();
    end;

    // Coleta nome, endereco e data de nascimento
    writeln('Digite o nome do Cliente: ');
    readln(nome);

    writeln('Digite o Endereço do Cliente: ');
    readln(endereco);

    writeln('Digite a Data de Nascimento do Cliente: (dd/mm/aaaa)');
    readln(data_nascimento);

    // Instanciacao do cliente
    cliente:= TCliente.Create;

    cliente.RG := rg;
    cliente.Nome := nome;
    cliente.Endereco := endereco;

    if TryStrToDateTime(data_nascimento, padrao_data) then
    begin
      cliente.DataNascimento := StrToDateTime(data_nascimento);
    end;

    // Adiciona o cliente a lista de clientes
    FClientes.add(cliente);
    writeln('Cliente adicionado com sucesso!');
  end;

  procedure TMain.AdicionarProduto;
  var
    produto: TProduto;
    padrao_int: integer;
    padrao_double: double;
    nome: string;
    codigo: string;
    valor: string;

  begin
    // Garante que o codigo do produto seja um inteiro
    repeat
      writeln('Digite o Código numérico do Produto: ');
      readln(codigo);

      if not TryStrToInt(codigo, padrao_int) then       // Garante um padrao de inteiro equivalente a padrao_int
      begin
        writeln('Esse Código não é um número inteiro!');
      end;
    until TryStrToInt(codigo, padrao_int);

    // Verifica se o codigo equivale a um produto ja cadastrado
    produto := PesquisaProduto(StrToInt(codigo));

    if produto <> nil then
    begin
      writeln('Esse Código já está cadastrado!');
      Exit();
    end;

    // Obtem nome do produto
    writeln('Digite o Nome do Produto: ');
    readln(nome);

    // Garante que o valor do produto seja um float
    repeat
      writeln('Digite o valor do Produto: (Use , ao invés de .)');
      readln(valor);

      if not TryStrToFloat(valor, padrao_double) then   // Garante um padrao de float equivalente a padrao_double
      begin
        writeln('Esse valor não é um número de ponto flutuante!');
      end;
    until TryStrToFloat(valor, padrao_double);

    // Instanciacao do produto
    produto := TProduto.Create;

    produto.Codigo := StrToInt(codigo);
    produto.Nome := nome;
    produto.Valor := StrToFloat(valor);

    FProdutos.add(produto);
    writeln('Produto adicionado com sucesso!');
  end;

  procedure TMain.AdicionarVenda;
  var
    venda: TVenda;
    cliente: TCliente;
    padrao_int: integer;
    padrao_data: TDateTime;
    numero: string;
    data: string;
    rg: string;
  begin

    // Garante que uma venda so sera realizada se houver pelo menos um produto e um cliente cadastrados
    if (FProdutos.Count <> 0) and (FClientes.Count <> 0) then
    begin
      writeln('Digite o RG do Cliente comprador:');
      readln(rg);

      // Verifica se o RG ja esta cadastrado
      cliente := PesquisaCliente(rg);

      if cliente = nil then
      begin
        Exit;
      end;

      repeat
        writeln('Digite o número da Venda:');
        readln(numero);

        if not TryStrToInt(numero, padrao_int) then      // Garante um padrao de inteiro equivalente a padrao_int
        begin
          writeln('Esse Número não é um número inteiro!');
        end;
      until TryStrToInt(numero, padrao_int);


      // Verifica se a venda ja existe
      venda := PesquisaVenda(StrToInt(numero));

      if venda <> nil then
      begin
        writeln('Esse Número já está cadastrado!');
        Exit();
      end;

      // Garante uma data padronizada
      repeat
        writeln('Digite a data da Venda: (dd/mm/aaaa)');
        readln(data);

        if not TryStrToDateTime(data, padrao_data) then
        begin
          writeln('A data informada não está dentro do padrão dd/mm/aaaa');
        end;
      until TryStrToDateTime(data, padrao_data);


      // Instanciacao da venda
      venda := TVenda.Create(StrToInt(numero), StrToDateTime(data), cliente);

      AdicionarItemVenda(venda);
      FVendas.Add(venda);
      writeln('Venda adicionada com sucesso!');
    end
    else
    begin
      if FProdutos.Count = 0 then
      begin
        writeln('Não há Produtos cadastrados!')
      end;

      if FClientes.Count = 0 then
      begin
        writeln('Não há Clientes cadastrados!')
      end;
    end;

  end;

  procedure TMain.AdicionarItemVenda(venda: TVenda);
  var
    item_venda: TItemVenda;
    produto: TProduto;
    padrao_int: integer;
    ver_lista_produto: integer;
    mais_produto: integer;
    codigo: integer;
    quantidade: string;
  begin
  // Menu de adicao de ItemVenda
    repeat
        writeln('Deseja visualizar a lista de Produtos?');
        writeln('1. Sim');
        writeln('2. Não');
        readln(ver_lista_produto);
    until (ver_lista_produto = 1) or (ver_lista_produto = 2);

    if ver_lista_produto = 1 then
    begin
      VisualizarProdutos;
    end;

    repeat
      if venda.Itens.Count > 0 then
      begin
        writeln('Deseja adicionar mais algum produto?');
        writeln('1. Sim');
        writeln('2. Não');
        readln(mais_produto);
      end
      else
      begin
        mais_produto := 1;
      end;

      if mais_produto = 1 then
      begin
        // Garante que seja escolhido um produto existente
        repeat
          writeln('Digite o codigo do Produto que você deseja comprar: ');
          readln(codigo);

          produto := PesquisaProduto(codigo);
        until(produto <> nil);

        // Garante um valor inteiro de produtos
        repeat
          writeln('Digite a quantidade de unidades desse produto:');
          readln(quantidade);

          if not TryStrToInt(quantidade, padrao_int) then
          begin
            writeln('Esse Número não é um número inteiro!');
          end;
        until TryStrToInt(quantidade, padrao_int);

        // ItemVenda instanciado
        item_venda := TItemVenda.Create(produto,StrToInt(quantidade));
        venda.AdicionarItem(item_venda);
        writeln('Item adicionado com sucesso!');
      end;

      // Garante que algo seja comprado (pelo menos um item)
      if (mais_produto = 2) and (venda.Itens.Count = 0) then
      begin
        writeln('A Venda precisa ter pelo menos 1 item!');
      end;

    until ((venda.Itens.Count > 0) and (mais_produto = 2));
  end;

  procedure TMain.AlterarCliente;
  var
    cliente: TCliente;
    cliente_pesquisa: TCliente;
    padrao_data: TDateTime;
    rg: string;
    nome: string;
    data_nascimento: string;
    endereco: string;
    flag: integer;
  begin
    writeln('Digite o RG do Cliente que você deseja realizar a alteração: ');
    readln(rg);

    // Verifica se o RG ja esta cadastrado
    cliente := PesquisaCliente(rg);

    if cliente = nil then
    begin
      Exit;
    end;

    // Coleta valores antigos dos atributos
    nome := cliente.Nome;
    rg := cliente.RG;
    data_nascimento := DateTimeToStr(cliente.DataNascimento);
    endereco := cliente.Endereco;

    // Menu de alteracao de cliente
    repeat
      writeln('Deseja alterar o RG do Cliente? 1- Sim 2- Não');
      readln(flag);

      if flag = 1 then
      begin
        // Garante RG nao nulo
        repeat
          writeln('Digite o novo RG do Cliente: ');
          readln(rg);

          if rg = '' then
          begin
            writeln('O RG não pode ser vazio!');
          end;
        until rg <> '';

        cliente_pesquisa := PesquisaCliente(rg);

        // Verifica se RG ja existe
        if cliente_pesquisa <> nil then
        begin
          writeln('Esse RG já está cadastrado no sistema!');
          Exit;
        end;
      end;
    until (flag = 1) or (flag = 2);

    repeat
      writeln('Deseja alterar o Nome do Cliente? 1- Sim 2- Não');
      readln(flag);

      if flag = 1 then
      begin
        writeln('Digite o novo Nome do Cliente: ');
        readln(nome);
      end;
    until (flag = 1) or (flag = 2);

    repeat
      writeln('Deseja alterar o Endereço do Cliente? 1- Sim 2- Não');
      readln(flag);

      if flag = 1 then
      begin
        writeln('Digite o novo Endereço do Cliente: ');
        readln(endereco);
      end;
    until (flag = 1) or (flag = 2);

    repeat
      writeln('Deseja alterar a Data de Nascimento do Cliente? 1- Sim 2- Não');
      readln(flag);

      if flag = 1 then
      begin
        writeln('Digite a nova Data de Nascimento do Cliente: ');
        readln(data_nascimento);
      end;
    until (flag = 1) or (flag = 2);

    // Valores sao atualizados de acordo com os desejos do usuario
    cliente.Nome := nome;
    cliente.RG := rg;
    cliente.Endereco := endereco;

    if TryStrToDateTime(data_nascimento, padrao_data) then
    begin
      cliente.DataNascimento := StrToDateTime(data_nascimento);
    end;

    writeln('A alteração foi realizada com Sucesso!');
  end;

  procedure TMain.AlterarProduto;
  var
    produto: TProduto;
    produto_pesquisa: TProduto;
    padrao_int: integer;
    padrao_double: double;
    codigo: string;
    nome: string;
    valor: string;
    flag: integer;
  begin
    // Menu de alteração de produto
    repeat
      writeln('Digite o codigo do Produto que você deseja realizar a alteração: ');
      readln(codigo);

      if not TryStrToInt(codigo, padrao_int) then
      begin
        writeln('Esse Código não é um número inteiro!');
      end;
    until TryStrToInt(codigo, padrao_int);

    produto := PesquisaProduto(StrToInt(codigo));

    if produto = nil then
    begin
      Exit;
    end;

    // Coleta valores antigos dos atributos
    codigo := IntToStr(produto.Codigo);
    nome := produto.Nome;
    valor := FloatToStr(produto.Valor);

    repeat
      writeln('Deseja alterar o Código do Produto? 1- Sim 2- Não');
      readln(flag);

      if flag = 1 then
      begin
        // Garante um odigo inteiro
        repeat
          writeln('Digite o novo Código do Produto: ');
          readln(codigo);

          if not TryStrToInt(codigo, padrao_int) then
          begin
            writeln('Esse Código não é um número inteiro!');
          end;
        until TryStrToInt(codigo, padrao_int);

        // Impede insercao de um codigo ja cadastrado no sistema
        produto_pesquisa := PesquisaProduto(StrToInt(codigo));

        if produto_pesquisa <> nil then
        begin
          writeln('Esse Código já está cadastrado no sistema!');
          Exit;
        end;
      end;
    until (flag = 1) or (flag = 2);

    repeat
      writeln('Deseja alterar o Nome do Produto? 1- Sim 2- Não');
      readln(flag);

      if flag = 1 then
      begin
        writeln('Digite o novo Nome do Produto: ');
        readln(nome);
      end;
    until (flag = 1) or (flag = 2);

    repeat
      writeln('Deseja alterar o Valor do Produto? 1- Sim 2- Não');
      readln(flag);

      // Garante um preco float
      if flag = 1 then
      begin
        repeat
          writeln('Digite o novo valor do Produto: (Use , ao invés de .)');
          readln(valor);

          if not TryStrToFloat(valor, padrao_double) then
          begin
            writeln('Esse valor não é um número de ponto flutuante!');
          end;
        until TryStrToFloat(valor, padrao_double);
      end;
    until (flag = 1) or (flag = 2);

    // Cadastra valores atualizados
    produto.Codigo := StrToInt(codigo);
    produto.Nome := nome;
    produto.Valor := StrToFloat(valor);
    writeln('A alteração foi realizada com Sucesso!');
  end;

  procedure TMain.RemoverCliente;
  var
    cliente: Tcliente;
    rg: string;
  begin
    writeln('Digite o RG do Cliente que você deseja excluir: ');
    readln(rg);

    // Verifica se o cliente a ser excluido existe
    cliente := PesquisaCliente(rg);

    if cliente = nil then
    begin
      Exit();
    end;

    FClientes.Remove(cliente);
    writeln('A remoção foi realizada com sucesso!');
  end;

  procedure TMain.RemoverProduto;
  var
    produto: TProduto;
    codigo: integer;
  begin
    writeln('Digite o codigo do Produto que você deseja excluir: ');
    readln(codigo);

    produto := PesquisaProduto(codigo);

    if produto = nil then
    begin
      Exit;
    end;

    FProdutos.Remove(produto);
    writeln('A remoção foi realizada com sucesso!');
  end;

  procedure TMain.RemoverVenda;
  var
    venda: TVenda;
    numero: integer;
  begin
    writeln('Digite o número da Venda que você deseja excluir: ');
    readln(numero);

    venda := PesquisaVenda(numero);

    if venda = nil then
    begin
      Exit;
    end;

    RemoverItemVenda(venda);
    FVendas.Remove(venda);
    writeln('A remoção foi realizada com sucesso!');
  end;

  // Remove todos os ItemVendas
  procedure TMain.RemoverItemVenda(venda: TVenda);
  var
    item_venda: TItemVenda;
  begin
    for item_venda in venda.Itens do
    begin
      venda.Itens.Remove(item_venda);
    end;
  end;

  // Lista todos os clientes cadastrados
  procedure TMain.VisualizarClientes;
  var
    cliente: TCliente;
  begin
    // Verifica se ha clientes cadastrados
    if FClientes.Count <> 0 then
    begin
      for cliente in FClientes do
      begin
        writeln(cliente.Visualizar);
      end;
    end
    else
    begin
      writeln('Não há Clientes cadastrados no Sistema!');
    end;


  end;

  // Lista todos os produtos cadastrados
  procedure TMain.VisualizarProdutos;
  var
    produto: TProduto;
  begin
    if FProdutos.Count <> 0 then
    begin
      for produto in FProdutos do
      begin
        writeln(produto.Visualizar);
      end;
    end
    else
    begin
      writeln('Não há Produtos cadastrados no sistema!');
    end;

  end;

  // Lista todas as vendas cadastrados
  procedure TMain.VisualizarVendas;
  var
    venda: TVenda;
  begin
    if FVendas.Count <> 0 then
    begin
      for venda in FVendas do
      begin
        writeln(venda.Visualizar);
      end;
    end
    else
    begin
      writeln('Não há Vendas cadastradas no sistema!');
    end;

  end;

  // Busca cliente de acordo com seu RG
  function TMain.PesquisaCliente(rg: string): TCliente;
  var
    cliente: TCliente;
  begin
    for cliente in FClientes do
    begin
      if cliente.RG = rg then
      begin
        Result := cliente;
        Exit();
      end;
    end;

    writeln('Não foi encontrado no sistema um Cliente com esse RG!');
    Result := nil;
  end;

  // Busca produto de acordo com seu codigo
  function TMain.PesquisaProduto(codigo: integer): TProduto;
   var
    produto: TProduto;
  begin
    for produto in FProdutos do
    begin
      if produto.Codigo = codigo then
      begin
        Result := produto;
        Exit;
      end;
    end;

    writeln('Não foi encontrado no sistema um Produto com esse código!');
    Result := nil;
  end;

  // Busca venda de acordo com seu numero
  function TMain.PesquisaVenda(numero: Integer): TVenda;
  var
    venda: TVenda;
  begin
    for venda in FVendas do
    begin
      if venda.Numero = numero then
      begin
        Result := venda;
        Exit;
      end;
    end;

    writeln('Não foi encontrado no sistema uma Venda com esse número!');
    Result := nil;
  end;

end.
