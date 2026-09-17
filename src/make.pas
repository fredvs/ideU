unit make;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$R-}{$Q-}
interface

uses
  mseconsts,
  msestockobjects,
  captionideu,
  msestrings,
  msetypes,
  msesystypes,
  msegraphedits,
  msepipestream;

procedure domake(atag: integer);
procedure abortmake;
function making: Boolean;
function buildmakecommandline(const atag: integer): string;

// fred
function customcommandline(const aname: filenamety; const acompiler, acompilertag, atag: integer): string;
procedure customdomake(aname: filenamety; acompiler, acompilertag, atag: integer);
function addmessagetext(const Sender: tpipereader; const procid: pprocidty): string;


procedure dodownload;
procedure abortdownload;
function downloading: Boolean;
function downloadresult: integer;
function runscript(const script: filenamety; const clearscreen, setmakedir: Boolean): Boolean;

var
  wineneeded: Boolean = False;
{$if defined(darwin) or defined(dragonfly)}
 targetcons: boolean = false;
{$endif}

implementation

uses
  mseprocutils,
  main,
  projectoptionsform,
  SysUtils,
  msegrids,
  confcompiler,
  sourceform,
  mseeditglob,
  msefileutils,
  msesys,
  msesysutils,
  msegraphics,
  messageform,
  msedesignintf,
  msedesigner,
  plugmanager,
  mseprocmonitor,
  mseevent,
  confideu,
  Classes,
  mclasses,
  mseclasses,
  mseapplication,
  msestream,
  msegui,
  actionsmodule;

type
  tprogrunner = class(tactcomponent)
  private
    fexitcode: integer;
    fmessagefile: ttextstream;
    fnofilecopy: Boolean;
    ffinished: Boolean;
    fmessagefinished: Boolean;
    fsetmakedir: Boolean;
    messagepipe: tpipereader;
  protected
    fcanceled: Boolean;
    procid: integer;
    procedure doasyncevent(var atag: integer); override;
    procedure inputavailable(const Sender: tpipereader);
    procedure messagefinished(const Sender: tpipereader);
    procedure dofinished; virtual;
    function getcommandline: ansistring; virtual;
    procedure runprog(const acommandline: string);
  public
    constructor Create(const aowner: TComponent; const clearscreen, setmakedir: Boolean); reintroduce;
    destructor Destroy; override;
  end;

  tscriptrunner = class(tprogrunner)
  private
    fscriptpath: filenamety;
  protected
    function getcommandline: ansistring; override;
    procedure dofinished; override;
  public
    constructor Create(const aowner: TComponent; const ascriptpath: filenamety; const clearscreen, setmakedir: Boolean);
    property exitcode: integer read fexitcode;
    property canceled: Boolean read fcanceled;
  end;

  makestepty = (maks_before, maks_make, maks_after, maks_finished);

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
    constructor Create(atag: integer); reintroduce;
  end;

  tcustommaker = class(tprogrunner)
  private
    ftargettimestamp: tdatetime;
    fmaketag: integer;
    fstep: makestepty;
    fscriptnum: integer;
    fcurrentdir: filenamety;
    fmainfile: filenamety;
    fcompiler: integer;
    fcompilertag: integer;

  protected
    procedure doasyncevent(var atag: integer); override;
    procedure dofinished; override;
    function getcommandline: ansistring; override;
  public
    constructor Create(aname: filenamety; acompiler: integer; acompilertag: integer; atag: integer); reintroduce;
  end;

  tloader = class(tprogrunner)
  protected
    procedure dofinished; override;
    function getcommandline: ansistring; override;
  public
    constructor Create(aowner: TComponent);
  end;

var
  maker: tmaker;
  loader: tloader;
  // fred
  custommaker: tcustommaker;

function making: Boolean;
begin
  Result := (maker <> nil) and (maker.procid <> invalidprochandle);
end;

function downloading: Boolean;
begin
  Result := (loader <> nil) and (loader.procid <> invalidprochandle);
end;

function downloadresult: integer;
begin
  Result   := -1;
  if loader <> nil then
    Result := loader.fexitcode;
end;

procedure killmake;
begin
  FreeAndNil(maker);
  FreeAndNil(custommaker);
end;

procedure killload;
begin
  FreeAndNil(loader);
end;

procedure domake(atag: integer);
var
  bo1: Boolean;
begin
  killmake;
  bo1 := False;
  designnotifications.beforemake(idesigner(designer), atag, bo1);
  if not bo1 then
  begin
    maker := tmaker.Create(atag);
    messagefo.Show;
  {
   if confideufo.usedefaulteditoroptions.value then
              begin
              if confideufo.closemessages.value then messagefo.hide;
              end else
              begin
              if projectoptions.o.closemessages then messagefo.hide;
              end;
   }
  end;
