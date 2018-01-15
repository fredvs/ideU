unit sak_mse;

{*******************************************************************************
*                         Speech Assistive Kit ( sak )                         *
*                  --------------------------------------                      *
*                                                                              *
*          Assistive Procedures using eSpeak and Portaudio libraries           *
*                                                                              *
*                                                                              *
*                 Fred van Stappen /  fiens@hotmail.com                        *
*                                                                              *
*                                                                              *
********************************************************************************
*  5 th release: 2015-06-04  (mse compatible)                                  *
*  4 th release: 2015-03-13  (sak_dll synchronized with sak)                   *
*  3 th release: 2015-03-04  (fpGUI focus)                                     *
*  2 th release: 2013-08-01  (use espeak executable)                           *
*  1 th release: 2013-06-15  (multi objects, multi forms)                      *
*******************************************************************************}
    {
    Copyright (C) 2013 - 2017  Fred van Stappen

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA  02110-1301  USA
    }
    
 {$mode objfpc}{$h+}

interface

uses
  msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus, msemenuwidgets, msegui,
  msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms, msetimer, msetabs,
   mseassistiveserver,mseassistiveclient, msegrids, msestrings, msesimplewidgets, msefiledialog,
  msedataedits, mseedit, msekeyboard, msefileutils, msestringcontainer,msedispwidgets,
  mseificomp, mseificompglob, mseifiglob, msestatfile, msestream, SysUtils, mseact, msesplitter,
  msegraphedits, msescrollbar, msewidgetgrid, msetoolbar,msebitmap,mseshapes, mseprocess,
  Math, Classes, Process, dynlibs
  {$IF not DEFINED(Windows)}
  , baseunix
       {$endif}  ;

(*
{$define darwin}
{$define freebsd}
{$define windows}
{$define cpu64}
{$define cpu86}
*)

type
  TSAK = class(TObject, iassistiveserver)
  protected
        
    ES_ExeFileName: filenamety;
    ES_DataDirectory: filenamety;
    ES_LibFileName: filenamety;
    PA_LibFileName: filenamety;
    SO_LibFileName: filenamety;
    
    old8087cw: word;
    mouseclicked: boolean;
    itementer: boolean;
    AProcess: TProcess;
    
    CompCount: integer;
    CheckObject: TObject;
    CheckPoint: Tpoint;
    CheckShift: TShiftState;

    voice_language: ansistring;
    voice_gender: ansistring;
    voice_speed: integer;  //-s
    voice_pitch: integer;  //-p
    voice_volume: integer;  //-a

    lastname: msestring;

  TheTimer: TTimer;
  TheTimerInit: TTimer;
  TheSender: iassistiveclient;
  ThePosition: pointty;
  TheKeyInfo: keyeventinfoty;
  TheMouseInfo: mouseeventinfoty;
  TheMenuInfo: menucellinfoarty;
  TheMenuIndex : integer;
  TheItemInfo: shapeinfoarty;

  TheWord: msestring;  // use F11 key in memo
  TheSentence: msestring;   // use F10 key in memo
  TheLastSentence: msestring;  // use F12 key in memo
  TheExtraChar: msestring;  
  TheLastCell: gridcoordty;
  TheCell: msestring;
  TheTypCell : integer;

  isfilelist : boolean;
  isgridsource : boolean;
  isblock : boolean;
    
    procedure doenter(const Sender: iassistiveclient);
    procedure doclientmouseevent(const sender: iassistiveclient; const info: mouseeventinfoty);
    procedure dochange(const sender: iassistiveclient);   
    procedure dofocuschanged(const oldwidget, newwidget: iassistiveclient);
    procedure dokeydown(const Sender: iassistiveclient; const info: keyeventinfoty);
    procedure doactionexecute(const Sender: TObject; const info: actioninfoty);
    procedure doitementer(const sender: iassistiveclient; //sender can be nil
                            const items: shapeinfoarty; const aindex: integer);
    procedure doitementer(const sender: iassistiveclient;
                         const items: menucellinfoarty; const aindex: integer);
    procedure docellevent(const sender: iassistiveclientgrid; 
                                    const info: celleventinfoty);
                                    
    procedure dodataentered(const sender: iassistiveclientdata);
                                   
  procedure doeditcharenter(const sender: iassistiveclientedit;
                                                const achar: msestring);
  procedure doeditchardelete(const sender: iassistiveclientedit;
                                                const achar: msestring);
  procedure doeditwithdrawn(const sender: iassistiveclientedit);
  procedure doeditindexmoved(const sender: iassistiveclientedit;
                                                const aindex: int32);
  procedure doeditinputmodeset(const sender: iassistiveclientedit;
                                                const amode: editinputmodety);
  procedure doedittextblock(const sender: iassistiveclientedit;
                    const amode: edittextblockmodety; const atext: msestring);
  procedure navigbordertouched(const sender: iassistiveclient;
                                       const adirection: graphicdirectionty);                                
                                    
  procedure doapplicationactivated();
  procedure doapplicationdeactivated();
 
  procedure dowindowactivated(const sender: iassistiveclient);
  procedure dowindowdeactivated(const sender: iassistiveclient);
  procedure dowindowclosed(const sender: iassistiveclient);
  procedure doactivate(const sender: iassistiveclient);
  
  procedure dodeactivate(const sender: iassistiveclient);
  procedure dodbvaluechanged(const sender: iassistiveclientdata);
  procedure dogridbordertouched(const sender: iassistiveclientgrid;
                                       const adirection: graphicdirectionty);
  
   procedure dodatasetevent(const sender: iassistiveclient; 
                const akind: assistivedbeventkindty;
                                  const adataset: pointer); //tdataset
 
 procedure dofocuschanged(const sender: iassistiveclient;
                               const oldwidget,newwidget: iassistiveclient);
                               
 procedure donavigbordertouched(const sender: iassistiveclient;
                                      const adirection: graphicdirectionty);
                                      
 procedure doactionexecute(const sender: iassistiveclient;//sender can be nil
                           const senderobj: tobject; const info: actioninfoty);                               

 procedure domenuactivated(const sender: iassistiveclientmenu);
  
 procedure doitementer(const sender: iassistiveclientmenu;//sender can be nil
                        const items: menucellinfoarty; const aindex: integer);
                         
    procedure ontimercell(const Sender: TObject);                               
    procedure ontimerkey(const Sender: TObject);
    procedure ontimermouse(const Sender: TObject);
    procedure ontimerenter(const Sender: TObject);
    procedure ontimeritementer(const Sender: TObject);
    procedure ontimeritementer2(const Sender: TObject);
    procedure ontimerchange(const Sender: TObject);
    procedure ontimerfocuschange(const Sender: TObject);
    procedure ontimergreeting(const sender: TObject);
    function LoadLib: integer;
    procedure espeak_key(Text: msestring);
    function WhatName(iaSender: iassistiveclient; novalue: boolean): msestring;
    function WhatKey(akey : keyty): msestring;
    function WhatChange(iaSender: iassistiveclient) : msestring;
    function FormatCode(acell : msestring) : msestring;
    
  public
    constructor Create();
    destructor Destroy(); override;
  end;

// The hello message
procedure SakGreeting(gret: msestring);
     
// Load with custom sakit dir
function SAKLoadLib(const SakitDir: filenamety = ''): integer;
                          //'' = default

// Load with custom espeak dir
function SAKLoadLib(const eSpeakBin: filenamety; const eSpeaklib: filenamety; const PortaudioLib: filenamety;
                                      const eSpeakDataDir: filenamety ; const sonicLib: filenamety): integer;
// Unload sak 
function SAKUnloadLib: integer;

//// to know if sak is loaded
function SakIsEnabled: boolean;

// Voice Config Procedures
function SAKSetVoice(gender: shortint; language: msestring ; speed: integer ; pitch: integer ; volume : integer ): integer;
// gender : 1 = man, 2 = woman.
// language : is the language code, for example :
// 'en' for english, 'fr' for french, 'pt' for Portugues, etc...
//           (check in /espeak-data if your language is there...)
//  speed sets the speed in words-per-minute , Range 80 to 450. The default value is 175. => -1
// pitch  range of 0 to 99. The default is 50.   => -1
// volume range of 0 to 200. The default is 100. => -1

// Start speaking the text
function SAKSay(Text: msestring): integer;

// Cancel current speak.
function SakCancel: integer;

const
  male = 1;
  female = 2;
  {$IFDEF FREEBSD}
// These are missing for FreeBSD in FPC's RTL
  S_IRWXU = S_IRUSR or S_IWUSR or S_IXUSR;
  S_IRWXG = S_IRGRP or S_IWGRP or S_IXGRP;
  S_IRWXO = S_IROTH or S_IWOTH or S_IXOTH;
{$ENDIF}

implementation

uses
  typinfo, mclasses, mseactions, mseformatstr, msegridsglob, mseimage;
  
var
  sak: TSAK;
  greeting : string = 'sak is working...' ;
  es_Handle:TLibHandle=dynlibs.NilHandle;
  pa_Handle:TLibHandle=dynlibs.NilHandle; 
  so_Handle:TLibHandle=dynlibs.NilHandle; 
  
