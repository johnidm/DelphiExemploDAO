object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Exemplo Delphi DAO'
  ClientHeight = 297
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 145
    Height = 57
    Caption = 'Cadastro de Clientes'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 80
    Width = 145
    Height = 57
    Caption = 'ListView'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 40
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 2
  end
  object Button4: TButton
    Left = 200
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 3
  end
end
