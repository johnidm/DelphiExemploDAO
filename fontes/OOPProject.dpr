program OOPProject;

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
  Model.Cliente in 'persistencia\Model.Cliente.pas',
  Helper.Conexao.ConectarDB in 'util\helpers\Helper.Conexao.ConectarDB.pas',
  Helper.Conexao.Instancia.SQLDataSet in 'util\helpers\Helper.Conexao.Instancia.SQLDataSet.pas',
  Helper.Conexao.SGBD.Firebird.Singleton in 'util\helpers\Helper.Conexao.SGBD.Firebird.Singleton.pas',
  Util.Constantes in 'util\Util.Constantes.pas',
  Util.Funcoes in 'util\Util.Funcoes.pas',
  Iterator.SQL.Select in 'framework\SQL\Iterator.SQL.Select.pas',
  RegisterVariable.ConnDB in 'framework\SQL\RegisterVariable.ConnDB.pas',
  Util.RS in 'util\Util.RS.pas',
  Builder.SQL.DML in 'framework\SQL\Builder.SQL.DML.pas',
  Parse.SQL.Params in 'framework\SQL\Parse.SQL.Params.pas',
  Util.Types in 'util\Util.Types.pas',
  Parse.SQL in 'framework\SQL\Parse.SQL.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:= True;


  Application.Initialize;
  Application.MainFormOnTaskbar := True;


  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
