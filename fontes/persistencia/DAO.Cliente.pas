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

uses Iterator.Select;

procedure TDAOCliente.Excluir(const AVOCliente: TVOCliente);
begin
  ExecutarComandoSQL('delete from clientes ' +
    '  where ' +
    '   id_cliente = ' + IntToStr(AVOCliente.ID)
  );
end;



function TDAOCliente.ListarTodos: TVOClienteLista;
var
  Cliente: TVOCliente;

  SQL: string;
begin
  Result := TVOClienteLista.Create();

  SQL:=
    'SELECT id_cliente, nm_cliente ' +
    '  FROM clientes ';

  with ( IIteratorSelect( TIteratorSelect.Iterator( SQL ) ) )  do
  begin

    while ( NextEof() ) do
    begin
      Cliente := TVOCliente.Create();

      // Popula a lista de objetos VO
      Cliente.ID := Field('id_cliente').AsInteger;
      Cliente.Nome := Field('nm_cliente').AsString;

      Result.Add(Cliente);
    end;

  end;

end;



function TDAOCliente.Pesquisar(const AID: Integer): TVOCliente;
var
  SQL: string;
begin
  Result:= TVOCliente.Create();

  SQL:=
    ' SELECT ' +
    '   id_cliente, ' +
    '   nm_cliente  ' +
    '  FROM clientes ' +
    ' WHERE ' +
    '   id_cliente = ' + IntToStr( AID );

  with ( IIteratorSelect( TIteratorSelect.Iterator( SQL ) ) ) do
  begin
    Result.ID:= Field('id_cliente').AsInteger;
    Result.Nome:= Field('nm_cliente').AsString;
  end;

end;



procedure TDAOCliente.Salvar(const AVOCliente: TVOCliente);
begin
  if ( IIteratorSelect( TIteratorSelect.Iterator( 'select 1 from CLIENTES where id_cliente =  ' + IntToStr( AVOCliente.ID ) ) ) ).IsEmpty then
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
    )
  else
    ExecutarComandoSQL(
      'UPDATE CLIENTES SET ' +
      '      nm_cliente = ' + QuotedStr(AVOCliente.Nome) +
      '  WHERE              ' +
      '      id_cliente = ' + IntToStr(AVOCliente.ID)
    );
end;


end.
