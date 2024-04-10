within DHC.Logic.EquipLogic;
model SigSrc
  "StgCtrl output Signal"
  parameter Boolean PS[3] "T=P,F=S";
  Modelica.Blocks.Interfaces.IntegerInput SigIn[5]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput Sig[5]
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
equation
    if PS[1]==false and PS[2]==true then
      Sig[1]= SigIn[1];
      Sig[2]= 0;
      Sig[3]= SigIn[3];
      Sig[4]= SigIn[4];
      Sig[5]= SigIn[5];
    elseif PS[1]==true and PS[2]==false then
      Sig[1]= SigIn[1];
      Sig[2]= SigIn[2];
      Sig[3]= SigIn[3];
      Sig[4]= 0;
      Sig[5]= SigIn[5];
    elseif PS[1]==false and PS[2]==false then
      Sig[1]= SigIn[1];
      Sig[2]= 0;
      Sig[3]= SigIn[3];
      Sig[4]= 0;
      Sig[5]= SigIn[5];
    else
      Sig= SigIn;
    end if;
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
          extent={{-86,40},{88,-40}},
          textColor={28,108,200},
          textString="Sig")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SigSrc;
