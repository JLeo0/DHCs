within DHCs.BaseClass.Building;
model Bldg "A building, Extend from PartialBldg"
  extends Building.PartialBldg;
  parameter Real km[2]
    annotation(Dialog(group="Pump Control"));

public
  DHCs.Logic.PumpLogic.mPMP PmpCtrlH(
    m_nominal=m_flow_nominal_PMP_H,
    km=km,
    n_PMP=n_PMP_H)
    annotation (Placement(transformation(extent={{-64,12},{-80,28}})));
  DHCs.Logic.PumpLogic.mPMP PmpCtrlC(
    m_nominal=m_flow_nominal_PMP_C,
    km=km,
    n_PMP=n_PMP_C)
    annotation (Placement(transformation(extent={{-64,68},{-80,52}})));
equation
  connect(UntHtg.mReqHeaWat_flow, PmpCtrlH.mReqIn) annotation (Line(points={{53,
          -14},{60,-14},{60,20},{-62.4,20}}, color={0,0,127}));
  connect(PmpCtrlH.mReqOut, PmpH.u) annotation (Line(points={{-80.8,20},{-100,20},
          {-100,-16},{-82,-16}}, color={0,0,127}));
  connect(PmpCtrlC.mReqOut, PmpC.u) annotation (Line(points={{-80.8,60},{-100,60},
          {-100,96},{-82,96}}, color={0,0,127}));
  connect(UntClg.mReqChiWat_flow, PmpCtrlC.mReqIn) annotation (Line(points={{53,
          98},{60,98},{60,60},{-62.4,60}}, color={0,0,127}));
  annotation (experiment(
      StopTime=604800,
      __Dymola_fixedstepsize=900,
      __Dymola_Algorithm="Euler"));
end Bldg;
