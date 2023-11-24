unit ClassItemVenda;

interface

uses
  SysUtils, ClassProduto, ClassTotalizavel;

type
  TItemVenda = class(TTotalizavel)

  private
    FProduto: TProduto;
    FValor: double;
    FQuantidade: integer;

  public
    constructor Create(AProduto: TProduto; AQuantidade: integer);
    property Produto: TProduto read FProduto write FProduto;
    property Valor: double read FValor write FValor;
    property Quantidade: integer read FQuantidade write FQuantidade;
    function Total: double; override;
    function Visualizar: string;

  end;
implementation

  constructor TItemVenda.Create(AProduto: TProduto; AQuantidade: Integer);
  begin
    FProduto := AProduto;
    FQuantidade := AQuantidade;
    FValor:= AProduto.Valor;
  end;

  function TItemVenda.Total(): Double;
  begin
    Result := FValor * FQuantidade;
  end;

  function TItemVenda.Visualizar(): string;
  begin
    Result := Format('Produto: %s, Valor do Produto: R$%f , Quantidade: %d', [FProduto.Nome, FValor, FQuantidade]);
  end;
end.
