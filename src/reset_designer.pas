program progconsole_graout;

{$mode objfpc}{$H+}

uses
   sysutils;
   
  procedure MainProc;
var
  f: textfile;
begin
   AssignFile(f, PChar(GetTempDir + '.postit.tmp'));
     rewrite(f);
        append(f);
      writeln(f, 'quit');
        Flush(f);
        CloseFile(f);    
end;     
 
begin
  MainProc;
end.
