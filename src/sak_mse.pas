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
    Copyright (C) 2013 - 2015  Fred van Stappen

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

interface

uses
  msetypes, mseglob, mseguiglob, mseguiintf, mseapplication, msestat, msemenus, msemenuwidgets, msegui,
  msegraphics, msegraphutils, mseevent, mseclasses, msewidgets, mseforms, msetimer,
   mseassistiveserver,mseassistiveclient, msegrids, msestrings, msesimplewidgets, 
  msedataedits, mseedit, msekeyboard, msefileutils,
  mseificomp, mseificompglob, mseifiglob, msestatfile, msestream, SysUtils, mseact,
  msegraphedits, msescrollbar, msewidgetgrid, msetoolbar,msebitmap,mseshapes, mseprocess,
  Math, Classes, Process
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

const
  male = 1;
  female = 2;

type
  TSAK = class(TObject, iassistiveserver)
  protected
        
    ES_ExeFileName: ansistring;
    ES_DataDirectory: ansistring;
    
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
  TheSender: TObject;
  TheKeyInfo: keyeventinfoty;
  TheMouseInfo: mouseeventinfoty;
  TheMenuInfo: menucellinfoarty;
  TheMenuIndex : integer;

  TheWord: string;  //// use F11 key in memo
  TheSentence: string;   //// use F10 key in memo
  TheLastSentence: string;  //// use F10 key in memo

  isentered: boolean;
  
    procedure doenter(const Sender: iassistiveclient);
    procedure clientmouseevent(const sender: iassistiveclient; const info: mouseeventinfoty);
    procedure dochange(const sender: iassistiveclient);   
    procedure dofocuschanged(const oldwidget, newwidget: iassistiveclient);
    procedure dokeydown(const Sender: iassistiveclient; const info: keyeventinfoty);
    procedure doactionexecute(const Sender: TObject; const info: actioninfoty);
    procedure doitementer(const sender: iassistiveclient; //sender can be nil
                            const items: shapeinfoarty; const aindex: integer);
    procedure doitementer(const sender: iassistiveclient;
                         const items: menucellinfoarty; const aindex: integer);
   procedure docellevent(const sender: iassistiveclient; 
                                    const info: celleventinfoty);
    procedure ontimerkey(const Sender: TObject);
    procedure ontimermouse(const Sender: TObject);
    procedure ontimerenter(const Sender: TObject);
    procedure ontimeritementer(const Sender: TObject);
    procedure ontimerchange(const Sender: TObject);
    function LoadLib: integer;
    procedure espeak_key(Text: string);
    function WhatName(Sender: TObject): string;
    function WhatChar(Sender: TObject; const info: keyeventinfoty): string;
    function WhatChange(Sender: TObject) : string;

  public
    constructor Create(const agrid: tstringgrid);
      destructor Destroy(); override;
  end;
  
  var
   sak: TSAK;
   isenabled : boolean = False;

/// Load with custom sakit dir
function SAKLoadLib(const SakitDir: filenamety = ''): integer;
                            //'' = default

/// Load with custom
function SAKLoadLib(const eSpeakBin: filenamety;
                                      const eSpeakDataDir: filenamety): integer;
/// Unload sak 
function SAKUnloadLib: integer;

//// to know if sak is loaded
function SakIsEnabled: boolean;

////////////////////// Voice Config Procedures ///////////////
function SAKSetVoice(gender: shortint; language: string ; speed: integer ; pitch: integer ; volume : integer ): integer;
//// gender : 1 = man, 2 = woman.
//// language : is the language code, for example :
//// 'en' for english, 'fr' for french, 'pt' for Portugues, etc...
////           (check in /espeak-data if your language is there...)
//  speed sets the speed in words-per-minute , Range 80 to 450. The default value is 175. => -1
// pitch  range of 0 to 99. The default is 50.   => -1
// volume range of 0 to 200. The default is 100. => -1

///// Start speaking the text
function SAKSay(Text: string): integer;

// Cancel current speak.
function SakCancel: integer;


implementation

uses
  typinfo, mclasses, mseactions;
  
/////////////////////////// Capture Assistive Procedures

function TSak.WhatChange(Sender: TObject) : string;
var
stringtemp : msestring;
begin
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
   if (Sender is tslider) then
    Result := ' changed position to ' + inttostr(round(tslider(sender).value * 100)) + ' ,%' ;
end;

