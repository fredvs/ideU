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
  msegraphedits, msescrollbar, msewidgetgrid, msetoolbar,msebitmap,mseshapes,
  Math, Classes, Process
  {$IF not DEFINED(Windows)}
  , dynlibs, baseunix
       {$endif}  ;

const
  male = 1;
  female = 2;

type
  TSAK = class(TObject, iassistiveserver)
  protected
    {$ifdef windows}
       {$else}
    PA_Library: ansistring;
    PA_Handle: TLibHandle;
       {$endif}
  
    {$IF DEFINED(freebsd) }
    ES_Handle: TLibHandle;
    ES_Library: ansistring;
    {$endif}
    
    ES_Exe: ansistring;
    ES_DataDirectory: ansistring;
    
  old8087cw: word;
  mouseclicked: boolean;
  itementer: boolean;
  isenabled: boolean;
  AProcess: TProcess;
  
    isloaded: boolean;
    isworking: boolean;
    CompCount: integer;
    CheckObject: TObject;
    CheckKey: word;
    CheckPoint: Tpoint;
    CheckShift: TShiftState;
     voice_language: ansistring;
     voice_gender: ansistring;
     lastname: msestring;
  TheTimer: TTimer;
  TheSender: TObject;
  TheKeyInfo: keyeventinfoty;
  TheMouseInfo: mouseeventinfoty;
  TheMenuInfo: menucellinfoarty;
  TheMenuIndex : integer;
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
    procedure ontimerkey(const Sender: TObject);
    procedure ontimermouse(const Sender: TObject);
    procedure ontimerenter(const Sender: TObject);
    procedure ontimeritementer(const Sender: TObject);
    procedure ontimerchange(const Sender: TObject);
    function LoadLib: integer;
    function espeak_key(Text: string): integer;

  public
    constructor Create(const agrid: tstringgrid);
 
  end;
  
  var
   sak: TSAK;
   isenabled : boolean = False;

//// Load with default
function SAKLoadlib: integer;

/// Load with custom sakit dir
function SAKLoadLib(SakitDir: string): integer;

/// Load with custom
 {$IF DEFINED(freebsd)}
 function SAKLoadLib(PortaudioLib: string; eSpeakexe: string;  eSpeaklib: string; eSpeakDataDir: string): integer;
    {$endif}
 {$IF DEFINED(linux)}
function SAKLoadLib(PortaudioLib: string; eSpeakexe: string; eSpeakDataDir: string): integer;
   {$endif}
{$IF DEFINED(windows)}
function SAKLoadLib(eSpeakexe: string; eSpeakDataDir: string): integer;  
 {$endif}

/// Unload sak 
function SAKUnloadLib: integer;

//// to know if sak is loaded
function SakIsEnabled: boolean;

////// Change voice language or/and gender
function SAKSetVoice(gender: shortint; language: string): integer;
//// gender : 1 = male, 2 = female.
//// language : is the language code, for example :
//// 'en' for english, 'fr' for french, 'pt' for Portugues, etc...
//// (check in /espeak-data if your language is there...)

///// Start speaking the text with default voice
function SAKSay(Text: string): integer;

// Cancel current speak.
function SakCancel: integer;

//var
 
 

implementation

uses
  typinfo, mclasses, mseactions;
  
/////////////////////////// Capture Assistive Procedures

function WhatChange(Sender: TObject) : string;
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

function WhatChar(Sender: TObject; const info: keyeventinfoty): string;

procedure checkgrid();
 begin
  if (Sender is Tcustomstringgrid) then begin
   with tcustomstringgrid(Sender) do begin
    if focusedcellvalid then begin
     Result := Result + ', column  ' +
              IntToStr(col) + ' , row  ' + 
              IntToStr(row) + '. ' + items[focusedcell]; 
                  //wrong! probably previous cell
    // nowait:= true;
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
        Result := 'up';
      checkgrid();
         end;
      
      key_down:
      begin
        Result := 'down';
       checkgrid();
         end;

      key_left:
      begin
        Result := 'left';
        checkgrid();
         end;

      key_right:
      begin
        Result := 'right';
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
      key_F9: Result := 'f, 9';
      key_F10: Result := 'f, 10';
      key_F11: Result := 'f, 11';
           
      key_F12: if (Sender is TMemoedit) then
          with Sender as TMemoedit do
            Result := Text
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

