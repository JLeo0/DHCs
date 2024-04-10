within DHC.Logic.PumpLogic;
model mPMP
  parameter Real m_nominal
    "Nominal mass flow rate";
  parameter Integer n_PMP "The number of pumps";
  parameter Real km[2];
  Integer n_PMP_On;
  Modelica.Blocks.Interfaces.RealInput mReqIn    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput [n_PMP] mReqOut(start = fill(0, n_PMP))
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
algorithm
   mReqOut:=fill(0, n_PMP);
   n_PMP_On :=integer(min(ceil(mReqIn/(km[2]*m_nominal)), n_PMP));
   for i in 1:n_PMP_On loop
     mReqOut[i]:=if mReqIn/n_PMP_On<km[1]*m_nominal then km[1]*m_nominal elseif
     mReqIn/n_PMP_On>km[2]*m_nominal then km[2]*m_nominal else mReqIn/n_PMP_On;
   end for;
   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-78,-110},{92,-158}},
          textColor={28,108,200},
          textString="%name"), Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-68,52},{72,-54}},
          textColor={28,108,200},
          textString="PMP")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end mPMP;
