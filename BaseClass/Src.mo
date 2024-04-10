within DHC.BaseClass;
model Src "Models in Src side"
   replaceable package Medium =
      Buildings.Media.Water                         constrainedby
    Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching=true);
  parameter Boolean TsupMd "T=sine,F=const";
  parameter Modelica.Units.SI.Temperature Ts "Temperature on source side";
  parameter Integer n_PMP "Number of Secondary SRC pumps"
  annotation(Dialog(group="SRC PMP"));
  parameter Modelica.Units.SI.MassFlowRate mNomPmpSrcS
  "Nominal mass flow rate for Secondary pumps in SRC side"
  annotation(Dialog(group="SRC PMP"));
  parameter Modelica.Units.SI.PressureDifference dpVlvNom
  "dpValve_nominal for pumps"
  annotation(Dialog(group="SRC PMP"));
  parameter Modelica.Units.SI.PressureDifference dpStNomSrcS
  "Static pressure to raise the water"
  annotation(Dialog(group="SRC PMP"));
  parameter Modelica.Units.SI.Time tWPV "Delay time between Pumps and Valves"
    annotation(Dialog(group="SRC PMP"));
  parameter Modelica.Units.SI.MassFlowRate mNomPmpSrcP
  "Nominal mass flow rate for Primary pumps in SRC side"
  annotation(Dialog(group="SRC PMP"));
  parameter Modelica.Units.SI.Power PPmpSrcP
  ""
  annotation(Dialog(group="SRC PMP"));
  parameter Modelica.Units.SI.MassFlowRate mNomSrc
  "Nominal mass flow rate"
  annotation(Dialog(group="Flow Pipes"));
  parameter Modelica.Units.SI.Velocity v_nominal[2]
  "Design velocity"
  annotation(Dialog(group="Flow Pipes"));
  parameter Modelica.Units.SI.Length L[2]
  "Pipe length"
  annotation(Dialog(group="Flow Pipes"));
  parameter Modelica.Units.SI.Height roughness
    "Average height of surface asperities"
    annotation (Dialog(group="Flow Pipes"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cPip
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Flow Pipes", enable=have_pipCap));

  parameter Modelica.Units.SI.Density rhoPip
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Flow Pipes", enable=have_pipCap));
  parameter Modelica.Units.SI.Length thickness "Pipe wall thickness"
    annotation (Dialog(group="Flow Pipes"));
  parameter Modelica.Units.SI.Length dIns
    "Thickness of pipe insulation, used to compute R"
    annotation (Dialog(group="Flow Pipes"));
  parameter Modelica.Units.SI.ThermalConductivity kIns
    "Heat conductivity of pipe insulation, used to compute R"
    annotation (Dialog(group="Flow Pipes"));

 DHC.BaseClass.Plants.FlowMachine_m SrcPmpS(
    tWP=tWPV,
    redeclare package Medium = Medium,
    m_flow_nominal=mNomPmpSrcS,
    dpValve_nominal=dpVlvNom,
    redeclare Data.PmpSrcSec per,
    num=n_PMP) "Secondary SRC Pumps"
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Buildings.Fluid.FixedResistances.PlugFlowPipe PipSrcSup[2](
    redeclare package Medium = Medium,
    each final m_flow_nominal=mNomSrc/2,
    each v_nominal=v_nominal[1],
    each roughness=roughness,
    each length=L[1],
    each dIns=dIns,
    each kIns=kIns,
    each cPip=cPip,
    each rhoPip=rhoPip,
    each thickness=thickness) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,60})));
  Buildings.Fluid.Sources.Boundary_pT SrcBou1(
    redeclare package Medium = Medium,
    p(displayUnit="Pa") = 101325,
    use_T_in=true,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-60,80})));
  Buildings.Fluid.FixedResistances.PlugFlowPipe PipSrcRet(
    redeclare package Medium = Medium,
    m_flow_nominal=mNomSrc,
    v_nominal=v_nominal[2],
    roughness=roughness,
    length=L[2],
    dIns=dIns,
    kIns=kIns,
    cPip=cPip,
    rhoPip=rhoPip,
    thickness=thickness) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-60})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSrcRet(
    redeclare package Medium = Medium,
    m_flow_nominal=n_PMP*mNomPmpSrcS,
    initType=Modelica.Blocks.Types.Init.InitialState) "Return Temperature" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={40,-60})));
  Buildings.Fluid.Sources.Boundary_pT SrcBou2(
    redeclare package Medium = Medium,
    p(displayUnit="Pa") = 101325,
    T=293.15,
    nPorts=1) "Load_Side_Outlet" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={88,-60})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSrcSup(
    redeclare package Medium = Medium,
    m_flow_nominal=n_PMP*mNomPmpSrcS,
    initType=Modelica.Blocks.Types.Init.InitialState)
      "Supply Temperature at Source side" annotation (
      Placement(transformation(
        extent={{9,10},{-9,-10}},
        rotation=180,
        origin={71,60})));
  Modelica.Blocks.Interfaces.RealInput mSrcReq[n_PMP]
    annotation (Placement(transformation(extent={{-140,24},{-100,64}})));
  Modelica.Blocks.Interfaces.RealOutput PS[size(SrcPmpS.P, 1)]
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-114,-10},{-94,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a hp
    "Heat transfer to or from surroundings (positive if pipe is colder than surrounding)"
    annotation (Placement(transformation(extent={{96,-50},{116,-30}})));
  Buildings.Fluid.Sensors.MassFlowRate mSrc(redeclare package Medium = Medium)
    "Mass flow rate in Src side"
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Interfaces.RealOutput PP
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1.5,
    f = 1/31536000,
    phase = -1.74724,
    offset=273.15 + 20.5,
    startTime=0) if TsupMd
    annotation (Placement(transformation(extent={{-100,90},{-90,100}})));
  Modelica.Blocks.Sources.Constant const(k=Ts) if not TsupMd
    annotation (Placement(transformation(extent={{-100,68},{-90,78}})));