function WhatName(Sender: TObject): string;
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
/// Load with custom
 {$IF DEFINED(freebsd)}
 function SAKLoadLib(PortaudioLib: string; eSpeakexe: string;  eSpeaklib: string; eSpeakDataDir: string): integer;
    {$endif}
 {$IF DEFINED(linux)}
function SAKLoadLib(PortaudioLib: string; eSpeakexe: string; eSpeakDataDir: string): integer;   {$endif}
{$IF DEFINED(windows)}
function SAKLoadLib(eSpeakexe: string; eSpeakDataDir: string): integer;  
 {$endif}
begin
  Result := -1;
  if assigned(sak) then
  begin
   sak.isloaded := True;
  end
  else
  begin
    sak := TSAK.Create(nil);
    sak.isWorking := True;
    sak.isloaded := False;
    if directoryexists(eSpeakDataDir) then
    begin
      Result := 0;
      sak.ES_DataDirectory := eSpeakDataDir;
    end;
      {$ifdef windows}
       {$else}
    if (Result = 0) and (fileexists(PortaudioLib)) then
    begin
      Result := 0;
      sak.PA_Library := PortaudioLib;
    end;
        {$endif}
    if (Result = 0) and (fileexists(eSpeakexe)) then
    begin
      Result := 0;
      sak.ES_Exe := eSpeakexe;
    end;
   end;
  if (Result = 0) or (sak.isloaded = True) then
  begin
    sak.isworking := True;
    Result := sak.loadlib;
  end;
end;

/// Load with custom sakit dir
function SAKLoadLib(SakitDir: string): integer;
begin
 Result := -1;
 if directoryexists(SakitDir) then
 begin
   if assigned(sak) then
  begin
    sak.isloaded := True;
  end
  else
  begin
    sak := TSAK.Create(nil);
    sak.isloaded := False;
    sak.ES_DataDirectory := SakitDir;
    
   {$ifdef windows}

    Result := -1;
      if fileexists(SakitDir + '\libwin32\espeak.exe') then
    begin
      sak.ES_Exe := SakitDir + '\libwin32\espeak.exe';
      Result := 0;
    end;
           {$endif}
         {$IF DEFINED(Linux) and  defined(cpu64)}
     if fileexists(SakitDir + '/liblinux64/libportaudio_x64.so') then
    begin
      sak.PA_Library := SakitDir + '/liblinux64/libportaudio_x64.so';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
       if fileexists( SakitDir +  '/liblinux64/speak_x64') then
      begin
        sak.ES_Exe := SakitDir +  '/liblinux64/speak_x64';
        Result := 0;
        fpchmod(SakitDir +  '/liblinux64/speak_x64', S_IRWXU);
      end;
    end;
     {$endif}
      {$IF DEFINED(Linux) and defined(cpu86) }
      if fileexists(SakitDir +  '/liblinux32/libportaudio_x86.so') then
    begin
      sak.PA_Library := SakitDir +  '/liblinux32/libportaudio_x86.so';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
     if fileexists(SakitDir +  '/liblinux32/speak_x86') then
      begin
        sak.ES_Exe := SakitDir +  '/liblinux32/speak_x86';
        Result := 0;
        fpchmod(SakitDir +  '/liblinux32/speak_x86', S_IRWXU);
      end;
    end;
                {$endif}

        {$IF DEFINED(freebsd) and  defined(cpu64)}
   if fileexists(SakitDir + '/libfreebsd64/libportaudio_x64.so') then
    begin
      sak.PA_Library := SakitDir + '/libfreebsd64/libportaudio_x64.so';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
       if fileexists(SakitDir + '/libfreebsd64/libespeak_x64.so') then
      begin
        sak.ES_Library := SakitDir + '/libfreebsd64/libespeak_x64.so';
        Result := 0;
      end;
    end;

    if Result = 0 then
    begin
      Result := -1;
       if fileexists(SakitDir + '/libfreebsd64/speak_x64') then
      begin
        sak.ES_Exe := SakitDir + '/libfreebsd64/speak_x64';
        Result := 0;
      //  fpchmod(ordir + '/sakit/libfreebsd64/speak_x64', S_IRWXU);
      end;
    end;
     {$endif}
      {$IF DEFINED(freebsd) and defined(cpu86) }
 
    if fileexists(SakitDir + '/libfreebsd32/libportaudio_x86.so') then
    begin
      sak.PA_Library := SakitDir + '/libfreebsd32/libportaudio_x86.so';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
      if fileexists(SakitDir + 'libfreebsd32/libespeak_x86.so') then
      begin
        sak.ES_Library := SakitDir + '/libfreebsd32/libespeak_x86.so';
        Result := 0;
      end;
    end;

    if Result = 0 then
    begin
      Result := -1;
     if fileexists(SakitDir + 'libfreebsd32/speak_x86') then
      begin
        sak.ES_Exe := SakitDir + '/libfreebsd32/speak_x86';
        Result := 0;
       // fpchmod(ordir + '/sakit/libfreebsd32/speak_x86', S_IRWXU);
      end;
    end;
                {$endif}

     {$IFDEF Darwin}
     if fileexists(SakitDir + '/libmac32/libportaudio_32.dylib') then
    begin
      sak.PA_Library := SakitDir + '/libmac32/libportaudio_32.dylib';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
     if fileexists(SakitDir + '/libmac32/speak') then
      begin
        sak.ES_Exe := SakitDir + '/libmac32/speak';
        Result := 0;
        fpchmod(SakitDir + '/libmac32/speak', S_IRWXU);
      end;
    end;
                {$endif}
  end;

  if (Result = 0) or (sak.isloaded = True) then
  begin
    sak.isworking := True;
    Result := sak.loadlib;
  end;
  
  end else  Result := -1;

