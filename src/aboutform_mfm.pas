unit aboutform_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,aboutform;

const
 objdata: record size: integer; data: array[0..1736] of byte end =
      (size: 1737; data: (
  84,80,70,48,8,116,97,98,111,117,116,102,111,10,97,98,111,117,116,95,
  102,111,114,109,19,102,97,99,101,46,102,97,100,101,95,112,111,115,46,99,
  111,117,110,116,2,2,19,102,97,99,101,46,102,97,100,101,95,112,111,115,
  46,105,116,101,109,115,1,2,0,2,1,0,21,102,97,99,101,46,102,97,
  100,101,95,99,111,108,111,114,46,99,111,117,110,116,2,2,21,102,97,99,
  101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,115,1,4,
  222,222,222,0,4,189,189,189,0,0,19,102,97,99,101,46,102,97,100,101,
  95,100,105,114,101,99,116,105,111,110,7,7,103,100,95,100,111,119,110,15,
  102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,7,118,105,
  115,105,98,108,101,8,8,98,111,117,110,100,115,95,120,3,172,1,8,98,
  111,117,110,100,115,95,121,3,2,1,9,98,111,117,110,100,115,95,99,120,
  3,116,1,9,98,111,117,110,100,115,95,99,121,3,90,1,26,99,111,110,
  116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,0,27,99,111,110,116,97,105,110,101,114,46,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,16,99,111,110,116,
  97,105,110,101,114,46,98,111,117,110,100,115,1,2,0,2,0,3,116,1,
  3,90,1,0,13,111,112,116,105,111,110,115,119,105,110,100,111,119,11,9,
  119,111,95,100,105,97,108,111,103,0,9,102,111,110,116,46,110,97,109,101,
  6,11,115,116,102,95,100,101,102,97,117,108,116,15,102,111,110,116,46,108,
  111,99,97,108,112,114,111,112,115,11,0,14,102,111,110,116,101,109,112,116,
  121,46,110,97,109,101,6,9,115,116,102,95,101,109,112,116,121,20,102,111,
  110,116,101,109,112,116,121,46,108,111,99,97,108,112,114,111,112,115,11,0,
  7,111,112,116,105,111,110,115,11,17,102,111,95,115,99,114,101,101,110,99,
  101,110,116,101,114,101,100,14,102,111,95,99,97,110,99,101,108,111,110,101,
  115,99,15,102,111,95,97,117,116,111,114,101,97,100,115,116,97,116,16,102,
  111,95,97,117,116,111,119,114,105,116,101,115,116,97,116,10,102,111,95,115,
  97,118,101,112,111,115,13,102,111,95,115,97,118,101,122,111,114,100,101,114,
  12,102,111,95,115,97,118,101,115,116,97,116,101,0,12,105,99,111,110,46,
  111,112,116,105,111,110,115,11,10,98,109,111,95,109,97,115,107,101,100,0,
  15,105,99,111,110,46,111,114,105,103,102,111,114,109,97,116,6,3,112,110,
  103,10,105,99,111,110,46,105,109,97,103,101,10,100,2,0,0,0,0,0,
  0,2,0,0,0,16,0,0,0,16,0,0,0,240,1,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,239,0,21,49,255,255,1,74,255,255,
  1,107,255,255,1,165,255,255,1,181,255,255,1,165,255,255,1,0,239,0,
  9,107,255,247,1,49,255,255,1,82,255,255,1,123,255,255,1,181,255,255,
  1,198,255,255,1,165,255,255,2,0,239,0,7,8,239,8,1,24,255,173,
  1,57,255,255,1,90,255,255,1,140,255,255,1,198,255,255,1,214,255,255,
  1,165,255,255,1,90,255,181,1,41,255,41,1,0,239,0,5,49,239,49,
  1,8,239,8,1,24,255,173,1,66,255,255,1,107,255,255,1,165,255,255,
  1,231,255,255,1,222,255,255,1,165,255,255,1,82,255,181,1,41,255,41,
  1,66,255,66,1,0,239,0,4,49,239,49,1,8,239,8,1,24,255,90,
  1,66,255,247,1,123,255,255,1,198,255,255,3,165,255,255,1,74,255,132,
  1,41,255,41,1,57,247,57,1,0,239,0,4,49,239,49,1,8,239,8,
  1,24,255,33,1,74,255,206,1,148,255,255,1,222,255,255,1,198,255,255,
  2,156,255,231,1,66,255,74,1,33,255,33,1,57,247,57,1,0,239,0,
  4,49,239,49,1,8,239,8,1,24,255,24,1,82,255,107,1,222,255,255,
  1,198,255,255,3,148,255,165,1,66,255,66,1,33,255,33,1,57,247,57,
  1,0,239,0,4,49,239,49,1,8,231,8,1,16,247,16,1,57,247,57,
  1,222,247,222,1,198,255,255,2,222,247,222,1,90,255,90,1,33,255,33,
  1,16,247,16,1,49,239,49,1,0,239,0,4,49,239,49,1,0,231,0,
  2,8,231,8,1,115,239,115,1,198,255,255,2,115,239,115,1,16,231,16,
  1,0,231,0,2,49,239,49,1,0,239,0,4,49,239,49,1,0,231,0,
  3,16,231,16,1,41,222,41,2,16,231,16,1,0,231,0,3,49,239,49,
  1,0,239,0,4,49,239,49,1,0,231,0,2,0,222,0,5,0,231,0,
  3,49,239,49,1,0,239,0,4,49,239,49,1,0,231,0,10,49,239,49,
  1,0,239,0,4,49,239,49,1,0,231,0,10,49,239,49,1,0,239,0,
  5,115,239,115,1,0,222,0,1,0,231,0,5,0,222,0,2,115,239,115,
  1,0,239,0,19,0,0,0,0,224,7,0,0,240,15,0,0,248,31,0,
  0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,
  0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,
  0,248,31,0,0,0,0,0,0,13,119,105,110,100,111,119,111,112,97,99,
  105,116,121,5,0,0,0,0,0,0,0,128,255,255,15,109,111,100,117,108,
  101,99,108,97,115,115,110,97,109,101,6,8,116,109,115,101,102,111,114,109,
  0,9,116,109,101,109,111,101,100,105,116,10,97,98,111,117,116,95,116,101,
  120,116,17,102,114,97,109,101,46,99,111,108,111,114,99,108,105,101,110,116,
  4,178,245,255,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,11,15,102,114,108,95,99,111,108,111,114,99,108,105,101,110,116,0,
  17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,
  21,102,114,97,109,101,46,115,98,104,111,114,122,46,112,97,103,101,115,105,
  122,101,2,1,21,102,114,97,109,101,46,115,98,118,101,114,116,46,112,97,
  103,101,115,105,122,101,2,1,8,98,111,117,110,100,115,95,120,2,7,8,
  98,111,117,110,100,115,95,121,2,9,9,98,111,117,110,100,115,95,99,120,
  3,101,1,9,98,111,117,110,100,115,95,99,121,3,75,1,11,111,112,116,
  105,111,110,115,101,100,105,116,11,11,111,101,95,114,101,97,100,111,110,108,
  121,13,111,101,95,99,108,111,115,101,113,117,101,114,121,16,111,101,95,99,
  104,101,99,107,109,114,99,97,110,99,101,108,12,111,101,95,108,105,110,101,
  98,114,101,97,107,12,111,101,95,101,97,116,114,101,116,117,114,110,20,111,
  101,95,114,101,115,101,116,115,101,108,101,99,116,111,110,101,120,105,116,20,
  111,101,95,110,111,102,105,114,115,116,97,114,114,111,119,110,97,118,105,103,
  22,111,101,95,102,111,99,117,115,114,101,99,116,111,110,114,101,97,100,111,
  110,108,121,0,9,116,101,120,116,102,108,97,103,115,11,12,116,102,95,120,
  99,101,110,116,101,114,101,100,12,116,102,95,119,111,114,100,98,114,101,97,
  107,11,116,102,95,110,111,115,101,108,101,99,116,0,15,116,101,120,116,102,
  108,97,103,115,97,99,116,105,118,101,11,12,116,102,95,120,99,101,110,116,
  101,114,101,100,12,116,102,95,119,111,114,100,98,114,101,97,107,0,13,114,
  101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,0)
 );

initialization
 registerobjectdata(@objdata,taboutfo,'');
end.
