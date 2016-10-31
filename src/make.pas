unit make;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface
uses
 msestrings, msepipestream, msesystypes;
 
procedure domake(atag: integer);
procedure abortmake;
function making: boolean;
function buildmakecommandline(const atag: integer): string;

// fred
function customcommandline(const aname: filenamety; const acompiler, acompilertag, atag: integer) : string;
procedure customdomake( aname: filenamety; acompiler, acompilertag, atag: integer);
function addmessagetext(const sender: tpipereader;
                              const procid: pprocidty): string;
//

procedure dodownload;
procedure abortdownload;
function downloading: boolean;
function downloadresult: integer;
function runscript(const script: filenamety;
                             const clearscreen,setmakedir: boolean): boolean;

var
 wineneeded: boolean = false;
 
implementation
uses
 mseprocutils,main,projectoptionsform,sysutils,msegrids, confcompiler,
 sourceform,mseeditglob,msefileutils,msesys,
 msesysutils,msegraphics,messageform,msedesignintf,msedesigner,
 mseprocmonitor,mseevent,
 msetypes,classes,mclasses,mseclasses,mseapplication,msestream,
 msegui,actionsmodule;
 
type
 tprogrunner = class(tactcomponent)
  private
   fexitcode: integer;
   fmessagefile: ttextstream;
   fnofilecopy: boolean;
   ffinished: boolean;
   fmessagefinished: boolean;
   fsetmakedir: boolean;
   messagepipe: tpipereader;
  protected
   fcanceled: boolean;
   procid: integer;
   procedure doasyncevent(var atag: integer); override;
   procedure inputavailable(const sender: tpipereader);
   procedure messagefinished(const sender: tpipereader);
   procedure dofinished; virtual;
   function getcommandline: ansistring; virtual;
   procedure runprog(const acommandline: string);
  public
   constructor create(const aowner: tcomponent; const clearscreen,setmakedir: boolean); reintroduce;
   destructor destroy; override;
 end;

 tscriptrunner = class(tprogrunner)
  private
   fscriptpath: filenamety;
  protected
   function getcommandline: ansistring; override;
   procedure dofinished; override;
  public
   constructor create(const aowner: tcomponent; const ascriptpath: filenamety;
                                         const clearscreen,setmakedir: boolean);
   property exitcode: integer read fexitcode;
   property canceled: boolean read fcanceled;
 end;

 makestepty = (maks_before,maks_make,maks_after,maks_finished);
 
 tmaker = class(tprogrunner)
  private
   ftargettimestamp: tdatetime;
   fmaketag: integer;
   fstep: makestepty;
   fscriptnum: integer;
   fcurrentdir: filenamety;
  protected
   procedure doasyncevent(var atag: integer); override;
   procedure dofinished; override;
   function getcommandline: ansistring; override;
  public
   constructor create(atag: integer); reintroduce;
 end;
 
 tcustommaker = class(tprogrunner)
  private
   ftargettimestamp: tdatetime;
   fmaketag: integer;
   fstep: makestepty;
   fscriptnum: integer;
   fcurrentdir: filenamety;
   fmainfile : filenamety;
   fcompiler : integer;
   fcompilertag : integer;
   
  protected
   procedure doasyncevent(var atag: integer); override;
   procedure dofinished; override;
   function getcommandline: ansistring; override;
  public
   constructor create(aname: filenamety; acompiler: integer; acompilertag: integer; atag: integer); reintroduce;
 end;
 
 tloader = class(tprogrunner)
  protected
   procedure dofinished; override;
   function getcommandline: ansistring; override;
  public
   constructor create(aowner: tcomponent);
 end;
 
 var
 maker: tmaker;
 loader: tloader;
  // fred
 custommaker: tcustommaker;


function making: boolean;
begin
 result:= (maker <> nil) and (maker.procid <> invalidprochandle);
end;

function downloading: boolean;
begin
 result:= (loader <> nil) and (loader.procid <> invalidprochandle);
end;

function downloadresult: integer;
begin
 result:= -1;
 if loader <> nil then begin
  result:= loader.fexitcode;
 end;
