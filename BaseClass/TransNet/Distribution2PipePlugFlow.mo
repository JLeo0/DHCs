within DHC.BaseClass.TransNet;
model Distribution2PipePlugFlow
  "Model of a two-pipe distribution network, using plug flow pipe models in the main line"
  extends DHC.BaseClass.TransNet.PartialDistribution2Pipe(redeclare
      DHC.BaseClass.TransNet.Connection2PipePlugFlow con[nCon](
      final lengthDis=lengthDis,
      final lengthCon=lengthCon,
      final v_nominalDis=v_nominalDis,
      final v_nominalCon=v_nominalCon,
      final roughness=roughness,
      final cPip=cPip,
      final rhoPip=rhoPip,
      final thickness=thickness,
      final dIns=dIns,
      final kIns=kIns), redeclare model Model_pipDis =
        Buildings.Fluid.FixedResistances.LosslessPipe);

  parameter Modelica.Units.SI.Length lengthDis[nCon]
    "Distribution Pipe length";
  parameter Modelica.Units.SI.Length lengthCon[nCon]
    "Connection Pipe length";
  parameter Modelica.Units.SI.Velocity v_nominalDis[nCon]
    "Velocity of Distribution Pipe at m_flow_nominal(used to compute default value for hydraulic diameter dh)";
  parameter Modelica.Units.SI.Velocity v_nominalCon[nCon]
    "Velocity of Connection Pipe at m_flow_nominal(used to compute default value for hydraulic diameter dh)";
  parameter Modelica.Units.SI.Height roughness[nCon]=fill(5e-3, nCon)
    "Average height of surface asperities";
  parameter Modelica.Units.SI.SpecificHeatCapacity cPip[nCon]=fill(500, nCon)
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Pipe", enable=have_pipCap));
  parameter Modelica.Units.SI.Density rhoPip[nCon](displayUnit="kg/m3")=fill(8000, nCon)
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Pipe", enable=have_pipCap));
  parameter Modelica.Units.SI.Length thickness[nCon]=fill(0.0035, nCon) "Pipe wall thickness";
  parameter Modelica.Units.SI.Length dIns[nCon]=fill(0.05, nCon)
    "Thickness of pipe insulation, used to compute R";
  parameter Modelica.Units.SI.ThermalConductivity kIns[nCon]=fill(0.028, nCon)
    "Heat conductivity of pipe insulation, used to compute R";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat transfer to or from surroundings (positive if pipe is colder than surrounding)"
    annotation (Placement(transformation(extent={{-110,20},{-90,40}}),
        iconTransformation(extent={{-140,-110},{-120,-90}})));
protected
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector theCol(final m=nCon)
    "Thermal collector" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,30})));
equation
  connect(theCol.port_b, heatPort)
    annotation (Line(points={{-80,30},{-100,30}}, color={191,0,0}));
  connect(theCol.port_a, con.heatPort) annotation (Line(points={{-60,30},{-16,30},
          {-16,6},{-10,6}}, color={191,0,0}));
  annotation (
    Documentation(
      info="<html>
<p>
This is a model of a two-pipe distribution network using
</p>
<ul>
<li>
a connection model with a plug flow pipe
model (pressure drop, heat transfer, transport delays)in the main line, and
</li>
<li>
a dummy pipe model with no hydraulic resistance and no heat loss for the end of
the distribution line (after the last connection).
</li>
</ul>
</html>",
      revisions="<html>
<ul>
<li>
January 27, 2023, by Michael Wetter:<br/>
Removed connection to itself.
</li>
<li>
January 2, 2023, by Kathryn Hinkelman:<br/>
First implementation.
</li>
</ul>
</html>"));
end Distribution2PipePlugFlow;