equation
  connect(SrcPmpS.u, mSrcReq) annotation (Line(points={{-32,64},{-70,64},{-70,
          44},{-120,44}}, color={0,0,127}));
  connect(SrcPmpS.P, PS) annotation (Line(points={{-9,64},{0,64},{0,80},{110,80}},
                color={0,0,127}));
  connect(PipSrcRet.heatPort, hp)
    annotation (Line(points={{-50,-50},{-50,-40},{106,-40}},color={191,0,0}));
  connect(PipSrcRet.port_b, mSrc.port_a) annotation (Line(
      points={{-40,-60},{-10,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(mSrc.port_b, TSrcRet.port_a) annotation (Line(
      points={{10,-60},{30,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(TSrcRet.port_b, SrcBou2.ports[1]) annotation (Line(
      points={{50,-60},{80,-60}},
      color={0,127,255},
      thickness=0.5));
  for i in 1:2 loop
    connect(PipSrcSup[i].heatPort, hp)
    annotation (Line(points={{30,50},{30,-40},{106,-40}},color={191,0,0}));
    connect(PipSrcSup[i].port_b, TSrcSup.port_a) annotation (Line(
      points={{40,60},{62,60}},
      color={0,127,255},
      thickness=0.5));
    connect(SrcPmpS.port_b, PipSrcSup[i].port_a)
    annotation (Line(points={{-10,60},{20,60}}, color={0,127,255}));
  end for;
  if TsupMd then
    connect(sine.y, SrcBou1.T_in) annotation (Line(points={{-89.5,95},{-76,95},{-76,
          83.2},{-69.6,83.2}}, color={0,0,127}));
  else
    connect(const.y, SrcBou1.T_in) annotation (Line(points={{-89.5,73},{-89.5,72},
          {-76,72},{-76,83.2},{-69.6,83.2}}, color={0,0,127}));
  end if;
  connect(SrcBou1.ports[1], SrcPmpS.port_a) annotation (Line(
      points={{-52,80},{-40,80},{-40,60},{-30,60}},
      color={0,127,255},
      thickness=0.5));
  connect(port_a, PipSrcRet.port_a) annotation (Line(
      points={{-104,0},{-80,0},{-80,-60},{-60,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(TSrcSup.port_b, port_b) annotation (Line(
      points={{80,60},{88,60},{88,0},{104,0}},
      color={0,127,255},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={                            Text(
          extent={{-98,-100},{100,-140}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Polygon(origin={23.3333,0},
          fillColor={128,128,128},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-23.333,30.0},{46.667,0.0},{-23.333,-30.0}}),
        Rectangle(
          fillColor = {128,128,128},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent={{-70,-4.5},{0,4.5}})}),
                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
end Src;
