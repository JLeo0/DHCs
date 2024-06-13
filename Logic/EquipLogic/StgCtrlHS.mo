within DHCs.Logic.EquipLogic;
model StgCtrlHS "Staging Control in Htg+S"
  extends DHCs.Logic.EquipLogic.PartialStgCtrl;
  Modelica_StateGraph2.Step A1(
    use_activePort=true,
    nIn=2,
    nOut=2) annotation (Placement(transformation(extent={{-64,72},{-56,64}})));
  parameter Real Q[3]={860,2000,2000}*1000 "Capacity";
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
  Modelica_StateGraph2.Step B2(
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
  Modelica.Blocks.Sources.RealExpression RB2(y=if B2.activePort then 2 else 0)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-82})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-77,-47})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[0.0,0.0,0.0,0.0,0.0,
        0.0; 1,0.0,0.0,0.0,0.0,1; 2,0.0,0.0,0.0,1,0.0; 3,0.0,0.0,0.0,1,1])
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=0,
        origin={41,-43})));
  Modelica.Blocks.Math.RealToInteger realToInteger[5]
    annotation (Placement(transformation(extent={{62,-50},{76,-36}})));
  Modelica_StateGraph2.Transition T6(
    use_conditionPort=false,
    condition=u <= Q[2] + Q[3] - db or u1 <> 1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-30,88})));
  Modelica_StateGraph2.Transition T5(
    use_conditionPort=false,
    condition=u > Q[2] + Q[3] + db and u1 == 1,
    delayedTransition=true,
    waitTime=wt,
    use_firePort=false)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-30,48})));
  Modelica_StateGraph2.Step A1B2(
    use_activePort=true,
    nIn=1,
    nOut=1) annotation (Placement(transformation(extent={{-24,72},{-16,64}})));
  Modelica.Blocks.Sources.RealExpression RA1B2(y=if A1B2.activePort then 3
         else 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,-82})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{0,-50},{14,-36}})));
  Modelica.Blocks.Sources.RealExpression A(y=if u1 == 1 then 1 else 0)
    annotation (Placement(transformation(extent={{-84,-30},{-64,-10}})));
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
  connect(T3.outPort,B2. inPort[1])
    annotation (Line(points={{-45,88},{-40.5,88},{-40.5,72}}, color={0,0,0}));
  connect(T4.outPort, A1.inPort[2])
    annotation (Line(points={{-55,48},{-59.5,48},{-59.5,64}}, color={0,0,0}));
  connect(B2.outPort[1], T4.inPort) annotation (Line(points={{-40.5,63.4},{
          -40.5,48},{-46,48}},
                         color={0,0,0}));
  connect(realToInteger.y, Sig)
    annotation (Line(points={{76.7,-43},{88,-43},{88,0},{110,0}},
                                              color={255,127,0}));
  connect(T5.inPort,B2. outPort[2]) annotation (Line(points={{-34,48},{-39.5,48},
          {-39.5,63.4}}, color={0,0,0}));
  connect(A1B2.inPort[1], T5.outPort)
    annotation (Line(points={{-20,64},{-20,48},{-25,48}},     color={0,0,0}));
  connect(A1B2.outPort[1], T6.inPort) annotation (Line(points={{-20,72.6},{-20,88},
          {-26,88}},     color={0,0,0}));
  connect(T6.outPort,B2. inPort[2])
    annotation (Line(points={{-35,88},{-39.5,88},{-39.5,72}}, color={0,0,0}));
  connect(RA1.y, multiSum.u[1]) annotation (Line(points={{-92,-71},{-92,-48.1667},
          {-82,-48.1667}},           color={0,0,127}));
  connect(RB2.y, multiSum.u[2]) annotation (Line(points={{-80,-71},{-80,-62},{-92,
          -62},{-92,-47},{-82,-47}},         color={0,0,127}));
  connect(RA1B2.y, multiSum.u[3]) annotation (Line(points={{-68,-71},{-68,
          -62},{-92,-62},{-92,-45.8333},{-82,-45.8333}},
                                                    color={0,0,127}));
  connect(product.y, combiTable1Ds.u)
    annotation (Line(points={{14.7,-43},{32.6,-43}}, color={0,0,127}));
  connect(product.u2, multiSum.y) annotation (Line(points={{-1.4,-47.2},{-68,-47.2},
          {-68,-47},{-71.15,-47}}, color={0,0,127}));
  connect(A.y, product.u1) annotation (Line(points={{-63,-20},{-1.4,-20},{-1.4,-38.8}},
        color={0,0,127}));
  connect(realToInteger.u, combiTable1Ds.y)
    annotation (Line(points={{60.6,-43},{48.7,-43}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end StgCtrlHS;
