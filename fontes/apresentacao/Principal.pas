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
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses Util.Conexao.SGBD.Firebird.Singleton;

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
  TConnFirebird.Instancia;
end;

end.
