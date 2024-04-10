within DHC.Logic.BldgLogic;
model LdHdl
  parameter Real k_C annotation (Dialog(group="Contrl"));
  parameter Real k_H  annotation (Dialog(group="Contrl"));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(extent={{-12,48},{8,68}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply Mul
    annotation (Placement(transformation(extent={{50,32},{70,52}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y[2]
    annotation (Placement(transformation(extent={{100,-100},{140,-60}})));
  Modelica.Blocks.Interfaces.RealInput u[2] "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter UnitChange1[2](each k=
        1000)
    annotation (Placement(transformation(extent={{-88,-4},{-78,6}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2(threshold=k_H)
    annotation (Placement(transformation(extent={{-52,-26},{-32,-6}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal2
    annotation (Placement(transformation(extent={{-14,-26},{6,-6}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply Mul1
    annotation (Placement(transformation(extent={{48,-44},{68,-24}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=k_C)
    annotation (Placement(transformation(extent={{-54,48},{-34,68}})));
  BldgLogic.BuiMod modeDecide
    annotation (Placement(transformation(extent={{14,4},{34,24}})));
  Modelica.Blocks.Interfaces.IntegerOutput y_Mode "1=htg, -1=clg, 0=none"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(booleanToReal1.y, Mul.u1) annotation (Line(points={{9,58},{40,58},{40,
          48},{48,48}},    color={0,0,127}));
  connect(u, UnitChange1.u) annotation (Line(points={{-120,0},{-118,0},{-118,1},
          {-89,1}}, color={0,0,127}));
  connect(greaterThreshold2.y,booleanToReal2. u)
    annotation (Line(points={{-31,-16},{-16,-16}},
                                                color={255,0,255}));
  connect(booleanToReal2.y, Mul1.u1) annotation (Line(points={{7,-16},{38,-16},
          {38,-28},{46,-28}}, color={0,0,127}));
  connect(lessThreshold.y, booleanToReal1.u)
    annotation (Line(points={{-33,58},{-14,58}},        color={255,0,255}));
  connect(lessThreshold.u, UnitChange1[1].y) annotation (Line(points={{-56,58},
          {-64,58},{-64,1},{-77,1}},color={0,0,127}));
  connect(UnitChange1[2].y, greaterThreshold2.u) annotation (Line(points={{-77,1},
          {-64,1},{-64,-16},{-54,-16}}, color={0,0,127}));
  connect(UnitChange1[1].y, Mul.u2) annotation (Line(points={{-77,1},{-64,1},{
          -64,36},{48,36}},
                        color={0,0,127}));
  connect(UnitChange1[2].y, Mul1.u2) annotation (Line(points={{-77,1},{-64,1},{
          -64,-40},{46,-40}},
                          color={0,0,127}));
  connect(Mul1.y, y[2]) annotation (Line(points={{70,-34},{76,-34},{76,-80},{
          104,-80},{104,-75},{120,-75}}, color={0,0,127}));
  connect(Mul.y, y[1]) annotation (Line(points={{72,42},{76,42},{76,-80},{112,
          -80},{112,-85},{120,-85}}, color={0,0,127}));
  connect(lessThreshold.y, modeDecide.u_C) annotation (Line(points={{-33,58},{
          -22,58},{-22,20},{12,20}},                        color={255,0,255}));
  connect(greaterThreshold2.y, modeDecide.u_H) annotation (Line(points={{-31,-16},
          {-24,-16},{-24,8},{12,8}},                 color={255,0,255}));
  connect(UnitChange1.y, modeDecide.u) annotation (Line(points={{-77,1},{-64,1},
          {-64,14},{12,14}},                     color={0,0,127}));
  connect(modeDecide.y, y_Mode)
    annotation (Line(points={{35,14},{66,14},{66,0},{110,0}},
                                                  color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,22},{26,2},{-20,-18}},
          thickness=0.5),
        Text(
          extent={{-90,-112},{96,-164}},
          textColor={0,127,255},
          textString="%name"),
        Text(
          extent={{-106,162},{102,108}},
          textColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LdHdl;
