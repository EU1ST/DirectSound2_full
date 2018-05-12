unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox; //??????
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses DirectSound;

var
  guidArr: array of TGUID;

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
var
  myDSound: IDirectSound8;
  capInfo: TDSCaps;
  p: PDSCaps;
begin
  ZeroMemory(@capInfo, SizeOf(TDSCaps));
  capInfo.dwSize := SizeOf(TDSCaps);
  DirectSoundCreate8(@guidArr[ComboBox1.ItemIndex], myDSound, nil);
  Caption := GUIDToString(guidArr[ComboBox1.ItemIndex]);
  myDSound.GetCaps(capInfo);
end;

end.