end;

procedure killmake;
begin
 freeandnil(maker);
  freeandnil(custommaker);
end;

procedure killload;
begin
 freeandnil(loader);
end;

procedure domake(atag: integer);
var
 bo1: boolean;
begin
 killmake;
 bo1:= false;
 designnotifications.beforemake(idesigner(designer),atag,bo1);
 if not bo1 then begin
  maker:= tmaker.Create(atag);
  if projectoptions.o.closemessages then begin
   messagefo.messages.show;
  end;
 end;
end;

procedure customdomake( aname: filenamety; acompiler, acompilertag, atag: integer);
var
 bo1: boolean;
begin
 killmake;
 bo1:= false;
 designnotifications.beforemake(idesigner(designer),atag,bo1);
 if not bo1 then begin
  custommaker:= tcustommaker.Create(aname, acompiler, acompilertag, atag);
  if projectoptions.o.closemessages then begin
   messagefo.messages.show;
  end;
 end;
end;


procedure abortmake;
begin
 if (maker <> nil) or (custommaker <> nil) then begin
  actionsmo.finishcustom;
     killmake;
  mainfo.setstattext(actionsmo.c[ord(ac_makeaborted)],mtk_error);
 end;
end;

procedure abortdownload;
begin
 if loader <> nil then begin
  killload;
  mainfo.setstattext(actionsmo.c[ord(ac_downloadaborted)],mtk_error);
 end;
end;

function buildmakecommandline(const atag: integer): string;
 
 function normalizename(const aname: filenamety): filenamety;
 begin
  result:= tosysfilepath(filepath(trim(aname),fk_file,true));
 end;
 
var
 int1,int2, int3: integer;
 str1,str2,str3, str4, winestr : msestring;
// wstr1: filenamety;
begin
winestr := '';
wineneeded:= false;

 with projectoptions,o,texp do begin
 