function TSak.WhatChar(Sender: TObject; const info: keyeventinfoty): string;

procedure checkgrid();
 begin
  if (Sender is Tcustomstringgrid) then begin
   with tcustomstringgrid(Sender) do begin
    if focusedcellvalid then begin
     Result := Result + ', column  ' +
              IntToStr(col) + ' , row  ' + 
              IntToStr(row) + '. ' + items[focusedcell]; 
     end;
   end;
  end;
 end;
 
var
  CheckKey: keyty;
  
begin
  CheckKey := info.key;
  Result := '';

  if ((CheckKey = key_Up) or (CheckKey = key_Space) or (CheckKey = key_down) or (CheckKey = key_left) or
    (CheckKey = key_right) or (CheckKey = key_tab)) and (sak.isentered = True)  and not (Sender is Tstringgrid) then
    sak.isentered := False
  else
  begin
    Result := info.chars;
    case CheckKey of

      key_Return:  begin
        Result := 'Enter';  
        end;
    
      key_Backspace: Result := 'back space';
      key_Backtab: Result := 'back tab';

      key_Up:
      begin
       if not (Sender is Tstringgrid) then Result := 'up';
     checkgrid();
         end;
      
      key_down:
      begin
        if not (Sender is Tstringgrid) then Result := 'down';
       checkgrid();
         end;

      key_left:
      begin
        if not (Sender is Tstringgrid) then Result := 'left';
        checkgrid();
         end;

      key_right:
      begin
        if not (Sender is Tstringgrid) then Result := 'right';
    checkgrid();
        end;
      
      key_Tab:  
      begin
      Result := 'tab'; 
      checkgrid();
       end; 
 
      key_Space: Result := 'space';
     
      key_F1: Result := 'f, 1';
      key_F2: Result := 'f, 2';
      key_F3: Result := 'f, 3';
      key_F4: Result := 'f, 4';
      key_F5: Result := 'f, 5';
      key_F6: Result := 'f, 6';
      key_F7: Result := 'f, 7';
      key_F8: Result := 'f, 8';
      key_F9: if (CheckObject is TMemoedit) then
                    result := thelastsentence
                  else
          Result := 'f, 9';

      key_F10: if (CheckObject is TMemoedit) then
                   result := theword
                  else Result := 'f, 10';

      key_F11: if (CheckObject is TMemoedit) then
                   result := thesentence
                  else result := 'f, 11';
           
      key_F12: if (Sender is TMemoedit) then
          with Sender as TMemoedit do
              begin
              //  SAKSetVoice(2,'',165,-1,-1);
            result := Text ;
              //  SAKSetVoice(-1,'',-1,-1,-1);
              end
        else
        if (Sender is Tstringedit) then
          with Sender as Tstringedit do
            Result := Text
        else if (Sender is Tstringgrid) then
              with Sender as tstringgrid do  Result := Result + ' column  ' + 
        IntToStr(col) + ' , row  ' + IntToStr(row) + '. ' + Tstringgrid(sender)[col][row]
        else        
          Result := '';
          
      key_Shift: Result := 'shift';
      key_control: Result := 'control,';
      key_alt: Result := 'alt';
      key_CapsLock: Result := 'caps lock';
      key_NumLock: Result := 'num lock';
      key_AltGr: Result := 'alt gr';
      
      Key_PageUp:
       begin
        Result := 'page up';
      checkgrid();
        end;
      
      Key_PageDown:
       begin
        Result := 'page down';
       checkgrid();
       end;
      
      Key_delete: Result := 'delete';
      Key_insert: Result := 'insert';
      Key_escape: Result := 'escape';
      Key_end: Result := 'end';
    end;
  end;
end;

