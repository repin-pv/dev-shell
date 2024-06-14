@echo off

set source="D:\Base\DB_14-03-2014"
set destination="D:\BackUp"
set passwd="Password"
set dd=%DATE:~0,2%
set mm=%DATE:~3,2%
set yyyy=%DATE:~6,4%
set curdate=%dd%-%mm%-%yyyy%

"C:\Program Files\7-Zip\7z.exe" a -tzip -ssw -mx1 -p%passwd% -r0 %destination%\1c77_%curdate%.zip %source%