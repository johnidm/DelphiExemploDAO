{
  Data Acesses Object
  DAO da entidade cliente
}

unit DAO.Cliente;

interface

uses
  SqlExpr,
  SysUtils,
  Util.Conexao.Instancia.SQLDataSet,
  VO.Cliente,
  DAO.Base;

type
  TDAOCliente = class(TDAOBase)
  public
    procedure Salvar(const AVOCliente: TVOCliente);
    procedure Excluir(const AVOCliente: TVOCliente);
    function Pesquisar(const AID: Integer): TVOCliente;
    function ListarTodos(): TVOClienteLista;
  end;

implementation


{ TDAOCliente }

procedure TDAOCliente.Excluir(const AVOCliente: TVOCliente);
begin
  ExecutarComandoSQL('delete from clientes ' +
    '  where ' +
    '   id_cliente = ' + IntToStr(AVOCliente.ID)
  );
end;



function TDAOCliente.ListarTodos: TVOClienteLista;
var
  SQLDataSet: TSQLDataSet;
  Cliente: TVOCliente;
begin
  Result := TVOClienteLista.Create();

  SQLDataSet := TUtilConexaoInstanciaSQLDataSet.Instancia();
  try
    SQLDataSet.CommandText := 'SELECT id_cliente, nm_cliente FROM clientes ';
    SQLDataSet.Open();

    SQLDataSet.First();
    while (not(SQLDataSet.Eof)) do
    begin
      Cliente := TVOCliente.Create();

      // Popula a lista de objetos VO
      Cliente.ID := SQLDataSet.FieldByName('id_cliente').AsInteger;
      Cliente.Nome := SQLDataSet.FieldByName('nm_cliente').AsString;

      Result.Add(Cliente);

      SQLDataSet.Next();

    end;

  finally
    FreeAndNil(SQLDataSet);
  end;
end;



function TDAOCliente.Pesquisar(const AID: Integer): TVOCliente;
var
  SQLDataSet: TSQLDataSet;
begin
  Result:= TVOCliente.Create();

  SQLDataSet:= TUtilConexaoInstanciaSQLDataSet.Instancia();
  try
    SQLDataSet.CommandText:=
      ' SELECT ' +
      '   id_cliente, ' +
      '   nm_cliente  ' +
      '  FROM clientes ' +
      ' WHERE ' +
      '   id_cliente = ' + IntToStr( AID );

    SQLDataSet.Open();

    if (not( SQLDataSet.IsEmpty )) then
    begin
      Result.ID:= SQLDataSet.FieldByName('id_cliente').AsInteger;
      Result.Nome:= SQLDataSet.FieldByName('nm_cliente').AsString;
    end else
      Result.ID:= 0;

  finally
    FreeAndNil( SQLDataSet );

  end;
end;



procedure TDAOCliente.Salvar(const AVOCliente: TVOCliente);
begin
  if (AVOCliente.ID > 0) then
    ExecutarComandoSQL(
      'UPDATE CLIENTES SET ' +
      '      nm_cliente = ' + QuotedStr(AVOCliente.Nome) +
      '  WHERE              ' +
      '      id_cliente = ' + IntToStr(AVOCliente.ID)
    )
  else
    ExecutarComandoSQL(
      ' INSERT INTO CLIENTES( ' +
      '     id_cliente,     ' +
      '     nm_cliente,     ' +
      '     dt_cadastro     ' +
      ') VALUES (           ' +
      '     gen_id( ID_CLIENTE_CLIENTES_GN, 1 ), ' +
            QuotedStr (AVOCliente.Nome) + ', ' +
            QuotedStr ('today') +

      ' ) '
    );
end;



end.
