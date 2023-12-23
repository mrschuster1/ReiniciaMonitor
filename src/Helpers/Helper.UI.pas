unit Helper.UI;

interface

uses
  Graphics,
  Classes,
  Windows;

type
  TUIHelper = class
  private
    const
    FONTS_LIST: array [0 .. 2] of string = ('SEGOE_MDL2', 'SEGOE_FLUENT',
      'DASH_ICONS');
  public
    class procedure LoadFontFromResource;
  end;

implementation

var
  FontCount: Cardinal;

  { TUIHelper }

class procedure TUIHelper.LoadFontFromResource;
begin
  for var Font in FONTS_LIST do
  begin
    var
    Stream := TResourceStream.Create(HInstance, Font, RT_RCDATA);
    try
      var
      FontData := TMemoryStream.Create;
      try
        FontData.CopyFrom(Stream, Stream.Size);
        AddFontMemResourceEx(FontData.Memory, FontData.Size, nil, @FontCount);
      finally
        FontData.Free;
      end;
    finally
      Stream.Free;
    end;
  end;
end;

initialization

TUIHelper.LoadFontFromResource;

end.
