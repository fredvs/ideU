unit conffpgui_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,conffpgui;

const
 objdata: record size: integer; data: array[0..6786] of byte end =
      (size: 6787; data: (
  84,80,70,48,12,116,99,111,110,102,102,112,103,117,105,102,111,11,99,111,
  110,102,102,112,103,117,105,102,111,13,111,112,116,105,111,110,115,119,105,100,
  103,101,116,11,6,111,119,95,116,111,112,13,111,119,95,97,114,114,111,119,
  102,111,99,117,115,11,111,119,95,115,117,98,102,111,99,117,115,17,111,119,
  95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,9,111,119,95,104,
  105,110,116,111,110,0,7,118,105,115,105,98,108,101,8,8,98,111,117,110,
  100,115,95,120,3,159,1,8,98,111,117,110,100,115,95,121,3,169,0,9,
  98,111,117,110,100,115,95,99,120,3,17,1,9,98,111,117,110,100,115,95,
  99,121,3,70,1,23,99,111,110,116,97,105,110,101,114,46,111,112,116,105,
  111,110,115,119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,101,102,
  111,99,117,115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,119,95,
  97,114,114,111,119,102,111,99,117,115,11,111,119,95,115,117,98,102,111,99,
  117,115,19,111,119,95,109,111,117,115,101,116,114,97,110,115,112,97,114,101,
  110,116,17,111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,
  0,26,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,11,0,27,99,111,110,116,97,105,110,101,114,
  46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,
  16,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,1,2,0,
  2,0,3,17,1,3,70,1,0,13,111,112,116,105,111,110,115,119,105,110,
  100,111,119,11,9,119,111,95,100,105,97,108,111,103,0,7,111,112,116,105,
  111,110,115,11,17,102,111,95,115,99,114,101,101,110,99,101,110,116,101,114,
  101,100,13,102,111,95,99,108,111,115,101,111,110,101,115,99,15,102,111,95,
  97,117,116,111,114,101,97,100,115,116,97,116,16,102,111,95,97,117,116,111,
  119,114,105,116,101,115,116,97,116,10,102,111,95,115,97,118,101,112,111,115,
  12,102,111,95,115,97,118,101,115,116,97,116,101,0,8,115,116,97,116,102,
  105,108,101,7,10,116,115,116,97,116,102,105,108,101,49,7,99,97,112,116,
  105,111,110,6,22,67,111,110,102,105,103,117,114,97,116,105,111,110,32,111,
  102,32,102,112,71,85,73,12,105,99,111,110,46,111,112,116,105,111,110,115,
  11,10,98,109,111,95,109,97,115,107,101,100,12,98,109,111,95,103,114,97,
  121,109,97,115,107,0,15,105,99,111,110,46,111,114,105,103,102,111,114,109,
  97,116,6,3,112,110,103,10,105,99,111,110,46,105,109,97,103,101,10,68,
  6,0,0,0,0,0,0,18,0,0,0,22,0,0,0,22,0,0,0,252,
  3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,28,37,
  255,255,1,48,255,255,1,61,255,255,1,83,255,255,1,115,255,255,1,150,
  255,255,1,176,255,255,1,181,255,255,1,164,255,255,1,133,255,255,1,0,
  0,0,12,40,255,255,1,49,255,255,1,64,255,255,1,89,255,255,1,123,
  255,255,1,162,255,255,1,189,255,255,1,190,255,255,1,166,255,255,1,129,
  255,255,1,0,0,0,12,42,255,255,1,53,255,255,1,69,255,255,1,96,
  255,255,1,134,255,255,1,175,255,255,1,202,255,255,1,198,255,255,1,166,
  255,255,1,124,255,255,1,0,0,0,9,7,233,7,1,10,236,10,1,14,
  241,14,1,39,255,255,1,57,255,255,1,75,255,255,1,104,255,255,1,146,
  255,255,1,190,255,255,1,215,255,255,1,204,255,255,1,165,255,255,1,112,
  255,255,1,59,255,59,1,36,255,36,1,22,249,22,1,0,0,0,6,7,
  234,7,1,10,237,10,1,16,242,16,1,39,255,255,1,61,255,255,1,83,
  255,255,1,116,255,255,1,162,255,255,1,208,255,255,1,229,255,255,1,209,
  255,255,1,162,255,255,1,105,255,255,1,55,255,55,1,33,255,33,1,21,
  248,21,1,0,0,0,6,7,234,7,1,11,238,11,1,17,244,17,1,39,
  255,255,1,64,255,255,1,93,255,255,1,131,255,255,1,182,255,255,1,229,
  255,255,1,243,255,255,1,214,255,255,1,157,255,255,1,98,255,255,1,53,
  255,53,1,32,255,32,1,20,247,20,1,0,0,0,6,7,234,7,1,12,
  238,12,1,18,245,18,1,35,255,148,1,67,255,255,1,104,255,255,1,150,
  255,255,1,206,255,255,1,253,255,255,1,255,255,255,1,219,255,255,1,153,
  255,255,1,90,255,192,1,51,255,51,1,31,255,31,1,20,246,20,1,0,
  0,0,6,7,234,7,1,11,238,11,1,19,246,19,1,33,255,58,1,68,
  255,255,1,116,255,255,1,169,255,255,1,231,255,255,1,255,255,255,2,225,
  255,255,1,148,255,255,1,84,255,106,1,50,255,50,1,30,255,30,1,19,
  245,19,1,0,0,0,6,7,233,7,1,11,237,11,1,18,245,18,1,32,
  255,32,1,62,255,150,1,123,255,255,1,181,255,255,1,249,255,255,1,255,
  255,255,2,226,255,255,1,137,255,210,1,80,255,80,1,47,255,47,1,28,
  255,28,1,17,244,17,1,0,0,0,6,6,232,6,1,10,236,10,1,16,
  243,16,1,29,255,29,1,52,255,52,1,0,0,0,6,120,255,120,1,72,
  255,72,1,42,255,42,1,25,252,25,1,15,242,15,1,0,0,0,6,5,
  231,5,1,8,235,8,1,14,240,14,1,24,251,24,1,43,255,43,1,0,
  0,0,6,97,255,97,1,58,255,58,1,34,255,34,1,20,247,20,1,12,
  239,12,1,0,0,0,6,1,226,1,1,1,228,1,1,2,228,2,1,3,
  229,3,1,14,238,14,1,5,208,5,1,0,0,0,4,8,217,8,1,28,
  240,28,1,5,232,5,1,4,230,4,1,3,229,3,2,0,0,0,6,0,
  227,0,1,1,227,1,1,1,228,1,2,7,232,7,1,3,222,3,1,0,
  0,0,4,4,226,4,1,13,236,13,1,3,229,3,1,2,229,2,1,2,
  228,2,2,0,0,0,6,0,225,0,1,0,227,0,2,1,227,1,1,2,
  228,2,1,1,225,1,1,2,221,2,1,2,211,2,2,2,222,2,1,2,
  225,2,1,4,229,4,1,1,228,1,2,1,227,1,2,0,0,0,6,0,
  226,0,1,0,227,0,3,0,226,0,1,1,224,1,2,1,222,1,2,1,
  224,1,1,1,226,1,1,1,227,1,2,0,227,0,1,0,225,0,1,0,
  227,0,1,0,0,0,6,0,225,0,1,0,227,0,4,0,226,0,1,0,
  227,0,4,0,226,0,1,0,227,0,1,0,226,0,1,0,225,0,1,0,
  226,0,1,1,227,1,1,0,0,0,6,0,226,0,1,0,227,0,1,0,
  226,0,10,0,225,0,3,0,226,0,1,0,0,0,6,0,225,0,1,0,
  227,0,4,0,226,0,1,0,227,0,4,0,226,0,1,0,227,0,1,0,
  226,0,1,0,225,0,1,0,226,0,1,1,226,1,1,0,0,0,6,0,
  225,0,1,0,227,0,1,0,226,0,10,0,225,0,3,0,227,0,1,0,
  0,0,7,0,227,0,11,0,226,0,1,0,225,0,1,0,223,0,1,0,
  0,0,9,0,221,0,1,0,225,0,1,0,226,0,1,0,227,0,6,0,
  226,0,1,0,224,0,1,0,211,0,1,0,0,0,5,16,2,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,38,173,143,189,254,254,182,151,165,34,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,119,132,195,248,255,255,248,
  190,135,110,0,0,0,0,0,0,0,0,0,0,0,0,0,0,158,229,247,
  255,255,255,255,246,228,147,0,0,0,0,0,0,0,0,0,0,0,0,208,
  208,238,253,255,255,255,255,255,255,252,236,208,208,0,0,0,0,0,0,0,
  0,0,220,255,255,255,255,255,255,255,255,255,255,255,255,255,255,208,0,0,
  0,0,0,0,0,0,220,255,255,255,181,215,255,255,255,255,210,186,255,255,
  255,208,0,0,0,0,0,0,0,0,220,255,255,255,214,161,208,255,255,203,
  164,217,255,255,255,208,0,0,0,0,0,0,0,0,220,255,255,255,174,152,
  213,249,249,209,150,179,255,255,255,208,0,0,0,0,0,0,0,0,220,255,
  255,255,103,64,93,100,100,92,61,113,255,255,255,208,0,0,0,0,0,0,
  0,0,220,255,255,255,81,0,0,0,0,0,0,92,255,255,255,208,0,0,
  0,0,0,0,0,0,220,255,255,255,81,0,0,0,0,0,0,92,255,255,
  255,208,0,0,0,0,0,0,0,0,249,255,255,255,141,3,0,0,0,0,
  4,155,255,255,255,244,0,0,0,0,0,0,0,0,245,255,255,255,157,16,
  0,0,0,0,18,169,255,255,255,239,0,0,0,0,0,0,0,0,252,255,
  255,255,215,57,8,3,3,9,63,222,255,255,255,249,0,0,0,0,0,0,
  0,0,245,255,255,255,251,164,76,52,52,79,170,252,255,255,255,240,0,0,
  0,0,0,0,0,0,230,255,255,255,253,252,253,254,254,253,252,253,255,255,
  255,221,0,0,0,0,0,0,0,0,188,253,255,255,253,238,238,241,241,238,
  239,253,255,255,252,178,0,0,0,0,0,0,0,0,118,237,255,255,252,252,
  253,254,254,253,252,252,255,255,232,110,0,0,0,0,0,0,0,0,31,191,
  247,254,251,237,238,241,241,238,238,251,254,246,181,28,0,0,0,0,0,0,
  0,0,0,60,187,237,247,251,253,254,254,253,251,246,235,179,54,0,0,0,
  0,0,0,0,0,0,0,0,18,91,162,208,231,237,237,230,206,159,87,16,
  0,0,0,0,0,0,0,13,119,105,110,100,111,119,111,112,97,99,105,116,
  121,5,0,0,0,0,0,0,0,128,255,255,15,109,111,100,117,108,101,99,
  108,97,115,115,110,97,109,101,6,8,116,109,115,101,102,111,114,109,0,13,
  116,102,105,108,101,110,97,109,101,101,100,105,116,13,102,112,103,117,105,100,
  101,115,105,103,110,101,114,3,84,97,103,2,7,13,102,114,97,109,101,46,
  99,97,112,116,105,111,110,6,16,36,123,70,80,71,85,73,68,69,83,73,
  71,78,69,82,125,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,
  101,120,116,102,108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,
  16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,
  102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,
  102,111,46,116,102,114,97,109,101,99,111,109,112,51,19,102,114,97,109,101,
  46,98,117,116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,114,97,
  109,101,46,98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,
  97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,
  46,116,102,114,97,109,101,99,111,109,112,50,7,105,109,97,103,101,110,114,
  2,17,0,0,29,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,30,102,114,97,
  109,101,46,98,117,116,116,111,110,46,102,114,97,109,101,46,108,111,99,97,
  108,112,114,111,112,115,49,11,0,27,102,114,97,109,101,46,98,117,116,116,
  111,110,46,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,
  97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,50,20,102,114,
  97,109,101,46,98,117,116,116,111,110,46,105,109,97,103,101,110,114,2,17,
  16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,
  2,18,2,0,2,0,0,4,104,105,110,116,6,22,80,97,116,104,32,111,
  102,32,102,112,71,85,73,32,68,101,115,105,103,110,101,114,8,98,111,117,
  110,100,115,95,120,2,2,8,98,111,117,110,100,115,95,121,2,21,9,98,
  111,117,110,100,115,95,99,120,3,13,1,9,98,111,117,110,100,115,95,99,
  121,2,41,7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,
  6,97,110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,18,99,111,
  110,116,114,111,108,108,101,114,46,111,112,116,105,111,110,115,11,15,102,100,
  111,95,115,121,115,102,105,108,101,110,97,109,101,15,102,100,111,95,115,97,
  118,101,108,97,115,116,100,105,114,0,22,99,111,110,116,114,111,108,108,101,
  114,46,99,97,112,116,105,111,110,111,112,101,110,6,19,102,112,71,85,73,
  32,68,101,115,105,103,110,101,114,32,112,97,116,104,13,114,101,102,102,111,
  110,116,104,101,105,103,104,116,2,15,0,0,12,116,98,111,111,108,101,97,
  110,101,100,105,116,19,101,110,97,98,108,101,102,112,103,117,105,100,101,115,
  105,103,110,101,114,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,
  20,68,101,115,105,103,110,101,114,32,105,110,116,101,103,114,97,116,105,111,
  110,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,
  14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,
  110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,109,101,16,102,114,
  97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,2,2,
  126,2,2,0,8,116,97,98,111,114,100,101,114,2,1,4,104,105,110,116,
  6,27,69,110,97,98,108,101,32,100,101,115,105,103,110,101,114,32,105,110,
  116,101,103,114,97,116,105,111,110,8,98,111,117,110,100,115,95,120,2,18,
  8,98,111,117,110,100,115,95,121,2,65,9,98,111,117,110,100,115,95,99,
  120,3,139,0,9,98,111,117,110,100,115,95,99,121,2,17,0,0,12,116,
  98,111,111,108,101,97,110,101,100,105,116,12,116,98,102,112,103,111,110,108,
  121,111,110,101,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,12,
  79,110,101,32,73,110,115,116,97,110,99,101,16,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,
  109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,101,110,117,105,
  116,101,109,102,114,97,109,101,16,102,114,97,109,101,46,111,117,116,101,114,
  102,114,97,109,101,1,2,0,2,2,2,83,2,2,0,8,116,97,98,111,
  114,100,101,114,2,2,4,104,105,110,116,6,38,79,110,108,121,32,79,110,
  101,32,73,110,115,116,97,110,99,101,32,40,115,101,116,117,112,32,100,101,
  115,105,103,110,101,114,32,116,111,111,41,8,98,111,117,110,100,115,95,120,
  2,18,8,98,111,117,110,100,115,95,121,2,83,9,98,111,117,110,100,115,
  95,99,120,2,96,9,98,111,117,110,100,115,95,99,121,2,17,5,118,97,
  108,117,101,9,0,0,9,116,103,114,111,117,112,98,111,120,12,103,114,111,
  117,112,99,111,109,109,97,110,100,13,102,114,97,109,101,46,99,97,112,116,
  105,111,110,6,18,67,111,109,109,97,110,100,32,108,105,110,101,32,112,97,
  114,97,109,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,
  116,102,108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,
  97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,
  46,116,102,114,97,109,101,99,111,109,112,50,16,102,114,97,109,101,46,111,
  117,116,101,114,102,114,97,109,101,1,2,0,2,9,2,0,2,0,0,8,
  116,97,98,111,114,100,101,114,2,3,8,98,111,117,110,100,115,95,120,2,
  12,8,98,111,117,110,100,115,95,121,2,105,9,98,111,117,110,100,115,95,
  99,120,3,238,0,9,98,111,117,110,100,115,95,99,121,3,144,0,0,5,
  116,101,100,105,116,10,101,100,102,105,108,101,110,97,109,101,16,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,
  101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,46,116,
  102,114,97,109,101,99,111,109,112,51,8,98,111,117,110,100,115,95,120,2,
  124,8,98,111,117,110,100,115,95,121,2,25,9,98,111,117,110,100,115,95,
  99,120,2,94,9,98,111,117,110,100,115,95,99,121,2,21,4,116,101,120,
  116,6,11,36,123,70,73,76,69,78,65,77,69,125,13,114,101,102,102,111,
  110,116,104,101,105,103,104,116,2,15,0,0,5,116,101,100,105,116,7,101,
  100,99,108,111,115,101,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,
  7,18,109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,51,
  8,116,97,98,111,114,100,101,114,2,1,8,98,111,117,110,100,115,95,120,
  2,124,8,98,111,117,110,100,115,95,121,2,47,9,98,111,117,110,100,115,
  95,99,120,2,94,9,98,111,117,110,100,115,95,99,121,2,21,4,116,101,
  120,116,6,8,99,108,111,115,101,97,108,108,13,114,101,102,102,111,110,116,
  104,101,105,103,104,116,2,15,0,0,5,116,101,100,105,116,6,101,100,104,
  105,100,101,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,
  11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,
  97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,51,8,116,97,
  98,111,114,100,101,114,2,2,8,98,111,117,110,100,115,95,120,2,124,8,
  98,111,117,110,100,115,95,121,2,91,9,98,111,117,110,100,115,95,99,120,
  2,94,9,98,111,117,110,100,115,95,99,121,2,21,4,116,101,120,116,6,
  6,104,105,100,101,105,116,13,114,101,102,102,111,110,116,104,101,105,103,104,
  116,2,15,0,0,5,116,101,100,105,116,6,101,100,115,104,111,119,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,
  97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,
  46,116,102,114,97,109,101,99,111,109,112,51,8,116,97,98,111,114,100,101,
  114,2,3,8,98,111,117,110,100,115,95,120,2,124,8,98,111,117,110,100,
  115,95,121,2,69,9,98,111,117,110,100,115,95,99,120,2,94,9,98,111,
  117,110,100,115,95,99,121,2,21,4,116,101,120,116,6,6,115,104,111,119,
  105,116,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,
  5,116,101,100,105,116,6,101,100,113,117,105,116,16,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,
  101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,46,116,102,114,97,
  109,101,99,111,109,112,51,8,116,97,98,111,114,100,101,114,2,4,8,98,
  111,117,110,100,115,95,120,2,124,8,98,111,117,110,100,115,95,121,2,113,
  9,98,111,117,110,100,115,95,99,120,2,94,9,98,111,117,110,100,115,95,
  99,121,2,21,4,116,101,120,116,6,4,113,117,105,116,13,114,101,102,102,
  111,110,116,104,101,105,103,104,116,2,15,0,0,12,116,98,111,111,108,101,
  97,110,101,100,105,116,10,105,102,108,111,97,100,102,105,108,101,13,102,114,
  97,109,101,46,99,97,112,116,105,111,110,6,12,76,111,97,100,32,70,105,
  108,101,32,61,62,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,
  115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,
  20,109,97,105,110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,109,
  101,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,
  0,2,2,2,80,2,2,0,8,116,97,98,111,114,100,101,114,2,5,8,
  98,111,117,110,100,115,95,120,2,12,8,98,111,117,110,100,115,95,121,2,
  25,9,98,111,117,110,100,115,95,99,120,2,93,9,98,111,117,110,100,115,
  95,99,121,2,17,5,118,97,108,117,101,9,0,0,12,116,98,111,111,108,
  101,97,110,101,100,105,116,7,105,102,99,108,111,115,101,13,102,114,97,109,
  101,46,99,97,112,116,105,111,110,6,13,67,108,111,115,101,32,70,105,108,
  101,32,61,62,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,
  115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,
  109,97,105,110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,109,101,
  16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,
  2,2,2,82,2,2,0,8,116,97,98,111,114,100,101,114,2,6,8,98,
  111,117,110,100,115,95,120,2,12,8,98,111,117,110,100,115,95,121,2,47,
  9,98,111,117,110,100,115,95,99,120,2,95,9,98,111,117,110,100,115,95,
  99,121,2,17,5,118,97,108,117,101,9,0,0,12,116,98,111,111,108,101,
  97,110,101,100,105,116,6,105,102,115,104,111,119,13,102,114,97,109,101,46,
  99,97,112,116,105,111,110,6,12,83,104,111,119,32,68,101,115,105,32,61,
  62,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,
  14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,
  110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,109,101,16,102,114,
  97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,2,2,
  89,2,2,0,8,116,97,98,111,114,100,101,114,2,7,8,98,111,117,110,
  100,115,95,120,2,12,8,98,111,117,110,100,115,95,121,2,69,9,98,111,
  117,110,100,115,95,99,120,2,102,9,98,111,117,110,100,115,95,99,121,2,
  17,5,118,97,108,117,101,9,0,0,12,116,98,111,111,108,101,97,110,101,
  100,105,116,6,105,102,104,105,100,101,13,102,114,97,109,101,46,99,97,112,
  116,105,111,110,6,12,72,105,100,101,32,68,101,115,105,32,61,62,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,
  97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,
  46,109,101,110,117,105,116,101,109,102,114,97,109,101,16,102,114,97,109,101,
  46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,2,2,83,2,2,
  0,8,116,97,98,111,114,100,101,114,2,8,8,98,111,117,110,100,115,95,
  120,2,12,8,98,111,117,110,100,115,95,121,2,91,9,98,111,117,110,100,
  115,95,99,120,2,96,9,98,111,117,110,100,115,95,99,121,2,17,5,118,
  97,108,117,101,9,0,0,12,116,98,111,111,108,101,97,110,101,100,105,116,
  6,105,102,113,117,105,116,13,102,114,97,109,101,46,99,97,112,116,105,111,
  110,6,12,81,117,105,116,32,68,101,115,105,32,61,62,16,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,
  46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,101,
  110,117,105,116,101,109,102,114,97,109,101,16,102,114,97,109,101,46,111,117,
  116,101,114,102,114,97,109,101,1,2,0,2,2,2,81,2,2,0,8,116,
  97,98,111,114,100,101,114,2,9,8,98,111,117,110,100,115,95,120,2,12,
  8,98,111,117,110,100,115,95,121,2,113,9,98,111,117,110,100,115,95,99,
  120,2,94,9,98,111,117,110,100,115,95,99,121,2,17,5,118,97,108,117,
  101,9,0,0,0,5,116,101,100,105,116,8,101,100,102,105,108,116,101,114,
  16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,
  102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,
  102,111,46,116,102,114,97,109,101,99,111,109,112,51,8,116,97,98,111,114,
  100,101,114,2,4,8,98,111,117,110,100,115,95,120,2,12,8,98,111,117,
  110,100,115,95,121,3,23,1,9,98,111,117,110,100,115,95,99,120,3,250,
  0,9,98,111,117,110,100,115,95,99,121,2,21,7,97,110,99,104,111,114,
  115,11,7,97,110,95,108,101,102,116,6,97,110,95,116,111,112,8,97,110,
  95,114,105,103,104,116,0,4,116,101,120,116,6,31,42,46,102,112,103,32,
  44,32,102,112,103,95,42,46,112,97,115,32,44,32,102,112,103,117,105,95,
  42,46,112,97,115,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,
  15,0,0,12,116,98,111,111,108,101,97,110,101,100,105,116,8,105,102,102,
  105,108,116,101,114,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,
  7,70,105,108,116,101,114,58,16,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,
  114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,
  116,101,7,20,109,97,105,110,102,111,46,109,101,110,117,105,116,101,109,102,
  114,97,109,101,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,
  101,1,2,0,2,2,2,37,2,2,0,8,116,97,98,111,114,100,101,114,
  2,5,8,98,111,117,110,100,115,95,120,2,20,8,98,111,117,110,100,115,
  95,121,3,1,1,9,98,111,117,110,100,115,95,99,120,2,50,9,98,111,
  117,110,100,115,95,99,121,2,17,0,0,7,116,98,117,116,116,111,110,2,
  111,107,14,111,112,116,105,111,110,115,119,105,100,103,101,116,49,11,19,111,
  119,49,95,102,111,110,116,103,108,121,112,104,104,101,105,103,104,116,13,111,
  119,49,95,97,117,116,111,115,99,97,108,101,0,13,111,112,116,105,111,110,
  115,119,105,100,103,101,116,11,11,111,119,95,116,97,98,102,111,99,117,115,
  13,111,119,95,97,114,114,111,119,102,111,99,117,115,15,111,119,95,97,114,
  114,111,119,102,111,99,117,115,105,110,16,111,119,95,97,114,114,111,119,102,
  111,99,117,115,111,117,116,17,111,119,95,100,101,115,116,114,111,121,119,105,
  100,103,101,116,115,0,5,99,111,108,111,114,4,3,0,0,128,17,102,114,
  97,109,101,46,111,112,116,105,111,110,115,115,107,105,110,11,8,102,115,111,
  95,102,108,97,116,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,15,102,114,108,95,111,112,116,105,111,110,115,115,107,105,110,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,
  105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,50,15,102,97,99,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,13,102,97,99,101,46,
  116,101,109,112,108,97,116,101,7,19,115,111,117,114,99,101,102,111,46,116,
  102,97,99,101,99,111,109,112,49,8,116,97,98,111,114,100,101,114,2,6,
  8,98,111,117,110,100,115,95,120,3,173,0,8,98,111,117,110,100,115,95,
  121,2,2,9,98,111,117,110,100,115,95,99,120,2,92,9,98,111,117,110,
  100,115,95,99,121,2,30,7,97,110,99,104,111,114,115,11,6,97,110,95,
  116,111,112,8,97,110,95,114,105,103,104,116,0,5,115,116,97,116,101,11,
  10,97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,
  100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,99,97,112,116,
  105,111,110,13,97,115,95,108,111,99,97,108,99,111,108,111,114,0,7,99,
  97,112,116,105,111,110,6,2,79,75,11,109,111,100,97,108,114,101,115,117,
  108,116,7,5,109,114,95,111,107,13,114,101,102,102,111,110,116,104,101,105,
  103,104,116,2,15,0,0,9,116,115,116,97,116,102,105,108,101,10,116,115,
  116,97,116,102,105,108,101,49,8,102,105,108,101,110,97,109,101,6,11,99,
  111,110,102,102,112,103,46,115,116,97,7,111,112,116,105,111,110,115,11,10,
  115,102,111,95,109,101,109,111,114,121,0,4,108,101,102,116,2,16,3,116,
  111,112,2,32,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tconffpguifo,'');
end.
