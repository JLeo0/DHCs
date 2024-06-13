within DHCs.BaseClass.Plants.PlantEquipment;
model CHwithVlv "Electric chiller with associated valves"
  extends DHCs.BaseClass.Plants.PlantEquipment.PartialEquipmentValve(val2(each final
              dpFixed_nominal=dp2_nominal), val1(each final dpFixed_nominal=
          dp1_nominal));

  parameter Modelica.Units.SI.Time tau1=30
    "Time constant at nominal flow in chillers" annotation (Dialog(
      tab="Dynamics",
      group="Nominal condition",
      enable=not energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState));
  parameter Modelica.Units.SI.Time tau2=30
    "Time constant at nominal flow in chillers" annotation (Dialog(
      tab="Dynamics",
      group="Nominal condition",
      enable=not energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState));

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Conservation equations"));

  // Initialization
  parameter Medium1.AbsolutePressure p1_start = Medium1.p_default
    "Start value of pressure"
    annotation(Dialog(tab = "Initialization", group = "Medium 1"));
  parameter Medium1.Temperature T1_start = Medium1.T_default
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization", group = "Medium 1"));
  parameter Medium1.MassFraction X1_start[Medium1.nX] = Medium1.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nXi > 0));
  parameter Medium1.ExtraProperty C1_start[Medium1.nC](
    final quantity=Medium1.extraPropertiesNames)=fill(0, Medium1.nC)
    "Start value of trace substances"
    annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));
  parameter Medium1.ExtraProperty C1_nominal[Medium1.nC](
    final quantity=Medium1.extraPropertiesNames) = fill(1E-2, Medium1.nC)
    "Nominal value of trace substances. (Set to typical order of magnitude.)"
   annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));
  parameter Medium2.AbsolutePressure p2_start = Medium2.p_default
    "Start value of pressure"
    annotation(Dialog(tab = "Initialization", group = "Medium 2"));
  parameter Medium2.Temperature T2_start = Medium2.T_default
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization", group = "Medium 2"));
  parameter Medium2.MassFraction X2_start[Medium2.nX] = Medium2.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nXi > 0));
  parameter Medium2.ExtraProperty C2_start[Medium2.nC](
    final quantity=Medium2.extraPropertiesNames)=fill(0, Medium2.nC)
    "Start value of trace substances"
    annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));
  parameter Medium2.ExtraProperty C2_nominal[Medium2.nC](
    final quantity=Medium2.extraPropertiesNames) = fill(1E-2, Medium2.nC)
    "Nominal value of trace substances. (Set to typical order of magnitude.)"
   annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));

  replaceable DHCs.BaseClass.Plants.ElectricEIR Equ constrainedby
    DHCs.BaseClass.Plants.ElectricEIR(
    redeclare each final package Medium1 = Medium1,
    redeclare each final package Medium2 = Medium2,
    each final allowFlowReversal1=allowFlowReversal1,
    each final allowFlowReversal2=allowFlowReversal2,
    each final per=per,
    each final show_T=show_T,
    each final from_dp1=from_dp1,
    each final dp1_nominal=0,
    each final linearizeFlowResistance1=linearizeFlowResistance1,
    each final deltaM1=deltaM1,
    each final from_dp2=from_dp2,
    each final dp2_nominal=0,
    each final linearizeFlowResistance2=linearizeFlowResistance2,
    each final deltaM2=deltaM2,
    each final homotopyInitialization=homotopyInitialization,
    each final m1_flow_nominal=m1_flow_nominal,
    each final m2_flow_nominal=m2_flow_nominal,
    each final m1_flow_small=m1_flow_small,
    each final m2_flow_small=m2_flow_small,
    each final tau1=tau1,
    each final tau2=tau2,
    each final energyDynamics=energyDynamics,
    each final p1_start=p1_start,
    each final T1_start=T1_start,
    each final X1_start=X1_start,
    each final C1_start=C1_start,
    each final C1_nominal=C1_nominal,
    each final p2_start=p2_start,
    each final T2_start=T2_start,
    each final X2_start=X2_start,
    each final C2_start=C2_start,
    each final C2_nominal=C2_nominal)
    "Chillers with identical nominal parameters but different performance curves"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{-96,90},{-84,78}})));
  Modelica.Blocks.Sources.IntegerConstant intC(k=-1)
    annotation (Placement(transformation(extent={{16,88},{4,100}})));

  replaceable parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic per
    "Performance data"
    annotation (choicesAllMatching = true,
                Placement(transformation(extent={{42,82},{58,98}})));
  Modelica.Blocks.Math.BooleanToReal booToRea(each final realTrue=1, each final
            realFalse=0) "Boolean to real (if true then 1 else 0)"
    annotation (Placement(transformation(extent={{-76,78},{-64,90}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay(delayTime=30)
    annotation (Placement(transformation(extent={{-72,-2},{-62,8}})));
equation
  if use_inputFilter then
    connect(booToRea.y, filter.u)
      annotation (Line(points={{-63.4,84},{-60,84},{-60,84},{-55.2,84}},
        color={0,0,127}));
  else
    connect(booToRea.y, y_actual)
      annotation (Line(points={{-63.4,84},{-60,84},{-60,74},{-22,74}},
        color={0,0,127}));
  end if;
  connect(TSet, Equ.TSet)
  annotation (Line(points={{-120,-20},{-60,-20},{-60,
            -3},{-12,-3}},
                         color={0,0,127}));
  connect(Equ.port_b2, val2.port_a)
    annotation (Line(points={{-10,-6},{-40,-6},{-40,-22}},
      color={0,127,255},
      thickness=0.5));
  connect(Equ.port_b1, val1.port_a)
    annotation (Line(points={{10,6},{40,6},{40,22}}, color={0,127,255},
      thickness=0.5));
  connect(Equ.P, P) annotation (Line(points={{11,9},{80,9},{80,20},{110,20}},
        color={0,0,127}));
  connect(intEqu.u1, on) annotation (Line(points={{-97.2,84},{-120,84}},
                     color={255,127,0}));
  connect(intC.y, intEqu.u2) annotation (Line(points={{3.4,94},{-100,94},{-100,88.8},
          {-97.2,88.8}},
                  color={255,127,0}));
  connect(intEqu.y, booToRea.u)
    annotation (Line(points={{-82.8,84},{-77.2,84}}, color={255,0,255}));
  connect(Equ.on, onDelay.y)
    annotation (Line(points={{-12,3},{-61,3}}, color={255,0,255}));
  connect(intEqu.y, onDelay.u) annotation (Line(points={{-82.8,84},{-80,84},{
          -80,3},{-74,3}}, color={255,0,255}));
  connect(Equ.port_a1, Ta1.port_b) annotation (Line(
      points={{-10,6},{-40,6},{-40,60},{-66,60}},
      color={0,127,255},
      thickness=0.5));
  connect(Ta2.port_b, Equ.port_a2) annotation (Line(
      points={{66,-60},{40,-60},{40,-6},{10,-6}},
      color={0,127,255},
      thickness=0.5));
  connect(Equ.Q, Q) annotation (Line(points={{11,2},{80,2},{80,-20},{110,-20}},
        color={0,0,127}));
  annotation (defaultComponentName="CH");
end CHwithVlv;
