within DHC.BaseClass;
model Connection2PipePlugFlow
  "Model for connecting an agent to a two-pipe distribution network, using plug flow pipe models in the main line"
  parameter Modelica.Units.SI.Temperature T_ini = 47+273.15 "Temperature initialization";
  extends
    DHC.BaseClass.PartialConnection2Pipe(
    redeclare model Model_pipDis =
        DHC.BaseClass.PlugFlowPipe (
      final length=length,
      final dIns=dIns,
      final kIns=kIns),
    redeclare model Model_pipCon =
        Buildings.Fluid.FixedResistances.LosslessPipe,
    pipDisSup(
      redeclare package Medium = Medium,
      roughness=roughness,
      cPip=cPip,
      rhoPip=rhoPip,
      thickness=thickness,
              T_start_in=T_ini, T_start_out=T_ini),
    pipDisRet(
      redeclare package Medium = Medium,
      roughness=roughness,
      cPip=cPip,
      rhoPip=rhoPip,
      thickness=thickness,
              T_start_in=T_ini, T_start_out=T_ini),
    junConRet(T_start=T_ini),
    junConSup(T_start=T_ini),
    pipCon(redeclare package Medium = Medium, allowFlowReversal=false),
    senDifEntFlo(redeclare package Medium2 = Medium));

  parameter Modelica.Units.SI.Length length
    "Pipe length"
    annotation (Dialog(group="Pipe"));
  parameter Modelica.Units.SI.Height roughness=5e-4
    "Average height of surface asperities"
    annotation (Dialog(group="Pipe"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cPip=500
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Pipe", enable=have_pipCap));
  parameter Modelica.Units.SI.Density rhoPip(displayUnit="kg/m3") = 8000
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Pipe", enable=have_pipCap));
  parameter Modelica.Units.SI.Length thickness=0.0035 "Pipe wall thickness"
    annotation (Dialog(group="Pipe"));
  parameter Modelica.Units.SI.Length dIns
    "Thickness of pipe insulation, used to compute R"
    annotation (Dialog(group="Pipe"));
  parameter Modelica.Units.SI.ThermalConductivity kIns
    "Heat conductivity of pipe insulation, used to compute R"
    annotation (Dialog(group="Pipe"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat transfer to or from surroundings (positive if pipe is colder than surrounding)"
    annotation (Placement(transformation(extent={{-110,60},{-90,80}})));
equation
  connect(pipDisRet.heatPort, heatPort) annotation (Line(points={{-70,-70},{-70,
          -60},{-52,-60},{-52,70},{-100,70}},
                                    color={191,0,0}));
  connect(pipDisSup.heatPort, heatPort) annotation (Line(points={{-70,-30},{-70,
          -20},{-52,-20},{-52,70},{-100,70}}, color={191,0,0}));
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
January 2, 2023, by Kathryn Hinkelman:<br/>
First implementation.
</li>
</ul>
</html>"));
end Connection2PipePlugFlow;