for int3:= 0 to high(compilerused) do begin
   if (atag and compilerusedon[int3] <> 0) and
         (compilerused[int3] <> '') then begin
 
 if (pos('Default',compilerused[int3]) > 0) or 
  (trim(compilerused[int3]) = '${COMPILER}') then
    str3:= quotefilename(tosysfilepath(makecommand)) else
        
    if (trim(compilerused[int3]) = 'Pascal Compiler 1') or 
    (trim(compilerused[int3]) = 'Pascal 1') then
    begin
     if  confcompilerfo.twinep1.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.fpccompiler.value));
    end else
    
    if (trim(compilerused[int3]) = 'Pascal Compiler 2') or 
    (trim(compilerused[int3]) = 'Pascal 2') then
    begin
     if  confcompilerfo.twinep2.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.fpccompiler2.value));
    end else
    
    if (trim(compilerused[int3]) = 'Pascal Compiler 3') or 
    (trim(compilerused[int3]) = 'Pascal 3') then
    begin
     if  confcompilerfo.twinep3.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.fpccompiler3.value));
    end else
    
     if (trim(compilerused[int3]) = 'Pascal Compiler 4') or 
    (trim(compilerused[int3]) = 'Pascal 4') then
    begin
     if  confcompilerfo.twinep4.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.fpccompiler4.value));
    end  else
    
     if (trim(compilerused[int3]) = 'Pascal Compiler 5') or 
    (trim(compilerused[int3]) = 'Pascal 5') then
    begin
     if  confcompilerfo.twinep5.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.fpccompiler5.value));
    end  else
    
     if (trim(compilerused[int3]) = 'Pascal Compiler 6') or 
    (trim(compilerused[int3]) = 'Pascal 6') then
    begin
     if  confcompilerfo.twinep5.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.fpccompiler6.value));
    end  else
    
     if (trim(compilerused[int3]) = 'Pascal Compiler 7') or 
    (trim(compilerused[int3]) = 'Pascal 7') then
    begin
     if  confcompilerfo.twinep7.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.fpccompiler7.value));
    end  else
    
     if (trim(compilerused[int3]) = 'Pascal Compiler 8') or 
    (trim(compilerused[int3]) = 'Pascal 8') then
    begin
     if  confcompilerfo.twinep8.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.fpccompiler8.value));
    end  else
    
     if (trim(compilerused[int3]) = 'C Compiler 1') or 
    (trim(compilerused[int3]) = 'C 1') then
    begin
     if  confcompilerfo.twinec1.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.ccompiler.value));
    end else
    
    if (trim(compilerused[int3]) = 'C Compiler 2') or 
    (trim(compilerused[int3]) = 'C 2') then
    begin
     if  confcompilerfo.twinec2.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.ccompiler2.value));
    end else
    
    if (trim(compilerused[int3]) = 'C Compiler 3') or 
    (trim(compilerused[int3]) = 'C 3') then
    begin
     if  confcompilerfo.twinec2.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.ccompiler3.value));
    end else
    
     if (trim(compilerused[int3]) = 'C Compiler 4') or 
    (trim(compilerused[int3]) = 'C 4') then
    begin
     if  confcompilerfo.twinec4.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.ccompiler4.value));
    end else
    
     if (trim(compilerused[int3]) = 'C Compiler 5') or 
    (trim(compilerused[int3]) = 'C 5') then
    begin
     if  confcompilerfo.twinec5.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.ccompiler5.value));
    end else
    
    if (trim(compilerused[int3]) = 'C Compiler 6') or 
    (trim(compilerused[int3]) = 'C 6') then
    begin
     if  confcompilerfo.twinec6.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.ccompiler6.value));
    end else
    
    if (trim(compilerused[int3]) = 'C Compiler 7') or 
    (trim(compilerused[int3]) = 'C 7') then
    begin
     if  confcompilerfo.twinec7.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.ccompiler7.value));
    end else
    
     if (trim(compilerused[int3]) = 'C Compiler 8') or 
    (trim(compilerused[int3]) = 'C 8') then
    begin
     if  confcompilerfo.twinec8.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.ccompiler8.value));
    end else
    
     if (trim(compilerused[int3]) = 'Java Compiler 1') or 
    (trim(compilerused[int3]) = 'Java 1') then
     begin
     if  confcompilerfo.twinej1.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.javacompiler.value));
    end else
    
    if (trim(compilerused[int3]) = 'Java Compiler 2') or 
    (trim(compilerused[int3]) = 'Java 2') then
    begin
     if  confcompilerfo.twinej2.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.javacompiler2.value));
    end else
    
    if (trim(compilerused[int3]) = 'Java Compiler 3') or 
    (trim(compilerused[int3]) = 'Java 3') then
    begin
     if  confcompilerfo.twinej3.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.javacompiler3.value));
    end else
    
     if (trim(compilerused[int3]) = 'Java Compiler 4') or 
    (trim(compilerused[int3]) = 'Java 4') then
    begin
     if  confcompilerfo.twinej4.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.javacompiler4.value));
    end else
    
     if (trim(compilerused[int3]) = 'Python Compiler 1') or 
    (trim(compilerused[int3]) = 'Python 1') then
    begin
     if  confcompilerfo.twinepy1.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.pythoncompiler.value));
    end else
    
    if (trim(compilerused[int3]) = 'Python Compiler 2') or 
    (trim(compilerused[int3]) = 'Python 2') then
    begin
     if  confcompilerfo.twinepy2.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.pythoncompiler2.value));
    end else
    
    if (trim(compilerused[int3]) = 'Python Compiler 3') or 
    (trim(compilerused[int3]) = 'Python 3') then
   begin
     if  confcompilerfo.twinepy3.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.pythoncompiler3.value));
    end else
    
     if (trim(compilerused[int3]) = 'Python Compiler 4') or 
    (trim(compilerused[int3]) = 'Python 4') then
    begin
     if  confcompilerfo.twinepy4.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.pythoncompiler4.value));
    end else
    
    if (trim(compilerused[int3]) = 'Other Compiler 1') or 
    (trim(compilerused[int3]) = 'Other 1') then
    begin
     if  confcompilerfo.twineo1.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.othercompiler.value));
    end else
    
    if (trim(compilerused[int3]) = 'Other Compiler 2') or 
    (trim(compilerused[int3]) = 'Other 2') then
    begin
     if  confcompilerfo.twineo2.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.othercompiler2.value));
    end else
    
    if (trim(compilerused[int3]) = 'Other Compiler 3') or 
    (trim(compilerused[int3]) = 'Other 3') then
    begin
     if  confcompilerfo.twineo3.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.othercompiler3.value));
    end else
    
    if (trim(compilerused[int3]) = 'Other Compiler 4') or 
    (trim(compilerused[int3]) = 'Other 4') then
    begin
     if  confcompilerfo.twineo4.value = true then
     winestr := 'wine ';
    str3:=  winestr + quotefilename(tosysfilepath(confcompilerfo.othercompiler4.value));
    end;
    
    
   end;
  
  end;
  
   for int3:= 0 to high(exeused) do begin
   if (atag and exeusedon[int3] <> 0) then begin
  
  if (pos('Default',exeused[int3]) > 0) or    
  (trim(exeused[int3]) = '${EXEEXT}')
     then
    begin
    str4 := '${EXEEXT}';
    expandprmacros1(str4) end else
        
   if (trim(exeused[int3]) = 'No Extension') or
    (trim(exeused[int3]) = '')  then
    str4:= '' else str4:= trim(exeused[int3]) ;
   end;
  end;
 
  str1:= str3;
  if (targetfile <> '') and (targpref <> '') then begin
   str1:= str1 + ' '+quotefilename(targpref+normalizename(targetfile+str4));
  end;
  int2:= high(unitdirs);
  int1:= high(unitdirson);
  if int1 < int2 then begin
   int2:= int1;
  end;
  for int1:= 0 to int2 do begin
   if (atag and unitdirson[int1] <> 0) and
         (unitdirs[int1] <> '') then begin
    str2:= normalizename(unitdirs[int1]);
    if unitdirson[int1] and $10000 <> 0 then begin
     str1:= str1 + ' ' + quotefilename(unitpref+str2);
    end;
    if unitdirson[int1] and $20000 <> 0 then begin
     str1:= str1 + ' ' + quotefilename(incpref+str2);
    end;
    if unitdirson[int1] and $40000 <> 0 then begin
     str1:= str1 + ' ' + quotefilename(libpref+str2);
    end;
    if unitdirson[int1] and $80000 <> 0 then begin
     str1:= str1 + ' ' + quotefilename(objpref+str2);
    end;
   end;
  end;
  for int1:= 0 to high(makeoptions) do begin
   if (atag and makeoptionson[int1] <> 0) and
         (makeoptions[int1] <> '') then begin
    str1:= str1 + ' ' + makeoptions[int1];
   end;
  end;
  str1:= str1 + ' ' + quotefilename(normalizename(mainfile));
 end;
 if winestr = 'wine ' then wineneeded := true ;
   result:= str1;
