{
  Data Acesses Object
  Classe base para declaração de métodos usados nas classes herdadas do pattern DAO
}

unit DAO.Base;

interface

uses
  SysUtils;

type
  EDAO = class( Exception );

  IDAO = interface
    ['{217E3C5E-61C0-4C7A-9380-B41DD939D978}']
  end;

  TDAOBase = class( TInterfacedObject, IDAO )
  public
  end;


implementation



end.
