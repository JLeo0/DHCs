within DHC.BaseClass;
model BuiUnit "A building and its branches, Extend from PartialBuiUnit"
  extends PartialBuiUnit;
  parameter Boolean sPmpCtrlMd=true "Secondary Pmp Ctrl,True=Keep one on，False=Frequent on and off"
  annotation(Dialog(group="Pump Control"));
  parameter Modelica.Units.SI.Time tWP=60 "Waiting time for pump"
  annotation(Dialog(group="Pump Control"));
  parameter Real kmin=0.3
    "Min ratio, kmin*kNom"
    annotation(Dialog(group="Pump Control"));
  parameter Real kmax=1.1
    "Max ratio, kmax*kNom"
    annotation(Dialog(group="Pump Control"));
  parameter Real k1=0.6
    "Min ratio in high efficiency range, k1*kNom"
    annotation(Dialog(group="Pump Control"));
  parameter Real k2=0.9
    "Max ratio in hign efficiency range, k2*kNom"
    annotation(Dialog(group="Pump Control"));
  parameter Real d=0.05
    "Deadband for critical point, d*m_flow_nominal"
    annotation(Dialog(group="Pump Control"));

  Modelica.Fluid.Interfaces.FluidPort_a Inlet(redeclare package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-50,-130},{-30,-110}}),
        iconTransformation(extent={{-50,-130},{-30,-110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Outlet(redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{30,-130},{50,-110}}),
        iconTransformation(extent={{30,-130},{50,-110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1
    "Heat transfer to or from surroundings (positive if pipe is colder than surrounding)"
    annotation (Placement(transformation(extent={{-116,-2},{-96,18}}),
        iconTransformation(extent={{-116,-2},{-96,18}})));
  Logic.PmpSpdCtrlWithBug PmpCtrlH(
    PmpCtrlMd=sPmpCtrlMd,
    k=1,
    n_PMP=n_PMP_H,
    tWP=tWP,
    m_flow_nominal=m_flow_nominal_PMP_H,
    kmin=kmin,
    kmax=kmax,
    k1=k1,
    k2=k2,
    d=d)   annotation (Placement(transformation(extent={{40,-64},{24,-48}})));
  Logic.PmpSpdCtrlWithBug PmpCtrlC(
    PmpCtrlMd=sPmpCtrlMd,
    k=-1,
    n_PMP=n_PMP_C,
    tWP=tWP,
    m_flow_nominal=m_flow_nominal_PMP_C,
    kmin=kmin,
    kmax=kmax,
    k1=k1,
    k2=k2,
    d=d)   annotation (Placement(transformation(extent={{48,64},{32,80}})));
equation
  connect(Tinlet.port_a, Inlet) annotation (Line(points={{-92,-90},{-92,-120},{
          -40,-120}},                      color={0,127,255}));
  connect(Toutlet.port_b, Outlet) annotation (Line(points={{84,-90},{84,-120},{
          40,-120}},        color={0,127,255}));
  connect(FlowPipe1.heatPort, heatPort1)
    annotation (Line(points={{-102,-12},{-106,-12},{-106,8}},color={191,0,0}));
  connect(FlowPipe2.heatPort, heatPort1) annotation (Line(points={{94,-52},{100,
          -52},{100,-100},{-126,-100},{-126,8},{-106,8}},       color={191,0,0}));
  connect(heatPort1, heatPort1)
    annotation (Line(points={{-106,8},{-106,8}}, color={191,0,0}));
  connect(HtgUnit.mReqHeaWat_flow, PmpCtrlH.ReqMasFlo) annotation (Line(points={{55,-20},
          {60,-20},{60,-56},{41.76,-56}},                        color={0,0,127}));
  connect(PmpCtrlH.y, PMP_H.u) annotation (Line(points={{23.2,-56},{-12,-56},{
          -12,-22},{-8,-22}},           color={0,0,127}));
  connect(PmpCtrlC.ReqMasFlo, ClgUnit.mReqChiWat_flow) annotation (Line(points={{49.76,
          72},{58,72},{58,44},{55,44}},        color={0,0,127}));
  connect(PmpCtrlC.y, PMP_C.u) annotation (Line(points={{31.2,72},{-18,72},{-18,
          50},{-8,50}},               color={0,0,127}));
  connect(IntExp.y, PmpCtrlH.u) annotation (Line(points={{0.8,10},{20,10},{20,
          -42},{50,-42},{50,-48},{41.6,-48}}, color={255,127,0}));
  connect(IntExp.y, PmpCtrlC.u) annotation (Line(points={{0.8,10},{20,10},{20,
          84},{58,84},{58,80},{49.6,80}}, color={255,127,0}));
  annotation (experiment(
      StopTime=604800,
      __Dymola_fixedstepsize=900,
      __Dymola_Algorithm="Euler"));
end BuiUnit;
