{This for loading/managing plugin

 Fred van Stappen / fiens@hotmail.com
}
unit plugmanager ;

interface

uses
{$IFDEF UNIX}
  cthreads, {$ENDIF}
  Process, conffpgui, msefileutils, make,
  classes,
  sysutils ;

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


procedure RunCustomCompiled(const AFilename: string; acompiler : string);

procedure RunWithoutDebug(const AFilename: string; Aparam: string);

// for fpGUI
procedure LoadfpgDesigner(const AfpgFilename: string);

procedure CleanfpgDesigner(); 

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

var
iffpgdconsumed : boolean = false ;

implementation

uses
main;

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
 
 procedure RunCustomCompiled(const AFilename: string; acompiler : string);
 var
  dataf, dataf2, dataf3, conso : string ;
  len1 : integer;
 begin
 
 if (acompiler = '') or (acompiler = '1w') or (acompiler = '3w') then
 begin
 if (acompiler = '') then RunWithoutDebug(AFilename, acompiler)
 else RunWithoutDebug(AFilename, 'wine');
 end 
 else
 begin
   if fileexists (AFilename) then
 begin 
dataf2 := trim(AFilename);
len1 := pos('.',dataf2) ;
 
if (acompiler = 'Pascal') or (acompiler = 'C') or (acompiler = '1') or (acompiler = '3')
then
begin
 {$IFDEF Windows} 
  dataf := copy(dataf2,1,len1) + 'exe' ; 
    {$else}
   dataf := copy(dataf2,1,len1-1) ;
    {$endif}
   
  dataf :=  tosysfilepath(filepath(trim(dataf),fk_file,true));
     
  if fileexists (dataf) then
  begin
     RunWithoutDebug(dataf, '') 
 end else mainfo.setstattext(dataf + ' is not executable...',mtk_notok);
 end;
 
if (acompiler = 'Java') or (acompiler = '2') then
begin
 
   dataf := copy(dataf2,1,len1-1) ;
   
    
  if fileexists (dataf+'.class') then
  begin
     
  conso := ExtractFilePath(dataf);
  
 //  writeln(conso);
  
 // RunWithoutDebug(conso, 'cd');
  
  dataf := copy(dataf,length(conso)+1,length(dataf)-length(conso)) ;
  
 // writeln(dataf);
{$ifdef windows}
dataf := 'java.exe -Djava.library.path=. ' + dataf; 
{$else}
dataf := 'java -Djava.library.path=. ' + dataf;
{$endif}
  
 // writeln(dataf);
  
  RunWithoutDebug(dataf, 'java');
  
  end else mainfo.setstattext(dataf+'.class' + ' does not exist...',mtk_notok);
end;

if (acompiler = 'Python') or (acompiler = '4') then
begin
 
   dataf := copy(dataf2,1,len1-1) ;
   
    
  if fileexists (dataf+'.pywc') then
  begin
     
  conso := ExtractFilePath(dataf);
  
 //  writeln(conso);
  
 // RunWithoutDebug(conso, 'cd');
  
  dataf := copy(dataf,length(conso)+1,length(dataf)-length(conso)) ;
  
 // writeln(dataf);
{$ifdef windows}
dataf := 'python.exe ' + dataf + '.pywc' ; 
{$else}
dataf := 'python ' + dataf + '.pywc';
{$endif}
  
 // writeln(dataf);
  
  RunWithoutDebug(dataf, 'pywc');
  
  end else mainfo.setstattext(dataf+'.pywc' + ' does not exist...',mtk_notok);
end;

end; 

end;
 
 end;
 
  
 procedure RunWithoutDebug(const AFilename: string; Aparam: string);
 var
  AProcess : TProcess ;
  thecommand : string;
  begin
  
  if Aparam = 'cd' then
  begin
    AProcess := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
      AProcess.CommandLine := Aparam + ' ' + AFilename ;
     {$WARN SYMBOL_DEPRECATED ON}
      AProcess.Options := [poNoConsole];
      AProcess.Priority:=ppRealTime;
      AProcess.Execute;
      AProcess.Free;
    end else
    
   if (Aparam = 'java') then
  begin
    AProcess := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
      AProcess.CommandLine := AFilename ;
     {$WARN SYMBOL_DEPRECATED ON}
      AProcess.Options := [poNoConsole];
      AProcess.Priority:=ppRealTime;
      AProcess.Execute;
      AProcess.Free;
      end else  
      
   if (Aparam = 'pywc') then
  begin
    AProcess := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
      AProcess.CommandLine := AFilename ;
     {$WARN SYMBOL_DEPRECATED ON}
      AProcess.Options := [poNoConsole];
      AProcess.Priority:=ppRealTime;
      AProcess.Execute;
      AProcess.Free;
      end else      
    
    
  if fileexists (AFilename) then
 begin 
 if Aparam = 'wine' then
 begin
 Aparam := '';
 wineneeded := true;
 end;
 
   if (wineneeded = true) then thecommand := 'wine ' + AFilename else
   thecommand :=  AFilename;
       AProcess := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
      AProcess.CommandLine := thecommand + Aparam ;
     {$WARN SYMBOL_DEPRECATED ON}
      AProcess.Options := [poNoConsole];
      AProcess.Priority:=ppRealTime;
      AProcess.Execute;
      AProcess.Free;
      mainfo.setstattext('' ,mtk_flat);  
         end else mainfo.setstattext(AFilename + ' does not exist...',mtk_notok); 
 end;
     
   //fpGUI designer
procedure LoadfpgDesigner(const AfpgFilename: string); 
 var
  dataf : string ;
 begin
 if fileexists(conffpguifo.fpguidesigner.value) then
 begin
  if ((iffpgdconsumed = false) and (AfpgFilename = 'quit')) or
 ((iffpgdconsumed = false) and (AfpgFilename = 'closeall')) or
 ((iffpgdconsumed = false) and (AfpgFilename = 'hideit'))
  then
 else 
 if (fileexists(AfpgFilename)) or (AfpgFilename = 'closeall') or (AfpgFilename = 'quit') or (AfpgFilename = 'showit')  or (AfpgFilename = 'hideit') then
  begin 
 iffpgdconsumed := true;
 dataf := conffpguifo.fpguidesigner.value ;
  dataf :=  tosysfilepath(filepath(trim(dataf),fk_file,true));
  RunWithoutDebug(dataf, ' ' + AfpgFilename) ;
  end;
 end;
end;
 
 //fpGUI designer
 
procedure CleanfpgDesigner(); 
{$ifdef unix}
 var
   dataf : string ;
  {$endif}
begin
 {$ifdef unix}
  dataf := '/usr/bin/killall' ;
  RunWithoutDebug(dataf,  ' designer_ext' ) ;
   {$endif}
end;

end.
