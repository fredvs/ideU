unit dialogfiles_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,dialogfiles;

const
 objdata: record size: integer; data: array[0..1318] of byte end =
      (size: 1319; data: (
  84,80,70,48,14,116,100,105,97,108,111,103,102,105,108,101,115,102,111,13,
  100,105,97,108,111,103,102,105,108,101,115,102,111,7,118,105,115,105,98,108,
  101,8,8,98,111,117,110,100,115,95,120,3,155,1,8,98,111,117,110,100,
  115,95,121,3,210,0,9,98,111,117,110,100,115,95,99,120,3,23,2,9,
  98,111,117,110,100,115,95,99,121,3,57,1,26,99,111,110,116,97,105,110,
  101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,27,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,16,99,111,110,116,97,105,110,101,
  114,46,98,111,117,110,100,115,1,2,0,2,0,3,23,2,3,57,1,0,
  13,111,112,116,105,111,110,115,119,105,110,100,111,119,11,9,119,111,95,100,
  105,97,108,111,103,0,7,99,97,112,116,105,111,110,6,29,76,111,97,100,
  32,97,32,83,121,110,116,97,120,32,68,101,102,105,110,105,116,105,111,110,
  32,70,105,108,101,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,
  101,6,8,116,109,115,101,102,111,114,109,0,7,116,98,117,116,116,111,110,
  8,116,98,117,116,116,111,110,49,8,98,111,117,110,100,115,95,120,3,151,
  1,8,98,111,117,110,100,115,95,121,2,16,9,98,111,117,110,100,115,95,
  99,120,2,50,9,98,111,117,110,100,115,95,99,121,2,21,5,115,116,97,
  116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,17,
  97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,7,99,
  97,112,116,105,111,110,6,2,79,75,9,111,110,101,120,101,99,117,116,101,
  7,5,98,117,116,111,107,0,0,7,116,98,117,116,116,111,110,8,116,98,
  117,116,116,111,110,50,8,116,97,98,111,114,100,101,114,2,1,8,98,111,
  117,110,100,115,95,120,3,208,1,8,98,111,117,110,100,115,95,121,2,16,
  9,98,111,117,110,100,115,95,99,120,2,56,9,98,111,117,110,100,115,95,
  99,121,2,21,5,115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,
  99,97,112,116,105,111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,
  101,99,117,116,101,0,7,99,97,112,116,105,111,110,6,6,67,97,110,99,
  101,108,9,111,110,101,120,101,99,117,116,101,7,9,98,117,116,99,97,110,
  99,101,108,0,0,13,116,102,105,108,101,108,105,115,116,118,105,101,119,9,
  108,105,115,116,95,115,100,101,102,5,99,111,108,111,114,4,230,245,255,0,
  16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,8,
  116,97,98,111,114,100,101,114,2,2,8,98,111,117,110,100,115,95,120,2,
  3,8,98,111,117,110,100,115,95,121,2,47,9,98,111,117,110,100,115,95,
  99,120,3,15,2,9,98,111,117,110,100,115,95,99,121,3,4,1,9,99,
  101,108,108,119,105,100,116,104,3,254,0,10,99,101,108,108,104,101,105,103,
  104,116,2,19,20,99,101,108,108,102,114,97,109,101,46,99,111,108,111,114,
  102,114,97,109,101,4,230,245,255,0,20,99,101,108,108,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,11,14,102,114,108,95,99,111,108,
  111,114,102,114,97,109,101,0,21,99,101,108,108,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,49,11,0,18,111,110,115,101,108,101,99,
  116,105,111,110,99,104,97,110,103,101,100,7,7,108,111,97,100,100,101,102,
  13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,5,116,
  101,100,105,116,13,115,101,108,101,99,116,101,100,95,115,100,101,102,17,102,
  114,97,109,101,46,99,111,108,111,114,99,108,105,101,110,116,4,230,245,255,
  0,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,31,83,101,108,
  101,99,116,101,100,32,83,121,110,116,97,120,32,68,101,102,105,110,105,116,
  105,111,110,32,70,105,108,101,16,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,11,15,102,114,108,95,99,111,108,111,114,99,108,105,101,
  110,116,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  49,11,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,
  1,2,0,2,18,2,0,2,0,0,8,116,97,98,111,114,100,101,114,2,
  3,8,98,111,117,110,100,115,95,120,2,5,8,98,111,117,110,100,115,95,
  121,2,2,9,98,111,117,110,100,115,95,99,120,3,138,1,9,98,111,117,
  110,100,115,95,99,121,2,39,11,111,112,116,105,111,110,115,101,100,105,116,
  11,11,111,101,95,114,101,97,100,111,110,108,121,12,111,101,95,117,110,100,
  111,111,110,101,115,99,13,111,101,95,99,108,111,115,101,113,117,101,114,121,
  16,111,101,95,99,104,101,99,107,109,114,99,97,110,99,101,108,14,111,101,
  95,115,104,105,102,116,114,101,116,117,114,110,12,111,101,95,101,97,116,114,
  101,116,117,114,110,20,111,101,95,114,101,115,101,116,115,101,108,101,99,116,
  111,110,101,120,105,116,15,111,101,95,101,120,105,116,111,110,99,117,114,115,
  111,114,13,111,101,95,101,110,100,111,110,101,110,116,101,114,13,111,101,95,
  97,117,116,111,115,101,108,101,99,116,25,111,101,95,97,117,116,111,115,101,
  108,101,99,116,111,110,102,105,114,115,116,99,108,105,99,107,22,111,101,95,
  102,111,99,117,115,114,101,99,116,111,110,114,101,97,100,111,110,108,121,0,
  13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tdialogfilesfo,'');
end.
