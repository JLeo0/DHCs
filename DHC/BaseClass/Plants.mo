within DHC.BaseClass;
model Plants
  "District heating and cooling plants, including chillers, heat pumps and pumps."
  replaceable package Medium=Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    parameter Modelica.Units.SI.Temperature T_ini "Temperature initialization";
      parameter Boolean PorS = false
    "true=Series，false=Parallel(Default)";

// Main parameter of the Chiller01 and Chiller02.
    parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal_CH  "Chiller nominal mass flow rate in source side"
    annotation(Dialog(group="Chiller"));
    parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal_CH "Chiller nominal mass flow rate in load side"
    annotation(Dialog(group="Chiller"));
    parameter Modelica.Units.SI.PressureDifference dp1_nominal_CH "Chiller nominal Pressure drop in source side"
    annotation(Dialog(group="Chiller"));
    parameter Modelica.Units.SI.PressureDifference dp2_nominal_CH "Chiller nominal Pressure drop in load side"
    annotation(Dialog(group="Chiller"));

//Chilled water pumps in summer.
  parameter Integer n_PMP_C "Number of chilled water pumps"
  annotation(Dialog(group="Pump"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_P_C "Chilled Water pump nominal mass flow rate"
  annotation(Dialog(group="Pump"));
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal_P_C
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
    annotation (Dialog(group="Pump"));

//Heating water pumps in winter.
  parameter Integer n_PMP_H "Number of heating water pumps"
  annotation(Dialog(group="Pump"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_P_H "Heating Water Pump nominal mass flow rate"
  annotation(Dialog(group="Pump"));
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal_P_H
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
    annotation (Dialog(group="Pump"));
// Chillers
  Buildings.Fluid.Chillers.ElectricEIR CH01(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=m1_flow_nominal_CH,
    m2_flow_nominal=m2_flow_nominal_CH,
    dp1_nominal(displayUnit="kPa") = dp1_nominal_CH,
    dp2_nominal(displayUnit="kPa") = dp2_nominal_CH,
    T1_start=T_ini,
    T2_start=T_ini,
    per=DHC.Data.ElectricEIRChiller_3500kW_8_0COP()) "Centrifugal Chiller CH01"
    annotation (Placement(transformation(extent={{-7,135},{43,185}})));

  Buildings.Fluid.Chillers.ElectricEIR CH02(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    m1_flow_nominal=m1_flow_nominal_CH,
    m2_flow_nominal=m2_flow_nominal_CH,
    dp1_nominal(displayUnit="kPa") = dp1_nominal_CH,
    dp2_nominal(displayUnit="kPa") = dp2_nominal_CH,
    T1_start=T_ini,
    T2_start=T_ini,
    per=DHC.Data.ElectricEIRChiller_3500kW_8_0COP()) "Centrifugal Chiller CH02"
    annotation (Placement(transformation(extent={{-12,20},{43,75}})));

// Heat Pumps
  Buildings.Fluid.HeatPumps.EquationFitReversible HP01(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    T1_start=T_ini,
    T2_start=T_ini,
    per=Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Trane_Axiom_EXW240(),
    scaling_factor=26) "Centrifugal Heat Pump HP01"
    annotation (Placement(transformation(extent={{40,-10},{-14,-64}})));
   Buildings.Fluid.HeatPumps.EquationFitReversible HP02(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    T1_start=T_ini,
    T2_start=T_ini,
    per=Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Trane_Axiom_EXW240(),
    scaling_factor=26) "Centrifugal Heat Pump HP02"
    annotation (Placement(transformation(extent={{43,-99},{-7,-149}})));
  Buildings.Fluid.HeatPumps.EquationFitReversible HP03(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    T1_start=T_ini,
    T2_start=T_ini,
    per=Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Trane_Axiom_EXW240(),
    scaling_factor=11.2) "Centrifugal Heat Pump HP03"
    annotation (Placement(transformation(extent={{43,-181},{-7,-231}})));

// Pumps
  DHC.BaseClass.FlowMachine_m CWP(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_P_C,
    dpValve_nominal=dpValve_nominal_P_C,
    redeclare Data.PMP_Clg_Plant per,
    num=n_PMP_C,
    T_start=T_ini)
           annotation (Placement(transformation(
        extent={{-22,-22},{22,22}},
        rotation=90,
        origin={56,-294})));
  DHC.BaseClass.FlowMachine_m HWP(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_P_H,
    dpValve_nominal=dpValve_nominal_P_H,
    redeclare Data.PMP_Clg_Plant per,
    num=n_PMP_H,
    T_start=T_ini)
           annotation (Placement(transformation(
        extent={{-26,-26},{26,26}},
        rotation=90,
        origin={-64,-288})));

// Other components
  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V12(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m2_flow_nominal_CH,
    Kvs=3611) "TwoWayButterfly Valve for CH01 Evaporator Inlet."
    annotation (Placement(transformation(extent={{96,136},{76,156}})));
  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V11(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=156.667,
    Kvs=3611) "TwoWayButterfly Valve for CH01 Condenser Inlet."
    annotation (Placement(transformation(extent={{-52,166},{-32,186}})));

  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V22(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m2_flow_nominal_CH,
    Kvs=3611) "TwoWayButterfly Valve for CH02 Evaporator Inlet."
    annotation (Placement(transformation(extent={{88,22},{68,42}})));
  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V21(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=156.667,
    Kvs=3611) "TwoWayButterfly Valve for CH02 Condenser Inlet."
    annotation (Placement(transformation(extent={{-62,62},{-42,82}})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller condenser outlet"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={138,176})));
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller evaporator inlet"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={118,32})));
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = Medium,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller condenser inlet" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-148,72})));

  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V32(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m2_flow_nominal_CH,
    Kvs=2422) "TwoWayButterfly Valve for HP01 Evaporator Inlet."
    annotation (Placement(transformation(extent={{88,-64},{68,-44}})));
  Buildings.Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller evaporator inlet"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={118,-54})));

  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V42(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m2_flow_nominal_CH,
    Kvs=2422) "TwoWayButterfly Valve for HP02 Evaporator Inlet."
    annotation (Placement(transformation(extent={{88,-148},{68,-128}})));
  Buildings.Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller evaporator inlet"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={118,-138})));

  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V52(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m2_flow_nominal_CH,
    Kvs=2422) "TwoWayButterfly Valve for HP03 Evaporator Inlet."
    annotation (Placement(transformation(extent={{88,-232},{68,-212}})));
  Buildings.Fluid.FixedResistances.Junction jun8(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller evaporator inlet"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={118,-222})));
  Buildings.Fluid.FixedResistances.Junction jun5(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller condenser outlet"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={138,106})));
  Buildings.Fluid.FixedResistances.Junction jun7(
    redeclare package Medium = Medium,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller condenser outlet"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={138,-20})));
  Buildings.Fluid.FixedResistances.Junction jun9(
    redeclare package Medium = Medium,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller condenser outlet"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={138,-108})));
  Buildings.Fluid.FixedResistances.Junction jun12(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller Evaporator outlet" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-108,-140})));
  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V31(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=156.667,
    Kvs=2422) "TwoWayButterfly Valve for HP01 Condenser Inlet."
    annotation (Placement(transformation(extent={{-70,-34},{-50,-14}})));
  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V41(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=156.667,
    Kvs=2422) "TwoWayButterfly Valve for HP02 Condenser Inlet."
    annotation (Placement(transformation(extent={{-62,-118},{-42,-98}})));
  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V51(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=156.667,
    Kvs=2422) "TwoWayButterfly Valve for HP03 Condenser Inlet."
    annotation (Placement(transformation(extent={{-62,-196},{-42,-176}})));
  Buildings.Fluid.FixedResistances.Junction jun10(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller Evaporator outlet" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-108,-54})));
  Buildings.Fluid.FixedResistances.Junction jun11(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller Evaporator outlet" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-108,28})));
  Buildings.Fluid.FixedResistances.Junction jun13(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller Evaporator outlet" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-108,144})));
  Buildings.Fluid.FixedResistances.Junction jun14(
    redeclare package Medium = Medium,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller condenser inlet" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-148,-186})));
  Buildings.Fluid.FixedResistances.Junction jun15(
    redeclare package Medium = Medium,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller condenser inlet" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-148,-108})));
  Buildings.Fluid.FixedResistances.Junction jun16(
    redeclare package Medium = Medium,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller condenser inlet" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-148,-24})));
  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V_PS1(
    redeclare package Medium = Medium,
    m_flow_nominal=m2_flow_nominal_CH,
    Kvs=3611) "TwoWayButterfly Valve for Chiller Parallelor Series."
    annotation (Placement(transformation(extent={{-28,116},{-48,136}})));
  Buildings.Fluid.FixedResistances.Junction jun17(
    redeclare package Medium = Medium,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller Evaporator outlet" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={44,106})));
  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V_PS2(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m2_flow_nominal_CH,
    Kvs=3611) "TwoWayButterfly Valve for Chiller Parallelor Series."
    annotation (Placement(transformation(extent={{78,96},{98,116}})));
  Buildings.Fluid.FixedResistances.Junction jun18(
    redeclare package Medium = Medium,
    T_start=T_ini,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller Evaporator outlet" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-76,176})));
  Buildings.Fluid.Actuators.Valves.TwoWayButterfly V_PS3(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m2_flow_nominal_CH,
    Kvs=3611) "TwoWayButterfly Valve for Chiller Parallelor Series."
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-148,126})));
  Modelica.Blocks.Interfaces.RealInput Tset
    "Set point for leaving fluid temperature" annotation (Placement(
        transformation(extent={{-220,-222},{-180,-182}}), iconTransformation(
          extent={{-220,-222},{-180,-182}})));
  Modelica.Fluid.Interfaces.FluidPort_b SrcO(redeclare package Medium = Medium)
                                             "Source Side Outlet" annotation (
     Placement(transformation(extent={{144,194},{222,272}}),
        iconTransformation(extent={{144,194},{222,272}})));
  Modelica.Fluid.Interfaces.FluidPort_b LdO(redeclare package Medium = Medium)
    "Load Side Outlet" annotation (Placement(transformation(extent={{-218.5,196},
            {-138,276}}), iconTransformation(extent={{-230,190},{-152,268}})));
  Modelica.Fluid.Interfaces.FluidPort_a SrcI(redeclare package Medium = Medium)
    "Source Side Inlet"                                          annotation (
      Placement(transformation(extent={{-232,-390},{-162.5,-320}}),
        iconTransformation(extent={{-240,-400},{-162,-322}})));
  Modelica.Blocks.Interfaces.RealInput Sig_VCH[2] "Chiller inlet valve signal"
    annotation (Placement(transformation(extent={{-221.5,58},{-181.5,98}}),
        iconTransformation(extent={{-221.5,58},{-181.5,98}})));
  Modelica.Blocks.Interfaces.RealInput Sig_HPV[3]
    "Heat Pump inlet valve signal" annotation (Placement(transformation(extent=
            {{-219.5,-134},{-179.5,-94}}), iconTransformation(extent={{-219.5,
            -134},{-179.5,-94}})));
  Modelica.Blocks.Interfaces.BooleanInput Sig_CH[2]
    "Set to true to enable compressor, or false to disable compressor"
    annotation (Placement(transformation(extent={{-221.5,142},{-181.5,182}}),
        iconTransformation(extent={{-221.5,142},{-181.5,182}})));
  Modelica.Blocks.Interfaces.IntegerInput Sig_HP[3]
    "Control input signal, cooling mode=-1, off=0, heating mode=+1" annotation (
     Placement(transformation(extent={{-221.5,-22},{-181.5,18}}),
        iconTransformation(extent={{-221.5,-22},{-181.5,18}})));
  Modelica.Blocks.Interfaces.RealOutput P_CH[2]
    "Each CH Electric power consumed by compressor" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={192,122}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={192,122})));
  Modelica.Blocks.Interfaces.RealOutput P_HP[3] "Each HP Compressor power "
    annotation (Placement(transformation(extent={{182,-10},{202,10}}),
        iconTransformation(extent={{182,-10},{202,10}})));

  Buildings.Fluid.FixedResistances.Junction jun19(
    redeclare package Medium = Medium,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) "jun chiller condenser inlet" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={56,-342})));
  Buildings.Fluid.FixedResistances.Junction jun20(
    redeclare package Medium = Medium,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) "jun chiller condenser outlet"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={56,-248})));
  Modelica.Blocks.Interfaces.RealOutput P_CWP[3]
    "Electrical power consumed by the Chilled Water pumps" annotation (
      Placement(transformation(extent={{184,-90},{204,-70}}),
        iconTransformation(extent={{184,-90},{204,-70}})));
  Modelica.Blocks.Interfaces.RealOutput P_HWP[2]
    "Electrical power consumed by the Hot Water pumps" annotation (Placement(
        transformation(extent={{182,-172},{202,-152}}), iconTransformation(
          extent={{182,-172},{202,-152}})));
  Modelica.Blocks.Interfaces.RealInput u_CWP[3]
    "Continuous input signal for the flow machine Chilled Water Pump"
    annotation (Placement(transformation(extent={{-220,-320},{-180,-280}})));
  Modelica.Blocks.Interfaces.RealInput u_HWP[2]
    "Continuous input signal for the flow machine Hot Water Pump"
    annotation (Placement(transformation(extent={{-220,-272},{-180,-232}})));
  Logic.PorSLgc porSLgc
    annotation (Placement(transformation(extent={{114,200},{94,220}})));
  Modelica.Blocks.Sources.BooleanExpression PorS_Mode(y=PorS)
    "Parallel or Series"
    annotation (Placement(transformation(extent={{152,200},{128,220}})));
  Modelica.Fluid.Interfaces.FluidPort_a LdI(redeclare package Medium = Medium)
    "Load Side Inlet" annotation (Placement(transformation(extent={{162,-390},{
            231.5,-320}}), iconTransformation(extent={{164,-396},{242,-318}})));
equation
  connect(V12.port_b, CH01.port_a2) annotation (Line(
      points={{76,146},{61.5,146},{61.5,145},{43,145}},
      color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(V11.port_b, CH01.port_a1) annotation (Line(
      points={{-32,176},{-22,176},{-22,175},{-7,175}},
      color={255,0,255},
      thickness=0.5));
  connect(V22.port_b, CH02.port_a2) annotation (Line(
      points={{68,32},{68,31},{43,31}},
      color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(V21.port_b, CH02.port_a1) annotation (Line(
      points={{-42,72},{-26,72},{-26,64},{-12,64}},
      color={255,0,255},
      thickness=0.5));
  connect(CH01.port_b1, jun1.port_3) annotation (Line(points={{43,175},{86.5,175},
          {86.5,176},{128,176}}, color={255,0,0},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(jun2.port_2, V12.port_a) annotation (Line(
      points={{118,42},{118,146},{96,146}},
      color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(jun2.port_3, V22.port_a) annotation (Line(
      points={{108,32},{88,32}},
      color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(jun4.port_2, jun2.port_1) annotation (Line(points={{118,-44},{118,22}},
                                           color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(jun4.port_3, V32.port_a) annotation (Line(
      points={{108,-54},{88,-54}},
      color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(jun6.port_3, V42.port_a) annotation (Line(
      points={{108,-138},{88,-138}},
      color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(jun8.port_3, V52.port_a) annotation (Line(
      points={{108,-222},{88,-222}},
      color={0,255,128},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(jun6.port_2, jun4.port_1) annotation (Line(points={{118,-128},{118,-64}},
                             color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(jun8.port_2, jun6.port_1)
    annotation (Line(points={{118,-212},{118,-148}},
                                                   color={0,255,128},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(jun1.port_1, jun5.port_2)
    annotation (Line(points={{138,166},{138,116}},
                                                 color={255,0,0},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(jun7.port_2, jun5.port_1)
    annotation (Line(points={{138,-10},{138,96}},  color={255,0,0},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(jun9.port_2, jun7.port_1)
    annotation (Line(points={{138,-98},{138,-30}},   color={255,0,0},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(HP01.port_a1, V32.port_b) annotation (Line(
      points={{40,-53.2},{58,-53.2},{58,-54},{68,-54}},
      color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HP02.port_a1, V42.port_b) annotation (Line(
      points={{43,-139},{65,-139},{65,-138},{68,-138}},
      color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HP03.port_a1, V52.port_b) annotation (Line(
      points={{43,-221},{55.5,-221},{55.5,-222},{68,-222}},
      color={0,255,128},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HP01.port_b2, jun7.port_3) annotation (Line(points={{40,-20.8},{122,
          -20.8},{122,-20},{128,-20}}, color={255,0,0},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(HP02.port_b2, jun9.port_3) annotation (Line(points={{43,-109},{122,-109},
          {122,-108},{128,-108}},
        color={255,0,0},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(jun9.port_1, HP03.port_b2) annotation (Line(points={{138,-118},{138,
          -191},{43,-191}},                          color={255,0,0},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(HP01.port_a2, V31.port_b) annotation (Line(
      points={{-14,-20.8},{-50,-20.8},{-50,-24}},
      color={255,0,255},
      thickness=0.5));
  connect(HP02.port_a2, V41.port_b) annotation (Line(
      points={{-7,-109},{-25,-109},{-25,-108},{-42,-108}},
      color={255,0,255},
      thickness=0.5));
  connect(HP03.port_a2, V51.port_b) annotation (Line(
      points={{-7,-191},{-7,-186},{-42,-186}},
      color={255,0,255},
      thickness=0.5));
  connect(jun12.port_1, HP03.port_b1) annotation (Line(points={{-108,-150},{-108,
          -221},{-7,-221}},                    color={0,255,255},
      thickness=0.5));
  connect(HP02.port_b1, jun12.port_3)
    annotation (Line(points={{-7,-139},{-7,-140},{-98,-140}},
                                                      color={0,255,255},
      thickness=0.5));
  connect(jun12.port_2, jun10.port_1)
    annotation (Line(points={{-108,-130},{-108,-64}},  color={0,255,255},
      thickness=0.5));
  connect(HP01.port_b1, jun10.port_3)
    annotation (Line(points={{-14,-53.2},{-26,-53.2},{-26,-54},{-98,-54}},
                                                      color={0,255,255},
      thickness=0.5));
  connect(jun10.port_2, jun11.port_1)
    annotation (Line(points={{-108,-44},{-108,18}},   color={0,255,255},
      thickness=0.5));
  connect(CH02.port_b2, jun11.port_3) annotation (Line(points={{-12,31},{-20,31},
          {-20,28},{-98,28}},
                            color={0,255,255},
      thickness=0.5));
  connect(CH01.port_b2, jun13.port_3) annotation (Line(points={{-7,145},{-7,144},
          {-98,144}},                             color={0,255,255},
      thickness=0.5));
  connect(jun13.port_1, jun11.port_2) annotation (Line(points={{-108,134},{-108,
          38}},                            color={0,255,255},
      thickness=0.5));
  connect(jun14.port_3, V51.port_a) annotation (Line(
      points={{-138,-186},{-62,-186}},
      color={255,0,255},
      thickness=0.5));
  connect(jun15.port_1, jun14.port_2)
    annotation (Line(points={{-148,-118},{-148,-176}}, color={255,0,255},
      thickness=0.5));
  connect(jun15.port_3, V41.port_a) annotation (Line(
      points={{-138,-108},{-62,-108}},
      color={255,0,255},
      thickness=0.5));
  connect(jun15.port_2, jun16.port_1)
    annotation (Line(points={{-148,-98},{-148,-34}},   color={255,0,255},
      thickness=0.5));
  connect(jun16.port_3, V31.port_a) annotation (Line(
      points={{-138,-24},{-70,-24}},
      color={255,0,255},
      thickness=0.5));
  connect(jun3.port_1, jun16.port_2) annotation (Line(points={{-148,62},{-148,-14}},
                                  color={255,0,255},
      thickness=0.5));
  connect(jun17.port_2, V_PS1.port_a) annotation (Line(
      points={{44,116},{44,126},{-28,126}},
      color={128,0,255},
      thickness=0.5));
  connect(CH02.port_b1, jun17.port_1) annotation (Line(
      points={{43,64},{43,80},{44,80},{44,96}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(jun17.port_3, V_PS2.port_a) annotation (Line(
      points={{54,106},{78,106}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(V_PS2.port_b, jun5.port_3) annotation (Line(
      points={{98,106},{128,106}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(jun18.port_2, V11.port_a) annotation (Line(
      points={{-66,176},{-52,176}},
      color={255,0,255},
      thickness=0.5));
  connect(V_PS1.port_b, jun18.port_3) annotation (Line(
      points={{-48,126},{-76,126},{-76,166}},
      color={128,0,255},
      thickness=0.5));
  connect(V_PS3.port_a, jun3.port_2) annotation (Line(
      points={{-148,116},{-148,82}},
      color={255,0,255},
      thickness=0.5));
  connect(V_PS3.port_b, jun18.port_1) annotation (Line(
      points={{-148,136},{-148,176},{-86,176}},
      color={255,0,255},
      thickness=0.5));
  connect(jun3.port_3, V21.port_a) annotation (Line(
      points={{-138,72},{-62,72}},
      color={255,0,255},
      thickness=0.5));
  connect(HP01.TSet, Tset) annotation (Line(points={{43.78,-61.3},{43.78,-60},{
          60,-60},{60,-80},{-92,-80},{-92,-202},{-200,-202}},
                                            color={0,0,127}));
  connect(HP02.TSet, Tset) annotation (Line(points={{46.5,-146.5},{44,-146.5},{44,
          -146},{60,-146},{60,-166},{-92,-166},{-92,-202},{-200,-202}},
                       color={0,0,127}));
  connect(HP03.TSet, Tset) annotation (Line(points={{46.5,-228.5},{56,-228.5},{56,
          -228},{60,-228},{60,-166},{-92,-166},{-92,-202},{-200,-202}},
                                                     color={0,0,127}));
  connect(jun1.port_2,SrcO)  annotation (Line(points={{138,186},{183,186},{183,233}},
                     color={255,0,0},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(jun13.port_2, LdO) annotation (Line(
      points={{-108,154},{-108,192},{-178.25,192},{-178.25,236}},
      color={0,255,255},
      thickness=0.5));
  connect(jun14.port_1,SrcI)  annotation (Line(points={{-148,-196},{-148,-355},{
          -197.25,-355}},                                     color={255,0,255},
      thickness=0.5));

  connect(SrcI,SrcI)  annotation (Line(points={{-197.25,-355},{-197.25,-355}},
        color={0,127,255}));
  connect(jun19.port_2, HWP.port_a) annotation (Line(
      points={{46,-342},{-64,-342},{-64,-314}},
      color={0,255,128},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(CWP.port_a, jun19.port_3) annotation (Line(
      points={{56,-316},{56,-332}},
      color={0,255,128},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(jun20.port_2, jun8.port_1) annotation (Line(
      points={{66,-248},{118,-248},{118,-232}},
      color={0,255,128},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(CWP.port_b, jun20.port_3) annotation (Line(
      points={{56,-272},{56,-258}},
      color={0,255,128},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(HWP.port_b, jun20.port_1) annotation (Line(
      points={{-64,-262},{-64,-248},{46,-248}},
      color={0,255,128},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(CWP.P, P_CWP) annotation (Line(points={{47.2,-269.8},{60,-269.8},{60,
          -80},{194,-80}},        color={0,0,127}));
  connect(HWP.P, P_HWP) annotation (Line(points={{-74.4,-259.4},{-74.4,-214},{
          -74,-214},{-74,-166},{162,-166},{162,-162},{192,-162}},
                             color={0,0,127}));
  connect(SrcO,SrcO)
    annotation (Line(points={{183,233},{183,233}}, color={0,127,255}));
  connect(CWP.u, u_CWP) annotation (Line(points={{47.2,-320.4},{48,-320.4},{48,
          -336},{-152,-336},{-152,-300},{-200,-300}},
        color={0,0,127}));
  connect(HWP.u, u_HWP) annotation (Line(points={{-74.4,-319.2},{-74.4,-336},{
          -152,-336},{-152,-252},{-200,-252}},
                  color={0,0,127}));
  connect(HP01.uMod, Sig_HP[1]) annotation (Line(points={{42.7,-37},{52,-37},{
          52,-2},{-198,-2},{-198,-8},{-200,-8},{-200,-8.66667},{-201.5,-8.66667}},
        color={255,127,0}));
  connect(HP02.uMod, Sig_HP[2]) annotation (Line(points={{45.5,-124},{52,-124},
          {52,-2},{-201.5,-2}}, color={255,127,0}));
  connect(HP03.uMod, Sig_HP[3]) annotation (Line(points={{45.5,-206},{52,-206},
          {52,-2},{-190,-2},{-190,0},{-196,0},{-196,4.66667},{-201.5,4.66667}},
        color={255,127,0}));
  connect(V31.y, Sig_HPV[1]) annotation (Line(points={{-60,-12},{-60,-8},{-168,
          -8},{-168,-114},{-194,-114},{-194,-120},{-196,-120},{-196,-120.667},{
          -199.5,-120.667}},                      color={0,0,127}));
  connect(V32.y, Sig_HPV[1]) annotation (Line(points={{78,-42},{78,-36},{60,-36},
          {60,-80},{-168,-80},{-168,-114},{-194,-114},{-194,-120.667},{-199.5,
          -120.667}},        color={0,0,127}));
  connect(V41.y, Sig_HPV[2]) annotation (Line(points={{-52,-96},{-52,-80},{-168,
          -80},{-168,-114},{-199.5,-114}}, color={0,0,127}));
  connect(V42.y, Sig_HPV[2]) annotation (Line(points={{78,-126},{78,-80},{-168,
          -80},{-168,-114},{-199.5,-114}},
                         color={0,0,127}));
  connect(V51.y, Sig_HPV[3]) annotation (Line(points={{-52,-174},{-52,-166},{
          -28,-166},{-28,-80},{-168,-80},{-168,-114},{-192,-114},{-192,-107.333},
          {-199.5,-107.333}},                                     color={0,0,
          127}));
  connect(V52.y, Sig_HPV[3]) annotation (Line(points={{78,-210},{78,-166},{-28,
          -166},{-28,-80},{-168,-80},{-168,-114},{-192,-114},{-192,-110},{-196,
          -110},{-196,-107.333},{-199.5,-107.333}},
                      color={0,0,127}));
  connect(CH01.on, Sig_CH[1]) annotation (Line(points={{-12,167.5},{-24,167.5},
          {-24,160},{-192,160},{-192,162},{-196,162},{-196,157},{-201.5,157}},
                                                         color={255,0,255}));
  connect(CH02.on, Sig_CH[2]) annotation (Line(points={{-17.5,55.75},{-50,55.75},
          {-50,56},{-82,56},{-82,160},{-196,160},{-196,167},{-201.5,167}},
        color={255,0,255}));
  connect(V11.y, Sig_VCH[1]) annotation (Line(points={{-42,188},{-42,206},{-92,
          206},{-92,90},{-176,90},{-176,78},{-192,78},{-192,76},{-196,76},{-196,
          73},{-201.5,73}},                               color={0,0,127}));
  connect(V12.y, Sig_VCH[1]) annotation (Line(points={{86,158},{86,206},{-92,
          206},{-92,90},{-176,90},{-176,78},{-196,78},{-196,73},{-201.5,73}},
        color={0,0,127}));
  connect(V21.y, Sig_VCH[2]) annotation (Line(points={{-52,84},{-52,90},{-176,
          90},{-176,78},{-196,78},{-196,83},{-201.5,83}},
                                                     color={0,0,127}));
  connect(V22.y, Sig_VCH[2]) annotation (Line(points={{78,44},{78,90},{-176,90},
          {-176,78},{-194,78},{-194,80},{-198,80},{-198,83},{-201.5,83}},
                                                                       color={0,
          0,127}));
  connect(CH01.P, P_CH[1]) annotation (Line(points={{45.5,182.5},{92,182.5},{92,
          182},{112,182},{112,158},{166,158},{166,122},{188,122},{188,119.5},{
          192,119.5}}, color={0,0,127}));
  connect(CH02.P, P_CH[2]) annotation (Line(points={{45.75,72.25},{106,72.25},{
          106,72},{166,72},{166,122},{186,122},{186,124},{192,124},{192,124.5}},
        color={0,0,127}));
  connect(HP01.P, P_HP[1]) annotation (Line(points={{-16.7,-36.46},{-30,-36.46},
          {-30,-2},{176,-2},{176,0},{186,0},{186,-3.33333},{192,-3.33333}},
        color={0,0,127}));
  connect(HP02.P, P_HP[2]) annotation (Line(points={{-9.5,-123.5},{-16,-123.5},
          {-16,-80},{156,-80},{156,-2},{176,-2},{176,0},{192,0}}, color={0,0,
          127}));
  connect(HP03.P, P_HP[3]) annotation (Line(points={{-9.5,-205.5},{-16,-205.5},
          {-16,-80},{156,-80},{156,-2},{176,-2},{176,0},{186,0},{186,3.33333},{
          192,3.33333}}, color={0,0,127}));
  connect(V_PS3.y, porSLgc.Sig_V_PS2) annotation (Line(points={{-136,126},{-128,
          126},{-128,206},{93,206}},
                           color={0,0,127}));
  connect(V_PS2.y, porSLgc.Sig_V_PS2) annotation (Line(points={{88,118},{88,124},
          {58,124},{58,206},{93,206}},    color={0,0,127}));
  connect(V_PS1.y, porSLgc.Sig_V_PS1) annotation (Line(points={{-38,138},{-38,152},
          {-58,152},{-58,214},{93,214}},
                 color={0,0,127}));
  connect(CH02.TSet, Tset) annotation (Line(points={{-17.5,39.25},{-64,39.25},{-64,
          40},{-92,40},{-92,-202},{-200,-202}},      color={0,0,127}));
  connect(CH01.TSet, Tset) annotation (Line(points={{-12,152.5},{-18,152.5},{-18,
          90},{-92,90},{-92,-202},{-200,-202}},                   color={0,0,
          127}));
  connect(PorS_Mode.y, porSLgc.u)
    annotation (Line(points={{126.8,210},{116,210}}, color={255,0,255}));
  connect(LdI, LdI)
    annotation (Line(points={{196.75,-355},{196.75,-355}}, color={0,127,255}));
  connect(jun19.port_1, LdI) annotation (Line(
      points={{66,-342},{148,-342},{148,-355},{196.75,-355}},
      color={0,255,128},
      thickness=0.5,
      pattern=LinePattern.Dash));
  annotation (
      experiment(StopTime=7200, __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-180,-360},{180,220}}), graphics={Text(
          extent={{-314,386},{-48,264}},
          textColor={28,108,200},
          textString="Load Side Outlet"),Text(
          extent={{100,-376},{348,-486}},
          textColor={28,108,200},
          textString="Load Side Inlet"),
        Text(
          extent={{-500,26},{-394,-82}},
          textColor={28,108,200},
          fontSize=26,
          textString="冷水机组：
a1b1冷却侧；
a2b2负荷侧。
热泵机组：
a1b1始终为负荷侧，
a2b2始终为源侧")}),
    Icon(coordinateSystem(extent={{-180,-360},{180,220}}), graphics={
                  Text(
          extent={{-166,-374},{196,-510}},
          textColor={28,108,200},
          textString="%name"),
        Rectangle(
          extent={{-180,220},{182,-360}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-140,88},{148,-312}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{-174,86},{4,196},{184,86},{-174,86}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-104,-18},{-16,-98}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{18,-20},{106,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-104,-138},{-16,-218}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{20,-138},{108,-218}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0})}));
end Plants;
