unit ClassVenda;

interface

uses
  SysUtils, System.Generics.Collections, ClassTotalizavel, ClassCliente, ClassItemVenda;

type
  TVenda = class(TTotalizavel)

  private
    FNumero: integer;
    FData: TDateTime;
    FCliente: TCliente;
    FItens: TObjectList<TItemVenda>;

  public
    constructor Create(numero: Integer; data: TDateTime; cliente: TCliente);
    property Numero: integer read FNumero write FNumero;
    property Data: TDateTime read FData write FData;
    property Cliente: TCliente read FCliente write FCliente;
    property Itens: TObjectList<TItemVenda> read FItens write FItens;
    function Total: double; override;
    procedure AdicionarItem(AItem: TItemVenda);
    function Visualizar: string;

  end;

implementation

  constructor TVenda.Create(numero: Integer; data: TDateTime; cliente: TCliente);
  begin
    FNumero := numero;
    FData := data;
    FCliente := cliente;
    FItens := TObjectList<TItemVenda>.Create;
  end;

  function TVenda.Total: double;
  var
    item : TItemVenda;
    soma: double;
  begin
    soma := 0.0;
    for item in FItens do
    begin
      soma := soma + item.Total;
    end;

    Result := soma;
  end;

  procedure TVenda.AdicionarItem(AItem: TItemVenda);
  begin
    FItens.Add(AItem);
  end;

  function TVenda.Visualizar(): string;
  var
    str: String;
    item: TItemVenda;
  begin
    str := Format('N�mero da venda: %d, Data: %s , Cliente: %s, Valor: %f, Itens: ', [FNumero, DateTimeToStr(FData), FCliente.Nome, Total]);
    for item in FItens do
    begin
      str := str + sLineBreak + '   ' + item.Visualizar();
    end;

    Result := str;
  end;
end.
