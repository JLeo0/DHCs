within DHC.Logic.PumpLogic;
model ComEquStg
  "Staging control"
  parameter Integer n(min=1,max=3) "Number";
  parameter Modelica.Units.SI.Time wt "Waiting time";
  parameter Real kNom "Nominal";
  parameter Real db(min=0,max=1) "Deadband";
  parameter Real km[2] "Ratio range";
  Modelica.Blocks.Interfaces.BooleanInput u1
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Sources.RealExpression One(y=if OneOn.activePort then 1 else 0)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,-40})));
  Modelica.Blocks.Sources.RealExpression Two(y=if TwoOn.activePort then 2 else 0)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,-60})));
  Modelica.Blocks.Sources.RealExpression Three(y=if ThreeOn.activePort then 3 else 0)
  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,-80})));
  Modelica.Blocks.Interfaces.RealInput u "Required"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica_StateGraph2.Step Off(
    initialStep=true,
    use_activePort=false,
    nIn=1,
    nOut=1)
           "Off"
    annotation (Placement(transformation(extent={{-64,26},{-56,34}})));
  Modelica_StateGraph2.Transition T1(
    use_conditionPort=false,
    condition=u1 and u > db*kNom,
    delayedTransition=false,
    waitTime=wt) "Turn on one machine" annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-40,0})));
  Modelica_StateGraph2.Step OneOn(
    initialStep=false,
    use_activePort=true,
    nIn=2,
    nOut=2)                    "One machine is on"
    annotation (Placement(transformation(extent={{-24,34},{-16,26}})));
  Modelica_StateGraph2.Transition T2(
    use_conditionPort=false,
    condition=not u1 or u < db*kNom,
    delayedTransition=true,
    waitTime=wt) "Turn off all machines" annotation (Placement(transformation(
        extent={{4,4},{-4,-4}},
        rotation=90,
        origin={-40,60})));
  Modelica_StateGraph2.Step TwoOn(
    initialStep=false,
    use_activePort=true,
    nOut=2,
    nIn=2)                     "Two machines are on"
    annotation (Placement(transformation(extent={{16,26},{24,34}})));
  Modelica_StateGraph2.Transition T3(
    use_conditionPort=false,
    condition=u1 and u > kNom*(1 + db) and n > 1,
    delayedTransition=true,
    waitTime=wt) "Turn on two machines" annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=270,
        origin={0,60})));
  Modelica_StateGraph2.Transition T4(
    use_conditionPort=false,
    condition=not u1 or u < kNom*(1 - db),
    delayedTransition=true,
    waitTime=wt) "Turn off one machine and keep one machine on"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=270)));
  Modelica_StateGraph2.Step ThreeOn(
    initialStep=false,
    use_activePort=true,
    nOut=1,
    nIn=1) "Three machines are on"
    annotation (Placement(transformation(extent={{56,34},{64,26}})));
  Modelica_StateGraph2.Transition T6(
    use_conditionPort=false,
    condition=not u1 or u <= 2*kNom*(1 - db),
    delayedTransition=true,
    waitTime=wt) "Turn off one machine and keep two machines on"
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={40,60})));
  Modelica_StateGraph2.Transition T5(
    use_conditionPort=false,
    condition=u1 and u > 2*kNom*(1 + db) and n == 3,
    delayedTransition=true,
    waitTime=wt) "Turn on three machines" annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={40,0})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-21,-61})));
  Modelica.Blocks.Interfaces.IntegerOutput y1 "Number of working machine."
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Math.RealToInteger realToInt
    annotation (Placement(transformation(extent={{22,-68},{36,-54}})));
  Modelica.Blocks.Interfaces.RealOutput y[n] "Required output for each machine"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
algorithm
  y := fill(0, n);
  for i in 1:y1 loop
    y[i] := if y1 == 0 then 0 else (if u/y1<km[1]*kNom then km[1]*kNom elseif u/y1>km[2]*kNom then km[2]*kNom else u/y1);
  end for;
equation
  connect(multiSum.u[1], One.y) annotation (Line(points={{-26,-62.1667},{-26,
          -62},{-24,-62},{-24,-60},{-40,-60},{-40,-40},{-59,-40}},
                                                              color={0,0,127}));
  connect(Two.y, multiSum.u[2])
    annotation (Line(points={{-59,-60},{-26,-60},{-26,-61}}, color={0,0,127}));
  connect(Three.y, multiSum.u[3]) annotation (Line(points={{-59,-80},{-40,-80},
          {-40,-59.8333},{-26,-59.8333}},color={0,0,127}));
  connect(realToInt.y, y1) annotation (Line(points={{36.7,-61},{36.7,-60},{80,-60},
          {80,80},{110,80}},
        color={255,127,0}));
  connect(realToInt.u, multiSum.y)
    annotation (Line(points={{20.6,-61},{-15.15,-61}}, color={0,0,127}));
  connect(TwoOn.outPort[1], T4.inPort) annotation (Line(points={{19.5,25.4},{
          19.5,-7.21645e-16},{4,-7.21645e-16}}, color={0,0,0}));
  connect(TwoOn.outPort[2], T5.inPort) annotation (Line(points={{20.5,25.4},{
          20.5,2.77556e-16},{36,2.77556e-16}}, color={0,0,0}));
  connect(T3.outPort, TwoOn.inPort[1])
    annotation (Line(points={{5,60},{19.5,60},{19.5,34}}, color={0,0,0}));
  connect(TwoOn.inPort[2], T6.outPort)
    annotation (Line(points={{20.5,34},{20.5,60},{35,60}}, color={0,0,0}));
  connect(T6.inPort, ThreeOn.outPort[1])
    annotation (Line(points={{44,60},{60,60},{60,34.6}}, color={0,0,0}));
  connect(ThreeOn.inPort[1], T5.outPort) annotation (Line(points={{60,26},{60,
          -3.33067e-16},{45,-3.33067e-16}}, color={0,0,0}));
  connect(OneOn.inPort[1], T4.outPort) annotation (Line(points={{-20.5,26},{
          -20.5,8.88178e-16},{-5,8.88178e-16}}, color={0,0,0}));
  connect(OneOn.inPort[2], T1.outPort) annotation (Line(points={{-19.5,26},{
          -19.5,-3.33067e-16},{-35,-3.33067e-16}}, color={0,0,0}));
  connect(T2.outPort, Off.inPort[1])
    annotation (Line(points={{-45,60},{-60,60},{-60,34}}, color={0,0,0}));
  connect(Off.outPort[1], T1.inPort) annotation (Line(points={{-60,25.4},{-60,
          2.77556e-16},{-44,2.77556e-16}}, color={0,0,0}));
  connect(T2.inPort, OneOn.outPort[1]) annotation (Line(points={{-36,60},{-20.5,
          60},{-20.5,34.6}}, color={0,0,0}));
  connect(OneOn.outPort[2], T3.inPort)
    annotation (Line(points={{-19.5,34.6},{-19.5,60},{-4,60}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,-104},{76,-152}},
          textColor={28,108,200},
          textString="%name"),
        Text(
          extent={{-58,22},{62,-26}},
          textColor={28,108,200},
          textString="PmpStg")}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ComEquStg;
