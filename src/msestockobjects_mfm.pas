unit msestockobjects_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,msestockobjects;

const
 objdata: record size: integer; data: array[0..8604] of byte end =
      (size: 8605; data: (
  84,80,70,48,10,116,115,116,111,99,107,100,97,116,97,9,115,116,111,99,
  107,100,97,116,97,9,98,111,117,110,100,115,95,99,120,3,188,0,9,98,
  111,117,110,100,115,95,99,121,2,85,4,108,101,102,116,3,130,0,3,116,
  111,112,2,59,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,101,
  6,14,116,109,115,101,100,97,116,97,109,111,100,117,108,101,0,10,116,105,
  109,97,103,101,108,105,115,116,6,103,108,121,112,104,115,5,119,105,100,116,
  104,2,15,6,104,101,105,103,104,116,2,15,7,111,112,116,105,111,110,115,
  11,14,98,109,111,95,109,111,110,111,99,104,114,111,109,101,10,98,109,111,
  95,109,97,115,107,101,100,0,5,99,111,117,110,116,2,84,4,108,101,102,
  116,2,32,3,116,111,112,2,40,5,105,109,97,103,101,10,164,23,0,0,
  0,0,0,0,3,0,0,0,150,0,0,0,150,0,0,0,184,11,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,128,0,0,0,0,2,0,0,0,0,0,0,0,0,0,255,129,
  255,192,127,128,1,0,0,0,3,0,0,0,0,0,24,3,0,0,1,129,
  128,64,64,128,3,0,1,128,3,0,0,0,0,0,184,3,112,0,1,129,
  128,64,68,128,7,128,3,192,3,254,15,0,0,0,240,1,248,0,1,129,
  128,64,68,128,15,192,7,224,3,252,7,0,0,0,224,0,248,0,1,129,
  190,64,95,128,31,224,15,240,3,248,3,0,0,0,240,1,248,0,1,129,
  128,64,68,128,15,240,31,224,3,240,1,0,0,0,184,3,112,0,1,129,
  128,64,68,128,7,248,63,192,3,224,0,0,0,0,24,3,0,0,1,129,
  128,64,64,128,3,0,0,128,3,64,0,0,0,0,0,0,0,0,255,129,
  255,192,127,128,1,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,128,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,32,0,
  0,128,8,0,17,0,0,4,8,0,2,0,0,0,96,0,32,0,48,0,
  0,128,12,0,19,0,0,4,14,128,3,0,136,8,224,0,112,0,56,0,
  127,128,14,0,23,0,0,132,15,224,3,0,220,29,224,1,248,0,60,0,
  62,128,15,0,31,96,27,228,15,248,3,0,136,8,224,0,252,1,56,0,
  28,128,14,0,23,96,27,132,15,224,3,0,0,0,96,0,0,0,48,0,
  8,128,12,0,19,0,0,4,14,128,3,0,0,0,32,0,0,0,32,0,
  0,128,8,0,17,0,0,4,8,0,2,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,28,0,0,0,0,0,0,112,0,0,0,
  0,0,192,96,48,192,17,0,0,56,0,0,16,0,4,8,112,0,0,0,
  0,0,224,224,56,240,23,0,0,112,0,0,112,0,28,8,112,0,0,0,
  12,0,112,192,29,48,30,252,31,224,0,0,240,1,124,8,254,131,255,1,
  30,0,56,128,15,24,28,252,31,192,1,0,240,7,252,9,254,131,255,1,
  63,96,28,0,7,24,31,0,0,192,0,0,240,1,124,8,254,131,255,129,
  127,224,14,128,15,24,0,0,0,96,6,0,112,0,28,8,112,0,0,192,
  255,192,7,192,29,16,0,252,31,48,3,0,16,0,4,8,112,0,0,0,
  0,128,3,224,56,48,0,252,31,152,1,0,0,0,0,0,112,0,0,0,
  0,0,1,96,48,96,0,0,0,204,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,128,0,0,0,96,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,14,255,31,120,0,56,0,
  2,128,25,0,0,0,0,0,0,0,0,0,0,7,6,12,252,0,40,0,
  6,0,6,0,0,0,0,0,0,0,0,0,128,3,12,6,134,1,40,0,
  14,0,6,0,0,0,0,0,0,248,3,0,192,1,24,3,3,3,40,0,
  30,0,6,128,4,0,0,0,0,64,0,0,224,0,176,1,3,3,40,0,
  62,0,6,0,3,0,1,192,0,224,0,0,192,0,160,0,3,3,40,0,
  126,0,6,192,15,128,3,192,0,240,1,0,152,1,160,0,3,3,108,0,
  62,0,6,0,3,0,1,0,0,248,3,0,48,3,160,0,134,1,198,0,
  30,0,6,128,4,0,0,0,0,0,0,0,96,6,160,0,252,3,131,1,
  14,0,6,0,0,0,0,0,0,0,0,0,192,12,160,0,120,135,1,3,
  6,0,6,0,0,0,0,0,0,0,0,0,128,1,224,0,0,206,255,7,
  2,128,25,0,0,0,0,0,0,0,0,0,0,3,0,0,0,4,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,254,15,255,135,255,195,
  255,1,0,0,0,0,0,0,0,0,0,0,0,0,255,159,255,207,255,231,
  255,3,0,0,0,0,0,0,0,0,0,0,0,0,3,152,1,204,0,102,
  0,3,0,0,0,0,0,0,0,0,0,0,0,0,3,152,141,205,192,102,
  0,3,0,0,7,192,7,0,0,248,3,0,0,0,3,152,221,205,224,102,
  28,3,14,128,13,96,12,224,3,8,2,0,240,7,3,152,249,204,112,102,
  62,3,17,192,24,32,8,32,2,8,2,0,224,3,3,152,113,204,56,102,
  62,3,17,64,16,32,8,32,2,8,2,0,192,1,3,152,249,204,28,102,
  62,3,17,192,24,32,8,32,2,8,2,0,128,0,3,152,221,205,14,102,
  28,3,14,128,13,96,12,224,3,8,2,0,240,7,3,152,141,205,6,102,
  0,3,0,0,7,192,7,0,0,248,3,0,0,0,3,152,1,204,0,102,
  0,3,0,0,0,0,0,0,0,0,0,0,0,0,255,159,255,207,255,231,
  255,3,0,0,0,0,0,0,0,0,0,0,0,0,254,15,255,135,255,195,
  255,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,248,15,0,0,0,0,16,0,
  0,0,0,0,2,0,0,0,0,4,4,0,8,8,0,0,32,0,56,0,
  0,0,4,0,2,0,0,16,4,8,2,0,8,8,64,0,112,0,108,0,
  8,0,4,0,2,64,4,32,2,16,1,0,8,8,160,0,216,0,198,0,
  8,0,4,0,2,128,2,64,1,160,0,0,8,8,16,1,140,1,131,1,
  62,128,63,224,63,0,1,128,0,64,0,0,8,8,160,0,216,0,198,0,
  8,0,4,0,2,128,2,64,1,160,0,0,8,8,64,0,112,0,108,0,
  8,0,4,0,2,64,4,32,2,16,1,0,8,8,0,0,32,0,56,0,
  0,0,4,0,2,0,0,16,4,8,2,0,248,15,0,0,0,0,16,0,
  0,0,0,0,2,0,0,0,0,4,4,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,
  0,0,0,0,1,3,2,16,0,24,3,0,128,0,64,0,112,0,0,0,
  0,224,255,192,193,15,14,112,0,24,3,0,64,1,160,0,216,0,254,128,
  255,192,96,240,241,63,62,240,1,24,3,0,32,2,16,1,140,1,68,0,
  65,128,49,252,253,255,254,240,7,24,3,0,240,7,8,2,6,3,40,0,
  34,0,27,240,241,63,62,240,1,24,3,0,0,0,252,7,255,7,16,0,
  20,0,14,192,193,15,14,112,0,24,3,0,0,0,0,0,0,0,0,0,
  8,0,4,0,1,3,2,16,0,24,3,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,64,0,224,
  227,131,99,224,255,0,0,0,0,0,0,0,0,0,0,6,96,128,96,224,
  193,195,49,80,144,0,0,228,31,230,15,0,0,4,0,6,80,4,81,224,
  227,227,16,73,148,252,127,0,0,230,15,0,1,84,0,3,88,9,90,224,
  247,243,177,73,148,4,64,0,0,0,0,0,7,82,128,3,79,10,79,160,
  227,186,251,72,144,4,92,228,31,0,0,0,31,82,224,1,65,10,73,0,
  65,16,31,200,159,244,75,0,0,230,15,0,127,82,216,1,65,10,81,0,
  0,0,14,8,128,244,75,0,0,230,15,0,31,81,246,1,65,10,97,0,
  65,0,31,8,128,244,75,228,31,0,0,0,7,209,185,1,79,10,79,160,
  227,130,59,200,159,4,92,0,0,0,0,0,129,80,84,1,88,9,216,224,
  247,195,113,8,128,4,64,0,0,230,15,0,128,0,82,1,80,4,80,225,
  227,227,224,200,159,252,127,228,31,230,15,0,0,0,105,1,96,0,96,226,
  193,115,192,9,128,0,0,0,0,0,0,0,0,0,36,1,0,0,0,228,
  227,51,128,248,255,0,0,0,0,0,0,0,0,0,32,1,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,240,
  255,255,255,255,255,255,255,255,255,255,63,0,0,0,0,0,255,135,255,243,
  168,168,168,168,168,168,168,168,167,167,39,0,252,3,170,138,255,207,255,247,
  255,255,255,255,255,255,255,255,255,255,63,0,4,2,4,132,1,204,0,246,
  255,255,255,255,255,255,255,255,255,255,63,0,4,2,8,130,13,204,6,246,
  255,255,255,255,125,125,125,255,35,35,35,0,228,31,16,129,29,204,14,246,
  0,0,0,255,0,0,0,255,132,132,4,0,36,18,160,128,57,204,28,246,
  255,255,255,255,255,255,255,255,255,255,63,0,36,18,0,128,113,204,56,246,
  0,0,0,255,167,167,167,255,168,168,40,0,36,18,160,128,225,204,112,246,
  0,0,0,255,220,220,220,255,247,247,55,0,252,19,0,128,193,205,224,246,
  39,39,39,255,135,135,135,255,255,255,63,0,32,16,160,128,129,205,192,246,
  255,255,255,255,224,224,224,255,171,171,43,0,32,16,0,128,1,204,0,246,
  255,255,255,255,71,71,71,255,44,44,44,0,224,31,160,128,255,207,255,247,
  171,171,171,255,255,255,255,255,255,255,63,0,0,0,0,0,255,135,255,243,
  255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,160,
  97,97,97,97,247,247,247,255,34,34,34,0,0,0,0,255,0,0,0,255,
  48,48,48,255,255,255,255,255,39,39,39,0,135,135,135,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,90,90,90,255,0,0,0,255,
  0,0,0,255,196,196,196,255,255,255,63,0,71,71,71,255,47,47,47,255,
  248,248,248,255,65,65,65,255,5,5,5,0,182,182,182,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,0,0,0,255,
  167,167,167,255,168,168,168,168,3,3,3,0,188,188,188,188,244,244,244,255,
  186,186,186,255,183,183,183,255,197,197,5,0,255,255,255,255,39,39,39,255,
  135,135,135,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  178,178,178,255,95,95,95,255,17,17,17,0,174,174,174,255,255,255,255,255,
  82,82,82,255,58,58,58,255,255,255,63,0,242,242,242,255,52,52,52,255,
  24,24,24,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,0,0,0,255,167,167,39,0,168,168,168,168,0,0,0,0,
  7,7,7,7,99,99,99,99,156,156,28,0,160,160,160,160,178,178,178,178,
  255,255,255,255,39,39,39,255,135,135,7,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,128,0,0,0,0,2,0,0,0,0,0,0,0,0,0,255,129,
  255,192,127,128,1,0,0,0,3,0,0,0,0,0,24,3,0,0,1,129,
  128,64,64,128,3,0,1,128,3,0,0,0,0,0,184,3,112,0,1,129,
  128,64,68,128,7,128,3,192,3,254,15,0,0,0,240,1,248,0,1,129,
  128,64,68,128,15,192,7,224,3,252,7,0,0,0,224,0,248,0,1,129,
  190,64,95,128,31,224,15,240,3,248,3,0,0,0,240,1,248,0,1,129,
  128,64,68,128,15,240,31,224,3,240,1,0,0,0,184,3,112,0,1,129,
  128,64,68,128,7,248,63,192,3,224,0,0,0,0,24,3,0,0,1,129,
  128,64,64,128,3,0,0,128,3,64,0,0,0,0,0,0,0,0,255,129,
  255,192,127,128,1,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,128,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,32,0,
  0,128,8,0,17,0,0,4,8,0,2,0,0,0,96,0,32,0,48,0,
  0,128,12,0,19,0,0,4,14,128,3,0,136,8,224,0,112,0,56,0,
  127,128,14,0,23,0,0,132,15,224,3,0,220,29,224,1,248,0,60,0,
  62,128,15,0,31,96,27,228,15,248,3,0,136,8,224,0,252,1,56,0,
  28,128,14,0,23,96,27,132,15,224,3,0,0,0,96,0,0,0,48,0,
  8,128,12,0,19,0,0,4,14,128,3,0,0,0,32,0,0,0,32,0,
  0,128,8,0,17,0,0,4,8,0,2,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,28,0,0,0,0,0,0,112,0,0,0,
  0,0,192,96,48,192,17,0,0,56,0,0,16,0,4,8,112,0,0,0,
  0,0,224,224,56,240,23,0,0,112,0,0,112,0,28,8,112,0,0,0,
  12,0,112,192,29,48,30,252,31,224,0,0,240,1,124,8,254,131,255,1,
  30,0,56,128,15,24,28,252,31,192,1,0,240,7,252,9,254,131,255,1,
  63,96,28,0,7,24,31,0,0,192,0,0,240,1,124,8,254,131,255,129,
  127,224,14,128,15,24,0,0,0,96,6,0,112,0,28,8,112,0,0,192,
  255,192,7,192,29,16,0,252,31,48,3,0,16,0,4,8,112,0,0,0,
  0,128,3,224,56,48,0,252,31,152,1,0,0,0,0,0,112,0,0,0,
  0,0,1,96,48,96,0,0,0,204,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,128,0,0,0,96,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,14,255,31,120,0,56,0,
  2,128,25,0,0,0,0,0,0,0,0,0,0,7,6,12,252,0,40,0,
  6,0,6,0,0,0,0,0,0,0,0,0,128,3,12,6,134,1,40,0,
  14,0,6,0,0,0,0,0,0,248,3,0,192,1,24,3,3,3,40,0,
  30,0,6,128,4,0,0,0,0,64,0,0,224,0,176,1,3,3,40,0,
  62,0,6,0,3,0,1,192,0,224,0,0,192,0,160,0,3,3,40,0,
  126,0,6,192,15,128,3,192,0,240,1,0,152,1,160,0,3,3,108,0,
  62,0,6,0,3,0,1,0,0,248,3,0,48,3,160,0,134,1,198,0,
  30,0,6,128,4,0,0,0,0,0,0,0,96,6,160,0,252,3,131,1,
  14,0,6,0,0,0,0,0,0,0,0,0,192,12,160,0,120,135,1,3,
  6,0,6,0,0,0,0,0,0,0,0,0,128,1,224,0,0,206,255,7,
  2,128,25,0,0,0,0,0,0,0,0,0,0,3,0,0,0,4,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,254,15,255,135,255,195,
  255,1,0,0,0,0,0,0,0,0,0,0,0,0,255,159,255,207,255,231,
  255,3,0,0,0,0,0,0,0,0,0,0,0,0,3,152,1,204,0,102,
  0,3,0,0,0,0,0,0,0,0,0,0,0,0,3,152,141,205,192,102,
  0,3,0,0,7,192,7,0,0,248,3,0,0,0,3,152,221,205,224,102,
  28,3,14,128,13,96,12,224,3,8,2,0,240,7,3,152,249,204,112,102,
  62,3,17,192,24,32,8,32,2,8,2,0,224,3,3,152,113,204,56,102,
  62,3,17,64,16,32,8,32,2,8,2,0,192,1,3,152,249,204,28,102,
  62,3,17,192,24,32,8,32,2,8,2,0,128,0,3,152,221,205,14,102,
  28,3,14,128,13,96,12,224,3,8,2,0,240,7,3,152,141,205,6,102,
  0,3,0,0,7,192,7,0,0,248,3,0,0,0,3,152,1,204,0,102,
  0,3,0,0,0,0,0,0,0,0,0,0,0,0,255,159,255,207,255,231,
  255,3,0,0,0,0,0,0,0,0,0,0,0,0,254,15,255,135,255,195,
  255,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,248,15,0,0,0,0,16,0,
  0,0,0,0,2,0,0,0,0,4,4,0,8,8,0,0,32,0,56,0,
  0,0,4,0,2,0,0,16,4,8,2,0,8,8,64,0,112,0,108,0,
  8,0,4,0,2,64,4,32,2,16,1,0,8,8,160,0,216,0,198,0,
  8,0,4,0,2,128,2,64,1,160,0,0,8,8,16,1,140,1,131,1,
  62,128,63,224,63,0,1,128,0,64,0,0,8,8,160,0,216,0,198,0,
  8,0,4,0,2,128,2,64,1,160,0,0,8,8,64,0,112,0,108,0,
  8,0,4,0,2,64,4,32,2,16,1,0,8,8,0,0,32,0,56,0,
  0,0,4,0,2,0,0,16,4,8,2,0,248,15,0,0,0,0,16,0,
  0,0,0,0,2,0,0,0,0,4,4,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,
  0,0,0,0,1,3,2,16,0,24,3,0,128,0,64,0,112,0,0,0,
  0,224,255,192,193,15,14,112,0,24,3,0,64,1,160,0,216,0,254,128,
  255,192,96,240,241,63,62,240,1,24,3,0,32,2,16,1,140,1,68,0,
  65,128,49,252,253,255,254,240,7,24,3,0,240,7,8,2,6,3,40,0,
  34,0,27,240,241,63,62,240,1,24,3,0,0,0,252,7,255,7,16,0,
  20,0,14,192,193,15,14,112,0,24,3,0,0,0,0,0,0,0,0,0,
  8,0,4,0,1,3,2,16,0,24,3,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,64,0,224,
  227,131,99,224,255,0,0,0,0,0,0,0,0,0,0,6,96,128,96,224,
  193,195,49,80,144,0,0,228,31,230,15,0,0,4,0,6,80,4,81,224,
  227,227,16,73,148,252,127,0,0,230,15,0,1,84,0,3,88,9,90,224,
  247,243,177,73,148,4,64,0,0,0,0,0,7,82,128,3,79,10,79,160,
  227,186,251,72,144,4,92,228,31,0,0,0,31,82,224,1,65,10,73,0,
  65,16,31,200,159,244,75,0,0,230,15,0,127,82,216,1,65,10,81,0,
  0,0,14,8,128,244,75,0,0,230,15,0,31,81,246,1,65,10,97,0,
  65,0,31,8,128,244,75,228,31,0,0,0,7,209,185,1,79,10,79,160,
  227,130,59,200,159,4,92,0,0,0,0,0,129,80,84,1,88,9,216,224,
  247,195,113,8,128,4,64,0,0,230,15,0,128,0,82,1,80,4,80,225,
  227,227,224,200,159,252,127,228,31,230,15,0,0,0,105,1,96,0,96,226,
  193,115,192,9,128,0,0,0,0,0,0,0,0,0,36,1,0,0,0,228,
  227,51,128,248,255,0,0,0,0,0,0,0,0,0,32,1,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,240,
  255,255,255,255,255,255,255,255,255,255,63,0,0,0,0,0,255,135,255,243,
  255,255,255,255,255,255,255,255,255,255,63,0,252,3,170,138,255,207,255,247,
  255,255,255,255,255,255,255,255,255,255,63,0,4,2,4,132,1,204,0,246,
  255,255,255,255,255,255,255,255,255,255,63,0,4,2,8,130,13,204,6,246,
  255,255,255,255,255,255,255,255,255,255,63,0,228,31,16,129,29,204,14,246,
  255,255,255,255,255,255,255,255,255,255,63,0,36,18,160,128,57,204,28,246,
  255,255,255,255,255,255,255,255,255,255,63,0,36,18,0,128,113,204,56,246,
  255,255,255,255,255,255,255,255,255,255,63,0,36,18,160,128,225,204,112,246,
  255,255,255,255,255,255,255,255,255,255,63,0,252,19,0,128,193,205,224,246,
  255,255,255,255,255,255,255,255,255,255,63,0,32,16,160,128,129,205,192,246,
  255,255,255,255,255,255,255,255,255,255,63,0,32,16,0,128,1,204,0,246,
  255,255,255,255,255,255,255,255,255,255,63,0,224,31,160,128,255,207,255,247,
  255,255,255,255,255,255,255,255,255,255,63,0,0,0,0,0,255,135,255,243,
  255,255,255,255,255,255,255,255,255,255,63,0,0,0,0,0,0,0,0,240,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,255,255,255,255,255,255,255,255,
  255,255,255,255,255,255,255,255,255,255,63,0,0,0,11,116,98,105,116,109,
  97,112,99,111,109,112,7,109,115,101,105,99,111,110,23,98,105,116,109,97,
  112,46,116,114,97,110,115,112,97,114,101,110,116,99,111,108,111,114,4,6,
  0,0,128,12,98,105,116,109,97,112,46,105,109,97,103,101,10,220,8,0,
  0,0,0,0,0,0,0,0,0,24,0,0,0,24,0,0,0,168,8,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,236,236,236,1,235,235,235,
  1,233,233,233,1,232,232,232,1,231,231,231,1,230,230,230,1,229,229,229,
  1,227,227,227,1,225,222,221,2,224,224,224,1,223,223,223,1,221,221,221,
  1,220,220,220,1,219,219,219,1,218,218,218,1,217,217,217,1,215,215,215,
  1,214,214,214,1,213,213,213,1,212,212,212,1,211,211,211,1,209,209,209,
  1,208,208,208,1,236,236,236,1,235,235,235,1,233,233,233,1,232,232,232,
  1,231,231,231,1,230,230,230,1,229,229,229,1,227,227,227,1,215,140,108,
  1,214,126,89,1,225,164,144,1,229,167,149,1,227,162,144,1,227,165,147,
  1,222,157,135,1,211,119,80,1,216,179,164,1,215,215,215,1,214,214,214,
  1,213,213,213,1,212,212,212,1,211,211,211,1,209,209,209,1,208,208,208,
  1,236,236,236,1,235,235,235,1,233,233,233,1,226,200,189,1,223,193,180,
  1,230,230,230,1,231,210,203,1,231,178,163,1,218,132,97,1,253,249,247,
  1,213,109,68,1,224,100,67,1,223,96,64,1,217,96,58,1,221,139,106,
  1,240,205,190,1,217,125,93,1,223,170,155,1,218,196,190,1,213,213,213,
  1,212,212,212,1,211,211,211,1,209,209,209,1,208,208,208,1,236,236,236,
  1,235,235,235,1,233,233,233,1,217,156,129,1,231,179,156,1,215,131,95,
  1,225,140,112,1,228,119,90,1,214,104,63,1,255,254,254,1,244,221,211,
  1,209,74,30,1,210,42,0,1,223,146,115,1,255,255,255,1,230,170,145,
  1,216,82,44,1,223,114,85,1,223,147,125,1,220,180,169,1,212,212,212,
  1,211,211,211,1,209,209,209,1,208,208,208,1,236,236,236,1,235,235,235,
  1,233,233,233,1,224,194,181,1,236,193,176,1,254,251,250,1,228,163,137,
  1,211,95,53,1,207,58,14,1,235,187,168,1,255,255,255,1,229,166,141,
  1,208,75,32,1,250,239,234,1,255,255,255,1,218,128,93,1,212,39,0,
  1,215,56,17,1,221,94,62,1,223,135,111,1,216,160,140,1,208,131,97,
  1,207,168,151,1,208,208,208,1,236,236,236,1,235,235,235,1,233,233,233,
  1,235,195,183,1,217,126,90,1,255,255,255,2,255,254,254,1,224,147,118,
  1,209,94,51,1,254,252,251,1,251,243,239,1,208,93,50,1,255,255,255,
  2,212,98,60,1,212,95,56,1,209,72,29,1,210,41,0,1,212,97,55,
  1,226,158,131,1,238,203,186,1,207,167,149,1,208,208,208,1,236,236,236,
  1,235,235,235,1,235,213,207,1,234,157,136,1,219,97,59,1,229,165,140,
  1,255,255,255,3,213,104,67,1,221,134,104,1,248,232,225,1,207,80,39,
  1,217,114,81,1,224,148,121,1,207,77,35,1,215,121,85,1,208,81,39,
  1,219,129,95,1,251,241,237,1,251,243,239,1,212,116,77,1,213,191,183,
  1,208,208,208,1,236,236,236,1,235,235,235,1,236,183,167,1,230,121,92,
  1,211,68,25,1,206,75,31,1,236,188,170,1,255,255,255,2,211,100,63,
  1,162,95,77,1,203,90,55,1,175,71,55,1,36,230,224,1,104,151,141,
  1,208,57,24,1,213,108,70,1,247,228,220,1,255,255,255,1,255,253,253,
  1,214,110,71,1,219,109,78,1,219,165,150,1,208,208,208,1,236,236,236,
  1,237,217,211,1,234,155,133,1,224,88,54,1,214,112,73,1,238,196,180,
  1,208,87,44,1,226,154,129,1,229,162,139,1,123,144,124,1,14,255,249,
  1,99,154,151,1,103,150,146,1,14,255,249,1,48,215,209,1,214,100,67,
  1,255,255,255,3,222,141,110,1,210,48,7,1,219,84,50,1,221,141,119,
  1,212,193,187,1,236,236,236,1,237,197,186,1,231,131,105,1,218,60,22,
  1,209,71,30,1,213,99,61,1,206,74,32,1,208,58,23,1,208,60,28,
  1,122,127,122,1,23,244,238,1,151,110,112,1,214,121,124,1,158,107,109,
  1,161,80,80,1,185,75,56,1,231,172,152,1,255,255,255,1,231,172,149,
  1,209,60,24,1,212,37,2,1,215,58,19,1,221,121,94,1,216,176,165,
  1,236,236,236,1,230,165,143,1,216,105,66,1,213,102,62,1,222,139,108,
  1,232,176,155,1,240,206,191,1,246,226,217,1,218,128,96,1,206,28,21,
  1,194,39,46,1,215,181,184,1,213,255,254,1,214,164,168,1,61,199,196,
  1,20,248,242,1,177,90,69,1,209,85,46,1,211,95,56,1,217,117,83,
  1,220,134,101,1,219,130,96,1,213,107,67,1,214,144,121,1,236,236,236,
  1,208,101,55,1,245,223,213,1,255,255,255,5,213,102,71,1,48,214,210,
  1,36,228,224,1,208,115,125,1,214,214,216,1,216,85,97,1,81,173,173,
  1,22,246,241,1,182,71,50,1,225,152,124,1,255,255,255,2,254,250,249,
  1,235,188,169,1,215,118,79,1,215,141,117,1,236,236,236,1,233,162,141,
  1,215,96,55,1,215,112,74,1,242,212,199,1,255,255,255,2,231,172,151,
  1,209,60,35,1,25,242,236,1,14,255,249,1,162,73,87,1,116,128,139,
  1,109,139,146,1,201,32,37,1,195,92,65,1,213,89,60,1,208,85,46,
  1,213,99,65,1,215,107,71,1,209,78,37,1,209,46,4,1,220,93,60,
  1,219,154,136,1,236,236,236,1,237,175,157,1,227,103,71,1,212,39,0,
  1,208,56,17,1,212,95,57,1,210,93,54,1,210,95,56,1,205,83,39,
  1,195,40,36,1,180,75,64,1,184,67,62,1,14,255,249,2,179,99,78,
  1,253,249,247,1,255,255,255,1,245,219,209,1,212,95,58,1,211,39,10,
  1,212,34,3,1,212,39,0,1,220,96,64,1,219,157,139,1,236,236,236,
  1,237,184,169,1,229,114,84,1,212,39,0,1,212,35,3,1,209,53,19,
  1,221,133,103,1,253,247,245,1,210,95,56,1,224,144,119,1,244,220,209,
  1,216,108,79,1,150,90,97,1,168,71,71,1,211,87,52,1,254,253,252,
  1,255,255,255,2,254,253,252,1,224,147,119,1,209,69,29,1,212,39,0,
  1,221,105,76,1,218,165,150,1,236,236,236,1,237,197,186,1,231,131,105,
  1,218,60,22,1,209,51,11,1,223,146,117,1,255,255,255,1,229,161,137,
  1,214,107,72,1,255,255,255,2,241,207,193,1,209,37,17,1,218,126,94,
  1,212,99,63,1,210,96,59,1,250,240,236,1,255,255,255,3,236,192,174,
  1,212,80,38,1,221,121,94,1,216,176,165,1,236,236,236,1,237,217,211,
  1,234,155,133,1,219,87,48,1,220,131,97,1,255,255,255,1,254,251,250,
  1,210,92,52,1,243,214,203,1,255,255,255,2,222,135,108,1,207,36,11,
  1,228,159,135,1,254,252,251,1,219,124,92,1,208,85,44,1,218,123,90,
  1,226,155,129,1,237,195,178,1,245,223,214,1,228,166,140,1,214,121,89,
  1,212,193,187,1,236,236,236,1,235,235,235,1,233,176,157,1,217,127,89,
  1,254,251,250,1,244,220,210,1,219,130,96,1,211,95,55,1,255,255,255,
  2,239,199,185,1,208,84,44,1,208,86,47,1,217,115,83,1,255,255,255,
  2,215,109,73,1,213,30,6,1,211,36,4,1,208,42,2,1,210,68,25,
  1,213,104,66,1,216,154,134,1,208,208,208,1,236,236,236,1,235,235,235,
  1,226,179,162,1,214,116,76,1,214,99,59,1,209,57,13,1,207,47,6,
  1,233,180,159,1,255,255,255,1,230,166,143,1,209,67,31,1,224,146,118,
  1,220,126,95,1,210,76,41,1,253,248,246,1,255,255,255,1,222,138,107,
  1,212,34,4,1,212,36,2,1,212,39,0,1,221,94,61,1,222,145,124,
  1,214,192,185,1,208,208,208,1,236,236,236,1,235,235,235,1,233,233,233,
  1,235,195,183,1,232,144,120,1,224,91,57,1,209,81,38,1,248,230,223,
  1,213,104,66,1,210,46,13,1,209,58,22,1,247,230,223,1,224,147,119,
  1,209,40,7,1,229,165,141,1,255,255,255,1,232,178,156,1,209,41,1,
  1,212,39,0,1,220,87,53,1,222,135,111,1,218,179,167,1,209,209,209,
  1,208,208,208,1,236,236,236,1,235,235,235,1,233,233,233,1,232,232,232,
  1,234,190,177,1,231,144,120,1,217,98,60,1,210,84,40,1,212,39,0,
  1,212,37,2,1,209,45,7,1,232,178,155,1,209,82,40,1,212,34,3,
  1,211,90,49,1,254,253,252,1,240,208,194,1,210,58,14,1,221,94,62,
  1,223,135,111,1,220,175,162,1,211,211,211,1,209,209,209,1,208,208,208,
  1,236,236,236,1,235,235,235,1,233,233,233,1,232,232,232,1,231,231,231,
  1,233,194,182,1,232,156,134,1,228,119,90,1,222,87,53,1,217,59,21,
  1,212,39,0,1,207,67,22,1,210,39,0,1,212,39,0,1,210,47,5,
  1,227,160,134,1,234,187,167,1,217,103,69,1,223,147,125,1,220,180,169,
  1,212,212,212,1,211,211,211,1,209,209,209,1,208,208,208,1,236,236,236,
  1,235,235,235,1,233,233,233,1,232,232,232,1,231,231,231,1,230,230,230,
  1,231,210,203,1,231,178,163,1,230,151,129,1,228,128,101,1,226,111,81,
  1,224,100,68,1,223,96,64,1,223,99,67,1,224,109,79,1,214,111,72,
  1,214,120,82,1,221,163,145,1,218,196,190,1,213,213,213,1,212,212,212,
  1,211,211,211,1,209,209,209,1,208,208,208,1,236,236,236,1,235,235,235,
  1,233,233,233,1,232,232,232,1,231,231,231,1,230,230,230,1,229,229,229,
  1,227,227,227,1,229,209,203,1,229,190,178,1,229,176,161,1,229,167,149,
  1,227,162,144,1,227,165,147,1,226,173,157,1,222,177,162,1,218,193,184,
  1,215,215,215,1,214,214,214,1,213,213,213,1,212,212,212,1,211,211,211,
  1,209,209,209,1,208,208,208,1,4,108,101,102,116,2,32,3,116,111,112,
  2,8,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tstockdata,'');
end.
