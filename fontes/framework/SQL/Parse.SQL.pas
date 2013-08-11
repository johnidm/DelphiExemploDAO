unit Parse.SQL;

interface

uses Util.Types, Data.DB;

type
  TParseSQLFields = class

  public
    class function GetFields( const AFields: TParamBuilder ): string;
    class function GetParamsWhere( const AFields: TParamBuilder ): string;
    class function GetParamsField( const AFields: TParamBuilder ): string;
    class function GetParamsUpdate( const AFields: TParamBuilder ): string;

    class function GetParans( const AFields: TParamBuilder; const AWheres: TParamBuilder ): TParams;

  end;

implementation

uses
  System.SysUtils, System.StrUtils, Util.Constantes, Vcl.Dialogs;


{ ParseSQLFields }

class function TParseSQLFields.GetFields(const AFields: TParamBuilder): string;
var
  Key: string;
begin
  for Key in AFields.Keys do
  begin
    Result:= Result + IfThen( Result <> EmptyStr, ', ' ) + Key  ;

  end
end;



class function TParseSQLFields.GetParamsField(
  const AFields: TParamBuilder): string;
var
  Key: string;
begin
  for Key in AFields.Keys do
    Result:= Result + IfThen( Result <> EmptyStr, ', ' ) +  PREFIX_SQL_FIELD + Key ;

end;



class function TParseSQLFields.GetParamsWhere(const AFields: TParamBuilder): string;
var
  Key: string;
begin
  for Key in AFields.Keys do
    Result:= Result + IfThen( Result <> EmptyStr, ' and ' ) + Key + ' = ' + PREFIX_SQL_WHERE + Key ;

end;



class function TParseSQLFields.GetParans(const AFields,
  AWheres: TParamBuilder): TParams;

var
  Key: String;

  function GetFieldType(const AFiled: Variant): TFieldType;
  begin
    {TODO Implemetar esse método }
    Result:= ftString;
  end;


begin
  Result:= TParams.Create( nil );

  for Key in AFields.Keys do
    Result.CreateParam( GetFieldType( AFields.Items[ Key ] ), PREFIX_SQL_FIELD + Key , ptInput ).Value := AFields.Items[ Key ];

  for Key in AWheres.Keys do
    Result.CreateParam( GetFieldType( AWheres.Items[ Key ] ), PREFIX_SQL_WHERE + Key, ptInput ).Value:= AWheres.Items[ Key ];

end;



class function TParseSQLFields.GetParamsUpdate(
  const AFields: TParamBuilder): string;
var
  Key: string;
begin
  for Key in AFields.Keys do
    Result:= Result + IfThen( Result <> EmptyStr, ', ' ) + Key + ' = ' + PREFIX_SQL_FIELD + Key ;

end;



end.
