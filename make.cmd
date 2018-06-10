cd src

ml64 dllmain.asm /c /Fo"dllmain.obj"
ml64 Int128Add.asm /c /Fo"Int128Add.obj"
ml64 Int128Sub.asm /c /Fo"Int128Sub.obj"
ml64 Int128ToString.asm /c /Fo"Int128ToString.obj"

if exist "bin\Release" rmdir bin\Release /s /q
mkdir bin\Release

link /ENTRY:DllMain /DEF:BigBadInt128.def /dll dllmain.obj Int128Add.obj Int128Sub.obj Int128ToString.obj /out:bin\Release\BigBadInt128.dll

cd ..
