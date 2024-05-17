within DHCs.Logic.EquipLogic;
model StgCtrlCP "Staging Control in Clg+P"
  extends DHCs.Logic.EquipLogic.PartialStgCtrl;
  Modelica_StateGraph2.Step A1(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(extent={{-64,72},{-56,64}})));
  parameter Real Q[5] "Capacity for each machine";
  Modelica_StateGraph2.Transition T1(
    use_conditionPort=false,
    condition=u1 == -1,
    delayedTransition=false,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-70,48})));
  Modelica_StateGraph2.Transition T2(
    use_conditionPort=false,
    condition=u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,4},{-4,-4}},
        rotation=90,
        origin={-70,88})));
  Modelica_StateGraph2.Step Off(
    initialStep=true,
    use_activePort=false,
    nOut=1,
    nIn=1) annotation (Placement(transformation(extent={{-84,64},{-76,72}})));
  Modelica_StateGraph2.Step B1(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(extent={{-44,64},{-36,72}})));
  Modelica_StateGraph2.Transition T3(
    use_conditionPort=false,
    condition=u > Q[1] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-50,88})));
  Modelica_StateGraph2.Transition T4(
    use_conditionPort=false,
    condition=u <= Q[1] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,4},{4,-4}},
        rotation=90,
        origin={-50,48})));
  Modelica.Blocks.Sources.RealExpression RA1(y=if A1.activePort then 1 else 0)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,-82})));
  Modelica.Blocks.Sources.RealExpression RB1(y=if B1.activePort then 2 else 0)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-82})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=16)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-75,-47})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[0.0,0.0,0.0,0.0,0.0,
        0.0; 1,0.0,0.0,0.0,0.0,-1; 2,0.0,0.0,0.0,-1,0.0; 3,0.0,0.0,0.0,-1,-1; 4,
        0.0,0.0,-1,-1,0.0; 5,0.0,0,-1,-1,-1; 6,0.0,-1,0.0,0.0,-1; 7,0.0,-1,0.0,-1,
        0; 8,0.0,-1,0,-1,-1; 9,0.0,-1,-1,-1,0.0; 10,-1,-1,0.0,0.0,0.0; 11,0.0,-1,
        -1,-1,-1; 12,-1,-1,0.0,0.0,-1; 13,-1,-1,0,-1,0.0; 14,-1,-1,0.0,-1,-1; 15,
        -1,-1,-1,-1,0.0; 16,-1,-1,-1,-1,-1])
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=0,
        origin={41,-43})));
  Modelica.Blocks.Math.RealToInteger realToInteger[5]
    annotation (Placement(transformation(extent={{62,-50},{76,-36}})));
  Modelica_StateGraph2.Transition T6(
    use_conditionPort=false,
    condition=u <= Q[2] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-30,88})));
  Modelica_StateGraph2.Transition T5(
    use_conditionPort=false,
    condition=u > Q[2] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-30,48})));
  Modelica_StateGraph2.Step A1B1(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(extent={{-24,72},{-16,64}})));
  Modelica_StateGraph2.Step B2(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(extent={{-4,64},{4,72}})));
  Modelica_StateGraph2.Transition T7(
    use_conditionPort=false,
    condition=u > Q[1] + Q[2] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-10,88})));
  Modelica_StateGraph2.Transition T8(
    use_conditionPort=false,
    condition=u <= Q[1] + Q[2] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=270,
        origin={-10,48})));
  Modelica_StateGraph2.Step A1B2(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(extent={{16,72},{24,64}})));
  Modelica_StateGraph2.Transition T10(
    use_conditionPort=false,
    condition=u <= Q[2] + Q[3] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=270,
        origin={10,88})));
  Modelica_StateGraph2.Transition T9(
    use_conditionPort=false,
    condition=u > Q[2] + Q[3] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={10,48})));
  Modelica_StateGraph2.Step A1C1(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(extent={{36,64},{44,72}})));
  Modelica_StateGraph2.Step B1C1(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(extent={{56,72},{64,64}})));
  Modelica_StateGraph2.Transition T12(
    use_conditionPort=false,
    condition=u <= Q[1] + Q[2] + Q[3] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={30,48})));
  Modelica_StateGraph2.Transition T13(
    use_conditionPort=false,
    condition=u > Q[1] + Q[4] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={50,48})));
  Modelica_StateGraph2.Transition T11(
    use_conditionPort=false,
    condition=u > Q[1] + Q[2] + Q[3] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={30,88})));
  Modelica_StateGraph2.Transition T14(
    use_conditionPort=false,
    condition=u <= Q[1] + Q[4] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=270,
        origin={50,88})));
  Modelica_StateGraph2.Step A1B1C1(
    use_activePort=true,
    nOut=2,
    nIn=2) annotation (Placement(transformation(
        extent={{4,4},{-4,-4}},
        rotation=180,
        origin={80,68})));
  Modelica_StateGraph2.Step B2C1(
    use_activePort=true,
    nOut=2,
    nIn=2) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={60,8})));
  Modelica_StateGraph2.Step C2(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={40,8})));
  Modelica_StateGraph2.Step A1B2C1(
    use_activePort=true,
    nIn=2,
    nOut=2)
    annotation (Placement(transformation(extent={{16,4},{24,12}}, rotation=0)));
  Modelica_StateGraph2.Step A1C2(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={0,8})));
  Modelica_StateGraph2.Step B1C2(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-18,8})));
  Modelica_StateGraph2.Step A1B1C2(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-40,8})));
  Modelica_StateGraph2.Step B2C2(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-60,8})));
  Modelica_StateGraph2.Transition T17(
    use_conditionPort=false,
    condition=u > Q[1] + Q[2] + Q[4] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={70,28})));
  Modelica_StateGraph2.Transition T18(
    use_conditionPort=false,
    condition=u <= Q[1] + Q[2] + Q[4] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={70,-12})));
  Modelica_StateGraph2.Transition T15(
    use_conditionPort=false,
    condition=u > Q[2] + Q[4] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={70,88})));
  Modelica_StateGraph2.Transition T16(
    use_conditionPort=false,
    condition=u <= Q[2] + Q[4] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={70,48})));
  Modelica_StateGraph2.Transition T20(
    use_conditionPort=false,
    condition=u <= Q[2] + Q[3] + Q[4] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={50,28})));
  Modelica_StateGraph2.Transition T19(
    use_conditionPort=false,
    condition=u > Q[2] + Q[3] + Q[4] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={50,-12})));
  Modelica_StateGraph2.Transition T22(
    use_conditionPort=false,
    condition=u <= Q[4] + Q[5] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={30,-12})));
  Modelica_StateGraph2.Transition T21(
    use_conditionPort=false,
    condition=u > Q[4] + Q[5] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={30,28})));
  Modelica_StateGraph2.Transition T24(
    use_conditionPort=false,
    condition=u <= Q[1] + Q[2] + Q[3] + Q[4] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={10,28})));
  Modelica_StateGraph2.Transition T23(
    use_conditionPort=false,
    condition=u > Q[1] + Q[2] + Q[3] + Q[4] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={10,-12})));
  Modelica_StateGraph2.Transition T25(
    use_conditionPort=false,
    condition=u > Q[1] + Q[4] + Q[5] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-10,28})));
  Modelica_StateGraph2.Transition T26(
    use_conditionPort=false,
    condition=u <= Q[1] + Q[4] + Q[5] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-10,-12})));
  Modelica_StateGraph2.Transition T27(
    use_conditionPort=false,
    condition=u > Q[2] + Q[4] + Q[5] - db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={-30,-12})));
  Modelica_StateGraph2.Transition T28(
    use_conditionPort=false,
    condition=u <= Q[2] + Q[4] + Q[5] + db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-30,28})));
  Modelica_StateGraph2.Transition T29(
    use_conditionPort=false,
    condition=u > Q[1] + Q[2] + Q[4] + Q[5] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-50,28})));
  Modelica_StateGraph2.Transition T30(
    use_conditionPort=false,
    condition=u <= Q[1] + Q[2] + Q[4] + Q[5] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-50,-12})));
  Modelica.Blocks.Sources.RealExpression RA1B1(y=if A1B1.activePort then 3
         else 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,-82})));
  Modelica.Blocks.Sources.RealExpression RB1C2(y=if B1C2.activePort then 13
         else 0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={54,-82})));
  Modelica.Blocks.Sources.RealExpression RA1B1C2(y=if A1B1C2.activePort then 14
         else 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={66,-82})));
  Modelica.Blocks.Sources.RealExpression RB2C2(y=if B2C2.activePort then 15
         else 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={78,-82})));
  Modelica.Blocks.Sources.RealExpression RA1B2C2(y=if A1B2C2.activePort then 16
         else 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-82})));
  Modelica.Blocks.Sources.RealExpression RB2C1(y=if B2C1.activePort
         then 9 else 0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={4,-82})));
  Modelica.Blocks.Sources.RealExpression RC2(y=if C2.activePort
         then 10 else 0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={16,-82})));
  Modelica.Blocks.Sources.RealExpression RA1C2(y=if A1C2.activePort then 12
         else 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={42,-82})));
  Modelica.Blocks.Sources.RealExpression RB2(y=if B2.activePort then 4 else 0)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-56,-82})));
  Modelica.Blocks.Sources.RealExpression RA1B2(y=if A1B2.activePort
         then 5 else 0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-44,-82})));
  Modelica.Blocks.Sources.RealExpression RA1C1(y=if A1C1.activePort
         then 6 else 0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,-82})));
  Modelica.Blocks.Sources.RealExpression RB1C1(y=if B1C1.activePort
         then 7 else 0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-82})));
  Modelica.Blocks.Sources.RealExpression RA1B1C1(y=if A1B1C1.activePort then 8 else 0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,-82})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-14,-50},{0,-36}})));
  Modelica.Blocks.Sources.RealExpression A(y=if u1 == -1 then 1 else 0)
    annotation (Placement(transformation(extent={{-82,-40},{-62,-20}})));
  Modelica_StateGraph2.Step A1B2C2(
    use_activePort=true,
    nIn=1,
    nOut=1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-80,8})));
  Modelica_StateGraph2.Transition T31(
    use_conditionPort=false,
    condition=u > Q[2] + Q[3] + Q[4] + Q[5] + db and u1 == -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-70,-12})));
  Modelica_StateGraph2.Transition T32(
    use_conditionPort=false,
    condition=u <= Q[2] + Q[3] + Q[4] + Q[5] - db or u1 <> -1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-70,28})));
  Modelica.Blocks.Sources.RealExpression RA1B2C1(y=if A1B2C1.activePort then 11
         else 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={28,-82})));
