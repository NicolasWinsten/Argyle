{-# OPTIONS_GHC -w #-}
-- TODO go to the lexer and add tokens for rightBindingOperators that end with a :
-- i'd rather just have this simpler rule than doing infixity declarations everywhere

module Parser(parse) where

import Token
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.0

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34 t35 t36 t37 t38 t39 t40 t41 t42
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
	| HappyAbsSyn39 t39
	| HappyAbsSyn40 t40
	| HappyAbsSyn41 t41
	| HappyAbsSyn42 t42

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,393) ([0,0,25600,513,241,0,0,712,57860,1,0,36864,2053,964,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24592,50184,3,0,8192,4096,0,0,0,64,0,0,0,32768,16384,0,0,0,768,16512,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,8256,30,0,0,8192,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,0,0,0,0,64,4128,15,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,3072,512,241,0,0,0,4096,0,0,0,512,1,0,0,0,0,0,0,0,512,0,0,0,768,0,0,0,0,0,0,0,0,512,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,6144,0,0,0,64,0,0,0,0,512,256,0,0,0,0,0,0,0,0,1024,0,0,0,16,0,0,0,0,0,0,0,0,0,32,0,0,32,16,0,0,16384,8192,3984,0,0,128,8256,30,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,16,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,32768,16384,7968,0,0,0,32768,0,0,0,0,0,0,0,1024,0,8,0,0,0,1024,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,32769,0,0,0,512,256,0,0,0,4,2,0,0,2048,1024,0,0,0,16,0,0,0,0,0,16,0,0,0,16,0,0,0,256,0,0,0,0,0,0,0,0,2,30849,0,0,1024,512,241,0,0,0,0,0,0,4096,2048,964,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,33024,120,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,8192,4107,1928,0,0,0,0,0,0,0,4096,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,8448,0,0,0,0,0,0,0,0,256,512,0,0,0,0,0,0,0,4,2,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,64,4128,15,0,0,0,0,0,0,256,16512,62,0,0,0,0,0,0,0,0,8,0,0,8,0,0,0,0,0,0,0,0,32,0,0,0,0,64,32,0,0,0,0,0,0,0,32769,256,0,0,0,0,0,0,0,2048,0,0,0,2048,0,16,0,0,32,0,0,0,8192,0,0,0,0,64,32,0,0,32768,16428,7840,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,1,512,0,0,0,2,0,0,0,0,0,0,0,0,8,16,0,0,0,4096,0,0,0,0,0,0,0,16384,24576,0,0,32768,0,256,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,2048,0,0,4096,0,32,0,0,8192,0,0,0,0,0,0,0,0,128,0,1,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,4096,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","prog","body","indentedBody","decl","def","rhs","exprlistAux","exprlist","expr","lambda","singlelambda","rightoper","oper","app","single","varlistAux","varlist","typesig","typeannotation","constraintlist","constraint","constrainedtype","type","ftype","typeopr","typeop","typeapp","typelistAux","typelist","singletype","instance","class","data","datarhs","constructorsS","constructorsB","variant","gadtconstructors","gadtconstructor","VAR","OP","OPR","CLASS","DATA","TYPE","INSTANCE","VIEW","'|'","':'","'='","'->'","'<-'","'=>'","')'","'('","'}'","'{'","']'","'['","','","';'","'_'","INDENT","DEDENT","NEWLINE","INT","CHAR","STRING","FLOAT","%eof"]
        bit_start = st Prelude.* 73
        bit_end = (st Prelude.+ 1) Prelude.* 73
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..72]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (43) = happyShift action_10
action_0 (46) = happyShift action_11
action_0 (47) = happyShift action_12
action_0 (49) = happyShift action_13
action_0 (58) = happyShift action_14
action_0 (65) = happyShift action_15
action_0 (69) = happyShift action_16
action_0 (70) = happyShift action_17
action_0 (71) = happyShift action_18
action_0 (72) = happyShift action_19
action_0 (4) = happyGoto action_20
action_0 (5) = happyGoto action_2
action_0 (7) = happyGoto action_3
action_0 (8) = happyGoto action_4
action_0 (18) = happyGoto action_5
action_0 (21) = happyGoto action_6
action_0 (34) = happyGoto action_7
action_0 (35) = happyGoto action_8
action_0 (36) = happyGoto action_9
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (43) = happyShift action_10
action_1 (46) = happyShift action_11
action_1 (47) = happyShift action_12
action_1 (49) = happyShift action_13
action_1 (58) = happyShift action_14
action_1 (65) = happyShift action_15
action_1 (69) = happyShift action_16
action_1 (70) = happyShift action_17
action_1 (71) = happyShift action_18
action_1 (72) = happyShift action_19
action_1 (5) = happyGoto action_2
action_1 (7) = happyGoto action_3
action_1 (8) = happyGoto action_4
action_1 (18) = happyGoto action_5
action_1 (21) = happyGoto action_6
action_1 (34) = happyGoto action_7
action_1 (35) = happyGoto action_8
action_1 (36) = happyGoto action_9
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (43) = happyShift action_10
action_2 (46) = happyShift action_11
action_2 (47) = happyShift action_12
action_2 (49) = happyShift action_13
action_2 (58) = happyShift action_14
action_2 (65) = happyShift action_15
action_2 (69) = happyShift action_16
action_2 (70) = happyShift action_17
action_2 (71) = happyShift action_18
action_2 (72) = happyShift action_19
action_2 (7) = happyGoto action_54
action_2 (8) = happyGoto action_4
action_2 (18) = happyGoto action_5
action_2 (21) = happyGoto action_6
action_2 (34) = happyGoto action_7
action_2 (35) = happyGoto action_8
action_2 (36) = happyGoto action_9
action_2 _ = happyReduce_1

action_3 _ = happyReduce_3

action_4 _ = happyReduce_6

action_5 (44) = happyShift action_53
action_5 _ = happyFail (happyExpListPerState 5)

action_6 _ = happyReduce_7

action_7 _ = happyReduce_8

action_8 _ = happyReduce_9

action_9 _ = happyReduce_10

action_10 (43) = happyShift action_30
action_10 (52) = happyShift action_51
action_10 (53) = happyShift action_52
action_10 (58) = happyShift action_32
action_10 (65) = happyShift action_15
action_10 (69) = happyShift action_16
action_10 (70) = happyShift action_17
action_10 (71) = happyShift action_18
action_10 (72) = happyShift action_19
action_10 (10) = happyGoto action_21
action_10 (11) = happyGoto action_48
action_10 (18) = happyGoto action_49
action_10 (22) = happyGoto action_50
action_10 _ = happyReduce_31

action_11 (43) = happyShift action_42
action_11 (58) = happyShift action_43
action_11 (25) = happyGoto action_47
action_11 (26) = happyGoto action_34
action_11 (27) = happyGoto action_35
action_11 (28) = happyGoto action_36
action_11 (29) = happyGoto action_37
action_11 (30) = happyGoto action_38
action_11 (31) = happyGoto action_39
action_11 (32) = happyGoto action_40
action_11 (33) = happyGoto action_41
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (43) = happyShift action_46
action_12 (19) = happyGoto action_44
action_12 (20) = happyGoto action_45
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (43) = happyShift action_42
action_13 (58) = happyShift action_43
action_13 (25) = happyGoto action_33
action_13 (26) = happyGoto action_34
action_13 (27) = happyGoto action_35
action_13 (28) = happyGoto action_36
action_13 (29) = happyGoto action_37
action_13 (30) = happyGoto action_38
action_13 (31) = happyGoto action_39
action_13 (32) = happyGoto action_40
action_13 (33) = happyGoto action_41
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (43) = happyShift action_30
action_14 (44) = happyShift action_31
action_14 (58) = happyShift action_32
action_14 (65) = happyShift action_15
action_14 (69) = happyShift action_16
action_14 (70) = happyShift action_17
action_14 (71) = happyShift action_18
action_14 (72) = happyShift action_19
action_14 (10) = happyGoto action_21
action_14 (11) = happyGoto action_22
action_14 (12) = happyGoto action_23
action_14 (13) = happyGoto action_24
action_14 (14) = happyGoto action_25
action_14 (15) = happyGoto action_26
action_14 (16) = happyGoto action_27
action_14 (17) = happyGoto action_28
action_14 (18) = happyGoto action_29
action_14 _ = happyFail (happyExpListPerState 14)

action_15 _ = happyReduce_36

action_16 _ = happyReduce_32

action_17 _ = happyReduce_33

action_18 _ = happyReduce_34

action_19 _ = happyReduce_35

action_20 (73) = happyAccept
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (43) = happyShift action_30
action_21 (58) = happyShift action_32
action_21 (65) = happyShift action_15
action_21 (69) = happyShift action_16
action_21 (70) = happyShift action_17
action_21 (71) = happyShift action_18
action_21 (72) = happyShift action_19
action_21 (18) = happyGoto action_83
action_21 _ = happyReduce_18

action_22 (56) = happyShift action_82
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (57) = happyShift action_81
action_23 _ = happyFail (happyExpListPerState 23)

action_24 _ = happyReduce_19

action_25 _ = happyReduce_20

action_26 _ = happyReduce_22

action_27 (44) = happyShift action_79
action_27 (45) = happyShift action_80
action_27 _ = happyReduce_24

action_28 (43) = happyShift action_30
action_28 (58) = happyShift action_32
action_28 (65) = happyShift action_15
action_28 (69) = happyShift action_16
action_28 (70) = happyShift action_17
action_28 (71) = happyShift action_18
action_28 (72) = happyShift action_19
action_28 (18) = happyGoto action_78
action_28 _ = happyReduce_26

action_29 (43) = happyReduce_27
action_29 (56) = happyReduce_16
action_29 (58) = happyReduce_27
action_29 (65) = happyReduce_27
action_29 (69) = happyReduce_27
action_29 (70) = happyReduce_27
action_29 (71) = happyReduce_27
action_29 (72) = happyReduce_27
action_29 _ = happyReduce_27

action_30 _ = happyReduce_31

action_31 (57) = happyShift action_77
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (43) = happyShift action_30
action_32 (44) = happyShift action_76
action_32 (58) = happyShift action_32
action_32 (65) = happyShift action_15
action_32 (69) = happyShift action_16
action_32 (70) = happyShift action_17
action_32 (71) = happyShift action_18
action_32 (72) = happyShift action_19
action_32 (10) = happyGoto action_21
action_32 (11) = happyGoto action_22
action_32 (12) = happyGoto action_23
action_32 (13) = happyGoto action_24
action_32 (14) = happyGoto action_25
action_32 (15) = happyGoto action_26
action_32 (16) = happyGoto action_27
action_32 (17) = happyGoto action_28
action_32 (18) = happyGoto action_29
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (68) = happyShift action_75
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (56) = happyShift action_73
action_34 (63) = happyShift action_74
action_34 _ = happyReduce_46

action_35 _ = happyReduce_49

action_36 (54) = happyShift action_72
action_36 _ = happyReduce_51

action_37 (44) = happyShift action_70
action_37 (45) = happyShift action_71
action_37 _ = happyReduce_53

action_38 _ = happyReduce_55

action_39 (43) = happyShift action_42
action_39 (58) = happyShift action_43
action_39 (33) = happyGoto action_69
action_39 _ = happyReduce_59

action_40 _ = happyReduce_56

action_41 _ = happyReduce_58

action_42 _ = happyReduce_61

action_43 (43) = happyShift action_42
action_43 (57) = happyShift action_68
action_43 (58) = happyShift action_43
action_43 (26) = happyGoto action_67
action_43 (27) = happyGoto action_35
action_43 (28) = happyGoto action_36
action_43 (29) = happyGoto action_37
action_43 (30) = happyGoto action_38
action_43 (31) = happyGoto action_39
action_43 (32) = happyGoto action_40
action_43 (33) = happyGoto action_41
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (43) = happyShift action_66
action_44 _ = happyReduce_39

action_45 (53) = happyShift action_64
action_45 (68) = happyShift action_65
action_45 (37) = happyGoto action_63
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_38

action_47 (68) = happyShift action_62
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (53) = happyShift action_61
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_16

action_50 (68) = happyShift action_60
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (43) = happyShift action_42
action_51 (58) = happyShift action_43
action_51 (25) = happyGoto action_59
action_51 (26) = happyGoto action_34
action_51 (27) = happyGoto action_35
action_51 (28) = happyGoto action_36
action_51 (29) = happyGoto action_37
action_51 (30) = happyGoto action_38
action_51 (31) = happyGoto action_39
action_51 (32) = happyGoto action_40
action_51 (33) = happyGoto action_41
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (43) = happyShift action_30
action_52 (58) = happyShift action_32
action_52 (65) = happyShift action_15
action_52 (68) = happyShift action_58
action_52 (69) = happyShift action_16
action_52 (70) = happyShift action_17
action_52 (71) = happyShift action_18
action_52 (72) = happyShift action_19
action_52 (9) = happyGoto action_56
action_52 (10) = happyGoto action_21
action_52 (11) = happyGoto action_22
action_52 (12) = happyGoto action_57
action_52 (13) = happyGoto action_24
action_52 (14) = happyGoto action_25
action_52 (15) = happyGoto action_26
action_52 (16) = happyGoto action_27
action_52 (17) = happyGoto action_28
action_52 (18) = happyGoto action_29
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (43) = happyShift action_30
action_53 (58) = happyShift action_32
action_53 (65) = happyShift action_15
action_53 (69) = happyShift action_16
action_53 (70) = happyShift action_17
action_53 (71) = happyShift action_18
action_53 (72) = happyShift action_19
action_53 (18) = happyGoto action_55
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_2

action_55 (53) = happyShift action_110
action_55 _ = happyFail (happyExpListPerState 55)

action_56 _ = happyReduce_12

action_57 (68) = happyShift action_109
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (66) = happyShift action_108
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_42

action_60 _ = happyReduce_40

action_61 (43) = happyShift action_30
action_61 (58) = happyShift action_32
action_61 (65) = happyShift action_15
action_61 (68) = happyShift action_58
action_61 (69) = happyShift action_16
action_61 (70) = happyShift action_17
action_61 (71) = happyShift action_18
action_61 (72) = happyShift action_19
action_61 (9) = happyGoto action_107
action_61 (10) = happyGoto action_21
action_61 (11) = happyGoto action_22
action_61 (12) = happyGoto action_57
action_61 (13) = happyGoto action_24
action_61 (14) = happyGoto action_25
action_61 (15) = happyGoto action_26
action_61 (16) = happyGoto action_27
action_61 (17) = happyGoto action_28
action_61 (18) = happyGoto action_29
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (66) = happyShift action_91
action_62 (6) = happyGoto action_106
action_62 _ = happyReduce_5

action_63 _ = happyReduce_65

action_64 (43) = happyShift action_104
action_64 (68) = happyShift action_105
action_64 (38) = happyGoto action_101
action_64 (39) = happyGoto action_102
action_64 (40) = happyGoto action_103
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (66) = happyShift action_100
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_37

action_67 (57) = happyShift action_99
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_62

action_69 _ = happyReduce_57

action_70 (43) = happyShift action_42
action_70 (58) = happyShift action_43
action_70 (30) = happyGoto action_98
action_70 (31) = happyGoto action_39
action_70 (32) = happyGoto action_40
action_70 (33) = happyGoto action_41
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (43) = happyShift action_42
action_71 (58) = happyShift action_43
action_71 (28) = happyGoto action_97
action_71 (29) = happyGoto action_37
action_71 (30) = happyGoto action_38
action_71 (31) = happyGoto action_39
action_71 (32) = happyGoto action_40
action_71 (33) = happyGoto action_41
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (43) = happyShift action_42
action_72 (58) = happyShift action_43
action_72 (27) = happyGoto action_96
action_72 (28) = happyGoto action_36
action_72 (29) = happyGoto action_37
action_72 (30) = happyGoto action_38
action_72 (31) = happyGoto action_39
action_72 (32) = happyGoto action_40
action_72 (33) = happyGoto action_41
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (43) = happyShift action_42
action_73 (58) = happyShift action_43
action_73 (26) = happyGoto action_95
action_73 (27) = happyGoto action_35
action_73 (28) = happyGoto action_36
action_73 (29) = happyGoto action_37
action_73 (30) = happyGoto action_38
action_73 (31) = happyGoto action_39
action_73 (32) = happyGoto action_40
action_73 (33) = happyGoto action_41
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (43) = happyShift action_46
action_74 (19) = happyGoto action_44
action_74 (20) = happyGoto action_92
action_74 (23) = happyGoto action_93
action_74 (24) = happyGoto action_94
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (66) = happyShift action_91
action_75 (6) = happyGoto action_90
action_75 _ = happyReduce_5

action_76 (57) = happyShift action_89
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (52) = happyShift action_51
action_77 (22) = happyGoto action_88
action_77 _ = happyReduce_30

action_78 _ = happyReduce_28

action_79 (43) = happyShift action_30
action_79 (58) = happyShift action_32
action_79 (65) = happyShift action_15
action_79 (69) = happyShift action_16
action_79 (70) = happyShift action_17
action_79 (71) = happyShift action_18
action_79 (72) = happyShift action_19
action_79 (17) = happyGoto action_87
action_79 (18) = happyGoto action_86
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (43) = happyShift action_30
action_80 (58) = happyShift action_32
action_80 (65) = happyShift action_15
action_80 (69) = happyShift action_16
action_80 (70) = happyShift action_17
action_80 (71) = happyShift action_18
action_80 (72) = happyShift action_19
action_80 (15) = happyGoto action_85
action_80 (16) = happyGoto action_27
action_80 (17) = happyGoto action_28
action_80 (18) = happyGoto action_86
action_80 _ = happyFail (happyExpListPerState 80)

action_81 _ = happyReduce_29

action_82 (43) = happyShift action_30
action_82 (58) = happyShift action_32
action_82 (65) = happyShift action_15
action_82 (69) = happyShift action_16
action_82 (70) = happyShift action_17
action_82 (71) = happyShift action_18
action_82 (72) = happyShift action_19
action_82 (10) = happyGoto action_21
action_82 (11) = happyGoto action_22
action_82 (12) = happyGoto action_84
action_82 (13) = happyGoto action_24
action_82 (14) = happyGoto action_25
action_82 (15) = happyGoto action_26
action_82 (16) = happyGoto action_27
action_82 (17) = happyGoto action_28
action_82 (18) = happyGoto action_29
action_82 _ = happyFail (happyExpListPerState 82)

action_83 _ = happyReduce_17

action_84 _ = happyReduce_21

action_85 _ = happyReduce_23

action_86 _ = happyReduce_27

action_87 (43) = happyShift action_30
action_87 (58) = happyShift action_32
action_87 (65) = happyShift action_15
action_87 (69) = happyShift action_16
action_87 (70) = happyShift action_17
action_87 (71) = happyShift action_18
action_87 (72) = happyShift action_19
action_87 (18) = happyGoto action_78
action_87 _ = happyReduce_25

action_88 (68) = happyShift action_126
action_88 _ = happyFail (happyExpListPerState 88)

action_89 _ = happyReduce_30

action_90 _ = happyReduce_63

action_91 (43) = happyShift action_10
action_91 (46) = happyShift action_11
action_91 (47) = happyShift action_12
action_91 (49) = happyShift action_13
action_91 (58) = happyShift action_14
action_91 (65) = happyShift action_15
action_91 (69) = happyShift action_16
action_91 (70) = happyShift action_17
action_91 (71) = happyShift action_18
action_91 (72) = happyShift action_19
action_91 (5) = happyGoto action_125
action_91 (7) = happyGoto action_3
action_91 (8) = happyGoto action_4
action_91 (18) = happyGoto action_5
action_91 (21) = happyGoto action_6
action_91 (34) = happyGoto action_7
action_91 (35) = happyGoto action_8
action_91 (36) = happyGoto action_9
action_91 _ = happyFail (happyExpListPerState 91)

action_92 _ = happyReduce_45

action_93 (56) = happyShift action_124
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (63) = happyShift action_123
action_94 _ = happyReduce_44

action_95 _ = happyReduce_48

action_96 _ = happyReduce_50

action_97 _ = happyReduce_52

action_98 _ = happyReduce_54

action_99 _ = happyReduce_60

action_100 (43) = happyShift action_120
action_100 (53) = happyShift action_121
action_100 (58) = happyShift action_122
action_100 (21) = happyGoto action_117
action_100 (41) = happyGoto action_118
action_100 (42) = happyGoto action_119
action_100 _ = happyFail (happyExpListPerState 100)

action_101 _ = happyReduce_66

action_102 (51) = happyShift action_115
action_102 (68) = happyShift action_116
action_102 _ = happyFail (happyExpListPerState 102)

action_103 _ = happyReduce_76

action_104 (43) = happyShift action_42
action_104 (58) = happyShift action_43
action_104 (31) = happyGoto action_39
action_104 (32) = happyGoto action_114
action_104 (33) = happyGoto action_41
action_104 _ = happyReduce_78

action_105 (66) = happyShift action_113
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_64

action_107 _ = happyReduce_11

action_108 (43) = happyShift action_30
action_108 (58) = happyShift action_32
action_108 (65) = happyShift action_15
action_108 (69) = happyShift action_16
action_108 (70) = happyShift action_17
action_108 (71) = happyShift action_18
action_108 (72) = happyShift action_19
action_108 (10) = happyGoto action_21
action_108 (11) = happyGoto action_22
action_108 (12) = happyGoto action_112
action_108 (13) = happyGoto action_24
action_108 (14) = happyGoto action_25
action_108 (15) = happyGoto action_26
action_108 (16) = happyGoto action_27
action_108 (17) = happyGoto action_28
action_108 (18) = happyGoto action_29
action_108 _ = happyFail (happyExpListPerState 108)

action_109 _ = happyReduce_14

action_110 (43) = happyShift action_30
action_110 (58) = happyShift action_32
action_110 (65) = happyShift action_15
action_110 (68) = happyShift action_58
action_110 (69) = happyShift action_16
action_110 (70) = happyShift action_17
action_110 (71) = happyShift action_18
action_110 (72) = happyShift action_19
action_110 (9) = happyGoto action_111
action_110 (10) = happyGoto action_21
action_110 (11) = happyGoto action_22
action_110 (12) = happyGoto action_57
action_110 (13) = happyGoto action_24
action_110 (14) = happyGoto action_25
action_110 (15) = happyGoto action_26
action_110 (16) = happyGoto action_27
action_110 (17) = happyGoto action_28
action_110 (18) = happyGoto action_29
action_110 _ = happyFail (happyExpListPerState 110)

action_111 _ = happyReduce_13

action_112 (68) = happyShift action_138
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (43) = happyShift action_104
action_113 (39) = happyGoto action_137
action_113 (40) = happyGoto action_103
action_113 _ = happyFail (happyExpListPerState 113)

action_114 _ = happyReduce_77

action_115 (43) = happyShift action_104
action_115 (40) = happyGoto action_136
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (51) = happyShift action_134
action_116 (66) = happyShift action_135
action_116 _ = happyReduce_74

action_117 _ = happyReduce_81

action_118 (43) = happyShift action_120
action_118 (58) = happyShift action_122
action_118 (67) = happyShift action_133
action_118 (21) = happyGoto action_117
action_118 (42) = happyGoto action_132
action_118 _ = happyFail (happyExpListPerState 118)

action_119 _ = happyReduce_79

action_120 (52) = happyShift action_51
action_120 (22) = happyGoto action_50
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (43) = happyShift action_104
action_121 (68) = happyShift action_105
action_121 (38) = happyGoto action_131
action_121 (39) = happyGoto action_102
action_121 (40) = happyGoto action_103
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (44) = happyShift action_130
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (43) = happyShift action_46
action_123 (19) = happyGoto action_44
action_123 (20) = happyGoto action_92
action_123 (23) = happyGoto action_129
action_123 (24) = happyGoto action_94
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (43) = happyShift action_42
action_124 (58) = happyShift action_43
action_124 (26) = happyGoto action_128
action_124 (27) = happyGoto action_35
action_124 (28) = happyGoto action_36
action_124 (29) = happyGoto action_37
action_124 (30) = happyGoto action_38
action_124 (31) = happyGoto action_39
action_124 (32) = happyGoto action_40
action_124 (33) = happyGoto action_41
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (43) = happyShift action_10
action_125 (46) = happyShift action_11
action_125 (47) = happyShift action_12
action_125 (49) = happyShift action_13
action_125 (58) = happyShift action_14
action_125 (65) = happyShift action_15
action_125 (67) = happyShift action_127
action_125 (69) = happyShift action_16
action_125 (70) = happyShift action_17
action_125 (71) = happyShift action_18
action_125 (72) = happyShift action_19
action_125 (7) = happyGoto action_54
action_125 (8) = happyGoto action_4
action_125 (18) = happyGoto action_5
action_125 (21) = happyGoto action_6
action_125 (34) = happyGoto action_7
action_125 (35) = happyGoto action_8
action_125 (36) = happyGoto action_9
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_41

action_127 _ = happyReduce_4

action_128 _ = happyReduce_47

action_129 _ = happyReduce_43

action_130 (57) = happyShift action_144
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (67) = happyShift action_143
action_131 _ = happyFail (happyExpListPerState 131)

action_132 _ = happyReduce_80

action_133 _ = happyReduce_68

action_134 (43) = happyShift action_104
action_134 (68) = happyShift action_105
action_134 (38) = happyGoto action_142
action_134 (39) = happyGoto action_102
action_134 (40) = happyGoto action_103
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (51) = happyShift action_141
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_75

action_137 (51) = happyShift action_115
action_137 (68) = happyShift action_140
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (67) = happyShift action_139
action_138 _ = happyFail (happyExpListPerState 138)

action_139 _ = happyReduce_15

action_140 (51) = happyShift action_146
action_140 (66) = happyShift action_147
action_140 (67) = happyShift action_148
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (43) = happyShift action_104
action_141 (68) = happyShift action_105
action_141 (38) = happyGoto action_145
action_141 (39) = happyGoto action_102
action_141 (40) = happyGoto action_103
action_141 _ = happyFail (happyExpListPerState 141)

action_142 _ = happyReduce_73

action_143 _ = happyReduce_67

action_144 (52) = happyShift action_51
action_144 (22) = happyGoto action_88
action_144 _ = happyFail (happyExpListPerState 144)

action_145 (67) = happyShift action_151
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (43) = happyShift action_104
action_146 (68) = happyShift action_105
action_146 (38) = happyGoto action_150
action_146 (39) = happyGoto action_102
action_146 (40) = happyGoto action_103
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (51) = happyShift action_149
action_147 _ = happyFail (happyExpListPerState 147)

action_148 _ = happyReduce_71

action_149 (43) = happyShift action_104
action_149 (68) = happyShift action_105
action_149 (38) = happyGoto action_153
action_149 (39) = happyGoto action_102
action_149 (40) = happyGoto action_103
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (67) = happyShift action_152
action_150 _ = happyFail (happyExpListPerState 150)

action_151 _ = happyReduce_72

action_152 _ = happyReduce_69

action_153 (67) = happyShift action_154
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (67) = happyShift action_155
action_154 _ = happyFail (happyExpListPerState 154)

action_155 _ = happyReduce_70

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (reverse happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  5 happyReduction_2
happyReduction_2 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
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
happyReduction_7 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  7 happyReduction_9
happyReduction_9 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  7 happyReduction_10
happyReduction_10 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happyReduce 4 8 happyReduction_11
happyReduction_11 ((HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	(HappyTerminal (Tident happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (Def happy_var_1 (foldr lambda happy_var_4 happy_var_2)
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_3  8 happyReduction_12
happyReduction_12 (HappyAbsSyn9  happy_var_3)
	_
	(HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn8
		 (Def happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happyReduce 5 8 happyReduction_13
happyReduction_13 ((HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_3) `HappyStk`
	(HappyTerminal (Toperator happy_var_2)) `HappyStk`
	(HappyAbsSyn18  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (Def happy_var_2 $ lambda happy_var_1 (lambda happy_var_3 happy_var_5)
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_2  9 happyReduction_14
happyReduction_14 _
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happyReduce 5 9 happyReduction_15
happyReduction_15 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (happy_var_3
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_1  10 happyReduction_16
happyReduction_16 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  10 happyReduction_17
happyReduction_17 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_2 : happy_var_1
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  11 happyReduction_18
happyReduction_18 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 (reverse happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  12 happyReduction_19
happyReduction_19 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  13 happyReduction_20
happyReduction_20 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  14 happyReduction_21
happyReduction_21 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn14
		 (lambda happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  14 happyReduction_22
happyReduction_22 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  15 happyReduction_23
happyReduction_23 (HappyAbsSyn15  happy_var_3)
	(HappyTerminal (Troperator happy_var_2))
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (App (App (Ident happy_var_2) happy_var_1) happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  15 happyReduction_24
happyReduction_24 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  16 happyReduction_25
happyReduction_25 (HappyAbsSyn17  happy_var_3)
	(HappyTerminal (Toperator happy_var_2))
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (App (App (Ident happy_var_2) happy_var_1) happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  16 happyReduction_26
happyReduction_26 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  17 happyReduction_27
happyReduction_27 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  17 happyReduction_28
happyReduction_28 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (App happy_var_1 happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  18 happyReduction_29
happyReduction_29 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (happy_var_2
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  18 happyReduction_30
happyReduction_30 _
	(HappyTerminal (Toperator happy_var_2))
	_
	 =  HappyAbsSyn18
		 (Ident happy_var_2
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  18 happyReduction_31
happyReduction_31 (HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn18
		 (Ident happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  18 happyReduction_32
happyReduction_32 (HappyTerminal (TintLiteral happy_var_1))
	 =  HappyAbsSyn18
		 (LiteralInt happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  18 happyReduction_33
happyReduction_33 (HappyTerminal (TcharLiteral happy_var_1))
	 =  HappyAbsSyn18
		 (LiteralChar happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  18 happyReduction_34
happyReduction_34 (HappyTerminal (TstringLiteral happy_var_1))
	 =  HappyAbsSyn18
		 (LiteralString happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  18 happyReduction_35
happyReduction_35 (HappyTerminal (TfloatLiteral happy_var_1))
	 =  HappyAbsSyn18
		 (LiteralFloat happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  18 happyReduction_36
happyReduction_36 _
	 =  HappyAbsSyn18
		 (UnderScore
	)

happyReduce_37 = happySpecReduce_2  19 happyReduction_37
happyReduction_37 (HappyTerminal (Tident happy_var_2))
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_2 : happy_var_1
	)
happyReduction_37 _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  19 happyReduction_38
happyReduction_38 (HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn19
		 ([happy_var_1]
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  20 happyReduction_39
happyReduction_39 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (reverse happy_var_1
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  21 happyReduction_40
happyReduction_40 _
	(HappyAbsSyn22  happy_var_2)
	(HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn21
		 (TypeSig happy_var_1 happy_var_2
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happyReduce 5 21 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Toperator happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (TypeSig happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_42 = happySpecReduce_2  22 happyReduction_42
happyReduction_42 (HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn22
		 (happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  23 happyReduction_43
happyReduction_43 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1 : happy_var_3
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  23 happyReduction_44
happyReduction_44 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 ([happy_var_1]
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  24 happyReduction_45
happyReduction_45 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (Constraint (head happy_var_1) (tail happy_var_1)
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  25 happyReduction_46
happyReduction_46 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn25
		 (Constrained [] happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happyReduce 5 25 happyReduction_47
happyReduction_47 ((HappyAbsSyn26  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (Constrained (ty2constraint happy_var_1 : happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_48 = happySpecReduce_3  25 happyReduction_48
happyReduction_48 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn25
		 (Constrained [ty2constraint happy_var_1] happy_var_3
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  26 happyReduction_49
happyReduction_49 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  27 happyReduction_50
happyReduction_50 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn27
		 (TyCon "->" [happy_var_1, happy_var_3]
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  27 happyReduction_51
happyReduction_51 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  28 happyReduction_52
happyReduction_52 (HappyAbsSyn28  happy_var_3)
	(HappyTerminal (Troperator happy_var_2))
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn28
		 (TyCon happy_var_2 [happy_var_1, happy_var_3]
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  28 happyReduction_53
happyReduction_53 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  29 happyReduction_54
happyReduction_54 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (Toperator happy_var_2))
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (TyCon happy_var_2 [happy_var_1, happy_var_3]
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  29 happyReduction_55
happyReduction_55 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  30 happyReduction_56
happyReduction_56 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn30
		 (fromTypeList happy_var_1
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_2  31 happyReduction_57
happyReduction_57 (HappyAbsSyn33  happy_var_2)
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn31
		 (happy_var_2 : happy_var_1
	)
happyReduction_57 _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_1  31 happyReduction_58
happyReduction_58 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn31
		 ([happy_var_1]
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  32 happyReduction_59
happyReduction_59 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 (reverse happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  33 happyReduction_60
happyReduction_60 _
	(HappyAbsSyn26  happy_var_2)
	_
	 =  HappyAbsSyn33
		 (happy_var_2
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  33 happyReduction_61
happyReduction_61 (HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn33
		 (Ty happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_2  33 happyReduction_62
happyReduction_62 _
	_
	 =  HappyAbsSyn33
		 (Ty "Unit"
	)

happyReduce_63 = happyReduce 4 34 happyReduction_63
happyReduction_63 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn34
		 (mkInstance happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_64 = happyReduce 4 35 happyReduction_64
happyReduction_64 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn35
		 (mkClass happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_65 = happySpecReduce_3  36 happyReduction_65
happyReduction_65 (HappyAbsSyn37  happy_var_3)
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn36
		 (happy_var_3 (head happy_var_2) (tail happy_var_2)
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_2  37 happyReduction_66
happyReduction_66 (HappyAbsSyn38  happy_var_2)
	_
	 =  HappyAbsSyn37
		 (\name tvars -> ADT name tvars (reverse happy_var_2)
	)
happyReduction_66 _ _  = notHappyAtAll 

happyReduce_67 = happyReduce 5 37 happyReduction_67
happyReduction_67 (_ `HappyStk`
	(HappyAbsSyn38  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn37
		 (\name tvars -> ADT name tvars (reverse happy_var_4)
	) `HappyStk` happyRest

happyReduce_68 = happyReduce 4 37 happyReduction_68
happyReduction_68 (_ `HappyStk`
	(HappyAbsSyn41  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn37
		 (\name tvars -> GADT name tvars (reverse happy_var_3)
	) `HappyStk` happyRest

happyReduce_69 = happyReduce 7 38 happyReduction_69
happyReduction_69 (_ `HappyStk`
	(HappyAbsSyn38  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (happy_var_3 ++ happy_var_6
	) `HappyStk` happyRest

happyReduce_70 = happyReduce 9 38 happyReduction_70
happyReduction_70 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (happy_var_3 ++ happy_var_7
	) `HappyStk` happyRest

happyReduce_71 = happyReduce 5 38 happyReduction_71
happyReduction_71 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (happy_var_3
	) `HappyStk` happyRest

happyReduce_72 = happyReduce 6 38 happyReduction_72
happyReduction_72 (_ `HappyStk`
	(HappyAbsSyn38  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (happy_var_1 ++ happy_var_5
	) `HappyStk` happyRest

happyReduce_73 = happyReduce 4 38 happyReduction_73
happyReduction_73 ((HappyAbsSyn38  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn39  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (happy_var_1 ++ happy_var_4
	) `HappyStk` happyRest

happyReduce_74 = happySpecReduce_2  38 happyReduction_74
happyReduction_74 _
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn38
		 (happy_var_1
	)
happyReduction_74 _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  39 happyReduction_75
happyReduction_75 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn39
		 (happy_var_3 : happy_var_1
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  39 happyReduction_76
happyReduction_76 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn39
		 ([happy_var_1]
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_2  40 happyReduction_77
happyReduction_77 (HappyAbsSyn32  happy_var_2)
	(HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn40
		 ((happy_var_1, happy_var_2)
	)
happyReduction_77 _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  40 happyReduction_78
happyReduction_78 (HappyTerminal (Tident happy_var_1))
	 =  HappyAbsSyn40
		 ((happy_var_1, [])
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  41 happyReduction_79
happyReduction_79 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn41
		 ([happy_var_1]
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_2  41 happyReduction_80
happyReduction_80 (HappyAbsSyn42  happy_var_2)
	(HappyAbsSyn41  happy_var_1)
	 =  HappyAbsSyn41
		 (happy_var_2 : happy_var_1
	)
happyReduction_80 _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  42 happyReduction_81
happyReduction_81 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn42
		 (let (TypeSig name ty) = happy_var_1 in (name, ty)
	)
happyReduction_81 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 73 73 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Tident happy_dollar_dollar -> cont 43;
	Toperator happy_dollar_dollar -> cont 44;
	Troperator happy_dollar_dollar -> cont 45;
	Tkeyword "class" -> cont 46;
	Tkeyword "data" -> cont 47;
	Tkeyword "type" -> cont 48;
	Tkeyword "instance" -> cont 49;
	Tkeyword "view" -> cont 50;
	Tpipe -> cont 51;
	Tcolon -> cont 52;
	Tequals -> cont 53;
	Trarrow -> cont 54;
	Tlarrow -> cont 55;
	Tfatrarrow -> cont 56;
	Trparen -> cont 57;
	Tlparen -> cont 58;
	Trcurly -> cont 59;
	Tlcurly -> cont 60;
	Trbracket -> cont 61;
	Tlbracket -> cont 62;
	Tcomma -> cont 63;
	Tsemicolon -> cont 64;
	Tunderscore -> cont 65;
	Tindent -> cont 66;
	Tdedent -> cont 67;
	Tnewline -> cont 68;
	TintLiteral happy_dollar_dollar -> cont 69;
	TcharLiteral happy_dollar_dollar -> cont 70;
	TstringLiteral happy_dollar_dollar -> cont 71;
	TfloatLiteral happy_dollar_dollar -> cont 72;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 73 tk tks = happyError' (tks, explist)
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
    = Lambda [([Expr], Expr)]
    | App Expr Expr
    | Ident String
    | LiteralInt Int
    | LiteralFloat Float
    | LiteralString String
    | LiteralChar Char
    | UnderScore
    deriving Show

lambda :: Expr -> Expr -> Expr
lambda l r = Lambda [([l], r)]

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

ty2constraint :: Type -> Constraint
ty2constraint (Ty a) = Constraint a []
ty2constraint (TyCon a tys)
    | all isSimple tys = Constraint a (map kindName tys)
    | otherwise = error $ "Your type constraints are funky"




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
