program SocketServerProject;

uses
  Forms,
  UnitServer in 'UnitServer.pas' {FormServer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormServer, FormServer);
  Application.Run;
end.
