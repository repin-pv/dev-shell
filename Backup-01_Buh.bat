CLS
ECHO OFF
CHCP 1251

REM �������� ����� ������ 7 ����
forfiles /p "C:\Base\01_Buh\Backup" /S /D -7 /C "cmd /c del /f /a /q @file"

REM ��������� ���������� ���������
SET PGDATABASE=01_Buh
SET PGHOST=localhost
SET PGPORT=5432
SET PGUSER=postgres
SET PGPASSWORD=1234

REM ������������ ����� ����� ��������� ����� � �����-������
SET DATETIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2% %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
SET DUMPFILE=%PGDATABASE% %DATETIME%.backup
SET LOGFILE=%PGDATABASE% %DATETIME%.log
SET DUMPPATH="C:\Base\01_Buh\Backup\%DUMPFILE%"
SET LOGPATH="C:\Base\01_Buh\Backup\%LOGFILE%"

REM �������� ��������� �����
IF NOT EXIST Backup MD Backup
CALL "C:\Program Files\PostgreSQL\11.9-1.1C\bin\pg_dump.exe" --format=custom --verbose --file=%DUMPPATH% 2>%LOGPATH%

REM ������ ���� ����������
IF NOT %ERRORLEVEL%==0 GOTO Error
GOTO Successfull

REM � ������ ������ ��������� ������������ ��������� ����� � �������� ��������������� ������ � �������
:Error
DEL %DUMPPATH%
MSG * "ERROR to create backup!!! See the information C:\Base\01_Buh\backup.log."
ECHO %DATETIME% ������ ��� �������� ��������� ����� %DUMPFILE%. �������� %LOGFILE%. >> backup.log
GOTO End

REM � ������ �������� ���������� ����������� ������ �������� ������ � ������
:Successfull
ECHO %DATETIME% �������� �������� ��������� ����� %DUMPFILE% >> backup.log
GOTO End
:End