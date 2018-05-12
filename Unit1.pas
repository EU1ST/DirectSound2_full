unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
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
  ComboBox1.Align := alTop;
  Memo1.ScrollBars := ssBoth;
  Memo1.Align := alClient;
  Memo1.Clear;
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
  Memo1.Clear;
  ZeroMemory(@capInfo, SizeOf(TDSCaps));
  capInfo.dwSize := SizeOf(TDSCaps);

  DirectSoundCreate8(@guidArr[ComboBox1.ItemIndex], myDSound, nil);
  Caption := GUIDToString(guidArr[ComboBox1.ItemIndex]);
  myDSound.GetCaps(capInfo);

  with Memo1.Lines do begin
    Add(Format('%d'#9'dwSize',                         [capInfo.dwSize                        ]));
    Add(Format('%d'#9'dwFlags',                        [capInfo.dwFlags                       ]));
    Add(Format('%d'#9'dwMinSecondarySampleRate',       [capInfo.dwMinSecondarySampleRate      ]));
    Add(Format('%d'#9'dwMaxSecondarySampleRate',       [capInfo.dwMaxSecondarySampleRate      ]));
    Add(Format('%d'#9'dwPrimaryBuffers',               [capInfo.dwPrimaryBuffers              ]));
    Add(Format('%d'#9'dwMaxHwMixingAllBuffers',        [capInfo.dwMaxHwMixingAllBuffers       ]));
    Add(Format('%d'#9'dwMaxHwMixingStaticBuffers',     [capInfo.dwMaxHwMixingStaticBuffers    ]));
    Add(Format('%d'#9'dwMaxHwMixingStreamingBuffers',  [capInfo.dwMaxHwMixingStreamingBuffers ]));
    Add(Format('%d'#9'dwFreeHwMixingAllBuffers',       [capInfo.dwFreeHwMixingAllBuffers      ]));
    Add(Format('%d'#9'dwFreeHwMixingStaticBuffers',    [capInfo.dwFreeHwMixingStaticBuffers   ]));
    Add(Format('%d'#9'dwFreeHwMixingStreamingBuffers', [capInfo.dwFreeHwMixingStreamingBuffers]));
    Add(Format('%d'#9'dwMaxHw3DAllBuffers',            [capInfo.dwMaxHw3DAllBuffers           ]));
    Add(Format('%d'#9'dwMaxHw3DStaticBuffers',         [capInfo.dwMaxHw3DStaticBuffers        ]));
    Add(Format('%d'#9'dwMaxHw3DStreamingBuffers',      [capInfo.dwMaxHw3DStreamingBuffers     ]));
    Add(Format('%d'#9'dwFreeHw3DAllBuffers',           [capInfo.dwFreeHw3DAllBuffers          ]));
    Add(Format('%d'#9'dwFreeHw3DStaticBuffers',        [capInfo.dwFreeHw3DStaticBuffers       ]));
    Add(Format('%d'#9'dwFreeHw3DStreamingBuffers',     [capInfo.dwFreeHw3DStreamingBuffers    ]));
    Add(Format('%d'#9'dwTotalHwMemBytes',              [capInfo.dwTotalHwMemBytes             ]));
    Add(Format('%d'#9'dwFreeHwMemBytes',               [capInfo.dwFreeHwMemBytes              ]));
    Add(Format('%d'#9'dwMaxContigFreeHwMemBytes',      [capInfo.dwMaxContigFreeHwMemBytes     ]));
    Add(Format('%d'#9'dwUnlockTransferRateHwBuffers',  [capInfo.dwUnlockTransferRateHwBuffers ]));
    Add(Format('%d'#9'dwPlayCpuOverheadSwBuffers',     [capInfo.dwPlayCpuOverheadSwBuffers    ]));
  end;
end;

end.

