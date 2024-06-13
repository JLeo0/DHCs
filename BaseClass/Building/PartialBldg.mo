within DHCs.BaseClass.Building;
partial model PartialBldg
  replaceable package Medium =
      Buildings.Media.Water                        constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  parameter Boolean Byp=true
                            "Bypass pipe model";
  parameter String filNam "File name with thermal loads as time series"
  annotation (Dialog(group="Load"));
  parameter Real kLd[2]
  annotation (Dialog(group="Load"));
  parameter Integer nPmp[2] "Number of Clg/Htg pumps in Bldg"
    annotation (Dialog(group="Pumps"));
  parameter Modelica.Units.SI.MassFlowRate mNomPmp[2]
    "Nominal mass flow rate of single clg/htg pump"
    annotation (Dialog(group="Pumps"));
  parameter Modelica.Units.SI.PressureDifference dpVlvNomPmp[2](displayUnit="Pa")
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
    annotation (Dialog(group="Pumps"));
  parameter Modelica.Units.SI.Time tau
    "Pump time constant at nominal flow (if energyDynamics <> SteadyState)"
    annotation (Dialog(tab="Dynamics", group="Pump"));
  parameter Boolean use_inputFilter=false
    "= true, if pump speed is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(tab="Dynamics", group="Pump"));
  parameter Modelica.Units.SI.Time riseTimePump
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
  parameter Modelica.Units.SI.MassFlowRate mNomLoa[2]
    "Load side mass flow rate at nominal conditions in Clg/Htg mode";
  parameter Modelica.Units.SI.Temperature TNomClgWat[2](min=273.15,displayUnit="degC")
    "Chilled water inlet/Outlet temperature at nominal conditions";
  parameter Modelica.Units.SI.Temperature TNomHtgWat[2](min=273.15,displayUnit="degC")
    "Heating water inlet/Outlet temperature at nominal conditions";
  parameter Modelica.Units.SI.HeatFlowRate QFlowNom[2]
    "Design Clg/Htg heat flow rate (<=0/>=0)";
  parameter Modelica.Units.SI.PressureDifference dpNom[2](displayUnit="Pa")
    "Nominal pressure drop of Clg/Htg Heat Exchangers";
  parameter Modelica.Units.SI.Temperature TNomLoa[2](displayUnit="degC")
    "Load side inlet temperature at nominal conditions in Clg/Htg mode";
