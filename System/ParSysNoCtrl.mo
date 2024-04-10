within DHC.System;
partial model ParSysNoCtrl "Partial system"
  extends Modelica.Icons.Example;
replaceable package Medium=Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium
  annotation (choicesAllMatching=true);
  parameter Modelica.Units.SI.Temperature Ts "Temperature on source side";
BaseClass.TransNet.Distribution2PipePlugFlow Dis(
    allowFlowReversal=true,
  redeclare package Medium = Medium)   "Distribution network for DHC system"
  annotation (Placement(transformation(extent={{30,-10},{70,10}})));
DHC.BaseClass.Building.Bldg Bldg[3](redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature Gnd
  "Ground temperature"
  annotation (Placement(transformation(extent={{56,-86},{44,-74}})));
BaseClass.Src     Src(
  redeclare package Medium = Medium)
                    "Source side part"
  annotation (Placement(transformation(extent={{-60,-86},{-40,-66}})));
DHC.BaseClass.Plants.Plant Plt(
    redeclare package Medium = Medium,
    refPre=true,
    dpNomHPs1(displayUnit="Pa"),
    dpNomHPs2(displayUnit="Pa"))
    annotation (Placement(transformation(extent={{-62,-40},{-40,-18}})));
  Buildings.Fluid.Sensors.MassFlowRate mFlow(redeclare package Medium = Medium,
      allowFlowReversal=false)
    "Mass flow rate in system"
    annotation (Placement(transformation(extent={{-28,-10},{-36,-2}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Tsup(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    initType=Modelica.Blocks.Types.Init.InitialState)
                         "Supply Temperature" annotation (Placement(
        transformation(
        extent={{4,4},{-4,-4}},
        rotation=180,
        origin={-16,-32})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Tret(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    initType=Modelica.Blocks.Types.Init.InitialState) "Return Temperature"
                                              annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={-4,-6})));
  Modelica.Blocks.Sources.Cosine cosine(
    amplitude=12.08,
    f=1/31536000,
    phase(displayUnit="rad") = -0.3675 - 1.74724 - 1.5708,
    offset=273.15 + 18.5,y(
      quantity="Temperature",
      unit="K"))
    annotation (Placement(transformation(extent={{86,-86},{74,-74}})));
equation
connect(Dis.ports_bCon, Bldg.Inlet) annotation (Line(points={{38,10},{20,10},
          {20,41.4286},{39.7143,41.4286}},  color={0,127,255},
    thickness=0.5));
connect(Bldg.Outlet, Dis.ports_aCon) annotation (Line(points={{60.2857,
          41.4286},{80,41.4286},{80,10},{62,10}},
      color={0,127,255},
    thickness=0.5));
connect(Gnd.port, Dis.heatPort)
  annotation (Line(points={{44,-80},{37,-80},{37,-10}}, color={191,0,0}));
connect(Gnd.port, Src.hp) annotation (Line(points={{44,-80},{-39.4,-80}},
                   color={191,0,0}));
  connect(Plt.port_b2, Src.port_a) annotation (Line(
      points={{-62,-37.8},{-62,-38},{-72,-38},{-72,-76},{-60.4,-76}},
      color={0,127,255},
      thickness=0.5));
  connect(Tsup.port_b, Dis.port_aDisSup) annotation (Line(points={{-12,-32},{20,
          -32},{20,0},{30,0}},
                            color={0,127,255},
      thickness=0.5));
  connect(mFlow.port_a, Tret.port_b) annotation (Line(
      points={{-28,-6},{-8,-6}},
      color={0,127,255},
      thickness=0.5));
  connect(mFlow.port_b, Plt.port_a1) annotation (Line(
      points={{-36,-6},{-62,-6},{-62,-20.2}},
      color={0,127,255},
      thickness=0.5));
  connect(cosine.y, Gnd.T)
    annotation (Line(points={{73.4,-80},{57.2,-80}}, color={0,0,127}));
  connect(Plt.port_a2, Src.port_b) annotation (Line(
      points={{-40,-37.8},{-40,-38},{-28,-38},{-28,-76},{-39.6,-76}},
      color={0,127,255},
      thickness=0.5));
  connect(Tret.port_a, Dis.port_bDisRet) annotation (Line(
      points={{2.22045e-16,-6},{30,-6}},
      color={0,127,255},
      thickness=0.5));
  connect(Plt.port_b1, Tsup.port_a) annotation (Line(
      points={{-40,-20.2},{-28,-20.2},{-28,-32},{-20,-32}},
      color={0,127,255},
      thickness=0.5));
annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
                                          Icon(coordinateSystem(extent={{-100,
            -80},{100,100}})),
  experiment(StopTime=208800, __Dymola_Algorithm="Dassl"));
end ParSysNoCtrl;
