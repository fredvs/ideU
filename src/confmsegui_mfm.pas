unit confmsegui_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,confmsegui;

const
 objdata: record size: integer; data: array[0..2313] of byte end =
      (size: 2314; data: (
  84,80,70,48,13,116,99,111,110,102,109,115,101,103,117,105,102,111,12,99,
  111,110,102,109,115,101,103,117,105,102,111,13,111,112,116,105,111,110,115,119,
  105,100,103,101,116,11,6,111,119,95,116,111,112,13,111,119,95,97,114,114,
  111,119,102,111,99,117,115,11,111,119,95,115,117,98,102,111,99,117,115,17,
  111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,9,111,119,
  95,104,105,110,116,111,110,0,7,118,105,115,105,98,108,101,8,8,98,111,
  117,110,100,115,95,120,3,137,1,8,98,111,117,110,100,115,95,121,3,20,
  1,9,98,111,117,110,100,115,95,99,120,3,120,1,9,98,111,117,110,100,
  115,95,99,121,2,117,23,99,111,110,116,97,105,110,101,114,46,111,112,116,
  105,111,110,115,119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,101,
  102,111,99,117,115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,119,
  95,97,114,114,111,119,102,111,99,117,115,11,111,119,95,115,117,98,102,111,
  99,117,115,19,111,119,95,109,111,117,115,101,116,114,97,110,115,112,97,114,
  101,110,116,17,111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,116,
  115,0,26,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,11,0,27,99,111,110,116,97,105,110,101,
  114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,16,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,1,2,
  0,2,0,3,120,1,2,117,0,13,111,112,116,105,111,110,115,119,105,110,
  100,111,119,11,9,119,111,95,100,105,97,108,111,103,0,9,102,111,110,116,
  46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,15,102,
  111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,0,14,102,111,110,
  116,101,109,112,116,121,46,110,97,109,101,6,9,115,116,102,95,101,109,112,
  116,121,20,102,111,110,116,101,109,112,116,121,46,108,111,99,97,108,112,114,
  111,112,115,11,0,7,111,112,116,105,111,110,115,11,17,102,111,95,115,99,
  114,101,101,110,99,101,110,116,101,114,101,100,13,102,111,95,99,108,111,115,
  101,111,110,101,115,99,15,102,111,95,97,117,116,111,114,101,97,100,115,116,
  97,116,16,102,111,95,97,117,116,111,119,114,105,116,101,115,116,97,116,10,
  102,111,95,115,97,118,101,112,111,115,12,102,111,95,115,97,118,101,115,116,
  97,116,101,0,8,115,116,97,116,102,105,108,101,7,10,116,115,116,97,116,
  102,105,108,101,49,7,99,97,112,116,105,111,110,6,23,67,111,110,102,105,
  103,117,114,97,116,105,111,110,32,111,102,32,77,83,69,103,117,105,12,105,
  99,111,110,46,111,112,116,105,111,110,115,11,10,98,109,111,95,109,97,115,
  107,101,100,12,98,109,111,95,103,114,97,121,109,97,115,107,0,15,105,99,
  111,110,46,111,114,105,103,102,111,114,109,97,116,6,3,112,110,103,13,119,
  105,110,100,111,119,111,112,97,99,105,116,121,5,0,0,0,0,0,0,0,
  128,255,255,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,101,6,
  8,116,109,115,101,102,111,114,109,0,13,116,102,105,108,101,110,97,109,101,
  101,100,105,116,6,109,115,101,100,105,114,3,84,97,103,2,2,13,102,114,
  97,109,101,46,99,97,112,116,105,111,110,6,9,36,123,77,83,69,68,73,
  82,125,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,
  102,108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,19,102,114,97,
  109,101,46,98,117,116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,
  114,97,109,101,46,98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,
  7,105,109,97,103,101,110,114,2,17,0,0,20,102,114,97,109,101,46,98,
  117,116,116,111,110,46,105,109,97,103,101,110,114,2,17,16,102,114,97,109,
  101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,
  0,0,4,104,105,110,116,6,25,82,111,111,116,32,100,105,114,101,99,116,
  111,114,121,32,111,102,32,109,115,101,103,117,105,46,8,98,111,117,110,100,
  115,95,120,2,8,8,98,111,117,110,100,115,95,121,2,14,9,98,111,117,
  110,100,115,95,99,120,3,104,1,9,98,111,117,110,100,115,95,99,121,2,
  39,7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,6,97,
  110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,11,111,112,116,105,
  111,110,115,101,100,105,116,11,0,5,118,97,108,117,101,6,9,36,123,77,
  83,69,68,73,82,125,19,99,111,110,116,114,111,108,108,101,114,46,102,105,
  108,101,110,97,109,101,6,10,36,123,77,83,69,68,73,82,125,47,18,99,
  111,110,116,114,111,108,108,101,114,46,108,97,115,116,100,105,114,6,30,47,
  104,111,109,101,47,102,114,101,100,47,105,100,101,117,47,115,114,99,47,36,
  123,77,83,69,68,73,82,125,47,18,99,111,110,116,114,111,108,108,101,114,
  46,111,112,116,105,111,110,115,11,13,102,100,111,95,100,105,114,101,99,116,
  111,114,121,0,22,99,111,110,116,114,111,108,108,101,114,46,99,97,112,116,
  105,111,110,111,112,101,110,6,21,77,83,69,103,117,105,32,114,111,111,116,
  32,100,105,114,101,99,116,111,114,121,13,114,101,102,102,111,110,116,104,101,
  105,103,104,116,2,15,0,0,13,116,102,105,108,101,110,97,109,101,101,100,
  105,116,9,109,115,101,108,105,98,100,105,114,3,84,97,103,2,3,13,102,
  114,97,109,101,46,99,97,112,116,105,111,110,6,12,36,123,77,83,69,76,
  73,66,68,73,82,125,22,102,114,97,109,101,46,99,97,112,116,105,111,110,
  116,101,120,116,102,108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,
  0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,
  19,102,114,97,109,101,46,98,117,116,116,111,110,115,46,99,111,117,110,116,
  2,1,19,102,114,97,109,101,46,98,117,116,116,111,110,115,46,105,116,101,
  109,115,14,1,7,105,109,97,103,101,110,114,2,17,0,0,20,102,114,97,
  109,101,46,98,117,116,116,111,110,46,105,109,97,103,101,110,114,2,17,16,
  102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,
  18,2,0,2,0,0,8,116,97,98,111,114,100,101,114,2,1,4,104,105,
  110,116,6,33,82,111,111,116,32,100,105,114,101,99,116,111,114,121,32,111,
  102,32,109,115,101,103,117,105,32,108,105,98,114,97,114,121,46,8,98,111,
  117,110,100,115,95,120,2,8,8,98,111,117,110,100,115,95,121,2,61,9,
  98,111,117,110,100,115,95,99,120,3,103,1,9,98,111,117,110,100,115,95,
  99,121,2,39,7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,
  116,6,97,110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,5,118,
  97,108,117,101,6,20,36,123,77,83,69,68,73,82,125,108,105,98,47,99,
  111,109,109,111,110,47,19,99,111,110,116,114,111,108,108,101,114,46,102,105,
  108,101,110,97,109,101,6,20,36,123,77,83,69,68,73,82,125,108,105,98,
  47,99,111,109,109,111,110,47,18,99,111,110,116,114,111,108,108,101,114,46,
  108,97,115,116,100,105,114,6,40,47,104,111,109,101,47,102,114,101,100,47,
  105,100,101,117,47,115,114,99,47,36,123,77,83,69,68,73,82,125,108,105,
  98,47,99,111,109,109,111,110,47,18,99,111,110,116,114,111,108,108,101,114,
  46,111,112,116,105,111,110,115,11,13,102,100,111,95,100,105,114,101,99,116,
  111,114,121,0,22,99,111,110,116,114,111,108,108,101,114,46,99,97,112,116,
  105,111,110,111,112,101,110,6,24,77,83,69,103,117,105,32,108,105,98,114,
  97,114,121,32,100,105,114,101,99,116,111,114,121,13,114,101,102,102,111,110,
  116,104,101,105,103,104,116,2,15,0,0,7,116,98,117,116,116,111,110,8,
  116,98,117,116,116,111,110,49,17,102,114,97,109,101,46,111,112,116,105,111,
  110,115,115,107,105,110,11,8,102,115,111,95,102,108,97,116,0,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,
  111,112,116,105,111,110,115,115,107,105,110,0,17,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,49,11,0,15,102,97,99,101,46,108,111,
  99,97,108,112,114,111,112,115,11,0,13,102,97,99,101,46,116,101,109,112,
  108,97,116,101,7,19,115,111,117,114,99,101,102,111,46,116,102,97,99,101,
  99,111,109,112,49,8,116,97,98,111,114,100,101,114,2,2,8,98,111,117,
  110,100,115,95,120,3,77,1,8,98,111,117,110,100,115,95,121,2,4,9,
  98,111,117,110,100,115,95,99,120,2,34,9,98,111,117,110,100,115,95,99,
  121,2,22,7,97,110,99,104,111,114,115,11,6,97,110,95,116,111,112,8,
  97,110,95,114,105,103,104,116,0,5,115,116,97,116,101,11,10,97,115,95,
  100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,100,101,102,97,
  117,108,116,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,0,
  7,99,97,112,116,105,111,110,6,3,38,79,75,11,109,111,100,97,108,114,
  101,115,117,108,116,7,5,109,114,95,111,107,0,0,9,116,115,116,97,116,
  102,105,108,101,10,116,115,116,97,116,102,105,108,101,49,8,102,105,108,101,
  110,97,109,101,6,11,99,111,110,102,109,115,101,46,115,116,97,7,111,112,
  116,105,111,110,115,11,10,115,102,111,95,109,101,109,111,114,121,0,4,108,
  101,102,116,2,16,3,116,111,112,2,32,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tconfmseguifo,'');
end.
