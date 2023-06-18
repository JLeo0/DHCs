within DHC.BaseClass;
model PartialBuiUnit

  parameter String filNam "File name with thermal loads as time series";

  replaceable package Medium=Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

 // load filter

 parameter Real k_C=0.05 "Cooling Load values below k_C are ignored";
 parameter Real k_H=0.05 "Heating Load values below k_H are ignored";



  parameter Modelica.Units.SI.Temperature T_ini = 20+273.15 "Temperature initialization";
// Pumps parameters
      parameter Modelica.Units.SI.Time tau=1
    "Pump time constant at nominal flow (if energyDynamics <> SteadyState)"
    annotation (Dialog(tab="Dynamics", group="Pump"));
  parameter Boolean use_inputFilter=false
    "= true, if pump speed is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(tab="Dynamics", group="Pump"));
  parameter Modelica.Units.SI.Time riseTimePump=30
    "Pump rise time of the filter (time to reach 99.6 % of the speed)" annotation (
      Dialog(
      tab="Dynamics",
      group="Pump",
      enable=use_inputFilter));
  parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization for pumps (no init/steady state/initial state/initial output)"
    annotation(Dialog(tab="Dynamics", group="Pump",enable=use_inputFilter));
  parameter Real[n_PMP_C] yPMPC_start=fill(0,n_PMP_C)
    "Initial value of chilled water pump signals"
    annotation(Dialog(tab="Dynamics", group="Pump",enable=use_inputFilter));
  parameter Real[n_PMP_H] yPMPH_start=fill(0,n_PMP_H)
    "Initial value of heating water pump signals"
    annotation(Dialog(tab="Dynamics", group="Pump",enable=use_inputFilter));

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,Dialog(tab="Dynamics",group="Pump"));
    //Cooling
    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_PMP_C=117.22
    "Mass flow rate for single chilled water pump"
    annotation (Dialog(group="Pumps nominal conditions"));
    parameter Modelica.Units.SI.Temperature T_aLoaCoo_nominal=273.15+26
    "Load side inlet temperature at nominal conditions in cooling mode"
    annotation (Dialog(group="Unit Nominal condition"));
    parameter Integer n_PMP_C = 2 "The number of chilled water pump"
    annotation (Dialog(group="Pumps nominal conditions"));
    parameter Modelica.Units.SI.PressureDifference dpValve_nominal_PMP_C(displayUnit="Pa")
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
    annotation (Dialog(group="Pumps nominal conditions"));
    //Heating
    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_PMP_H=75
    "Mass flow rate for single heating water pump"
    annotation (Dialog(group="Pumps nominal conditions"));
    parameter Integer n_PMP_H = 2 "The number of heating water pump"
    annotation (Dialog(group="Pumps nominal conditions"));
    parameter Modelica.Units.SI.PressureDifference dpValve_nominal_PMP_H(displayUnit="Pa")
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
    annotation (Dialog(group="Pumps nominal conditions"));

// Unit parameters
  parameter Modelica.Units.SI.MassFlowRate mLoaCoo_flow_nominal=300
    "Load side mass flow rate at nominal conditions in cooling mode"
    annotation (Dialog(group="Unit Nominal condition"));

  parameter Modelica.Units.SI.Temperature T_aChiWat_nominal=273.15+5.5
    "Chilled water inlet temperature at nominal conditions "
    annotation (Dialog(group="Unit Nominal condition"));

  parameter Modelica.Units.SI.Temperature T_bChiWat_nominal(
    min=273.15,displayUnit="degC") = T_aChiWat_nominal + 6
    "Chilled water outlet temperature at nominal conditions"
    annotation (Dialog(group="Unit Nominal condition"));
