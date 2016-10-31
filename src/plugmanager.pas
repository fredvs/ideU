
unit plugmanager ;
{This for loading/managing plugin

 Fred van Stappen / fiens@hotmail.com
}

////////////////////////////////////////////////////////////////////////////////

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


procedure RunCustomCompiled(const AFilename: string);

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
 
 procedure RunCustomCompiled(const AFilename: string);
 var
  dataf, dataf2 : string ;
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
  
 
  RunWithoutDebug(dataf, '');
 
 end else mainfo.setstattext(dataf + ' is not executable...',mtk_notok);
 end;
 
 procedure RunWithoutDebug(const AFilename: string; Aparam: string);
 var
  AProcess : TProcess ;
  thecommand : string;
  begin
 
  if fileexists (AFilename) then
 begin 
   if wineneeded = true then thecommand := 'wine ' + AFilename else
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
/////////

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

/////////
 
end.
