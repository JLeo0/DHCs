within DHCs.BaseClass.Plants;
model Pumps "Pumps"
  replaceable package Medium =Buildings.Media.Water
   constrainedby Modelica.Media.Interfaces.PartialMedium
   annotation (choicesAllMatching=true);
  parameter Integer nPmp[2]={3,2} "Number of pumps in each series";
  parameter Modelica.Units.SI.MassFlowRate mNomPmp[2] "Water pump nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dpNomPmp[2]
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
  Modelica.Blocks.Interfaces.RealInput mCwp[nPmp[1]]
    "Continuous input signal for the flow machine"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput mHwp[nPmp[2]]
    "Continuous input signal for the flow machine"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput PCwp[nPmp[1]]
    "Electrical power consumed by the pumps"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput PHwp[nPmp[2]]
    "Electrical power consumed by the pumps"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  replaceable parameter Buildings.Fluid.Movers.Data.Generic perCwp[nPmp[1]]
    annotation (Placement(transformation(extent={{-18,84},{-4,98}})));
  replaceable parameter Buildings.Fluid.Movers.Data.Generic perHwp[nPmp[2]]
    annotation (Placement(transformation(extent={{4,84},{18,98}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-114,-10},{-94,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  FlowMachine_m       HWP(
    redeclare package Medium = Medium,
    m_flow_nominal=mNomPmp[2],
    dpValve_nominal=dpNomPmp[2],
    each per=perHwp,
    num=nPmp[2])
              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,-20})));
  FlowMachine_m     CWP(
    redeclare package Medium = Medium,
    m_flow_nominal=mNomPmp[1],
    dpValve_nominal=dpNomPmp[1],
    each per=perCwp,
    num=nPmp[1])
              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,20})));
equation
  connect(CWP.port_a, port_a) annotation (Line(points={{-10,20},{-40,20},{-40,0},
          {-104,0}}, color={0,127,255},
      thickness=0.5));
  connect(HWP.port_a, port_a) annotation (Line(points={{-10,-20},{-40,-20},{-40,
          0},{-104,0}}, color={0,127,255},
      thickness=0.5));
  connect(HWP.port_b, port_b) annotation (Line(points={{10,-20},{40,-20},{40,0},
          {104,0}}, color={0,127,255},
      thickness=0.5));
  connect(CWP.port_b, port_b) annotation (Line(points={{10,20},{40,20},{40,0},{104,
          0}}, color={0,127,255},
      thickness=0.5));
  connect(mCwp, CWP.u) annotation (Line(points={{-120,80},{-40,80},{-40,24},{-12,
          24}}, color={0,0,127}));
  connect(mHwp, HWP.u) annotation (Line(points={{-120,40},{-60,40},{-60,-16},{-12,
          -16}}, color={0,0,127}));
  connect(CWP.P, PCwp) annotation (Line(points={{11,24},{40,24},{40,80},{110,80}},
        color={0,0,127}));
  connect(HWP.P, PHwp) annotation (Line(points={{11,-16},{60,-16},{60,40},{110,40}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-149,-114},{151,-154}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-60,60},{60,40}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-60,-40},{60,-60}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-100,10},{-64,-10}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-30,80},{32,20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{0,80},{0,20},{32,52},{0,80}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{4,58},{20,42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          visible=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState,
          fillColor={0,100,199}),
        Ellipse(
          extent={{-30,-20},{32,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{0,-20},{0,-80},{32,-48},{0,-20}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{4,-42},{20,-58}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          visible=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState,
          fillColor={0,100,199}),
        Rectangle(
          extent={{64,10},{100,-10}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-60,10},{60,-10}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={60,0},
          rotation=90),
        Rectangle(
          extent={{-60,10},{60,-10}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-60,0},
          rotation=90)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pumps;
