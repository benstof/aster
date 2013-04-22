unit fontFormunt;

interface

uses Graphics,
     wintypes,
     sysutils,
     extctrls,
     form2unt,
     classes;

Function GetFontFilename(Fnme:String;FStyles:TFontStyles):String;

implementation


var   _Style : TFontStyles;
     _TTFName : string;


Function Is_MMFont(FFn:String):boolean;
begin
   Is_MMFont:=false;
  { if standardfont(FFn) or (FFn='MM ISO') or (FFn='MM ITALIC') or (FFn='MM SCRIPTC') or (FFn='MM COMPLEX') or
      (FFn='MM GOTHICI') or (FFn='MM HB') or (FFn='MM CENT') or (FFn='MM HAND') or (FFn='MM DOTFONT') or
      (FFn='MM HELVITIA') or (FFn='MM ISO_EQ') or (FFn='MM ROMANS') then
         Is_MMFont:=true;}
end;

Function GetFontFilename(Fnme:String; FStyles:TFontStyles):String;
var LogFont : TLogFont;

  Function GetOp_System : DWord;
  var OSInfo : TOsVersionInfo;
  begin
     OSInfo.dwOSVersionInfoSize:=Sizeof(OSInfo);
     GetVersionEx(OSInfo);
     Result:=OSInfo.dwPlatformId;
  end;

  Function GetFontRegPath : String;
  var OPSy : DWord;
  begin
     result:='';
     OpSy:=GetOp_System;
     case OPSy of
       VER_PLATFORM_WIN32_WINDOWS : Result:='SOFTWARE\Microsoft\Windows\CurrentVersion\Fonts';
       VER_PLATFORM_WIN32_NT : Result:='SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts';
     end;
  end;



  Function GetFileName(_FontName:String):String;
  var RegKey :String;
      OpenKeyHandle : HKey;
      VType,Len : DWord;
      Buf : array of char;
  begin
     result:='';
     RegKey:=GetFontRegPath;
     If RegKey='' then exit;

     If RegOpenKeyEx(HKEY_LOCAL_MACHINE,PChar(RegKey),0,KEY_READ,OpenkeyHandle)<>ERROR_SUCCESS then
       Exit;

     SetLength(Buf,1000);
     Len:=Length(Buf);
     If RegQueryValueEx(OpenkeyHandle,PChar(_FontName),0,@VType,PByte(Buf),@Len)<>ERROR_SUCCESS then
       Exit;

     Result:=PChar(Buf);
     SetLength(Buf,0);

     RegCloseKey(OpenkeyHandle);
  end;

  Function _EnumFontFamProc(Ipelf:PEnumLogFont; {pointer to logical font data}
                            Ipntm : PNewTextMetric; {pointer to physical font data}
                            FontType : integer; {Font type}
                            IParam : LPARAM {address of application definerd data}): LongInt;stdcall;
  var FontStyleMatch : Boolean;


  begin
     FontStyleMatch:=false;
     if (Ipntm.tmPitchAndFamily and TMPF_TRUETYPE) = 0 then
     begin      {font is nie true type}
        Result:=0;
        _TTFName:='';
     end
     else
     begin  {font is true type}
        _TTFName:=(GetFileName(String(Ipelf.elfFullName)+'(TrueType)'));
        if _TTFName='' then
           _TTFName:=(GetFileName(String(Ipelf.elfFullName)+'(True Type)'));
        if _TTFName='' then
           _TTFName:=(GetFileName(String(Ipelf.elfFullName)+' (True Type)'));
        if _TTFName='' then
           _TTFName:=(GetFileName(String(Ipelf.elfFullName)+' (TrueType)'));

        If (fsBold in _Style) and (fsItalic in _Style) then {toets Bold - Italic }
        begin
           If (Ipelf^.elfLogFont.lfWeight>=FW_BOLD) and (Ipelf^.elfLogFont.lfItalic=255) then
              FontStyleMatch:=true;
        end
        else
         {toets bold}
           if (fsBold in _Style) then
           begin
              If (Ipelf^.elfLogFont.lfWeight>=FW_BOLD) then
                FontStyleMatch:=true;
           end
           else
             {toets italic}
              if (fsItalic in _Style) then
              begin
                 If (Ipelf^.elfLogFont.lfItalic=255) then
                   FontStyleMatch:=true;
              end
              else
                 If (fsBold in _Style) and (fsItalic in _Style) then {toets Bold - Italic }
                 begin
                    If (Ipelf^.elfLogFont.lfWeight<FW_BOLD) and (Ipelf^.elfLogFont.lfItalic<>255) then
                       FontStyleMatch:=true;
                 end;
     end;
  end;

begin
   _Style := FStyles;
   EnumFontFamilies(GetDC(0),PChar(FNme),@_EnumFontFamProc,0);
   Result:=_TTFName;
end;



end.
 