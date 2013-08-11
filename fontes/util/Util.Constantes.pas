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

  PREFIX_SQL_PARANS = '_'; // prefixo dos paramentros e dos campos

  PREFIX_SQL_FIELD = ':_f_';
  PREFIX_SQL_WHERE = ':_w_';


implementation

uses
  SysUtils;


initialization
   DIR_APLICACAO:= ExtractFilePath( Application.ExeName );

end.
