unit ClassPessoa;

interface

type

  TPessoa = class abstract

  private
    var
    FNome : String;
    FEndereco : String;

  public
    property Nome : string read FNome write FNome; //Método de acesso para as outras classes
    property Endereco : string read FEndereco write FEndereco;
    function Visualizar: string; virtual; abstract;

  end;
implementation

end.
