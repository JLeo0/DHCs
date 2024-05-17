within DHCs.Logic.SysLogic;
model mTotPmp "Total mass flow"
  parameter Integer n=5 "Number pumps";
  parameter Modelica.Units.SI.MassFlowRate mNomEqu[n,2]
  "Nominal mass flow rate";
  Modelica.Blocks.Interfaces.IntegerInput u[n]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y(start=0)
  annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Real mt[n];
equation
  for i in 1:5 loop
    mt[i] = if u[i]==-1 then mNomEqu[i,1] elseif u[i]==1 then mNomEqu[i,2] else 0;
  end for;
  y=sum(mt);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-86,-106},{86,-146}},
          textColor={28,108,200},
          textString="%name"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-86,40},{88,-40}},
          textColor={28,108,200},
          textString="mTotPmp")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end mTotPmp;
