{-# OPTIONS_GHC -w #-}
module Parser(parse) where

import Token
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.0

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34 t35 t36 t37 t38
	= HappyTerminal (TokenClass)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27
	| HappyAbsSyn28 t28
	| HappyAbsSyn29 t29
	| HappyAbsSyn30 t30
	| HappyAbsSyn31 t31
	| HappyAbsSyn32 t32
	| HappyAbsSyn33 t33
	| HappyAbsSyn34 t34
	| HappyAbsSyn35 t35
	| HappyAbsSyn36 t36
	| HappyAbsSyn37 t37
	| HappyAbsSyn38 t38

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,304) ([0,0,2880,34832,7,0,46080,33024,120,0,16384,4107,1928,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49216,34832,7,0,1024,256,0,0,16384,0,0,0,0,4,1,0,0,192,34832,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,4107,1928,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,16392,0,0,0,64,34832,7,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,16384,0,0,0,8256,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1024,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,384,0,0,0,0,0,0,0,0,1024,0,0,32832,34832,7,0,0,0,0,0,0,0,64,0,0,4,1,0,0,64,51216,7,0,1024,33024,120,0,0,128,0,0,0,0,0,0,0,0,16384,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,33024,124,0,0,0,16,0,0,4,0,0,0,32768,16384,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,0,0,64,16,0,0,1024,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,1024,33024,120,0,16384,4096,1928,0,0,0,0,0,0,0,0,0,0,1024,33024,120,0,0,0,0,0,0,180,30849,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,30849,0,0,0,0,0,0,1024,33024,124,0,0,0,0,0,0,0,1024,0,0,32832,0,0,0,0,2,4,0,0,0,0,0,0,4,1,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,1024,0,2,0,0,64,0,0,0,4,0,0,0,0,8192,0,0,0,0,0,0,0,32,64,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,16384,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,32,32,0,0,4,0,0,0,0,16384,0,0,1024,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","prog","body","indentedBody","decl","def","rhs","exprlist","expr","lambda","singlelambda","oper","app","single","varlistAux","varlist","typesig","typeannotation","constrainedtype","constraintlist","constraint","type","type1","typelistAux","typelist","singletype","instance","class","adt","adtrhs","constructors","linedconstructors","variant","gadt","gadtconstructors","gadtconstructor","VAR","OP","CLASS","DATA","TYPE","INSTANCE","VIEW","'|'","':'","'='","'->'","'<-'","'=>'","')'","'('","'}'","'{'","']'","'['","','","';'","'_'","INDENT","DEDENT","NEWLINE","INT","CHAR","STRING","FLOAT","%eof"]
        bit_start = st Prelude.* 68
        bit_end = (st Prelude.+ 1) Prelude.* 68
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..67]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (39) = happyShift action_12
action_0 (41) = happyShift action_13
action_0 (42) = happyShift action_14
action_0 (44) = happyShift action_15
action_0 (53) = happyShift action_16
action_0 (60) = happyShift action_17
action_0 (64) = happyShift action_18
action_0 (65) = happyShift action_19
action_0 (66) = happyShift action_20
action_0 (67) = happyShift action_21
action_0 (4) = happyGoto action_22
action_0 (5) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 (16) = happyGoto action_6
action_0 (19) = happyGoto action_7
action_0 (29) = happyGoto action_8
action_0 (30) = happyGoto action_9
action_0 (31) = happyGoto action_10
action_0 (36) = happyGoto action_11
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (39) = happyShift action_12
action_1 (41) = happyShift action_13
action_1 (42) = happyShift action_14
action_1 (44) = happyShift action_15
action_1 (53) = happyShift action_16
action_1 (60) = happyShift action_17
action_1 (64) = happyShift action_18
action_1 (65) = happyShift action_19
action_1 (66) = happyShift action_20
action_1 (67) = happyShift action_21
action_1 (4) = happyGoto action_2
action_1 (5) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 (16) = happyGoto action_6
action_1 (19) = happyGoto action_7
action_1 (29) = happyGoto action_8
action_1 (30) = happyGoto action_9
action_1 (31) = happyGoto action_10
action_1 (36) = happyGoto action_11
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (39) = happyShift action_12
action_2 (41) = happyShift action_13
action_2 (42) = happyShift action_14
action_2 (44) = happyShift action_15
action_2 (53) = happyShift action_16
action_2 (60) = happyShift action_17
action_2 (64) = happyShift action_18
action_2 (65) = happyShift action_19
action_2 (66) = happyShift action_20
action_2 (67) = happyShift action_21
action_2 (7) = happyGoto action_23
action_2 (8) = happyGoto action_5
action_2 (16) = happyGoto action_6
action_2 (19) = happyGoto action_7
action_2 (29) = happyGoto action_8
action_2 (30) = happyGoto action_9
action_2 (31) = happyGoto action_10
action_2 (36) = happyGoto action_11
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyReduce_1

action_4 _ = happyReduce_3

action_5 _ = happyReduce_6

action_6 (40) = happyShift action_49
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_7

action_8 _ = happyReduce_8

action_9 _ = happyReduce_9

action_10 _ = happyReduce_10

action_11 _ = happyReduce_11

action_12 (39) = happyShift action_30
action_12 (47) = happyShift action_47
action_12 (48) = happyShift action_48
action_12 (53) = happyShift action_16
action_12 (60) = happyShift action_17
action_12 (64) = happyShift action_18
action_12 (65) = happyShift action_19
action_12 (66) = happyShift action_20
action_12 (67) = happyShift action_21
action_12 (10) = happyGoto action_44
action_12 (16) = happyGoto action_45
action_12 (20) = happyGoto action_46
action_12 _ = happyReduce_29

action_13 (39) = happyShift action_40
action_13 (53) = happyShift action_41
action_13 (21) = happyGoto action_43
action_13 (22) = happyGoto action_33
action_13 (23) = happyGoto action_34
action_13 (24) = happyGoto action_35
action_13 (25) = happyGoto action_36
action_13 (26) = happyGoto action_37
action_13 (27) = happyGoto action_38
action_13 (28) = happyGoto action_39
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (39) = happyShift action_42
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (39) = happyShift action_40
action_15 (53) = happyShift action_41
action_15 (21) = happyGoto action_32
action_15 (22) = happyGoto action_33
action_15 (23) = happyGoto action_34
action_15 (24) = happyGoto action_35
action_15 (25) = happyGoto action_36
action_15 (26) = happyGoto action_37
action_15 (27) = happyGoto action_38
action_15 (28) = happyGoto action_39
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (39) = happyShift action_30
action_16 (40) = happyShift action_31
action_16 (53) = happyShift action_16
action_16 (60) = happyShift action_17
action_16 (64) = happyShift action_18
action_16 (65) = happyShift action_19
action_16 (66) = happyShift action_20
action_16 (67) = happyShift action_21
action_16 (11) = happyGoto action_24
action_16 (12) = happyGoto action_25
action_16 (13) = happyGoto action_26
action_16 (14) = happyGoto action_27
action_16 (15) = happyGoto action_28
action_16 (16) = happyGoto action_29
action_16 _ = happyFail (happyExpListPerState 16)

action_17 _ = happyReduce_34

action_18 _ = happyReduce_30

action_19 _ = happyReduce_31

action_20 _ = happyReduce_32

action_21 _ = happyReduce_33

action_22 (39) = happyShift action_12
action_22 (41) = happyShift action_13
action_22 (42) = happyShift action_14
action_22 (44) = happyShift action_15
action_22 (53) = happyShift action_16
action_22 (60) = happyShift action_17
action_22 (64) = happyShift action_18
action_22 (65) = happyShift action_19
action_22 (66) = happyShift action_20
action_22 (67) = happyShift action_21
action_22 (68) = happyAccept
action_22 (7) = happyGoto action_23
action_22 (8) = happyGoto action_5
action_22 (16) = happyGoto action_6
action_22 (19) = happyGoto action_7
action_22 (29) = happyGoto action_8
action_22 (30) = happyGoto action_9
action_22 (31) = happyGoto action_10
action_22 (36) = happyGoto action_11
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_2

action_24 (52) = happyShift action_75
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_19

action_26 _ = happyReduce_20

action_27 (40) = happyShift action_73
action_27 (51) = happyShift action_74
action_27 _ = happyReduce_22

action_28 (39) = happyShift action_30
action_28 (53) = happyShift action_16
action_28 (60) = happyShift action_17
action_28 (64) = happyShift action_18
action_28 (65) = happyShift action_19
action_28 (66) = happyShift action_20
action_28 (67) = happyShift action_21
action_28 (16) = happyGoto action_72
action_28 _ = happyReduce_24

action_29 _ = happyReduce_25

action_30 _ = happyReduce_29

action_31 (52) = happyShift action_71
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (63) = happyShift action_70
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (51) = happyShift action_68
action_33 (58) = happyShift action_69
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_44

action_35 _ = happyReduce_42

action_36 (49) = happyShift action_67
action_36 _ = happyReduce_47

action_37 (39) = happyShift action_63
action_37 (53) = happyShift action_41
action_37 (28) = happyGoto action_66
action_37 _ = happyReduce_51

action_38 _ = happyReduce_48

action_39 _ = happyReduce_50

action_40 (39) = happyShift action_61
action_40 (51) = happyReduce_35
action_40 (58) = happyReduce_35
action_40 (17) = happyGoto action_59
action_40 (18) = happyGoto action_65
action_40 _ = happyReduce_53

action_41 (39) = happyShift action_63
action_41 (52) = happyShift action_64
action_41 (53) = happyShift action_41
action_41 (24) = happyGoto action_62
action_41 (25) = happyGoto action_36
action_41 (26) = happyGoto action_37
action_41 (27) = happyGoto action_38
action_41 (28) = happyGoto action_39
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (39) = happyShift action_61
action_42 (17) = happyGoto action_59
action_42 (18) = happyGoto action_60
action_42 _ = happyReduce_35

action_43 (63) = happyShift action_58
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (39) = happyShift action_30
action_44 (48) = happyShift action_57
action_44 (53) = happyShift action_16
action_44 (60) = happyShift action_17
action_44 (64) = happyShift action_18
action_44 (65) = happyShift action_19
action_44 (66) = happyShift action_20
action_44 (67) = happyShift action_21
action_44 (16) = happyGoto action_56
action_44 _ = happyFail (happyExpListPerState 44)

action_45 _ = happyReduce_17

action_46 (63) = happyShift action_55
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (39) = happyShift action_40
action_47 (53) = happyShift action_41
action_47 (21) = happyGoto action_54
action_47 (22) = happyGoto action_33
action_47 (23) = happyGoto action_34
action_47 (24) = happyGoto action_35
action_47 (25) = happyGoto action_36
action_47 (26) = happyGoto action_37
action_47 (27) = happyGoto action_38
action_47 (28) = happyGoto action_39
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (39) = happyShift action_30
action_48 (53) = happyShift action_16
action_48 (60) = happyShift action_17
action_48 (63) = happyShift action_53
action_48 (64) = happyShift action_18
action_48 (65) = happyShift action_19
action_48 (66) = happyShift action_20
action_48 (67) = happyShift action_21
action_48 (9) = happyGoto action_51
action_48 (11) = happyGoto action_52
action_48 (12) = happyGoto action_25
action_48 (13) = happyGoto action_26
action_48 (14) = happyGoto action_27
action_48 (15) = happyGoto action_28
action_48 (16) = happyGoto action_29
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (39) = happyShift action_30
action_49 (53) = happyShift action_16
action_49 (60) = happyShift action_17
action_49 (64) = happyShift action_18
action_49 (65) = happyShift action_19
action_49 (66) = happyShift action_20
action_49 (67) = happyShift action_21
action_49 (16) = happyGoto action_50
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (48) = happyShift action_93
action_50 _ = happyFail (happyExpListPerState 50)

action_51 _ = happyReduce_13

action_52 (63) = happyShift action_92
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (61) = happyShift action_91
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_40

action_55 _ = happyReduce_39

action_56 _ = happyReduce_18

action_57 (39) = happyShift action_30
action_57 (53) = happyShift action_16
action_57 (60) = happyShift action_17
action_57 (63) = happyShift action_53
action_57 (64) = happyShift action_18
action_57 (65) = happyShift action_19
action_57 (66) = happyShift action_20
action_57 (67) = happyShift action_21
action_57 (9) = happyGoto action_90
action_57 (11) = happyGoto action_52
action_57 (12) = happyGoto action_25
action_57 (13) = happyGoto action_26
action_57 (14) = happyGoto action_27
action_57 (15) = happyGoto action_28
action_57 (16) = happyGoto action_29
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (61) = happyShift action_79
action_58 (6) = happyGoto action_89
action_58 _ = happyReduce_5

action_59 (39) = happyShift action_88
action_59 _ = happyReduce_38

action_60 (48) = happyShift action_86
action_60 (63) = happyShift action_87
action_60 (32) = happyGoto action_85
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_37

action_62 (52) = happyShift action_84
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_53

action_64 _ = happyReduce_54

action_65 _ = happyReduce_45

action_66 _ = happyReduce_49

action_67 (39) = happyShift action_63
action_67 (53) = happyShift action_41
action_67 (24) = happyGoto action_83
action_67 (25) = happyGoto action_36
action_67 (26) = happyGoto action_37
action_67 (27) = happyGoto action_38
action_67 (28) = happyGoto action_39
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (39) = happyShift action_63
action_68 (53) = happyShift action_41
action_68 (24) = happyGoto action_82
action_68 (25) = happyGoto action_36
action_68 (26) = happyGoto action_37
action_68 (27) = happyGoto action_38
action_68 (28) = happyGoto action_39
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (39) = happyShift action_81
action_69 (23) = happyGoto action_80
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (61) = happyShift action_79
action_70 (6) = happyGoto action_78
action_70 _ = happyReduce_5

action_71 _ = happyReduce_28

action_72 _ = happyReduce_26

action_73 (39) = happyShift action_30
action_73 (53) = happyShift action_16
action_73 (60) = happyShift action_17
action_73 (64) = happyShift action_18
action_73 (65) = happyShift action_19
action_73 (66) = happyShift action_20
action_73 (67) = happyShift action_21
action_73 (15) = happyGoto action_77
action_73 (16) = happyGoto action_29
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (39) = happyShift action_30
action_74 (53) = happyShift action_16
action_74 (60) = happyShift action_17
action_74 (64) = happyShift action_18
action_74 (65) = happyShift action_19
action_74 (66) = happyShift action_20
action_74 (67) = happyShift action_21
action_74 (11) = happyGoto action_76
action_74 (12) = happyGoto action_25
action_74 (13) = happyGoto action_26
action_74 (14) = happyGoto action_27
action_74 (15) = happyGoto action_28
action_74 (16) = happyGoto action_29
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_27

action_76 _ = happyReduce_21

action_77 (39) = happyShift action_30
action_77 (53) = happyShift action_16
action_77 (60) = happyShift action_17
action_77 (64) = happyShift action_18
action_77 (65) = happyShift action_19
action_77 (66) = happyShift action_20
action_77 (67) = happyShift action_21
action_77 (16) = happyGoto action_72
action_77 _ = happyReduce_23

action_78 _ = happyReduce_55

action_79 (39) = happyShift action_12
action_79 (41) = happyShift action_13
action_79 (42) = happyShift action_14
action_79 (44) = happyShift action_15
action_79 (53) = happyShift action_16
action_79 (60) = happyShift action_17
action_79 (64) = happyShift action_18
action_79 (65) = happyShift action_19
action_79 (66) = happyShift action_20
action_79 (67) = happyShift action_21
action_79 (4) = happyGoto action_2
action_79 (5) = happyGoto action_100
action_79 (7) = happyGoto action_4
action_79 (8) = happyGoto action_5
action_79 (16) = happyGoto action_6
action_79 (19) = happyGoto action_7
action_79 (29) = happyGoto action_8
action_79 (30) = happyGoto action_9
action_79 (31) = happyGoto action_10
action_79 (36) = happyGoto action_11
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_43

action_81 (39) = happyShift action_61
action_81 (17) = happyGoto action_59
action_81 (18) = happyGoto action_65
action_81 _ = happyReduce_35

action_82 _ = happyReduce_41

action_83 _ = happyReduce_46

action_84 _ = happyReduce_52

action_85 _ = happyReduce_57

action_86 (39) = happyShift action_99
action_86 (33) = happyGoto action_97
action_86 (35) = happyGoto action_98
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (61) = happyShift action_96
action_87 _ = happyFail (happyExpListPerState 87)

action_88 _ = happyReduce_36

action_89 _ = happyReduce_56

action_90 _ = happyReduce_12

action_91 (39) = happyShift action_30
action_91 (53) = happyShift action_16
action_91 (60) = happyShift action_17
action_91 (64) = happyShift action_18
action_91 (65) = happyShift action_19
action_91 (66) = happyShift action_20
action_91 (67) = happyShift action_21
action_91 (11) = happyGoto action_95
action_91 (12) = happyGoto action_25
action_91 (13) = happyGoto action_26
action_91 (14) = happyGoto action_27
action_91 (15) = happyGoto action_28
action_91 (16) = happyGoto action_29
action_91 _ = happyFail (happyExpListPerState 91)

action_92 _ = happyReduce_15

action_93 (39) = happyShift action_30
action_93 (53) = happyShift action_16
action_93 (60) = happyShift action_17
action_93 (63) = happyShift action_53
action_93 (64) = happyShift action_18
action_93 (65) = happyShift action_19
action_93 (66) = happyShift action_20
action_93 (67) = happyShift action_21
action_93 (9) = happyGoto action_94
action_93 (11) = happyGoto action_52
action_93 (12) = happyGoto action_25
action_93 (13) = happyGoto action_26
action_93 (14) = happyGoto action_27
action_93 (15) = happyGoto action_28
action_93 (16) = happyGoto action_29
action_93 _ = happyFail (happyExpListPerState 93)

action_94 _ = happyReduce_14

action_95 (63) = happyShift action_108
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (39) = happyShift action_106
action_96 (48) = happyShift action_107
action_96 (38) = happyGoto action_105
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (46) = happyShift action_103
action_97 (63) = happyShift action_104
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_62

action_99 (39) = happyShift action_63
action_99 (53) = happyShift action_41
action_99 (26) = happyGoto action_37
action_99 (27) = happyGoto action_102
action_99 (28) = happyGoto action_39
action_99 _ = happyReduce_67

action_100 (62) = happyShift action_101
action_100 _ = happyReduce_1

action_101 _ = happyReduce_4

action_102 _ = happyReduce_66

action_103 (39) = happyShift action_99
action_103 (35) = happyGoto action_116
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_58

action_105 (39) = happyShift action_106
action_105 (62) = happyShift action_115
action_105 (37) = happyGoto action_113
action_105 (38) = happyGoto action_114
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (47) = happyShift action_47
action_106 (20) = happyGoto action_112
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (39) = happyShift action_99
action_107 (33) = happyGoto action_110
action_107 (35) = happyGoto action_111
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (62) = happyShift action_109
action_108 _ = happyFail (happyExpListPerState 108)

action_109 _ = happyReduce_16

action_110 (46) = happyShift action_103
action_110 (63) = happyShift action_120
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (63) = happyShift action_119
action_111 _ = happyReduce_62

action_112 (63) = happyShift action_118
action_112 _ = happyFail (happyExpListPerState 112)

action_113 _ = happyReduce_68

action_114 (39) = happyShift action_106
action_114 (62) = happyShift action_115
action_114 (37) = happyGoto action_117
action_114 (38) = happyGoto action_114
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_69

action_116 _ = happyReduce_61

action_117 _ = happyReduce_70

action_118 _ = happyReduce_71

action_119 (46) = happyShift action_123
action_119 (34) = happyGoto action_122
action_119 _ = happyReduce_63

action_120 (62) = happyShift action_121
action_120 _ = happyFail (happyExpListPerState 120)

action_121 _ = happyReduce_60

action_122 (46) = happyShift action_125
action_122 (62) = happyShift action_126
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (39) = happyShift action_99
action_123 (35) = happyGoto action_124
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (63) = happyShift action_128
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (39) = happyShift action_99
action_125 (35) = happyGoto action_127
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_59

action_127 (63) = happyShift action_129
action_127 _ = happyFail (happyExpListPerState 127)

action_128 _ = happyReduce_64

action_129 _ = happyReduce_65

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (reverse happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  5 happyReduction_2
happyReduction_2 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_2 : happy_var_1
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  6 happyReduction_4
happyReduction_4 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (reverse happy_var_2
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_0  6 happyReduction_5
happyReduction_5  =  HappyAbsSyn6
		 ([]
	)

happyReduce_6 = happySpecReduce_1  7 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  7 happyReduction_7
happyReduction_7 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  7 happyReduction_9
happyReduction_9 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  7 happyReduction_10
happyReduction_10 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  7 happyReduction_11
happyReduction_11 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happyReduce 4 8 happyReduction_12
happyReduction_12 ((HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	(HappyTerminal (Tident happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (Def happy_var_1 (foldr Lambda happy_var_4 $ reverse happy_var_2)
	) `HappyStk` happyRest

happyReduce_13 = happySpecReduce_3  8 happyReduction_13
happyReduction_13 (HappyAbsSyn9  happy_var_3)
	_
	(HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn8
		 (Def happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happyReduce 5 8 happyReduction_14
happyReduction_14 ((HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	(HappyTerminal (Toperator happy_var_2)) `HappyStk`
	(HappyAbsSyn16  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (Def happy_var_2 $ Lambda happy_var_1 (Lambda happy_var_3 happy_var_5)
	) `HappyStk` happyRest

happyReduce_15 = happySpecReduce_2  9 happyReduction_15
happyReduction_15 _
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happyReduce 5 9 happyReduction_16
happyReduction_16 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (happy_var_3
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_1  10 happyReduction_17
happyReduction_17 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  10 happyReduction_18
happyReduction_18 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_2 : happy_var_1
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  11 happyReduction_19
happyReduction_19 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  12 happyReduction_20
happyReduction_20 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  13 happyReduction_21
happyReduction_21 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (Lambda happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  13 happyReduction_22
happyReduction_22 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  14 happyReduction_23
happyReduction_23 (HappyAbsSyn15  happy_var_3)
	(HappyTerminal (Toperator happy_var_2))
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (App (App (Ident happy_var_2) happy_var_1) happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  14 happyReduction_24
happyReduction_24 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  15 happyReduction_25
happyReduction_25 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_2  15 happyReduction_26
happyReduction_26 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (App happy_var_1 happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  16 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  16 happyReduction_28
happyReduction_28 _
	(HappyTerminal (Toperator happy_var_2))
	_
	 =  HappyAbsSyn16
		 (Ident happy_var_2
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  16 happyReduction_29
happyReduction_29 (HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn16
		 (Ident happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  16 happyReduction_30
happyReduction_30 (HappyTerminal (TintLiteral happy_var_1))
	 =  HappyAbsSyn16
		 (LiteralInt happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  16 happyReduction_31
happyReduction_31 (HappyTerminal (TcharLiteral happy_var_1))
	 =  HappyAbsSyn16
		 (LiteralChar happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  16 happyReduction_32
happyReduction_32 (HappyTerminal (TstringLiteral happy_var_1))
	 =  HappyAbsSyn16
		 (LiteralString happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  16 happyReduction_33
happyReduction_33 (HappyTerminal (TfloatLiteral happy_var_1))
	 =  HappyAbsSyn16
		 (LiteralFloat happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  16 happyReduction_34
happyReduction_34 _
	 =  HappyAbsSyn16
		 (UnderScore
	)

happyReduce_35 = happySpecReduce_0  17 happyReduction_35
happyReduction_35  =  HappyAbsSyn17
		 ([]
	)

happyReduce_36 = happySpecReduce_2  17 happyReduction_36
happyReduction_36 (HappyTerminal (Tident happy_var_2))
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_2 : happy_var_1
	)
happyReduction_36 _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  17 happyReduction_37
happyReduction_37 (HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  18 happyReduction_38
happyReduction_38 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn18
		 (reverse happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  19 happyReduction_39
happyReduction_39 _
	(HappyAbsSyn20  happy_var_2)
	(HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn19
		 (TypeSig happy_var_1 happy_var_2
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  20 happyReduction_40
happyReduction_40 (HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  21 happyReduction_41
happyReduction_41 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn21
		 (Constrained (reverse happy_var_1) happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  21 happyReduction_42
happyReduction_42 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn21
		 (Constrained [] happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  22 happyReduction_43
happyReduction_43 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_3 : happy_var_1
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  22 happyReduction_44
happyReduction_44 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 ([happy_var_1]
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  23 happyReduction_45
happyReduction_45 (HappyAbsSyn18  happy_var_2)
	(HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn23
		 (Constraint happy_var_1 happy_var_2
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  24 happyReduction_46
happyReduction_46 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (TyCon "->" [happy_var_1, happy_var_3]
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  24 happyReduction_47
happyReduction_47 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  25 happyReduction_48
happyReduction_48 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn25
		 (fromTypeList happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_2  26 happyReduction_49
happyReduction_49 (HappyAbsSyn28  happy_var_2)
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_2 : happy_var_1
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  26 happyReduction_50
happyReduction_50 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn26
		 ([happy_var_1]
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  27 happyReduction_51
happyReduction_51 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 (reverse happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  28 happyReduction_52
happyReduction_52 _
	(HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (happy_var_2
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  28 happyReduction_53
happyReduction_53 (HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn28
		 (Ty happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_2  28 happyReduction_54
happyReduction_54 _
	_
	 =  HappyAbsSyn28
		 (Ty "Unit"
	)

happyReduce_55 = happyReduce 4 29 happyReduction_55
happyReduction_55 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (mkInstance happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_56 = happyReduce 4 30 happyReduction_56
happyReduction_56 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (mkClass happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_57 = happyReduce 4 31 happyReduction_57
happyReduction_57 ((HappyAbsSyn32  happy_var_4) `HappyStk`
	(HappyAbsSyn18  happy_var_3) `HappyStk`
	(HappyTerminal (Tident happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn31
		 (ADT happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_58 = happySpecReduce_3  32 happyReduction_58
happyReduction_58 _
	(HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn32
		 (reverse happy_var_2
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happyReduce 7 32 happyReduction_59
happyReduction_59 (_ `HappyStk`
	(HappyAbsSyn34  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn32
		 (happy_var_4 : reverse happy_var_6
	) `HappyStk` happyRest

happyReduce_60 = happyReduce 6 32 happyReduction_60
happyReduction_60 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn33  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn32
		 (reverse happy_var_4
	) `HappyStk` happyRest

happyReduce_61 = happySpecReduce_3  33 happyReduction_61
happyReduction_61 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_3 : happy_var_1
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  33 happyReduction_62
happyReduction_62 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn33
		 ([happy_var_1]
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_0  34 happyReduction_63
happyReduction_63  =  HappyAbsSyn34
		 ([]
	)

happyReduce_64 = happySpecReduce_3  34 happyReduction_64
happyReduction_64 _
	(HappyAbsSyn35  happy_var_2)
	_
	 =  HappyAbsSyn34
		 ([happy_var_2]
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happyReduce 4 34 happyReduction_65
happyReduction_65 (_ `HappyStk`
	(HappyAbsSyn35  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn34  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn34
		 (happy_var_3 : happy_var_1
	) `HappyStk` happyRest

happyReduce_66 = happySpecReduce_2  35 happyReduction_66
happyReduction_66 (HappyAbsSyn27  happy_var_2)
	(HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn35
		 ((happy_var_1, happy_var_2)
	)
happyReduction_66 _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  35 happyReduction_67
happyReduction_67 (HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn35
		 ((happy_var_1, [])
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happyReduce 7 36 happyReduction_68
happyReduction_68 ((HappyAbsSyn37  happy_var_7) `HappyStk`
	(HappyAbsSyn38  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_3) `HappyStk`
	(HappyTerminal (Tident happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn36
		 (GADT happy_var_2 happy_var_3 (happy_var_6 : reverse happy_var_7)
	) `HappyStk` happyRest

happyReduce_69 = happySpecReduce_1  37 happyReduction_69
happyReduction_69 _
	 =  HappyAbsSyn37
		 ([]
	)

happyReduce_70 = happySpecReduce_2  37 happyReduction_70
happyReduction_70 (HappyAbsSyn37  happy_var_2)
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn37
		 (happy_var_1 : happy_var_2
	)
happyReduction_70 _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  38 happyReduction_71
happyReduction_71 _
	(HappyAbsSyn20  happy_var_2)
	(HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn38
		 ((happy_var_1, happy_var_2)
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 68 68 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Tident happy_dollar_dollar -> cont 39;
	Toperator happy_dollar_dollar -> cont 40;
	Tkeyword "class" -> cont 41;
	Tkeyword "data" -> cont 42;
	Tkeyword "type" -> cont 43;
	Tkeyword "instance" -> cont 44;
	Tkeyword "view" -> cont 45;
	Tpipe -> cont 46;
	Tcolon -> cont 47;
	Tequals -> cont 48;
	Trarrow -> cont 49;
	Tlarrow -> cont 50;
	Tfatrarrow -> cont 51;
	Trparen -> cont 52;
	Tlparen -> cont 53;
	Trcurly -> cont 54;
	Tlcurly -> cont 55;
	Trbracket -> cont 56;
	Tlbracket -> cont 57;
	Tcomma -> cont 58;
	Tsemicolon -> cont 59;
	Tunderscore -> cont 60;
	Tindent -> cont 61;
	Tdedent -> cont 62;
	Tnewline -> cont 63;
	TintLiteral happy_dollar_dollar -> cont 64;
	TcharLiteral happy_dollar_dollar -> cont 65;
	TstringLiteral happy_dollar_dollar -> cont 66;
	TfloatLiteral happy_dollar_dollar -> cont 67;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 68 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(TokenClass)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [TokenClass] -> a
parseError toks = error $ "Parse Error:" ++ show toks

data Expr
    = Lambda Expr Expr
    | App Expr Expr
    | Ident String
    | LiteralInt Int
    | LiteralFloat Float
    | LiteralString String
    | LiteralChar Char
    | UnderScore
    deriving Show

data Constraint = Constraint String [String] deriving (Show, Eq)

data Type
    = Ty String
    | TyCon String [Type]
    deriving (Show, Eq)

data ConstrainedType = Constrained [Constraint] Type deriving (Show, Eq)

-- declarations/definitions for type signatures, functions, datatypes, type functions, classes, instances, views
data Decl
    = Def String Expr
    | TypeSig String ConstrainedType
    | ADT String [String] [(String, [Type])] -- kind name, parameters, mappings of constructor names to their types
    | GADT String [String] [(String, ConstrainedType)]
    | TypeFun String [String] Type  -- function name, parameters, body
    | Class [Constraint] String [String] [Decl]  -- type constraints, class name, parameters, method declarations / default implementations
    | Instance [Constraint] String String [Type] [Decl]  -- type constraints, implementation name, class name, arguments, method implementations
    | View [Constraint] [Type] Type [(String, [Type])] Expr -- type constraints, parameters, type, pattern names mapped to their fruit, conversion function
    deriving Show


-- given a type signature Either a b, it is parsed as [Ty "Either", Ty "a", Ty "b"]
-- this function converts it to TyCon "Either" [Ty "a", Ty "b"]
fromTypeList :: [Type] -> Type
fromTypeList [ty] = ty
fromTypeList (Ty a : tys) = TyCon a tys
fromTypeList (TyCon name tys : others) = TyCon name (tys ++ others)

isSimple :: Type -> Bool
isSimple (Ty _) = True
isSimple _ = False

kindName :: Type -> String
kindName (Ty a) = a
kindName (TyCon a _) = a

-- i'm reusing the constrainedtype rule to parse class and instance declarations
-- so I use these weird functions to create them from ConstrainedType parses

mkInstance :: ConstrainedType -> [Decl] -> Decl
mkInstance (Constrained consts ty) decls =
    case ty of
        Ty a -> Instance consts "" a [] decls
        TyCon a tys -> Instance consts "" a tys decls

mkClass :: ConstrainedType -> [Decl] -> Decl
mkClass (Constrained consts ty) decls =
    case ty of
        Ty a -> Class consts a [] decls
        TyCon a tys | all isSimple tys -> Class consts a (map kindName tys) decls
        ty -> error $ "Your class declaration for " ++ kindName ty ++ " is funky."
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
