{
  Unidade
  Declara as contantes compartilhadas no ciclo de vida da applicação
}

unit Util.Constantes;

interface

uses
  Forms;

const
  {$J+}
  DIR_APLICACAO: string = '';
  {$J-}



implementation

uses
  SysUtils;


initialization
   DIR_APLICACAO:= ExtractFilePath( Application.ExeName );

end.
