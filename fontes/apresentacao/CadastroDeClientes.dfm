object FrmCadastroDeClientes: TFrmCadastroDeClientes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de clientes'
  ClientHeight = 383
  ClientWidth = 539
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 95
    Top = 31
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object EdtID: TLabeledEdit
    Left = 24
    Top = 32
    Width = 65
    Height = 21
    EditLabel.Width = 11
    EditLabel.Height = 13
    EditLabel.Caption = 'ID'
    TabOrder = 0
  end
  object EdtNome: TLabeledEdit
    Left = 24
    Top = 72
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    TabOrder = 1
  end
  object BtnSalvar: TBitBtn
    Left = 248
    Top = 31
    Width = 121
    Height = 75
    Caption = 'Salvar/Editar'
    TabOrder = 2
    OnClick = BtnSalvarClick
  end
  object BtnCancelar: TBitBtn
    Left = 248
    Top = 191
    Width = 75
    Height = 74
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = BtnCancelarClick
  end
  object BtnExcluir: TBitBtn
    Left = 248
    Top = 112
    Width = 75
    Height = 73
    Caption = 'Excluir'
    TabOrder = 4
    OnClick = BtnExcluirClick
  end
  object BtnFechar: TBitBtn
    Left = 248
    Top = 271
    Width = 75
    Height = 74
    Caption = 'Fechar'
    TabOrder = 5
    OnClick = BtnFecharClick
  end
end
