unit TestBuilder.SQL;


interface

uses
  TestFramework, System.SysUtils, Builder.SQL.DML, Util.RS, Generics.Collections,
  StrUtils, RegisterVariable.ConnDB, Util.Constantes, Vcl.Dialogs,
  Data.DB, Util.Types;

type

  {$REGION 'Teste Builder Insert'}
  TestTBuilderSQLDMLInsert = class(TTestCase)
  strict private
    FBuilderSQLDMLInsert: TBuilderSQLDMLInsert;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute3Campos;
    procedure TesteExecute1Campo();
  end;
  {$ENDREGION}


  {$REGION 'Teste Builder Update'}
  TestTBuilderSQLDMLUpdate = class(TTestCase)
  strict private
    FBuilderSQLDMLUpdate: TBuilderSQLDMLUpdate;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute1CampoSemWhere;
    procedure TestExecute3CamposSemWhere;
    procedure TestExecute1CampoCom1CampoWhere;
    procedure TestExecute1CampoCao2CampoWhere;
    procedure TestExecute3CamposCom1CampoWhere;
    procedure TestExecute3CamposCom3CamposWhere;
  end;
  {$ENDREGION}


  {$REGION ''}
  TestTBuilderSQLDMLDelete = class(TTestCase)
  strict private
    FBuilderSQLDMLDelete: TBuilderSQLDMLDelete;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecuteCom1Where;
    procedure TestExecuteCom4Where;
  end;
  {$ENDREGION}


implementation



{$REGION 'Impl Builder Insert'}
procedure TestTBuilderSQLDMLInsert.SetUp;
begin
  FBuilderSQLDMLInsert := TBuilderSQLDMLInsert.Create;
end;

procedure TestTBuilderSQLDMLInsert.TearDown;
begin
  FBuilderSQLDMLInsert.Free;
  FBuilderSQLDMLInsert := nil;
end;



procedure TestTBuilderSQLDMLInsert.TesteExecute1Campo;
var
  Retorno: string;
begin
  FBuilderSQLDMLInsert.DefineTable( 'teste' );
  FBuilderSQLDMLInsert.DefineField( 'campo01', 1 );

  Retorno:= FBuilderSQLDMLInsert.MountSQL;

  CheckEquals( 'insert into teste ( campo01 ) values ( :_f_campo01 )' , Retorno );

end;



procedure TestTBuilderSQLDMLInsert.TestExecute3Campos;
var
  Retorno, SQLEsperado: string;
begin
  FBuilderSQLDMLInsert.DefineTable( 'teste' );
  FBuilderSQLDMLInsert.DefineField( 'campo01', 1 );
  FBuilderSQLDMLInsert.DefineField( 'campo02', 1 );
  FBuilderSQLDMLInsert.DefineField( 'campo03', 1 );

  Retorno:= FBuilderSQLDMLInsert.MountSQL;


  SQLEsperado:=
    'insert into teste ( campo01, campo02, campo03 ) values ( :_f_campo01, :_f_campo02, :_f_campo03 )';

  CheckEquals( SQLEsperado, Retorno );

end;
{$ENDREGION}


{$REGION 'Impl Builder Update'}
procedure TestTBuilderSQLDMLUpdate.SetUp;
begin
  FBuilderSQLDMLUpdate := TBuilderSQLDMLUpdate.Create;
end;



procedure TestTBuilderSQLDMLUpdate.TearDown;
begin
  FBuilderSQLDMLUpdate.Free;
  FBuilderSQLDMLUpdate := nil;
end;



procedure TestTBuilderSQLDMLUpdate.TestExecute1CampoCao2CampoWhere;
var
  Retorno, SQLEsperado: string;
begin
  FBuilderSQLDMLUpdate.DefineTable( 'teste' );
  FBuilderSQLDMLUpdate.DefineField( 'campo01', 1 );
  FBuilderSQLDMLUpdate.DefineWhere( 'campo02', 1 );
  FBuilderSQLDMLUpdate.DefineWhere( 'campo03', 1 );


  Retorno:= FBuilderSQLDMLUpdate.MountSQL;

  SQLEsperado:=
    'update teste set campo01 = :_f_campo01 where campo02 = :_w_campo02 and campo03 = :_w_campo03' ;

  CheckEquals( SQLEsperado, Retorno );

end;



procedure TestTBuilderSQLDMLUpdate.TestExecute1CampoCom1CampoWhere;
var
  Retorno, SQLEsperado: string;
begin
  FBuilderSQLDMLUpdate.DefineTable( 'teste' );
  FBuilderSQLDMLUpdate.DefineField( 'campo01', 1 );
  FBuilderSQLDMLUpdate.DefineWhere( 'campo02', 1 );

  Retorno:= FBuilderSQLDMLUpdate.MountSQL;

  SQLEsperado:=
    'update teste set campo01 = :_f_campo01 where campo02 = :_w_campo02' ;

  CheckEquals( SQLEsperado, Retorno );

end;



procedure TestTBuilderSQLDMLUpdate.TestExecute1CampoSemWhere;
var
  Retorno, SQLEsperado: string;
