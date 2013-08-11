{
  Data Acesses Object
  DAO da entidade cliente
}

unit DAO.Cliente;

interface

uses
  SqlExpr,
  SysUtils,
  Model.Cliente,
  DAO.Base,
  Iterator.SQL.Select, Util.Funcoes, Util.RS, Builder.SQL.DML;

type
  TDAOCliente = class(TDAOBase)
  public
    procedure Salvar(const AModelCliente: TModelCliente);
    procedure Excluir(const AModelCliente: TModelCliente);
    function Pesquisar(const AID: Integer): TModelCliente;
    function ListarTodos(): TModelListaCliente;
  end;

implementation


{ TDAOCliente }



procedure TDAOCliente.Excluir(const AModelCliente: TModelCliente);
begin
  with TBuilderSQLDMLDelete.Create do
  begin
    try
      DefineTable( 'clientes' );
      DefineWhere( 'id_cliente', AModelCliente.ID );

      Execute();
    finally
      Free;
    end;
  end;
end;



function TDAOCliente.ListarTodos: TModelListaCliente;
var
  Cliente: TModelCliente;

  SQL: string;
begin
  Result := TModelListaCliente.Create();

  SQL:=
    'SELECT id_cliente, nm_cliente ' +
    '  FROM clientes ';

  with ( IIteratorSQLSelect( TIteratorSQLSelect.Iterator( SQL ) ) )  do
  begin

    while ( NextEof() ) do
    begin
      Cliente := TModelCliente.Create();

      // Popula a lista de objetos VO
      Cliente.ID := Field('id_cliente').AsInteger;
      Cliente.Nome := Field('nm_cliente').AsString;

      Result.Add(Cliente);
    end;

  end;

end;



function TDAOCliente.Pesquisar(const AID: Integer): TModelCliente;
var
  SQL: string;
begin
  Result:= TModelCliente.Create();

  SQL:=
    ' SELECT ' +
    '   id_cliente, ' +
    '   nm_cliente  ' +
    '  FROM clientes ' +
    ' WHERE ' +
    '   id_cliente = ' + IntToStr( AID );

  with ( IIteratorSQLSelect( TIteratorSQLSelect.Iterator( SQL ) ) ) do
  begin
    Result.ID:= Field('id_cliente').AsInteger;
    Result.Nome:= Field('nm_cliente').AsString;
  end;

end;



procedure TDAOCliente.Salvar(const AModelCliente: TModelCliente);
begin
  if ( IIteratorSQLSelect( TIteratorSQLSelect.Iterator( 'select 1 from CLIENTES where id_cliente =  ' + IntToStr( AModelCliente.ID ) ) ) ).IsEmpty  then
  begin
    with TBuilderSQLDMLInsert.Create do
    begin
      try
        DefineTable( 'clientes' );
        DefineField( 'id_cliente', AModelCliente.ID );
        DefineField( 'nm_cliente', AModelCliente.Nome );

        Execute();
      finally
        Free;
      end;
    end;
  end else
  begin
    with TBuilderSQLDMLUpdate.Create do
    begin
      try
        DefineTable( 'clientes' );
        DefineField( 'id_cliente', AModelCliente.ID );
        DefineField( 'nm_cliente', AModelCliente.Nome );

        Execute();
      finally
        Free;
      end;
    end;
  end;
end;


end.