end;

procedure customdomake(aname: filenamety; acompiler, acompilertag, atag: integer);
var
  bo1: Boolean;
begin
  killmake;
  bo1 := False;
  designnotifications.beforemake(idesigner(designer), atag, bo1);
  if not bo1 then
  begin
    custommaker := tcustommaker.Create(aname, acompiler, acompilertag, atag);
    messagefo.Show;
  {
  if confideufo.usedefaulteditoroptions.value then
              begin
              if confideufo.closemessages.value then messagefo.hide;
              end else
              begin
              if projectoptions.o.closemessages then messagefo.hide;
             end;
   }
  end;
end;


procedure abortmake;
begin
  if (maker <> nil) or (custommaker <> nil) then
  begin
    actionsmo.finishcustom;
    killmake;
    mainfo.setstattext(lang_actionsmodule[Ord(ac_makeaborted)], mtk_error);
  end;
end;

procedure abortdownload;
begin
  if loader <> nil then
  begin
    killload;
    mainfo.setstattext(lang_actionsmodule[Ord(ac_downloadaborted)], mtk_error);
  end;
end;

{$IFDEF WINDOWS}
  {$PUSH}
  // Force safe -O2 rules exclusively for Windows under FPC trunk
  {$OPTIMIZATION LEVEL2}
  {$OPTIMIZATION NOREGVAR}
{$ENDIF}

function buildmakecommandline(const atag: integer): string;

  function normalizename(const aname: filenamety): filenamety;
  begin
    Result := tosysfilepath(filepath(trim(aname), fk_file, True));
  end;

var
  int1, int2, inttypecomp, acompiler: integer;
  str1, str2, strcompiler, strexecext, strwine, strextra: msestring;
