{
  Data Acesses Object
  Classe base para declara��o de m�todos usados nas classes herdadas
}

unit DAO.Base;

interface

uses
  SysUtils,
  SqlExpr,
  Util.Conexao.Instancia.SQLDataSet,
  Util.Conexao.SGBD.Firebird.Singleton;

type
  EDAOErro = class( Exception );

  IDAO = interface
    ['{217E3C5E-61C0-4C7A-9380-B41DD939D978}']
  end;

  TDAOBase = class( TInterfacedObject, IDAO )
  public
    procedure ExecutarComandoSQL( const AComandoSQL: string );
  end;

resourcestring
  RSComandoSQLNaoDefinido = 'Comando SQL n�o definido [TAOBase.ExecutarComandoSQL]';

implementation

{ TAOBasen }


procedure TDAOBase.ExecutarComandoSQL(const AComandoSQL: string);
begin
  if ( AComandoSQL = EmptyStr ) then
    raise EDAOErro.Create( RSComandoSQLNaoDefinido);

  TConnFirebird.Instancia.SQLConnection.ExecuteDirect( AComandoSQL );
end;


end.
