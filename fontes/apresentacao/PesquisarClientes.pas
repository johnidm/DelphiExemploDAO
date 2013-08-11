unit PesquisarClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DAO.Cliente, DB, StdCtrls, Buttons, DBClient, Grids, DBGrids,
  ExtCtrls, Model.Cliente;

type
  TFrmPesquisarClientes = class(TForm)
    Panel1: TPanel;
    GrdClientes: TDBGrid;
    CdsClientes: TClientDataSet;
    DsClientes: TDataSource;
    BtnOK: TBitBtn;
    BtnFechar: TBitBtn;
    CdsClientesID: TIntegerField;
    CdsClientesNome: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure GrdClientesDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    ID: Integer;
    class function PesquisarCliente(): Integer;
  end;

implementation

{$R *.dfm}

procedure TFrmPesquisarClientes.BtnOKClick(Sender: TObject);
begin
  ID := CdsClientes.FieldByName('ID').AsInteger;

  ModalResult := mrOk;
end;

procedure TFrmPesquisarClientes.BtnFecharClick(Sender: TObject);
begin
  ModalResult := mrNone;
  Close();
end;

class function TFrmPesquisarClientes.PesquisarCliente: Integer;
var
  FrmPesquisarClientes: TFrmPesquisarClientes;
begin
  FrmPesquisarClientes := TFrmPesquisarClientes.Create(nil);
  try
    FrmPesquisarClientes.ShowModal();
    if (FrmPesquisarClientes.ModalResult = mrOk) then
    begin
      Result := FrmPesquisarClientes.ID;

      // Isso é uma gambiara, só fiz para demostrar o efeito da pesquisa
      // deve ser melhorado
      keybd_event(13, 0, 0, 0);

    end
    else
      Result := 0;

  finally
    FreeAndNil(FrmPesquisarClientes)
  end;

end;

procedure TFrmPesquisarClientes.GrdClientesDblClick(Sender: TObject);
begin
  BtnOK.Click();
end;

procedure TFrmPesquisarClientes.FormCreate(Sender: TObject);
var
  DAOCliente: TDAOCliente;
  Clientes: TModelListaCliente;
  Cliente: TModelCliente;
begin
  // Popula o ClientDataSet com a lista de clientes
  DAOCliente := TDAOCliente.Create();
  try
    try
      Clientes := DAOCliente.ListarTodos();

      CdsClientes.CreateDataSet();

      for Cliente in Clientes do
      begin
        with CdsClientes do
        begin
          Insert();

          FieldByName('ID').AsInteger := Cliente.ID;
          FieldByName('Nome').AsString := Cliente.Nome;

          Post();
        end;
      end

    finally
      FreeAndNil(Clientes)
    end;

  finally
    FreeAndNil(DAOCliente)

  end;

  // Ordenação
  CdsClientes.IndexFieldNames := 'Nome';
  CdsClientes.First();
end;

procedure TFrmPesquisarClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if ( Key = 13 )  then
   if ( ActiveControl = GrdClientes ) then
     BtnOK.Click
end;



end.
