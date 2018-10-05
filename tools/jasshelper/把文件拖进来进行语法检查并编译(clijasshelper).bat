ECHO ON
START /wait  %~dp0\clijasshelper.exe --scriptonly %~dp0\Scripts\common.j  %~dp0\Scripts\blizzard.j %~nx1 %~n1.vj
pause