function TSak.WhatName(Sender: TObject): string;
begin

  Result := '';

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
  if (Sender is TStringEdit) then
    Result := 'edit, ' + TStringEdit(Sender).Name
  else
  if (Sender is TMemoEdit) then
    Result := 'memo, ' + TMemoEdit(Sender).Name
  else
  if (Sender is Twidgetgrid) then
    Result := 'widget grid, ' + Twidgetgrid(Sender).Name
  else
   if (Sender is Tstringgrid) then
    Result := 'grid, ' + Tstringgrid(Sender).Name
  else
  if (Sender is tbooleaneditradio) then
  begin
    if (Tbooleaneditradio(Sender).frame.Caption <> '') then
      Result := 'radio button, ' + Tbooleaneditradio(Sender).frame.Caption
    else
      Result := 'radio button, ' + Tbooleaneditradio(Sender).Name;
  end
  else if (Sender is tbooleanedit) then
  begin
    if (Tbooleanedit(Sender).frame.Caption <> '') then
      Result := 'checkbox, ' + Tbooleanedit(Sender).frame.Caption
    else
      Result := 'checkbox, ' + Tbooleanedit(Sender).Name;
  end
   else
   if (Sender is ttoolbar) then
    Result := 'tool bar, ' + ttoolbar(Sender).Name
  else
  if (Sender is tslider) then
    Result := 'slider, ' + Tslider(Sender).Name
  else 
    if (Sender is ttoolbutton) then
    Result := 'toolbutton, ' +  ttoolbutton(Sender).hint
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
     ;
 //   else 
 //    if (Sender is twidget) then
 //   Result := 'widget, ' + Twidget(Sender).Name ;
    
end;

////////////////////// Loading Procedure

function SAKLoadLib(const eSpeakBin: filenamety;
                                      const eSpeakDataDir: filenamety): integer;
begin
 Result := -1;
 if sak = nil then begin
  sak:= TSAK.Create(nil);
 end;
 if (espeakdatadir = '') or directoryexists(eSpeakDataDir) then begin
  Result:= 0;
  sak.ES_DataDirectory:= tosysfilepath(eSpeakDataDir);
 end;
 if result = 0 then
 begin
 sak.ES_ExeFileName:= tosysfilepath(eSpeakBin);
 Result:= sak.loadlib;
 end;
 if result <> 0 then begin
  freeandnil(sak);
 end;
end;

function SAKLoadLib(const sakitdir: filenamety = ''): integer;
var
 ordir: filenamety;
 espeakbin,espeakdatadir: filenamety;
const
{$ifdef mswindows}
 espeakstarter = 'espeak.bat';
 espeaklibdir = 'libwin32';
 espeakdefault = 'espeak.exe';
{$else}
 espeakstarter = 'espeak.sh';
 espeakdefault = 'espeak';
{$endif}
{$if defined(linux) and  defined(cpu64)}
 espeaklibdir = 'liblinux64';
{$endif}
{$if defined(linux) and defined(cpu86) }
 espeaklibdir = 'liblinux32';
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

 espeakbin:= ordir + espeakstarter;

  if fileexists(espeakbin) then
  begin
   Result:= 0;
   {$ifdef unix}
  fpchmod(espeakbin, S_IRWXU);
   {$endif}
  end
 else begin
{$ifdef windows}
  espeakbin:= ordir + '\sakit\'+espeaklibdir+'\'+espeakstarter;
{$else}
   espeakbin:= ordir + '/sakit/'+espeaklibdir+'/'+espeakstarter;
{$endif}
  if fileexists(espeakbin) then begin
    Result:= 0;
     {$ifdef unix}
   fpchmod(espeakbin, S_IRWXU);
    {$endif}
   end
  else begin
//{$ifdef unix}
//  if (fileexists('/usr/bin/espeak')) or (fileexists('/usr/local/bin/espeak')) then begin
   espeakbin:= espeakdefault; //try to run default binary
     Result:= 0;
    end;
//{$endif}
  end;
 end;

 if result = 0 then begin
  result:= sakloadlib(espeakbin,espeakdatadir);
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
 end;
end;

function checksakactive(const raiseexception: boolean = false): boolean;
begin
 result:= sak <> nil;
// if not result and raiseexception then begin
//  raise esakerror.create('SAK not acitve');
// end;
end;

procedure TSAK.dochange(const sender: iassistiveclient);
begin
 thetimer.enabled := false;
if WhatName(sender.getinstance) <> '' then
 begin  
  TheSender := sender.getinstance;  
  thetimer.interval := 600000 ;
  thetimer.ontimer := @ontimerchange;
  thetimer.enabled := true;
 end;
 end;

procedure TSAK.ontimerchange(const sender: TObject);
begin
thetimer.enabled := false;
 SakCancel;
 espeak_Key(WhatName(TheSender) + WhatChange(TheSender));
end;

procedure TSAK.ontimerenter(const Sender: TObject);
begin
  thetimer.Enabled := False;
  SakCancel;
  espeak_Key(WhatName(TheSender) + ', enter');
end;

