unit CadastroDeClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, VO.Cliente, DAO.Cliente,
  PesquisarClientes;

type
  TFrmCadastroDeClientes = class(TForm)
    EdtID: TLabeledEdit;
    EdtNome: TLabeledEdit;
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnExcluir: TBitBtn;
    SpeedButton1: TSpeedButton;
    BtnFechar: TBitBtn;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    procedure LimparFormulario();
  public
    { Public declarations }

    class procedure CadastrarCliente( ); overload;
    class procedure CadastrarCliente( const AID: Integer ); overload;
  end;

resourcestring
  RSClienteNaoEncontrado = 'Cliente não contrado';
  RSNomeClienteNaoInformado = 'Nome do cliente não encontrado';

implementation

{$R *.dfm}

procedure TFrmCadastroDeClientes.BtnCancelarClick(Sender: TObject);
begin
  LimparFormulario();
end;

procedure TFrmCadastroDeClientes.BtnExcluirClick(Sender: TObject);
var
  Cliente: TVOCliente;
  DAOCliente: TDAOCliente;
begin
  Cliente := TVOCliente.Create();
  try
    DAOCliente := TDAOCliente.Create();
    try
      with Cliente do
      begin
        ID := StrToIntDef(EdtID.Text, 0);
        if ( ID > 0 ) then
          DAOCliente.Excluir(Cliente);
      end;

    finally
      FreeAndNil(DAOCliente)
    end;
  finally
    FreeAndNil(Cliente)
  end;

  LimparFormulario();
end;



procedure TFrmCadastroDeClientes.BtnFecharClick(Sender: TObject);
begin
  Close();
end;

procedure TFrmCadastroDeClientes.BtnSalvarClick(Sender: TObject);
var
  Cliente: TVOCliente;
  DAOCliente: TDAOCliente;
begin
  // Somente para evitar o cadastro do nome em branco.
  // Esse validação deve estar em outro local
  if ( EdtNome.Text = EmptyStr ) then
  begin
    MessageDlg( RSNomeClienteNaoInformado, mtInformation, [MBOK], 0 );

    EdtNome.SetFocus;
    Exit;
  end;
         
  Cliente := TVOCliente.Create;
  try
    DAOCliente := TDAOCliente.Create();
    try
      with Cliente do
      begin
        ID := StrToIntdEF(EdtID.Text, 0);
        Nome := EdtNome.Text;

        DAOCliente.Salvar(Cliente);
      end;
    finally
      FreeAndNil(DAOCliente);
    end;
  finally
    FreeAndNil(Cliente);
  end;

  LimparFormulario();
end;


class procedure TFrmCadastroDeClientes.CadastrarCliente(
   const AID: Integer );
var
  FrmCadastroDeClientes: TFrmCadastroDeClientes;
begin
  FrmCadastroDeClientes := TFrmCadastroDeClientes.Create(nil);
  try
    // Pega o código do cliente e popula o Edit para
    // fazer a peaquisa
    FrmCadastroDeClientes.EdtID.Text:= IntToStr( AID );
    FrmCadastroDeClientes.ShowModal();
  finally
    FreeAndNil(FrmCadastroDeClientes);

  end;

end;



class procedure TFrmCadastroDeClientes.CadastrarCliente;
var
  FrmCadastroDeClientes: TFrmCadastroDeClientes;
begin
  FrmCadastroDeClientes := TFrmCadastroDeClientes.Create(nil);
  try
    FrmCadastroDeClientes.ShowModal();

  finally
    FreeAndNil(FrmCadastroDeClientes);

  end;
end;



procedure TFrmCadastroDeClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  DAOCliente: TDAOCliente;
  Cliente: TVOCliente;
begin
  if (Key = 13) then
  begin
    if (ActiveControl = EdtID) then
    begin
      DAOCliente := TDAOCliente.Create();
      try
        Cliente := DAOCliente.Pesquisar(StrToIntdEF(EdtID.Text, 0));
        try
          if (Cliente.ID > 0) then
          begin
            // Popula os campos da tela
            EdtNome.Text := Cliente.Nome;
          end
          else if ( EdtID.Text <> EmptyStr ) then
          begin
            MessageDlg( RSClienteNaoEncontrado, mtInformation, [mbok], 0 );
            Exit;
          end;

          SelectNext(ActiveControl, True, True);
        finally
          FreeAndNil(Cliente);
        end;

      finally
        FreeAndNil(DAOCliente);
      end;
    end
    else if ( ActiveControl = EdtNome ) then
    begin
      //
      SelectNext(ActiveControl, True, True);
    end;



  end;

end;

procedure TFrmCadastroDeClientes.FormShow(Sender: TObject);
begin
  // Simula o ENTRE para inicar a pesquisa do cliente e popular os campos da tela
  // Isso deve ser melhorado, feito somente par demontrar a funcionalidade
  if ( EdtID.Text <> EmptyStr ) then
    keybd_event( 13, 0 ,0 , 0);
end;

procedure TFrmCadastroDeClientes.LimparFormulario;
begin
  // Limpa os dados do formulário
  EdtID.Clear;
  EdtNome.Clear;
  EdtID.SetFocus;
end;

procedure TFrmCadastroDeClientes.SpeedButton1Click(Sender: TObject);
var
  ID: Integer;
begin
  ID := TFrmPesquisarClientes.PesquisarCliente();
  if (ID > 0) then
    EdtID.Text := IntToStr(ID);

  EdtID.SetFocus;
end;

end.
