{This for loading/managing plugin

 Fred van Stappen / fiens@hotmail.com
}

Unit plugmanager;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

Interface

Uses 
{$IFDEF UNIX}
cthreads, {$ENDIF}
Process, conffpgui, msefileutils, make,
Classes,
SysUtils;


{  // for future libraries
type
   TPlugin = class(TThread)
  protected
  procedure Execute; override;
 function execute(athread: tmsethread): integer; override;
     public
  constructor Create(CreateSuspended: boolean;
      const StackSize: SizeUInt = DefaultStackSize);
end;

procedure fpgd_mainproc();
}

Function DoBeautifier(Const AFilename: String; formatengine: integer;
                      backup: boolean): boolean;

Procedure RunCustomCompiled(Const AFilename: String; acompiler: String);

Procedure RunWithoutDebug(Const AFilename: String; Aparam: String);

// for fpGUI
Procedure LoadfpgDesigner(Const AfpgFilename: String);

Procedure CleanfpgDesigner();


{ for future libraries
function fpgd_loadlib(const libfilename: string): boolean; 
procedure fpgd_unloadlib;
procedure fpgd_hide();
procedure fpgd_close();
function fpgd_loadfile(afilename : PChar) : integer ;

var
fpgdlib_isloaded : boolean = false;
fpgdlib_enabled : boolean = true;
fpgdprog_enabled : boolean = false;
fpgplug : TPlugin ;
}

Var 
  iffpgdconsumed: boolean = False;

Implementation

Uses 
main, beauty;


{ // for libraries
 constructor TPlugin.Create(CreateSuspended: boolean;
  const StackSize: SizeUInt);
  begin
   inherited Create(CreateSuspended, StackSize);
  FreeOnTerminate := true;
    end;
 
 //// fpgui designer_ext
// function TPlugin.execute(athread: tmsethread): integer;
  procedure TPlugin.execute();
  begin
if fpgdlib_isloaded then
 h_fpgdxt.fpgdxtmainproc() ;
  end;  

function fpgd_loadlib(const libfilename: string): boolean;
begin
 fpgdlib_isloaded := h_fpgdxt.fpgdxtloadlib(libfilename);
 result := fpgdlib_isloaded ;
 fpgplug  := TPlugin.Create(false) ;
end;

procedure fpgd_unloadlib();
begin
h_fpgdxt.fpgdxtunloadlib() ;
fpgdlib_enabled := false;
end;

 procedure fpgd_hide(); 
 begin
   h_fpgdxt.fpgdxthide();
 end;
 
 procedure fpgd_close(); 
 begin
   h_fpgdxt.fpgdxtclose();
 end;
 
function fpgd_loadfile(afilename : PChar) : integer ;
 begin
  result := -1;
  if FileExists(afilename) then
  begin
  result := h_fpgdxt.fpgdxtloadfile(afilename);
  end;
  end;
 
  procedure fpgd_mainproc(); 
  begin
    //  fpgplug.execute(fpgplug);
       fpgplug.execute();
   end;
 }

Procedure RunCustomCompiled(Const AFilename: String; acompiler: String);

Var 
  dataf, dataf2, conso: string;
  len1: integer;
Begin

  If (acompiler = '') Or (acompiler = '1w') Or (acompiler = '3w') Then
    Begin
      If (acompiler = '') Then
        RunWithoutDebug(ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True))), acompiler)
      Else
        RunWithoutDebug(ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True))), 'wine');
    End
  Else
    Begin
      If fileexists(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True))) Then
        Begin
          dataf2 := ansistring(trim(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True))));
          len1 := pos('.', dataf2);

          If (acompiler = 'Pascal') Or (acompiler = 'C') Or (acompiler = '1') Or
             (acompiler = '3') Then
            Begin
 {$IFDEF Windows}
              dataf := copy(dataf2, 1, len1) + 'exe';
    {$else}
              dataf := copy(dataf2, 1, len1 - 1);
    {$endif}

              dataf := ansistring(tosysfilepath(filepath(UTF8Decode(trim(dataf)), fk_file, True)));

              If fileexists(dataf) Then
                Begin
                  RunWithoutDebug(dataf, '');
                End
              Else
                mainfo.setstattext(UTF8Decode(dataf + ' is not executable...'), mtk_notok);
            End;

          If (acompiler = 'Java') Or (acompiler = '2') Then
            Begin

              dataf := copy(dataf2, 1, len1 - 1);


              If fileexists(dataf + '.class') Then
                Begin

                  conso := ExtractFilePath(dataf);

                  dataf := copy(dataf, length(conso) + 1, length(dataf) - length(conso));