end;

//////////////

function SAKLoadLib: integer;
var
  ordir: string;
begin
  Result := -1;
  if assigned(sak) then
  begin
    sak.isloaded := True;
  end
  else
  begin
    sak := TSAK.Create(nil);
    sak.isloaded := False;
    ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
   {$ifdef windows}
    sak.ES_DataDirectory := ordir + '\sakit';
     {$else}
    sak.ES_DataDirectory := ordir + '/sakit';
       {$endif}

   {$ifdef windows}

    Result := -1;
    if fileexists(ordir + 'espeak.exe') then
    begin
      Result := 0;
      sak.ES_Exe := ordir + 'espeak.exe';
    end
    else
    if fileexists(ordir + '\sakit\libwin32\espeak.exe') then
    begin
      sak.ES_Exe := ordir + '\sakit\libwin32\espeak.exe';
      Result := 0;
    end;
           {$endif}
         {$IF DEFINED(Linux) and  defined(cpu64)}
    if fileexists(ordir + 'libportaudio_x64.so') then
    begin
      Result := 0;
      sak.PA_Library := ordir + 'libportaudio_x64.so';
    end
    else
    if fileexists(ordir + '/sakit/liblinux64/libportaudio_x64.so') then
    begin
      sak.PA_Library := ordir + '/sakit/liblinux64/libportaudio_x64.so';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
      if fileexists(ordir + 'speak_x64') then
      begin
        Result := 0;
        sak.ES_Exe := ordir + 'speak_x64';
        fpchmod(ordir + 'speak_x64', S_IRWXU);
      end
      else
      if fileexists(ordir + '/sakit/liblinux64/speak_x64') then
      begin
        sak.ES_Exe := ordir + '/sakit/liblinux64/speak_x64';
        Result := 0;
        fpchmod(ordir + '/sakit/liblinux64/speak_x64', S_IRWXU);
      end;
    end;
     {$endif}
      {$IF DEFINED(Linux) and defined(cpu86) }
    if fileexists(ordir + 'libportaudio_x86.so') then
    begin
      Result := 0;
      sak.PA_Library := ordir + 'libportaudio_x86.so';
    end
    else
    if fileexists(ordir + '/sakit/liblinux32/libportaudio_x86.so') then
    begin
      sak.PA_Library := ordir + '/sakit/liblinux32/libportaudio_x86.so';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
      if fileexists(ordir + 'speak_x86') then
      begin
        Result := 0;
        sak.ES_Exe := ordir + 'speak_x86';
        fpchmod(ordir + 'speak_x86', S_IRWXU);
      end
      else
      if fileexists(ordir + '/sakit/liblinux32/speak_x86') then
      begin
        sak.ES_Exe := ordir + '/sakit/liblinux32/speak_x86';
        Result := 0;
        fpchmod(ordir + '/sakit/liblinux32/speak_x86', S_IRWXU);
      end;
    end;
                {$endif}

        {$IF DEFINED(freebsd) and  defined(cpu64)}
    if fileexists(ordir + 'libportaudio_x64.so') then
    begin
      Result := 0;
      sak.PA_Library := ordir + 'libportaudio_x64.so';
    end
    else
    if fileexists(ordir + '/sakit/libfreebsd64/libportaudio_x64.so') then
    begin
      sak.PA_Library := ordir + '/sakit/libfreebsd64/libportaudio_x64.so';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
      if fileexists(ordir + 'libespeak_x64.so') then
      begin
        Result := 0;
        sak.ES_Library := ordir + 'libespeak_x64.so';
      end
      else
      if fileexists(ordir + '/sakit/libfreebsd64/libespeak_x64.so') then
      begin
        sak.ES_Library := ordir + '/sakit/libfreebsd64/libespeak_x64.so';
        Result := 0;
      end;
    end;

    if Result = 0 then
    begin
      Result := -1;
      if fileexists(ordir + 'speak_x64') then
      begin
        Result := 0;
        sak.ES_Exe := ordir + 'speak_x64';
       // fpchmod(ordir + 'speak_x64', S_IRWXU);
      end
      else
      if fileexists(ordir + '/sakit/libfreebsd64/speak_x64') then
      begin
        sak.ES_Exe := ordir + '/sakit/libfreebsd64/speak_x64';
        Result := 0;
      //  fpchmod(ordir + '/sakit/libfreebsd64/speak_x64', S_IRWXU);
      end;
    end;
     {$endif}
      {$IF DEFINED(freebsd) and defined(cpu86) }
    if fileexists(ordir + 'libportaudio_x86.so') then
    begin
      Result := 0;
      sak.PA_Library := ordir + 'libportaudio_x86.so';
    end
    else
    if fileexists(ordir + '/sakit/libfreebsd32/libportaudio_x86.so') then
    begin
      sak.PA_Library := ordir + '/sakit/libfreebsd32/libportaudio_x86.so';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
      if fileexists(ordir + 'libspeak_x86.so') then
      begin
        Result := 0;
        sak.ES_Library := ordir + 'libespeak_x86.so';
      end
      else
      if fileexists(ordir + '/sakit/libfreebsd32/libespeak_x86.so') then
      begin
        sak.ES_Library := ordir + '/sakit/libfreebsd32/libespeak_x86.so';
        Result := 0;
      end;
    end;

    if Result = 0 then
    begin
      Result := -1;
      if fileexists(ordir + 'speak_x86') then
      begin
        Result := 0;
        sak.ES_Exe := ordir + 'speak_x86';
        // fpchmod(ordir + 'speak_x86', S_IRWXU);
      end
      else
      if fileexists(ordir + '/sakit/libfreebsd32/speak_x86') then
      begin
        sak.ES_Exe := ordir + '/sakit/libfreebsd32/speak_x86';
        Result := 0;
       // fpchmod(ordir + '/sakit/libfreebsd32/speak_x86', S_IRWXU);
      end;
    end;
                {$endif}

     {$IFDEF Darwin}
    if fileexists(ordir + 'libportaudio_32.dylib') then
    begin
      Result := 0;
      sak.PA_Library := ordir + 'libportaudio_32.dylib';
    end
    else
    if fileexists(ordir + '/sakit/libmac32/libportaudio_32.dylib') then
    begin
      sak.PA_Library := ordir + '/sakit/libmac32/libportaudio_32.dylib';
      Result := 0;
    end;

    if Result = 0 then
    begin
      Result := -1;
      if fileexists(ordir + 'speak') then
      begin
        Result := 0;
        sak.ES_Exe := ordir + 'speak';
        fpchmod(ordir + 'speak', S_IRWXU);
      end
      else
      if fileexists(ordir + '/sakit/libmac32/speak') then
      begin
        sak.ES_Exe := ordir + '/sakit/libmac32/speak';
        Result := 0;
        fpchmod(ordir + '/sakit/libmac32/speak', S_IRWXU);
      end;
    end;
                {$endif}
  end;

  if (Result = 0) or (sak.isloaded = True)
   then
  begin
    sak.isworking := True;
    Result := sak.loadlib;
  end;

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
begin
  WhatCh := WhatChar(Sender.getinstance, info);

  if trim(WhatCh) <> '' then
  begin
    TheSender := Sender.getinstance;
    TheKeyInfo := info;
    thetimer.Enabled := False;
    thetimer.interval := 6000;
    thetimer.ontimer := @ontimerkey;
    thetimer.Enabled := True;
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
    thetimer.interval := 600;
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

