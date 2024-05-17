within DHCs.BaseClass.Plants;
model Plant "Plant"
  replaceable package Medium =Buildings.Media.Water
   constrainedby Modelica.Media.Interfaces.PartialMedium
   annotation (choicesAllMatching=true);
  parameter Boolean refPre=false "Add refPressure model";
  parameter Integer nEqu[3] "Number of CHs and HPs"
  annotation (Dialog(group="Equipments"));
  parameter Boolean PS[3]=fill(true,3) "T=Parallel,F=Series"
  annotation (Dialog(group="Equipments"));
  parameter Modelica.Units.SI.MassFlowRate mNomCH[2]
  "Nominal mass flow rate in CHs LD/SRC side"
  annotation (Dialog(group="Equipments"));
  parameter Modelica.Units.SI.PressureDifference dpNomCH[2]
  "Nominal Pressure drop in CHs LD/SRC side"
  annotation (Dialog(group="Equipments"));
  parameter Modelica.Units.SI.MassFlowRate mNomHPs1[2]
  "Nominal mass flow rate in HPs1 LD/SRC side"
  annotation (Dialog(group="Equipments"));
  parameter Modelica.Units.SI.PressureDifference dpNomHPs1[2]
  "Nominal Pressure drop in HPs1 LD/SRC side"
  annotation (Dialog(group="Equipments"));
  parameter Modelica.Units.SI.MassFlowRate mNomHPs2[2]
  "Nominal mass flow rate in HPs2 LD/SRC side"
  annotation (Dialog(group="Equipments"));
  parameter Modelica.Units.SI.PressureDifference dpNomHPs2[2]
  "Nominal Pressure drop in HPs2 LD/SRC side"
  annotation (Dialog(group="Equipments"));
  parameter Integer nPmpP[2] "Number of water pumps"
  annotation(Dialog(group="Pump"));
  parameter Modelica.Units.SI.MassFlowRate mNomPmpP[2] "Chilled Water pump nominal mass flow rate"
  annotation(Dialog(group="Pump"));
  parameter Modelica.Units.SI.PressureDifference dpNomPmpP[2]
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
    annotation (Dialog(group="Pump"));
  parameter Modelica.Units.SI.MassFlowRate mNomSys
  "Nominal mass flow rate for Pressure Drop"
  annotation(Dialog(group="Others"));
  parameter Modelica.Units.SI.PressureDifference dpNomPreDro
    "Nominal pressure drop for Pressure Drop"
    annotation (Dialog(group="Others"));
  parameter Boolean Byp=false "Bypass pipe. true=on, false=off."
  annotation (Dialog(group="Others"));
  replaceable parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic perCH[nEqu[1]]
    constrainedby Buildings.Fluid.Chillers.Data.ElectricEIR.Generic
    "Performance data for CH" annotation (Dialog(group="Equipments"),choicesAllMatching=true, Placement(
        transformation(extent={{-52,-98},{-36,-82}})));
  replaceable parameter
    Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic perHPs1[nEqu[2]]
    constrainedby Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic
    "Performance data for HPs1" annotation (Dialog(group="Equipments"),choicesAllMatching=true, Placement(
        transformation(extent={{-30,-98},{-14,-82}})));
  replaceable parameter
    Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic perHPs2[nEqu[3]]
    constrainedby Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic
    "Performance data for HPs2" annotation (Dialog(group="Equipments"),choicesAllMatching=true, Placement(
        transformation(extent={{-8,-98},{8,-82}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  PlantEquipment.Equips Equips(
    redeclare package Medium = Medium,
    num=nEqu,
    PS=PS,
    mNomCH=mNomCH,
    dpNomCH=dpNomCH,
    mNomHPs1=mNomHPs1,
    dpNomHPs1=dpNomHPs1,
    mNomHPs2=mNomHPs2,
    dpNomHPs2=dpNomHPs2,
    perCH=perCH,
    perHPs1=perHPs1,
    perHPs2=perHPs2)
    annotation (Placement(transformation(extent={{0,-56},{20,-36}})));
  Buildings.Fluid.Sources.Boundary_pT refPressure(redeclare package Medium =
        Medium,
    p(displayUnit="Pa"),
    nPorts=1)    if refPre         annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-80,96})));
  Modelica.Blocks.Interfaces.IntegerInput on[sum(nEqu)]
    "Equipment signal,-1=clg,1=htg,0=off"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealOutput PCwp[nPmpP[1]]
    "Electrical power consumed by the pumps"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput PHwp[nPmpP[2]]
    "Electrical power consumed by the pumps"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealInput mCwp[nPmpP[1]]
    "Continuous input signal for the flow machine"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput mHwp[nPmpP[2]]
    "Continuous input signal for the flow machine"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealOutput P[sum(nEqu)]
    "Electric power consumed by chiller and heat pump compressor"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealInput TSet
    "Set point for leaving water temperature"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Buildings.Fluid.Sensors.MassFlowRate mBypSnsr(redeclare package Medium =
        Medium, allowFlowReversal=true) if Byp
    "The mass flow rate of the bypass pipe in plant."
    annotation (Placement(transformation(extent={{-12,72},{-28,88}})));
  Buildings.Fluid.Sensors.RelativePressure dpSnsrByp(redeclare final package
      Medium = Medium) if Byp
    "Relative pressure sensor between to bypass pipe in buiunit." annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={20,60})));
  replaceable parameter Buildings.Fluid.Movers.Data.Generic perCwp[nPmpP[1]]
  "Performance data for Cwp"
    annotation (Dialog(group="Pump"),choicesAllMatching=true, Placement(transformation(extent={{14,-98},{30,-82}})));
  replaceable parameter Buildings.Fluid.Movers.Data.Generic perHwp[nPmpP[2]]
  "Performance data for Hwp"
    annotation (Dialog(group="Pump"),choicesAllMatching=true, Placement(transformation(extent={{36,-98},{52,-82}})));
  DHCs.BaseClass.Plants.FlowMachine_m CWP(
    redeclare package Medium = Medium,
    m_flow_nominal=mNomPmpP[1],
    dpValve_nominal=dpNomPmpP[1],
    each per=perCwp,
    num=nPmpP[1])
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  DHCs.BaseClass.Plants.FlowMachine_m HWP(
    redeclare package Medium = Medium,
    m_flow_nominal=mNomPmpP[2],
    dpValve_nominal=dpNomPmpP[2],
    each per=perHwp,
    num=nPmpP[2])
    annotation (Placement(transformation(extent={{-60,-2},{-40,18}})));
  Buildings.Fluid.FixedResistances.PressureDrop PreDro(
    redeclare final package Medium = Medium,
    final m_flow_nominal=mNomSys,
    final dp_nominal=dpNomPreDro) "Flow resistance" annotation (Placement(
        transformation(
        extent={{-8,8},{8,-8}},
        rotation=270,
        origin={-20,-16})));
  Modelica.Blocks.Interfaces.RealOutput Q[sum(nEqu)]
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  if refPre then
  connect(refPressure.ports[1], port_a1)
    annotation (Line(points={{-80,90},{-80,80},{-100,80}}, color={0,127,255}));
  end if;
  if Byp then
    connect(dpSnsrByp.port_a, port_b1) annotation (Line(points={{30,60},{80,60},{80,
          80},{100,80}},    color={0,127,255}));
    connect(dpSnsrByp.port_b, port_a1) annotation (Line(points={{10,60},{-80,60},{
          -80,80},{-100,80}},  color={0,127,255}));
    connect(mBypSnsr.port_b, port_a1) annotation (Line(points={{-28,80},{-100,80}},
                              color={0,127,255}));
    connect(port_b1, mBypSnsr.port_a)
    annotation (Line(points={{100,80},{-12,80}}, color={0,127,255}));
  end if;
  connect(port_a2, Equips.port_a2) annotation (Line(
      points={{100,-80},{80,-80},{80,-52},{20,-52}},
      color={0,127,255},
      thickness=0.5));
  connect(Equips.port_b2, port_b2) annotation (Line(
      points={{0,-52},{-80,-52},{-80,-80},{-100,-80}},
      color={0,127,255},
      thickness=0.5));
  connect(Equips.on, on) annotation (Line(points={{-2,-37},{-2,-38},{-90,-38},{-90,
          60},{-120,60}},                       color={255,127,0}));
  connect(Equips.P, P) annotation (Line(points={{21,-43},{90,-43},{90,-20},{110,
          -20}}, color={0,0,127}));
  connect(Equips.TSet, TSet) annotation (Line(points={{-2,-42.2},{-90,-42.2},{-90,
          -50},{-120,-50}}, color={0,0,127}));
  connect(PreDro.port_b, Equips.port_a1) annotation (Line(
      points={{-20,-24},{-20,-40},{0,-40}},
      color={0,127,255},
      thickness=0.5));
  connect(port_b1, Equips.port_b1) annotation (Line(
      points={{100,80},{80,80},{80,-40},{20,-40}},
      color={0,127,255},
      thickness=0.5));
  connect(Equips.Q, Q) annotation (Line(points={{21,-49},{90,-49},{90,-60},{110,
          -60}}, color={0,0,127}));
  connect(HWP.P, PHwp) annotation (Line(points={{-39,12},{90,12},{90,20},{110,20}},
        color={0,0,127}));
  connect(CWP.P, PCwp) annotation (Line(points={{-39,44},{90,44},{90,60},{110,60}},
        color={0,0,127}));
  connect(mCwp, CWP.u) annotation (Line(points={{-120,20},{-72,20},{-72,44},{-62,
          44}}, color={0,0,127}));
  connect(mHwp, HWP.u) annotation (Line(points={{-120,-20},{-72,-20},{-72,12},{-62,
          12}}, color={0,0,127}));
  connect(CWP.port_a, port_a1) annotation (Line(
      points={{-60,40},{-80,40},{-80,80},{-100,80}},
      color={0,127,255},
      thickness=0.5));
  connect(HWP.port_a, port_a1) annotation (Line(
      points={{-60,8},{-80,8},{-80,80},{-100,80}},
      color={0,127,255},
      thickness=0.5));
  connect(HWP.port_b, PreDro.port_a) annotation (Line(
      points={{-40,8},{-20,8},{-20,-8}},
      color={0,127,255},
      thickness=0.5));
  connect(CWP.port_b, PreDro.port_a) annotation (Line(
      points={{-40,40},{-20,40},{-20,-8}},
      color={0,127,255},
      thickness=0.5));
  annotation (Icon(graphics={
      Text(
          extent={{-98,-102},{102,-140}},
          textColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{36,88},{94,76}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-98,-86},{-38,-74}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,60},{60,-62}},
          lineColor={27,0,55},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-14,6},{14,-6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={40,74},
          rotation=-90),
        Rectangle(
          extent={{-96,86},{-38,74}},
          lineColor={0,128,255},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-13,6},{13,-6}},
          lineColor={0,128,255},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-40,73},
          rotation=-90),
        Rectangle(
          extent={{-12.5,-5.5},{12.5,5.5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          origin={-41.5,-73.5},
          rotation=-90),
        Rectangle(
          extent={{36,-86},{94,-74}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12.5,-5.5},{12.5,5.5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          origin={40.5,-73.5},
          rotation=-90),
        Text(extent={{28,60},{-28,40}},
          textColor={255,0,0},
          textString=DynamicSelect("", String(on[1]))),
        Text(extent={{28,32},{-28,12}},
          textColor={255,0,0},
          textString=DynamicSelect("", String(on[2]))),
        Text(extent={{28,8},{-28,-12}},
          textColor={255,0,0},
          textString=DynamicSelect("", String(on[3]))),
        Text(extent={{28,-18},{-28,-38}},
          textColor={255,0,0},
          textString=DynamicSelect("", String(on[4]))),
        Text(extent={{28,-42},{-28,-62}},
          textColor={255,0,0},
          textString=DynamicSelect("", String(on[5])))}),
        defaultComponentName="Equips");
end Plant;
