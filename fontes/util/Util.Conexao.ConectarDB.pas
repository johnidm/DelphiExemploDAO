{
  Classe utilit�ria
  Declara m�todos para conex�o com o DB
}

unit Util.Conexao.ConectarDB;

interface

uses
  SqlExpr, Util.Constantes;
type
  TUtilConexaoConectarDB = class
  strict private
    const
      DB_SENHA = 'masterkey';
      DB_USER = 'SYSDBA';
  public
    class procedure Conectar( ASQLConnection: TSQLConnection );
  end;

implementation

{ TUtilConexaoConectarDB }

class procedure TUtilConexaoConectarDB.Conectar(ASQLConnection: TSQLConnection);
begin
  if (ASQLConnection.Connected) then
    ASQLConnection.Close;

  ASQLConnection.ConnectionName := 'FBConnection';
  ASQLConnection.DriverName := 'Firebird';
  ASQLConnection.LoadParamsOnConnect := False;
  ASQLConnection.LoginPrompt:= False;

  with ASQLConnection.Params do
  begin
    Values['Database'] := DIR_APLICACAO + 'dados.fdb';

    Values['Password'] := DB_SENHA;
    Values['User_Name'] := DB_USER;
  end;

  ASQLConnection.Open;
end;


end.
