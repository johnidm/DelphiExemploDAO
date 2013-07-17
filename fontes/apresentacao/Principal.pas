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
    Button3: TButton;
    SQLConnection1: TSQLConnection;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses Util.Conexao.SGBD.Firebird.Singleton, RegisterVariable.ConnDB ,
  Util.Conexao.Instancia.SQLDataSet, Iterator.Select;

{$R *.dfm}

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
  TFrmCadastroDeClientes.CadastrarCliente();
end;


procedure TFrmPrincipal.Button2Click(Sender: TObject);
begin
  TFrmListView.AbrirFormulario( );
end;

procedure TFrmPrincipal.Button3Click(Sender: TObject);
begin


  with TIteratorSelect.Iterator( 'select * from tabela ' ) do
  begin
    if ( IsEmpty ) then
    begin
      ShowMessage('Nenhum registro encontrado!!!');
      Exit;
    end;

    while ( NextEof() ) do
    begin
      ShowMessage( Field('campo1').AsString )
    end;
  end;

end;

procedure TFrmPrincipal.Button4Click(Sender: TObject);
begin
  SQLConnection1.Open;


end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  TRegisterVariable.Register( SQLConnection1 );

 

end;

initialization

finalization

end.
