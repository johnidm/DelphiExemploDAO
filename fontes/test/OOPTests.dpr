program OOPTests;

uses
  DUnitTestRunner,

  TestParse.SQL in 'TestParse.SQL.pas',
  Parse.SQL in '..\framework\Parse.SQL.pas',
  Util.Types in '..\util\Util.Types.pas',
  Util.Constantes in '..\util\Util.Constantes.pas',
  TestBuilder.SQL in 'TestBuilder.SQL.pas',
  Builder.SQL.DML in '..\framework\Builder.SQL.DML.pas',
  RegisterVariable.ConnDB in '..\framework\RegisterVariable.ConnDB.pas',
  Util.RS in '..\util\Util.RS.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

