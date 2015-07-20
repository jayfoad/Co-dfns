:Namespace reverse

I←{⊃((⎕DR ⍵)323)⎕DR ⍵}
S←':Namespace' 'Run←{⌽⍵}' ':EndNamespace'
NS←⎕FIX S ⋄ C←#.codfns

REVERSE∆01∆GCC_TEST←{~(⊂'gcc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'gcc' ⋄ CS←'Scratch/reverse01'C.Fix S ⋄ C.COMPILER←'gcc'
  R←I ⍬ ⋄ #.UT.expect←NS.Run R ⋄ CS.Run R
}

REVERSE∆01∆ICC_TEST←{~(⊂'icc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'icc' ⋄ CS←'Scratch/reverse01'C.Fix S ⋄ C.COMPILER←'gcc'
  R←I ⍬ ⋄ #.UT.expect←NS.Run R ⋄ CS.Run R
}

REVERSE∆02∆GCC_TEST←{~(⊂'gcc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'gcc' ⋄ CS←'Scratch/reverse02'C.Fix S ⋄ C.COMPILER←'gcc'
  R←I 0 ⋄ #.UT.expect←NS.Run R ⋄ CS.Run R
}

REVERSE∆02∆ICC_TEST←{~(⊂'icc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'icc' ⋄ CS←'Scratch/reverse02'C.Fix S ⋄ C.COMPILER←'gcc'
  R←I 0 ⋄ #.UT.expect←NS.Run R ⋄ CS.Run R
}

REVERSE∆03∆GCC_TEST←{~(⊂'gcc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'gcc' ⋄ CS←'Scratch/reverse03'C.Fix S ⋄ C.COMPILER←'gcc'
  R←I ⍳5 ⋄ #.UT.expect←NS.Run R ⋄ CS.Run R
}

REVERSE∆03∆ICC_TEST←{~(⊂'icc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'icc' ⋄ CS←'Scratch/reverse03'C.Fix S ⋄ C.COMPILER←'gcc'
  R←I ⍳5 ⋄ #.UT.expect←NS.Run R ⋄ CS.Run R
}

REVERSE∆04∆GCC_TEST←{~(⊂'gcc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'gcc' ⋄ CS←'Scratch/reverse04'C.Fix S ⋄ C.COMPILER←'gcc'
  R←I 2 3 4⍴⍳5 ⋄ #.UT.expect←NS.Run R ⋄ CS.Run R
}

REVERSE∆04∆ICC_TEST←{~(⊂'icc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'icc' ⋄ CS←'Scratch/reverse04'C.Fix S ⋄ C.COMPILER←'gcc'
  R←I 2 3 4⍴⍳5 ⋄ #.UT.expect←NS.Run R ⋄ CS.Run R
}

:EndNamespace
