unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DirectSound, Registry;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
  guidArr: array of TGUID;
  DS: IDirectSound;
  TDSGUID, RTDSGUID: TGUID;
function EnumCallback(lpGuid: PGUID; lpcstrDescription, lpcstrModule: PChar;
    lpContext: Pointer): BOOL; stdcall;
begin
  if lpGuid <> nil then
  begin
    TStrings(lpContext).Add(lpcstrDescription);
    SetLength(guidArr, Length(guidArr) + 1);
    guidArr[Length(guidArr) - 1] := lpGuid^;
  end;
  Result := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DirectSoundEnumerate(EnumCallback, ComboBox1.Items);
  ComboBox1.ItemIndex := 0;
  ComboBox1.OnChange(nil);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);

begin
  TDSGUID:= guidArr[ComboBox1.ItemIndex];
  DirectSoundCreate(@TDSGUID, DS, nil);
  Caption := GUIDToString(guidArr[ComboBox1.ItemIndex]);
end;

procedure TForm1.Button1Click(Sender: TObject);
var R: TRegistry;
begin
  R := TRegistry.Create;
  try
    if not R.OpenKey('Software\AlMaGriNa', True) then
      RaiseLastOSError;
    R.WriteBinaryData('SumVAC', TDSGUID, 16);
  finally R.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var R: TRegistry;
begin
  R := TRegistry.Create;
  try
    if not R.OpenKey('Software\AlMaGriNa', True) then
      RaiseLastOSError;
    R.ReadBinaryData('SumVAC', TDSGUID, 16);
    Label1.Caption:= GUIDToString(TDSGUID);
  finally R.Free;
  end;
end;

end.

