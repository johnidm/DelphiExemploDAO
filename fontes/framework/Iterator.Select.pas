unit Iterator.Select;

interface

uses
  Vcl.Dialogs, Data.SqlExpr,
  System.SysUtils, Data.DB, System.Classes;

type
  IIteratorSelect = interface
    ['{96CAECD5-3A85-4643-A991-3678CB56DBF4}']
    function IsEmpty(): Boolean;
    function NextEof(): Boolean;
    function Field( const AFieldName: string ): TField;
  end;

  TIteratorSelect = class( TInterfacedObject, IIteratorSelect )
  strict private
    SQLDataSet: TSQLDataSet;
    CanNextRecord: Boolean;

    function GetSQLDataSet: TSQLDataSet;

    constructor Create( const ASQL: string );
    destructor Destroy(); override;

  public
    property DataSet: TSQLDataSet read GetSQLDataSet;

    function IsEmpty(): Boolean;
    function NextEof(): Boolean;
    function Field( const AFieldName: string ): TField;

    class function Iterator( const ACommandSelect: string ): IIteratorSelect;
  end;

implementation

{ TIterator }

uses RegisterVariable.ConnDB;


constructor TIteratorSelect.Create(const ASQL: string);
begin
  SQLDataSet:= TSQLDataSet.Create( nil );
  SQLDataSet.CommandText:= ASQL;

  SQLDataSet.SQLConnection:= TRegisterVariable.ConnDB ;

  SQLDataSet.Open();
  SQLDataSet.First();

  CanNextRecord:= False;
end;



destructor TIteratorSelect.Destroy;
begin
  if ( Assigned( SQLDataSet ) ) then
    FreeAndNil( SQLDataSet );

  inherited;
end;



function TIteratorSelect.Field( const AFieldName: string ): TField;
begin
  Result:= SQLDataSet.Fields.FieldByName( AFieldName )
end;


function TIteratorSelect.GetSQLDataSet: TSQLDataSet;
begin
  Result:= SQLDataSet;
end;


function TIteratorSelect.IsEmpty: Boolean;
begin
  Result:= SQLDataSet.IsEmpty;
end;


class function TIteratorSelect.Iterator( const ACommandSelect: string ): IIteratorSelect;
begin
  Result:= TIteratorSelect.Create( ACommandSelect );
end;


function TIteratorSelect.NextEof: Boolean;
begin

  if ( CanNextRecord ) then
    SQLDataSet.Next();

  Result:= ( not (SQLDataSet.Eof) );

  if ( SQLDataSet.Bof ) then
    CanNextRecord:= True;

end;


initialization



finalization
  

end.