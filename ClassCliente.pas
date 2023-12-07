unit ClassCliente;

interface

uses
  SysUtils, ClassPessoa;

type
  // cliente extends pessoa
  TCliente = class(TPessoa)

  private
    FRG: string;
    FDataNascimento: TDateTime;

  public
    // read = getter e write = setter
    property RG: string read FRG write FRG;
    property DataNascimento: TDateTime read FDataNascimento write FDataNascimento;
    function Visualizar: string; override;

  end;
implementation

  function TCliente.Visualizar: string;
  begin
    Result := Format('Cliente: %s, RG: %s, Data de Nascimento: %s, Endereço: %s', [Nome, FRG, DateTimeToStr(FDataNascimento), Endereco]);
    // Result é uma variável especial usada para armazenar o valor de retorno da função.
  end;
end.
