object FormServer: TFormServer
  Left = 235
  Top = 133
  Width = 304
  Height = 455
  Caption = 'Server Order'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 32
    Width = 57
    Height = 13
    Caption = 'Nomor Meja'
  end
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 69
    Height = 13
    Caption = 'This IP Addres'
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 52
    Height = 13
    Caption = 'ID Member'
  end
  object Label4: TLabel
    Left = 16
    Top = 80
    Width = 48
    Height = 13
    Caption = 'ID Produk'
  end
  object Label5: TLabel
    Left = 16
    Top = 104
    Width = 23
    Height = 13
    Caption = 'Note'
  end
  object Memo1: TMemo
    Left = 8
    Top = 176
    Width = 265
    Height = 193
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 0
  end
  object ButtonSend: TButton
    Left = 144
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 1
    OnClick = ButtonSendClick
  end
  object Edit1: TEdit
    Left = 96
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 96
    Top = 8
    Width = 121
    Height = 19
    TabStop = False
    BevelInner = bvSpace
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 3
  end
  object Edit3: TEdit
    Left = 96
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object Edit4: TEdit
    Left = 96
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object Edit5: TEdit
    Left = 96
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object Button1: TButton
    Left = 200
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 7
    OnClick = Button1Click
  end
  object ServerSocket1: TServerSocket
    Active = True
    Port = 5000
    ServerType = stNonBlocking
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    Left = 112
    Top = 136
  end
end
