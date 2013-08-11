{
  Business Object
  Possui as versões dos leiautes disponíveis para exportação do arquivo de clientes
}

unit BO.Exportar.Clientes.Leiaute;

interface

uses
  Model.Cliente,
  Classes,
  SysUtils, Util.Constantes;


type
  TVersaoLeiaute = ( tleitBlocado, tleitCaractereSeparador );


  IVersaoLeiaute = interface
    ['{C3EAE1A9-8E45-47C2-B51D-4140708F7D95}']
    procedure Exportar( const AClientes: TModelListaCliente );
  end;

  // Classe base dos leiautes
  TVersao = class ( TInterfacedObject )
  public
    procedure PreparaDiretorio( const AArquivoExportacao: string );
  end;


  TVersaoBlocado = class( TVersao , IVersaoLeiaute )
  public
    procedure Exportar( const AClientes: TModelListaCliente );
  end;


  TVersaoCaractereSeparador = class( TVersao, IVersaoLeiaute )
  private
    const CARACTERE_SEPARADOR = ':';
  public
    procedure Exportar( const AClientes: TModelListaCliente );
  end;

  // Fábrica de leiaute
  TLeiauteFactory = class
  public
    class function Instance( const AVersaoLeiaute: TVersaoLeiaute ): IVersaoLeiaute;
  end;


implementation


{ TVersaoBlocado }

procedure TVersaoBlocado.Exportar(const AClientes: TModelListaCliente);
const
  ARQUIVO = 'versao_blocado.txt' ;

var
  StringList: TStringList;
  Cliente: TModelCliente;
begin
  StringList:= TStringList.Create;
  try
    for Cliente in AClientes do
    begin
      StringList.Add(
        IntToStr(Cliente.ID) +
        Cliente.Nome
      );
    end;

    PreparaDiretorio( ARQUIVO );

    StringList.SaveToFile( DIR_APLICACAO + ARQUIVO );

  finally
    FreeAndNil( StringList )
  end;

end;

{ TVersaoCaractereSeparador }

procedure TVersaoCaractereSeparador.Exportar(const AClientes: TModelListaCliente);
const
  ARQUIVO = 'versao_caractere_separador.txt';

var
  StringList: TStringList;
  Cliente: TModelCliente;
begin
  StringList:= TStringList.Create;
  try
    for Cliente in AClientes do
    begin
      StringList.Add(
        IntToStr(Cliente.ID) +

        CARACTERE_SEPARADOR +

        Cliente.Nome
      );
    end;

    PreparaDiretorio( ARQUIVO );

    StringList.SaveToFile( DIR_APLICACAO + ARQUIVO );

  finally
    FreeAndNil( StringList )
  end;
end;


{ TLeiaute }

class function TLeiauteFactory.Instance(
  const AVersaoLeiaute: TVersaoLeiaute): IVersaoLeiaute;
begin
  case AVersaoLeiaute of
    tleitBlocado: Result:= TVersaoBlocado.Create() ;
    tleitCaractereSeparador: Result:= TVersaoCaractereSeparador.Create() ;
  end;
end;


{ TVersao }

procedure TVersao.PreparaDiretorio( const AArquivoExportacao: string );
begin
  if ( not ( DirectoryExists ( DIR_APLICACAO ) ) ) then
    CreateDir( ExtractFilePath( DIR_APLICACAO ) );


  if ( FileExists( AArquivoExportacao ) ) then
    DeleteFile(  AArquivoExportacao );

end;



end.
