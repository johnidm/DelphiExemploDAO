unit Iterator.SQL.Select;

interface

uses
  Vcl.Dialogs, Data.SqlExpr,
  System.SysUtils, Data.DB, System.Classes;

type
  IIteratorSQLSelect = interface
    ['{96CAECD5-3A85-4643-A991-3678CB56DBF4}']
    function IsEmpty(): Boolean;
    function NextEof(): Boolean;
    function Field( const AFieldName: string ): TField;
  end;

  TIteratorSQLSelect = class( TInterfacedObject, IIteratorSQLSelect )
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

    class function Iterator( const ACommandSelect: string ): IIteratorSQLSelect;
  end;

implementation

{ TIterator }

uses RegisterVariable.ConnDB;


constructor TIteratorSQLSelect.Create(const ASQL: string);
begin
  SQLDataSet:= TSQLDataSet.Create( nil );
  SQLDataSet.CommandText:= ASQL;

  SQLDataSet.SQLConnection:= TRegisterVariable.ConnDB ;

  SQLDataSet.Open();
  SQLDataSet.First();

  CanNextRecord:= False;
end;



destructor TIteratorSQLSelect.Destroy;
begin
  if ( Assigned( SQLDataSet ) ) then
    FreeAndNil( SQLDataSet );

  inherited;
end;



function TIteratorSQLSelect.Field( const AFieldName: string ): TField;
begin
  Result:= SQLDataSet.Fields.FieldByName( AFieldName )
end;



function TIteratorSQLSelect.GetSQLDataSet: TSQLDataSet;
begin
  Result:= SQLDataSet;
end;



function TIteratorSQLSelect.IsEmpty: Boolean;
begin
  Result:= SQLDataSet.IsEmpty;
end;



class function TIteratorSQLSelect.Iterator( const ACommandSelect: string ): IIteratorSQLSelect;
begin
  Result:= TIteratorSQLSelect.Create( ACommandSelect );
end;



function TIteratorSQLSelect.NextEof: Boolean;
begin

  if ( CanNextRecord ) then
    SQLDataSet.Next();

  Result:= ( not (SQLDataSet.Eof) );

  if ( SQLDataSet.Bof ) then
    CanNextRecord:= True;

end;



end.
