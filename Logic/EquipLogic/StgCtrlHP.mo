within DHC.Logic.EquipLogic;
model StgCtrlHP "Staging Control in Htg+P"
  extends DHC.Logic.EquipLogic.PartialStgCtrl;
  Modelica_StateGraph2.Step A1(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(extent={{-64,72},{-56,64}})));
  parameter Real Q[3] "Capacity";
  Modelica_StateGraph2.Transition T1(
    use_conditionPort=false,
    condition=u1 == 1,
    delayedTransition=false,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-70,48})));
  Modelica_StateGraph2.Transition T2(
    use_conditionPort=false,
    condition=u1 <> 1,
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
    condition=u > Q[1] + db and u1 == 1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-50,88})));
  Modelica_StateGraph2.Transition T4(
    use_conditionPort=false,
    condition=u <= Q[1] - db or u1 <> 1,
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
  Modelica.Blocks.Math.MultiSum multiSum(nu=5)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-77,-47})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[0.0,0.0,0.0,0.0,0.0,
        0.0; 1,0.0,0.0,0.0,0.0,1; 2,0.0,0.0,0.0,1,0.0; 3,0.0,0.0,0.0,1,1; 4,0.0,
        0.0,1,1,0.0; 5,0.0,0.0,1,1,1])
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-1,-49})));
  Modelica.Blocks.Math.RealToInteger realToInteger[5]
    annotation (Placement(transformation(extent={{52,-56},{66,-42}})));
  Modelica_StateGraph2.Transition T6(
    use_conditionPort=false,
    condition=u <= Q[2] - db or u1 <> 1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-30,88})));
  Modelica_StateGraph2.Transition T5(
    use_conditionPort=false,
    condition=u > Q[2] + db and u1 == 1,
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
    condition=u > Q[1] + Q[2] + db and u1 == 1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-10,88})));
  Modelica_StateGraph2.Transition T8(
    use_conditionPort=false,
    condition=u <= Q[1] + Q[2] - db or u1 <> 1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=270,
        origin={-10,48})));
  Modelica_StateGraph2.Step A1B2(
    use_activePort=true,
    nIn=1,
    nOut=1) annotation (Placement(transformation(extent={{16,72},{24,64}})));
  Modelica_StateGraph2.Transition T10(
    use_conditionPort=false,
    condition=u <= Q[2] + Q[3] - db or u1 <> 1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=270,
        origin={10,88})));
  Modelica_StateGraph2.Transition T9(
    use_conditionPort=false,
    condition=u > Q[2] + Q[3] + db and u1 == 1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={10,48})));
  Modelica.Blocks.Sources.RealExpression RA1B1(y=if A1B1.activePort then 3
         else 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,-82})));
  Modelica.Blocks.Sources.RealExpression RB2(y=if B2.activePort then 4 else 0)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-56,-82})));
  Modelica.Blocks.Sources.RealExpression RA1B2(y=if A1B2.activePort then 5
         else 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,-82})));
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
    annotation (Line(points={{66.7,-49},{88,-49},{88,0},{110,0}},
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
    annotation (Line(points={{15,48},{20,48},{20,64}},  color={0,0,0}));
  connect(A1B2.outPort[1], T10.inPort)
    annotation (Line(points={{20,72.6},{20,88},{14,88}},  color={0,0,0}));
  connect(T10.outPort, B2.inPort[2])
    annotation (Line(points={{5,88},{0.5,88},{0.5,72}},    color={0,0,0}));
  connect(RA1.y, multiSum.u[1]) annotation (Line(points={{-92,-71},{-92,-48.4},
          {-82,-48.4}},              color={0,0,127}));
  connect(RB1.y, multiSum.u[2]) annotation (Line(points={{-80,-71},{-80,-62},{
          -92,-62},{-92,-47.7},{-82,-47.7}}, color={0,0,127}));
  connect(RA1B1.y, multiSum.u[3]) annotation (Line(points={{-68,-71},{-68,-62},
          {-92,-62},{-92,-47},{-82,-47}},           color={0,0,127}));
  connect(RB2.y, multiSum.u[4]) annotation (Line(points={{-56,-71},{-56,-62},{
          -92,-62},{-92,-46.3},{-82,-46.3}},       color={0,0,127}));
  connect(realToInteger.u, combiTable1Ds.y)
    annotation (Line(points={{50.6,-49},{6.7,-49}},  color={0,0,127}));
  connect(RA1B2.y, multiSum.u[5]) annotation (Line(points={{-42,-71},{-42,-62},
          {-92,-62},{-92,-45.6},{-82,-45.6}}, color={0,0,127}));
  connect(multiSum.y, combiTable1Ds.u) annotation (Line(points={{-71.15,-47},{
          -71.15,-48},{-12,-48},{-12,-49},{-9.4,-49}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=208800, __Dymola_Algorithm="Dassl"));
end StgCtrlHP;
