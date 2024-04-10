within DHC.Logic.SysLogic;
model SysLoadHdl
  parameter Real k[2];
  Modelica.Blocks.Interfaces.RealInput u[2] "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput SysMd "system mode"
    annotation (Placement(transformation(extent={{100,60},{140,100}})));
  Modelica.Blocks.Interfaces.RealOutput SysLd " W"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  SysMd = if -1*u[1]>u[2] and -1*u[1]>k[1] then -1 elseif -1*u[1]<u[2] and u[2]>k[2] then 1 else 0;
  SysLd = if SysMd==-1 then u[1] elseif SysMd==1 then u[2] else 0;
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
          extent={{-100,164},{86,112}},
          textColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SysLoadHdl;
