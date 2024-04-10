within DHC.BaseClass.Plants.PlantEquipment;
model Equips "CHillers and heat pumps"
  replaceable package Medium =Buildings.Media.Water
   constrainedby Modelica.Media.Interfaces.PartialMedium
   annotation (choicesAllMatching=true);
  parameter Integer num[3];
  parameter Boolean PS[3] "T=Parallel,F=Series";
  parameter Modelica.Units.SI.MassFlowRate mNomCH[2]
  "Nominal mass flow rate in CHs";
  parameter Modelica.Units.SI.PressureDifference dpNomCH[2]
  "Nominal Pressure drop in CHs";
  parameter Modelica.Units.SI.MassFlowRate mNomHPs1[2]
  "Nominal mass flow rate in HPs1";
  parameter Modelica.Units.SI.PressureDifference dpNomHPs1[2]
  "Nominal Pressure drop in HPs1";
  parameter Modelica.Units.SI.MassFlowRate mNomHPs2[2]
  "Nominal mass flow rate in HPs2";
  parameter Modelica.Units.SI.PressureDifference dpNomHPs2[2]
  "Nominal Pressure drop in HPs2";
  PlantEquipment.CHPS CHs(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=mNomCH[1],
    m2_flow_nominal=mNomCH[2],
    dp1_nominal=dpNomCH[1],
    dp2_nominal=dpNomCH[2],
    num=num[1],
    PS=PS[1],
    per=perCH) "Chillers"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  PlantEquipment.HPPS HPs1(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=mNomHPs1[1],
    m2_flow_nominal=mNomHPs1[2],
    dp1_nominal=dpNomHPs1[1],
    dp2_nominal=dpNomHPs1[2],
    num=num[2],
    PS=PS[2],
    per=perHPs1) "Heat pumps 1"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  PlantEquipment.HPPS HPs2(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=mNomHPs2[1],
    m2_flow_nominal=mNomHPs2[2],
    dp1_nominal=dpNomHPs2[1],
    dp2_nominal=dpNomHPs2[2],
    num=num[3],
    PS=PS[3],
    per=perHPs2) "Heat pumps 2"
    annotation (Placement(transformation(extent={{-10,-52},{10,-32}})));
  replaceable parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic perCH[num[1]]
    constrainedby Buildings.Fluid.Chillers.Data.ElectricEIR.Generic
    "Performance data" annotation (choicesAllMatching=true, Placement(
        transformation(extent={{-58,82},{-42,98}})));
  replaceable parameter
    Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic perHPs1[num[2]]
    constrainedby Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic
    "Performance data" annotation (choicesAllMatching=true, Placement(
        transformation(extent={{-18,82},{-2,98}})));
  replaceable parameter
    Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic perHPs2[num[3]]
    constrainedby Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic
    "Performance data" annotation (choicesAllMatching=true, Placement(
        transformation(extent={{22,82},{38,98}})));
  Modelica.Blocks.Interfaces.RealInput TSet
    "Set point for leaving water temperature"
    annotation (Placement(transformation(extent={{-140,18},{-100,58}})));
  Modelica.Blocks.Interfaces.IntegerInput on[sum(num)]
    "Equipment signal,-1=clg,1=htg,0=off"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealOutput P[sum(num)]
    "Electric power consumed by chiller and heat pump compressor"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Interfaces.RealOutput Q[sum(num)]
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
equation
  connect(port_a2, HPs1.port_a2)
    annotation (Line(points={{100,-60},{40,-60},{40,-6},{10,-6}},
                                                          color={0,127,255},
      thickness=0.5));
  connect(port_a2, HPs2.port_a2) annotation (Line(points={{100,-60},{40,-60},{40,
          -48},{10,-48}},
                 color={0,127,255},
      thickness=0.5));
  connect(CHs.port_a2, port_a2)
    annotation (Line(points={{10,34},{40,34},{40,-60},{100,-60}},
                                                          color={0,127,255},
      thickness=0.5));
  connect(HPs2.port_b1, port_b1) annotation (Line(points={{10,-36},{20,-36},{20,
          60},{100,60}}, color={0,127,255},
      thickness=0.5));
  connect(HPs1.port_b1, port_b1) annotation (Line(points={{10,6},{20,6},{20,60},
          {100,60}}, color={0,127,255},
      thickness=0.5));
  connect(CHs.port_b1, port_b1) annotation (Line(points={{10,46},{20,46},{20,60},
          {100,60}}, color={0,127,255},
      thickness=0.5));
  connect(CHs.port_a1, port_a1) annotation (Line(points={{-10,46},{-40,46},{-40,
          60},{-100,60}},
                color={0,127,255},
      thickness=0.5));
  connect(HPs1.port_a1, port_a1)
    annotation (Line(points={{-10,6},{-40,6},{-40,60},{-100,60}},
                                                          color={0,127,255},
      thickness=0.5));
  connect(HPs2.port_a1, port_a1) annotation (Line(points={{-10,-36},{-40,-36},{-40,
          60},{-100,60}},
                     color={0,127,255},
      thickness=0.5));
  connect(port_b2, CHs.port_b2) annotation (Line(points={{-100,-60},{-20,-60},{-20,
          34},{-10,34}}, color={0,127,255},
      thickness=0.5));
  connect(HPs1.port_b2, port_b2) annotation (Line(points={{-10,-6},{-20,-6},{-20,
          -60},{-100,-60}}, color={0,127,255},
      thickness=0.5));
  connect(HPs2.port_b2, port_b2) annotation (Line(points={{-10,-48},{-20,-48},{-20,
          -60},{-100,-60}}, color={0,127,255},
      thickness=0.5));
  connect(TSet, CHs.TSet)
    annotation (Line(points={{-120,38},{-12,38}}, color={0,0,127}));
  connect(HPs2.TSet, TSet) annotation (Line(points={{-12,-44},{-60,-44},{-60,38},
          {-120,38}}, color={0,0,127}));
  connect(HPs1.TSet, TSet) annotation (Line(points={{-12,-2},{-60,-2},{-60,38},{
          -120,38}}, color={0,0,127}));
  for i in 1:num[1] loop
    connect(CHs.on[i], on[i]) annotation (Line(points={{-12,48.4},{-80,48.4},{-80,90},{-120,
          90}}, color={255,127,0}));
    connect(CHs.P[i], P[i]) annotation (Line(points={{11,42},{60,42},{60,30},{110,
            30}},
        color={0,0,127}));
    connect(CHs.Q[i], Q[i]) annotation (Line(points={{11,38},{80,38},{80,-30},{110,
          -30}}, color={0,0,127}));
  end for;
  for i in 1:num[2] loop
    connect(HPs1.on[i], on[i+num[1]]) annotation (Line(points={{-12,8.4},{-12,8},
            {-80,8},{-80,90},{-120,90}},
                          color={255,127,0}));
    connect(HPs1.P[i], P[i+num[1]]) annotation (Line(points={{11,2},{60,2},{60,30},
            {110,30}},
        color={0,0,127}));
    connect(HPs1.Q[i], Q[i+num[1]]) annotation (Line(points={{11,-2},{80,-2},{80,-30},{110,
          -30}}, color={0,0,127}));
  end for;
  for i in 1:num[3] loop
    connect(HPs2.on[i], on[i+num[1]+num[2]]) annotation (Line(points={{-12,-33.6},{-12,-34},{-80,-34},
          {-80,90},{-120,90}}, color={255,127,0}));
    connect(HPs2.P[i], P[i+num[1]+num[2]]) annotation (Line(points={{11,-40},{60,
            -40},{60,30},{110,30}},
        color={0,0,127}));
    connect(HPs2.Q[i], Q[i+num[1]+num[2]]) annotation (Line(points={{11,-44},{80,-44},{80,-30},{
          110,-30}}, color={0,0,127}));
  end for;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,68},{-40,50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,70},{60,66}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=45),
        Rectangle(
          extent={{38,66},{42,14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,14},{60,10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=45),
        Polygon(
          points={{-42,42},{-52,30},{-32,30},{-42,42}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,30},{-40,14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-42,40},{-52,52},{-32,52},{-42,40}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,54},{52,30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,54},{30,36},{50,36},{40,54}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,-64},{60,-68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=45),
        Rectangle(
          extent={{38,-12},{42,-64}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,-24},{52,-48}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,-24},{30,-42},{50,-42},{40,-24}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,-8},{60,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=45),
        Rectangle(
          extent={{-44,-12},{-40,-28}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-42,-38},{-52,-26},{-32,-26},{-42,-38}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-42,-36},{-52,-48},{-32,-48},{-42,-36}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,-48},{-40,-64}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
      Text(
          extent={{-157,143},{143,103}},
          textColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name")}),           defaultComponentName="Equips");
end Equips;
