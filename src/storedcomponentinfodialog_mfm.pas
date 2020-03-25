unit storedcomponentinfodialog_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,storedcomponentinfodialog;

const
 objdata: record size: integer; data: array[0..2230] of byte end =
      (size: 2231; data: (
  84,80,70,48,28,116,115,116,111,114,101,100,99,111,109,112,111,110,101,110,
  116,105,110,102,111,100,105,97,108,111,103,102,111,27,115,116,111,114,101,100,
  99,111,109,112,111,110,101,110,116,105,110,102,111,100,105,97,108,111,103,102,
  111,8,98,111,117,110,100,115,95,120,3,172,0,8,98,111,117,110,100,115,
  95,121,3,228,0,9,98,111,117,110,100,115,95,99,120,3,106,1,9,98,
  111,117,110,100,115,95,99,121,3,255,0,26,99,111,110,116,97,105,110,101,
  114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  27,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,49,11,0,16,99,111,110,116,97,105,110,101,114,
  46,98,111,117,110,100,115,1,2,0,2,0,3,106,1,3,255,0,0,9,
  102,111,110,116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,
  108,116,15,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,0,
  14,102,111,110,116,101,109,112,116,121,46,110,97,109,101,6,9,115,116,102,
  95,101,109,112,116,121,20,102,111,110,116,101,109,112,116,121,46,108,111,99,
  97,108,112,114,111,112,115,11,0,7,111,112,116,105,111,110,115,11,14,102,
  111,95,102,114,101,101,111,110,99,108,111,115,101,17,102,111,95,115,99,114,
  101,101,110,99,101,110,116,101,114,101,100,14,102,111,95,99,97,110,99,101,
  108,111,110,101,115,99,15,102,111,95,97,117,116,111,114,101,97,100,115,116,
  97,116,16,102,111,95,97,117,116,111,119,114,105,116,101,115,116,97,116,10,
  102,111,95,115,97,118,101,112,111,115,12,102,111,95,115,97,118,101,115,116,
  97,116,101,0,13,119,105,110,100,111,119,111,112,97,99,105,116,121,5,0,
  0,0,0,0,0,0,128,255,255,12,111,110,99,108,111,115,101,113,117,101,
  114,121,7,12,100,111,99,108,111,115,101,113,117,101,114,121,15,109,111,100,
  117,108,101,99,108,97,115,115,110,97,109,101,6,8,116,109,115,101,102,111,
  114,109,0,7,116,98,117,116,116,111,110,8,116,98,117,116,116,111,110,49,
  8,98,111,117,110,100,115,95,120,3,240,0,8,98,111,117,110,100,115,95,
  121,3,224,0,9,98,111,117,110,100,115,95,99,120,2,50,9,98,111,117,
  110,100,115,95,99,121,2,20,7,97,110,99,104,111,114,115,11,8,97,110,
  95,114,105,103,104,116,9,97,110,95,98,111,116,116,111,109,0,5,115,116,
  97,116,101,11,10,97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,
  111,99,97,108,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,
  99,97,112,116,105,111,110,0,7,99,97,112,116,105,111,110,6,3,38,79,
  75,11,109,111,100,97,108,114,101,115,117,108,116,7,5,109,114,95,111,107,
  0,0,7,116,98,117,116,116,111,110,8,116,98,117,116,116,111,110,50,8,
  116,97,98,111,114,100,101,114,2,1,8,98,111,117,110,100,115,95,120,3,
  48,1,8,98,111,117,110,100,115,95,121,3,224,0,9,98,111,117,110,100,
  115,95,99,120,2,50,9,98,111,117,110,100,115,95,99,121,2,20,7,97,
  110,99,104,111,114,115,11,8,97,110,95,114,105,103,104,116,9,97,110,95,
  98,111,116,116,111,109,0,5,115,116,97,116,101,11,15,97,115,95,108,111,
  99,97,108,99,97,112,116,105,111,110,0,7,99,97,112,116,105,111,110,6,
  7,38,67,97,110,99,101,108,11,109,111,100,97,108,114,101,115,117,108,116,
  7,9,109,114,95,99,97,110,99,101,108,0,0,13,116,102,105,108,101,110,
  97,109,101,101,100,105,116,8,102,105,108,101,112,97,116,104,13,102,114,97,
  109,101,46,99,97,112,116,105,111,110,6,5,38,70,105,108,101,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,19,102,114,97,
  109,101,46,98,117,116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,
  114,97,109,101,46,98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,
  5,99,111,108,111,114,4,2,0,0,128,7,105,109,97,103,101,110,114,2,
  17,0,0,18,102,114,97,109,101,46,98,117,116,116,111,110,46,99,111,108,
  111,114,4,2,0,0,128,20,102,114,97,109,101,46,98,117,116,116,111,110,
  46,105,109,97,103,101,110,114,2,17,16,102,114,97,109,101,46,111,117,116,
  101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,0,8,116,97,
  98,111,114,100,101,114,2,2,8,98,111,117,110,100,115,95,120,2,8,8,
  98,111,117,110,100,115,95,121,3,173,0,9,98,111,117,110,100,115,95,99,
  120,3,92,1,9,98,111,117,110,100,115,95,99,121,2,39,7,97,110,99,
  104,111,114,115,11,7,97,110,95,108,101,102,116,8,97,110,95,114,105,103,
  104,116,9,97,110,95,98,111,116,116,111,109,0,12,111,112,116,105,111,110,
  115,101,100,105,116,49,11,17,111,101,49,95,97,117,116,111,112,111,112,117,
  112,109,101,110,117,14,111,101,49,95,107,101,121,101,120,101,99,117,116,101,
  13,111,101,49,95,115,97,118,101,118,97,108,117,101,13,111,101,49,95,115,
  97,118,101,115,116,97,116,101,0,11,111,112,116,105,111,110,115,101,100,105,
  116,11,12,111,101,95,117,110,100,111,111,110,101,115,99,13,111,101,95,99,
  108,111,115,101,113,117,101,114,121,16,111,101,95,99,104,101,99,107,109,114,
  99,97,110,99,101,108,14,111,101,95,115,104,105,102,116,114,101,116,117,114,
  110,12,111,101,95,101,97,116,114,101,116,117,114,110,20,111,101,95,114,101,
  115,101,116,115,101,108,101,99,116,111,110,101,120,105,116,15,111,101,95,101,
  120,105,116,111,110,99,117,114,115,111,114,13,111,101,95,101,110,100,111,110,
  101,110,116,101,114,13,111,101,95,97,117,116,111,115,101,108,101,99,116,25,
  111,101,95,97,117,116,111,115,101,108,101,99,116,111,110,102,105,114,115,116,
  99,108,105,99,107,10,111,101,95,110,111,116,110,117,108,108,0,9,116,101,
  120,116,102,108,97,103,115,11,12,116,102,95,121,99,101,110,116,101,114,101,
  100,11,116,102,95,110,111,115,101,108,101,99,116,14,116,102,95,101,108,108,
  105,112,115,101,108,101,102,116,0,26,99,111,110,116,114,111,108,108,101,114,
  46,102,105,108,116,101,114,108,105,115,116,46,100,97,116,97,1,1,6,14,
  67,111,109,112,111,110,101,110,116,32,70,105,108,101,6,5,42,46,99,109,
  112,0,1,6,9,65,108,108,32,70,105,108,101,115,6,1,42,0,0,21,
  99,111,110,116,114,111,108,108,101,114,46,100,101,102,97,117,108,116,101,120,
  116,6,3,99,109,112,18,99,111,110,116,114,111,108,108,101,114,46,111,112,
  116,105,111,110,115,11,8,102,100,111,95,115,97,118,101,14,102,100,111,95,
  99,104,101,99,107,101,120,105,115,116,15,102,100,111,95,115,97,118,101,108,
  97,115,116,100,105,114,0,22,99,111,110,116,114,111,108,108,101,114,46,99,
  97,112,116,105,111,110,115,97,118,101,6,14,67,111,109,112,111,110,101,110,
  116,32,70,105,108,101,13,114,101,102,102,111,110,116,104,101,105,103,104,116,
  2,15,0,0,11,116,115,116,114,105,110,103,101,100,105,116,8,99,111,109,
  112,110,97,109,101,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,
  5,38,78,97,109,101,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,
  109,101,1,2,0,2,18,2,0,2,0,0,8,116,97,98,111,114,100,101,
  114,2,3,8,98,111,117,110,100,115,95,120,2,8,8,98,111,117,110,100,
  115,95,121,2,6,9,98,111,117,110,100,115,95,99,120,3,92,1,9,98,
  111,117,110,100,115,95,99,121,2,39,7,97,110,99,104,111,114,115,11,7,
  97,110,95,108,101,102,116,6,97,110,95,116,111,112,8,97,110,95,114,105,
  103,104,116,0,13,111,110,100,97,116,97,101,110,116,101,114,101,100,7,15,
  110,97,109,101,100,97,116,97,101,110,116,101,114,101,100,13,114,101,102,102,
  111,110,116,104,101,105,103,104,116,2,15,0,0,9,116,109,101,109,111,101,
  100,105,116,8,99,111,109,112,100,101,115,99,13,102,114,97,109,101,46,99,
  97,112,116,105,111,110,6,12,38,68,101,115,99,114,105,112,116,105,111,110,
  16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,
  114,108,95,99,111,108,111,114,99,108,105,101,110,116,0,17,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,21,102,114,97,109,
  101,46,115,98,104,111,114,122,46,112,97,103,101,115,105,122,101,2,1,21,
  102,114,97,109,101,46,115,98,118,101,114,116,46,112,97,103,101,115,105,122,
  101,2,1,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,
  1,2,0,2,18,2,0,2,0,0,8,116,97,98,111,114,100,101,114,2,
  4,8,98,111,117,110,100,115,95,120,2,8,8,98,111,117,110,100,115,95,
  121,2,46,9,98,111,117,110,100,115,95,99,120,3,92,1,9,98,111,117,
  110,100,115,95,99,121,2,126,7,97,110,99,104,111,114,115,11,7,97,110,
  95,108,101,102,116,6,97,110,95,116,111,112,8,97,110,95,114,105,103,104,
  116,9,97,110,95,98,111,116,116,111,109,0,13,114,101,102,102,111,110,116,
  104,101,105,103,104,116,2,15,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tstoredcomponentinfodialogfo,'');
end.