protected
  parameter Integer n_PMP_C = nPmp[1] "The number of chilled water pump"
    annotation (Dialog(group="Pumps"));
  parameter Integer n_PMP_H = nPmp[2] "The number of heating water pump"
    annotation (Dialog(group="Pumps"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_PMP_C=mNomPmp[1]
    "Mass flow rate for single chilled water pump"
    annotation (Dialog(group="Pumps"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_PMP_H=mNomPmp[2]
    "Mass flow rate for single heating water pump"
    annotation (Dialog(group="Pumps"));
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal_PMP_C(displayUnit="Pa")=dpVlvNomPmp[1]
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
    annotation (Dialog(group="Pumps"));
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal_PMP_H(displayUnit="Pa")=dpVlvNomPmp[2]
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
    annotation (Dialog(group="Pumps"));
  parameter Modelica.Units.SI.MassFlowRate mLoaCoo_flow_nominal=mNomLoa[1]
    "Load side mass flow rate at nominal conditions in cooling mode";
  parameter Modelica.Units.SI.MassFlowRate mLoaHea_flow_nominal=mNomLoa[2]
    "Load side mass flow rate at nominal conditions in heating mode";
  parameter Modelica.Units.SI.Temperature T_aChiWat_nominal(
    min=273.15,displayUnit="degC") = TNomClgWat[1]
    "Chilled water inlet temperature at nominal conditions ";
  parameter Modelica.Units.SI.Temperature T_bChiWat_nominal(
    min=273.15,displayUnit="degC") = TNomClgWat[2]
    "Chilled water outlet temperature at nominal conditions";
  parameter Modelica.Units.SI.Temperature T_aHeaWat_nominal(
    min=273.15,displayUnit="degC") = TNomHtgWat[1]
    "Heating water inlet temperature at nominal conditions" annotation (Dialog(
        group="Unit"));
  parameter Modelica.Units.SI.Temperature T_bHeaWat_nominal(
    min=273.15,displayUnit="degC") = TNomHtgWat[2]
    "Heating water outlet temperature at nominal conditions" annotation (Dialog(
        group="Unit"));
  parameter Modelica.Units.SI.HeatFlowRate QCoo_flow_nominal(max=-Modelica.Constants.eps)=QFlowNom[1]
    "Design cooling heat flow rate (<=0)";
  parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal(min=Modelica.Constants.eps)=QFlowNom[2]
    "Design heating heat flow rate (>=0)";
  parameter Modelica.Units.SI.PressureDifference dpClgNom(displayUnit="Pa")=dpNom[1]
    "Nominal pressure drop of Heat Exchangers";
  parameter Modelica.Units.SI.PressureDifference dpHtgNom(displayUnit="Pa")=dpNom[2]
    "Nominal pressure drop of Heat Exchangers";
  parameter Modelica.Units.SI.Temperature T_aLoaCoo_nominal=TNomLoa[1]
    "Load side inlet temperature at nominal conditions in cooling mode";
  parameter Modelica.Units.SI.Temperature T_aLoaHea_nominal=TNomLoa[2]
    "Load side inlet temperature at nominal conditions in heating mode";
public
  Modelica.Blocks.Interfaces.RealOutput PPmpC[size(PmpC.P, 1)]
    "Electrical power consumed by the chilled water pumps"
    annotation (Placement(transformation(extent={{140,50},{160,70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant minTSet
    "Minimum temperature set point"
    annotation (Placement(transformation(extent={{-20,-8},{-12,0}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant maxTSet
    "Maximum temperature set point"
    annotation (Placement(transformation(extent={{-20,84},{-12,92}})));

  Buildings.Experimental.DHC.Loads.BaseClasses.Validation.BaseClasses.FanCoil2PipeCooling UntClg(
    QCoo_flow_nominal=QCoo_flow_nominal,
    mLoaCoo_flow_nominal=mLoaCoo_flow_nominal,
    T_aChiWat_nominal=T_aChiWat_nominal,
    T_bChiWat_nominal=T_bChiWat_nominal,
    T_aLoaCoo_nominal=T_aLoaCoo_nominal,
    QEnv_flow_nominal=-QCoo_flow_nominal,
    hexWetNtu(r_nominal=1)) "Cooling Unit"
    annotation (Placement(transformation(extent={{28,104},{52,80}})));
  Buildings.Experimental.DHC.Loads.BaseClasses.Validation.BaseClasses.FanCoil2PipeHeating UntHtg(
    QHea_flow_nominal=QHea_flow_nominal,
    mLoaHea_flow_nominal=mLoaHea_flow_nominal,
    T_aHeaWat_nominal=T_aHeaWat_nominal,
    T_bHeaWat_nominal=T_bHeaWat_nominal,
    T_aLoaHea_nominal=T_aLoaHea_nominal)
                       "Heating Unit"
    annotation (Placement(transformation(extent={{28,-22},{52,2}})));

  Plants.FlowMachine_m PmpC(
    redeclare package Medium = Medium,
    per=fill(perPmp[1], n_PMP_C),
    m_flow_nominal=m_flow_nominal_PMP_C,
    dpValve_nominal=dpValve_nominal_PMP_C,
    num=n_PMP_C)
    annotation (Placement(transformation(extent={{-80,110},{-60,90}})));

  Plants.FlowMachine_m PmpH(
    redeclare package Medium = Medium,
    per=fill(perPmp[2], n_PMP_H),
    m_flow_nominal=m_flow_nominal_PMP_H,
    dpValve_nominal=dpValve_nominal_PMP_H,
    num=n_PMP_H)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));

  Buildings.Fluid.FixedResistances.Junction Jun1(
    redeclare package Medium = Medium,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,-120})));

  Buildings.Fluid.FixedResistances.Junction Jun3(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-120,-20})));
  Buildings.Fluid.FixedResistances.Junction Jun4(redeclare package Medium =
        Medium) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={120,-20})));

  Buildings.Fluid.Sensors.TemperatureTwoPort TSup(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_PMP_C,
    initType=Modelica.Blocks.Types.Init.InitialState)
    "Supply water Temperature to building" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-120})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TRet(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal_PMP_C)
    "Return water temperature from building" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-120})));
  Buildings.Fluid.Sensors.TemperatureTwoPort To(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal_PMP_C)
    "BuiUnit Heat Exchange Outlet Temperature" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={120,-50})));
  Modelica.Blocks.Sources.CombiTimeTable LdRd(
    tableOnFile=true,
    tableName="tab1",
    fileName=filNam,
    y(each unit="kW"),
    offset={0,0},
    columns={2,3},
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1)
    "Reader for thermal loads (y[1] is cooling load, y[2] is heating load)"
    annotation (Placement(transformation(extent={{-94,126},{-82,138}})));
  Modelica.Blocks.Interfaces.RealOutput PPmpH[size(PmpH.P, 1)]
    "Electrical power consumed by the heating water pumps"
    annotation (Placement(transformation(extent={{140,10},{160,30}})));
  replaceable parameter Buildings.Fluid.Movers.Data.Generic perPmp[2]
    constrainedby Buildings.Fluid.Movers.Data.Generic
    "Performance data for water pump"
    annotation (choicesAllMatching=true,Dialog(group="Pumps"),Placement(transformation(extent={{-134,
            126},{-126,134}})));
  Buildings.Fluid.FixedResistances.Junction Jun2(
    redeclare package Medium = Medium,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional)
                annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={70,-120})));
  Modelica.Blocks.Interfaces.RealOutput Load[2] "Unfiltered Load, kW"
    annotation (Placement(transformation(extent={{140,122},{160,142}})));
  Logic.BldgLogic.LdHdl LdHdl
    annotation (Placement(transformation(extent={{-38,114},{-26,126}})));
  Buildings.Fluid.Sensors.RelativePressure dpSnsrByp(redeclare final package
      Medium = Medium) if Byp
    "Relative pressure sensor between to bypass pipe in buiunit." annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={20,-80})));
  Modelica.Blocks.Interfaces.RealOutput dpByp if Byp
    "Relative pressure of the bypass pipe"
    annotation (Placement(transformation(extent={{-140,-50},{-160,-30}})));
  Buildings.Fluid.Sensors.MassFlowRate mBypSnsr(redeclare package Medium =
        Medium, allowFlowReversal=true) if Byp
    "The mass flow rate of the bypass pipe in BuiUnit."
    annotation (Placement(transformation(extent={{10,-130},{30,-110}})));
  Modelica.Blocks.Interfaces.RealOutput mByp if Byp
    "Mass flow rate of the bypasss pipe."
    annotation (Placement(transformation(extent={{-140,-70},{-160,-50}})));
  Modelica.Blocks.Interfaces.IntegerOutput y_Md "1=htg, -1=clg, 0=off"
    annotation (Placement(transformation(extent={{140,90},{160,110}})));
  Modelica.Blocks.Sources.IntegerExpression IntExp(y=if LdHdl.y_Mode == -1 and
        yMdSys == -1 then -1 elseif LdHdl.y_Mode == 1 and yMdSys == 1 then 1
         else 0) "integer expression for clgunit and htgunit"
    annotation (Placement(transformation(extent={{100,30},{84,50}})));
  Modelica.Blocks.Interfaces.IntegerInput yMdSys "1=htg, -1=clg, 0=off"
    annotation (Placement(transformation(extent={{-168,66},{-140,94}}),
        iconTransformation(extent={{-168,66},{-140,94}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Ti(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal_PMP_C)
    "BuiUnit Pump(or Unit) Inlet Temperature" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-54,-80})));
  Modelica.Fluid.Interfaces.FluidPort_a Inlet(redeclare package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-154,-130},{-134,-110}}),
        iconTransformation(extent={{-154,-130},{-134,-110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Outlet(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{134,-130},{154,-110}}),
        iconTransformation(extent={{134,-130},{154,-110}})));
  Buildings.Fluid.Sensors.MassFlowRate mSupSnsr(redeclare package Medium =
        Medium, allowFlowReversal=true) "Total mass flow rate of Building"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-120})));
  Buildings.Fluid.Sensors.MassFlowRate mSupRea(redeclare package Medium =
        Medium, allowFlowReversal=true) "Total mass flow rate of Unit"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-90,-80})));
