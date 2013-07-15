{
  Classe utilitária
  Declara o objeto que representa a conexão com o DB Firebird 2.5
}

unit Util.Conexao.SGBD.Firebird.Singleton;

interface

uses
  SqlExpr, SysUtils, Util.Conexao.ConectarDB;

type
  TConnFirebird = class sealed
  private
    class var FInstancia: TConnFirebird;

  strict private
    FSQLConnection: TSQLConnection;

    class function GetInstancia: TConnFirebird; static;

  public
    constructor Create();
    destructor Destroy(); override;

    property SQLConnection: TSQLConnection read FSQLConnection;

    class property Instancia: TConnFirebird read GetInstancia;
  end;

implementation



{ TConexaoFirebird }

constructor TConnFirebird.Create();
begin
  FSQLConnection:= TSQLConnection.Create( nil );

end;



destructor TConnFirebird.Destroy;
begin
  if ( Assigned( FSQLConnection ) ) then
  begin
    if ( SQLConnection.Connected ) then
      SQLConnection.Close();

    FreeAndNil( FSQLConnection );
  end;

  inherited;
end;



class function TConnFirebird.GetInstancia: TConnFirebird;
begin
  if ( not ( Assigned ( FInstancia ) ) ) then
    FInstancia:= TConnFirebird.Create();

  Result:= FInstancia;
end;



initialization


finalization
  if  ( Assigned( TConnFirebird.FInstancia ) ) then
    FreeAndNil( TConnFirebird.FInstancia );


end.