constructor TSAK.Create(const agrid: tstringgrid);
begin
  assistiveserver := iassistiveserver(self);
end;
///////////////// loading sak

function TSAK.LoadLib: integer;
begin
  Result := -1;
  old8087cw := Get8087CW;
  isenabled := False;
  voice_language:= '';
  voice_gender:= '' ;
  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
  Set8087CW($133f);
  if sak.isloaded = True then
    Result := 0
  else
  begin
  {$ifdef windows}
    Result := 0;
       {$else}
    if not fileexists(PA_Library) then
      Result := -2
    else
    begin
      Pa_Handle := DynLibs.LoadLibrary(PA_Library);
      if Pa_Handle <> DynLibs.NilHandle then
        Result := 0
      else
        Result := -21;
    end;

    {$ifdef freebsd}
    if not fileexists(ES_Library) then
      Result := -4
    else
    begin
      ES_Handle := DynLibs.LoadLibrary(ES_Library);
      if ES_Handle <> DynLibs.NilHandle then
        Result := 0
      else
        Result := -41;
    end;
    {$endif}
   
    if Result = 0 then
    begin
    {$endif}
      if not fileexists(ES_Exe) then
        Result := -3
      else
      if Result = 0 then
      begin
        thetimer := ttimer.Create(nil);
        thetimer.interval := 500000;
        thetimer.tag := 0;
        thetimer.Enabled := False;
      end;
    {$ifdef windows}
       {$else}
    end;
       {$endif}
  end;

  if Result > -1 then
  begin
    sak.isloaded := True;
    espeak_Key('sak is working...');
    isenabled := True;
  end
  else
    Result := -31;
