{
  Classe utilitária
  Declara métodos para instância de objetos que executam SQLs no DB
}

unit Helper.Conexao.Instancia.SQLDataSet;

interface

uses
  Helper.Conexao.SGBD.Firebird.Singleton,
  SqlExpr;

type
  TInstanciaSQLDataSet = class sealed
  public
    class function Instancia(): TSQLDataSet;
  end;


implementation

{ TUtilConexaoInstanciaSQLDataSet }

class function TInstanciaSQLDataSet.Instancia: TSQLDataSet;
begin
  Result:= TSQLDataSet.Create( nil );

  // Representa a conexao com os objetos
  Result.SQLConnection:= TConnFirebird.Instancia.SQLConnection;
end;

end.