procedure TSAK.doenter(const Sender: iassistiveclient);
begin
//if itementer = false then
//begin
  if WhatName(Sender.getinstance) <> '' then
  begin
    thetimer.Enabled := False;
    TheSender := Sender.getinstance;
    thetimer.interval := 600000;
    thetimer.ontimer := @ontimerenter;
    thetimer.Enabled := True;
    isentered := True;
  end;
//end;

end;

procedure TSAK.ontimerkey(const Sender: TObject);
begin
if itementer = false then begin
  thetimer.Enabled := False;
  SakCancel;
  espeak_Key(WhatChar(TheSender, TheKeyinfo));
    end;
end;

procedure TSAK.dokeydown(const Sender: iassistiveclient; const info: keyeventinfoty);
var
  WhatCh: msestring;
  oldlang : string;
  oldspeed, oldgender ,oldpitch, oldvolume : integer;
begin
  thetimer.Enabled := False;

   
  
    WhatCh := WhatChar(Sender.getinstance, info);
    TheSender := Sender.getinstance;
    TheKeyInfo := info;
    thetimer.ontimer := @ontimerkey;

  if (TheSender is Tstringedit) or (TheSender is Tmemoedit) then  
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

  if info.key = key_Space then
   begin
   SAKSetVoice(2,'',150,-1,-1);
   espeak_Key(Theword) ;
   TheSentence := TheSentence + ' ' + TheWord;
   Theword := '';
   SAKSetVoice(oldgender,oldlang,oldspeed,oldpitch,oldvolume);
   end else
   if (WhatCh = '.') or (WhatCh = '?') or (WhatCh = '!') then
   begin
   SAKSetVoice(2,'',150,-1,-1);
   espeak_Key( Theword + ', ' + TheSentence + ' ' + Theword) ;
   SAKSetVoice(oldgender,oldlang,oldspeed,oldpitch,oldvolume);
   TheLastSentence := TheSentence + ' ' + Theword ;
   TheSentence := '';
   Theword := '';
   end
   else
   begin
    thetimer.Interval := 1 ;
   Theword := Theword + info.chars;
     thetimer.Enabled := True;
   end;
   end else
   begin
   if (TheSender is Tcustomstringgrid) then
   begin
     if (info.key = key_down) or (info.key = key_up) or (info.key = key_left) or (info.key = key_right)
   then
   begin
      case info.key of
   key_down: WhatCh := 'down';
   key_up: WhatCh := 'up';
   key_left: WhatCh := 'left';
   key_right: WhatCh := 'right';
   end;
   
   SakCancel;
      espeak_Key(WhatCh) ; 
     thetimer.interval := 600000;
     thetimer.Enabled := True;
    end else
    begin
     thetimer.interval := 400000 ; 
     thetimer.Enabled := True;
     end;
   end;
   end;

end;

procedure TSAK.ontimermouse(const Sender: TObject);
var
stringtemp : msestring = '' ;

begin
  thetimer.Enabled := False;

  if TheMouseinfo.eventkind = ek_mousemove then
  begin

    if TComponent(TheSender).Name <> lastname then
    begin
      SakCancel;
      
      if(TheSender is tbooleaneditradio) then
  begin
  if tbooleaneditradio(TheSender).value = false then stringtemp := ' , false, ' else stringtemp := ' , true, ';
  end;
  
    if(TheSender is tbooleanedit) then
  begin
  if tbooleanedit(TheSender).value = false then stringtemp := ' , false, ' else stringtemp := ' , true, '; 
  end;
  
     if(TheSender is tslider) then
  begin
  stringtemp := ' , ' + inttostr(round(tslider(TheSender).value * 100)) + ' ,%, '
  end;
        
      espeak_Key(WhatName(TheSender) + stringtemp + ' focused.');
      lastname := TComponent(TheSender).Name;
    end;
  end
  else
  if TheMouseinfo.eventkind = ek_buttonpress then
  begin
    SakCancel;
    espeak_Key(WhatName(TheSender) + ' clicked.');
    lastname := TComponent(TheSender).Name;
  end;

end;

procedure TSAK.clientmouseevent(const sender: iassistiveclient;
                                           const info: mouseeventinfoty);
 begin
 //if itementer = false then
//begin
  if WhatName(Sender.getinstance) <> '' then
  begin
    TheSender := Sender.getinstance;
    TheMouseInfo := info;
    thetimer.Enabled := False;
    if info.eventkind = ek_mousemove then
  thetimer.interval := 60000 else
  thetimer.interval := 600000 ;
  
    thetimer.ontimer := @ontimermouse;
    thetimer.Enabled := True;
  end;
