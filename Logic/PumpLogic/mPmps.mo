within DHC.Logic.PumpLogic;
model mPmps "Mass flow control for primary pumps and src pumps"
  parameter Boolean PS[3]=fill(true,3) "T=Parallel,F=Series(Src side)";
  parameter Integer nPmpP[2]={3,2}
                                  "Number of primary pumps";
  parameter Modelica.Units.SI.MassFlowRate mNomPmpP[2](each min=0)
  "Nominal mass flow rate for primary pumps";
  parameter Integer nPmpSrc = 3
                               "Number of Src pumps";
  parameter Modelica.Units.SI.MassFlowRate mNomPmpSrc(min=0)
  "Nominal mass flow rate for Src pumps";
  parameter Modelica.Units.SI.Time wt=60 "Waiting time for Pumps";
  parameter Real db(min=0,max=1)=0.05 "Deadband for critical point for pumps, d*kNom";
  parameter Real km[2]={0.3,1}
                         "Mass flow ratio range for pumps";
  parameter Modelica.Units.SI.MassFlowRate mNomLdCH(min=0)
  "Nominal mass flow rate for CHs at load side";
  parameter Modelica.Units.SI.MassFlowRate mNomLdHPs1[2](min=0)
  "Nominal mass flow rate for HPs1 in Clg/Htg mode at load side";
  parameter Modelica.Units.SI.MassFlowRate mNomLdHPs2[2](min=0)
  "Nominal mass flow rate for HPs2 in Clg/Htg mode at load side";
  parameter Modelica.Units.SI.MassFlowRate mNomSrcCH(min=0)
  "Nominal mass flow rate for CHs at Src side";
  parameter Modelica.Units.SI.MassFlowRate mNomSrcHPs1[2](min=0)
  "Nominal mass flow rate for HPs1 in Clg/Htg mode at Src side";
  parameter Modelica.Units.SI.MassFlowRate mNomSrcHPs2[2](min=0)
  "Nominal mass flow rate for HPs2 in Clg/Htg mode at Src side";
  SysLogic.mTotPmp
          mTotPmpSrc
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  SysLogic.mTotPmp
          mTotPmpPri
    annotation (Placement(transformation(extent={{-60,-2},{-40,18}})));
  DHC.Logic.PumpLogic.ComEquStg mPmpSrc                annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,60})));
  DHC.Logic.PumpLogic.ComEquStg mPmpCwp                annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={70,-60})));
  DHC.Logic.PumpLogic.ComEquStg mPmpHwp                annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,0})));
  Modelica.Blocks.Interfaces.RealOutput mSrc[nPmpSrc]
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput mHwp[nPmpP[2]]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput mCwp[nPmpP[1]]
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.IntegerInput SigEqu[5] "Signal for equipments"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.MathInteger.Sum sum(nu=5) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-80,-28})));
  Buildings.Controls.OBC.CDL.Integers.GreaterEqual intGreEqu
    annotation (Placement(transformation(extent={{-56,-70},{-36,-50}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{20,-50},{40,-70}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k=0)
    annotation (Placement(transformation(extent={{-96,-78},{-76,-58}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-24,-70},{-4,-50}})));
  EquipLogic.SigSrc sigSrc
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
equation
  connect(mTotPmpPri.u, SigEqu) annotation (Line(points={{-62,8},{-80,8},{-80,0},
          {-120,0}}, color={255,127,0}));
  connect(sum.u, SigEqu)
    annotation (Line(points={{-80,-22},{-80,0},{-120,0}}, color={255,128,0}));
  connect(const.y, switch1.u3) annotation (Line(points={{39,-30},{10,-30},{10,-8},
          {18,-8}}, color={0,0,127}));
  connect(switch2.u3, const.y) annotation (Line(points={{18,-52},{10,-52},{10,-30},
          {39,-30}}, color={0,0,127}));
  connect(mTotPmpPri.y, switch2.u1) annotation (Line(points={{-39,8},{2,8},{2,-68},
          {18,-68}}, color={0,0,127}));
  connect(mTotPmpPri.y, switch1.u1)
    annotation (Line(points={{-39,8},{18,8}}, color={0,0,127}));
  connect(intGreEqu.u1, sum.y) annotation (Line(points={{-58,-60},{-68,-60},{-68,
          -42},{-80,-42},{-80,-34.9}}, color={255,127,0}));
  connect(integerConstant.y, intGreEqu.u2)
    annotation (Line(points={{-75,-68},{-58,-68}}, color={255,127,0}));
  connect(intGreEqu.y, switch1.u2) annotation (Line(points={{-34,-60},{-32,-60},
          {-32,0},{18,0}}, color={255,0,255}));
  connect(not1.y, switch2.u2)
    annotation (Line(points={{-3,-60},{18,-60}}, color={255,0,255}));
  connect(not1.u, intGreEqu.y)
    annotation (Line(points={{-26,-60},{-34,-60}}, color={255,0,255}));
  connect(sigSrc.Sig, mTotPmpSrc.u)
    annotation (Line(points={{-38,60},{-12,60}}, color={255,127,0}));
  connect(sigSrc.SigIn, SigEqu) annotation (Line(points={{-62,60},{-80,60},{-80,
          0},{-120,0}}, color={255,127,0}));
  connect(mPmpCwp.u1, not1.y) annotation (Line(points={{58,-68},{50,-68},{50,-78},
          {8,-78},{8,-70},{-3,-70},{-3,-60}}, color={255,0,255}));
  connect(mPmpHwp.u1, intGreEqu.y) annotation (Line(points={{58,8},{48,8},{48,20},
          {-32,20},{-32,-60},{-34,-60}}, color={255,0,255}));
  connect(booleanConstant.y, mPmpSrc.u1) annotation (Line(points={{11,90},{30,90},
          {30,68},{38,68}}, color={255,0,255}));
  connect(mPmpSrc.u, mTotPmpSrc.y)
    annotation (Line(points={{38,60},{11,60}}, color={0,0,127}));
  connect(mPmpSrc.y, mSrc)
    annotation (Line(points={{61,60},{110,60}}, color={0,0,127}));
  connect(mPmpHwp.u, switch1.y)
    annotation (Line(points={{58,0},{41,0}}, color={0,0,127}));
  connect(mPmpHwp.y, mHwp)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(switch2.y, mPmpCwp.u)
    annotation (Line(points={{41,-60},{58,-60}}, color={0,0,127}));
  connect(mPmpCwp.y, mCwp)
    annotation (Line(points={{81,-60},{110,-60}}, color={0,0,127}));
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
          textString="mPmps")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end mPmps;
