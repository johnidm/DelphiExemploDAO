{
  Value Object
  VO da entidade cliente
}

unit VO.Cliente;

interface

uses
  Generics.Collections;

type
  TVOCliente = class
  private
    FID: Integer;
    FNome: string;
  public
    property ID:  Integer read FID write FID;
    property Nome: string read FNome write FNome;
  end;

  TVOClienteLista = class(TObjectList< TVOCliente >)
  end;

implementation

end.
