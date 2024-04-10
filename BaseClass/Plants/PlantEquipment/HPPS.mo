within DHC.BaseClass.Plants.PlantEquipment;
model HPPS "Heat pumps in parallel or series"
  extends PartialPS(
  redeclare DHC.BaseClass.Plants.PlantEquipment.HPwithVlv Equ[num](final per=
          per, final scaling_factor=scaling_factor));
  parameter Real scaling_factor[num] = fill(1,num)
   "Scaling factor for heat pump capacity";
  replaceable parameter Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic per[num]
    "Performance data"
    annotation (choicesAllMatching = true,
                Placement(transformation(extent={{2,82},{18,98}})));
  annotation (defaultComponentName="HPs");
end HPPS;
