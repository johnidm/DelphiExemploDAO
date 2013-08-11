unit Parse.SQL.Params;

interface

uses
  Data.DB;


type
  TParseSQLParams = class
  public
    class function WheresComma( const AParams: TParams ): string;
    class function FieldsComma( const AParams: TParams ): string;

    class function ParamWhere( const AParams: TParams ): string;
    class function ParamUpdate( const AParams: TParams ): string;

  end;

implementation

{ TParseParams }

uses Util.Constantes, System.StrUtils;

function RemovePrefix( const AField: string ): string;
begin
  Result:= AField;
  Delete( Result, Pos( PREFIX_SQL_PARANS , Result ) , Length( PREFIX_SQL_PARANS ) ) ;
end;



class function TParseSQLParams.FieldsComma(const AParams: TParams): string;
var
  Index: Integer;
begin
  for Index:= 0 to Pred( AParams.Count ) do
    Result:= Result + RemovePrefix( AParams[ Index ].Name ) +
      IfThen( Index <> Pred( AParams.Count ) , ', ' ) ;
end;



class function TParseSQLParams.WheresComma(const AParams: TParams): string;
var
  Index: Integer;
begin
  for Index:= 0 to Pred( AParams.Count ) do
    Result:= Result + ':' + AParams[ Index ].Name +
      IfThen( Index <> Pred( AParams.Count ) , ', ' ) ;

end;



class function TParseSQLParams.ParamUpdate(const AParams: TParams): string;
var
  Index: Integer;
begin
  for Index:= 0 to Pred( AParams.Count ) do
    Result:= Result + RemovePrefix( AParams[ Index ].Name ) + ' = :' +  AParams[ Index ].Name +
      IfThen( Index <> Pred( AParams.Count ) , ', ' ) ;
end;



class function TParseSQLParams.ParamWhere(const AParams: TParams): string;
var
  Index: Integer;
begin
  for Index:= 0 to Pred( AParams.Count ) do
    Result:= Result + ':' + AParams[ Index ].Name +
      IfThen( Index <> Pred( AParams.Count ) , ' and ' ) ;
end;



end.