end;

/// fred
function customcommandline(const aname: filenamety; const acompiler, acompilertag, atag: integer) : string;
 
 function normalizename(const aname: filenamety): filenamety;
 begin
  result:= tosysfilepath(filepath(trim(aname),fk_file,true));
 end;
 
var
 int1,int2, int3: integer;
 str1,str2,str3, str4: msestring;
 optionfilename, optionfilename2 : msestring;
 commandcompiler : msestring;
 winestr : msestring = '';

begin

wineneeded:= false;

 with projectoptions,o,texp do begin
 commandcompiler := '' ;
 
case acompiler of
1: begin // fpc compiler
case acompilertag of
1 : begin
    if confcompilerfo.twinep1.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.fpccompiler.value;
    end;
2 : begin
    if confcompilerfo.twinep2.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.fpccompiler2.value;
    end;
3 : begin
    if confcompilerfo.twinep3.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.fpccompiler3.value;
    end; 
4 : begin
    if confcompilerfo.twinep4.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.fpccompiler4.value;
    end;
5 : begin
    if confcompilerfo.twinep5.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.fpccompiler5.value;
    end;
6 : begin
    if confcompilerfo.twinep6.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.fpccompiler6.value;
    end;
7 : begin
    if confcompilerfo.twinep7.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.fpccompiler7.value;
    end; 
