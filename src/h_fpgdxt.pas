
unit h_fpgdxt ;
{This is the Dynamic loading version of designer_ext library wrapper.

With reference counter too...

 Fred van Stappen / fiens@hotmail.com
}

////////////////////////////////////////////////////////////////////////////////

interface

uses
  DynLibs;

{$IF not DEFINED(windows)}
type
  THandle = pointer;
  TArray = single;
{$endif}

var
  fpgdxtmainproc : procedure(); cdecl;
  fpgdxtloadfile: function(afilename : PChar) : integer ; cdecl;
  fpgdxtclose : procedure(); cdecl;
  fpgdxthide : procedure(); cdecl;

 LibHandle:TLibHandle=dynlibs.NilHandle; // this will hold our handle for the lib
 ReferenceCounter : cardinal = 0;  // Reference counter
         
function fpgdxtisLoaded() : boolean; inline; 
function fpgdxtloadlib(const libfilename: string): boolean; // load the lib
procedure fpgdxtunloadlib();
// unload and frees the lib from memory : do not forget to call it before close application.

implementation

function fpgdxtisloaded(): boolean;
begin
 Result := (LibHandle <> dynlibs.NilHandle);
end;

function fpgdxtloadlib(const libfilename: string): boolean;
begin
   Result := False;
  if LibHandle<>0 then 
begin
 Inc(ReferenceCounter);
result:=true 
end  else begin 
    if Length(libfilename) = 0 then exit;
    LibHandle:=DynLibs.LoadLibrary(libfilename); // obtain the handle we want
  	if LibHandle <> DynLibs.NilHandle then
       begin
    try
      Pointer(fpgdxtmainproc) :=
        GetProcAddress(LibHandle, 'fpgdxtmainproc');
      Pointer(fpgdxtclose) :=
        GetProcAddress(LibHandle, 'fpgdxtclose');
      Pointer(fpgdxtloadfile) :=
        GetProcAddress(LibHandle, 'fpgdxtloadfile');
      Pointer(fpgdxthide) :=
        GetProcAddress(LibHandle, 'fpgdxthide');
     
    Result := fpgdxtisLoaded;
    ReferenceCounter:=1;   
      except
      fpgdxtunloadlib;
    end;
  end;
end;
end;

procedure fpgdxtunloadlib();
begin
// < Reference counting
  if ReferenceCounter > 0 then
    dec(ReferenceCounter);
  if ReferenceCounter > 0 then
    exit;
  // >

  if LibHandle <> DynLibs.NilHandle then
  begin
    DynLibs.UnloadLibrary(LibHandle);
    LibHandle := DynLibs.NilHandle;
  end;
end;

end.
