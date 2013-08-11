unit TestParse.SQL;

interface

uses
  TestFramework, System.Generics.Collections, Parse.SQL, Util.Types;

type

  TestParseSQLFields = class(TTestCase)
  private
    AFields: TParamBuilder;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetFields;
    procedure TestGetParamsWhere;
    procedure TestGetParamsField;
    procedure TestGetParamsUpdate;
  end;

implementation



procedure TestParseSQLFields.SetUp;
begin
  AFields:= TParamBuilder.Create();
end;



procedure TestParseSQLFields.TearDown;
begin
  AFields.Free;
end;



procedure TestParseSQLFields.TestGetFields;
var
  ReturnValue: string;
begin
  AFields.Add( 'field01', 1 );
  AFields.Add( 'field02', 1 );
  AFields.Add( 'field03', 1 );
  AFields.Add( 'field04', 1 );
  AFields.Add( 'field05', 1 );

  ReturnValue := TParseSQLFields.GetFields(AFields);

  CheckEquals( 'field03, field01, field04, field05, field02' , ReturnValue );
end;



procedure TestParseSQLFields.TestGetParamsWhere;
var
  ReturnValue: string;

begin
  AFields.Add( 'field01', 1 );
  AFields.Add( 'field02', 1 );
 

  ReturnValue := TParseSQLFields.GetParamsWhere(AFields);

  CheckEquals( 'field01 = :_w_field01 and field02 = :_w_field02' , ReturnValue );
end;



procedure TestParseSQLFields.TestGetParamsField;
var
  ReturnValue: string;

begin
  AFields.Add( 'field01', 1 );
  AFields.Add( 'field02', 1 );
  AFields.Add( 'field03', 1 );
  AFields.Add( 'field04', 1 );
  AFields.Add( 'field05', 1 );

  ReturnValue := TParseSQLFields.GetParamsField(AFields);

  CheckEquals( ':_f_field03, :_f_field01, :_f_field04, :_f_field05, :_f_field02' , ReturnValue );
end;



procedure TestParseSQLFields.TestGetParamsUpdate;
var
  ReturnValue: string;

begin
  AFields.Add( 'field01', 1 );
  AFields.Add( 'field02', 1 );
  AFields.Add( 'field03', 1 );

  ReturnValue := TParseSQLFields.GetParamsUpdate(AFields);

  CheckEquals( 'field03 = :_f_field03, field01 = :_f_field01, field02 = :_f_field02' , ReturnValue );

end;



initialization
  // Register any test cases with the test runner
  RegisterTest(TestParseSQLFields.Suite);
end.