8 : begin
    if confcompilerfo.twinep8.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.fpccompiler8.value;
    end;
end;
end;

2: begin // java
case acompilertag of
1 : begin
    if confcompilerfo.twinej1.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.javacompiler.value;
    end;
2 : begin
    if confcompilerfo.twinej2.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.javacompiler2.value;
    end;
3 : begin
    if confcompilerfo.twinej3.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.javacompiler3.value;
    end; 
4 : begin
    if confcompilerfo.twinej4.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.javacompiler4.value;
    end;
end;
end;

3: begin // C
case acompilertag of
1 : begin
    if confcompilerfo.twinec1.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.ccompiler.value;
    end;
2 : begin
    if confcompilerfo.twinec2.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.ccompiler2.value;
    end;
3 : begin
    if confcompilerfo.twinec3.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.ccompiler3.value;
    end; 
4 : begin
    if confcompilerfo.twinec4.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.ccompiler4.value;
    end;
5 : begin
    if confcompilerfo.twinec5.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.ccompiler5.value;
    end;
6 : begin
    if confcompilerfo.twinec6.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.ccompiler6.value;
    end;
7 : begin
    if confcompilerfo.twinec7.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.ccompiler7.value;
    end; 
8 : begin
    if confcompilerfo.twinec8.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.ccompiler8.value;
    end;
end;
end;

4: begin // python
case acompilertag of
1 : begin
    if confcompilerfo.twinepy1.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.pythoncompiler.value;
    end;
2 : begin
    if confcompilerfo.twinepy2.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.pythoncompiler2.value;
    end;
3 : begin
    if confcompilerfo.twinepy3.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.pythoncompiler3.value;
    end;
4 : begin
    if confcompilerfo.twinepy4.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.pythoncompiler4.value;
    end;
end;
end;

5: begin // other
case acompilertag of
1 : begin
    if confcompilerfo.twineo1.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.othercompiler.value;
    end;
2 : begin
    if confcompilerfo.twineo2.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.othercompiler2.value;
    end;
3 : begin
    if confcompilerfo.twineo3.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.othercompiler3.value;
    end; 
4 : begin
    if confcompilerfo.twineo4.value = true then winestr := 'wine ';
    commandcompiler := confcompilerfo.othercompiler4.value;
    end;
end;
end;
end;

for int3:= 0 to high(exeused) do begin
   if (atag and exeusedon[int3] <> 0) then begin
  
   if (pos('Default',exeused[int3]) > 0) or           
 (trim(exeused[int3]) = '${EXEEXT}')  then
    begin
    str4 := '${EXEEXT}';
    expandprmacros1(str4) end else
        
   if (trim(exeused[int3]) = 'No Extension') or
    (trim(exeused[int3]) = '')  then
    str4:= '' else str4:= trim(exeused[int3]) ; 
 
   end; 
   
  end;


 
  str3:= quotefilename(tosysfilepath(commandcompiler));
  str1:= str3;
 
  str3 := aname ;
  
  if winestr = 'wine ' then wineneeded := true ;

 str1:= winestr + str1 + ' '+ quotefilename(normalizename(str3));

  int2:= high(unitdirs);
  int1:= high(unitdirson);
  if int1 < int2 then begin
   int2:= int1;
  end;
  for int1:= 0 to int2 do begin
   if (atag and unitdirson[int1] <> 0) and
         (unitdirs[int1] <> '') then begin
    str2:= normalizename(unitdirs[int1]);
    if unitdirson[int1] and $10000 <> 0 then begin
     str1:= str1 + ' ' + quotefilename(unitpref+str2);
    end;
    if unitdirson[int1] and $20000 <> 0 then begin
     str1:= str1 + ' ' + quotefilename(incpref+str2);
    end;
    if unitdirson[int1] and $40000 <> 0 then begin
     str1:= str1 + ' ' + quotefilename(libpref+str2);
    end;
    if unitdirson[int1] and $80000 <> 0 then begin
     str1:= str1 + ' ' + quotefilename(objpref+str2);
    end;
   end;
  end;
  for int1:= 0 to high(makeoptions) do begin
   if (atag and makeoptionson[int1] <> 0) and
         (makeoptions[int1] <> '') then begin
  
    str1:= str1 + ' ' + makeoptions[int1];
 
   end;
  end;
  str1:= str1 + ' ' + quotefilename(normalizename(removefileext(aname)+str4));
 end;
 result:= str1;
