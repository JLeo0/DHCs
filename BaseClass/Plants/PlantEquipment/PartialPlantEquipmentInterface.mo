within DHCs.BaseClass.Plants.PlantEquipment;
partial model PartialPlantEquipmentInterface
  "Partial model that implements the interface for chiller and heat pump in plant"
  extends Buildings.Fluid.Interfaces.PartialFourPortInterface;
  extends Buildings.Fluid.Interfaces.FourPortFlowResistanceParameters(
     final computeFlowResistance1=true,
     final computeFlowResistance2=true);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}));
end PartialPlantEquipmentInterface;