equation
  if Byp then
    connect(dpSnsrByp.p_rel, dpByp) annotation (Line(points={{20,-71},{20,-40},{-150,
          -40}},color={0,0,127}));
    connect(mBypSnsr.m_flow, mByp) annotation (Line(points={{20,-109},{20,-100},{-10,
          -100},{-10,-60},{-150,-60}},color={0,0,127}));
    connect(dpSnsrByp.port_b, Jun2.port_1) annotation (Line(points={{30,-80},{50,-80},
          {50,-120},{60,-120}}, color={0,127,255}));
    connect(dpSnsrByp.port_a, Jun1.port_2) annotation (Line(points={{10,-80},{0,-80},
          {0,-120},{-20,-120}},        color={0,127,255}));
    connect(mBypSnsr.port_a, Jun1.port_2) annotation (Line(
      points={{10,-120},{-20,-120}},
      color={238,46,47},
      thickness=0.5));
    connect(mBypSnsr.port_b, Jun2.port_1) annotation (Line(
      points={{30,-120},{60,-120}},
      color={238,46,47},
      thickness=0.5));
  end if;
  connect(PmpC.port_b, UntClg.port_aChiWat) annotation (Line(
      points={{-60,100},{28,100}},
      color={0,127,255},
      thickness=0.5));
  connect(Jun4.port_1, UntClg.port_bChiWat) annotation (Line(
      points={{120,-10},{120,100},{52,100}},
      color={0,127,255},
      thickness=0.5));
  connect(UntHtg.port_bHeaWat,Jun4. port_3) annotation (Line(
      points={{52,-20},{110,-20}},
      color={0,127,255},
      thickness=0.5));
  connect(PmpC.P, PPmpC) annotation (Line(points={{-59,96},{-40,96},{-40,60},{150,
          60}},                  color={0,0,127}));
  connect(maxTSet.y, UntClg.TSetCoo) annotation (Line(points={{-11.2,88},{27,88}},
                            color={0,0,127}));
  connect(minTSet.y, UntHtg.TSetHea)
    annotation (Line(points={{-11.2,-4},{27,-4}},   color={0,0,127}));
  connect(Jun3.port_2, PmpC.port_a) annotation (Line(
      points={{-120,-10},{-120,100},{-80,100}},
      color={0,127,255},
      thickness=0.5));
  connect(PmpH.port_b, UntHtg.port_aHeaWat) annotation (Line(
      points={{-60,-20},{28,-20}},
      color={0,127,255},
      thickness=0.5));
  connect(PmpH.port_a,Jun3. port_3) annotation (Line(
      points={{-80,-20},{-110,-20}},
      color={0,127,255},
      thickness=0.5));
  connect(Jun4.port_2, To.port_a) annotation (Line(
      points={{120,-30},{120,-40}},
      color={0,127,255},
      thickness=0.5));
  connect(PmpH.P, PPmpH) annotation (Line(points={{-59,-16},{-40,-16},{-40,20},{
          150,20}},  color={0,0,127}));
  connect(LdRd.y, LdHdl.u)
    annotation (Line(points={{-81.4,132},{-60,132},{-60,120},{-39.2,120}},
                                                       color={0,0,127}));
  connect(LdHdl.y[1], UntClg.QReqCoo_flow) annotation (Line(points={{-24.8,114.9},
          {20,114.9},{20,96.2},{27,96.2}},                  color={0,0,127}));
  connect(LdHdl.y[2], UntHtg.QReqHea_flow) annotation (Line(points={{-24.8,115.5},
          {20,115.5},{20,-12},{27,-12}},      color={0,0,127}));
  connect(LdHdl.y_Mode, y_Md) annotation (Line(points={{-25.4,120},{134,120},{134,
          100},{150,100}},                    color={255,127,0}));
  connect(LdRd.y, Load) annotation (Line(points={{-81.4,132},{150,132}},
                                        color={0,0,127}));
  connect(TSup.port_a, Inlet) annotation (Line(
      points={{-120,-120},{-144,-120}},
      color={0,127,255},
      thickness=0.5));
  connect(TRet.port_b, Outlet) annotation (Line(
      points={{120,-120},{144,-120}},
      color={0,127,255},
      thickness=0.5));
  connect(TRet.port_a, Jun2.port_2) annotation (Line(
      points={{100,-120},{80,-120}},
      color={0,127,255},
      thickness=0.5));
  connect(TSup.port_b, mSupSnsr.port_a) annotation (Line(
      points={{-100,-120},{-80,-120}},
      color={0,127,255},
      thickness=0.5));
  connect(mSupSnsr.port_b, Jun1.port_1) annotation (Line(
      points={{-60,-120},{-40,-120}},
      color={0,127,255},
      thickness=0.5));
  connect(Jun1.port_3, Ti.port_a) annotation (Line(
      points={{-30,-110},{-30,-80},{-44,-80}},
      color={0,127,255},
      thickness=0.5));
  connect(To.port_b, Jun2.port_3) annotation (Line(
      points={{120,-60},{120,-80},{70,-80},{70,-110}},
      color={0,127,255},
      thickness=0.5));
  connect(Ti.port_b, mSupRea.port_a)
    annotation (Line(points={{-64,-80},{-80,-80}}, color={0,127,255}));
  connect(mSupRea.port_b, Jun3.port_1) annotation (Line(points={{-100,-80},{
          -120,-80},{-120,-30}}, color={0,127,255},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -140},{140,140}}),                                  graphics={
                  Text(
          extent={{-136,-140},{142,-200}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          lineColor={128,128,128},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-140,-140},{140,140}},
          radius=40.0),
        Rectangle(
          extent={{-16,4},{16,-4}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          origin={-64,-106},
          rotation=90,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-38.5,3.5},{38.5,-3.5}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          origin={96.5,-121.5},
          rotation=180,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-46,4},{46,-4}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          origin={-106,-120},
          rotation=180,
          pattern=LinePattern.None),
        Text(
          extent={{62,30},{-58,-20}},
          textColor={255,255,255},
          textString=DynamicSelect("", String((if use_T_in then T_in else T)-273.15, format=".1f"))),
        Rectangle(
          lineColor={128,128,128},
          extent={{-140,-140},{140,140}},
          radius=40),
      Rectangle(
        extent={{-80,40},{80,-92}},
        lineColor={150,150,150},
        fillPattern=FillPattern.Solid,
        fillColor={150,150,150}),
      Polygon(
        points={{0,92},{-100,40},{100,40},{0,92}},
        lineColor={95,95,95},
        smooth=Smooth.None,
        fillPattern=FillPattern.Solid,
        fillColor={95,95,95}),
      Rectangle(
        extent={{12,-46},{58,-2}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-54,-92},{-8,-2}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-16,4},{16,-4}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          origin={62,-108},
          rotation=90,
          pattern=LinePattern.None)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,
            140}})),
    experiment(StopTime=3600, __Dymola_Algorithm="Dassl"));
end PartialBldg;
