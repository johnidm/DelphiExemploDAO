object FrmListView: TFrmListView
  Left = 0
  Top = 0
  ActiveControl = ListBox1
  BorderStyle = bsDialog
  Caption = 'ListView'
  ClientHeight = 372
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 288
    Top = 40
    Width = 169
    Height = 33
    Caption = 'Novo Cliente'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 241
    Height = 345
    ItemHeight = 13
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 288
    Top = 88
    Width = 113
    Height = 33
    Caption = 'Editar Cliente'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 288
    Top = 136
    Width = 113
    Height = 33
    Caption = 'Excluir Cliente'
    TabOrder = 3
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 288
    Top = 184
    Width = 113
    Height = 33
    Caption = 'Pesquisar Cliente'
    TabOrder = 4
  end
  object BitBtn5: TBitBtn
    Left = 288
    Top = 296
    Width = 113
    Height = 33
    Caption = 'Exportar em Arquivo'
    TabOrder = 5
    OnClick = BitBtn5Click
  end
end
