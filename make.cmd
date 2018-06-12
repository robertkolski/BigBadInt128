cd src

ml64 dllmain.asm /c /Fo"dllmain.obj"
ml64 Int128Add.asm /c /Fo"Int128Add.obj"
ml64 Int128Sub.asm /c /Fo"Int128Sub.obj"
ml64 Int128Mul.asm /c /Fo"Int128Mul.obj"
ml64 Int128ToString.asm /c /Fo"Int128ToString.obj"
ml64 Int128Parse.asm /c /Fo"Int128Parse.obj"
ml64 UInt128Mul.asm /c /Fo"UInt128Mul.obj"
ml64 UInt128ToString.asm /c /Fo"UInt128ToString.obj"
ml64 UInt128Parse.asm /c /Fo"UInt128Parse.obj"

if exist "bin\Release" rmdir bin\Release /s /q
mkdir bin\Release

link /ENTRY:DllMain /DEF:BigBadInt128.def /dll dllmain.obj Int128Add.obj Int128Sub.obj Int128Mul.obj Int128ToString.obj Int128Parse.obj UInt128Mul.obj UInt128ToString.obj UInt128Parse.obj /out:bin\Release\BigBadInt128.dll

cd ..