/*
  parameter Modelica.Units.SI.HeatFlowRate QCoo_flow_nominal(max=-Modelica.Constants.eps)=1000*
       Buildings.Experimental.DHC.Loads.BaseClasses.getPeakLoad(string=
    "#Peak space cooling load", filNam=Modelica.Utilities.Files.loadResource(
    filNam)) "Design cooling heat flow rate (<=0)"
    annotation (Dialog(group="Unit Nominal condition"));
*/
    parameter Modelica.Units.SI.HeatFlowRate QCoo_flow_nominal(max=-Modelica.Constants.eps)=-1000*7830
    "Design cooling heat flow rate (<=0)"
    annotation (Dialog(group="Unit Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpClgNom(displayUnit="Pa")
    "Nominal pressure drop of Heat Exchangers"
    annotation (Dialog(group="Unit Nominal condition"));
   parameter Modelica.Units.SI.MassFlowRate mLoaHea_flow_nominal=300
    "Load side mass flow rate at nominal conditions in heating mode"
    annotation (Dialog(group="Unit Nominal condition"));

  parameter Modelica.Units.SI.Temperature T_aHeaWat_nominal=273.15 + 46.5
    "Heating water inlet temperature at nominal conditions" annotation (Dialog(
        group="Unit Nominal condition"));

  parameter Modelica.Units.SI.Temperature T_bHeaWat_nominal(
    min=273.15,displayUnit="degC") = T_aHeaWat_nominal - 6
    "Heating water outlet temperature at nominal conditions" annotation (Dialog(
        group="Unit Nominal condition"));
/*
  parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal(min=Modelica.Constants.eps)=1000*
       Buildings.Experimental.DHC.Loads.BaseClasses.getPeakLoad(string=
    "#Peak space heating load", filNam=Modelica.Utilities.Files.loadResource(
    filNam)) "Design heating heat flow rate (>=0)"
    annotation (Dialog(group="Unit Nominal condition"));
*/
   parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal(min=Modelica.Constants.eps)=1000*3310
    "Design heating heat flow rate (>=0)"
    annotation (Dialog(group="Unit Nominal condition"));
     parameter Modelica.Units.SI.Temperature T_aLoaHea_nominal=273.15 + 21.1
    "Load side inlet temperature at nominal conditions in heating mode"
    annotation (Dialog(group="Unit Nominal condition"));

  parameter Modelica.Units.SI.HeatFlowRate QRooHea_flow_nominal(min=0) = abs(
  QCoo_flow_nominal)
    "Nominal heating load (for room air temperature prediction)"
    annotation (Dialog(group="Unit Nominal condition"));
  parameter Modelica.Units.SI.Temperature TRooHea_nominal=20 + 273.15
    "Room temperature at heating nominal conditions (for room air temperature prediction)"
    annotation (Dialog(group="Unit Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpHtgNom(displayUnit="Pa")
    "Nominal pressure drop of Heat Exchangers"
    annotation (Dialog(group="Unit Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpLoa_nominal_Unit(displayUnit="Pa")=
       250 "Load side pressure drop"
    annotation (Dialog(group="Unit Nominal condition"));

  parameter Boolean have_speVar=true
    "Set to true for a variable speed fan (otherwise fan is always on)"
    annotation (Dialog(group="Unit Nominal condition"));


    // Bypass
  parameter Boolean BypVal=true "Bypass valve signal. true=on, false=off."
  annotation (Dialog(group="Bypass"));
protected
  parameter Real SigBypVlv(min=0,max=1) = if BypVal==true then 1 else 0
  "Bypass valve status" annotation (Dialog(group="Bypass"));
public
  parameter Real Kvs "Kv value at fully open valve for bypass valve"
    annotation(Dialog(group="Bypass"),choices(
     choice =  1.31 "DN 6",
     choice =  2.34 "DN 8",
     choice =  3.65 "DN 10",
     choice =  8.22 "DN 15",
     choice =  14.6 "DN 20",
     choice =  22.8 "DN 25",
     choice =  37.4 "DN 32",
     choice =  58.5 "DN 40",
     choice =  91.3 "DN 50",
     choice =   154 "DN 65",
     choice =   234 "DN 80",
     choice =   296 "DN 90",
     choice =   365 "DN 100",
     choice =   483 "DN 115",
     choice =   570 "DN 125",
     choice =   822 "DN 150",
     choice =  1492 "DN 200",
     choice =  2422 "DN 250",
     choice =  3611 "DN 300",
     choice =  5060 "DN 350",
     choice =  6790 "DN 400",
     choice =  8823 "DN 450",
     choice = 11159 "DN 500",
     choice = 16759 "DN 600",
     choice = 20068 "DN 650",
     choice = 23744 "DN 700",
     choice = 27767 "DN 750",
     choice = 32178 "DN 800",
     choice = 42212 "DN 900",
     choice = 53911 "DN 1000",
     choice = 60420 "DN 1050",
     choice = 82845 "DN 1200"));




// Branch pipes
   parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_P=m_flow_nominal_PMP_C "Nominal mass flow rate of the pipe"
                                                                                                                      annotation (Dialog(group="Plugflowpipe"));
   parameter Modelica.Units.SI.Velocity v_nominal_P=1.5 "Velocity at m_flow_nominal (used to compute default value for hydraulic diameter dh)" annotation (Dialog(group="Plugflowpipe"));
    parameter Modelica.Units.SI.Length length=1 "Pipe length"
    annotation (Dialog(group="Plugflowpipe"));
  parameter Modelica.Units.SI.Height roughness=5e-4
    "Average height of surface asperities"
    annotation (Dialog(group="Plugflowpipe"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cPip=500
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Plugflowpipe", enable=have_pipCap));

  parameter Modelica.Units.SI.Density rhoPip(displayUnit="kg/m3") = 8000
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Plugflowpipe", enable=have_pipCap));
  parameter Modelica.Units.SI.Length thickness=0.0035 "Pipe wall thickness"
    annotation (Dialog(group="Plugflowpipe"));
  parameter Modelica.Units.SI.Length dIns=0.03
    "Thickness of pipe insulation, used to compute R"
    annotation (Dialog(group="Plugflowpipe"));

  parameter Modelica.Units.SI.ThermalConductivity kIns=0.035
    "Heat conductivity of pipe insulation, used to compute R"
    annotation (Dialog(group="Plugflowpipe"));





  Modelica.Blocks.Interfaces.RealOutput P_PMP_C[size(PMP_C.P, 1)]
    "Electrical power consumed by the chilled water pumps"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant minTSet(k=293.15, y(
        final unit="K", displayUnit="degC"))
    "Minimum temperature set point"
    annotation (Placement(transformation(extent={{-24,-14},{-16,-6}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant maxTSet(k=297.15, y(
        final unit="K", displayUnit="degC"))
    "Maximum temperature set point"
    annotation (Placement(transformation(extent={{-24,26},{-16,34}})));

  DHC.BaseClass.FanCoil2PipeCooling
    ClgUnit(
    Md=-1,
    QCoo_flow_nominal=QCoo_flow_nominal,
    mLoaCoo_flow_nominal=mLoaCoo_flow_nominal,
    T_aChiWat_nominal=T_aChiWat_nominal,
    T_bChiWat_nominal=T_bChiWat_nominal,
    T_aLoaCoo_nominal=T_aLoaCoo_nominal,
    dpClgNom=dpClgNom,
    have_speVar=have_speVar,
    dpLoa_nominal=dpLoa_nominal_Unit,
    QEnv_flow_nominal=-QCoo_flow_nominal,
    hexWetNtu(r_nominal=1))
    annotation (Placement(transformation(extent={{30,50},{54,26}})));
  DHC.BaseClass.FanCoil2PipeHeating
    HtgUnit(
    Md=1,
    QHea_flow_nominal=QHea_flow_nominal,
    mLoaHea_flow_nominal=mLoaHea_flow_nominal,
    T_aHeaWat_nominal=T_aHeaWat_nominal,
    T_bHeaWat_nominal=T_bHeaWat_nominal,
    T_aLoaHea_nominal=T_aLoaHea_nominal,
    dpHtgNom=dpHtgNom,
    dpLoa_nominal=dpLoa_nominal_Unit,
    have_speVar=have_speVar)
    annotation (Placement(transformation(extent={{30,-28},{54,-4}})));

  BaseClass.FlowMachine_m PMP_C(
    redeclare package Medium=Medium,
    per=fill(
      perPMP_C,
      n_PMP_C),
    m_flow_nominal=m_flow_nominal_PMP_C,
    dpValve_nominal=dpValve_nominal_PMP_C,
    num=n_PMP_C,
    T_start=T_ini)
    annotation (Placement(transformation(extent={{-6,36},{14,56}})));

  BaseClass.FlowMachine_m PMP_H(
    redeclare package Medium=Medium,
    per=fill(
      perPMP_H,
      n_PMP_H),
    m_flow_nominal=m_flow_nominal_PMP_H,
    dpValve_nominal=dpValve_nominal_PMP_H,
    num=n_PMP_H,
    T_start=T_ini)
    annotation (Placement(transformation(extent={{-6,-36},{14,-16}})));


//  Other models
  Buildings.Fluid.FixedResistances.Junction jun(redeclare package Medium =
        Medium,
    T_start=T_ini,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-70,36},{-50,56}})));
  Buildings.Fluid.FixedResistances.LosslessPipe BypassPipe(redeclare package
      Medium = Medium, allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal_PMP_C*n_PMP_C)
                                               "bypass pipe" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-60,-12})));

  Buildings.Fluid.FixedResistances.Junction jun2(redeclare package Medium =
        Medium,
    T_start=T_ini,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-42,36},{-22,56}})));
  Buildings.Fluid.FixedResistances.Junction jun3(redeclare package Medium =
        Medium,
    T_start=T_ini,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0})
                annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={82,30})));

  Buildings.Fluid.Actuators.Valves.TwoWayButterfly BypVlv(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal_PMP_C*n_PMP_C,             Kvs
      =Kvs) "Bypass valve"
    annotation (Placement(transformation(extent={{-2,-88},{18,-68}})));
  Modelica.Blocks.Sources.Constant SigBypValve(k=SigBypVlv)
    "1=keep bypass valve on"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-18,-62})));

  DHC.BaseClass.PlugFlowPipe FlowPipe2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_P,
    v_nominal=v_nominal_P,
    roughness=roughness,
    length=length,
    dIns=dIns,
    kIns=kIns,
    cPip=cPip,
    rhoPip=rhoPip,
    thickness=thickness,
    T_start_in=T_ini,
    T_start_out=T_ini)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,-52})));
  DHC.BaseClass.PlugFlowPipe FlowPipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_P,
    v_nominal=v_nominal_P,
    roughness=roughness,
    length=length,
    dIns=dIns,
    kIns=kIns,
    cPip=cPip,
    rhoPip=rhoPip,
    thickness=thickness,
    T_start_in=T_ini,
    T_start_out=T_ini)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,-12})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Tinlet(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_PMP_C,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_ini) "BuiUnit Branch Inlet Temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,-80})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Toutlet(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal_PMP_C) "BuiUnit Branch Outlet Temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,-80})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Tinlet_PMP(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal_PMP_C)
    "BuiUnit Pump Inlet Temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,32})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Toutlet_Unit(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal_PMP_C)
    "BuiUnit Heat Exchange Outlet Temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,2})));
  Modelica.Blocks.Sources.CombiTimeTable Loadin(
    tableOnFile=true,
    tableName="tab1",
    fileName=filNam,
    y(each unit="kW"),
    offset={0,0},
    columns={2,3},
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1)
    "Reader for thermal loads (y[1] is cooling load, y[2] is heating load)"
    annotation (Placement(transformation(extent={{-68,88},{-56,100}})));
  Modelica.Blocks.Interfaces.RealOutput P_PMP_H[size(PMP_H.P, 1)]
    "Electrical power consumed by the heating water pumps"
    annotation (Placement(transformation(extent={{100,-48},{120,-28}})));
  replaceable parameter Buildings.Fluid.Movers.Data.Generic perPMP_C
    constrainedby Buildings.Fluid.Movers.Data.Generic
    "Performance data for chilled water pump"
    annotation (choicesAllMatching=true,Dialog(group="Pumps nominal conditions"),Placement(transformation(extent={{-98,90},
            {-90,98}})));
  replaceable parameter Buildings.Fluid.Movers.Data.Generic perPMP_H
    constrainedby Buildings.Fluid.Movers.Data.Generic
    "Performance data for heating water pump"
    annotation (choicesAllMatching=true,Dialog(group="Pumps nominal conditions"),Placement(transformation(extent={{-84,90},
            {-76,98}})));

  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0})
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,-24})));
  Modelica.Blocks.Interfaces.RealOutput Load[2] "Unfiltered Load, kW"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Logic.LdHdl LdHdl(k_C=k_C*QCoo_flow_nominal, k_H=k_H*QHea_flow_nominal)
    "Load values below k are ignored"
    annotation (Placement(transformation(extent={{-40,88},{-28,100}})));

  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare final package
      Medium = Medium)
    "Relative pressure sensor between to bypass pipe in buiunit."
                                                  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-74,-52})));
  Modelica.Blocks.Interfaces.RealOutput p_rel_byp
    "Relative pressure of the bypass pipe"
    annotation (Placement(transformation(extent={{-100,-70},{-120,-50}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium, allowFlowReversal=true)
    "The mass flow rate of the bypass pipe in BuiUnit."
    annotation (Placement(transformation(extent={{-50,-88},{-30,-68}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_byp
    "Mass flow rate of the bypasss pipe."
    annotation (Placement(transformation(extent={{-100,-40},{-120,-20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y_Md "1=htg, -1=clg, 0=off"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));

  Modelica.Blocks.Sources.IntegerExpression IntExp(y=if LdHdl.y_Mode == -1 and
        yMdSys == -1 then -1 elseif LdHdl.y_Mode == 1 and yMdSys == 1 then 1
         else 0) "integer expression for clgunit and htgunit"
    annotation (Placement(transformation(extent={{-16,0},{0,20}})));
  Modelica.Blocks.Interfaces.IntegerInput yMdSys "1=htg, -1=clg, 0=off"
    annotation (Placement(transformation(extent={{-134,86},{-106,114}}),
        iconTransformation(extent={{-134,86},{-106,114}})));
equation

  connect(BypassPipe.port_a, jun.port_3)
    annotation (Line(points={{-60,-2},{-60,36}}, color={0,127,255},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(jun.port_2, jun2.port_1)
    annotation (Line(points={{-50,46},{-42,46}}, color={0,127,255}));
  connect(PMP_C.port_b, ClgUnit.port_aChiWat)
    annotation (Line(points={{14,46},{30,46}}, color={0,127,255},
      thickness=0.5));
  connect(jun3.port_1, ClgUnit.port_bChiWat)
    annotation (Line(points={{82,40},{82,46},{54,46}}, color={0,127,255},
      thickness=0.5));
  connect(HtgUnit.port_bHeaWat, jun3.port_3) annotation (Line(points={{54,-26},
          {62,-26},{62,30},{72,30}},
                               color={0,127,255},
      thickness=0.5));
  connect(PMP_C.P, P_PMP_C) annotation (Line(points={{15,50},{20,50},{20,56},{
          94,56},{94,40},{110,40}},
                color={0,0,127}));
  connect(maxTSet.y, ClgUnit.TSetCoo) annotation (Line(points={{-15.2,30},{26,
          30},{26,34},{29,34}},              color={0,0,127}));
  connect(minTSet.y, HtgUnit.TSetHea) annotation (Line(points={{-15.2,-10},{29,
          -10}},                                           color={0,0,127}));
  connect(SigBypValve.y,BypVlv. y)
    annotation (Line(points={{-13.6,-62},{8,-62},{8,-66}}, color={0,0,127}));
  connect(jun2.port_2, PMP_C.port_a) annotation (Line(points={{-22,46},{-6,46}},
                             color={0,127,255},
      thickness=0.5));
  connect(PMP_H.port_b, HtgUnit.port_aHeaWat) annotation (Line(points={{14,-26},
          {30,-26}},             color={0,127,255},
      thickness=0.5));
  connect(PMP_H.port_a, jun2.port_3)
    annotation (Line(points={{-6,-26},{-32,-26},{-32,36}},
                                                         color={0,127,255},
      thickness=0.5));
  connect(FlowPipe1.port_a, Tinlet.port_b) annotation (Line(points={{-92,-22},{-92,
          -70}},                                             color={0,127,255},
      thickness=0.5));
  connect(FlowPipe2.port_b, Toutlet.port_a) annotation (Line(points={{84,-62},{84,
          -70}},                          color={0,127,255},
      thickness=0.5));
  connect(FlowPipe1.port_b, Tinlet_PMP.port_a) annotation (Line(points={{-92,-2},
          {-92,22}},                          color={0,127,255},
      thickness=0.5));
  connect(Tinlet_PMP.port_b, jun.port_1)
    annotation (Line(points={{-92,42},{-92,46},{-70,46}},
                                                 color={0,127,255},
      thickness=0.5));
  connect(jun3.port_2, Toutlet_Unit.port_a)
    annotation (Line(points={{82,20},{84,20},{84,12}},color={0,127,255},
      thickness=0.5));
  connect(PMP_H.P, P_PMP_H) annotation (Line(points={{15,-22},{20,-22},{20,-38},
          {110,-38}},
                color={0,0,127}));
  connect(Toutlet_Unit.port_b, jun1.port_1)
    annotation (Line(points={{84,-8},{84,-14}}, color={0,127,255},
      thickness=0.5));
  connect(jun1.port_2, FlowPipe2.port_a)
    annotation (Line(points={{84,-34},{84,-42}}, color={0,127,255},
      thickness=0.5));
  connect(Loadin.y, LdHdl.u1)
    annotation (Line(points={{-55.4,94},{-41.2,94}}, color={0,0,127}));
  connect(LdHdl.y1[1], ClgUnit.QReqCoo_flow) annotation (Line(points={{-26.8,
          93.7},{20,93.7},{20,42.2},{29,42.2}}, color={0,0,127}));
  connect(LdHdl.y1[2], HtgUnit.QReqHea_flow) annotation (Line(points={{-26.8,
          94.3},{20,94.3},{20,-18},{29,-18}}, color={0,0,127}));
  connect(senRelPre.port_a, jun.port_3)
    annotation (Line(points={{-74,-42},{-74,36},{-60,36}}, color={0,127,255}));
  connect(senRelPre.port_b, jun1.port_3) annotation (Line(points={{-74,-62},{
          -74,-96},{66,-96},{66,-24},{74,-24}}, color={0,127,255}));
  connect(senRelPre.p_rel, p_rel_byp) annotation (Line(points={{-83,-52},{-94,
          -52},{-94,-60},{-110,-60}}, color={0,0,127}));
  connect(BypassPipe.port_b, senMasFlo.port_a) annotation (Line(points={{-60,-22},
          {-60,-78},{-50,-78}},      color={0,127,255}));
  connect(senMasFlo.port_b,BypVlv. port_a)
    annotation (Line(points={{-30,-78},{-2,-78}}, color={0,127,255}));
  connect(senMasFlo.m_flow, m_flow_byp) annotation (Line(points={{-40,-67},{-40,
          -30},{-110,-30}},           color={0,0,127}));
  connect(LdHdl.y_Mode, y_Md) annotation (Line(points={{-27.4,89.2},{-28,89.2},
          {-28,84},{58,84},{58,80},{110,80}}, color={255,127,0}));
  connect(Loadin.y, Load) annotation (Line(points={{-55.4,94},{-48,94},{-48,108},
          {94,108},{94,100},{110,100}},
                     color={0,0,127}));
  connect(IntExp.y, ClgUnit.u) annotation (Line(points={{0.8,10},{20,10},{20,25},
          {26.4,25}}, color={255,127,0}));
  connect(IntExp.y, HtgUnit.u) annotation (Line(points={{0.8,10},{20,10},{20,-3},
          {26.4,-3}}, color={255,127,0}));
  connect(jun1.port_3, BypVlv.port_b) annotation (Line(
      points={{74,-24},{66,-24},{66,-78},{18,-78}},
      color={0,127,255},
      thickness=0.5,
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                  Text(
          extent={{-96,156},{100,100}},
          textColor={28,108,200},
          textString="%name"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,64},{58,-50}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{-70,62},{0,94},{72,62},{-70,62}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-14,8},{14,-8}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={40,-76},
          rotation=90,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-31,2},{31,-2}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-40,-81},
          rotation=90,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-14,8},{14,-8}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-40,-76},
          rotation=90,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-31,2},{31,-2}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={40,-81},
          rotation=90,
          pattern=LinePattern.None)}),                           Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=3600, __Dymola_Algorithm="Dassl"));
end PartialBuiUnit;
