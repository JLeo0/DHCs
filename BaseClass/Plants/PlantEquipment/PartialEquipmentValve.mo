within DHCs.BaseClass.Plants.PlantEquipment;
partial model PartialEquipmentValve
  "Partial equipment model with associated valves"
  extends DHCs.BaseClass.Plants.PlantEquipment.PartialPlantEquipmentInterface;
  extends
    Buildings.Applications.DataCenters.ChillerCooled.Equipment.BaseClasses.ValvesParameters(
    final numVal = 2,
    final m_flow_nominal = {m1_flow_nominal,m2_flow_nominal},
    rhoStd = {Medium1.density_pTX(101325, 273.15+4, Medium1.X_default),
            Medium2.density_pTX(101325, 273.15+4, Medium2.X_default)},
    final deltaM=deltaM1);
  constant Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(HideResult=true);
  // Isolation valve parameters
  parameter Real l[2](each min=1e-10, each max=1) = {0.0001,0.0001}
    "Valve leakage, l=Kv(y=0)/Kv(y=1)"
    annotation(Dialog(group="Two-way valve"));
  // Signal Filter Parameter
  parameter Boolean use_inputFilter=false
    "= true, if opening is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(tab="Dynamics", group="Filtered opening"));
  parameter Modelica.Units.SI.Time riseTimeValve=30
    "Rise time of the filter (time to reach 99.6 % of an opening step)"
    annotation (Dialog(
      tab="Dynamics",
      group="Filtered opening",
      enable=use_inputFilter));
  parameter Modelica.Blocks.Types.Init initValve=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
  parameter Real yValve_start=0
    "Initial value of output:0-closed, 1-fully opened"
    annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare each replaceable package Medium = Medium2,
    each final allowFlowReversal=allowFlowReversal2,
    each final m_flow_nominal=m2_flow_nominal,
    each dpFixed_nominal=dp2_nominal,
    each final show_T=show_T,
    each final homotopyInitialization=homotopyInitialization,
    each final riseTime=riseTimeValve,
    each final init=initValve,
    each final use_inputFilter=false,
    each final deltaM=deltaM2,
    each final l=l[2],
    final y_start=yValve_start,
    each final CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
    each final from_dp=from_dp2,
    each final linearized=linearizeFlowResistance2,
    each final rhoStd=rhoStd[2],
    each final dpValve_nominal=dpValve_nominal[2])
    "Isolation valves on medium 2 side for on/off use" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-32})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare each replaceable package Medium = Medium1,
    each final allowFlowReversal=allowFlowReversal1,
    each final m_flow_nominal=m1_flow_nominal,
    each dpFixed_nominal=dp1_nominal,
    each final show_T=show_T,
    each final homotopyInitialization=homotopyInitialization,
    each final use_inputFilter=false,
    each final riseTime=riseTimeValve,
    each final init=initValve,
    final y_start=yValve_start,
    each final deltaM=deltaM1,
    each final l=l[1],
    each final dpValve_nominal=dpValve_nominal[1],
    each final CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
    each final from_dp=from_dp1,
    each final linearized=linearizeFlowResistance1,
    each final rhoStd=rhoStd[1])
    "Isolation valves on medium 1 side for on/off use" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={40,32})));
  Modelica.Blocks.Interfaces.RealOutput P
    "Electric power consumed by chiller or heat pump compressor"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealInput TSet
    "Set point for leaving water temperature"
    annotation (Placement(transformation(extent={{-140,
            -40},{-100,0}}),
      iconTransformation(extent={{-140,-40},{-100,
            0}})));

  Modelica.Blocks.Interfaces.IntegerInput on
    "Equipment signal,-1=clg,1=htg,0=off"
    annotation (Placement(transformation(extent={{-140,64},{-100,104}}),
        iconTransformation(extent={{-140,64},{-100,104}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Tb1(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal) "Temperature" annotation (
      Placement(transformation(
        extent={{-5,-6},{5,6}},
        rotation=0,
        origin={71,60})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Tb2(redeclare package Medium =
        Medium2, m_flow_nominal=m2_flow_nominal) "Temperature" annotation (
      Placement(transformation(
        extent={{5,-6},{-5,6}},
        rotation=0,
        origin={-69,-60})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Ta1(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal) "Temperature" annotation (
      Placement(transformation(
        extent={{-5,-6},{5,6}},
        rotation=0,
        origin={-71,60})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Ta2(redeclare package Medium =
        Medium2, m_flow_nominal=m2_flow_nominal) "Temperature" annotation (
      Placement(transformation(
        extent={{5,-6},{-5,6}},
        rotation=0,
        origin={71,-60})));
  Modelica.Blocks.Interfaces.RealOutput Q(each final quantity="Power", each final
            unit="W")
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
protected
  Modelica.Blocks.Continuous.Filter filter(
    each order=2,
    each f_cut=5/(2*Modelica.Constants.pi*riseTimeValve),
    each final init=initValve,
    final y_start=yValve_start,
    each final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    each final filterType=Modelica.Blocks.Types.FilterType.LowPass,
    x(each stateSelect=StateSelect.always))  if use_inputFilter
    "Second order filters to approximate valve opening time, and to improve numerics"
    annotation (Placement(transformation(extent={{-54,78},{-42,90}})));
protected
  Modelica.Blocks.Interfaces.RealOutput y_actual "Actual valve position"
    annotation (Placement(transformation(extent={{-30,66},{-14,82}})));
  Modelica.Blocks.Interfaces.RealOutput y_filtered if use_inputFilter
    "Filtered valve positions in the range 0..1"
    annotation (Placement(transformation(extent={{-30,76},{-14,92}}),
        iconTransformation(extent={{60,50},{80,70}})));
initial equation
  assert(homotopyInitialization, "In " + getInstanceName() +
    ": The constant homotopyInitialization has been modified from its default value. This constant will be removed in future releases.",
    level = AssertionLevel.warning);
equation
  connect(y_actual, val1.y)
    annotation (Line(points={{-22,74},{20,74},{20,32},{28,32}},
                           color={0,0,127}));
  connect(y_actual, val2.y)
    annotation (Line(points={{-22,74},{-20,74},{-20,-32},{-28,-32}},
                                                            color={0,0,127}));
 connect(filter.y,y_filtered)
   annotation (Line(points={{-41.4,84},{-22,84}},
      color={0,0,127}));
   connect(filter.y,y_actual)
     annotation (Line(points={{-41.4,84},{-36,84},{-36,74},{-22,74}},
       color={0,0,127}));
  connect(val1.port_b, Tb1.port_a) annotation (Line(
      points={{40,42},{40,60},{66,60}},
      color={0,127,255},
      thickness=0.5));
  connect(Tb1.port_b, port_b1) annotation (Line(
      points={{76,60},{100,60}},
      color={0,127,255},
      thickness=0.5));
  connect(val2.port_b, Tb2.port_a) annotation (Line(
      points={{-40,-42},{-40,-60},{-64,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(Tb2.port_b, port_b2) annotation (Line(
      points={{-74,-60},{-100,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(Ta1.port_a, port_a1) annotation (Line(
      points={{-76,60},{-100,60}},
      color={0,127,255},
      thickness=0.5));
  connect(Ta2.port_a, port_a2) annotation (Line(
      points={{76,-60},{100,-60}},
      color={0,127,255},
      thickness=0.5));
 annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Text(extent={{66,6},{116,-8}},    textString="P",
          textColor={0,0,127}),
        Text(extent={{-108,-24},{-62,-36}},
          textColor={0,0,127},
          textString="TSet"),
        Rectangle(
          extent={{-99,-54},{102,-66}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-66},{0,-54}},
          lineColor={0,0,127},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-104,66},{98,54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,54},{98,66}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,52},{-40,12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,70},{58,52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-42,2},{-52,12},{-32,12},{-42,2}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-42,2},{-52,-10},{-32,-10},{-42,2}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,-10},{-40,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{38,52},{42,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,-50},{58,-68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{18,24},{62,-18}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,24},{22,-8},{58,-8},{40,24}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{-110,96},{-64,84}},
          textColor={0,0,127},
          textString="on")}));
end PartialEquipmentValve;
