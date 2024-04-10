within DHC.Logic.SysLogic;
model PltLgc "Plant control Logic"

  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium" annotation (choicesAllMatching=true);
  parameter Integer nBui=3 "Number of Buildings"
  annotation(Dialog(group="Bldg"));
  parameter Boolean QTotMd=true  "T=Measured value, F=External value,only for debug"
  annotation(Dialog(group="Bldg"));
  parameter Modelica.Units.SI.HeatFlowRate QClgNom[nBui](max=0)
  "Design Clg Load of each Bldg"
                                annotation(Dialog(group="Bldg"));
  parameter Modelica.Units.SI.HeatFlowRate QHtgNom[nBui](min=0)
  "Design Clg Load of each Bldg"
                                annotation(Dialog(group="Bldg"));
  parameter Integer nPmpP[2]      "Number of primary pumps"
  annotation(Dialog(group="Pmp"));
  parameter Modelica.Units.SI.MassFlowRate mNomPmpP[2](each min=0)
  "Nominal mass flow rate for primary pumps"
                                            annotation(Dialog(group="Pmp"));
  parameter Integer nPmpSrc    "Number of Src pumps"
  annotation(Dialog(group="Pmp"));
  parameter Modelica.Units.SI.MassFlowRate mNomPmpSrc(min=0)
  "Nominal mass flow rate"
                          annotation(Dialog(group="Pmp"));
  parameter Modelica.Units.SI.Time tWP "Waiting time"
                                                     annotation(Dialog(group="Pmp"));
  parameter Real d(min=0,max=1) "Deadband"
                                          annotation(Dialog(group="Pmp"));
  parameter Real km[2]        "ratio range"
  annotation(Dialog(group="Pmp"));
  parameter Boolean PS[3] "T=Parallel,F=Series"
  annotation(Dialog(group="CH&HP"));
  parameter Real Qc[5] "Capacity in clg mode"
  annotation(Dialog(group="CH&HP"));
  parameter Real Qh[3] "Capacity in htg mode"
  annotation(Dialog(group="CH&HP"));
  parameter Modelica.Units.SI.MassFlowRate mNomLdCH(min=0)
  "Nominal mass flow rate for CHs at load side"
  annotation(Dialog(group="CH&HP"));
  parameter Modelica.Units.SI.MassFlowRate mNomLdHPs1[2](min=0)
  "Nominal mass flow rate for HPs1 in Clg/Htg mode at load side"
  annotation(Dialog(group="CH&HP"));
  parameter Modelica.Units.SI.MassFlowRate mNomLdHPs2[2](min=0)
  "Nominal mass flow rate for HPs2 in Clg/Htg mode at load side"
  annotation(Dialog(group="CH&HP"));
  parameter Modelica.Units.SI.MassFlowRate mNomSrcCH(min=0)
  "Nominal mass flow rate for CHs at Src side"
  annotation(Dialog(group="CH&HP"));
  parameter Modelica.Units.SI.MassFlowRate mNomSrcHPs1[2](min=0)
  "Nominal mass flow rate for HPs1 in Clg/Htg mode at Src side"
  annotation(Dialog(group="CH&HP"));
  parameter Modelica.Units.SI.MassFlowRate mNomSrcHPs2[2](min=0)
  "Nominal mass flow rate for HPs2 in Clg/Htg mode at Src side"
  annotation(Dialog(group="CH&HP"));
  parameter Modelica.Units.SI.Time wt "Waiting time for CH or HP"
  annotation(Dialog(group="CH&HP"));
  parameter Real k "Min ratio"
  annotation(Dialog(group="CH&HP"));
  parameter Real db "Dead band"
  annotation(Dialog(group="CH&HP"));
  Modelica.Blocks.Interfaces.RealInput Ld[nBui,2]
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Math.Sum QTot[2]
    "Total cooling and heating flow rate for all buildings "
    annotation (Placement(transformation(extent={{-90,80},{-70,100}})));
  Modelica.Blocks.Logical.Switch QTotSwi "Qneed in clg and htg mode"
    annotation (Placement(transformation(extent={{-30,-6},{-10,-26}})));
  Modelica.Blocks.Sources.BooleanExpression QTotMode(y=QTotMd)
    "true=Measured value"
    annotation (Placement(transformation(extent={{-68,-24},{-52,-8}})));
  SysLoadHdl sysLoadHdl
    annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
  Modelica.Blocks.Math.IntegerToReal intToReal
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,30})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{6,-10},{26,10}})));
  DHC.Logic.EquipLogic.StgCtrl stgCtrl
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput SigEqu[5] "Signal"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput mSrc[nPmpSrc]
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput mHwp[nPmpP[2]]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput mCwp[nPmpP[1]]
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Math.Product pro
    "Product"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-62,-40})));
  Modelica.Blocks.Math.Add dT(final k1=-1, final k2=+1)
    "Temperature difference"
    annotation (Placement(transformation(extent={{-84,14},{-64,34}})));
  Modelica.Blocks.Interfaces.RealInput TRet
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,30})));
  Modelica.Blocks.Interfaces.RealInput mFlow
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-90})));
  Modelica.Blocks.Interfaces.RealInput TSup
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-30})));
  Buildings.Controls.OBC.CDL.Routing.IntegerScalarReplicator rep(final nout=
        nBui) "Replicate"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Modelica.Blocks.Interfaces.IntegerOutput Sys[nBui]
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  PumpLogic.mPmps mPmps(
    PS=PS,
    nPmpP=nPmpP,
    mNomPmpP=mNomPmpP,
    nPmpSrc=nPmpSrc,
    mNomPmpSrc=mNomPmpSrc,
    wt=tWP,
    db=d,
    km=km,
    mNomLdCH=mNomLdCH,
    mNomLdHPs1=mNomLdHPs1,
    mNomLdHPs2=mNomLdHPs2,
    mNomSrcCH=mNomSrcCH,
    mNomSrcHPs1=mNomSrcHPs1,
    mNomSrcHPs2=mNomSrcHPs2)
    annotation (Placement(transformation(extent={{68,-10},{88,10}})));
  Modelica.Blocks.Math.Gain QndMea(final k=cp_default)
    "Qneed from measured data."
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-86,-70})));
protected
  final parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default)
    "Medium state at default properties";
  final parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";