begin
  FBuilderSQLDMLUpdate.DefineTable( 'teste' );
  FBuilderSQLDMLUpdate.DefineField( 'campo01', 1 );

  Retorno:= FBuilderSQLDMLUpdate.MountSQL;

  SQLEsperado:=
    'update teste set campo01 = :_f_campo01' ;

  CheckEquals( SQLEsperado, Retorno );

end;



procedure TestTBuilderSQLDMLUpdate.TestExecute3CamposCom1CampoWhere;
var
  Retorno, SQLEsperado: string;
begin
  FBuilderSQLDMLUpdate.DefineTable( 'teste' );
  FBuilderSQLDMLUpdate.DefineField( 'campo01', 1 );

  FBuilderSQLDMLUpdate.DefineWhere( 'campo04', 1 );
  FBuilderSQLDMLUpdate.DefineWhere( 'campo05', 1 );
  FBuilderSQLDMLUpdate.DefineWhere( 'campo06', 1 );


  Retorno:= FBuilderSQLDMLUpdate.MountSQL;

  SQLEsperado:=
    'update teste set campo01 = :_f_campo01 where campo04 = :_w_campo04 and campo05 = :_w_campo05 and campo06 = :_w_campo06';

  CheckEquals( SQLEsperado, Retorno );

end;



procedure TestTBuilderSQLDMLUpdate.TestExecute3CamposCom3CamposWhere;
var
  Retorno, SQLEsperado: string;
begin
  FBuilderSQLDMLUpdate.DefineTable( 'teste' );
  FBuilderSQLDMLUpdate.DefineField( 'campo01', 1 );
  FBuilderSQLDMLUpdate.DefineField( 'campo02', 1 );
  FBuilderSQLDMLUpdate.DefineField( 'campo03', 1 );

  FBuilderSQLDMLUpdate.DefineWhere( 'campo04', 1 );
  FBuilderSQLDMLUpdate.DefineWhere( 'campo05', 1 );
  FBuilderSQLDMLUpdate.DefineWhere( 'campo06', 1 );


  Retorno:= FBuilderSQLDMLUpdate.MountSQL;

  SQLEsperado:=
    'update teste set campo01 = :_f_campo01, campo02 = :_f_campo02, campo03 = :_f_campo03 where campo04 = :_w_campo04 and campo05 = :_w_campo05 and campo06 = :_w_campo06';

  CheckEquals( SQLEsperado, Retorno );

end;



procedure TestTBuilderSQLDMLUpdate.TestExecute3CamposSemWhere;
var
  Retorno, SQLEsperado: string;
begin
  FBuilderSQLDMLUpdate.DefineTable( 'teste' );
  FBuilderSQLDMLUpdate.DefineField( 'campo01', 1 );
  FBuilderSQLDMLUpdate.DefineField( 'campo02', 1 );
  FBuilderSQLDMLUpdate.DefineField( 'campo03', 1 );

  Retorno:= FBuilderSQLDMLUpdate.MountSQL;

  SQLEsperado:=
    'update teste set campo01 = :_f_campo01, campo02 = :_f_campo02, campo03 = :_f_campo03';

  CheckEquals( SQLEsperado, Retorno );
end;
{$ENDREGION}



{ TestTBuilderSQLDMLDelete }

procedure TestTBuilderSQLDMLDelete.SetUp;
begin
  inherited;

  FBuilderSQLDMLDelete:= TBuilderSQLDMLDelete.Create();
end;



procedure TestTBuilderSQLDMLDelete.TearDown;
begin
  inherited;

  FBuilderSQLDMLDelete.Free;
  FBuilderSQLDMLDelete:= nil;
end;



procedure TestTBuilderSQLDMLDelete.TestExecuteCom1Where;
var
  Retorno: string;
begin
  FBuilderSQLDMLDelete.DefineTable( 'teste' );
  FBuilderSQLDMLDelete.DefineWhere( 'campo01', 1 );

  Retorno:= FBuilderSQLDMLDelete.MountSQL();

  CheckEquals( 'delete from teste where campo01 = :_w_campo01' , Retorno );

end;



procedure TestTBuilderSQLDMLDelete.TestExecuteCom4Where;
var
  Retorno: string;
begin
  FBuilderSQLDMLDelete.DefineTable( 'teste' );
  FBuilderSQLDMLDelete.DefineWhere( 'campo01', 1 );
  FBuilderSQLDMLDelete.DefineWhere( 'campo02', 1 );
  FBuilderSQLDMLDelete.DefineWhere( 'campo03', 1 );
  FBuilderSQLDMLDelete.DefineWhere( 'campo04', 1 );

  Retorno:= FBuilderSQLDMLDelete.MountSQL();

  CheckEquals( 'delete from teste where campo01 = :_w_campo01 and campo02 = :_w_campo02 and campo03 = :_w_campo03 and campo04 = :_w_campo04' , Retorno );

end;



initialization
  // Register any test cases with the test runner
  RegisterTest(TestTBuilderSQLDMLInsert.Suite);
  RegisterTest(TestTBuilderSQLDMLUpdate.Suite);
  RegisterTest(TestTBuilderSQLDMLDelete.Suite);
end.

