within DHC.BaseClass.Plants.PlantEquipment;
model CHPS "Chillers in parallel or series"
  extends PartialPS(
  redeclare DHC.BaseClass.Plants.PlantEquipment.CHwithVlv Equ[num](final per=
          per));
  replaceable parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic per[num]
    "Performance data"
     annotation (choicesAllMatching = true,
                Placement(transformation(extent={{2,82},{18,98}})));
  annotation (defaultComponentName="CHs");
end CHPS;