equation
  for i in 1:2 loop
     for j in 1:nBui loop
        connect(Ld[j,i], QTot[i].u[j])
                                     annotation (Line(points={{-120,90},{-92,90}},    color={0,0,127}));
     end for;
  end for;
  connect(QTotMode.y, QTotSwi.u2) annotation (Line(points={{-51.2,-16},{-32,-16}},
                                color={255,0,255}));
  connect(QTot.y, sysLoadHdl.u)
    annotation (Line(points={{-69,90},{-66,90},{-66,72},{-60,72}},
                                                     color={0,0,127}));
  connect(QTotSwi.u3, sysLoadHdl.SysLd) annotation (Line(points={{-32,-8},{-32,
          72},{-37,72}},              color={0,0,127}));
  connect(sysLoadHdl.SysMd, intToReal.u) annotation (Line(points={{-36,80},{-10,
          80},{-10,42}},             color={255,127,0}));
  connect(QTotSwi.y, product.u2)
    annotation (Line(points={{-9,-16},{-4,-16},{-4,-6},{4,-6}},
                                                  color={0,0,127}));
  connect(product.u1, intToReal.y) annotation (Line(points={{4,6},{-10,6},{-10,
          19}},                color={0,0,127}));
  connect(sysLoadHdl.SysMd, stgCtrl.u1) annotation (Line(points={{-36,80},{-10,
          80},{-10,60},{30,60},{30,8},{34,8}},
                                  color={255,127,0}));
  connect(stgCtrl.u, product.y)
    annotation (Line(points={{34,0},{27,0}},     color={0,0,127}));
  connect(TRet,dT. u1)
    annotation (Line(points={{-120,30},{-86,30}},          color={0,0,127}));
  connect(TSup, dT.u2) annotation (Line(points={{-120,-30},{-94,-30},{-94,18},{
          -86,18}},    color={0,0,127}));
  connect(pro.u1, dT.y)
    annotation (Line(points={{-74,-34},{-80,-34},{-80,6},{-58,6},{-58,24},{-63,
          24}},                                      color={0,0,127}));
  connect(sysLoadHdl.SysMd, rep.u) annotation (Line(points={{-36,80},{58,80}},
                               color={255,127,0}));
  connect(Sys, rep.y)
    annotation (Line(points={{110,80},{82,80}}, color={255,127,0}));
  connect(SigEqu, stgCtrl.Sig) annotation (Line(points={{110,-80},{60,-80},{60,
          0},{57,0}},     color={255,127,0}));
  connect(stgCtrl.Sig, mPmps.SigEqu)
    annotation (Line(points={{57,0},{66,0}}, color={255,127,0}));
  connect(mPmps.mSrc, mSrc) annotation (Line(points={{89,6},{94,6},{94,40},{110,
          40}}, color={0,0,127}));
  connect(mPmps.mHwp, mHwp)
    annotation (Line(points={{89,0},{110,0}}, color={0,0,127}));
  connect(mPmps.mCwp, mCwp) annotation (Line(points={{89,-6},{94,-6},{94,-40},{
          110,-40}}, color={0,0,127}));
  connect(mFlow, QndMea.u) annotation (Line(points={{-120,-90},{-86,-90},{-86,
          -77.2}}, color={0,0,127}));
  connect(QndMea.y, pro.u2) annotation (Line(points={{-86,-63.4},{-86,-46},{-74,
          -46}}, color={0,0,127}));
  connect(QTotSwi.u1, pro.y) annotation (Line(points={{-32,-24},{-46,-24},{-46,
          -40},{-51,-40}}, color={0,0,127}));
    annotation (
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={                                                                   Text(
          extent={{-100,-100},{98,-140}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
  Polygon(
    origin={1.3835,-4.1418},
    rotation=45.0,
    fillColor={64,64,64},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
    points={{-15.0,93.333},{-15.0,68.333},{0.0,58.333},{15.0,68.333},{15.0,93.333},{20.0,93.333},{25.0,83.333},{25.0,58.333},{10.0,43.333},{10.0,-41.667},{25.0,-56.667},{25.0,-76.667},{10.0,-91.667},{0.0,-91.667},{0.0,-81.667},{5.0,-81.667},{15.0,-71.667},{15.0,-61.667},{5.0,-51.667},{-5.0,-51.667},{-15.0,-61.667},{-15.0,-71.667},{-5.0,-81.667},{0.0,-81.667},{0.0,-91.667},{-10.0,-91.667},{-25.0,-76.667},{-25.0,-56.667},{-10.0,-41.667},{-10.0,43.333},{-25.0,58.333},{-25.0,83.333},{-20.0,93.333}}),
  Polygon(
    origin={10.1018,5.218},
    rotation=-45.0,
    fillColor={255,255,255},
    fillPattern=FillPattern.Solid,
    points={{-15.0,87.273},{15.0,87.273},{20.0,82.273},{20.0,27.273},{10.0,17.273},{10.0,7.273},
    {20.0,2.273},{20.0,-2.727},{5.0,-2.727},{5.0,-77.727},{10.0,-87.727},{5.0,-112.727},{-5.0,-112.727},{-10.0,-87.727},{-5.0,-77.727},{-5.0,-2.727},{-20.0,-2.727},{-20.0,2.273},{-10.0,7.273},{-10.0,17.273},{-20.0,27.273},{-20.0,82.273}}),
    Text(extent={{48,90},{-46,56}},
          textColor={255,0,0},
          textString=DynamicSelect("", String(sysLoadHdl.SysMd)))}),                     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end PltLgc;
