within DHC.BaseClass.TransNet;
model Connection2PipePlugFlow
  "Model for connecting an agent to a two-pipe distribution network, using plug flow pipe models in the main line"
  extends DHC.BaseClass.TransNet.PartialConnection2Pipe(
    redeclare model Model_pipDisSup =
        Buildings.Fluid.FixedResistances.PlugFlowPipe (
        final length=lengthDis,
        final v_nominal=v_nominalDis,
        final roughness=roughness,
        final cPip=cPip,
        final rhoPip=rhoPip,
        final thickness=thickness,
        final dIns=dIns,
        final kIns=kIns),
    redeclare model Model_pipDisRet =
        Buildings.Fluid.FixedResistances.PlugFlowPipe (
        final length=lengthDis,
        final v_nominal=v_nominalDis,
        final roughness=roughness,
        final cPip=cPip,
        final rhoPip=rhoPip,
        final thickness=thickness,
        final dIns=dIns,
        final kIns=kIns),
    redeclare model Model_pipConSup =
        Buildings.Fluid.FixedResistances.PlugFlowPipe (
        final length=lengthCon,
        final v_nominal=v_nominalCon,
        final roughness=roughness,
        final cPip=cPip,
        final rhoPip=rhoPip,
        final thickness=thickness,
        final dIns=dIns,
        final kIns=kIns),
    redeclare model Model_pipConRet =
        Buildings.Fluid.FixedResistances.PlugFlowPipe (
        final length=lengthCon,
        final v_nominal=v_nominalCon,
        final roughness=roughness,
        final cPip=cPip,
        final rhoPip=rhoPip,
        final thickness=thickness,
        final dIns=dIns,
        final kIns=kIns));
  parameter Modelica.Units.SI.Length lengthDis
    "Distribution Pipe length";
  parameter Modelica.Units.SI.Length lengthCon
    "Connection Pipe length";
  parameter Modelica.Units.SI.Velocity v_nominalDis=v_nominalDis
    "Velocity of Distribution Pipe at m_flow_nominal(used to compute default value for hydraulic diameter dh)";
  parameter Modelica.Units.SI.Velocity v_nominalCon=v_nominalCon
    "Velocity of Connection Pipe at m_flow_nominal(used to compute default value for hydraulic diameter dh)";
  parameter Modelica.Units.SI.Height roughness
    "Average height of surface asperities";
  parameter Modelica.Units.SI.SpecificHeatCapacity cPip
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Pipe", enable=have_pipCap));
  parameter Modelica.Units.SI.Density rhoPip(displayUnit="kg/m3")
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Pipe", enable=have_pipCap));
  parameter Modelica.Units.SI.Length thickness "Pipe wall thickness";
  parameter Modelica.Units.SI.Length dIns
    "Thickness of pipe insulation, used to compute R";
  parameter Modelica.Units.SI.ThermalConductivity kIns
    "Heat conductivity of pipe insulation, used to compute R";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat transfer to or from surroundings (positive if pipe is colder than surrounding)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
equation
  connect(pipDisRet.heatPort, heatPort) annotation (Line(points={{-70,-70},{-70,
          -60},{-52,-60},{-52,-10},{-70,-10},{-70,60},{-100,60}},
                                    color={191,0,0}));
  connect(pipDisSup.heatPort, heatPort) annotation (Line(points={{-70,-30},{-70,
          60},{-100,60}},                     color={191,0,0}));
  connect(pipConSup.heatPort, heatPort) annotation (Line(points={{-30,-10},{-70,
          -10},{-70,60},{-100,60}}, color={191,0,0}));
  connect(pipConRet.heatPort, heatPort) annotation (Line(points={{10,-10},{0,
          -10},{0,20},{-70,20},{-70,60},{-100,60}},
                                               color={191,0,0}));
  annotation (
    Documentation(
      info="<html>
<p>
This is a model of a connection with a two-pipe distribution network using 
a plug flow pipe model that includes pressure drop, heat transfer, and transport
delays.
</p>
<p>
The plug flow pipe model is used in the main distribution line,
but not in the connection to the building, as the latter is typically short.
</p>
</html>",
      revisions="<html>
<ul>
<li>
June 14, 2023, by David Blum:<br/>
Fix redeclare of dis pipe models in connections.
</li>
<li>
January 2, 2023, by Kathryn Hinkelman:<br/>
First implementation.
</li>
</ul>
</html>"));
end Connection2PipePlugFlow;
