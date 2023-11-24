unit ClassMenu;

interface

uses
  SysUtils;

type
  Menu = class

  private

  public
    class function ShowMainMenu(): integer;
    class function ShowMenu(opt: integer): integer;
  end;

implementation

  class function Menu.ShowMainMenu(): integer;
  var
    opt: integer;
  begin
    repeat
      writeln('Digite a op��o desejada:');
      writeln('1. Adicionar');
      writeln('2. Alterar');
      writeln('3. Remover');
      writeln('4. Visualizar');
      writeln('0. Sair');
      readln(opt);
    until (opt = 0) or (opt = 1) or (opt = 2) or (opt = 3) or (opt = 4);
    Result := opt;
  end;

  class function Menu.ShowMenu(opt: integer): integer;
  var
    opt2: integer;
  begin

    if opt = 1 then
    begin
      repeat
        writeln('Digite a op��o desejada:');
        writeln('1. Adicionar Cliente');
        writeln('2. Adicionar Produto');
        writeln('3. Adicionar Venda');
        writeln('0. Sair');
        readln(opt2);
      until (opt2 = 0) or (opt2 = 1) or (opt2 = 2) or (opt2 = 3);
      Result := opt2;
      Exit;
    end;

    if opt = 2 then
    begin
      repeat
        writeln('Digite a op��o desejada:');
        writeln('1. Alterar Cliente');
        writeln('2. Alterar Produto');
        writeln('0. Sair');
        readln(opt2);
      until (opt2 = 0) or (opt2 = 1) or (opt2 = 2);
      Result := opt2;
      Exit;
    end; 

    if opt = 3 then
    begin
      repeat
        writeln('Digite a op��o desejada:');
        writeln('1. Remover Cliente');
        writeln('2. Remover Produto');
        writeln('3. Remover Venda');
        writeln('0. Sair');
        readln(opt2);
      until (opt2 = 0) or (opt2 = 1) or (opt2 = 2) or (opt2 = 3);
      Result := opt2;
      Exit;
    end;

    if opt = 4 then
    begin
      repeat
        writeln('Digite a op��o desejada:');
        writeln('1. Visualizar Clientes');
        writeln('2. Visualizar Produtos');
        writeln('3. Visualizar Vendas');
        writeln('0. Sair');
        readln(opt2); 
      until (opt2 = 0) or (opt2 = 1) or (opt2 = 2) or (opt2 = 3);
      Result := opt2;
      Exit;
    end;
    
  end;

end.
