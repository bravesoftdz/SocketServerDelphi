object FormServer: TFormServer
  Left = 126
  Top = 106
  Width = 1179
  Height = 501
  Caption = 'Server Order'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 880
    Top = 8
    Width = 69
    Height = 13
    Caption = 'This IP Addres'
  end
  object Label5: TLabel
    Left = 880
    Top = 32
    Width = 23
    Height = 13
    Caption = 'Logs'
  end
  object Memo1: TMemo
    Left = 880
    Top = 48
    Width = 265
    Height = 345
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ButtonSend: TButton
    Left = 992
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 1
    Visible = False
    OnClick = ButtonSendClick
  end
  object EditIP: TEdit
    Left = 960
    Top = 8
    Width = 169
    Height = 19
    TabStop = False
    BevelInner = bvSpace
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 1072
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 3
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 857
    Height = 385
    DataSource = DsOrder
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_ORDER'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TABLE_NO'
        Title.Caption = 'TABLE'
        Width = 39
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FID_WAITERS'
        Title.Caption = 'ID_WAITERS'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WAITER_NAME'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_MEMBER'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MEMBER_NAME'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MENU'
        Width = 121
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRICE'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTY'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTAL_PRICE'
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_STATUS'
        Title.Caption = 'PAID'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Width = 48
        Visible = True
      end>
  end
  object ServerSocket1: TServerSocket
    Active = True
    Port = 5000
    ServerType = stNonBlocking
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    Left = 792
    Top = 400
  end
  object ZConnection: TZConnection
    Protocol = 'mysql'
    HostName = 'localhost'
    Database = 'cafedb'
    User = 'root'
    Connected = True
    Left = 728
    Top = 400
  end
  object ZTableOrder: TZTable
    Connection = ZConnection
    Active = True
    TableName = 'view_order'
    Left = 640
    Top = 344
  end
  object DsOrder: TDataSource
    DataSet = ZTableOrder
    Left = 672
    Top = 344
  end
  object MainMenu1: TMainMenu
    Left = 696
    Top = 400
    object Menu1: TMenuItem
      Caption = 'File'
      object Product1: TMenuItem
        Caption = 'Menu'
      end
      object Waiters1: TMenuItem
        Caption = 'Waiters'
      end
      object Ingredients1: TMenuItem
        Caption = 'Ingredients'
      end
    end
  end
  object ZQueryInput: TZQuery
    Connection = ZConnection
    Params = <>
    Left = 664
    Top = 400
  end
end
