@echo off
SET CALLDIR=%~dp0
%CALLDIR%\espeak.exe --path=%CALLDIR%\..\ %*