
unit plugmanager ;
{This for loading/managing plugin

 Fred van Stappen / fiens@hotmail.com
}

////////////////////////////////////////////////////////////////////////////////

interface

uses
{$IFDEF UNIX}
  cthreads, {$ENDIF}
  Process, conffpgui, msefileutils,
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


procedure RunCustomCompiled(const AFilename: string);

// for fpGUI
procedure LoadfpgDesigner(const AfpgFilename: string; param: string);

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
TheProcess : Tprocess;

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
 
 procedure RunCustomCompiled(const AFilename: string);
 var
  dataf, dataf2 : string ;
  AProcess : TProcess ;
  len1 : integer;
 begin
 
  if fileexists (AFilename) then
 begin 
dataf2 := trim(AFilename);
len1 := pos('.',dataf2) ;

 {$IFDEF Windows} 
  dataf := copy(dataf2,1,len1) + 'exe' ; 
    {$else}
   dataf := copy(dataf2,1,len1-1) ;
    {$endif}
    
  dataf :=  tosysfilepath(filepath(trim(dataf),fk_file,true));
     
     if fileexists(dataf) then
     begin
       AProcess := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
      AProcess.CommandLine := dataf ;
     {$WARN SYMBOL_DEPRECATED ON}
      AProcess.Options := [poNoConsole];
      //AProcess.Priority:=ppRealTime;
      AProcess.Execute;
      AProcess.Free;
      mainfo.setstattext('',mtk_flat);  
         end else mainfo.setstattext('  Not a executable file...',mtk_flat);
    
  end;
 
 end;
     
   //fpGUI designer
procedure LoadfpgDesigner(const AfpgFilename: string; param: string); 
 var
  dataf : string ;
  AProcess : TProcess ;
 begin
 
 if (iffpgdconsumed = false) and (AfpgFilename = 'quit') then
 else 
 begin
 
  if fileexists((AfpgFilename)) or (AfpgFilename = 'closeall') or (AfpgFilename = 'quit') or (AfpgFilename = 'showit')  or (AfpgFilename = 'hideit') then
 begin 

if assigned(TheProcess) then
   begin  
 if ((iffpgdconsumed = false) and (AfpgFilename <> 'quit')) or (iffpgdconsumed = true) then 
 begin
 iffpgdconsumed := true;
 dataf := conffpguifo.fpguidesigner.value ;
  dataf :=  tosysfilepath(filepath(trim(dataf),fk_file,true));
     
     if fileexists((dataf)) then
     begin
       AProcess := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
      AProcess.CommandLine := dataf + ' ' + trim(AfpgFilename) ;
     {$WARN SYMBOL_DEPRECATED ON}
      AProcess.Options := [poNoConsole];
      //AProcess.Priority:=ppRealTime;
      AProcess.Execute;
      AProcess.Free;
     end;
end; end else
begin  
  iffpgdconsumed := true;
 dataf := conffpguifo.fpguidesigner.value ;
  dataf :=  tosysfilepath(filepath(trim(dataf),fk_file,true));
     
     if fileexists((dataf)) then
     begin
     TheProcess := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
      TheProcess.CommandLine := dataf + ' ' + trim(AfpgFilename) ;
     {$WARN SYMBOL_DEPRECATED ON}
      TheProcess.Options := [poNoConsole];
      //AProcess.Priority:=ppRealTime;
      TheProcess.Execute;
      TheProcess.Free;
     end;
  end;
 end;
 end;
 end;
/////////

 //fpGUI designer

procedure CleanfpgDesigner(); 
{$ifdef unix}
 var
   dataf : string ;
   AProcess : TProcess ;
{$endif}
begin
   
// if assigned(TheProcess) then TheProcess.Terminate(0);  

 {$ifdef unix}
  dataf := '/usr/bin/killall designer_ext' ;
 
      AProcess := TProcess.Create(nil);
      {$WARN SYMBOL_DEPRECATED OFF}
      AProcess.CommandLine := dataf ;
     {$WARN SYMBOL_DEPRECATED ON}
      AProcess.Options := [poNoConsole];
      AProcess.Execute;
      AProcess.Free;
   {$endif}
  if assigned(TheProcess) then TheProcess := nil; 
  end;

/////////
 
end.
