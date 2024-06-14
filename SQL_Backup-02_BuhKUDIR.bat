CLS
ECHO OFF
# CHCP 1251

REM Удаление копий старше 7 дней
forfiles /p "C:\Base\02_BuhKUDIR\Backup" /S /D -7 /C "cmd /c del /f /a /q @file"

REM Установка переменных окружения
SET PGDATABASE=01_Buh
SET PGHOST=localhost
SET PGPORT=5432
SET PGUSER=postgres
SET PGPASSWORD=1234

REM Формирование имени файла резервной копии и файла-отчета
SET DATETIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2% %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
SET DUMPFILE=%PGDATABASE% %DATETIME%.backup
SET LOGFILE=%PGDATABASE% %DATETIME%.log
SET DUMPPATH="C:\Base\02_BuhKUDIR\Backup\%DUMPFILE%"
SET LOGPATH="C:\Base\02_BuhKUDIR\Backup\%LOGFILE%"

REM Создание резервной копии
IF NOT EXIST Backup MD Backup
CALL "C:\Program Files\PostgreSQL\11.9-1.1C\bin\pg_dump.exe" --format=custom --verbose --file=%DUMPPATH% 2>%LOGPATH%

REM Анализ кода завершения
IF NOT %ERRORLEVEL%==0 GOTO Error
GOTO Successfull

REM В случае ошибки удаляется поврежденная резервная копия и делается соответствующая запись в журнале
:Error
DEL %DUMPPATH%
MSG * "ERROR to create backup!!! See the information C:\Base\02_BuhKUDIR\backup.log."
ECHO %DATETIME% Ошибка при создании резервной копии %DUMPFILE%. Смотрите %LOGFILE%. >> backup.log
GOTO End

REM В случае удачного резервного копирования просто делается запись в журнал
:Successfull
ECHO %DATETIME% Успешное создание резервной копии %DUMPFILE% >> backup.log
GOTO End
:End