end;

function SAKUnLoadLib: integer;
var
  i: integer;
begin
result := -1;
  isenabled := False;
  if assigned(sak) then
  begin
     SakCancel;
   
    sak.TheTimer.Enabled := False;
    
    freeandnil(sak.TheTimer);
 
      {$IF not DEFINED(Windows)}
    sleep(100);
    DynLibs.UnloadLibrary(sak.Pa_Handle);
    sak.Pa_Handle := DynLibs.NilHandle;
     {$IF DEFINED(freebsd)}
    DynLibs.UnloadLibrary(sak.ES_Handle);
    ES_Handle := DynLibs.NilHandle;
        {$endif}
         {$endif}
   Set8087CW(sak.old8087cw);
   freeandnil(sak);
   assistiveserver := nil;
    result := 0;
  end;
end;

////////////////////// Voice Config Procedures ///////////////
function SAKSetVoice(gender: shortint; language: string): integer;
begin
result := -1;
if assigned(sak) then
begin
  if gender = 1 then
    sak.voice_gender := 'm3'
  else
  sak.voice_gender := 'f2';
  sak.voice_language := language;
  result := 0;
end;
end;

////////////////////// Speecher Procedures ////////////////
function TSAK.espeak_key(Text: string): integer;
begin
result := -1;
  AProcess := TProcess.Create(nil);
  AProcess.Executable :=
  tosysfilepath(filepath(trim(sak.ES_Exe), fk_file, True));
  
  if (voice_gender = '') and (voice_language = '') then
  else
 if (voice_gender <> '') and (voice_language = '') then
  AProcess.Parameters.Add('-v' + voice_gender) else
 if (voice_gender = '') and (voice_language <> '') then
  AProcess.Parameters.Add('-v' + voice_language) else
 if (voice_gender <> '') and (voice_language <> '') then
  AProcess.Parameters.Add('-v' + voice_language + '+' + voice_gender);
  
  AProcess.Parameters.Add('--path=' + sak.ES_DataDirectory);
  AProcess.Parameters.Add('"' + Text + '"');
  AProcess.Options := AProcess.Options + [poNoConsole, poUsePipes];
  AProcess.FreeOnRelease;
  AProcess.Execute;
  if AProcess <> nil then result := 0;
end;

//// custom speecher procedure => to use also as extra-speecher
function SAKSay(Text: string): integer;
begin
  Result := sak.espeak_Key(Text);
end;

/// cancel current speech
function SakCancel: integer;
begin
result := -1;
 if assigned(sak) then
  if assigned(sak.AProcess) then
  begin
    sak.AProcess.Terminate(0);
    freeandnil(sak.AProcess);
    result := 0;
    end;
end;

///////////// Enabled procedure
function SakIsEnabled(): boolean;
begin
  Result := isenabled;
end;

end.
