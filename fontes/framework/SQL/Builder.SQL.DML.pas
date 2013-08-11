unit Builder.SQL.DML;

interface

uses
  System.SysUtils,
  Data.DB, StrUtils,
  Generics.Collections,
  RegisterVariable.ConnDB,
  Util.Constantes,
  Util.Types,
  Vcl.Dialogs,
  Util.RS;

type
  EBuilderSQLDML = class( Exception );


  {$REGION 'Classe base do Builder SQL'}
  TBuilderSQLDML = class
  strict private
    FTable: string;
    function GetTable: string;

  protected
    Fields: TParamBuilder;
    Wheres: TParamBuilder;

    property Table: string read GetTable write FTable;
  public

    procedure DefineTable( const ATable: string );

    procedure DefineField( const AFieldName: string; const AParamValue: Variant );
    procedure DefineWhere( const AFieldName: string; const AParamValue: Variant );

    procedure Clear();

    constructor Create();
    destructor Destroy; override;
  end;
  {$ENDREGION}


  TBuilderSQLDMLInsert = class( TBuilderSQLDML )
  public
    function MountSQL(): string;
    procedure Execute();
  end;

  TBuilderSQLDMLUpdate = class( TBuilderSQLDML )
  public
    function MountSQL(): string;
    procedure Execute();
  end;

  TBuilderSQLDMLDelete = class( TBuilderSQLDML )
  public
    function MountSQL(): string;
    procedure Execute();
  end;


implementation



{ TBuilderSQLDML }

uses Parse.SQL;

procedure TBuilderSQLDML.Clear;
begin
  Table:= EmptyStr;

  Fields.Clear();
  Wheres.Clear();

end;

constructor TBuilderSQLDML.Create;
begin
  Fields:= TParamBuilder.Create();
  Wheres:= TParamBuilder.Create();

end;



destructor TBuilderSQLDML.Destroy;
begin
  FreeAndNil( Wheres );
  FreeAndNil( Fields );

  inherited;
end;



function TBuilderSQLDML.GetTable: string;
begin
  if ( FTable = EmptyStr ) then
    raise EBuilderSQLDML.Create( RSTabelaNaoInformada );

  Result:= FTable;
end;



procedure TBuilderSQLDML.DefineField(const AFieldName: string;
  const AParamValue: Variant);
begin
  Fields.Add( AFieldName, AParamValue );

end;



procedure TBuilderSQLDML.DefineWhere(  const AFieldName: string; const AParamValue: Variant );
begin
  Wheres.Add( AFieldName, AParamValue );
end;



procedure TBuilderSQLDML.DefineTable(const ATable: string);
begin
  FTable:= ATable;
end;



{ TBuilderSQLDMLInsert }

procedure TBuilderSQLDMLInsert.Execute;
var
  Params: TParams;
begin
  Params:= TParseSQLFields.GetParans( Fields, Wheres );
  try

    TRegisterVariable.ConnDB.Execute( MountSQL(), Params );

  finally
    FreeAndNil( Params )
  end;
end;



function TBuilderSQLDMLInsert.MountSQL: string;
begin
  Result:=
    'insert into ' + Table +  ' ( ' +
       TParseSQLFields.GetFields( Fields ) +
    ' ) values ( ' +
       TParseSQLFields.GetParamsField ( Fields ) +
    ' )';
end;



{ TBuilderSQLDMLUpdate }

procedure TBuilderSQLDMLUpdate.Execute;
var
  Params: TParams;
begin
  Params:= TParseSQLFields.GetParans( Fields, Wheres );
  try

    TRegisterVariable.ConnDB.Execute( MountSQL(), Params );

  finally
    FreeAndNil( Params )
  end;

end;



function TBuilderSQLDMLUpdate.MountSQL: string;
begin
  Result:=
    'update ' + Table + ' set ' +
    TParseSQLFields.GetParamsUpdate( Fields ) +

    IfThen( Wheres.Count > 0, ' where ' + TParseSQLFields.GetParamsWhere( Wheres ) );

end;



{ TBuilderSQLDMLDelete }

procedure TBuilderSQLDMLDelete.Execute;
var
  Params: TParams;
begin
  Params:= TParseSQLFields.GetParans( Fields, Wheres );
  try

    TRegisterVariable.ConnDB.Execute( MountSQL(), Params );

  finally
    FreeAndNil( Params )
  end;
end;



function TBuilderSQLDMLDelete.MountSQL: string;
begin
  Result:=
    'delete from ' + Table + ' where ' +
    TParseSQLFields.GetParamsWhere( Wheres );
end;



end.
