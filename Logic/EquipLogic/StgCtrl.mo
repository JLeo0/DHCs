within DHC.Logic.EquipLogic;
model StgCtrl
  extends DHC.Logic.EquipLogic.PartialStgCtrl;
  parameter Real Qc[5] "Capacity in clg mode";
  parameter Real Qh[3] "Capacity in htg mode";
  parameter Boolean PS[2]={true,true}
    "T=P,F=S"
             annotation (Evaluate=true);
  StgCtrlCP stgCtrlCP(
    wt=wt,
    k=k,
    db=db,
    Q=Qc) if PS[1] annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  StgCtrlCS stgCtrlCS(
    wt=wt,
    k=k,
    db=db,
    Q=Qc) if not PS[1] annotation (Placement(transformation(extent={{-60,12},{-40,
            32}})));
  StgCtrlHP stgCtrlHP(
    wt=wt,
    k=k,
    db=db,
    Q=Qh) if PS[2] annotation (Placement(transformation(extent={{-60,-32},{-40,-12}})));
  StgCtrlHS stgCtrlHS(
    wt=wt,
    k=k,
    db=db,
    Q=Qh) if not PS[2] annotation (Placement(transformation(extent={{-60,-70},{-40,
            -50}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi[5]
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k=-1)
    annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
equation
  for i in 1:5 loop
    connect(intEqu.y, intSwi[i].u2)
    annotation (Line(points={{44,0},{58,0}}, color={255,0,255}));
  end for;
  if PS[1] then
      connect(stgCtrlCP.Sig, intSwi.u1) annotation (Line(points={{-39,60},{50,60},
            {50,8},{58,8}},
                      color={255,127,0}));
  else
      connect(stgCtrlCS.Sig, intSwi.u1) annotation (Line(points={{-39,22},{50,22},
            {50,8},{58,8}},
                      color={255,127,0}));
  end if;
    if PS[2] then
      connect(stgCtrlHP.Sig, intSwi.u3) annotation (Line(points={{-39,-22},{-20,
            -22},{-20,-48},{50,-48},{50,-8},{58,-8}},
                                               color={255,127,0}));
  else
      connect(stgCtrlHS.Sig, intSwi.u3) annotation (Line(points={{-39,-60},{50,-60},
            {50,-8},{58,-8}},                 color={255,127,0}));
    end if;
  connect(stgCtrlCP.u1, u1) annotation (Line(points={{-62,68},{-90,68},{-90,80},
          {-120,80}}, color={255,127,0}));
  connect(stgCtrlCS.u1, u1) annotation (Line(points={{-62,30},{-90,30},{-90,80},
          {-120,80}}, color={255,127,0}));
  connect(stgCtrlHP.u1, u1) annotation (Line(points={{-62,-14},{-90,-14},{-90,80},
          {-120,80}}, color={255,127,0}));
  connect(stgCtrlHS.u1, u1) annotation (Line(points={{-62,-52},{-90,-52},{-90,80},
          {-120,80}}, color={255,127,0}));
  connect(stgCtrlCP.u, u) annotation (Line(points={{-62,60},{-96,60},{-96,0},{-120,
          0}}, color={0,0,127}));
  connect(stgCtrlCS.u, u) annotation (Line(points={{-62,22},{-96,22},{-96,0},{-120,
          0}}, color={0,0,127}));
  connect(stgCtrlHP.u, u) annotation (Line(points={{-62,-22},{-96,-22},{-96,0},{
          -120,0}}, color={0,0,127}));
  connect(stgCtrlHS.u, u) annotation (Line(points={{-62,-60},{-96,-60},{-96,0},{
          -120,0}}, color={0,0,127}));
  connect(integerConstant.y, intEqu.u2) annotation (Line(points={{13,-18},{20,-18},
          {20,-8}},                   color={255,127,0}));
  connect(u1, intEqu.u1) annotation (Line(points={{-120,80},{-90,80},{-90,0},{20,
          0}}, color={255,127,0}));
  connect(intSwi.y, Sig)
    annotation (Line(points={{82,0},{110,0}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end StgCtrl;
