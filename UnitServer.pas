unit UnitServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, Winsock, Menus, DB, Grids, DBGrids,
  ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  ZConnection;

type
  TFormServer = class(TForm)
    ServerSocket1: TServerSocket;
    Memo1: TMemo;
    ButtonSend: TButton;
    Label2: TLabel;
    EditIP: TEdit;
    Label5: TLabel;
    Button1: TButton;
    ZConnection: TZConnection;
    ZTableOrder: TZTable;
    DBGrid1: TDBGrid;
    DsOrder: TDataSource;
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    Product1: TMenuItem;
    Waiters1: TMenuItem;
    Ingredients1: TMenuItem;
    ZQueryInput: TZQuery;
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ButtonSendClick(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormShow(Sender: TObject);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormServer: TFormServer;

implementation

{$R *.dfm}
function GetIPFromHost
(var HostName, IPaddr, WSAErr: string): Boolean; 
type 
  Name = array[0..100] of Char; 
  PName = ^Name; 
var 
  HEnt: pHostEnt; 
  HName: PName; 
  WSAData: TWSAData; 
  i: Integer; 
begin 
  Result := False;     
  if WSAStartup($0101, WSAData) <> 0 then begin 
    WSAErr := 'Winsock is not responding."';
    Exit; 
  end; 
  IPaddr := ''; 
  New(HName); 
  if GetHostName(HName^, SizeOf(Name)) = 0 then
  begin 
    HostName := StrPas(HName^); 
    HEnt := GetHostByName(HName^); 
    for i := 0 to HEnt^.h_length - 1 do 
     IPaddr :=
      Concat(IPaddr,
      IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.'); 
    SetLength(IPaddr, Length(IPaddr) - 1); 
    Result := True; 
  end
  else begin
   case WSAGetLastError of
    WSANOTINITIALISED:WSAErr:='WSANotInitialised'; 
    WSAENETDOWN      :WSAErr:='WSAENetDown'; 
    WSAEINPROGRESS   :WSAErr:='WSAEInProgress'; 
   end;
  end; 
  Dispose(HName);
  WSACleanup;
end;

procedure Split
(const Delimiter: Char; // delimiter charachter
 Input: string;         // input string
 const Strings: TStrings) ; // list of string result
begin
Assert(Assigned(Strings)) ;
Strings.Clear;
Strings.Delimiter := Delimiter;
Strings.DelimitedText := Input;
end;

procedure TFormServer.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
 data, command, noTable, idMember, idWaiters, idProduct, productName, price, qty, unique_id:string;
 splitOrder,splitDetailOrder : TStringList;
 count, i, countDetail, clientNo : integer;
begin
data := Socket.ReceiveText;
memo1.Lines.Add(data);
splitOrder:= TStringList.Create;
  try
    Split('/', data, splitOrder);
    count := splitOrder.Count;
    for i:=0 to count-1 do
  begin
      splitDetailOrder:= TStringList.Create;
        try
          Split('#', splitOrder[i], splitDetailOrder) ;
          countDetail := splitDetailOrder.Count;
          if countDetail >=3 then
          begin
          command:=splitDetailOrder[0];
          noTable:=splitDetailOrder[1];
          idWaiters:=splitDetailOrder[2];
          idMember:=splitDetailOrder[3];
          idProduct:=splitDetailOrder[4];
          productName:=splitDetailOrder[5];
          price:=splitDetailOrder[6];
          qty:=splitDetailOrder[7];
          unique_id:=splitDetailOrder[8];
          if command='ORDER' then
          begin
            with ZQueryInput do
            begin
              Close;
              SQL.Clear;
              SQL.Text:='insert into cafedb.order (FID_WAITERS, FID_MENU, FID_MEMBER, QTY, TABLE_NO, UNIQUE_ID)values('''+idWaiters+''', '''+idProduct+''', '''+idMember+''', '''+qty+''', '''+noTable+''', '''+unique_id+''')';
              ExecSQL;
            end;
          end;
          end
          else
          begin
          command:=splitDetailOrder[0];
          unique_id:=splitDetailOrder[1];
          if command='NOTIFY' then
          begin
            with ZQueryInput do
            begin
              Close;
              SQL.Clear;
              SQL.Text:='update cafedb.order set STATUS=''COOKED'' where UNIQUE_ID='''+unique_id+'''';
              ExecSQL;
            end;
            with ZQueryInput do
            begin
              Close;
              SQL.Clear;
              SQL.Text:='select table_no, id_member, fid_menu, menu from cafedb.view_order where UNIQUE_ID='''+unique_id+'''';
              Open;
            end;
            if not ZQueryInput.Eof then
            begin
                  noTable:=ZQueryInput.Fields[0].AsString;
                  idMember:=ZQueryInput.Fields[1].AsString;
                  idProduct:=ZQueryInput.Fields[2].AsString;
                  productName:=ZQueryInput.Fields[3].AsString+' : Cooked Done';
            end;

          end;
          end;

          for clientNo := 0 to ServerSocket1.Socket.ActiveConnections-1 do
            begin
              with ServerSocket1.Socket.Connections[i] do
              begin
                SendText(command+'#'+ noTable +'#'+ idMember +'#'+ idProduct +'#'+ productName +'#'+ unique_id +#13#10);
              end;
            end;

          ZTableOrder.Refresh;

        finally
          splitDetailOrder.Free;
        end;

  end;
  finally
    splitOrder.Free;
  end;





end;

procedure TFormServer.ButtonSendClick(Sender: TObject);
var
  i:integer;
begin
for i := 0 to ServerSocket1.Socket.ActiveConnections-1 do
  begin
    with ServerSocket1.Socket.Connections[i] do
    begin
//        SendText('ORDER#'+ Edit1.Text +'#'+ Edit3.Text +'#'+ Edit4.Text +'#'+ Edit5.Text +#13#10);
    end;
  end;

end;

procedure TFormServer.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
memo1.Lines.Add('Client has connected');
end;

procedure TFormServer.FormShow(Sender: TObject);
var
  Host, IP, Err: string;
begin
if GetIPFromHost(Host, IP, Err) then begin
    EditIP.Text := IP;
  end
  else
    MessageDlg(Err, mtError, [mbOk], 0);

end;

procedure TFormServer.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
memo1.Lines.Add('Client has disconnected');
end;

procedure TFormServer.Button1Click(Sender: TObject);
begin
Memo1.Clear;
end;

end.
