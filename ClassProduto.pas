unit ClassProduto;

interface

uses
SysUtils;

type
  TProduto = class

  private
    FCodigo: integer;
    FNome: string;
    FValor: double;

  public

  // getters e setters
  property Codigo: integer read FCodigo write FCodigo;
  property Nome: string read FNome write FNome;
  property Valor: double read FValor write FValor;
  function Visualizar: string;

  end;
implementation

  function TProduto.Visualizar(): string;
  begin
    Result := Format('Produto: %s, C�digo: %d, Valor: R$%f', [FNome, FCodigo, FValor]);
  end;
end.