end;



procedure dodownload;
begin
 killload;
 if projectoptions.o.closemessages then begin
  messagefo.messages.show;
 end;
 loader:= tloader.create(nil);
end;

function runscript(const script: filenamety;
                            const clearscreen,setmakedir: boolean): boolean;
var
 runner: tscriptrunner;
begin
 result:= script = '';
 if not result then begin
  runner:= tscriptrunner.create(nil,script,clearscreen,setmakedir);
  try
   result:= not runner.canceled and (runner.fexitcode = 0);
  finally
   runner.release;
  end;
 end;
end;

{ tprogrunner }

constructor tprogrunner.create(const aowner: tcomponent; const clearscreen,setmakedir: boolean);
begin
 inherited create(aowner);
 with projectoptions,o.texp do begin
  if o.copymessages and (messageoutputfile <> '') and not fnofilecopy then begin
   fmessagefile:= ttextstream.create(messageoutputfile,fm_create);
  end;
  messagepipe:= tpipereader.create;
  messagepipe.oninputavailable:= {$ifdef FPC}@{$endif}inputavailable;
  messagepipe.onpipebroken:= {$ifdef FPC}@{$endif}messagefinished;
  if clearscreen then begin
   messagefo.messages.rowcount:= 0;
  end;
  procid:= invalidprochandle;
  fsetmakedir:= setmakedir;
   runprog(getcommandline);
   end;
end;

destructor tprogrunner.destroy;
begin
 if (procid <> invalidprochandle) then begin
  try
   killprocess(procid);
  except
  end;
  procid:= invalidprochandle;
 end;
 messagepipe.Free;
 fmessagefile.free;
 inherited;
end;

procedure tprogrunner.runprog(const acommandline: string);
var
 wdbefore: filenamety;
begin
 fexitcode:= 1; //defaulterror
 fmessagefinished:= false;
 ffinished:= false;
 
 procid:= invalidprochandle;
 with projectoptions,o.texp do begin
  if fsetmakedir and (makedir <> '') then begin
   wdbefore:= setcurrentdirmse(makedir);
  end;
  try
   procid:= execmse2(acommandline,nil,messagepipe,messagepipe,-1,
                                                   [exo_inactive,exo_tty]);
  except
   on e1: exception do begin
    fcanceled:= true;
    if e1 is eoserror then begin
{$warnings off}
     fexitcode:= eoserror(e).error;
{$warnings on}
    end;
    application.handleexception(nil,actionsmo.c[ord(ac_runerrorwith)]+
                                                          acommandline+'": ');
   end;
  end;
  if fsetmakedir and (makedir <> '') then begin
   setcurrentdirmse(wdbefore);
  end;
 end;
end;

procedure tprogrunner.doasyncevent(var atag: integer);
begin
 if getprocessexitcode(procid,fexitcode,5000000) <> pee_ok then begin
  messagefo.messages.appendrow([actionsmo.c[ord(ac_errortimeout)]]);
  messagefo.messages.appendrow(['']);
  killprocess(procid);
 end;
 procid:= invalidprochandle;
end;

procedure tprogrunner.dofinished;
begin
 ffinished:= true;
 asyncevent(0);
end;

procedure tprogrunner.messagefinished(const sender: tpipereader);
begin
 fmessagefinished:= true;
 dofinished;
end;

function addmessagetext(const sender: tpipereader;
                                         const procid: pprocidty): string;
var
 str1: string;
begin
 str1:= sender.readdatastring;
 while application.checkoverload(-1) do begin
  if (procid <> nil) and (procid^ = invalidprochandle) then begin
   exit;
  end;
  application.unlock;
  sleepus(100000);
  application.lock;
 end;
 messagefo.addtext(str1);
 result:= str1;
