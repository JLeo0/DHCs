within DHCs.BaseClass.Plants.PlantEquipment;
partial model PartialPS "Partial equipment parallel or series model"

  extends DHCs.BaseClass.Plants.PlantEquipment.PartialPlantEquipmentInterface;
  parameter Integer num(min=1)=2 "Number of equipment";
  parameter Boolean PS=true "T=Parallel,F=Series";
  replaceable DHCs.BaseClass.Plants.PlantEquipment.PartialEquipmentValve Equ[num]
    constrainedby DHCs.BaseClass.Plants.PlantEquipment.PartialEquipmentValve(
    redeclare each final package Medium1 = Medium1,
    redeclare each final package Medium2 = Medium2,
    each final m1_flow_nominal=m1_flow_nominal,
    each final m2_flow_nominal=m2_flow_nominal,
    each final dp1_nominal=dp1_nominal,
    each final dp2_nominal=dp2_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set point for leaving water temperature"
    annotation (Placement(transformation(extent={{-140,
            -40},{-100,0}}),
      iconTransformation(extent={{-140,-40},{-100,
            0}})));
  Modelica.Blocks.Interfaces.RealOutput P[num]
    "Electric power consumed by chiller or heat pump compressor"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.IntegerInput on[num]
    "Equipment signal,-1=clg,1=htg,0=off" annotation (Placement(transformation(
          extent={{-140,64},{-100,104}}), iconTransformation(extent={{-140,64},{
            -100,104}})));
  Modelica.Blocks.Interfaces.RealOutput Q[num](each final quantity="Power",
      each final unit="W")
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
equation
  connect(on, Equ.on) annotation (Line(points={{-120,84},{-40,84},{-40,8.4},{-12,
          8.4}}, color={255,127,0}));
  connect(Equ.P, P) annotation (Line(points={{11,2},{80,2},{80,20},{110,20}},
        color={0,0,127}));
  for i in 1:num loop
  connect(TSet, Equ[i].TSet) annotation (Line(points={{-120,-20},{-80,-20},{-80,
            -2},{-12,-2}}, color={0,0,127}));
  connect(Equ[i].port_a1, port_a1) annotation (Line(
          points={{-10,6},{-60,6},{-60,60},{-100,60}},
          color={0,127,255},
          thickness=0.5));
  connect(Equ[i].port_b1, port_b1) annotation (Line(
          points={{10,6},{60,6},{60,60},{100,60}},
          color={0,127,255},
          thickness=0.5));
  end for;
  if PS then
    for i in 1:num loop
    connect(Equ[i].port_a2, port_a2) annotation (Line(
          points={{10,-6},{60,-6},{60,-60},{100,-60}},
          color={0,127,255},
          thickness=0.5));
    connect(Equ[i].port_b2, port_b2) annotation (Line(
          points={{-10,-6},{-60,-6},{-60,-60},{-100,-60}},
          color={0,127,255},
          thickness=0.5));
    end for;
  else
    connect(Equ[1].port_a2, port_a2) annotation (Line(
          points={{10,-6},{60,-6},{60,-60},{100,-60}},
          color={0,127,255},
          thickness=0.5));
    connect(Equ[num].port_b2, port_b2) annotation (Line(
          points={{-10,-6},{-60,-6},{-60,-60},{-100,-60}},
          color={0,127,255},
          thickness=0.5));
    if num>=2 then
      for i in 2:num loop
        connect(Equ[i-1].port_b2,Equ[i].port_a2);
      end for;
    end if;
  end if;
  connect(Equ.Q, Q) annotation (Line(points={{11,-2},{80,-2},{80,-20},{110,-20}},
        color={0,0,127}));
  annotation (Icon(graphics={
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
          fillPattern=FillPattern.Solid)}));
end PartialPS;
