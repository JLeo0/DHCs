within DHCs.Logic.BldgLogic;
model BuiMod
  Modelica.Blocks.Interfaces.BooleanInput u_C
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.BooleanInput u_H
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.IntegerOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput u[2] "Load"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  if u[1]+u[2]>0 and u_H then
    y= 1;
  elseif u[1]+u[2]<0 and u_C then
    y= -1;
  else
    y= 0;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-76,44},{82,-42}},
          textColor={28,108,200},
          textString="BuiMod"),
        Text(
          extent={{-96,138},{98,106}},
          textColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BuiMod;