end;

procedure tprogrunner.inputavailable(const sender: tpipereader);
var
 str1: string;
begin
 str1:= addmessagetext(sender,@procid);
 if fmessagefile <> nil then begin
  fmessagefile.writestr(str1);
 end;
end;

function tprogrunner.getcommandline: ansistring;
begin
 result:= ''; //dummy
end;

{ tmaker }

constructor tmaker.create(atag: integer);
begin
 fstep:= maks_before;
 fmaketag:= atag;
 ftargettimestamp:= getfilemodtime(gettargetfile);
 fcurrentdir:= getcurrentdirmse;
 inherited create(nil,true,true);
 if procid <> invalidprochandle then begin

 actionsmo.initproject ;
 //mainfo.setstattext(actionsmo.c[ord(ac_making)],mtk_running);
 
  mainfo.setstattext('Making ' + gettargetfile + '...' ,mtk_making);
  
  messagefo.messages.font.options:= messagefo.messages.font.options +
                                                      [foo_nonantialiased];
 end
 else begin
   mainfo.setstattext(actionsmo.c[ord(ac_makenotrunning)],mtk_error);
  designnotifications.aftermake(idesigner(designer),fexitcode);
  actionsmo.finishcustom ;
 end;
end;

procedure tmaker.dofinished;
begin
 actionsmo.finishcustom ;
  
 if ftargettimestamp <> getfilemodtime(gettargetfile) then begin
  mainfo.targetfilemodified;
 end;
 inherited;
end;

function tmaker.getcommandline: ansistring;
begin
 result:= '';
 with projectoptions,o do begin
  if fstep = maks_before then begin
   while fscriptnum <= high(befcommandon) do begin
    if (befcommandon[fscriptnum] and fmaketag <> 0) and 
                           (fscriptnum <= high(texp.befcommand)) then begin
     result:= o.texp.befcommand[fscriptnum];
     break;
    end;
    inc(fscriptnum);
   end;
   if fscriptnum <= high(befcommandon) then begin
    inc(fscriptnum);
    exit;
   end
   else begin
    fstep:= maks_make;
   end;
  end;
  if fstep = maks_make then begin
   result:= buildmakecommandline(fmaketag);
   fscriptnum:= 0;
   fstep:= maks_after;
   exit;
  end;
  if fstep = maks_after then begin
   while fscriptnum <= high(aftcommandon) do begin
    if (aftcommandon[fscriptnum] and fmaketag <> 0) and 
                           (fscriptnum <= high(o.texp.aftcommand)) then begin
     result:= o.texp.aftcommand[fscriptnum];
     break;
    end;
    inc(fscriptnum);
   end;
   if fscriptnum <= high(aftcommandon) then begin
    inc(fscriptnum);
    exit;
   end
   else begin
    fstep:= maks_finished;
   end;
  end;
 end;
end;

procedure tmaker.doasyncevent(var atag: integer);
 procedure finished;
 begin
  setcurrentdirmse(fcurrentdir);
  designnotifications.aftermake(idesigner(designer),fexitcode);
  messagefo.messages.font.options:= messagefo.messages.font.options +
              [foo_antialiased2];
 end;
var
 str1: string;
begin
 inherited;
 str1:= getcommandline;
 if (fstep = maks_finished) or (fexitcode <> 0) then begin
  finished;
 end
 else begin
  runprog(str1);
  if procid = invalidprochandle then begin
   finished;
  end;
 end;
end;

{ tcustommaker }
constructor tcustommaker.create(aname: filenamety; acompiler: integer; acompilertag: integer; atag: integer);
begin
 fstep:= maks_before;
 fmaketag:= atag;
 ftargettimestamp:= getfilemodtime(aname);
 fmainfile := aname;
 fcompiler := acompiler;
 fcompilertag := acompilertag;
 fcurrentdir:= getcurrentdirmse;
 inherited create(nil,true,true);
 if procid <> invalidprochandle then begin
 // mainfo.setstattext(actionsmo.c[ord(ac_making)],mtk_running);
  mainfo.setstattext('Compiling ' + aname + '...' ,mtk_making);
    
  messagefo.messages.font.options:= messagefo.messages.font.options +
                                                      [foo_nonantialiased];
 end
 else begin
  mainfo.setstattext(actionsmo.c[ord(ac_makenotrunning)],mtk_error);
  designnotifications.aftermake(idesigner(designer),fexitcode);
 end;
