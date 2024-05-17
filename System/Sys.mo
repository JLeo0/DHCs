within DHCs.System;
model Sys
  extends ParSysNoCtrl;
  Logic.SysLogic.PltLgc Logic
    annotation (Placement(transformation(extent={{-40,46},{-60,68}})));
  Modelica.Blocks.Sources.RealExpression Tset annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,-62})));
equation
  connect(Logic.mFlow, mSup.m_flow) annotation (Line(points={{-38,47.1},{-32,
          47.1},{-32,-1.6}}, color={0,0,127}));
  connect(Logic.Ld, Bldg.Load) annotation (Line(points={{-38,66.9},{68,66.9},{
          68,59.4286},{60.7143,59.4286}}, color={0,0,127}));
  connect(Logic.mCwp, Plant.mCwp) annotation (Line(points={{-61,52.6},{-78,52.6},
          {-78,-26.8},{-64.2,-26.8}}, color={0,0,127}));
  connect(Plant.mHwp, Logic.mHwp) annotation (Line(points={{-64.2,-31.2},{-82,-31.2},
          {-82,57},{-61,57}}, color={0,0,127}));
  connect(Logic.mSrc, Source.mSrc) annotation (Line(points={{-61,61.4},{-86,
          61.4},{-86,-72},{-62,-72}}, color={0,0,127}));
  connect(Logic.SigEqu, Plant.on) annotation (Line(points={{-61,48.2},{-74,48.2},
          {-74,-22.4},{-64.2,-22.4}}, color={255,127,0}));
  connect(Logic.TRet, Tret.T) annotation (Line(points={{-38,60.3},{-4,60.3},{-4,
          -1.6}}, color={0,0,127}));
  connect(Tsup.T, Logic.TSup) annotation (Line(points={{-16,-27.6},{-16,53.7},{
          -38,53.7}}, color={0,0,127}));
  connect(Logic.Sys, Bldg.yMdSys) annotation (Line(points={{-61,65.8},{-86,65.8},
          {-86,76},{20,76},{20,55.7143},{39,55.7143}}, color={255,127,0}));
  connect(Plant.TSet, Tset.y) annotation (Line(points={{-64.2,-34.5},{-92,-34.5},
          {-92,-51}}, color={0,0,127}));
  annotation (experiment(StopTime=208800, __Dymola_Algorithm="Dassl"));
end Sys;