{$ifdef windows}
                  dataf := 'java.exe -Djava.library.path=. ' + dataf;
{$else}
                  dataf := 'java -Djava.library.path=. ' + dataf;
{$endif}

                  RunWithoutDebug(dataf, 'java');

                End
              Else
                mainfo.setstattext(UTF8Decode(dataf + '.class' + ' does not exist...'), mtk_notok);
            End;

          If (acompiler = 'Python') Or (acompiler = '4') Then
            Begin

              dataf := copy(dataf2, 1, len1 - 1);


              If fileexists(dataf + '.pywc') Then
                Begin

                  conso := ExtractFilePath(dataf);

                  dataf := copy(dataf, length(conso) + 1, length(dataf) - length(conso));

{$ifdef windows}
                  dataf := 'python.exe ' + dataf + '.pywc';
{$else}
                  dataf := 'python ' + dataf + '.pywc';
{$endif}

                  RunWithoutDebug(dataf, 'pywc');

                End
              Else
                mainfo.setstattext(UTF8Decode(dataf + '.pywc' + ' does not exist...'), mtk_notok);
            End;

        End;

    End;

End;


Procedure RunWithoutDebug(Const AFilename: String; Aparam: String);

Var 
  AProcess: TProcess;
  thecommand: string;
Begin

  If Aparam = 'cd' Then
    Begin
      AProcess := TProcess.Create(Nil);
      {$WARN SYMBOL_DEPRECATED OFF}
      AProcess.CommandLine := Aparam + ' ' + ansistring(tosysfilepath(
                              filepath(UTF8Decode(AFilename), fk_file, True)));
     {$WARN SYMBOL_DEPRECATED ON}
      AProcess.Priority := ppRealTime;
      AProcess.Options := [poNoConsole];
      AProcess.Execute;
      AProcess.Free;
    End
  Else

    If (Aparam = 'java') Then
      Begin
        AProcess := TProcess.Create(Nil);
      {$WARN SYMBOL_DEPRECATED OFF}
        AProcess.CommandLine := ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)));
     {$WARN SYMBOL_DEPRECATED ON}
        AProcess.Priority := ppRealTime;
        AProcess.Options := [poNoConsole];
        AProcess.Execute;
        AProcess.Free;
      End
  Else

    If (Aparam = 'pywc') Then
      Begin
        AProcess := TProcess.Create(Nil);
      {$WARN SYMBOL_DEPRECATED OFF}
        AProcess.CommandLine := ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)));
     {$WARN SYMBOL_DEPRECATED ON}
        AProcess.Priority := ppRealTime;
        AProcess.Options := [poNoConsole];
        AProcess.Execute;
        AProcess.Free;
      End
  Else

    If fileexists(ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)))) Then
      Begin
        If Aparam = 'wine' Then
          Begin
            Aparam := '';
            wineneeded := True;
          End;

        If (wineneeded = True) Then
          thecommand := 'wine ' + ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)))
        Else
          thecommand := ansistring(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)));
        AProcess := TProcess.Create(Nil);
      {$WARN SYMBOL_DEPRECATED OFF}
        AProcess.CommandLine := thecommand + Aparam;
     {$WARN SYMBOL_DEPRECATED ON}
        AProcess.Priority := ppRealTime;
        AProcess.Options := [poNoConsole];
        AProcess.Execute;
        AProcess.Free;
       // mainfo.setstattext('', mtk_flat);
      End
  Else
    mainfo.setstattext(UTF8Decode(AFilename) + ' does not exist...', mtk_notok);
