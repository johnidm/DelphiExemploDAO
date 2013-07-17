program ExemploOOP;

uses
  Forms,
  CadastroDeClientes in 'apresentacao\CadastroDeClientes.pas' {FrmCadastroDeClientes},
  ListView in 'apresentacao\ListView.pas' {FrmListView},
  PesquisarClientes in 'apresentacao\PesquisarClientes.pas' {FrmPesquisarClientes},
  Principal in 'apresentacao\Principal.pas' {FrmPrincipal},
  BO.Exportar.Clientes.Leiaute in 'negocio\BO.Exportar.Clientes.Leiaute.pas',
  BO.Exportar.Clientes in 'negocio\BO.Exportar.Clientes.pas',
  DAO.Base in 'persistencia\DAO.Base.pas',
  DAO.Cliente in 'persistencia\DAO.Cliente.pas',
  VO.Cliente in 'persistencia\VO.Cliente.pas',
  Util.Conexao.ConectarDB in 'util\Util.Conexao.ConectarDB.pas',
  Util.Conexao.Instancia.SQLDataSet in 'util\Util.Conexao.Instancia.SQLDataSet.pas',
  Util.Conexao.SGBD.Firebird.Singleton in 'util\Util.Conexao.SGBD.Firebird.Singleton.pas',
  Util.Constantes in 'util\Util.Constantes.pas',
  Util.Funcoes in 'util\Util.Funcoes.pas',
  Iterator.Select in 'framework\Iterator.Select.pas',
  RegisterVariable.ConnDB in 'framework\RegisterVariable.ConnDB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  ReportMemoryLeaksOnShutdown:= True;

  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
