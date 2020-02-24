unit finddialogform_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,finddialogform;

const
 objdata: record size: integer; data: array[0..3389] of byte end =
      (size: 3390; data: (
  84,80,70,48,13,116,102,105,110,100,100,105,97,108,111,103,102,111,12,102,
  105,110,100,100,105,97,108,111,103,102,111,13,111,112,116,105,111,110,115,119,
  105,100,103,101,116,11,11,111,119,95,116,97,98,102,111,99,117,115,13,111,
  119,95,97,114,114,111,119,102,111,99,117,115,15,111,119,95,97,114,114,111,
  119,102,111,99,117,115,105,110,16,111,119,95,97,114,114,111,119,102,111,99,
  117,115,111,117,116,11,111,119,95,115,117,98,102,111,99,117,115,17,111,119,
  95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,9,111,119,95,104,
  105,110,116,111,110,0,7,118,105,115,105,98,108,101,8,8,98,111,117,110,
  100,115,95,120,3,184,1,8,98,111,117,110,100,115,95,121,3,3,1,9,
  98,111,117,110,100,115,95,99,120,3,44,1,9,98,111,117,110,100,115,95,
  99,121,2,90,12,98,111,117,110,100,115,95,99,120,109,105,110,3,44,1,
  12,98,111,117,110,100,115,95,99,121,109,105,110,2,90,12,98,111,117,110,
  100,115,95,99,120,109,97,120,3,44,1,12,98,111,117,110,100,115,95,99,
  121,109,97,120,2,90,23,99,111,110,116,97,105,110,101,114,46,111,112,116,
  105,111,110,115,119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,101,
  102,111,99,117,115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,119,
  95,97,114,114,111,119,102,111,99,117,115,15,111,119,95,97,114,114,111,119,
  102,111,99,117,115,105,110,16,111,119,95,97,114,114,111,119,102,111,99,117,
  115,111,117,116,11,111,119,95,115,117,98,102,111,99,117,115,19,111,119,95,
  109,111,117,115,101,116,114,97,110,115,112,97,114,101,110,116,17,111,119,95,
  100,101,115,116,114,111,121,119,105,100,103,101,116,115,0,26,99,111,110,116,
  97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,11,0,27,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,49,11,0,16,99,111,110,116,97,
  105,110,101,114,46,98,111,117,110,100,115,1,2,0,2,0,3,44,1,2,
  90,0,13,111,112,116,105,111,110,115,119,105,110,100,111,119,11,10,119,111,
  95,109,101,115,115,97,103,101,0,7,111,112,116,105,111,110,115,11,14,102,
  111,95,102,114,101,101,111,110,99,108,111,115,101,13,102,111,95,99,108,111,
  115,101,111,110,101,115,99,17,102,111,95,108,111,99,97,108,115,104,111,114,
  116,99,117,116,115,15,102,111,95,97,117,116,111,114,101,97,100,115,116,97,
  116,16,102,111,95,97,117,116,111,119,114,105,116,101,115,116,97,116,10,102,
  111,95,115,97,118,101,112,111,115,13,102,111,95,115,97,118,101,122,111,114,
  100,101,114,0,8,115,116,97,116,102,105,108,101,7,9,115,116,97,116,102,
  105,108,101,49,7,99,97,112,116,105,111,110,6,9,70,105,110,100,32,84,
  101,120,116,12,105,99,111,110,46,111,112,116,105,111,110,115,11,10,98,109,
  111,95,109,97,115,107,101,100,0,15,105,99,111,110,46,111,114,105,103,102,
  111,114,109,97,116,6,3,112,110,103,10,105,99,111,110,46,105,109,97,103,
  101,10,100,2,0,0,0,0,0,0,2,0,0,0,16,0,0,0,16,0,
  0,0,240,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,239,
  0,21,49,255,255,1,74,255,255,1,107,255,255,1,165,255,255,1,181,255,
  255,1,165,255,255,1,0,239,0,9,107,255,247,1,49,255,255,1,82,255,
  255,1,123,255,255,1,181,255,255,1,198,255,255,1,165,255,255,2,0,239,
  0,7,8,239,8,1,24,255,173,1,57,255,255,1,90,255,255,1,140,255,
  255,1,198,255,255,1,214,255,255,1,165,255,255,1,90,255,181,1,41,255,
  41,1,0,239,0,5,49,239,49,1,8,239,8,1,24,255,173,1,66,255,
  255,1,107,255,255,1,165,255,255,1,231,255,255,1,222,255,255,1,165,255,
  255,1,82,255,181,1,41,255,41,1,66,255,66,1,0,239,0,4,49,239,
  49,1,8,239,8,1,24,255,90,1,66,255,247,1,123,255,255,1,198,255,
  255,3,165,255,255,1,74,255,132,1,41,255,41,1,57,247,57,1,0,239,
  0,4,49,239,49,1,8,239,8,1,24,255,33,1,74,255,206,1,148,255,
  255,1,222,255,255,1,198,255,255,2,156,255,231,1,66,255,74,1,33,255,
  33,1,57,247,57,1,0,239,0,4,49,239,49,1,8,239,8,1,24,255,
  24,1,82,255,107,1,222,255,255,1,198,255,255,3,148,255,165,1,66,255,
  66,1,33,255,33,1,57,247,57,1,0,239,0,4,49,239,49,1,8,231,
  8,1,16,247,16,1,57,247,57,1,222,247,222,1,198,255,255,2,222,247,
  222,1,90,255,90,1,33,255,33,1,16,247,16,1,49,239,49,1,0,239,
  0,4,49,239,49,1,0,231,0,2,8,231,8,1,115,239,115,1,198,255,
  255,2,115,239,115,1,16,231,16,1,0,231,0,2,49,239,49,1,0,239,
  0,4,49,239,49,1,0,231,0,3,16,231,16,1,41,222,41,2,16,231,
  16,1,0,231,0,3,49,239,49,1,0,239,0,4,49,239,49,1,0,231,
  0,2,0,222,0,5,0,231,0,3,49,239,49,1,0,239,0,4,49,239,
  49,1,0,231,0,10,49,239,49,1,0,239,0,4,49,239,49,1,0,231,
  0,10,49,239,49,1,0,239,0,5,115,239,115,1,0,222,0,1,0,231,
  0,5,0,222,0,2,115,239,115,1,0,239,0,19,0,0,0,0,224,7,
  0,0,240,15,0,0,248,31,0,0,252,63,0,0,252,63,0,0,252,63,
  0,0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,
  0,0,252,63,0,0,252,63,0,0,248,31,0,0,0,0,0,0,13,119,
  105,110,100,111,119,111,112,97,99,105,116,121,5,0,0,0,0,0,0,0,
  128,255,255,7,111,110,99,108,111,115,101,7,9,111,110,99,108,111,115,101,
  101,118,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,101,6,8,
  116,109,115,101,102,111,114,109,0,9,116,108,97,121,111,117,116,101,114,10,
  116,108,97,121,111,117,116,101,114,50,16,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,
  108,112,114,111,112,115,49,11,0,8,116,97,98,111,114,100,101,114,2,2,
  8,98,111,117,110,100,115,95,120,2,8,8,98,111,117,110,100,115,95,121,
  2,45,9,98,111,117,110,100,115,95,99,120,3,27,1,9,98,111,117,110,
  100,115,95,99,121,2,40,12,111,112,116,105,111,110,115,115,99,97,108,101,
  11,11,111,115,99,95,101,120,112,97,110,100,120,11,111,115,99,95,115,104,
  114,105,110,107,120,17,111,115,99,95,101,120,112,97,110,100,115,104,114,105,
  110,107,120,17,111,115,99,95,101,120,112,97,110,100,115,104,114,105,110,107,
  121,0,13,111,112,116,105,111,110,115,108,97,121,111,117,116,11,10,108,97,
  111,95,112,108,97,99,101,120,0,13,112,108,97,99,101,95,109,105,110,100,
  105,115,116,2,4,13,112,108,97,99,101,95,109,97,120,100,105,115,116,2,
  4,0,12,116,98,111,111,108,101,97,110,101,100,105,116,12,115,101,108,101,
  99,116,101,100,111,110,108,121,13,102,114,97,109,101,46,99,97,112,116,105,
  111,110,6,14,115,101,108,101,99,116,38,101,100,32,111,110,108,121,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,16,102,114,
  97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,2,2,
  82,2,2,0,8,98,111,117,110,100,115,95,120,3,188,0,8,98,111,117,
  110,100,115,95,121,2,10,9,98,111,117,110,100,115,95,99,120,2,95,9,
  98,111,117,110,100,115,95,99,121,2,17,8,115,116,97,116,102,105,108,101,
  7,9,115,116,97,116,102,105,108,101,49,0,0,12,116,98,111,111,108,101,
  97,110,101,100,105,116,9,119,104,111,108,101,119,111,114,100,13,102,114,97,
  109,101,46,99,97,112,116,105,111,110,6,11,38,119,104,111,108,101,32,119,
  111,114,100,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,
  11,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,
  2,0,2,2,2,72,2,2,0,8,116,97,98,111,114,100,101,114,2,1,
  8,98,111,117,110,100,115,95,120,2,99,8,98,111,117,110,100,115,95,121,
  2,10,9,98,111,117,110,100,115,95,99,120,2,85,9,98,111,117,110,100,
  115,95,99,121,2,17,0,0,12,116,98,111,111,108,101,97,110,101,100,105,
  116,13,99,97,115,101,115,101,110,115,105,116,105,118,101,13,102,114,97,109,
  101,46,99,97,112,116,105,111,110,6,14,99,97,115,101,38,115,101,110,115,
  105,116,105,118,101,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,
  115,49,11,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,
  101,1,2,0,2,2,2,82,2,2,0,8,116,97,98,111,114,100,101,114,
  2,2,8,98,111,117,110,100,115,95,120,2,0,8,98,111,117,110,100,115,
  95,121,2,10,9,98,111,117,110,100,115,95,99,120,2,95,9,98,111,117,
  110,100,115,95,99,121,2,17,0,0,0,12,116,104,105,115,116,111,114,121,
  101,100,105,116,8,102,105,110,100,116,101,120,116,13,102,114,97,109,101,46,
  99,97,112,116,105,111,110,6,13,84,101,120,116,32,116,111,32,38,102,105,
  110,100,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,
  102,108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,19,102,114,97,
  109,101,46,98,117,116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,
  114,97,109,101,46,98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,
  0,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,
  2,0,2,18,2,0,2,0,0,8,98,111,117,110,100,115,95,120,2,9,
  8,98,111,117,110,100,115,95,121,2,2,9,98,111,117,110,100,115,95,99,
  120,3,226,0,9,98,111,117,110,100,115,95,99,121,2,39,7,97,110,99,
  104,111,114,115,11,7,97,110,95,108,101,102,116,6,97,110,95,116,111,112,
  8,97,110,95,114,105,103,104,116,0,12,111,112,116,105,111,110,115,101,100,
  105,116,49,11,17,111,101,49,95,97,117,116,111,112,111,112,117,112,109,101,
  110,117,13,111,101,49,95,115,97,118,101,118,97,108,117,101,13,111,101,49,
  95,115,97,118,101,115,116,97,116,101,0,11,111,112,116,105,111,110,115,101,
  100,105,116,11,12,111,101,95,117,110,100,111,111,110,101,115,99,13,111,101,
  95,99,108,111,115,101,113,117,101,114,121,16,111,101,95,99,104,101,99,107,
  109,114,99,97,110,99,101,108,20,111,101,95,114,101,115,101,116,115,101,108,
  101,99,116,111,110,101,120,105,116,15,111,101,95,101,120,105,116,111,110,99,
  117,114,115,111,114,13,111,101,95,97,117,116,111,115,101,108,101,99,116,25,
  111,101,95,97,117,116,111,115,101,108,101,99,116,111,110,102,105,114,115,116,
  99,108,105,99,107,0,19,100,114,111,112,100,111,119,110,46,99,111,108,115,
  46,99,111,117,110,116,2,1,19,100,114,111,112,100,111,119,110,46,99,111,
  108,115,46,105,116,101,109,115,14,1,0,0,13,114,101,102,102,111,110,116,
  104,101,105,103,104,116,2,15,0,0,9,116,108,97,121,111,117,116,101,114,
  10,116,108,97,121,111,117,116,101,114,49,16,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,49,11,0,8,116,97,98,111,114,100,101,114,2,
  1,8,98,111,117,110,100,115,95,120,3,8,1,8,98,111,117,110,100,115,
  95,121,2,88,9,98,111,117,110,100,115,95,99,120,2,27,9,98,111,117,
  110,100,115,95,99,121,2,0,7,97,110,99,104,111,114,115,11,6,97,110,
  95,116,111,112,8,97,110,95,114,105,103,104,116,0,12,111,112,116,105,111,
  110,115,115,99,97,108,101,11,11,111,115,99,95,101,120,112,97,110,100,120,
  11,111,115,99,95,115,104,114,105,110,107,120,11,111,115,99,95,101,120,112,
  97,110,100,121,11,111,115,99,95,115,104,114,105,110,107,121,0,13,111,112,
  116,105,111,110,115,108,97,121,111,117,116,11,10,108,97,111,95,112,108,97,
  99,101,120,10,108,97,111,95,97,108,105,103,110,121,19,108,97,111,95,115,
  121,110,99,109,97,120,97,117,116,111,115,105,122,101,0,10,97,108,105,103,
  110,95,103,108,117,101,7,9,119,97,109,95,115,116,97,114,116,13,112,108,
  97,99,101,95,109,105,110,100,105,115,116,2,5,13,112,108,97,99,101,95,
  109,97,120,100,105,115,116,2,5,10,112,108,97,99,101,95,109,111,100,101,
  7,7,119,97,109,95,101,110,100,0,0,7,116,98,117,116,116,111,110,8,
  116,98,117,116,116,111,110,50,8,116,97,98,111,114,100,101,114,2,3,8,
  98,111,117,110,100,115,95,120,3,248,0,8,98,111,117,110,100,115,95,121,
  2,15,9,98,111,117,110,100,115,95,99,120,2,42,9,98,111,117,110,100,
  115,95,99,121,2,21,7,97,110,99,104,111,114,115,11,6,97,110,95,116,
  111,112,8,97,110,95,114,105,103,104,116,0,5,115,116,97,116,101,11,10,
  97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,100,
  101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,99,97,112,116,105,
  111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,
  0,7,99,97,112,116,105,111,110,6,3,38,79,75,9,111,110,101,120,101,
  99,117,116,101,7,4,111,110,111,107,0,0,9,116,115,116,97,116,102,105,
  108,101,9,115,116,97,116,102,105,108,101,49,8,102,105,108,101,110,97,109,
  101,6,16,102,105,110,100,100,105,97,108,111,103,102,111,46,115,116,97,7,
  111,112,116,105,111,110,115,11,10,115,102,111,95,109,101,109,111,114,121,0,
  4,108,101,102,116,2,112,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tfinddialogfo,'');
end.
