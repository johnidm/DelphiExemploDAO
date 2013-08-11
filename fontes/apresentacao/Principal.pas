unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WideStrings, DBXFirebird, DB, SqlExpr,
  CadastroDeClientes, ListView;

type
  TFrmPrincipal = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses Helper.Conexao.SGBD.Firebird.Singleton, RegisterVariable.ConnDB ,
  Helper.Conexao.Instancia.SQLDataSet, Iterator.SQL.Select, Helper.Conexao.ConectarDB;

{$R *.dfm}

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
  TFrmCadastroDeClientes.CadastrarCliente();
end;


procedure TFrmPrincipal.Button2Click(Sender: TObject);
begin
  TFrmListView.AbrirFormulario( );
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
  SQL: string;

begin
  // Define o objeto que ira representar a conexão com o DB
  TRegisterVariable.Register( {SQLConnection1} TConnFirebird.Instancia.SQLConnection );

  // Conecta com o DB
  TConnConectDB.Connect( TConnFirebird.Instancia.SQLConnection );

  SQL:= ' select CAMPO1 from TABELA where CODIGO = 1';

  (*
  Campo:= IIteratorSQLSelect( TIteratorSQLSelect.Iterator( SQL ) ).Field('CAMPO1').AsString;
  ShowMessage( Campo );

  SQL:= ' select CAMPO1 from TABELA ';
  with ( IIteratorSelect( TIteratorSelect.Iterator( SQL ) ) ) do
  begin
    while ( NextEof() ) do
    begin
      ShowMessage(
        Field( 'CAMPO1' ).AsString );
    end;
  end;
  *)

end;


{TODO transformas os DAO em Interfaces}


end.
