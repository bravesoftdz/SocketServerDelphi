unit UnitServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, Winsock;

type
  TFormServer = class(TForm)
    ServerSocket1: TServerSocket;
    Memo1: TMemo;
    ButtonSend: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ButtonSendClick(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormShow(Sender: TObject);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
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

procedure TFormServer.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
memo1.Lines.Add(Socket.ReceiveText)
end;

procedure TFormServer.ButtonSendClick(Sender: TObject);
var
  i:integer;
begin
for i := 0 to ServerSocket1.Socket.ActiveConnections-1 do
  begin
    with ServerSocket1.Socket.Connections[i] do
    begin
        SendText('NOTIFY#'+ Edit1.Text +'#'+ Edit3.Text +'# CATATAN'#13#10);
    end;
  end;
//ServerSocket1.Socket.Connections[0].sendtext('NOTIFY#'+ Edit1.Text +'#'+ Edit3.Text +'# CATATAN'#13#10);
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
    Edit2.Text := IP;
  end
  else
    MessageDlg(Err, mtError, [mbOk], 0);

end;

procedure TFormServer.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
memo1.Lines.Add('Client has disconnected');
end;

end.