end;

procedure tcustommaker.dofinished;
begin
 if ftargettimestamp <> getfilemodtime(fmainfile) then begin
  mainfo.targetfilemodified;
 end;
 inherited;
end;

function tcustommaker.getcommandline: ansistring;
begin
  result:= '';
 with projectoptions,o do begin
  if fstep = maks_before then begin
   while fscriptnum <= high(befcommandon) do begin
    if (befcommandon[fscriptnum] and fmaketag <> 0) and 
                           (fscriptnum <= high(texp.befcommand)) then begin
     result:= o.texp.befcommand[fscriptnum];
     break;
    end;
    inc(fscriptnum);
   end;
   if fscriptnum <= high(befcommandon) then begin
    inc(fscriptnum);
    exit;
   end
   else begin
    fstep:= maks_make;
   end;
  end;
  if fstep = maks_make then begin
  result:= customcommandline(fmainfile, fcompiler, fcompilertag, fmaketag);
   fscriptnum:= 0;
   fstep:= maks_after;
   exit;
  end;
  if fstep = maks_after then begin
   while fscriptnum <= high(aftcommandon) do begin
    if (aftcommandon[fscriptnum] and fmaketag <> 0) and 
                           (fscriptnum <= high(o.texp.aftcommand)) then begin
     result:= o.texp.aftcommand[fscriptnum];
     break;
    end;
    inc(fscriptnum);
   end;
   if fscriptnum <= high(aftcommandon) then begin
    inc(fscriptnum);
    exit;
   end
   else begin
    fstep:= maks_finished;
   end;
  end;
 end;
end;  

procedure tcustommaker.doasyncevent(var atag: integer);
 procedure finished;
 begin
  setcurrentdirmse(fcurrentdir);
  designnotifications.aftermake(idesigner(designer),fexitcode);
  messagefo.messages.font.options:= messagefo.messages.font.options +
              [foo_antialiased2];
 end;
var
 str1: string;
begin
 inherited;
 str1:= getcommandline;
 if (fstep = maks_finished) or (fexitcode <> 0) then begin
  finished;
 end
 else begin
  runprog(str1);
  if procid = invalidprochandle then begin
   finished;
  end;
 end;
end;

{ tloader }

constructor tloader.create(aowner: tcomponent);
begin
 inherited create(aowner,false,true);
 if procid <> invalidprochandle then begin
  mainfo.setstattext(actionsmo.c[ord(ac_downloading)],mtk_making);
 end
 else begin
  mainfo.setstattext(actionsmo.c[ord(ac_downloadnotrunning)],mtk_error);
 end;
end;

procedure tloader.dofinished;
begin
 inherited;
end;

function tloader.getcommandline: ansistring;
begin
 result:= projectoptions.d.texp.uploadcommand;
end;


{ tscriptrunner }

constructor tscriptrunner.create(const aowner: tcomponent;
               const ascriptpath: filenamety; const clearscreen: boolean;
               const setmakedir: boolean);
begin
 fscriptpath:= tosysfilepath(ascriptpath);
 fnofilecopy:= true;
 if clearscreen then begin
  messagefo.messages.rowcount:= 0;
 end;
 messagefo.messages.appendrow(ascriptpath);
 messagefo.messages.appendrow('');
 inherited create(aowner,false,setmakedir);
 if not fcanceled then begin
  fcanceled:= not application.waitdialog(nil,'"'+ascriptpath+
               actionsmo.c[ord(ac_running)],
     actionsmo.c[ord(ac_script)],nil,nil,nil);
 end;
end;

function tscriptrunner.getcommandline: ansistring;
begin
 result:= fscriptpath;
end;

procedure tscriptrunner.dofinished;
begin
 inherited;
 application.terminatewait;
end;

end.
