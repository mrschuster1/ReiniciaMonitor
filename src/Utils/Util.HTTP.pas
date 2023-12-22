unit Util.HTTP;

interface

uses
  IdHTTP;

type
  THTTPUtil = class
  public
   class function GetIPFromURL(const url: string): string;
  end;

implementation

{ THTTPUtil }

class function THTTPUtil.GetIPFromURL(const url: string): string;
begin
 var IdHTTP := TIdHTTP.Create(nil);
  try
    IdHTTP.Head(url);
    Result := IdHTTP.Response.Server;
  finally
    IdHTTP.Free;
  end;
end;

end.
