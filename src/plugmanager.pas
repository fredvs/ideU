{This for loading/managing plugin

 Fred van Stappen / fiens@hotmail.com
}

unit plugmanager;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
{$IFDEF UNIX}
cthreads, {$ENDIF}
  Process,
  conffpgui,
  msefileutils,
{$IFDEF darwin}
msegui, commandorform, {$ENDIF}
  make,
  Classes,
  SysUtils;

function DoBeautifier(const AFilename: string; formatengine: integer; backup: Boolean): Boolean;

procedure RunCustomCompiled(const AFilename: string; acompiler: string);

procedure RunWithoutDebug(const AFilename: string; Aparam: string);

{$ifdef darwin}
procedure RunWithoutDebugMac(Const AFilename: String; Aparam: String);
{$endif}

// for fpGUI
procedure LoadfpgDesigner(const AfpgFilename: string);

procedure CleanfpgDesigner();

var
  iffpgdconsumed: Boolean = False;

implementation

uses
 {$ifdef darwin}
main, beauty, projectoptionsform, messageform ;
 {$else}
  main,
  beauty;

 {$endif}


procedure RunCustomCompiled(const AFilename: string; acompiler: string);
var
  dataf, dataf2, conso: string;
  len1: integer;
begin
  {$ifdef darwin}
  if (acompiler = 'macos') then
    RunWithoutDebugMac(ansistring(tosysfilepath(filepath(UTF8Decode(ansistring(AFilename)), fk_file,
    True))), acompiler)
  else
   {$endif}
  if (acompiler = '') or (acompiler = '1w') or (acompiler = '3w') then
  begin
    if (acompiler = '') then
      RunWithoutDebug(ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True))),
        acompiler)
    else
      RunWithoutDebug(ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True))),
        'wine');
  end
  else if fileexists(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True))) then
  begin
    dataf2 := ansistring(trim(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True))));
    len1   := pos('.', dataf2);

    if (acompiler = 'Pascal') or (acompiler = 'C') or (acompiler = '1') or
      (acompiler = '3') then
    begin
    {$IFDEF Windows}
      dataf := copy(dataf2, 1, len1) + 'exe';
    {$else}
      dataf := copy(dataf2, 1, len1 - 1);
    {$endif}

      dataf := ansistring(tosysfilepath(filepath(UTF8Decode(trim(dataf)), fk_file, True)));

      if fileexists(dataf) then
        RunWithoutDebug(dataf, '')
      else
        mainfo.setstattext(UTF8Decode(dataf + ' is not executable...'), mtk_notok);
    end;

    if (acompiler = 'Java') or (acompiler = '2') then
    begin

      dataf := copy(dataf2, 1, len1 - 1);

      if fileexists(dataf + '.class') then
      begin

        conso := ExtractFilePath(dataf);

        dataf := copy(dataf, length(conso) + 1, length(dataf) - length(conso));

{$ifdef windows}
        dataf := 'java.exe -Djava.library.path=. ' + dataf;
{$else}
        dataf := 'java -Djava.library.path=. ' + dataf;
{$endif}

        RunWithoutDebug(dataf, 'java');

      end
      else
        mainfo.setstattext(UTF8Decode(dataf + '.class' + ' does not exist...'), mtk_notok);
    end;

    if (acompiler = 'Python') or (acompiler = '4') then
    begin

      dataf := copy(dataf2, 1, len1 - 1);

      if fileexists(dataf + '.pywc') then
      begin

        conso := ExtractFilePath(dataf);

        dataf := copy(dataf, length(conso) + 1, length(dataf) - length(conso));

{$ifdef windows}
                   dataf := 'python.exe ' + dataf + '.pywc';
{$else}
        dataf := 'python ' + dataf + '.pywc';
{$endif}

        RunWithoutDebug(dataf, 'pywc');

      end
      else
        mainfo.setstattext(UTF8Decode(dataf + '.pywc' + ' does not exist...'), mtk_notok);
    end;
  end;
end;

{$ifdef darwin}
procedure RunWithoutDebugMac(Const AFilename: String; Aparam: String);

