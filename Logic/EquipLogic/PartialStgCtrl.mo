within DHCs.Logic.EquipLogic;
partial model PartialStgCtrl "Partial mode for StgCtrl"
  parameter Modelica.Units.SI.Time wt "Waiting time";
  parameter Real k "Min ratio";
  parameter Real db "Dead band";
  Modelica.Blocks.Interfaces.IntegerInput u1
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput Sig[5] "Signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-86,-106},{86,-146}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-90,44},{84,-36}},
          textColor={28,108,200},
          textString="Stg")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialStgCtrl;