//  end;
end;

procedure TSAK.dofocuschanged(const oldwidget: iassistiveclient; const newwidget: iassistiveclient);
begin

end;

procedure TSAK.ontimeritementer(const Sender: TObject);
begin
  thetimer.Enabled := False;
  SakCancel;
  espeak_key(WhatName(TheSender) + ', ' + TheMenuInfo[TheMenuIndex].buttoninfo.ca.caption.text + ' , focused');
  itementer:= false;
 end;

procedure TSAK.doitementer(const sender: iassistiveclient;
               const items: shapeinfoarty; const aindex: integer);
begin
end;

procedure TSAK.doitementer(const sender: iassistiveclient;
                        const items: menucellinfoarty; const aindex: integer);
begin
 if WhatName(Sender.getinstance) <> '' then
  begin
    thetimer.Enabled := False; isentered := True;
    TheSender := Sender.getinstance;
    TheMenuInfo := items;
    TheMenuIndex := aindex;
    thetimer.interval := 600000;
    thetimer.ontimer := @ontimeritementer;
    thetimer.Enabled := True;
  //  itementer:= true;
  end;
end;

procedure TSAK.doactionexecute(const Sender: TObject; const info: actioninfoty);
begin

end;

procedure TSAK.docellevent(const sender: iassistiveclient;
               const info: celleventinfoty);
//var
// mstr1: msestring;
begin
{
 with info do begin
  if eventkind = cek_enter then begin
   mstr1:= WhatName(grid)+', column' +
              IntToStr(cell.col) + ' , row  ' + 
              IntToStr(cell.row) + 'entered';
   if info.grid is tcustomstringgrid then begin
    mstr1:= mstr1+'. ' + tcustomstringgrid(grid).items[grid.focusedcell]; 
   end;
   delayedspeak(mstr1);
  end;
 end;
 }
end;

constructor TSAK.Create(const agrid: tstringgrid);
begin
        thetimer := ttimer.Create(nil);
        thetimer.interval := 500000;
        thetimer.tag := 0;
        thetimer.Enabled := False;
end;

destructor TSAK.Destroy();
begin
 thetimer.free();
 assistiveserver:= nil;
 end;


///////////////// loading sak

function TSAK.LoadLib: integer;
var
 str1: string = '' ;
begin
 result:= -1;

 if (getprocessoutput(ES_ExeFileName+' --version','',str1,5000000,
                                           [pro_shell,pro_inactive]) = 0) and
                   ((pos('eSpeak',str1) <> 0) or 
                    (pos('speak text-to-speech',str1) <> 0)) then begin 
  result:= 0;
 
  AProcess := TProcess.Create(nil);
  AProcess.Executable :=
  tosysfilepath(filepath(trim(sak.ES_ExeFileName), fk_file, True));
  AProcess.Options := AProcess.Options + [poNoConsole, poUsePipes];
  AProcess.FreeOnRelease;
  
  TheWord := '' ;
  TheSentence := '' ;
  TheLastSentence := '' ;

  voice_gender := '' ;
  voice_language := '' ;
  voice_speed := -1 ;
  voice_pitch := -1 ;
  voice_volume := -1 ;
  
  espeak_Key('sak is working...');

  assistiveserver:= iassistiveserver(self); //sak is now operable
 end;
end;

////////////////////// Voice Config Procedures ///////////////
function SAKSetVoice(gender: shortint; language: string ; speed: integer ; pitch: integer ; volume : integer ): integer;
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


////////////////////// Speecher Procedures ////////////////
procedure TSAK.espeak_key(Text: string);
var
 params: string = '';
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

  {$IF DEFINED(Windows)}
    if es_datadirectory <> ''  then
    AProcess.Parameters.Add('--path=' + ES_DataDirectory);
      {$endif}  ;

  AProcess.Parameters.Add('"' + Text + '"');
  AProcess.Execute;

end;

//// custom speecher procedure => to use also as extra-speecher
function SAKSay(Text: string): integer;
begin
Result := -1;
if assigned(sak) then
begin
  sak.espeak_Key(Text);
  Result := 0;
end;
end;

/// cancel current speech
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

///////////// Enabled procedure
function SakIsEnabled(): boolean;
begin
  Result := isenabled;
// result:= sak <> nil;
end;

finalization
 sak.free();

end.
