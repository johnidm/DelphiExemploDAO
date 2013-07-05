{
  Classe utilit�ria
  Declara o objeto que representa a conex�o com o DB Firebird 2.5
}

unit Util.Conexao.SGBD.Firebird.Singleton;

interface

uses
  SqlExpr, SysUtils, Util.Conexao.ConectarDB;

type
  TUtilConexaoSGBDFirebirdSingleton = class sealed
  private // n�o pode ser strict private
    class var
      _Conexao: TSQLConnection;
  public
    class function Instance(): TSQLConnection;
  end;

implementation



class function TUtilConexaoSGBDFirebirdSingleton.Instance: TSQLConnection;
begin
  if (not ( Assigned ( _Conexao ) ) ) then
  begin
    _Conexao:= TSQLConnection.Create( nil );

    TUtilConexaoConectarDB.Conectar( _Conexao );
  end;

  Result:= _Conexao;
end;


initialization


finalization
  // Destroi o objeto Singleton da conex�o
  if ( Assigned ( TUtilConexaoSGBDFirebirdSingleton._Conexao )  ) then
    FreeAndNil( TUtilConexaoSGBDFirebirdSingleton._Conexao )

end.