End;

//Beautifier
Function DoBeautifier(Const AFilename: String; formatengine: integer; backup: boolean): boolean;

Var 
  plugpath, exename, param: string;
Begin

  result := false;

  plugpath := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) +
              'plugin' + directoryseparator ;

  tosysfilepath(filepath(UTF8Decode(plugpath), fk_file, True)) ;

  If backup Then
    CopyFile(tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)),
    tosysfilepath(filepath(UTF8Decode(AFilename), fk_file, True)) + '.bak_' +
     UTF8Decode(formatdatetime('YYYY_MM_DD_HH_mm_ss',now)))  ;

  If formatengine = 0 Then
    Begin
      exename := 'ptop';
      param := ' -c ' +
               ansistring(tosysfilepath(filepath(UTF8Decode(plugpath + exename +
               directoryseparator + exename + '.cfg '), fk_file, True))) + ' ';
               ;
     //writeln(param);          
    End
  Else
    Begin
      param := ' -inplace ';
      exename := 'jcf';
    End;

  //writeln('plugpath = ' + plugpath);
  //writeln('param = ' + param);

  plugpath := plugpath + exename +
              directoryseparator + exename ;

 {$IFDEF windows}
  plugpath := plugpath + '.exe';
{$ENDIF}

  plugpath := ansistring(tosysfilepath(filepath(UTF8Decode(plugpath), fk_file, True)));
  
 // writeln(plugpath);  
 
  If fileexists(tosysfilepath(filepath(UTF8Decode(trim(AFilename)),
     fk_file, True))) Then
    Begin
      result := true;
         
 //writeln(param + AFilename);  
  // beautyfo.filetoclean.value := plugpath + param + AFilename ;

      If formatengine = 0 Then
        RunWithoutDebug(plugpath, param + ansistring(tosysfilepath(filepath(UTF8Decode(trim(AFilename)),
     fk_file, True))) + ' ' + ansistring(tosysfilepath(filepath(utf8decode(trim(AFilename)),
     fk_file, True))))
      Else
        RunWithoutDebug(plugpath, param + ansistring(tosysfilepath((filepath(UTF8Decode(trim(AFilename)),
     fk_file, True)))));
    End;
End;

//fpGUI designer
Procedure LoadfpgDesigner(Const AfpgFilename: String);

Var 
  dataf: string;
Begin
  If fileexists(tosysfilepath(filepath(trim(conffpguifo.fpguidesigner.Value),
     fk_file, True))) Then
    Begin
      If ((iffpgdconsumed = False) And (AfpgFilename = 'quit')) Or
         ((iffpgdconsumed = False) And (AfpgFilename = 'closeall')) Or
         ((iffpgdconsumed = False) And (AfpgFilename = 'hideit')) Then
      Else
        If (fileexists(tosysfilepath(filepath(UTF8Decode(AfpgFilename), fk_file, True)))) Or
           (AfpgFilename = 'closeall') Or (AfpgFilename = 'quit') Or
           (AfpgFilename = 'showit') Or (AfpgFilename = 'hideit') Then
          Begin
            iffpgdconsumed := True;
            dataf := ansistring(tosysfilepath(filepath(trim(conffpguifo.fpguidesigner.Value),
                     fk_file, True)));
            If (fileexists(tosysfilepath(filepath(UTF8Decode(AfpgFilename), fk_file, True)))) Then
              RunWithoutDebug(dataf, ' ' +
                              ansistring(tosysfilepath(filepath(UTF8Decode(AfpgFilename), fk_file, True))))
            Else
              RunWithoutDebug(dataf, ' ' + ansistring(AfpgFilename));
          End;
    End;
End;

//fpGUI designer
Procedure CleanfpgDesigner();
{$ifdef unix}

Var 
  dataf: string;
  {$endif}
Begin
 {$ifdef unix}
  dataf := '/usr/bin/killall';
  RunWithoutDebug(dataf, ' designer_ext');
   {$endif}
End;

End.