// Load with custom espeak dir
function SAKLoadLib(const eSpeakBin: filenamety; const eSpeaklib: filenamety; const PortaudioLib: filenamety;
                                      const eSpeakDataDir: filenamety ; const sonicLib: filenamety): integer;
begin
 Result := -1;

 if sak = nil then sak:= TSAK.Create();
 if (espeakdatadir = '') or (directoryexists(tosysfilepath(eSpeakDataDir))) then
 begin
  Result:= 0;
  sak.ES_DataDirectory:= tosysfilepath(eSpeakDataDir);
 end;
 if result = 0 then
 begin
 sak.ES_ExeFileName:= tosysfilepath(eSpeakBin);
 sak.PA_LibFileName:= tosysfilepath(PortaudioLib);
 sak.ES_LibFileName:= tosysfilepath(eSpeaklib);
 sak.SO_LibFileName:= tosysfilepath(soniclib);

 Result:= sak.loadlib;
 end;
 if result <> 0 then freeandnil(sak);

end;

function SAKLoadLib(const sakitdir: filenamety = ''): integer;

function WhatFile(const sakini : filenamety = ''; what : integer = 0) : string;
// to find the file in sak.ini (what => 0 = espeak bin, 1 = portaudio lib, 2 = espeak lib, 4 = soniclib)
var
tf: textfile;
ffinded : boolean ;
dataf, whatfil : string;
len : integer;
scriptfile : string;
begin
ffinded := false;
result := '';

//writeln( 'sakini is ' + sakini);

if findfile(sakini) then
begin
 scriptfile := tosysfilepath(sakini);
  AssignFile(tf,pchar(scriptfile));
   Reset(tF);

   case what of
    0: whatfil := 'BINESPEAK=';
    1: whatfil := 'LIBPORTAUDIO=';
    2: whatfil := 'LIBESPEAK=';
    3: whatfil := 'DIRESPEAKDATA=';
    4: whatfil := 'LIBSONIC=';
     end;

  len := length(whatfil);
  
   while (eof(tf) = false) and (ffinded = false) do
     begin
       Readln(tF, dataf);
    dataf := trim(dataf);

    if  Pos(whatfil,dataf) > 0 then
   begin
    if  Pos('#',dataf) > 0 then  dataf := trim(copy(dataf,1, Pos('#',dataf)-1));
     result := copy(dataf,Pos(whatfil,dataf)+ len , length(dataf)-len);
  // writeln( 'Result is ' +  result);
    ffinded := true;
   end;
     end;
  CloseFile(tf);
end;

end;

{$IF DEFINED(unix)}
function ChangePermission(const thefile: filenamety = ''; raisemessage : boolean = true) : integer ;
var
info : stat;
begin
  result := 0;
 if (FpStat(thefile,info{%H-})<>-1) and FPS_ISREG(info.st_mode) and
             (BaseUnix.FpAccess(thefile,BaseUnix.X_OK)=0) then else
 begin
  if raisemessage = true then
  begin
  
  if askok('Permission mode of file:' +lineend+ thefile
   +lineend+ 'is not set as executable...'
    +lineend+ 'Do you want to reset it?') then begin

  fpchmod(thefile, S_IRWXU);
// => get error at compil
// sys_setfilerights(thefile,[s_irusr,s_iwusr,s_ixusr,s_irgrp,s_ixgrp, s_iroth,s_ixoth]);

   end else result := -1;
  
 end
 else result := -1;

end; 
end;

{$endif}
var
 tmp : string;
  ordir, sakini, espeakbin, espeaklib, portaudiolib, soniclib, espeakdatadir : filenamety;
const
sakininame = 'sak.ini';

{$ifdef mswindows}
 espeaklibdir = 'libwin32';
 espeakdefault = 'espeak.exe';
{$else}
 espeakdefault = 'espeak';
{$endif}

{$if defined(linux) and  defined(cpu64)}
 espeaklibdir = 'liblinux64';
{$endif}
{$if defined(linux) and defined(cpu86) }
 espeaklibdir = 'liblinux32';
{$endif}
{$if defined(linux) and defined(cpuarm) }
 espeaklibdir = 'libarmrpi';
{$endif}
{$if defined(freebsd) and  defined(cpu64)}
 espeaklibdir = 'libfreebsd64';
{$endif}
{$if defined(freebsd) and defined(cpu86) } 
 espeaklibdir = 'libfreebsd32';
 {$endif}
{$ifdef darwin}
 espeaklibdir = 'libmac32';
{$endif}

begin
 Result := -1;
 espeakdatadir:= '';
 if sakitdir = '' then begin
  ordir:= IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
 end
 else begin
  ordir:= sakitdir;
 end;

sakini := ordir + sakininame;
 espeakbin:= ordir + WhatFile(sakini,0);

 tmp := WhatFile(sakini,1);
 if tmp <> '' then
 portaudiolib:= ordir + tmp else  portaudiolib:= '';

 espeaklib:= ordir + WhatFile(sakini,2);

 tmp := WhatFile(sakini,2);
 if tmp <> '' then
 espeaklib:= ordir + tmp else  espeaklib:= '';

tmp := WhatFile(sakini,3);
 if (tmp = '/') or (tmp = './') then
 espeakdatadir:= ordir else 
if tmp = '../' then
 espeakdatadir:= ExtractFilePath(ordir)
else 
 espeakdatadir:= tmp ;
 
 tmp := WhatFile(sakini,4);
 if tmp <> '' then
 soniclib:= ordir + tmp else  soniclib:= '';

   if (finddir(espeakdatadir)) and (findfile(espeakbin)) and (findfile(sakini)) and ((findfile(portaudiolib)) or (portaudiolib = ''))
 and ((findfile(espeaklib)) or (espeaklib = '')) and ((findfile(soniclib)) or (soniclib = ''))
 then
  begin
   Result:= 0;
   espeakdatadir:= ordir ;
   {$ifdef unix}
 result := ChangePermission(espeakbin,true);
   {$endif}
  end
 else begin
  sakini:= ordir +  directoryseparator +'sakit' + directoryseparator +
  espeaklibdir + directoryseparator + sakininame;

  espeakbin:= ordir + directoryseparator + 'sakit' + directoryseparator +
  espeaklibdir+ directoryseparator + WhatFile(sakini, 0);

  tmp := WhatFile(sakini,1);
 if tmp <> '' then
  portaudiolib:= ordir + directoryseparator + 'sakit' + directoryseparator +
  espeaklibdir+ directoryseparator + tmp else  portaudiolib:= '';

 tmp := WhatFile(sakini,2);
 if tmp <> '' then
 espeaklib:= ordir + directoryseparator + 'sakit' + directoryseparator +
  espeaklibdir+ directoryseparator + tmp else  espeaklib:= '';

 tmp := WhatFile(sakini,3);
 if (tmp = '/') or (tmp = './') then
 espeakdatadir:= ordir + directoryseparator + 'sakit' + directoryseparator +
  espeaklibdir+ directoryseparator else 
if tmp = '../' then
 espeakdatadir:= ordir + directoryseparator + 'sakit' + directoryseparator
else 
 espeakdatadir:= tmp ;
 
 tmp := WhatFile(sakini,4);
 if tmp <> '' then
 soniclib:= ordir + directoryseparator + 'sakit' + directoryseparator +
  espeaklibdir+ directoryseparator + tmp else  soniclib:= '';

   if (finddir(espeakdatadir)) and (findfile(espeakbin)) and (findfile(sakini)) and ((findfile(portaudiolib)) or (portaudiolib = ''))
   and ((findfile(espeaklib)) or (espeaklib = '')) and ((findfile(soniclib)) or (soniclib = ''))  then
 begin
    Result:= 0;
        {$ifdef unix}
  result := ChangePermission(espeakbin,true);
    {$endif}
   end
  else begin
{$ifdef unix}
  if (fileexists('/usr/bin/'+espeakdefault)) then begin
  espeakbin:= '/usr/bin/'+espeakdefault;
 result := 0;
end else
 if
 (fileexists('/usr/local/bin/'+espeakdefault)) then
begin
  espeakbin:= '/usr/local/bin/'+espeakdefault;
result := 0;
end;
 {$endif}

