cd src

ml64 /c /Fo"dllmain.obj" /Fldllmain.lst /Sa dllmain.asm
ml64 /c /Fo"Int128Add.obj" /FlInt128Add.lst /Sa Int128Add.asm
ml64 /c /Fo"Int128Sub.obj" /FlInt128Sub.lst /Sa Int128Sub.asm
ml64 /c /Fo"Int128Mul.obj" /FlInt128Mul.lst /Sa Int128Mul.asm
ml64 /c /Fo"Int128ToString.obj" /FlInt128ToString.lst /Sa Int128ToString.asm 
ml64 /c /Fo"Int128Parse.obj" /FlInt128Parse.lst /Sa Int128Parse.asm
ml64 /c /Fo"UInt128Add.obj" /FlUInt128Add.lst /Sa UInt128Add.asm
ml64 /c /Fo"UInt128Sub.obj" /FlUInt128Sub.lst /Sa UInt128Sub.asm
ml64 /c /Fo"UInt128Mul.obj" /FlUInt128Mul.lst /Sa UInt128Mul.asm
ml64 /c /Fo"UInt128ToString.obj" /FlUInt128ToString.lst /Sa UInt128ToString.asm
ml64 /c /Fo"UInt128Parse.obj" /FlUInt128Parse.lst /Sa UInt128Parse.asm 

if exist "bin\Release" rmdir bin\Release /s /q
mkdir bin\Release

link /ENTRY:DllMain /DEF:BigBadInt128.def /dll dllmain.obj Int128Add.obj Int128Sub.obj Int128Mul.obj Int128ToString.obj Int128Parse.obj UInt128Add.obj UInt128Sub.obj UInt128Mul.obj UInt128ToString.obj UInt128Parse.obj /out:bin\Release\BigBadInt128.dll

cd ..