begin
  strextra    := ' ';
  strwine     := '';
  wineneeded  := False;
  strexecext  := '';
  strcompiler := '';
  inttypecomp := 0;

  with projectoptions, o, texp do
  begin

    for int1 := 0 to high(compilerused) do
      if (atag and compilerusedon[int1] <> 0) and
        (compilerused[int1] <> '') then
        if (pos('Default', compilerused[int1]) > 0) or
          (trim(compilerused[int1]) = '${COMPILER}') then
          strcompiler := quotefilename(tosysfilepath(makecommand))
        else
        if (trim(compilerused[int1]) = 'Pascal Compiler 1') or
          (trim(compilerused[int1]) = 'Pascal 1') then
        begin
          acompiler := 1;
          if (confcompilerfo.twinep1.Value = True) and (confcompilerfo.twinep1.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.fpccompiler.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Pascal Compiler 2') or
          (trim(compilerused[int1]) = 'Pascal 2') then
        begin
          acompiler := 1;
          if (confcompilerfo.twinep2.Value = True) and (confcompilerfo.twinep2.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.fpccompiler2.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Pascal Compiler 3') or
          (trim(compilerused[int1]) = 'Pascal 3') then
        begin
          acompiler := 1;
          if (confcompilerfo.twinep3.Value = True) and (confcompilerfo.twinep3.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.fpccompiler3.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Pascal Compiler 4') or
          (trim(compilerused[int1]) = 'Pascal 4') then
        begin
          acompiler := 1;
          if (confcompilerfo.twinep4.Value = True) and (confcompilerfo.twinep4.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.fpccompiler4.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Pascal Compiler 5') or
          (trim(compilerused[int1]) = 'Pascal 5') then
        begin
          acompiler := 1;
          if (confcompilerfo.twinep5.Value = True) and (confcompilerfo.twinep5.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.fpccompiler5.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Pascal Compiler 6') or
          (trim(compilerused[int1]) = 'Pascal 6') then
        begin
          acompiler := 1;
          if (confcompilerfo.twinep6.Value = True) and (confcompilerfo.twinep6.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.fpccompiler6.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Pascal Compiler 7') or
          (trim(compilerused[int1]) = 'Pascal 7') then
        begin
          acompiler := 1;
          if (confcompilerfo.twinep7.Value = True) and (confcompilerfo.twinep7.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.fpccompiler7.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Pascal Compiler 8') or
          (trim(compilerused[int1]) = 'Pascal 8') then
        begin
          acompiler := 1;
          if (confcompilerfo.twinep8.Value = True) and (confcompilerfo.twinep8.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.fpccompiler8.Value));
        end
        else
        if (trim(compilerused[int1]) = 'C Compiler 1') or
          (trim(compilerused[int1]) = 'C 1') then
        begin
          acompiler := 3;
          if (confcompilerfo.twinec1.Value = True) and (confcompilerfo.twinec1.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.ccompiler.Value));
        end
        else
        if (trim(compilerused[int1]) = 'C Compiler 2') or
          (trim(compilerused[int1]) = 'C 2') then
        begin
          acompiler := 3;
          if (confcompilerfo.twinec2.Value = True) and (confcompilerfo.twinec2.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.ccompiler2.Value));
        end
        else
        if (trim(compilerused[int1]) = 'C Compiler 3') or
          (trim(compilerused[int1]) = 'C 3') then
        begin
          acompiler := 3;
          if (confcompilerfo.twinec3.Value = True) and (confcompilerfo.twinec3.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.ccompiler3.Value));
        end
        else
        if (trim(compilerused[int1]) = 'C Compiler 4') or
          (trim(compilerused[int1]) = 'C 4') then
        begin
          acompiler := 3;
          if (confcompilerfo.twinec4.Value = True) and (confcompilerfo.twinec4.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.ccompiler4.Value));
        end
        else
        if (trim(compilerused[int1]) = 'C Compiler 5') or
          (trim(compilerused[int1]) = 'C 5') then
        begin
          acompiler := 3;
          if (confcompilerfo.twinec5.Value = True) and (confcompilerfo.twinec5.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.ccompiler5.Value));
        end
        else
        if (trim(compilerused[int1]) = 'C Compiler 6') or
          (trim(compilerused[int1]) = 'C 6') then
        begin
          acompiler := 3;
          if (confcompilerfo.twinec6.Value = True) and (confcompilerfo.twinec6.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.ccompiler6.Value));
        end
        else
        if (trim(compilerused[int1]) = 'C Compiler 7') or
          (trim(compilerused[int1]) = 'C 7') then
        begin
          acompiler := 3;
          if (confcompilerfo.twinec7.Value = True) and (confcompilerfo.twinec7.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.ccompiler7.Value));
        end
        else
        if (trim(compilerused[int1]) = 'C Compiler 8') or
          (trim(compilerused[int1]) = 'C 8') then
        begin
          acompiler := 3;
          if (confcompilerfo.twinec8.Value = True) and (confcompilerfo.twinec8.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.ccompiler8.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Java Compiler 1') or
          (trim(compilerused[int1]) = 'Java 1') then
        begin
          acompiler   := 2;
          inttypecomp := 1;
          if (confcompilerfo.twinej1.Value = True) and (confcompilerfo.twinej1.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.javacompiler.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Java Compiler 2') or
          (trim(compilerused[int1]) = 'Java 2') then
        begin
          acompiler   := 2;
          inttypecomp := 1;
          if (confcompilerfo.twinej2.Value = True) and (confcompilerfo.twinej2.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.javacompiler2.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Java Compiler 3') or
          (trim(compilerused[int1]) = 'Java 3') then
        begin
          acompiler   := 2;
          inttypecomp := 1;
          if (confcompilerfo.twinej3.Value = True) and (confcompilerfo.twinej3.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.javacompiler3.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Java Compiler 4') or
          (trim(compilerused[int1]) = 'Java 4') then
        begin
          acompiler   := 2;
          inttypecomp := 1;
          if (confcompilerfo.twinej4.Value = True) and (confcompilerfo.twinej4.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.javacompiler4.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Python Compiler 1') or
          (trim(compilerused[int1]) = 'Python 1') then
        begin
          acompiler   := 2;
          inttypecomp := 2;
          if (confcompilerfo.twinepy1.Value = True) and (confcompilerfo.twinepy1.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.pythoncompiler.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Python Compiler 2') or
          (trim(compilerused[int1]) = 'Python 2') then
        begin
          acompiler   := 4;
          inttypecomp := 2;
          if (confcompilerfo.twinepy2.Value = True) and (confcompilerfo.twinepy2.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.pythoncompiler2.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Python Compiler 3') or
          (trim(compilerused[int1]) = 'Python 3') then
        begin
          acompiler   := 4;
          inttypecomp := 2;
          if (confcompilerfo.twinepy3.Value = True) and (confcompilerfo.twinepy3.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.pythoncompiler3.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Python Compiler 4') or
          (trim(compilerused[int1]) = 'Python 4') then
        begin
          acompiler   := 4;
          inttypecomp := 2;
          if (confcompilerfo.twinepy4.Value = True) and (confcompilerfo.twinepy4.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.pythoncompiler4.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Other Compiler 1') or
          (trim(compilerused[int1]) = 'Other 1') then
        begin
          acompiler := 5;
          if (confcompilerfo.twineo1.Value = True) and (confcompilerfo.twineo1.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.othercompiler.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Other Compiler 2') or
          (trim(compilerused[int1]) = 'Other 2') then
        begin
          acompiler := 5;
          if (confcompilerfo.twineo2.Value = True) and (confcompilerfo.twineo2.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.othercompiler2.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Other Compiler 3') or
          (trim(compilerused[int1]) = 'Other 3') then
        begin
          acompiler := 5;
          if (confcompilerfo.twineo3.Value = True) and (confcompilerfo.twineo3.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.othercompiler3.Value));
        end
        else
        if (trim(compilerused[int1]) = 'Other Compiler 4') or
          (trim(compilerused[int1]) = 'Other 4') then
        begin
          acompiler := 5;
          if (confcompilerfo.twineo4.Value = True) and (confcompilerfo.twineo4.Enabled = True) then
            strwine := 'wine ';
          strcompiler := strwine + quotefilename(tosysfilepath(confcompilerfo.othercompiler4.Value));
        end;

    int1       := 0;
    strexecext := '${EXEEXT}';
    expandprmacros1(strexecext);

    int1         := system.pos('${EXEEXT}', uppercase(targetfile));
    if int1 > 0 then
      targetfile := system.copy(targetfile, 0, int1 - 1);


    if int1 = 0 then
      int1       := system.pos(uppercase(strexecext), uppercase(targetfile));
    if int1 > 0 then
      targetfile := system.copy(targetfile, 0, int1 - 1);

    if inttypecomp = 1 then
      strexecext := '.java'
    else if inttypecomp = 2 then
      strexecext := '.pyw'
    else
      for int1 := 0 to high(exeused) do
        if (atag and exeusedon[int1] <> 0) then
          if (pos('Default', exeused[int1]) > 0) or
            (trim(exeused[int1]) = '${EXEEXT}') then
          begin
            strexecext := '${EXEEXT}';
            expandprmacros1(strexecext);
          end
          else
          if (trim(exeused[int1]) = 'No Extension') or
            (trim(exeused[int1]) = '') then
            strexecext := ''
          else
            strexecext := trim(exeused[int1]);

    //str1:= strcompiler;

    if (targetfile <> '') and (acompiler <> 3) then
    begin
      if (targpref <> '') and (targpref <> '-o') then
      begin
        if (Copy(targpref, 1, 2) = '-o') then
          str1 := strcompiler + ' ' +
            quotefilename(targpref + normalizename(targetfile + strexecext))
        else
          str1 := strcompiler + ' -o' +
            quotefilename(targpref + normalizename(targetfile + strexecext));
      end
      else if (targpref = '-o') or (targpref = '') then
        str1 := strcompiler + ' -o' +
          quotefilename(normalizename(targetfile + strexecext));
    end
    else
      str1   := strcompiler;

    int2 := high(unitdirs);
    int1 := high(unitdirson);
    if int1 < int2 then
      int2 := int1;
    for int1 := 0 to int2 do
      if (atag and unitdirson[int1] <> 0) and
        (unitdirs[int1] <> '') then
      begin
        str2   := normalizename(unitdirs[int1]);
        if unitdirson[int1] and $10000 <> 0 then
          str1 := str1 + ' ' + quotefilename(unitpref + str2);
        if unitdirson[int1] and $20000 <> 0 then
          str1 := str1 + ' ' + quotefilename(incpref + str2);
        if unitdirson[int1] and $40000 <> 0 then
          str1 := str1 + ' ' + quotefilename(libpref + str2);
        if unitdirson[int1] and $80000 <> 0 then
          str1 := str1 + ' ' + quotefilename(objpref + str2);
      end;
    for int1 := 0 to high(makeoptions) do
      if (atag and makeoptionson[int1] <> 0) and
        (makeoptions[int1] <> '') then
        if makeoptionson[int1] and $10000 <> 0 then
          strextra := strextra + ' ' + makeoptions[int1]
        else
          str1     := str1 + ' ' + makeoptions[int1];
    // if  acompiler <> 3 then
    str1 := trim(str1) + ' ' + quotefilename(normalizename(mainfile));
  end;
  if strwine = 'wine ' then
    wineneeded := True;
  Result       := ansistring(trim(str1 + strextra));
end;


/// fred
function customcommandline(const aname: filenamety; const acompiler, acompilertag, atag: integer): string;

  function normalizename(const aname: filenamety): filenamety;
  begin
    Result := tosysfilepath(filepath(trim(aname), fk_file, True));
  end;

var
  int1, int2, int3, int4: integer;
  str1, str2, str3, str4: msestring;
  commandcompiler: msestring;
  winestr: msestring = '';
  extrastr: msestring = ' ';
begin

  wineneeded := False;

  int4 := 0;

  with projectoptions, o, texp do
  begin
    commandcompiler := '';

    case acompiler of
      1: case acompilertag of
          1:
          begin
            if confcompilerfo.twinep1.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.fpccompiler.Value;
          end;
          2:
          begin
            if confcompilerfo.twinep2.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.fpccompiler2.Value;
          end;
          3:
          begin
            if confcompilerfo.twinep3.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.fpccompiler3.Value;
          end;
          4:
          begin
            if confcompilerfo.twinep4.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.fpccompiler4.Value;
          end;
          5:
          begin
            if confcompilerfo.twinep5.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.fpccompiler5.Value;
          end;
          6:
          begin
            if confcompilerfo.twinep6.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.fpccompiler6.Value;
          end;
          7:
          begin
            if confcompilerfo.twinep7.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.fpccompiler7.Value;
          end;
          8:
          begin
            if confcompilerfo.twinep8.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.fpccompiler8.Value;
          end;
        end;// fpc compiler


      2:
      begin // java
        int4 := 1;
        case acompilertag of
          1:
          begin
            if confcompilerfo.twinej1.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.javacompiler.Value;
          end;
          2:
          begin
            if confcompilerfo.twinej2.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.javacompiler2.Value;
          end;
          3:
          begin
            if confcompilerfo.twinej3.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.javacompiler3.Value;
          end;
          4:
          begin
            if confcompilerfo.twinej4.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.javacompiler4.Value;
          end;
        end;
      end;

      3: case acompilertag of
          1:
          begin
            if confcompilerfo.twinec1.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.ccompiler.Value;
          end;
          2:
          begin
            if confcompilerfo.twinec2.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.ccompiler2.Value;
          end;
          3:
          begin
            if confcompilerfo.twinec3.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.ccompiler3.Value;
          end;
          4:
          begin
            if confcompilerfo.twinec4.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.ccompiler4.Value;
          end;
          5:
          begin
            if confcompilerfo.twinec5.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.ccompiler5.Value;
          end;
          6:
          begin
            if confcompilerfo.twinec6.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.ccompiler6.Value;
          end;
          7:
          begin
            if confcompilerfo.twinec7.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.ccompiler7.Value;
          end;
          8:
          begin
            if confcompilerfo.twinec8.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.ccompiler8.Value;
          end;
        end;// C


      4:
      begin // python
        int4 := 2;
        case acompilertag of
          1:
          begin
            if confcompilerfo.twinepy1.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.pythoncompiler.Value;
          end;
          2:
          begin
            if confcompilerfo.twinepy2.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.pythoncompiler2.Value;
          end;
          3:
          begin
            if confcompilerfo.twinepy3.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.pythoncompiler3.Value;
          end;
          4:
          begin
            if confcompilerfo.twinepy4.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.pythoncompiler4.Value;
          end;
        end;
      end;

      5: case acompilertag of
          1:
          begin
            if confcompilerfo.twineo1.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.othercompiler.Value;
          end;
          2:
          begin
            if confcompilerfo.twineo2.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.othercompiler2.Value;
          end;
          3:
          begin
            if confcompilerfo.twineo3.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.othercompiler3.Value;
          end;
          4:
          begin
            if confcompilerfo.twineo4.Value = True then
              winestr       := 'wine ';
            commandcompiler := confcompilerfo.othercompiler4.Value;
          end;
        end;// other

    end;

    if int4 = 1 then
      str4 := '.java'
    else if int4 = 2 then
      str4 := '.pyw'
    else
      for int3 := 0 to high(exeused) do
        if (atag and exeusedon[int3] <> 0) then
          if (pos('Default', exeused[int3]) > 0) or
            (trim(exeused[int3]) = '${EXEEXT}') then
          begin
            str4 := '${EXEEXT}';
            expandprmacros1(str4);
          end
          else
          if (trim(exeused[int3]) = 'No Extension') or
            (trim(exeused[int3]) = '') then
            str4 := ''
          else
            str4 := trim(exeused[int3]);

    if int4 = 2 then
      str3 := quotefilename(tosysfilepath(commandcompiler)) + ' -v -m py_compile'
    else // python
      str3 := quotefilename(tosysfilepath(commandcompiler));

    str1 := str3;

    str3 := aname;

    if winestr = 'wine ' then
      wineneeded := True;

    if acompiler <> 3 then
      str1 := winestr + str1 + ' ' +
        quotefilename(normalizename(str3))
    else
      str1 := winestr + str1 + ' ';

    int2 := high(unitdirs);
    int1 := high(unitdirson);
    if int1 < int2 then
      int2 := int1;

    if atag <> 0 then
    begin

      for int1 := 0 to int2 do
        if (atag and unitdirson[int1] <> 0) and
          (unitdirs[int1] <> '') then
        begin
          str2   := normalizename(unitdirs[int1]);
          if unitdirson[int1] and $10000 <> 0 then
            str1 := str1 + ' ' + quotefilename(unitpref + str2);
          if unitdirson[int1] and $20000 <> 0 then
            str1 := str1 + ' ' + quotefilename(incpref + str2);
          if unitdirson[int1] and $40000 <> 0 then
            str1 := str1 + ' ' + quotefilename(libpref + str2);
          if unitdirson[int1] and $80000 <> 0 then
            str1 := str1 + ' ' + quotefilename(objpref + str2);
        end;

      for int1 := 0 to high(makeoptions) do
        if (atag and makeoptionson[int1] <> 0) and
          (makeoptions[int1] <> '') then
          if makeoptionson[int1] and $10000 <> 0 then
            extrastr := extrastr + ' ' + makeoptions[int1]
          else
            str1     := str1 + ' ' + makeoptions[int1];
    end;

    // str1:= str1 + ' ' + quotefilename(normalizename(removefileext(aname)+str4));
    // if acompiler <> 3 then
    // str1:= trim(str1) + ' ' + quotefilename(normalizename(removefileext(aname)+str4)) else
    str1 := trim(str1) + ' ' + normalizename(aname);
  end;
  str1   := trim(str1 + extrastr);
  // writeln(str1);
  Result := ansistring(str1);
end;

{$IFDEF WINDOWS}
  {$POP}
{$ENDIF}

procedure dodownload;
begin
  killload;
 {
  if confideufo.usedefaulteditoroptions.value then
              begin
              if confideufo.closemessages.value then messagefo.hide;
              end else
              begin
              if projectoptions.o.closemessages then messagefo.hide;
             end;
}
  loader := tloader.Create(nil);
end;

function runscript(const script: filenamety; const clearscreen, setmakedir: Boolean): Boolean;
var
  runner: tscriptrunner;
begin
  Result := script = '';
  if not Result then
  begin
    runner   := tscriptrunner.Create(nil, script, clearscreen, setmakedir);
    try
      Result := not runner.canceled and (runner.fexitcode = 0);
    finally
      runner.Release;
    end;
  end;
end;

{ tprogrunner }

constructor tprogrunner.Create(const aowner: TComponent; const clearscreen, setmakedir: Boolean);
begin
  inherited Create(aowner);
  with projectoptions, o.texp do
  begin
    if o.copymessages and (messageoutputfile <> '') and not fnofilecopy then
      fmessagefile := ttextstream.Create(messageoutputfile, fm_create);
    messagepipe    := tpipereader.Create;
    messagepipe.oninputavailable :=
{$ifdef FPC}
      @
{$endif}
      inputavailable;
    messagepipe.onpipebroken :=
{$ifdef FPC}
      @
{$endif}
      messagefinished;
    if clearscreen then
      messagefo.Messages.rowcount := 0;
    procid      := invalidprochandle;
    fsetmakedir := setmakedir;
    runprog(getcommandline);
  end;
end;

destructor tprogrunner.Destroy;
begin
  if (procid <> invalidprochandle) then
  begin
    try
      killprocess(procid);
    except
    end;
    procid := invalidprochandle;
  end;
  messagepipe.Free;
  fmessagefile.Free;
  inherited;
end;

procedure tprogrunner.runprog(const acommandline: string);
var
  wdbefore: filenamety;
begin
  fmessagefinished := False;
  ffinished        := False;

 {$ifdef darwin}
 procid:= 0;
 {$else}
  procid := invalidprochandle;
 {$endif}

 {$if defined(dragonfly)}
 fexitcode:= 0;
 {$else}
  fexitcode := 1;
 {$endif}

  with projectoptions, o.texp do
  begin
    if fsetmakedir and (makedir <> '') then
      wdbefore := setcurrentdirmse(makedir);
    try
 {$if defined(darwin) or defined(dragonfly)}
  targetcons  := false;
  RunCustomCompiled(ansistring(acommandline), 'macos');
 {$else}
      procid   := execmse2(UTF8Decode(acommandline), nil, messagepipe, messagepipe, -1, [exo_inactive, exo_tty]);
 {$endif}

    except
      on e1: Exception do
      begin
        fcanceled   := True;
        if e1 is eoserror then
          fexitcode := eoserror(e).error
{$warnings off}
{$warnings on}
        ;
        application.handleexception(nil, lang_actionsmodule[Ord(ac_runerrorwith)] + ' "' +
          UTF8Decode(acommandline) + '": ');
      end;
    end;
    if fsetmakedir and (makedir <> '') then
      setcurrentdirmse(wdbefore);
  end;
end;

procedure tprogrunner.doasyncevent(var atag: integer);
begin
  if getprocessexitcode(procid, fexitcode, 5000000) <> pee_ok then
  begin
    messagefo.Messages.appendrow([lang_actionsmodule[Ord(ac_errortimeout)]]);
    messagefo.Messages.appendrow(['']);
    killprocess(procid);
  end;
  procid := invalidprochandle;
end;

procedure tprogrunner.dofinished;
begin
  ffinished := True;
  asyncevent(0);
end;

procedure tprogrunner.messagefinished(const Sender: tpipereader);
begin
  fmessagefinished := True;
  dofinished;
end;

function addmessagetext(const Sender: tpipereader; const procid: pprocidty): string;
var
  str1: string;
begin
  str1 := Sender.readdatastring;
  while application.checkoverload(-1) do
  begin
    if (procid <> nil) and (procid^ = invalidprochandle) then
      Exit;
    application.unlock;
    sleepus(100000);
    application.lock;
  end;
  messagefo.addtext(str1);
  Result := str1;
end;

procedure tprogrunner.inputavailable(const Sender: tpipereader);
var
  str1: string;
begin
  str1 := addmessagetext(Sender, @procid);
  if fmessagefile <> nil then
    fmessagefile.writestr(str1);
end;

function tprogrunner.getcommandline: ansistring;
begin
  Result := ''; //dummy
end;

 { tmaker }

constructor tmaker.Create(atag: integer);
begin
  fstep       := maks_before;
  fmaketag    := atag;
  ftargettimestamp := getfilemodtime(gettargetfile);
  fcurrentdir := getcurrentdirmse;
  inherited Create(nil, True, True);
  if procid <> invalidprochandle then
  begin

    actionsmo.initproject;
    //mainfo.setstattext(actionsmo.c[ord(ac_making)],mtk_running);

 {$if not defined(darwin) and not defined(dragonfly)}
    mainfo.setstattext(lang_actionsmodule[Ord(ac_making)] + ' ' + gettargetfile + '...', mtk_making);
 {$endif}

    messagefo.Messages.font.options := messagefo.Messages.font.options +
      [foo_nonantialiased];
  end
  else
  begin
    mainfo.setstattext(lang_actionsmodule[Ord(ac_makenotrunning)], mtk_error);
    designnotifications.aftermake(idesigner(designer), fexitcode);
    actionsmo.finishcustom;
  end;
end;

procedure tmaker.dofinished;
begin
  actionsmo.finishcustom;

  if ftargettimestamp <> getfilemodtime(gettargetfile) then
    mainfo.targetfilemodified;
  inherited;
end;

function tmaker.getcommandline: ansistring;
begin
  Result := '';
  with projectoptions, o do
  begin
    if fstep = maks_before then
    begin
      while fscriptnum <= high(befcommandon) do
      begin
        if (befcommandon[fscriptnum] and fmaketag <> 0) and
          (fscriptnum <= high(texp.befcommand)) then
        begin
          Result := ansistring(o.texp.befcommand[fscriptnum]);
          break;
        end;
        Inc(fscriptnum);
      end;
      if fscriptnum <= high(befcommandon) then
      begin
        Inc(fscriptnum);
        Exit;
      end
      else
        fstep := maks_make;
    end;
    if fstep = maks_make then
    begin
      Result     := buildmakecommandline(fmaketag);
      fscriptnum := 0;
      fstep      := maks_after;
      Exit;
    end;
    if fstep = maks_after then
    begin
      while fscriptnum <= high(aftcommandon) do
      begin
        if (aftcommandon[fscriptnum] and fmaketag <> 0) and
          (fscriptnum <= high(o.texp.aftcommand)) then
        begin
          Result := ansistring(o.texp.aftcommand[fscriptnum]);
          break;
        end;
        Inc(fscriptnum);
      end;
      if fscriptnum <= high(aftcommandon) then
      begin
        Inc(fscriptnum);
        Exit;
      end
      else
        fstep := maks_finished;
    end;
  end;
end;

procedure tmaker.doasyncevent(var atag: integer);

  procedure finished;
  begin
    setcurrentdirmse(fcurrentdir);
    designnotifications.aftermake(idesigner(designer), fexitcode);
    messagefo.Messages.font.options := messagefo.Messages.font.options +
      [foo_antialiased2];
  end;

var
  str1: string;
begin
  inherited;
  str1 := getcommandline;
  if (fstep = maks_finished) or (fexitcode <> 0) then
    finished
  else
  begin
    runprog(str1);
    if procid = invalidprochandle then
      finished;
  end;
end;

{ tcustommaker }
constructor tcustommaker.Create(aname: filenamety; acompiler: integer; acompilertag: integer; atag: integer);
begin
  fstep        := maks_before;
  fmaketag     := atag;
  ftargettimestamp := getfilemodtime(aname);
  fmainfile    := aname;
  fcompiler    := acompiler;
  fcompilertag := acompilertag;
  fcurrentdir  := getcurrentdirmse;
  inherited Create(nil, True, True);
  if procid <> invalidprochandle then
  begin
    // mainfo.setstattext(actionsmo.c[ord(ac_making)],mtk_running);

 {$if not defined(darwin) and not defined(dragonfly)}
    mainfo.setstattext(lang_actionsmodule[Ord(ac_making)] + ' ' + aname + '...', mtk_making);
 {$endif}

    messagefo.Messages.font.options := messagefo.Messages.font.options +
      [foo_nonantialiased];
  end
  else
  begin
    mainfo.setstattext(lang_actionsmodule[Ord(ac_makenotrunning)], mtk_error);
    designnotifications.aftermake(idesigner(designer), fexitcode);
  end;
end;

procedure tcustommaker.dofinished;
begin
  if ftargettimestamp <> getfilemodtime(fmainfile) then
    mainfo.targetfilemodified;
  inherited;
end;

function tcustommaker.getcommandline: ansistring;
begin
  Result := '';
  with projectoptions, o do
  begin
    if fstep = maks_before then
    begin
      while fscriptnum <= high(befcommandon) do
      begin
        if (befcommandon[fscriptnum] and fmaketag <> 0) and
          (fscriptnum <= high(texp.befcommand)) then
        begin
          Result := ansistring(o.texp.befcommand[fscriptnum]);
          break;
        end;
        Inc(fscriptnum);
      end;
      if fscriptnum <= high(befcommandon) then
      begin
        Inc(fscriptnum);
        Exit;
      end
      else
        fstep := maks_make;
    end;
    if fstep = maks_make then
    begin
      Result     := customcommandline(fmainfile, fcompiler, fcompilertag, fmaketag);
      fscriptnum := 0;
      fstep      := maks_after;
      Exit;
    end;
    if fstep = maks_after then
    begin
      while fscriptnum <= high(aftcommandon) do
      begin
        if (aftcommandon[fscriptnum] and fmaketag <> 0) and
          (fscriptnum <= high(o.texp.aftcommand)) then
        begin
          Result := ansistring(o.texp.aftcommand[fscriptnum]);
          break;
        end;
        Inc(fscriptnum);
      end;
      if fscriptnum <= high(aftcommandon) then
      begin
        Inc(fscriptnum);
        Exit;
      end
      else
        fstep := maks_finished;
    end;
  end;
end;

procedure tcustommaker.doasyncevent(var atag: integer);

  procedure finished;
  begin
    setcurrentdirmse(fcurrentdir);
    designnotifications.aftermake(idesigner(designer), fexitcode);
    messagefo.Messages.font.options := messagefo.Messages.font.options +
      [foo_antialiased2];
  end;

var
  str1: string;
begin
  inherited;
  str1 := getcommandline;
  if (fstep = maks_finished) or (fexitcode <> 0) then
    finished
  else
  begin
    runprog(str1);
    if procid = invalidprochandle then
      finished;
  end;
end;

{ tloader }

constructor tloader.Create(aowner: TComponent);
begin
  inherited Create(aowner, False, True);
  if procid <> invalidprochandle then
    mainfo.setstattext(lang_actionsmodule[Ord(ac_downloading)], mtk_making)
  else
    mainfo.setstattext(lang_actionsmodule[Ord(ac_downloadnotrunning)], mtk_error);
end;

procedure tloader.dofinished;
begin
  inherited;
end;

function tloader.getcommandline: ansistring;
begin
  Result := ansistring(projectoptions.d.texp.uploadcommand);
end;


{ tscriptrunner }

constructor tscriptrunner.Create(const aowner: TComponent; const ascriptpath: filenamety; const clearscreen: Boolean; const setmakedir: Boolean);
begin
  fscriptpath := tosysfilepath(ascriptpath);
  fnofilecopy := True;
  if clearscreen then
    messagefo.Messages.rowcount := 0;
  messagefo.Messages.appendrow(ascriptpath);
  messagefo.Messages.appendrow('');
  inherited Create(aowner, False, setmakedir);
  if not fcanceled then
    fcanceled := not application.waitdialog(nil, '"' + ascriptpath +
      ' ' + lang_actionsmodule[Ord(ac_running)],
      lang_actionsmodule[Ord(ac_script)], nil, nil, nil);
end;

function tscriptrunner.getcommandline: ansistring;
begin
  Result := ansistring(fscriptpath);
end;

procedure tscriptrunner.dofinished;
begin
  inherited;
  application.terminatewait;
end;

end.