equation
  connect(T1.outPort, A1.inPort[1])
    annotation (Line(points={{-65,48},{-60.5,48},{-60.5,64}},
                                                          color={0,0,0}));
  connect(A1.outPort[1], T2.inPort)
    annotation (Line(points={{-60.5,72.6},{-60.5,88},{-66,88}},
                                                            color={0,0,0}));
  connect(Off.outPort[1], T1.inPort)
    annotation (Line(points={{-80,63.4},{-80,48},{-74,48}}, color={0,0,0}));
  connect(T2.outPort, Off.inPort[1])
    annotation (Line(points={{-75,88},{-80,88},{-80,72}}, color={0,0,0}));
  connect(A1.outPort[2], T3.inPort) annotation (Line(points={{-59.5,72.6},{
          -59.5,88},{-54,88}},
                         color={0,0,0}));
  connect(T3.outPort, B1.inPort[1])
    annotation (Line(points={{-45,88},{-40.5,88},{-40.5,72}}, color={0,0,0}));
  connect(T4.outPort, A1.inPort[2])
    annotation (Line(points={{-55,48},{-59.5,48},{-59.5,64}}, color={0,0,0}));
  connect(B1.outPort[1], T4.inPort) annotation (Line(points={{-40.5,63.4},{
          -40.5,48},{-46,48}},
                         color={0,0,0}));
  connect(realToInteger.y, Sig)
    annotation (Line(points={{76.7,-43},{88,-43},{88,0},{110,0}},
                                              color={255,127,0}));
  connect(T5.inPort, B1.outPort[2]) annotation (Line(points={{-34,48},{-39.5,48},
          {-39.5,63.4}}, color={0,0,0}));
  connect(A1B1.inPort[1], T5.outPort)
    annotation (Line(points={{-20.5,64},{-20.5,48},{-25,48}}, color={0,0,0}));
  connect(A1B1.outPort[1], T6.inPort) annotation (Line(points={{-20.5,72.6},{
          -20.5,88},{-26,88}},
                         color={0,0,0}));
  connect(T6.outPort, B1.inPort[2])
    annotation (Line(points={{-35,88},{-39.5,88},{-39.5,72}}, color={0,0,0}));
  connect(A1B1.outPort[2], T7.inPort) annotation (Line(points={{-19.5,72.6},{
          -19.5,88},{-14,88}},
                         color={0,0,0}));
  connect(T7.outPort, B2.inPort[1])
    annotation (Line(points={{-5,88},{-0.5,88},{-0.5,72}},    color={0,0,0}));
  connect(B2.outPort[1], T8.inPort) annotation (Line(points={{-0.5,63.4},{-0.5,
          48},{-6,48}},  color={0,0,0}));
  connect(T8.outPort, A1B1.inPort[2])
    annotation (Line(points={{-15,48},{-19.5,48},{-19.5,64}}, color={0,0,0}));
  connect(B2.outPort[2], T9.inPort)
    annotation (Line(points={{0.5,63.4},{0.5,48},{6,48}},    color={0,0,0}));
  connect(T9.outPort, A1B2.inPort[1])
    annotation (Line(points={{15,48},{19.5,48},{19.5,64}},
                                                        color={0,0,0}));
  connect(A1B2.outPort[1], T10.inPort)
    annotation (Line(points={{19.5,72.6},{19.5,88},{14,88}},
                                                          color={0,0,0}));
  connect(T10.outPort, B2.inPort[2])
    annotation (Line(points={{5,88},{0.5,88},{0.5,72}},    color={0,0,0}));
  connect(A1B2.outPort[2], T11.inPort)
    annotation (Line(points={{20.5,72.6},{20.5,88},{26,88}}, color={0,0,0}));
  connect(T11.outPort, A1C1.inPort[1])
    annotation (Line(points={{35,88},{39.5,88},{39.5,72}}, color={0,0,0}));
  connect(A1C1.outPort[1], T12.inPort)
    annotation (Line(points={{39.5,63.4},{39.5,48},{34,48}}, color={0,0,0}));
  connect(T12.outPort, A1B2.inPort[2])
    annotation (Line(points={{25,48},{20.5,48},{20.5,64}}, color={0,0,0}));
  connect(A1C1.inPort[2],T14. outPort)
    annotation (Line(points={{40.5,72},{40.5,88},{45,88}}, color={0,0,0}));
  connect(B1C1.outPort[1],T14. inPort)
    annotation (Line(points={{59.5,72.6},{59.5,88},{54,88}}, color={0,0,0}));
  connect(B1C1.inPort[1],T13. outPort)
    annotation (Line(points={{59.5,64},{59.5,48},{55,48}}, color={0,0,0}));
  connect(T13.inPort, A1C1.outPort[2])
    annotation (Line(points={{46,48},{40.5,48},{40.5,63.4}}, color={0,0,0}));
  connect(T29.outPort, B2C2.inPort[1])
    annotation (Line(points={{-55,28},{-60.5,28},{-60.5,12}}, color={0,0,0}));
  connect(B2C2.outPort[1], T30.inPort) annotation (Line(points={{-60.5,3.4},{-60.5,
          -12},{-54,-12}}, color={0,0,0}));
  connect(T30.outPort, A1B1C2.inPort[1])
    annotation (Line(points={{-45,-12},{-40.5,-12},{-40.5,4}}, color={0,0,0}));
  connect(A1B1C2.outPort[1], T29.inPort) annotation (Line(points={{-40.5,12.6},{
          -40.5,28},{-46,28}}, color={0,0,0}));
  connect(T28.inPort, A1B1C2.outPort[2]) annotation (Line(points={{-34,28},{-39.5,
          28},{-39.5,12.6}}, color={0,0,0}));
  connect(A1B1C2.inPort[2], T27.outPort)
    annotation (Line(points={{-39.5,4},{-39.5,-12},{-35,-12}}, color={0,0,0}));
  connect(T27.inPort, B1C2.outPort[1]) annotation (Line(points={{-26,-12},{-18.5,
          -12},{-18.5,3.4}}, color={0,0,0}));
  connect(B1C2.inPort[1], T28.outPort)
    annotation (Line(points={{-18.5,12},{-18.5,28},{-25,28}}, color={0,0,0}));
  connect(T25.outPort, B1C2.inPort[2])
    annotation (Line(points={{-15,28},{-17.5,28},{-17.5,12}}, color={0,0,0}));
  connect(B1C2.outPort[2], T26.inPort) annotation (Line(points={{-17.5,3.4},{-17.5,
          -12},{-14,-12}}, color={0,0,0}));
  connect(T26.outPort,A1C2. inPort[1]) annotation (Line(points={{-5,-12},{-0.5,-12},
          {-0.5,4}},        color={0,0,0}));
  connect(T25.inPort,A1C2. outPort[1])
    annotation (Line(points={{-6,28},{-0.5,28},{-0.5,12.6}},   color={0,0,0}));
  connect(A1C2.outPort[2],T24. inPort)
    annotation (Line(points={{0.5,12.6},{0.5,28},{6,28}},      color={0,0,0}));
  connect(A1C2.inPort[2],T23. outPort) annotation (Line(points={{0.5,4},{0.5,-12},
          {5,-12}},        color={0,0,0}));
  connect(T23.inPort, A1B2C1.outPort[1])
    annotation (Line(points={{14,-12},{19.5,-12},{19.5,3.4}}, color={0,0,0}));
  connect(A1B2C1.inPort[1], T24.outPort)
    annotation (Line(points={{19.5,12},{19.5,28},{15,28}}, color={0,0,0}));
  connect(T21.outPort, A1B2C1.inPort[2])
    annotation (Line(points={{25,28},{20.5,28},{20.5,12}}, color={0,0,0}));
  connect(A1B2C1.outPort[2], T22.inPort)
    annotation (Line(points={{20.5,3.4},{20.5,-12},{26,-12}}, color={0,0,0}));
  connect(T22.outPort, C2.inPort[1])
    annotation (Line(points={{35,-12},{39.5,-12},{39.5,4}},
                                                          color={0,0,0}));
  connect(C2.outPort[1],T21. inPort)
    annotation (Line(points={{39.5,12.6},{39.5,28},{34,28}},
                                                         color={0,0,0}));
  connect(T20.inPort, C2.outPort[2])
    annotation (Line(points={{46,28},{40.5,28},{40.5,12.6}},color={0,0,0}));
  connect(T19.outPort, C2.inPort[2])
    annotation (Line(points={{45,-12},{40.5,-12},{40.5,4}},  color={0,0,0}));
  connect(T19.inPort, B2C1.outPort[1])
    annotation (Line(points={{54,-12},{59.5,-12},{59.5,3.4}},  color={0,0,0}));
  connect(B2C1.outPort[2],T18. inPort)
    annotation (Line(points={{60.5,3.4},{60.5,-12},{66,-12}},  color={0,0,0}));
  connect(A1B1C1.outPort[1],T16. inPort) annotation (Line(points={{79.5,63.4},{79.5,
          48},{74,48}},       color={0,0,0}));
  connect(T16.outPort, B1C1.inPort[2])
    annotation (Line(points={{65,48},{60,48},{60,64},{60.5,64}},
                                                         color={0,0,0}));
  connect(T15.inPort, B1C1.outPort[2]) annotation (Line(points={{66,88},{60.5,88},
          {60.5,72.6}},           color={0,0,0}));
  connect(A1B1C1.inPort[1],T18. outPort)
    annotation (Line(points={{79.5,72},{79.5,88},{86,88},{86,-12},{75,-12}},
                                                             color={0,0,0}));
  connect(B2C1.inPort[1],T20. outPort)
    annotation (Line(points={{59.5,12},{59.5,28},{55,28}},color={0,0,0}));
  connect(T17.outPort, B2C1.inPort[2])
    annotation (Line(points={{65,28},{60.5,28},{60.5,12}},color={0,0,0}));
  connect(T17.inPort, A1B1C1.outPort[2])
    annotation (Line(points={{74,28},{80.5,28},{80.5,63.4}},color={0,0,0}));
  connect(T15.outPort, A1B1C1.inPort[2]) annotation (Line(points={{75,88},{80.5,
          88},{80.5,72}},              color={0,0,0}));
  connect(RA1.y, multiSum.u[1]) annotation (Line(points={{-92,-71},{-92,
          -48.6406},{-80,-48.6406}}, color={0,0,127}));
  connect(RB1.y, multiSum.u[2]) annotation (Line(points={{-80,-71},{-80,-62},{
          -92,-62},{-92,-48.4219},{-80,-48.4219}},
                                             color={0,0,127}));
  connect(RA1B1.y, multiSum.u[3]) annotation (Line(points={{-68,-71},{-68,-62},
          {-92,-62},{-92,-48.2031},{-80,-48.2031}}, color={0,0,127}));
  connect(RB2.y, multiSum.u[4]) annotation (Line(points={{-56,-71},{-56,-62},{
          -92,-62},{-92,-47.9844},{-80,-47.9844}}, color={0,0,127}));
  connect(RA1B2.y, multiSum.u[5]) annotation (Line(points={{-44,-71},{-44,-62},
          {-92,-62},{-92,-47.7656},{-80,-47.7656}},
                                              color={0,0,127}));
  connect(RA1C1.y, multiSum.u[6]) annotation (Line(points={{-32,-71},{-32,-62},
          {-92,-62},{-92,-47.5469},{-80,-47.5469}}, color={0,0,127}));
  connect(RB1C1.y, multiSum.u[7]) annotation (Line(points={{-20,-71},{-20,-62},
          {-92,-62},{-92,-47.3281},{-80,-47.3281}}, color={0,0,127}));
  connect(RA1B1C1.y, multiSum.u[8]) annotation (Line(points={{-8,-71},{-8,-62},
          {-92,-62},{-92,-47.1094},{-80,-47.1094}},
                                          color={0,0,127}));
  connect(RB2C1.y, multiSum.u[9]) annotation (Line(points={{4,-71},{4,-62},{-92,
          -62},{-92,-46.8906},{-80,-46.8906}}, color={0,0,127}));
  connect(RC2.y, multiSum.u[10]) annotation (Line(points={{16,-71},{16,-62},{
          -92,-62},{-92,-46.6719},{-80,-46.6719}}, color={0,0,127}));
  connect(RA1C2.y, multiSum.u[11]) annotation (Line(points={{42,-71},{42,-62},{
          -92,-62},{-92,-46.4531},{-80,-46.4531}},
                                             color={0,0,127}));
  connect(RB1C2.y, multiSum.u[12]) annotation (Line(points={{54,-71},{54,-62},{
          -92,-62},{-92,-46.2344},{-80,-46.2344}}, color={0,0,127}));
  connect(RA1B1C2.y, multiSum.u[13]) annotation (Line(points={{66,-71},{66,-62},
          {-92,-62},{-92,-46.0156},{-80,-46.0156}}, color={0,0,127}));
  connect(RB2C2.y, multiSum.u[14]) annotation (Line(points={{78,-71},{78,-62},{
          -92,-62},{-92,-45.7969},{-80,-45.7969}},
                                             color={0,0,127}));
  connect(RA1B2C2.y, multiSum.u[15]) annotation (Line(points={{90,-71},{90,-62},
          {-92,-62},{-92,-45.5781},{-80,-45.5781}}, color={0,0,127}));
  connect(combiTable1Ds.y, realToInteger.u)
    annotation (Line(points={{48.7,-43},{60.6,-43}}, color={0,0,127}));
  connect(product2.y, combiTable1Ds.u)
    annotation (Line(points={{0.7,-43},{32.6,-43}}, color={0,0,127}));
  connect(multiSum.y, product2.u2) annotation (Line(points={{-69.15,-47},{-69.15,
          -47.2},{-15.4,-47.2}}, color={0,0,127}));
  connect(A.y, product2.u1) annotation (Line(points={{-61,-30},{-61,-32},{-15.4,
          -32},{-15.4,-38.8}}, color={0,0,127}));
  connect(B2C2.outPort[2], T31.inPort) annotation (Line(points={{-59.5,3.4},{-59.5,
          -12},{-66,-12}}, color={0,0,0}));
  connect(T31.outPort, A1B2C2.inPort[1])
    annotation (Line(points={{-75,-12},{-80,-12},{-80,4}}, color={0,0,0}));
  connect(T32.inPort, A1B2C2.outPort[1])
    annotation (Line(points={{-74,28},{-80,28},{-80,12.6}}, color={0,0,0}));
  connect(T32.outPort, B2C2.inPort[2])
    annotation (Line(points={{-65,28},{-59.5,28},{-59.5,12}}, color={0,0,0}));
  connect(RA1B2C1.y, multiSum.u[16]) annotation (Line(points={{28,-71},{28,-62},
          {-92,-62},{-92,-45.3594},{-80,-45.3594}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-10,104},{30,98}},
          textColor={28,108,200},
          textString="There is a Bug here. Forget to add C1")}));
end StgCtrlCP;
