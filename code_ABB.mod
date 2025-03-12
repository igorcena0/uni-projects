MODULE Module1
        CONST robtarget SP1:=[[750,-700,272],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_10:=[[750,-700,173.5],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget SP2:=[[700,800,272],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_20:=[[700,800,173.5],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget home:=[[979.496732003,0,1054],[0.5,0,0.866025404,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: Igor Cena
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    PROC main()
        MoveJ home,v400,z100,VaccumGripper_TCP\WObj:=wobj0;
        SetDO doActVG,0;
        SetDO doMotorON,0;
        SetDO DOpositionitem,0;
        SetDO DOremoveitem,0;
        SetDO DOsetitem,0;
        SetDO DOsetitem,1;
        SetDO DOsetitem,0;
        SetDO doMotorON,1;
        WaitDI diItemArrived,1;
        SetDO doMotorON, 0;
        Path_10;
        MoveJ home,v400,z100,VaccumGripper_TCP\WObj:=wobj0;
        SetDO DOremoveitem,1;
    ENDPROC
    PROC Path_10()
        MoveJ SP1,v400,z100,VaccumGripper_TCP\WObj:=wobj0;
        MoveJ Target_10,v400,fine,VaccumGripper_TCP\WObj:=wobj0;
        Grasp;
        MoveJ SP1,v400,z100,VaccumGripper_TCP\WObj:=wobj0;
        MoveJ SP2,v400,z100,VaccumGripper_TCP\WObj:=wobj0;
        MoveJ Target_20,v400,fine,VaccumGripper_TCP\WObj:=wobj0;
        Release;
        MoveJ SP2,v400,z100,VaccumGripper_TCP\WObj:=wobj0;
    ENDPROC
PROC Grasp()
 WaitTime 1;
 SetDO doActVG,1;
 WaitTime 1;
 WaitDI diVGAttached,1;
 ENDPROC
 PROC Release()
 WaitTime 1;
 SetDO doActVG,0;
 WaitTime 1;
 WaitDI diVGAttached,0;
 ENDPROC
ENDMODULE