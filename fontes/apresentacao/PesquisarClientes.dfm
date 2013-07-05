object FrmPesquisarClientes: TFrmPesquisarClientes
  Left = 0
  Top = 0
  ActiveControl = GrdClientes
  BorderStyle = bsDialog
  Caption = 'Pesquisar Clientes'
  ClientHeight = 277
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 226
    Width = 331
    Height = 51
    Align = alBottom
    TabOrder = 0
    object BtnOK: TBitBtn
      Left = 167
      Top = 16
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
    object BtnFechar: TBitBtn
      Left = 248
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = BtnFecharClick
    end
  end
  object GrdClientes: TDBGrid
    Left = 0
    Top = 0
    Width = 331
    Height = 226
    Align = alClient
    DataSource = DsClientes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = GrdClientesDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 200
        Visible = True
      end>
  end
  object CdsClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 168
    object CdsClientesID: TIntegerField
      FieldName = 'ID'
    end
    object CdsClientesNome: TStringField
      FieldName = 'Nome'
      Size = 60
    end
  end
  object DsClientes: TDataSource
    DataSet = CdsClientes
    Left = 88
    Top = 216
  end
end