var 
  AProcess: TProcess;
  thecommand: string;
  AStringList: TStringList;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;
  OutputStream, OutputStream2 : TStream;

begin
  if Aparam = 'wine' then
    begin
      Aparam := '';
      wineneeded := True;
    end;

  if (wineneeded = True) then
    thecommand := 'wine ' + ansistring(tosysfilepath(filepath(UTF8Decode(ansistring(AFilename)),
                  fk_file, True)))
  else
    thecommand := ansistring(tosysfilepath(filepath(UTF8Decode(ansistring(AFilename)), fk_file, True
                  )));
  AProcess := TProcess.Create(Nil);

        {$WARN SYMBOL_DEPRECATED OFF}
  AProcess.CommandLine := ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True))) ;
       {$WARN SYMBOL_DEPRECATED ON}

  AProcess.Options := [poUsePipes];

  messagefo.messages.clear;

  application.processmessages;

  AProcess.Execute;

  AStringList := TStringList.Create;

  OutputStream := TMemoryStream.Create;

  repeat
    BytesRead := AProcess.Output.Read(Buffer, 2048);

    OutputStream.write(Buffer, BytesRead);

    OutputStream2 := OutputStream;

    OutputStream2.Position := 0;

    AStringList.LoadFromStream(OutputStream2);

    messagefo.addtext(AStringList.text);

    application.processmessages;

  until BytesRead = 0;
 
  messagefo.messages.clear;

  OutputStream.Position := 0;
  
  AStringList.LoadFromStream(OutputStream);

  messagefo.addtext(AStringList.text);

  //   application.processmessages; 

  mainfo.setstattext('Process done', mtk_flat);

  debuggerfo.project_make.Enabled := True;

  AStringList.Free;
  AProcess.Free;
  OutputStream.Free;
end;
{$endif}

procedure RunWithoutDebug(const AFilename: string; Aparam: string);
var
  AProcess: TProcess;
  thecommand: string;
begin
 {$ifdef darwin}
  if (Aparam = 'macos') then
    RunWithoutDebugMac(ansistring(tosysfilepath(filepath(UTF8Decode(ansistring(AFilename)), fk_file,
    True))), Aparam)
  else
   {$endif}
  if Aparam = 'cd' then
  begin
    AProcess          := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
    AProcess.CommandLine := Aparam + ' ' + ansistring(tosysfilepath(
      filepath(UTF8Decode(AFilename), fk_file, True)));
     {$WARN SYMBOL_DEPRECATED ON}
    AProcess.Priority := ppRealTime;
    AProcess.Options  := [poNoConsole];
    AProcess.Execute;
    AProcess.Free;
  end
  else if (Aparam = 'java') then
  begin
    AProcess          := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
    AProcess.CommandLine := ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file,
      True)));
     {$WARN SYMBOL_DEPRECATED ON}
    AProcess.Priority := ppRealTime;
    AProcess.Options  := [poNoConsole];
    AProcess.Execute;
    AProcess.Free;
  end
  else if (Aparam = 'pywc') then
  begin
    AProcess          := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
    AProcess.CommandLine := ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file,
      True)));
     {$WARN SYMBOL_DEPRECATED ON}
    AProcess.Priority := ppRealTime;
    AProcess.Options  := [poNoConsole];
    AProcess.Execute;
    AProcess.Free;
  end
  else if fileexists(ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)))) then
  begin
    if Aparam = 'wine' then
    begin
      Aparam     := '';
      wineneeded := True;
    end;

    if (wineneeded = True) then
      thecommand := 'wine ' + ansistring(tosysfilepath(filepath(UTF8Decode(AFilename),
        fk_file, True)))
    else
      thecommand := ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)));

    AProcess := TProcess.Create(nil);

    {$WARN SYMBOL_DEPRECATED OFF}
    AProcess.CommandLine := thecommand + Aparam;
    {$WARN SYMBOL_DEPRECATED ON}

    //AProcess.Executable := ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)));
    // AProcess.Parameters.Add(Aparam);

    AProcess.Priority := ppRealTime;
    AProcess.Options  := [poNoConsole];
    AProcess.Execute;
    AProcess.Free;
    // mainfo.setstattext('', mtk_flat);
  end
  else
    mainfo.setstattext(UTF8Decode(AFilename) + ' does not exist...', mtk_notok);
