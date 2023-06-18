within DHC.BaseClass;
model FlowMachine_y "Identical speed controlled flow machines"
  extends DHC.BaseClass.PartialPumpParallel_y(
    redeclare final Buildings.Fluid.Movers.SpeedControlled_y pum(final y_start=yPump_start),
    rhoStd=Medium.density_pTX(101325, 273.15+4, Medium.X_default));

  Modelica.Blocks.Math.Product product1
                                      [num]
    annotation (Placement(transformation(extent={{-34,60},{-14,80}})));
equation
  connect(u, product1.u1) annotation (Line(points={{-120,40},{-90,40},{-90,76},
          {-36,76}}, color={0,0,127}));
  connect(swi.y, product1.u2) annotation (Line(points={{-26,-30},{-24,-30},{-24,
          52},{-36,52},{-36,64}}, color={0,0,127}));
  connect(product1.y, pum.y) annotation (Line(points={{-13,70},{-8,70},{-8,20},
          {0,20},{0,12}}, color={0,0,127}));
  annotation (    Documentation(revisions="<html>
<ul>
<li>
November 16, 2022, by Michael Wetter:<br/>
Improved sequence to avoid switching pump on when the valve is commanded off.
</li>
<li>
July 27, 2017, by Yangyang Fu:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>This model implements a parallel of identical pumps with speed being controlled.
The number can be specified by setting a value of <code>num</code>.
The shutoff valves are used to avoid circulating flow among pumps.
</p>
</html>"));
end FlowMachine_y;