{$ifdef windows}
  if (fileexists('c:\Program Files (x86)\eSpeak\command_line\'+espeakdefault)) then
begin
  espeakbin:= 'c:\Program Files (x86)\eSpeak\command_line\'+espeakdefault;
 result := 0;
end else
 if
 (fileexists('c:\Program Files\eSpeak\command_line\'+espeakdefault)) then
begin
  espeakbin:= 'c:\Program Files\eSpeak\command_line\'+espeakdefault;
result := 0;
end;
 {$endif}

espeakdatadir:= '';
portaudiolib:= '' ;

end;
 end;
 
 if result = 0 then begin
  result:= sakloadlib(espeakbin,espeaklib,portaudiolib,espeakdatadir,soniclib);
 end;
end;

function SAKUnLoadLib: integer;
begin
 result:= -1;
 if assigned(sak) then begin
   SakCancel;
  result:= 0;
  freeandnil(sak.thetimer);
  freeandnil(sak.AProcess);
  freeandnil(sak);
  
  if pa_Handle <> dynlibs.NilHandle then
  begin
  DynLibs.UnloadLibrary(pa_Handle);
    pa_Handle:=DynLibs.NilHandle;
  end; 
  
   if es_Handle <> dynlibs.NilHandle then
  begin
  DynLibs.UnloadLibrary(es_Handle);
    es_Handle:=DynLibs.NilHandle;
  end; 
  
   if so_Handle <> dynlibs.NilHandle then
  begin
  DynLibs.UnloadLibrary(so_Handle);
    so_Handle:=DynLibs.NilHandle;
  end;  
    
 end;
end;

 
// Capture Assistive Procedures

function TSak.WhatKey(akey : keyty): msestring;
var
keyname : msestring = '' ;
 begin
      case akey of
        key_none : keyname := 'none'; 
        key_Space : keyname := 'Space';               
        key_Exclam : keyname := 'Exclam'; 
        key_QuoteDbl : keyname := 'Quote Dbl'; 
        key_NumberSign : keyname := 'NumberSign'; 
        key_Dollar : keyname := 'Dollar'; 
        key_Percent : keyname := 'Percent'; 
        key_Ampersand : keyname := 'Ampersand'; 
        key_Apostrophe : keyname := 'Apostrophe'; 
        key_ParenLeft : keyname := 'Parenthese Left'; 
        key_ParenRight : keyname := 'Parenthese Right'; 
        key_Asterisk : keyname := 'Asterisk'; 
        key_Plus : keyname := 'Plus'; 
        key_Comma : keyname := 'Comma'; 
        key_Minus : keyname := 'Minus'; 
        key_Period : keyname := 'Period'; 
        key_Slash : keyname := 'Slash'; 
        key_Colon : keyname := 'Colon'; 
        key_Semicolon : keyname := 'Semicolon'; 
        key_Less : keyname := 'Less'; 
        key_Equal : keyname := 'Equal'; 
        key_Greater : keyname := 'Greater'; 
        key_Question : keyname := 'Question'; 
        key_At : keyname := 'At'; 
        key_BracketLeft : keyname := 'Bracket Left';
        key_Backslash : keyname := 'Backslash'; 
        key_BracketRight : keyname := 'Bracket Right';
        key_AsciiCircum : keyname := 'Ascii Circum';
        key_Underscore : keyname := 'Underscore'; 
        key_QuoteLeft : keyname := 'Quote Left'; 
        key_BraceLeft : keyname := 'Brace Left'; 
        key_Bar : keyname := 'Bar';  
        key_BraceRight : keyname := 'Brace Right'; 
        key_AsciiTilde : keyname := 'Ascii Tilde'; 
        key_nobreakspace : keyname := 'no breakspace';
        key_exclamdown : keyname := 'exclam down'; 
        key_cent : keyname := 'cent'; 
        key_sterling : keyname := 'sterling'; 
        key_currency : keyname := 'currency'; 
        key_yen : keyname := 'yen';  
        key_brokenbar : keyname := 'brokenbar'; 
        key_section : keyname := 'section'; 
        key_diaeresis : keyname := 'diaeresis'; 
        key_copyright : keyname := 'copyright'; 
        key_ordfeminine : keyname := 'ordfeminine';
        key_guillemotleft : keyname := 'guillemot left';       
        key_notsign : keyname := 'not sign'; 
        key_hyphen : keyname := 'hyphen'; 
        key_registered : keyname := 'registered'; 
        key_macron : keyname := 'macron'; 
        key_degree : keyname := 'degree'; 
        key_plusminus : keyname := 'plus minus'; 
        key_twosuperior : keyname := 'two superior';
        key_threesuperior : keyname := 'three superior'; 
        key_acute : keyname := 'acute'; 
        key_mu : keyname := 'mu'; 
        key_paragraph : keyname := 'paragraph'; 
        key_periodcentered : keyname := 'period centered'; 
        key_cedilla : keyname := 'cedilla'; 
        key_onesuperior : keyname := 'one superior';
        key_masculine : keyname := 'masculine'; 
        key_guillemotright : keyname := 'guillemot right';    
        key_onequarter : keyname := 'one quarter'; 
        key_onehalf : keyname := 'one half'; 
        key_threequarters : keyname := 'three quarters'; 
        key_questiondown : keyname := 'question down';
        key_Agrave : keyname := 'A grave'; 
        key_Aacute : keyname := 'A acute'; 
        key_Acircumflex : keyname := 'A circumflex';
        key_Atilde : keyname := 'A tilde'; 
        key_Adiaeresis : keyname := 'A diaeresis'; 
        key_Aring : keyname := 'A ring'; 
        key_AE : keyname := 'AE'; 
        key_Ccedilla : keyname := 'C cedilla'; 
        key_Egrave : keyname := 'E grave'; 
        key_Eacute : keyname := 'E acute'; 
        key_Ecircumflex : keyname := 'E circumflex';
        key_Ediaeresis : keyname := 'E diaeresis'; 
        key_Igrave : keyname := 'I grave'; 
        key_Iacute : keyname := 'I acute'; 
        key_Icircumflex : keyname := 'I circumflex';
        key_Idiaeresis : keyname := 'I diaeresis'; 
        key_ETH : keyname := 'ETH'; 
        key_Escape : keyname := 'Escape';            
        key_Tab : keyname := 'Tab'; 
        key_Backtab : keyname := 'Backtab'; 
        key_Backspace : keyname := 'Backspace'; 
        key_Return : keyname := 'Return'; 
        key_Insert : keyname := 'Insert'; 
        key_Delete : keyname := 'Delete'; 
        key_Pause : keyname := 'Pause'; 
        key_Print : keyname := 'Print'; 
        key_SysReq : keyname := 'SysReq'; 
        key_Home : keyname := 'Home';               
        key_End : keyname := 'End'; 
        key_Left : keyname := 'Left'; 
        key_Up : keyname := 'Up'; 
        key_Right : keyname := 'Right'; 
        key_Down : keyname := 'Down'; 
        key_Prior : keyname := 'Prior'; 
        key_Next : keyname := 'Next'; 
        key_clear : keyname := 'clear'; 
        key_decimal : keyname := 'decimal'; 
        key_Shift : keyname := 'Shift';            
        key_Control : keyname := 'Control'; 
        key_Meta : keyname := 'Meta'; 
        key_Alt : keyname := 'Alt'; 
        key_CapsLock : keyname := 'Caps Lock'; 
        key_NumLock : keyname := 'Num Lock'; 
        key_ScrollLock : keyname := 'Scroll Lock'; 
        key_AltGr : keyname := 'Alt Gr'; 
        key_F1 : keyname := 'F1';              
        key_F2 : keyname := 'F2'; 
        key_F3 : keyname := 'F3'; 
        key_F4 : keyname := 'F4'; 
        key_F5 : keyname := 'F5'; 
        key_F6 : keyname := 'F6'; 
        key_F7 : keyname := 'F7'; 
        key_F8 : keyname := 'F8'; 
        key_F9 : keyname := 'F9'; 
        key_F10 : keyname := 'F10'; 
        key_F11 : keyname := 'F11'; 
        key_F12 : keyname := 'F12'; 
        key_F13 : keyname := 'F13'; 
        key_F14 : keyname := 'F14'; 
        key_F15 : keyname := 'F15'; 
        key_F16 : keyname := 'F16'; 
        key_F17 : keyname := 'F17'; 
        key_F18 : keyname := 'F18'; 
        key_F19 : keyname := 'F19'; 
        key_F20 : keyname := 'F20'; 
        key_Super : keyname := 'Super';          
        key_Menu : keyname := 'Menu'; 
        key_Hyper : keyname := 'Hyper'; 
        key_Help : keyname := 'Help'; 
        key_unknown : keyname := 'unknown'; 
   end;
 result := keyname;
end;

function TSak.WhatName(iaSender: iassistiveclient; novalue: boolean): msestring;
    
var
Sender : Tobject;
tempstr : msestring;
begin
Result := '';

 if assigned(iaSender) then 
 begin

Sender := iaSender.getinstance;

   if (Sender is TSplitter) then
     else
  if (Sender is TLabel) then
    Result := 'label, ' + TLabel(Sender).Caption
  else
  if (Sender is TButton) then
  begin
    if (trim(TButton(Sender).Caption) <> '') then
      Result := 'button, ' + TButton(Sender).Caption
    else
    if (trim(TButton(Sender).Name) <> '') then
      Result := 'button, ' + TButton(Sender).Name
    else
    if (trim(TButton(Sender).hint) <> '') then
      Result := 'button, ' + TButton(Sender).hint;
  end
  else
  if (Sender is tfilelistview) then
 begin
 if assigned(tfilelistview(Sender).selectednames) then
    Result := 'file list, ' + tfilelistview(Sender).name + ' , ' + tfilelistview(Sender).selectednames[0]
 else Result := 'file list, ' + tfilelistview(Sender).name ;
  end else
   if (Sender is thistoryedit) then
  begin
   if trim(thistoryedit(Sender).hint) = '' then 
    Result := 'edit , ' + thistoryedit(Sender).name + ' , ' + formatcode(thistoryedit(Sender).value) else
    Result := 'edit , ' + thistoryedit(Sender).name  +' , ' + thistoryedit(Sender).hint +  c_linefeed +
    ' The value, is: ' +  c_linefeed + formatcode(thistoryedit(Sender).value)
  end else
  if (Sender is tfilenameedit) then
  begin
   if trim(tfilenameedit(Sender).hint) = '' then 
    Result := 'filename edit, ' + tfilenameedit(Sender).name + ' , ' + formatcode(tfilenameedit(Sender).value) else
    Result := 'filename edit, ' + tfilenameedit(Sender).name + 
    ' , ' + tfilenameedit(Sender).hint +  c_linefeed+
    ' The value, is: ' +  c_linefeed + formatcode(tfilenameedit(Sender).value)
  end else
  if (Sender is tdirdropdownedit) then
  begin
  if trim(tdirdropdownedit(Sender).hint) = '' then 
    Result := 'directory edit, ' + tdirdropdownedit(Sender).name + ' , ' +
     formatcode(tdirdropdownedit(Sender).value)
  else  Result := 'directory edit, ' + tdirdropdownedit(Sender).name + ' , ' +
   tdirdropdownedit(Sender).hint +  c_linefeed +
    ' The value, is: ' +  c_linefeed + formatcode(tdirdropdownedit(Sender).value)
 end
 else
 if (Sender is TStringEdit) then
  begin
  if trim(TStringEdit(Sender).hint) = '' then 
   Result := ' ' + TStringEdit(Sender).name + ' , ' + TStringEdit(Sender).value 
    else  Result := ' ' + TStringEdit(Sender).name + ' , ' +
   TStringEdit(Sender).hint +  c_linefeed +
    ' The value, is: ' +  c_linefeed + TStringEdit(Sender).text
// Result := iaSender.getassistivename() + ' , ' +  iaSender.getassistivecaption() + 
// ' , ' +  iaSender.getassistivetext() +  ' , ';
 end
  else
  if (Sender is tdropdownlistedit) then
    Result := 'combobox, ' + tdropdownlistedit(Sender).name + ' , ' + tdropdownlistedit(Sender).value
  else
  if (Sender is tdatetimeedit) then
    Result := 'date edit, ' + tdatetimeedit(Sender).Name + ' , ' + datetostr(tdatetimeedit(Sender).value)
    + ' , ' + timetostr(tdatetimeedit(Sender).value)
  else
  if (Sender is trealedit) then
    Result := 'real edit, ' + trealedit(Sender).Name + ' , ' + floattostr(trealedit(Sender).value) 
  else
  if (Sender is tintegeredit) then
    Result := 'integer edit, ' + tintegeredit(Sender).Name + ' , ' + inttostr(tintegeredit(Sender).value)
  else
  if (Sender is TMemoEdit) then
    Result := 'memo, ' + TMemoEdit(Sender).Name + ' , ' + TMemoEdit(Sender).value
  else
  if (Sender is Twidgetgrid) then
    Result := 'page, ' + Twidgetgrid(Sender).Name
  else
   if (Sender is Tstringgrid) then
    Result := 'grid, ' + Tstringgrid(Sender).Name
  else
  
    if (Sender is ttabpage) then
    Result := 'tab, page, ' + ttabpage(Sender).caption
  else
  if (Sender is ttab) then
    Result := 'tab, ' + ttab(Sender).caption
  else
   if (Sender is Ttabwidget) then  
   Result := 'tabwidget, ' + Ttabwidget(Sender).Name + ' , active index, ' + 
   inttostr(Ttabwidget(Sender).activepageindex)
  else
    if (Sender is Ttabbar) then  
    Result := 'tabbar, ' + Ttabbar(Sender).name + ', ' + 
   Ttabbar(Sender).tabs[ttabbar(Sender).activetab].caption
    else
   if (Sender is tcustomtabbar) then  
  Result := 'tab, ' + tcustomtabbar(Sender).tabs[tcustomtabbar(Sender).activetab].caption
  else
  if (Sender is tcustomtabbar1) then  
  Result := 'tab, ' + tcustomtabbar1(Sender).tabs[tcustomtabbar1(Sender).activetab].caption
    else
   if (Sender is Tstringdisp) then
    Result := 'Info panel, ' + Tstringdisp(Sender).value 
   else
   if (Sender is Tdatetimedisp) then
    Result := 'Date panel, ' + Tdatetimedisp(Sender).name
   else
   if (Sender is tbooleandisp) then
    Result := 'Boolean panel, ' + tbooleandisp(Sender).name 
   else
   if (Sender is trealdisp) then
    Result := 'real panel, ' + trealdisp(Sender).name
   else
   if (Sender is tintegerdisp) then
    Result := 'Integer panel, ' + tintegerdisp(Sender).name 
   else
    if (Sender is tstockglyphbutton) then
    Result := 'button, ' + tstockglyphbutton(Sender).name
   else
    if (Sender is Tenumedit) then  
   Result := 'combo box, ' + Tenumedit(Sender).Name + ' , ' + inttostr(Tenumedit(Sender).value)
   else
   if (Sender is timage) then
  begin
      if (trim(timage(Sender).hint) <> '') then
      Result := 'image, ' + timage(Sender).hint 
      else
      Result := 'image, ' + Timage(Sender).Name;
  end
  else
    if (Sender is tdockform) then
  begin
      if (trim(tdockform(Sender).caption) <> '') then
      Result := 'form, ' + tdockform(Sender).caption 
      else
      Result := 'form, ' + tdockform(Sender).Name;
  end
  else
    if (Sender is tmseform) then
  begin
      if (trim(tmseform(Sender).caption) <> '') then
      Result := 'form, ' + tmseform(Sender).caption 
      else
      Result := 'form, ' + tmseform(Sender).Name;
  end
  else
   if (Sender is tbooleaneditradio) then
  begin
  
  if novalue = false then
  begin
  if tbooleaneditradio(Sender).value = true then
   tempstr := 'true' else tempstr := 'false' ;
  end;
  
  if assigned(Tbooleaneditradio(Sender).frame) then
  begin
   if (trim(Tbooleaneditradio(Sender).frame.Caption) <> '') then
     Result := 'radio button, ' + Tbooleaneditradio(Sender).frame.Caption +
      ' , ' + tempstr
  else
   if (Tbooleaneditradio(Sender).hint <> '') then
    Result := 'radio button, ' + Tbooleaneditradio(Sender).hint +
      ' , ' + tempstr
    else
     Result := 'radio button, ' + Tbooleaneditradio(Sender).Name +
      ' , ' + tempstr;
   end else
   if (Tbooleaneditradio(Sender).hint <> '') then
    Result := 'radio button, ' + Tbooleaneditradio(Sender).hint +
      ' , ' + tempstr 
    else
     Result := 'radio button, ' + Tbooleaneditradio(Sender).Name +
      ' , ' + tempstr;
    end
    else if (Sender is tgroupbox) then
    begin
     if assigned(tgroupbox(Sender).frame) then
   begin
    if (trim(tgroupbox(Sender).frame.Caption) <> '') then
      Result := 'groupbox, ' + tgroupbox(Sender).frame.Caption +
      ' , ' + tempstr
     else
      Result := 'groupbox, ' + tgroupbox(Sender).Name +
      ' , ' + tempstr;
   end else
      Result := 'checkbox, ' + tgroupbox(Sender).Name +
      ' , ' + tempstr;
    end
   else if (Sender is tbooleanedit) then
  begin
   if novalue = false then
  begin
  if Tbooleanedit(Sender).value = true then
   tempstr := 'true' else tempstr := 'false' ;
  end;
  
   if assigned(Tbooleanedit(Sender).frame) then
   begin
    if (trim(Tbooleanedit(Sender).frame.Caption) <> '') then
      Result := 'checkbox, ' + Tbooleanedit(Sender).frame.Caption +
      ' , ' + tempstr
     else
    if (Tbooleanedit(Sender).hint <> '') then
      Result := 'checkbox, ' + Tbooleanedit(Sender).hint +
      ' , ' + tempstr
    else
      Result := 'checkbox, ' + Tbooleanedit(Sender).Name +
      ' , ' + tempstr;
   end else if (Tbooleanedit(Sender).hint <> '') then
      Result := 'checkbox, ' + Tbooleanedit(Sender).hint +
      ' , ' + tempstr
    else
      Result := 'checkbox, ' + Tbooleanedit(Sender).Name +
      ' , ' + tempstr;
    end
   else
     if (Sender is ttoolbar) then
     Result := 'tool bar, ' + iaSender.getassistivehint()
  else
  if (Sender is tslider) then
    Result := 'slider, ' + Tslider(Sender).Name
  else 
  if (Sender is ttoolbutton) then
    Result := 'tool button, ' +  ttoolbutton(Sender).hint
  else 
   if (Sender is tmenuitem) then
  begin
    if (tmenuitem(Sender).Caption <> '') then
      Result := 'menu item , ' + tmenuitem(Sender).Caption
    else
      Result := 'menu item , ' + tmenuitem(Sender).Name;
  end
  else 
  if (Sender is tmainmenu) or (Sender is tmainmenuwidget) or (Sender is tmenu) or  (Sender is tcustommenu) or   (Sender is tpopupmenu)  then
     Result :=  'menu, '
  else
   if (Sender is tmessagewidget) then Result := 
     'message, ' +
   
   iaSender.getassistivename() + ' , ' +  iaSender.getassistivecaption() + 
 ' , ' +  iaSender.getassistivetext() +  ' , '
     ;
     
 // else if (trim(iaSender.getassistivename()) <> '') then Result := iaSender.getassistivename() + ' , ' +  iaSender.getassistivecaption() + 
 //' , ' +  iaSender.getassistivetext() +  ' , ';
 
 //else  if (Sender is twidget) then Result := Sender.classname() + ', ' + Twidget(Sender).Name + ', ' ;
    
end;
end; 

function TSak.WhatChange(iaSender: iassistiveclient) : msestring;
var
Sender : Tobject;
stringtemp : msestring;
begin

result := '';

if assigned(iaSender) then begin

sender := iaSender.getinstance;

if (Sender is tbooleaneditradio) then
  begin
  if tbooleaneditradio(sender).value = false then stringtemp := 'false' else stringtemp := 'true';
       Result := ' changed to ' + stringtemp ;
   end
  else
  if (Sender is tbooleanedit) then
  begin
   if tbooleanedit(sender).value = false then stringtemp := 'false' else stringtemp := 'true';
      Result := ' changed to ' + stringtemp ;
  end
   else
  if (sender is thistoryedit) then 
  begin
  result:= ' changed to ' + (thistoryedit(sender).value);
  end
  else
  if (sender is tdirdropdownedit) then 
  begin
  result:= ' changed to ' + (tdirdropdownedit(sender).value);
  end
  else
    if (sender is tenumedit) then 
  begin
  result:= ' changed to ' + (tenumedit(sender).enumname(tenumedit(sender).value));
  end
  else
   if (Sender is tslider) then
    Result := ' changed position to ' + inttostr(round(tslider(sender).value * 100)) + ' ,%' ;
   end;
end;

procedure TSAK.ontimerchange(const sender: TObject);
begin
thetimer.enabled := false;
 SakCancel;
 espeak_Key(WhatName(TheSender,true) + WhatChange(TheSender));
end;

procedure TSAK.dochange(const sender: iassistiveclient);
begin
if assigned(Sender) then
if (WhatName(sender, true) <> '') and  (isblock = false) then
 begin
  thetimer.enabled := false;  
  TheSender := sender;  
  thetimer.interval := 800000 ;
  thetimer.ontimer := @ontimerchange;
  thetimer.enabled := true;
 end;
end; 

// not yet used

procedure TSAK.dodataentered(const sender: iassistiveclientdata);
  begin
  end;
                                   
  procedure TSAK.doeditcharenter(const sender: iassistiveclientedit;
                                                const achar: msestring);
  begin
  end;                                              
  procedure TSAK.doeditchardelete(const sender: iassistiveclientedit;
                                                const achar: msestring);
  begin
  end;
  procedure TSAK.doeditwithdrawn(const sender: iassistiveclientedit);
  begin
  end;
  procedure TSAK.doeditindexmoved(const sender: iassistiveclientedit;
                                                const aindex: int32);
  begin
  end;
  procedure TSAK.doeditinputmodeset(const sender: iassistiveclientedit;
                                                const amode: editinputmodety);
  begin
  end;
  procedure TSAK.doedittextblock(const sender: iassistiveclientedit;
                    const amode: edittextblockmodety; const atext: msestring);
  begin
  end;
  procedure TSAK.navigbordertouched(const sender: iassistiveclient;
                                       const adirection: graphicdirectionty);
  begin
  end;
  
   procedure TSAK.doapplicationactivated();
  begin
  end;
  
  procedure TSAK.doapplicationdeactivated();
  begin
  end;
  
  procedure TSAK.dowindowactivated(const sender: iassistiveclient);
  begin
  end;
  
  procedure TSAK.dowindowdeactivated(const sender: iassistiveclient);
  begin
  end;
  
  procedure TSAK.dowindowclosed(const sender: iassistiveclient);
  begin
  end;
  
  procedure TSAK.doactivate(const sender: iassistiveclient);
  begin
  end;
  
   procedure TSAK.dofocuschanged(const sender: iassistiveclient;
                               const oldwidget,newwidget: iassistiveclient);
   begin
  end;
                              
 procedure TSAK.donavigbordertouched(const sender: iassistiveclient;
                                      const adirection: graphicdirectionty);
   begin
  end;
                                     
 procedure TSAK.doactionexecute(const sender: iassistiveclient;//sender can be nil
                           const senderobj: tobject; const info: actioninfoty);                               
   begin
  end;
  
 procedure TSAK.domenuactivated(const sender: iassistiveclientmenu);
  begin
  end;
  
 procedure TSAK.doitementer(const sender: iassistiveclientmenu;//sender can be nil
                        const items: menucellinfoarty; const aindex: integer);
  
 begin
  end;
  
procedure TSAK.dodeactivate(const sender: iassistiveclient);
begin
  end;
  
   procedure TSAK.dodbvaluechanged(const sender: iassistiveclientdata);
  begin
  end;
  
  procedure TSAK.dogridbordertouched(const sender: iassistiveclientgrid;
                                       const adirection: graphicdirectionty);  
  begin
  end;
  
   procedure TSAK.dodatasetevent(const sender: iassistiveclient; 
                const akind: assistivedbeventkindty;
                                  const adataset: pointer); //tdataset
   begin
  end;
  
procedure TSAK.ontimergreeting(const sender: TObject);
begin
thetimerinit.enabled := false;
 isblock := false;
thetimerinit.free();
end;

procedure TSAK.ontimerenter(const Sender: TObject);
begin
  thetimer.Enabled := False;
  SakCancel;
  if (TheSender.getinstance is tmessagewidget) then
  espeak_Key(WhatName(TheSender,false) + ', press enter to quit.' )
  else  espeak_Key('selected, ' + WhatName(TheSender,false) ) ;
end;

procedure TSAK.doenter(const Sender: iassistiveclient);
begin
if assigned(Sender) then
  if (WhatName(Sender,false) <> '') and  (isblock = false) then
  begin
    thetimer.Enabled := False;
    TheSender := Sender;
    thetimer.interval := 1000000;
    thetimer.ontimer := @ontimerenter;
    thetimer.Enabled := True;
  end;
end;

procedure TSAK.ontimerkey(const Sender: TObject);
var
 oldlang : msestring;
  oldspeed, oldgender ,oldpitch, oldvolume : integer;
begin
thetimer.Enabled := False;  
SakCancel;
   
if TheTypCell = 1 then begin

   oldlang := voice_language;
      if voice_gender = '' then
    oldgender := -1 else
     if voice_gender = 'm3' then
    oldgender := 1 else
     oldgender := 2 ;
  oldspeed := voice_speed;
  oldpitch := voice_pitch;
  oldvolume := voice_volume;

  SAKSetVoice(2,'',150,-1,-1);
  espeak_Key(TheCell);
   SAKSetVoice(oldgender,oldlang,oldspeed,oldpitch,oldvolume);
   
 end else espeak_Key(thecell);
  
end;

procedure TSAK.dokeydown(const Sender: iassistiveclient; const info: keyeventinfoty);
var
  WhatCh : msestring;
  oldlang : msestring;
  oldspeed, oldgender ,oldpitch, oldvolume : integer;
 begin
 if (assigned(Sender)) and
  (isblock = false) then
  begin
   oldlang := voice_language;
      if voice_gender = '' then
    oldgender := -1 else
     if voice_gender = 'm3' then
    oldgender := 1 else
     oldgender := 2 ;
  oldspeed := voice_speed;
  oldpitch := voice_pitch;
  oldvolume := voice_volume;
  TheTypCell := 0 ;
  WhatCh := info.chars;
  TheExtraChar := WhatKey(info.key) ;
    
 if (itementer = true) then
  begin
  SAKSetVoice(2,'',150,-1,-1);
  SakCancel;
 if TheExtraChar <> '' then  espeak_Key(TheExtraChar)
 else espeak_Key(WhatCh) ;
 SAKSetVoice(oldgender,oldlang,oldspeed,oldpitch,oldvolume);
 itementer := false;
 end else
  begin
   thetimer.Enabled := False;
   thetimer.ontimer := @ontimerkey;
         
  if (TheExtraChar <> '') or (WhatCh = '.') then begin
  SakCancel;
  SAKSetVoice(2,'',150,-1,-1);
  if WhatCh = '.' then espeak_Key('point') else
 espeak_Key(TheExtraChar) ;
  SAKSetVoice(oldgender,oldlang,oldspeed,oldpitch,oldvolume);
 end; 
      
 if (Sender.getinstance is Tstringedit) or (Sender.getinstance is Tmemoedit)
  or (Sender.getinstance is tdirdropdownedit) or (Sender.getinstance is thistoryedit) 
  or (Sender.getinstance is TStringEdit) or (Sender.getinstance is tfilenameedit) then  
  begin 
  if info.key = key_f12 then
  begin
  thetimer.ontimer := @ontimercell;
   thetimer.Interval := 800000 ;
   
   if (Sender.getinstance is Tmemoedit) then
   TheCell := Tmemoedit(Sender.getinstance).text;
   
    if (Sender.getinstance is Tstringedit) then
   TheCell := Tstringedit(Sender.getinstance).text;
   TheTypCell := 1 ;
   thetimer.enabled := true;
  end else
  
  if (info.key = key_Space) or (info.key = key_f4) then
   begin
   thetimer.ontimer := @ontimercell;
   thetimer.Interval := 700000 ;
   TheCell := Theword;
   TheTypCell := 1 ;
   thetimer.enabled := true;
   TheSentence := TheSentence + ' ' + TheWord;
   Theword := '';
   end else
   if (WhatCh = '.') or (WhatCh = '?') or (WhatCh = '!') then
   begin
   thetimer.ontimer := @ontimercell;
   thetimer.Interval := 800000 ;
   TheCell := Theword + ', ' + TheSentence + Theword;
   TheTypCell := 1 ;
   thetimer.enabled := true;
   TheLastSentence := TheSentence + ' ' + Theword ;
   TheSentence := '';
   Theword := '';
   thetimer.enabled := true;
   end
   else
   begin
   if (TheExtraChar = '') and (WhatCh <> '.') then
   begin
   TheTypCell := 0 ;
   TheCell := info.chars;
   thetimer.Interval := 100000 ;
   Theword := Theword + info.chars;
   thetimer.Enabled := True;
   end;
   end;
   end else
   begin
   if (Sender.getinstance is Tcustomstringgrid) or (Sender.getinstance is Tstringgrid)  then
   begin
       itementer := false;
      if TheExtraChar = '' then
        begin 
       TheCell := info.chars;  
       TheTypCell := 0 ;
       thetimer.Interval := 100000 ;
       thetimer.Enabled := True;
        end;
     end   
    else
         begin
    if (TheExtraChar = '') and (WhatCh <> '.') 
      then begin 
     itementer := false; 
     TheTypCell := 0 ;
     TheCell := info.chars; 
     thetimer.interval := 100000 ; 
     thetimer.Enabled := True;
    end;
    end;
  end;
 end;
 end;
 end;

procedure TSAK.ontimermouse(const Sender: TObject);
var
stringtemp : msestring = '' ;

begin
  thetimer.Enabled := False;

 if (TheMouseinfo.eventkind = ek_mousemove)  then
  begin

if WhatName(TheSender, true)  <> lastname then
    begin
      SakCancel;
    
      if(TheSender.getinstance is tbooleaneditradio) then
  begin
  if tbooleaneditradio(TheSender.getinstance).value = false then stringtemp := ' , false, ' else stringtemp := ' , true, ';
  end;
  
    if(TheSender.getinstance is tbooleanedit) then
  begin
  if tbooleanedit(TheSender.getinstance).value = false then stringtemp := ' , false, ' else stringtemp := ' , true, '; 
  end;
 
     if(TheSender.getinstance is tslider) then
  begin
  stringtemp := ' , ' + inttostr(round(tslider(TheSender.getinstance).value * 100)) + ' ,%, '
  end;
  
       espeak_Key('left  ' +inttostr(twidget(TheSender.getinstance).left+ TheMouseinfo.pos.x) + ' , top '+ 
         inttostr(twidget(TheSender.getinstance).top + TheMouseinfo.pos.y) + ' , focused ,  '+ 
        WhatName(TheSender, true) + stringtemp );
      lastname := WhatName(TheSender, true);
    end;
  end
  else
  if (TheMouseinfo.eventkind = ek_buttonpress) then
  begin
    SakCancel;
    espeak_Key( 'clicked  , ' + WhatName(TheSender, false) );
    lastname := WhatName(TheSender, false);
  end;

end;

procedure TSAK.doclientmouseevent(const sender: iassistiveclient;
                                           const info: mouseeventinfoty);
 begin
 if (assigned(Sender)) then
  if (WhatName(Sender, false) <> '') and  (isblock = false) then
  begin
    TheSender := Sender;
    TheMouseInfo := info;
    thetimer.Enabled := False;
    if info.eventkind = ek_mousemove then
    thetimer.interval := 60000 else
    thetimer.interval := 6000 ;
    thetimer.ontimer := @ontimermouse;
    thetimer.Enabled := True;
  end;
 end;

procedure TSAK.ontimerfocuschange(const Sender: TObject);
begin
//{
 thetimer.Enabled := false;
 SakCancel;
 // espeak_Key('a tab has the new focus');
  espeak_Key('selected, ' + WhatName(TheSender, false));
 // lastname := WhatName(TheSender);
  isblock := false;
// }
end;

procedure TSAK.dofocuschanged(const oldwidget: iassistiveclient; const newwidget: iassistiveclient);
begin
//{
if (assigned(newwidget)) then
if (WhatName(newwidget,false) <> '') 
//  and (lastname <> WhatName(newwidget))
 // and not (newwidget.getinstance is ttabwidget) 
 //  (newwidget.getinstance is Ttab)
 then
 begin
    thetimer.Enabled := False; 
  // SakCancel;
   
   // espeak_Key(WhatName(newwidget) + ' has the newfocus');
 //   lastname := WhatName(newwidget);
 //isentered := True;
   TheSender := newwidget;
   thetimer.interval := 700000;
   thetimer.ontimer := @ontimerfocuschange;
   thetimer.Enabled := True;
   isblock := true;
  //  itementer:= true;
 end;
//}

end;

procedure TSAK.ontimeritementer(const Sender: TObject);
begin
  thetimer.Enabled := False;
  SakCancel;
  espeak_key('focused, ' + WhatName(TheSender, false) + ', ' + 
  TheMenuInfo[TheMenuIndex].buttoninfo.ca.caption.text );
  itementer:= false;
 end;
 
 procedure TSAK.ontimeritementer2(const Sender: TObject);
begin
  thetimer.Enabled := False;
  SakCancel;
  espeak_key('focused, ' +  WhatName(TheSender, false) + ', ' + 
  TheItemInfo[TheMenuIndex].ca.caption.text );
  itementer:= true;
 end;

procedure  TSAK.doitementer(const sender: iassistiveclient; //sender can be nil
                            const items: shapeinfoarty; const aindex: integer);
begin
if (assigned(Sender)) then
 if (WhatName(Sender, false) <> '') and  (isblock = false) then
  begin
    thetimer.Enabled := False; 
    TheSender := Sender;
    TheItemInfo := items;
    TheMenuIndex := aindex;
    thetimer.interval := 900000;
    thetimer.ontimer := @ontimeritementer2;
    thetimer.Enabled := True;
    itementer:= true;
  end;
end;  

procedure TSAK.doitementer(const sender: iassistiveclient;
                        const items: menucellinfoarty; const aindex: integer);
begin
if (assigned(Sender)) then
 if (WhatName(Sender, false) <> '') and  (isblock = false) then
  begin
    thetimer.Enabled := False; 
    TheSender := Sender;
    TheMenuInfo := items;
    TheMenuIndex := aindex;
    thetimer.interval := 900000;
    thetimer.ontimer := @ontimeritementer;
    thetimer.Enabled := True;
    itementer:= true;
  end;
end;

procedure TSAK.doactionexecute(const Sender: TObject; const info: actioninfoty);
begin
end;

// for code editor
function TSAK.formatcode(acell : msestring) : msestring;
var
formatcell : msestring;
begin

 formatcell := aCell;
 {
 if (isgridsource = true) and (isfirstload = false) then
 while pos(' ',formatcell)  > 0 do
   if pos(' ',formatcell)  > 0 then formatcell := copy(formatcell,1,pos(' ',formatcell)-1) + 'ºspaceº' +
   copy(formatcell,pos(' ',formatcell)+1, length(formatcell) - pos(' ',formatcell)+1  );
 }   
  while pos(',',formatcell)  > 0 do
   if pos(',',formatcell)  > 0 then formatcell := copy(formatcell,1,pos(',',formatcell)-1) + ' ªcommaª ' +
   copy(formatcell,pos(',',formatcell)+1, length(formatcell) - pos(',',formatcell)+1  );
   
   while pos('º',formatcell)  > 0 do
   if pos('º',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('º',formatcell)-1) + ' , ' +
   copy(formatcell,pos('º',formatcell)+1, length(formatcell) - pos('º',formatcell)+1  );
  
   while pos('ª',formatcell)  > 0 do
   if pos('ª',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('ª',formatcell)-1) + ' , ' +
   copy(formatcell,pos('ª',formatcell)+1, length(formatcell) - pos('ª',formatcell)+1  );
     
     while pos(';',formatcell)  > 0 do
   if pos(';',formatcell)  > 0 then formatcell := copy(formatcell,1,pos(';',formatcell)-1) + ' , Semi colon , ' +
   copy(formatcell,pos(';',formatcell)+1, length(formatcell) - pos(';',formatcell)+1  );
   
       while pos('(',formatcell)  > 0 do
   if pos('(',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('(',formatcell)-1) + '  , opening parenthesis , ' +
   copy(formatcell,pos('(',formatcell)+1, length(formatcell) - pos('(',formatcell)+1  );
   
        while pos(')',formatcell)  > 0 do
   if pos(')',formatcell)  > 0 then formatcell := copy(formatcell,1,pos(')',formatcell)-1) + ' , closing parenthesis , ' +
   copy(formatcell,pos(')',formatcell)+1, length(formatcell) - pos(')',formatcell)+1  );

   while pos(':',formatcell)  > 0 do
   if pos(':',formatcell)  > 0 then formatcell := copy(formatcell,1,pos(':',formatcell)-1) + ' , two point , ' +
   copy(formatcell,pos(':',formatcell)+1, length(formatcell) - pos(':',formatcell)+1  );

 while pos('.',formatcell)  > 0 do
   if pos('.',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('.',formatcell)-1) + ' , point , ' +
   copy(formatcell,pos('.',formatcell)+1, length(formatcell) - pos('.',formatcell)+1  );
   
 while pos('/',formatcell)  > 0 do
   if pos('/',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('/',formatcell)-1) + ' , slash , ' +
   copy(formatcell,pos('/',formatcell)+1, length(formatcell) - pos('/',formatcell)+1  );

while pos('\',formatcell)  > 0 do
   if pos('\',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('\',formatcell)-1) + ' , back slash , ' +
   copy(formatcell,pos('\',formatcell)+1, length(formatcell) - pos('\',formatcell)+1  );

while pos('{',formatcell)  > 0 do 
   if pos('{',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('{',formatcell)-1) + ' , brace left , ' +
   copy(formatcell,pos('{',formatcell)+1, length(formatcell) - pos('{',formatcell)+1  );

while pos('}',formatcell)  > 0 do
   if pos('}',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('}',formatcell)-1) + ' , brace right , ' +
   copy(formatcell,pos('}',formatcell)+1, length(formatcell) - pos('}',formatcell)+1  );
   
while pos('<',formatcell)  > 0 do
   if pos('<',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('<',formatcell)-1) + ' , less , ' +
   copy(formatcell,pos('<',formatcell)+1, length(formatcell) - pos('<',formatcell)+1  );

while pos('>',formatcell)  > 0 do
   if pos('>',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('>',formatcell)-1) + ' , greater , ' +
   copy(formatcell,pos('>',formatcell)+1, length(formatcell) - pos('>',formatcell)+1  );

while pos('''',formatcell) > 0 do
   if pos('''',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('''',formatcell)-1) + ' , apostrophe , ' +
   copy(formatcell,pos('''',formatcell)+1, length(formatcell) - pos('''',formatcell)+1  );
  
while pos('"',formatcell)  > 0 do 
   if pos('"',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('"',formatcell)-1) + ' , two apostrophes , ' +
   copy(formatcell,pos('"',formatcell)+1, length(formatcell) - pos('"',formatcell)+1  );

while pos('-',formatcell)  > 0 do
   if pos('-',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('-',formatcell)-1) + ' , minus , ' +
   copy(formatcell,pos('-',formatcell)+1, length(formatcell) - pos('-',formatcell)+1  );

while pos('+',formatcell)  > 0 do
   if pos('+',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('+',formatcell)-1) + ' , plus , ' +
   copy(formatcell,pos('+',formatcell)+1, length(formatcell) - pos('+',formatcell)+1  );

while pos('$',formatcell)  > 0 do
   if pos('$',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('$',formatcell)-1) + ' , dollar , ' +
   copy(formatcell,pos('$',formatcell)+1, length(formatcell) - pos('$',formatcell)+1  );
   
   while pos('_',formatcell)  > 0 do
   if pos('_',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('_',formatcell)-1) + ' , underscore , ' +
   copy(formatcell,pos('_',formatcell)+1, length(formatcell) - pos('_',formatcell)+1  );

   while pos('[',formatcell)  > 0 do
   if pos('[',formatcell)  > 0 then formatcell := copy(formatcell,1,pos('[',formatcell)-1) + ' , open square braket , ' +
   copy(formatcell,pos('[',formatcell)+1, length(formatcell) - pos('[',formatcell)+1  );

while pos(']',formatcell)  > 0 do
   if pos(']',formatcell)  > 0 then formatcell := copy(formatcell,1,pos(']',formatcell)-1) + ' , close square braket , ' +
   copy(formatcell,pos(']',formatcell)+1, length(formatcell) - pos(']',formatcell)+1  );

result := formatcell ;
end;

procedure TSAK.ontimercell(const Sender: TObject);
var
 oldlang : msestring;
  oldspeed, oldgender ,oldpitch, oldvolume : integer;
begin
  thetimer.Enabled := False;  

SakCancel;
   
if TheTypCell = 1 then begin

oldlang := voice_language;
      if voice_gender = '' then
    oldgender := -1 else
     if voice_gender = 'm3' then
    oldgender := 1 else
     oldgender := 2 ;
  oldspeed := voice_speed;
  oldpitch := voice_pitch;
  oldvolume := voice_volume;

  SAKSetVoice(2,'',150,-1,-1);
  espeak_Key(TheCell);
   SAKSetVoice(oldgender,oldlang,oldspeed,oldpitch,oldvolume);
   
 end else
 begin
 	if 	(isfilelist = true) and (assigned(Thesender)) then
	begin
 if assigned(tfilelistview(TheSender.getinstance).selectednames) then
 TheCell := tfilelistview(TheSender.getinstance).selectednames[0]
 else
 if trim(tfilelistview(TheSender.getinstance).focuseditem.caption) <> '' then
   TheCell := 'directory , ' +  tfilelistview(TheSender.getinstance).focuseditem.caption;
 end;
     espeak_Key(thecell);
  end;
 end;

procedure TSAK.docellevent(const sender: iassistiveclientgrid; 
                                     const info: celleventinfoty);
var
 mstr1, mstr2: msestring;
 lrkeyused : boolean = false;
 gridcoo : gridcoordty;
begin
if (assigned(Sender)) and
  (isblock = false) then
  begin
 if (Sender.getinstance is Twidgetgrid) then isgridsource := true else
 isgridsource := false;
 
 if (TheExtraChar = 'Up') or (TheExtraChar = 'Down') or
    			  (TheExtraChar = 'Prior') or (TheExtraChar = 'Next') or
    			  (TheExtraChar = 'Backspace') or (TheExtraChar = 'Delete') or
    			 (TheExtraChar = 'Right') or (TheExtraChar = 'Left') then
 lrkeyused := true;
 
 isfilelist := false;
   thetimer.enabled := false;
  thetimer.ontimer := @ontimercell;
  thetimer.interval := 600000;
   TheCell := '';
   TheSender := nil ; 	
 
 if info.eventkind = cek_keyup then 
 begin
 	 if  (Sender.getinstance is tfilelistview) then
 	begin
 	TheSender := sender;
 	isfilelist := true;
 	thetimer.enabled := true;
 	end
 else
 begin	
 if (sender.getassistivecaretindex() > -1) and (info.cell.row > -1) then
 begin
  	mstr1:= sender.getassistivecelltext(info.cell);
	if ((lrkeyused = true) and not (Sender.getinstance is Twidgetgrid)) or 
	(TheLastCell.row > info.cell.row) or (TheLastCell.row < info.cell.row) 
	 then
			begin
			if (Sender.getinstance is Tstringgrid) or 
			(Sender.getinstance is Tcustomstringgrid) then
		begin
		  if (Sender.getinstance is Tstringgrid) then if
		  Tstringgrid(Sender.getinstance).datacols.count > 1 then
			TheCell := ' Colon , '+ inttostrmse(info.cell.col) + ' , row , '
    		+ inttostrmse(info.cell.row) + ' , ' + formatcode(mstr1) else			
    		TheCell := ' row , '+ inttostrmse(info.cell.row) + ' , ' + formatcode(mstr1);
    	
    	 if (Sender.getinstance is Tcustomstringgrid) then if
		  Tcustomstringgrid(Sender.getinstance).datacols.count > 1 then
			TheCell := ' Colon , '+ inttostrmse(info.cell.col) + ' , row , '
    		+ inttostrmse(info.cell.row) + ' , ' + formatcode(mstr1) else			
    		TheCell := ' row , '+ inttostrmse(info.cell.row) + ' , ' + formatcode(mstr1);
    		
			end else 
    	TheCell := ' row , '
    		+ inttostrmse(info.cell.row + 1) + ' , ' + formatcode(mstr1) ;
    		
    		TheTypCell := 0 ;
    		thetimer.enabled := true;
			end  else
	if length(mstr1) > 0 then
			begin 
			mstr2 := mstr1[sender.getassistivecaretindex()] ;
			
			{			
			if sender.getassistivecaretindex() < TheLastCell.col then
			mstr3 := ' Colon , '+ inttostrmse(sender.getassistivecaretindex()) + ' , ' else
			mstr3 := '';
			}
  			        	if (mstr2 = ' ') or (mstr2 = '.') or (mstr2 = ',') or (mstr2 = '"') or
        	(mstr2 = '[') or (mstr2 = ']') or (mstr2 = '{') or (mstr2 = '}')
        	or (mstr2 = '(') or (mstr2 = ')') or (mstr2 = '[') or (mstr2 = ']') then
   				begin 
   			TheCell := Theword ;
    		TheTypCell := 1 ;
    		thetimer.enabled := true;
   			Theword := '';
    			end else
 			if mstr2 = ';'  then
   				begin
 			    TheTypCell := 1 ;
    			TheCell := formatcode(mstr1);
    			thetimer.enabled := true;
      			end  else
       		if (TheExtraChar = 'F4') then
   				begin
   				gridcoo.col := info.cell.col;
                gridcoo.row := info.cell.row;
                
                if gridcoo.row - 4 < 0 then 
                begin
                 mstr1 := 'Reading ' + inttostr(info.cell.row) + ' rows prior . ';
                gridcoo.row := 0 end
                else begin
                gridcoo.row := gridcoo.row - 4 ;
                 mstr1 := 'Reading 4 rows prior . ';
                 end;
             
               gridcoo.row := 0 ;
                while gridcoo.row <
                info.cell.row + 1 
               //  info.grid.rowcount -1
                do
				begin
				mstr1 := mstr1 + ' , row , ' + inttostr(gridcoo.row + 1) + ' , ' +
				formatcode(sender.getassistivecelltext(gridcoo));
				inc(gridcoo.row);
				end;
				
				thetimer.enabled := false;
   			    TheTypCell := 0 ;
   			    thetimer.interval := 800000 ;
    			TheCell := mstr1 ;
    			thetimer.enabled := true;
      			end  else
      		   begin
    			Theword := Theword + mstr2;
    			TheTypCell := 0 ;
    			if lrkeyused = true then
    			begin
    			TheTypCell := 0 ;
    			thetimer.interval := 800000 ;
    			TheCell :=  formatcode(mstr2);
     			thetimer.enabled := true;
     			 end;
   			end;
 		end;
 	TheLastCell.col := sender.getassistivecaretindex() ; 
	TheLastCell.row := info.cell.row;
 		end;
 		 end; end else
 if info.eventkind = cek_mousemove then
  begin
  if itementer = false then 
  begin
     mstr2:= ' Colon , '+ inttostrmse(sender.getassistivecaretindex())+
      ' , row , '+inttostrmse(info.cell.row+1) + ' , ';
	mstr1 := mstr2 + formatcode(sender.getassistivecelltext(info.cell));
	
 	Theword := '';
 	TheLastCell.col := sender.getassistivecaretindex() ; 
	TheLastCell.row := info.cell.row;
	TheTypCell := 0 ;
	TheCell :=  mstr1;
	 thetimer.interval := 300000;
     thetimer.enabled := true;
    end;
   itementer := false; 
 end;
end; 
end;

// Creating/destroying sak

constructor TSAK.Create();
begin
        thetimer := ttimer.Create(nil);
        thetimer.interval := 500000;
        thetimer.tag := 0;
        thetimer.Enabled := False;
        
        thetimerInit := ttimer.Create(nil);
        thetimerInit.interval := 2000000;
        thetimerInit.Enabled := False;
end;

destructor TSAK.Destroy();
begin
 thetimer.free();
 assistiveserver:= nil;
 end;

// Hello message.
procedure SakGreeting(gret: msestring);
begin
greeting := gret;
end;

// Loading sak
function TSAK.LoadLib: integer;
//var
// str1: msestring = '' ;
begin
 {  
result:= -1;
if (getprocessoutput(ES_ExeFileName+' --version','',str1,5000000,
                                           [pro_shell,pro_inactive]) = 0) and
                   ((pos('eSpeak',str1) <> 0) or 
                    (pos('speak text-to-speech',str1) <> 0)) then begin 
}
  result:= 0;
 
  AProcess := TProcess.Create(nil);
  AProcess.Executable :=
  tosysfilepath(filepath(trim(ES_ExeFileName), fk_file, True));
  AProcess.Options := AProcess.Options + [poNoConsole, poUsePipes];
  AProcess.FreeOnRelease;

   {$ifdef unix}
  if trim(ES_LibFileName) <> '' then
begin
 AProcess.Environment.Text := 'LD_LIBRARY_PATH=' + tosysfilepath(ExtractFilePath(ES_LibFileName)) ;
if trim(PA_LibFileName) <> '' then
   AProcess.Environment.Text := AProcess.Environment.Text + ':' + tosysfilepath(ExtractFilePath(PA_LibFileName))

end  else
begin
  if trim(PA_LibFileName) <> '' then
   AProcess.Environment.Text := 'LD_PRELOAD=' + tosysfilepath(PA_LibFileName) ;
end;

if trim(PA_LibFileName) <> '' then pa_Handle:= DynLibs.SafeLoadLibrary(tosysfilepath(PA_LibFileName));
if trim(SO_LibFileName) <> '' then so_Handle:= DynLibs.SafeLoadLibrary(tosysfilepath(SO_LibFileName));
if trim(ES_LibFileName) <> '' then es_Handle:= DynLibs.SafeLoadLibrary(tosysfilepath(ES_LibFileName));
   
{$endif}

 AProcess.Executable :=  tosysfilepath(ES_ExeFileName);

  TheWord := '' ;
  TheSentence := '' ;
  TheLastSentence := '' ;
  
  voice_gender := '' ;
  voice_language := '' ;
  voice_speed := -1 ;
  voice_pitch := -1 ;
  voice_volume := -1 ;
  
  thetimerinit.ontimer := @ontimergreeting;
  thetimerinit.enabled := true; 
  isblock := true;
  
  espeak_Key(greeting);
  
  assistiveserver:= iassistiveserver(self); //sak is now operable
end;

// Voice Config Procedures
function SAKSetVoice(gender: shortint; language: msestring ; speed: integer ; pitch: integer ; volume : integer): integer;
// gender => 1 = man / => 2 = woman => defaut -1 (man)
// language => 'en' or 'pt' or 'ru'  => default 'en' => ''
//  speed sets the speed in words-per-minute , Range 80 to 450. The default value is 175. => -1
// pitch  range of 0 to 99. The default is 50.  => -1
// volume range of 0 to 200. The default is 100. => -1
begin
   result := -1;
  if assigned(sak) then
  begin
   result := 0;
    if gender = -1 then
    sak.voice_gender := ''  else
   if gender = 1 then
    sak.voice_gender := 'm3'
  else
    sak.voice_gender := 'f2';
  sak.voice_language := language;
  sak.voice_speed := speed;
  sak.voice_volume := volume;
  sak.voice_pitch := pitch;
  end;
end;

// Speecher Procedures
procedure TSAK.espeak_key(Text: msestring);
var
 params: msestring = '';
begin
   aprocess.Parameters.clear;

if (voice_gender <> '') or (voice_language <> '') then begin
  params:= params + '-v';
  if voice_language <> '' then begin
   params:= params+voice_language;
   if voice_gender <> '' then begin
    params:= params+'+'+voice_gender;
   end;
  end
  else begin
   if voice_gender <> '' then begin
    params:= params+voice_gender;
   end;
  end;
 end;

if  params <> '' then AProcess.Parameters.Add(params) ;

if voice_speed <> -1 then AProcess.Parameters.Add('-s' + inttostr(voice_speed)) ;
if voice_pitch <> -1 then AProcess.Parameters.Add('-p' + inttostr(voice_pitch)) ;
if voice_volume <> -1 then AProcess.Parameters.Add('-a' + inttostr(voice_volume)) ;

    if es_datadirectory <> ''  then
    AProcess.Parameters.Add('--path=' + ES_DataDirectory);
   
  AProcess.Parameters.Add('"' + Text + '"');
  AProcess.Execute;
end;

// custom speecher procedure => to use also as extra-speecher
function SAKSay(Text: msestring): integer;
begin
Result := -1;
if assigned(sak) then
begin
  sak.espeak_Key(Text);
  Result := 0;
end;
end;

// cancel current speech
function SakCancel: integer;
begin
result := -1;
 if assigned(sak) then
  if assigned(sak.AProcess) then
  begin
    sak.AProcess.Terminate(0);
    sak.AProcess.active := false;
   // freeandnil(sak.AProcess);
    result := 0;
    end;
end;

// Enabled procedure
function SakIsEnabled(): boolean;
begin
result:= sak <> nil;
end;

finalization
 sak.free();

end.
