unit Util.Funcoes;

interface

  procedure LancarErro( const AMensagem: string );

implementation

uses
  System.SysUtils;


procedure LancarErro( const AMensagem: string );
begin
  raise Exception.Create( AMensagem );
end;


end.