end;

//Beautifier
function DoBeautifier(const AFilename: string; formatengine: integer; backup: Boolean): Boolean;
var
  plugpath, exename, param: string;
begin

  Result := False;

  plugpath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
    'plugin' + directoryseparator;

  tosysfilepath(filepath(UTF8Decode(plugpath), fk_file, True));

  if backup then
    CopyFile(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)),
      tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)) + '.bak_' +
      UTF8Decode(formatdatetime('YYYY_MM_DD_HH_mm_ss', now)));

  if formatengine = 0 then
  begin
    exename := 'ptop';
    param   := ' -c ' +
      ansistring(tosysfilepath(filepath(UTF8Decode(plugpath + exename +
      directoryseparator + exename + '.cfg '), fk_file, True))) + ' ';
    ;
    //writeln(param);          
  end
  else
  begin
    param   := ' -inplace ';
    exename := 'jcf';
  end;

  //writeln('plugpath = ' + plugpath);
  //writeln('param = ' + param);

  plugpath := plugpath + exename +
    directoryseparator + exename;

 {$IFDEF windows}
  plugpath := plugpath + '.exe';
 {$ENDIF}

  plugpath := ansistring(tosysfilepath(filepath(UTF8Decode(plugpath), fk_file, True)));

  // writeln(plugpath);  

  if fileexists(tosysfilepath(filepath(UTF8Decode(trim(AFilename)),
    fk_file, True))) then
  begin
    Result := True;

    //writeln(param + AFilename);  
    // beautyfo.filetoclean.value := plugpath + param + AFilename ;

    if formatengine = 0 then
      RunWithoutDebug(plugpath, param + ansistring(tosysfilepath(filepath(UTF8Decode(trim(
        AFilename)),
        fk_file, True))) + ' ' + ansistring(tosysfilepath(filepath(utf8decode(trim(AFilename)),
        fk_file, True))))
    else
      RunWithoutDebug(plugpath, param + ansistring(tosysfilepath((filepath(UTF8Decode(trim(
        AFilename)),
        fk_file, True)))));
  end;
end;

//fpGUI designer
procedure LoadfpgDesigner(const AfpgFilename: string);
var
  dataf: string;
begin
  if fileexists(tosysfilepath(filepath(trim(conffpguifo.fpguidesigner.Value),
    fk_file, True))) then
    if ((iffpgdconsumed = False) and (AfpgFilename = 'quit')) or
      ((iffpgdconsumed = False) and (AfpgFilename = 'closeall')) or
      ((iffpgdconsumed = False) and (AfpgFilename = 'hideit')) then
    else if (fileexists(tosysfilepath(filepath(UTF8Decode(AfpgFilename), fk_file, True)))) or
      (AfpgFilename = 'closeall') or (AfpgFilename = 'quit') or
      (AfpgFilename = 'showit') or (AfpgFilename = 'hideit') then
    begin
      iffpgdconsumed := True;
      dataf          := ansistring(tosysfilepath(filepath(trim(conffpguifo.fpguidesigner.Value)
        ,
        fk_file, True)));
      if (fileexists(tosysfilepath(filepath(UTF8Decode(AfpgFilename), fk_file, True)))) then
        RunWithoutDebug(dataf, ' ' +
          ansistring(tosysfilepath(filepath(UTF8Decode(AfpgFilename), fk_file,
          True))))
      else
        RunWithoutDebug(dataf, ' ' + ansistring(AfpgFilename));
    end;
end;

//fpGUI designer
procedure CleanfpgDesigner();
{$ifdef unix}

var 
  dataf: string;
  {$endif}
begin
 {$ifdef unix}
  dataf := '/usr/bin/killall';
  RunWithoutDebug(dataf, ' designer_ext');
   {$endif}
end;

end.

