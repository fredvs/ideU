unit confdebugger_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,confdebugger;

const
 objdata: record size: integer; data: array[0..3524] of byte end =
      (size: 3525; data: (
  84,80,70,48,15,116,99,111,110,102,100,101,98,117,103,103,101,114,102,111,
  14,99,111,110,102,100,101,98,117,103,103,101,114,102,111,13,111,112,116,105,
  111,110,115,119,105,100,103,101,116,11,6,111,119,95,116,111,112,11,111,119,
  95,117,108,116,114,97,116,111,112,13,111,119,95,109,111,117,115,101,102,111,
  99,117,115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,119,95,97,
  114,114,111,119,102,111,99,117,115,11,111,119,95,115,117,98,102,111,99,117,
  115,13,111,119,95,109,111,117,115,101,119,104,101,101,108,17,111,119,95,100,
  101,115,116,114,111,121,119,105,100,103,101,116,115,9,111,119,95,104,105,110,
  116,111,110,0,7,118,105,115,105,98,108,101,8,8,98,111,117,110,100,115,
  95,120,3,200,1,8,98,111,117,110,100,115,95,121,3,184,0,9,98,111,
  117,110,100,115,95,99,120,3,13,2,9,98,111,117,110,100,115,95,99,121,
  3,71,1,26,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,11,0,27,99,111,110,116,97,105,110,
  101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,
  11,0,16,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,1,
  2,0,2,0,3,13,2,3,71,1,0,13,111,112,116,105,111,110,115,119,
  105,110,100,111,119,11,9,119,111,95,100,105,97,108,111,103,0,9,102,111,
  110,116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,
  15,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,0,7,111,
  112,116,105,111,110,115,11,17,102,111,95,115,99,114,101,101,110,99,101,110,
  116,101,114,101,100,15,102,111,95,97,117,116,111,114,101,97,100,115,116,97,
  116,16,102,111,95,97,117,116,111,119,114,105,116,101,115,116,97,116,10,102,
  111,95,115,97,118,101,112,111,115,13,102,111,95,115,97,118,101,122,111,114,
  100,101,114,12,102,111,95,115,97,118,101,115,116,97,116,101,0,7,99,97,
  112,116,105,111,110,6,23,68,101,98,117,103,103,101,114,115,32,67,111,110,
  102,105,103,117,114,97,116,105,111,110,15,105,99,111,110,46,111,114,105,103,
  102,111,114,109,97,116,6,3,98,109,112,13,119,105,110,100,111,119,111,112,
  97,99,105,116,121,5,0,0,0,0,0,0,0,128,255,255,6,111,110,115,
  104,111,119,7,7,111,110,99,114,101,97,116,15,109,111,100,117,108,101,99,
  108,97,115,115,110,97,109,101,6,8,116,109,115,101,102,111,114,109,0,14,
  116,102,105,108,101,110,97,109,101,101,100,105,116,120,9,100,101,98,117,103,
  103,101,114,52,3,84,97,103,2,7,17,102,114,97,109,101,46,99,111,108,
  111,114,99,108,105,101,110,116,4,230,255,230,0,13,102,114,97,109,101,46,
  99,97,112,116,105,111,110,6,12,36,123,68,69,66,85,71,71,69,82,52,
  125,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,102,
  108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,99,
  111,108,111,114,99,108,105,101,110,116,0,17,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,19,102,114,97,109,101,46,98,117,
  116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,114,97,109,101,46,
  98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,7,105,109,97,103,
  101,110,114,2,17,0,0,20,102,114,97,109,101,46,98,117,116,116,111,110,
  46,105,109,97,103,101,110,114,2,17,16,102,114,97,109,101,46,111,117,116,
  101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,0,8,116,97,
  98,111,114,100,101,114,2,4,4,104,105,110,116,6,18,80,97,116,104,32,
  116,111,32,100,101,98,117,103,103,101,114,32,52,8,98,111,117,110,100,115,
  95,120,2,10,8,98,111,117,110,100,115,95,121,3,9,1,9,98,111,117,
  110,100,115,95,99,120,3,248,1,9,98,111,117,110,100,115,95,99,121,2,
  39,21,99,111,110,116,114,111,108,108,101,114,46,102,111,110,116,104,101,105,
  103,104,116,2,0,19,99,111,110,116,114,111,108,108,101,114,46,102,111,110,
  116,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,20,99,
  111,110,116,114,111,108,108,101,114,46,102,111,110,116,99,111,108,111,114,4,
  2,0,0,160,20,99,111,110,116,114,111,108,108,101,114,46,98,97,99,107,
  99,111,108,111,114,4,1,0,0,128,18,99,111,110,116,114,111,108,108,101,
  114,46,110,111,112,97,110,101,108,8,18,99,111,110,116,114,111,108,108,101,
  114,46,99,111,109,112,97,99,116,8,22,99,111,110,116,114,111,108,108,101,
  114,46,115,104,111,119,111,112,116,105,111,110,115,8,22,99,111,110,116,114,
  111,108,108,101,114,46,104,105,100,101,104,105,115,116,111,114,121,8,20,99,
  111,110,116,114,111,108,108,101,114,46,104,105,100,101,105,99,111,110,115,8,
  21,99,111,110,116,114,111,108,108,101,114,46,115,104,111,119,104,105,100,100,
  101,110,8,22,99,111,110,116,114,111,108,108,101,114,46,99,97,112,116,105,
  111,110,111,112,101,110,6,13,68,101,98,117,103,103,101,114,32,80,97,116,
  104,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,14,
  116,102,105,108,101,110,97,109,101,101,100,105,116,120,9,100,101,98,117,103,
  103,101,114,51,3,84,97,103,2,7,17,102,114,97,109,101,46,99,111,108,
  111,114,99,108,105,101,110,116,4,230,255,230,0,13,102,114,97,109,101,46,
  99,97,112,116,105,111,110,6,12,36,123,68,69,66,85,71,71,69,82,51,
  125,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,102,
  108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,99,
  111,108,111,114,99,108,105,101,110,116,0,17,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,19,102,114,97,109,101,46,98,117,
  116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,114,97,109,101,46,
  98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,7,105,109,97,103,
  101,110,114,2,17,0,0,20,102,114,97,109,101,46,98,117,116,116,111,110,
  46,105,109,97,103,101,110,114,2,17,16,102,114,97,109,101,46,111,117,116,
  101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,0,8,116,97,
  98,111,114,100,101,114,2,3,4,104,105,110,116,6,18,80,97,116,104,32,
  116,111,32,100,101,98,117,103,103,101,114,32,51,8,98,111,117,110,100,115,
  95,120,2,11,8,98,111,117,110,100,115,95,121,3,188,0,9,98,111,117,
  110,100,115,95,99,120,3,248,1,9,98,111,117,110,100,115,95,99,121,2,
  39,21,99,111,110,116,114,111,108,108,101,114,46,102,111,110,116,104,101,105,
  103,104,116,2,0,19,99,111,110,116,114,111,108,108,101,114,46,102,111,110,
  116,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,20,99,
  111,110,116,114,111,108,108,101,114,46,102,111,110,116,99,111,108,111,114,4,
  2,0,0,160,20,99,111,110,116,114,111,108,108,101,114,46,98,97,99,107,
  99,111,108,111,114,4,1,0,0,128,18,99,111,110,116,114,111,108,108,101,
  114,46,110,111,112,97,110,101,108,8,18,99,111,110,116,114,111,108,108,101,
  114,46,99,111,109,112,97,99,116,8,22,99,111,110,116,114,111,108,108,101,
  114,46,115,104,111,119,111,112,116,105,111,110,115,8,22,99,111,110,116,114,
  111,108,108,101,114,46,104,105,100,101,104,105,115,116,111,114,121,8,20,99,
  111,110,116,114,111,108,108,101,114,46,104,105,100,101,105,99,111,110,115,8,
  21,99,111,110,116,114,111,108,108,101,114,46,115,104,111,119,104,105,100,100,
  101,110,8,22,99,111,110,116,114,111,108,108,101,114,46,99,97,112,116,105,
  111,110,111,112,101,110,6,13,68,101,98,117,103,103,101,114,32,80,97,116,
  104,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,14,
  116,102,105,108,101,110,97,109,101,101,100,105,116,120,9,100,101,98,117,103,
  103,101,114,50,3,84,97,103,2,7,17,102,114,97,109,101,46,99,111,108,
  111,114,99,108,105,101,110,116,4,230,255,230,0,13,102,114,97,109,101,46,
  99,97,112,116,105,111,110,6,12,36,123,68,69,66,85,71,71,69,82,50,
  125,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,102,
  108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,99,
  111,108,111,114,99,108,105,101,110,116,0,17,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,19,102,114,97,109,101,46,98,117,
  116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,114,97,109,101,46,
  98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,7,105,109,97,103,
  101,110,114,2,17,0,0,20,102,114,97,109,101,46,98,117,116,116,111,110,
  46,105,109,97,103,101,110,114,2,17,16,102,114,97,109,101,46,111,117,116,
  101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,0,8,116,97,
  98,111,114,100,101,114,2,2,4,104,105,110,116,6,18,80,97,116,104,32,
  116,111,32,100,101,98,117,103,103,101,114,32,50,8,98,111,117,110,100,115,
  95,120,2,11,8,98,111,117,110,100,115,95,121,2,117,9,98,111,117,110,
  100,115,95,99,120,3,248,1,9,98,111,117,110,100,115,95,99,121,2,39,
  21,99,111,110,116,114,111,108,108,101,114,46,102,111,110,116,104,101,105,103,
  104,116,2,0,19,99,111,110,116,114,111,108,108,101,114,46,102,111,110,116,
  110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,20,99,111,
  110,116,114,111,108,108,101,114,46,102,111,110,116,99,111,108,111,114,4,2,
  0,0,160,20,99,111,110,116,114,111,108,108,101,114,46,98,97,99,107,99,
  111,108,111,114,4,1,0,0,128,18,99,111,110,116,114,111,108,108,101,114,
  46,110,111,112,97,110,101,108,8,18,99,111,110,116,114,111,108,108,101,114,
  46,99,111,109,112,97,99,116,8,22,99,111,110,116,114,111,108,108,101,114,
  46,115,104,111,119,111,112,116,105,111,110,115,8,22,99,111,110,116,114,111,
  108,108,101,114,46,104,105,100,101,104,105,115,116,111,114,121,8,20,99,111,
  110,116,114,111,108,108,101,114,46,104,105,100,101,105,99,111,110,115,8,21,
  99,111,110,116,114,111,108,108,101,114,46,115,104,111,119,104,105,100,100,101,
  110,8,22,99,111,110,116,114,111,108,108,101,114,46,99,97,112,116,105,111,
  110,111,112,101,110,6,13,68,101,98,117,103,103,101,114,32,80,97,116,104,
  13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,14,116,
  102,105,108,101,110,97,109,101,101,100,105,116,120,9,100,101,98,117,103,103,
  101,114,49,3,84,97,103,2,7,17,102,114,97,109,101,46,99,111,108,111,
  114,99,108,105,101,110,116,4,230,255,230,0,13,102,114,97,109,101,46,99,
  97,112,116,105,111,110,6,12,36,123,68,69,66,85,71,71,69,82,49,125,
  22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,102,108,
  97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,99,111,
  108,111,114,99,108,105,101,110,116,0,17,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,49,11,0,19,102,114,97,109,101,46,98,117,116,
  116,111,110,115,46,99,111,117,110,116,2,1,19,102,114,97,109,101,46,98,
  117,116,116,111,110,115,46,105,116,101,109,115,14,1,7,105,109,97,103,101,
  110,114,2,17,0,0,20,102,114,97,109,101,46,98,117,116,116,111,110,46,
  105,109,97,103,101,110,114,2,17,16,102,114,97,109,101,46,111,117,116,101,
  114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,0,8,116,97,98,
  111,114,100,101,114,2,1,4,104,105,110,116,6,18,80,97,116,104,32,116,
  111,32,100,101,98,117,103,103,101,114,32,49,8,98,111,117,110,100,115,95,
  120,2,11,8,98,111,117,110,100,115,95,121,2,52,9,98,111,117,110,100,
  115,95,99,120,3,248,1,9,98,111,117,110,100,115,95,99,121,2,39,21,
  99,111,110,116,114,111,108,108,101,114,46,102,111,110,116,104,101,105,103,104,
  116,2,0,19,99,111,110,116,114,111,108,108,101,114,46,102,111,110,116,110,
  97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,20,99,111,110,
  116,114,111,108,108,101,114,46,102,111,110,116,99,111,108,111,114,4,2,0,
  0,160,20,99,111,110,116,114,111,108,108,101,114,46,98,97,99,107,99,111,
  108,111,114,4,1,0,0,128,18,99,111,110,116,114,111,108,108,101,114,46,
  110,111,112,97,110,101,108,8,18,99,111,110,116,114,111,108,108,101,114,46,
  99,111,109,112,97,99,116,8,22,99,111,110,116,114,111,108,108,101,114,46,
  115,104,111,119,111,112,116,105,111,110,115,8,22,99,111,110,116,114,111,108,
  108,101,114,46,104,105,100,101,104,105,115,116,111,114,121,8,20,99,111,110,
  116,114,111,108,108,101,114,46,104,105,100,101,105,99,111,110,115,8,21,99,
  111,110,116,114,111,108,108,101,114,46,115,104,111,119,104,105,100,100,101,110,
  8,22,99,111,110,116,114,111,108,108,101,114,46,99,97,112,116,105,111,110,
  111,112,101,110,6,13,68,101,98,117,103,103,101,114,32,80,97,116,104,13,
  114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,7,116,98,
  117,116,116,111,110,7,116,110,67,108,111,115,101,17,102,114,97,109,101,46,
  111,112,116,105,111,110,115,115,107,105,110,11,8,102,115,111,95,102,108,97,
  116,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  15,102,114,108,95,111,112,116,105,111,110,115,115,107,105,110,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,15,102,97,
  99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,13,102,97,99,101,
  46,116,101,109,112,108,97,116,101,7,21,115,111,117,114,99,101,112,97,103,
  101,46,116,102,97,99,101,99,111,109,112,49,8,98,111,117,110,100,115,95,
  120,3,145,1,8,98,111,117,110,100,115,95,121,2,5,9,98,111,117,110,
  100,115,95,99,120,2,111,9,98,111,117,110,100,115,95,99,121,2,24,5,
  115,116,97,116,101,11,10,97,115,95,100,101,102,97,117,108,116,15,97,115,
  95,108,111,99,97,108,100,101,102,97,117,108,116,15,97,115,95,108,111,99,
  97,108,99,97,112,116,105,111,110,0,7,99,97,112,116,105,111,110,6,3,
  38,79,75,11,109,111,100,97,108,114,101,115,117,108,116,7,5,109,114,95,
  111,107,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tconfdebuggerfo,'');
end.
