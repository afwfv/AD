::init
@echo off
chcp 65001
cd %~dp0\aa
cls
if exist *.txt del /f /q .\*.txt
python --version
set wgetFix=--local-encoding=UTF-8 --remote-encoding=UTF-8 --restrict-file-names=nocontrol --no-cookies --no-check-certificate
set wgetUAWindows=-U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5047.0 Safari/537.36"
set wgetUAiPhone=-U "Mozilla/5.0 (iPhone; CPU iPhone OS 15_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 SearchCraft/3.9.0 (Baidu; P2 15.5)"
echo Init-OK!

::set date and time
::echo %time%
::echo %date%
::set times=%date:~3,4%/%date:~8,2%/%date:~11,2% %time:~0,2%:%time:~3,2%
::set dates=%date:~0,4%/%date:~5,2%/%date:~8,2%

::enable proxy in local machine (not needed
::set http_proxy=127.0.0.1:7890
::set https_proxy=127.0.0.1:7890

::process list
for /f "eol=# tokens=1 delims= " %%i in (..\rule-list.ini) do (
>>list.txt echo %%i
)

::start download files in rule-list and convert and merge
for /f "skip=1 eol=; tokens=1,2,3 delims==" %%i in (list.txt) do (

echo Downloading...
wget -q --no-hsts %wgetFix% %wgetUAiPhone% -t 2 -T 30 -O down.txt %%j
echo Download-OK!

sed -i -E --posix "/^$/d" down.txt

if %%i==c2w (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^.+?,//g" down.txt
sed -i -E --posix "s/,.+$//g" down.txt
sed -i -E --posix  "s/^/@@||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==c2a (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^.+?,//g" down.txt
sed -i -E --posix "s/,.+$//g" down.txt
sed -i -E --posix  "s/^/||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2w (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
sed -i -E --posix  "s/^/@@||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2a (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
sed -i -E --posix  "s/^/||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2w (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix  "s/^/@@||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2a (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix  "s/^/||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2wa (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
sed -i -E --posix  "s/^/@@|/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2aa (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
sed -i -E --posix  "s/^/|/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2wa (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix  "s/^/@@|/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2aa (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix  "s/^/|/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==a2w (
echo Auto-transformation-%%i...
sed -i -E --posix  "s/^\|\|/@@||/g" down.txt
echo Auto-transformation-OK!
)

if %%i==w2a (
echo Auto-transformation-%%i...
sed -i -E --posix  "s/^\@\@\|\|/||/g" down.txt
echo Auto-transformation-OK!
)

echo Merging...
type blank.dd>>down.txt
type down.txt>>mergd.txt
echo Merge-OK!

)
echo Download-completed!

::Merge custom rules in folder
echo Merging-Custom...

type .\custom-rules\*>>mergd.txt

echo Merge-OK!

::primary deduplicate
echo Deduplicate...

set LC_ALL='C'
s -u -r -i -o nore.txt mergd.txt
set LC_ALL=

echo Deduplicate-OK!

::extract useful lines
echo Extracting-lines...

::extract punctuation mark into file
(findstr /b /c:"##" nore.txt)>nord.txt
(findstr /b /c:"#%#" nore.txt)>>nord.txt
(findstr /b /c:"#$#" nore.txt)>>nord.txt
(findstr /b /c:"#@#" nore.txt)>>nord.txt
(findstr /b /c:"#pkg" nore.txt)>>nord.txt
(findstr /b /c:"$" nore.txt)>>nord.txt
(findstr /b /c:"&" nore.txt)>>nord.txt
(findstr /b /c:"(" nore.txt)>>nord.txt
(findstr /b /c:"*" nore.txt)>>nord.txt
(findstr /b /c:"," nore.txt)>>nord.txt
(findstr /b /c:"-" nore.txt)>>nord.txt
(findstr /b /c:"." nore.txt)>>nord.txt
(findstr /b /c:"/" nore.txt)>>nord.txt
(findstr /b /c:":" nore.txt)>>nord.txt
(findstr /b /c:";" nore.txt)>>nord.txt
(findstr /b /c:"=" nore.txt)>>nord.txt
(findstr /b /c:"?" nore.txt)>>nord.txt
(findstr /b /c:"@" nore.txt)>>nord.txt
(findstr /b /c:"_" nore.txt)>>nord.txt
(findstr /b /c:"^" nore.txt)>>nord.txt
(findstr /b /c:"|" nore.txt)>>nord.txt
(findstr /b /c:"~" nore.txt)>>nord.txt

::extract numbers into file
(findstr /b [0-9] nore.txt)>>nord.txt

::extract alphabet into file
(findstr /b [Aa-Zz] nore.txt)>>nord.txt

echo Extract-OK!


echo Sorting...

::set LC_ALL='C'
::s -u -i -o nordv.txt nord.txt

python sort.py nord.txt nordv.txt

echo Sort-OK!

::count total rules
echo Counting...
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nordv.txt')do set/a rnum=%%a
echo Count-OK!

::get and save version code
echo Getting-codes...
for /f "tokens=1,2 delims=:" %%i in ('echo %time%') do (set v3=%%i%%j)
if not %v3% gtr 999 set v3=0%v3%
for /f "tokens=2 delims= " %%i in ('echo %date%') do (set v1=%%i)
for /f "tokens=1,2,3 delims=/" %%i in ('echo %v1%') do (set v2=%%k%%i%%j)
set vs=%v2%%v3%

for /f "tokens=1,2 delims=:" %%i in ('echo %time%') do (set g3=%%i:%%j)
for /f "tokens=1,2,3 delims=/" %%i in ('echo %v1%') do (set g1=%%k/%%i/%%j)
set gs=%g1% %g3%

::get last modified time
::for /f "tokens=2,3 delims= " %%i in ('echo %date% %time%') do (set lm=%%i %%j)
::for /f "tokens=1 delims=." %%i in ('echo %lm%') do (set lm=%%i)

::save info into file
::if local,disable this
::in order to update readme
if not exist ..\..\changelog md ..\..\changelog
echo {"schemaVersion":1,"label":"Last updated","color":"green","message":"%gs% (????????????)"} > ..\..\changelog\date
echo {"schemaVersion":1,"label":"Version","color":"blue","message":"%vs%"} > ..\..\changelog\ver
echo {"schemaVersion":1,"label":"Rule count","color":"yellow","message":"%rnum%"} > ..\..\changelog\num

::add title and date to rule
echo ! Version: %vs%>tpdate.txt
echo ! Last modified: %gs% (????????????)>>tpdate.txt
echo ! Count: %rnum%>>tpdate.txt
echo.>>tpdate.txt
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>>tpdate.txt
echo.>>tpdate.txt
echo Get-codes-OK!

::final merge
echo Merging...
type title.dd>w.txt
type tpdate.txt>>w.txt
type nordv.txt>>w.txt
type addition.dd>>w.txt
echo Merge-OK!

::move file out
copy /y .\w.txt ..\..\

::end cleanup
if not %rnum% gtr 1000 (
echo FAILING...
exit 114514
)
echo All-done!
del /f /q .\*.txt&exit 0
