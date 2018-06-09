cd src

ml64 dllmain.asm /c /Fo"dllmain.obj"
ml64 add.asm /c /Fo"add.obj"

if exist "bin\Release" rmdir bin\Release /s /q
mkdir bin\Release

link /ENTRY:DllMain /DEF:BigBadInt128.def /dll dllmain.obj add.obj /out:bin\Release\BigBadInt128.dll

cd ..
