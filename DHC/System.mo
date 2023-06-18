within DHC;
model System1
  "The system operates at all variable flow rates except SRC side"
    extends Modelica.Icons.Example;

 replaceable package Medium=Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching=true);

  BaseClass.BuiUnit BLDG1(
    filNam=datDes.filNam[1],
    redeclare package Medium = Medium,
    k_C=datDes.kLD[1, 1],
    k_H=datDes.kLD[1, 2],
    T_ini=datDes.T_ini,
    m_flow_nominal_PMP_C=datDes.m_flow_nominal_PMP_B[1, 1],
    n_PMP_C=datDes.n_PMP_B[1, 1],
    dpValve_nominal_PMP_C=datDes.dpValve_nominal_PMP_B[1, 1],
    m_flow_nominal_PMP_H=datDes.m_flow_nominal_PMP_B[1, 2],
    n_PMP_H=datDes.n_PMP_B[1, 2],
    dpValve_nominal_PMP_H=datDes.dpValve_nominal_PMP_B[1, 2],
    QCoo_flow_nominal=datDes.LdNom[1, 1],
    dpClgNom=datDes.dpUnitNom[1, 1],
    QHea_flow_nominal=datDes.LdNom[1, 2],
    dpHtgNom=datDes.dpUnitNom[1, 2],
    BypVal=datDes.BypVlv,
    Kvs=datDes.Kvs[1],
    m_flow_nominal_P=datDes.m_flow_nominal_B[1],
    v_nominal_P=datDes.v_nominal_P[1],
    length=datDes.lcon[1],
    roughness=datDes.roughness,
    cPip=datDes.cPip,
    rhoPip=datDes.rhoPip,
    thickness=datDes.thickness,
    dIns=datDes.dIns,
    kIns=datDes.kIns,
    redeclare DHC.Data.PMP_A1_Clg perPMP_C,
    redeclare DHC.Data.PMP_A1_Htg perPMP_H,
    sPmpCtrlMd=datDes.sPmpCtrlMd,
    tWP=datDes.tWP,
    kmin=datDes.kminmax[1],
    kmax=datDes.kminmax[2],
    k1=datDes.k12[1],
    k2=datDes.k12[2],
    d=datDes.d)                        "A1A2"
    annotation (Placement(transformation(extent={{180,60},{200,80}})));
  BaseClass.BuiUnit BLDG2(
    dpValve_nominal_PMP_C=datDes.dpValve_nominal_PMP_B[2, 1],
    dpValve_nominal_PMP_H=datDes.dpValve_nominal_PMP_B[2, 2],
    QCoo_flow_nominal=datDes.LdNom[2, 1],
    dpClgNom=datDes.dpUnitNom[2, 1],
    QHea_flow_nominal=datDes.LdNom[2, 2],
    dpHtgNom=datDes.dpUnitNom[2, 2],
    BypVal=datDes.BypVlv,
    Kvs=datDes.Kvs[2],
    filNam=datDes.filNam[2],
    redeclare package Medium = Medium,
    k_C=datDes.kLD[2, 1],
    k_H=datDes.kLD[2, 2],
    T_ini=datDes.T_ini,
    m_flow_nominal_PMP_C=datDes.m_flow_nominal_PMP_B[2, 1],
    n_PMP_C=datDes.n_PMP_B[2, 1],
    m_flow_nominal_PMP_H=datDes.m_flow_nominal_PMP_B[2, 2],
    n_PMP_H=datDes.n_PMP_B[2, 2],
    m_flow_nominal_P=datDes.m_flow_nominal_B[2],
    v_nominal_P=datDes.v_nominal_P[2],
    length=datDes.lcon[2],
    roughness=datDes.roughness,
    cPip=datDes.cPip,
    rhoPip=datDes.rhoPip,
    thickness=datDes.thickness,
    dIns=datDes.dIns,
    kIns=datDes.kIns,
    redeclare DHC.Data.PMP_A3_Clg perPMP_C,
    redeclare DHC.Data.PMP_A3_Htg perPMP_H,
    sPmpCtrlMd=datDes.sPmpCtrlMd,
    tWP=datDes.tWP,
    kmin=datDes.kminmax[1],
    kmax=datDes.kminmax[2],
    k1=datDes.k12[1],
    k2=datDes.k12[2],
    d=datDes.d) "A3"
    annotation (Placement(transformation(extent={{120,58},{140,78}})));

  BaseClass.BuiUnit BLDG3(
    dpValve_nominal_PMP_C=datDes.dpValve_nominal_PMP_B[3, 1],
    dpValve_nominal_PMP_H=datDes.dpValve_nominal_PMP_B[3, 2],
    QCoo_flow_nominal=datDes.LdNom[3, 1],
    dpClgNom=datDes.dpUnitNom[3, 1],
    QHea_flow_nominal=datDes.LdNom[3, 2],
    dpHtgNom=datDes.dpUnitNom[3, 2],
    BypVal=datDes.BypVlv,
    Kvs=datDes.Kvs[3],
    filNam=datDes.filNam[3],
    redeclare package Medium = Medium,
    k_C=datDes.kLD[3, 1],
    k_H=datDes.kLD[3, 2],
    T_ini=datDes.T_ini,
    m_flow_nominal_PMP_C=datDes.m_flow_nominal_PMP_B[3, 1],
    n_PMP_C=datDes.n_PMP_B[3, 1],
    m_flow_nominal_PMP_H=datDes.m_flow_nominal_PMP_B[3, 2],
    n_PMP_H=datDes.n_PMP_B[3, 2],
    m_flow_nominal_P=datDes.m_flow_nominal_B[3],
    v_nominal_P=datDes.v_nominal_P[3],
    length=datDes.lcon[3],
    roughness=datDes.roughness,
    cPip=datDes.cPip,
    rhoPip=datDes.rhoPip,
    thickness=datDes.thickness,
    dIns=datDes.dIns,
    kIns=datDes.kIns,
    redeclare DHC.Data.PMP_A4_ClgHtg perPMP_C,
    redeclare DHC.Data.PMP_A4_ClgHtg perPMP_H,
    sPmpCtrlMd=datDes.sPmpCtrlMd,
    tWP=datDes.tWP,
    kmin=datDes.kminmax[1],
    kmax=datDes.kminmax[2],
    k1=datDes.k12[1],
    k2=datDes.k12[2],
    d=datDes.d) "A4"
    annotation (Placement(transformation(extent={{60,58},{80,78}})));

  Buildings.HeatTransfer.Sources.FixedTemperature
                                        gnd(T=datDes.T_Grd)
                                                      "Ground"
    annotation (Placement(transformation(extent={{18,22},{30,34}})));
  BaseClass.Connection2PipePlugFlow Pipe2(
    T_ini=datDes.T_ini,
    redeclare package Medium = Medium,
    mDis_flow_nominal=datDes.m_flow_nominal_B[1] + datDes.m_flow_nominal_B[2],
    mCon_flow_nominal=datDes.m_flow_nominal_B[2],
    allowFlowReversal=false,
    length=datDes.lDis[1],
    roughness=datDes.roughness,
    cPip=datDes.cPip,
    rhoPip=datDes.rhoPip,
    thickness=datDes.thickness,
    dIns=datDes.dIns,
    kIns=datDes.kIns)
    annotation (Placement(transformation(extent={{116,-52},{136,-32}})));

  BaseClass.Connection2PipePlugFlow Pipe1(
    T_ini=datDes.T_ini,
    redeclare package Medium = Medium,
    mDis_flow_nominal=datDes.m_flow_nominal_B[1] + datDes.m_flow_nominal_B[2]
         + datDes.m_flow_nominal_B[3],
    mCon_flow_nominal=datDes.m_flow_nominal_B[3],
    allowFlowReversal=false,
    length=datDes.lDis[2],
    roughness=datDes.roughness,
    cPip=datDes.cPip,
    rhoPip=datDes.rhoPip,
    thickness=datDes.thickness,
    dIns=datDes.dIns,
    kIns=datDes.kIns)
    annotation (Placement(transformation(extent={{56,-52},{76,-32}})));
  Buildings.Fluid.Sensors.MassFlowRate mSup(redeclare package Medium = Medium)
    "Mass flow rate in system"
    annotation (Placement(transformation(extent={{0,-46},{8,-38}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloA4(redeclare package Medium =
        Medium, allowFlowReversal=true) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={66,16})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloA3(redeclare package Medium =
        Medium, allowFlowReversal=true) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={126,18})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloA1(redeclare package Medium =
        Medium, allowFlowReversal=true) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={186,18})));
  Buildings.Fluid.Sensors.TemperatureTwoPort ToA4(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.m_flow_nominal_B[3],
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=datDes.T_ini) "BuiUnit Branch Inlet Temperature" annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={86,18})));
  Buildings.Fluid.Sensors.TemperatureTwoPort ToA3(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.m_flow_nominal_B[2],
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=datDes.T_ini) "BuiUnit Branch Inlet Temperature" annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={150,20})));
  Buildings.Fluid.Sensors.TemperatureTwoPort ToA1(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.m_flow_nominal_B[1],
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=datDes.T_ini) "BuiUnit Branch outlet Temperature" annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={204,18})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Tret(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.m_flow_nominal_PMP_P[1]*datDes.n_PMP_P[1],
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=datDes.T_ini) "Return Temperature" annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={38,-58})));
  Data.DesignData datDes(
    RunMode=2,
    dpValve_nominal_PMP_B(displayUnit="Pa") = {{1,1},{1,1},{1,1}},
    dpValve_nominal_PMP_P={20,12}*9806.65,
    dpValve_nominal_PMP_S(displayUnit="Pa"))
                         "Design data"
    annotation (Placement(transformation(extent={{149,187},{175,213}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Tsup(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.m_flow_nominal_PMP_P[1]*datDes.n_PMP_P[1],
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=datDes.T_ini) "Supply Temperature" annotation (Placement(
        transformation(
        extent={{4,4},{-4,-4}},
        rotation=180,
        origin={22,-42})));
  BaseClass.Plants plant(
    redeclare package Medium = Medium,
    T_ini=datDes.T_ini,
    PorS=datDes.PorS,
    m1_flow_nominal_CH=datDes.m_flow_nominal_CH[1],
    m2_flow_nominal_CH=datDes.m_flow_nominal_CH[2],
    dp1_nominal_CH=datDes.dp_nominal_CH[1],
    dp2_nominal_CH=datDes.dp_nominal_CH[2],
    n_PMP_C=datDes.n_PMP_P[1],
    m_flow_nominal_P_C=datDes.m_flow_nominal_PMP_P[1],
    dpValve_nominal_P_C=datDes.dpValve_nominal_PMP_P[1],
    m_flow_nominal_P_H=datDes.m_flow_nominal_PMP_P[2],
    n_PMP_H=datDes.n_PMP_P[2],
    dpValve_nominal_P_H=datDes.dpValve_nominal_PMP_P[2])
    annotation (Placement(transformation(extent={{-24,-102},{0,-64}})));
  Buildings.Fluid.Sources.Boundary_pT SrcBou2(
    redeclare package Medium = Medium,
    p(displayUnit="Pa") = 101325,
    T=293.15,
    nPorts=1) "Load_Side_Outlet" annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={93,-79})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TretSRC(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.n_PMP_S*datDes.mNomPmpSrcS,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=datDes.T_ini) "Return Temperature" annotation (Placement(
        transformation(
        extent={{4,4},{-4,-4}},
        rotation=180,
        origin={64,-80})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium = Medium,
      nPorts=1)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={5,-125})));
  Logic.PltLgc PltLgc(
    redeclare package Medium = Medium,
    kc_S=datDes.kS[1],
    kh_S=datDes.kS[2],
    Wt=datDes.Wt[1],
    Qnd_Mode=datDes.Qnd,
    minCooLoad=datDes.minLd[1],
    minHeaLoad=datDes.minLd[2]) "Plant control logic"
    annotation (Placement(transformation(extent={{-36,-16},{-56,4}})));
  BaseClass.FlowMachine_m SrcPmpS(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.mNomPmpSrcS,
    dpValve_nominal=datDes.dpValve_nominal_PMP_S,
    redeclare DHC.Data.PMP_SRC_Sec per,
    num=datDes.n_PMP_S,
    T_start=datDes.T_ini) "Secondary SRC Pumps"
    annotation (Placement(transformation(extent={{-174,-134},{-154,-114}})));
  Buildings.Fluid.Sources.Boundary_pT SrcBou1(
    redeclare package Medium = Medium,
    p(displayUnit="Pa") = 101325,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-205,-123})));
  Logic.PmpSpdCtrlWithBug PrimPmpCtrlH(
    PmpCtrlMd=datDes.pPmpCtrlMd,
    k=1,
    n_PMP=datDes.n_PMP_P[2],
    tWP=datDes.tWP,
    m_flow_nominal=datDes.m_flow_nominal_PMP_P[2],
    kmin=datDes.kminmax[1],
    kmax=datDes.kminmax[2],
    k1=datDes.k12[1],
    k2=datDes.k12[2],
    d=datDes.d)
            "Primary pump control in htg mode"
    annotation (Placement(transformation(extent={{-84,120},{-104,140}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter GainH(k=datDes.n_PMP_P[
        2]*datDes.m_flow_nominal_PMP_P[2]) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={-36,130})));
  Buildings.Controls.OBC.CDL.Continuous.PID BypPIDCtrl(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=datDes.kc,
    Ti=datDes.Ti) "PID control for byp flow" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={4,130})));
  Modelica.Blocks.Sources.Constant Zero(k=0)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=0,
        origin={36,130})));
  Logic.PmpSpdCtrlWithBug PrimPmpCtrlC(
    PmpCtrlMd=datDes.pPmpCtrlMd,
    k=-1,
    n_PMP=datDes.n_PMP_P[1],
    tWP=datDes.tWP,
    m_flow_nominal=datDes.m_flow_nominal_PMP_P[1],
    kmin=datDes.kminmax[1],
    kmax=datDes.kminmax[2],
    k1=datDes.k12[1],
    k2=datDes.k12[2],
    d=datDes.d) "Primary pump control in clg mode"
    annotation (Placement(transformation(extent={{-86,70},{-106,90}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter GainC(k=datDes.n_PMP_P[
        1]*datDes.m_flow_nominal_PMP_P[1])
                        annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={-38,80})));
  Modelica.Blocks.Sources.RealExpression minBypFlow(each y=if PltLgc.SysMd <> 0
         then min(i for i in {BLDG1.m_flow_byp,BLDG2.m_flow_byp,BLDG3.m_flow_byp})
         else 0) "Output min bypass mass flow rate" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={6,164})));
  Modelica.Blocks.Sources.IntegerExpression EachBuiMd(y=if max(i for i in {
        BLDG1.y_Md,BLDG2.y_Md,BLDG3.y_Md}) == 1 and min(i for i in {BLDG1.y_Md,
        BLDG2.y_Md,BLDG3.y_Md}) >= 0 then 1 elseif min(i for i in {BLDG1.y_Md,
        BLDG2.y_Md,BLDG3.y_Md}) == -1 and max(i for i in {BLDG1.y_Md,BLDG2.y_Md,
        BLDG3.y_Md}) <= 0 then -1 elseif min(i for i in {BLDG1.y_Md,BLDG2.y_Md,
        BLDG3.y_Md}) == 0 and max(i for i in {BLDG1.y_Md,BLDG2.y_Md,BLDG3.y_Md})
         == 0 then 0 else 99) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-26,50})));
  Modelica.Blocks.Sources.RealExpression TsetExp(y=if PltLgc.SysMd == -1 then
        datDes.Tset[1] elseif PltLgc.SysMd == 1 then datDes.Tset[2] else datDes.Tset[
        3]) "Tset Expression" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,-76})));
  Modelica.Blocks.Sources.RealExpression PChHpClg(y=if PltLgc.SysMd == -1 then
        (sum(plant.P_CH) + sum(plant.P_HP)) else 0)
    "Power Consumption of chiller and heat pumps in clg mode" annotation (
      Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,201})));
  Modelica.Blocks.Continuous.Integrator EClg(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Yearly Energy consumed during clg mode"
    annotation (Placement(transformation(extent={{334,130},{354,150}})));
  Modelica.Blocks.Sources.IntegerExpression SysMode(y=PltLgc.SysMd) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={20,104})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TsupSrc(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.n_PMP_S*datDes.mNomPmpSrcS,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=datDes.T_ini) "Supply Temperature at Source side" annotation (
      Placement(transformation(
        extent={{4,4},{-4,-4}},
        rotation=180,
        origin={-38,-124})));
  Logic.mParFixCtrl mParFixCtrlSrc(
    m1=datDes.m_flow_nominal_CH[1],
    m2={datDes.m_flow_nominal_HP12[1],datDes.m_flow_nominal_HP12[3]},
    m3={datDes.m_flow_nominal_HP3[1],datDes.m_flow_nominal_HP3[3]})
    "Partial Mass flow control in SRC side"
    annotation (Placement(transformation(extent={{-126,-12},{-146,8}})));
  Logic.mPMP mPmpSrc(
    m_nominal=datDes.mNomPmpSrcS,
    n_PMP=datDes.n_PMP_S,
    kmin=datDes.kminmax[1],
    kmax=datDes.kminmax[2]) "Required mass flow rate for each Src pump"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-182,-54})));
  Modelica.Blocks.Sources.RealExpression PCwpClg(y=if PltLgc.SysMd == -1 then
        sum(plant.P_CWP) else 0)
    "Power Consumption of Chilled water pumps in clg mode" annotation (
      Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,175})));
  Modelica.Blocks.Sources.RealExpression PPmpBClg(y=if PltLgc.SysMd == -1 then
        sum(BLDG1.P_PMP_C) + sum(BLDG2.P_PMP_C) + sum(BLDG3.P_PMP_C) else 0)
    "Power Consumption of pumps in buiunit in clg mode" annotation (Placement(
        transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,149})));
  Modelica.Blocks.Sources.RealExpression PPmpSsClg(y=if PltLgc.SysMd == -1
         then sum(SrcPmpS.P) else 0)
    "Power Consumption of Secondary SRC pumps in clg mode" annotation (
      Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,123})));
  Modelica.Blocks.Math.MultiSum PClg(nu=4) "Power consumption in clg mode"
    annotation (Placement(transformation(extent={{304,134},{316,146}})));
  Modelica.Blocks.Sources.RealExpression PChHpHtg(y=if PltLgc.SysMd == 1 then (
        sum(plant.P_HP)) else 0)
    "Power Consumption of chiller and heat pumps in htg mode" annotation (
      Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,-17})));
  Modelica.Blocks.Continuous.Integrator EHtg(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Yearly Energy consumed during htg mode"
    annotation (Placement(transformation(extent={{340,-52},{360,-32}})));
  Modelica.Blocks.Sources.RealExpression PCwpHtg(y=if PltLgc.SysMd == 1 then
        sum(plant.P_HWP) else 0)
    "Power Consumption of Chilled water pumps in htg mode" annotation (
      Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,-43})));
  Modelica.Blocks.Sources.RealExpression PPmpBHtg(y=if PltLgc.SysMd == 1 then
        sum(BLDG1.P_PMP_H) + sum(BLDG2.P_PMP_H) + sum(BLDG3.P_PMP_H) else 0)
    "Power Consumption of pumps in buiunit in htg mode" annotation (Placement(
        transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,-69})));
  Modelica.Blocks.Sources.RealExpression PPmpSsHtg(y=if PltLgc.SysMd == 1 then
        sum(SrcPmpS.P) else 0)
    "Power Consumption of Secondary SRC pumps in htg mode" annotation (
      Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,-95})));
  Modelica.Blocks.Math.MultiSum PHtg(nu=4) "Power consumption in htg mode"
    annotation (Placement(transformation(extent={{308,-48},{320,-36}})));
  Modelica.Blocks.Math.MultiSum P(nu=2) "Power consumption"
    annotation (Placement(transformation(extent={{384,-6},{396,6}})));
  Modelica.Blocks.Continuous.Integrator E(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Yearly Energy consumed"
    annotation (Placement(transformation(extent={{420,-10},{440,10}})));
  Modelica.Blocks.Sources.RealExpression PPmpSpHtg(y=if PltLgc.SysMd == 1 then
        mParFixCtrlSrc.y/datDes.mNomPmpSrcP*datDes.PPmpSrcP else 0)
                  "Power Consumption of Primary SRC pumps in htg mode"
    annotation (Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,-121})));
  Modelica.Blocks.Sources.RealExpression QHtg(y=if PltLgc.SysMd == 1 then (abs(
        plant.HP01.QLoa_flow + plant.HP02.QLoa_flow + plant.HP03.QLoa_flow))
         else 0) "Q in htg mode" annotation (Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,-147})));
  Modelica.Blocks.Sources.RealExpression PPmpSpClg(y=if PltLgc.SysMd == -1
         then mParFixCtrlSrc.y/datDes.mNomPmpSrcP*datDes.PPmpSrcP else 0)
                        "Power Consumption of Primary SRC pumps in clg mode"
    annotation (Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,97})));
  Modelica.Blocks.Sources.RealExpression QClg(y=if PltLgc.SysMd == -1 then (abs(
        plant.CH01.QEva_flow_in.y + plant.CH02.QEva_flow_in.y) + abs(plant.HP01.QLoa_flow
         + plant.HP02.QLoa_flow + plant.HP03.QLoa_flow)) else 0)
    "Q in clg mode" annotation (Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,71})));
  Modelica.Blocks.Sources.RealExpression COPC(y=if PltLgc.SysMd == -1 then (
        QClg.y + 1e-6)/(PClg.y + 1e-6) else 0) "COP in clg mode" annotation (
      Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,45})));
  Modelica.Blocks.Sources.RealExpression COPH(y=if PltLgc.SysMd == 1 then (QHtg.y
         + 1e-6)/(PHtg.y + 1e-6) else 0) "COP in htg mode" annotation (
      Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,-173})));
  Modelica.Blocks.Continuous.Integrator yQHtg(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Yearly Q during htg mode"
    annotation (Placement(transformation(extent={{298,-122},{318,-102}})));
  Modelica.Blocks.Continuous.Integrator yQClg(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Yearly Q during clg mode"
    annotation (Placement(transformation(extent={{296,60},{316,80}})));
  Modelica.Blocks.Sources.RealExpression ECOPClg(y=(yQClg.y + 1e-6)/(EClg.y +
        1e-6)) "Average COP during clg mode. Only the last-minute value is correct"
    annotation (Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,19})));
  Modelica.Blocks.Sources.RealExpression ECOPHtg(y=(yQHtg.y + 1e-6)/(EHtg.y +
        1e-6)) "Average COP during htg mode. Only the last-minute value is correct"
    annotation (Placement(transformation(
        extent={{-25,-19},{25,19}},
        rotation=0,
        origin={247,-199})));
  BaseClass.PlugFlowPipe FlowPipeSRC3(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.mNomSrc[1],
    v_nominal=datDes.v_nominal_SRC[2],
    roughness=datDes.roughness,
    length=datDes.L_SRC[2],
    dIns=datDes.dIns,
    kIns=datDes.kIns,
    cPip=datDes.cPip,
    rhoPip=datDes.rhoPip,
    thickness=datDes.thickness,
    T_start_in=datDes.T_ini,
    T_start_out=datDes.T_ini) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,-80})));
  BaseClass.PlugFlowPipe FlowPipeSRC1(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.mNomSrc[1]/2,
    v_nominal=datDes.v_nominal_SRC[1],
    roughness=datDes.roughness,
    length=datDes.L_SRC[1],
    dIns=datDes.dIns,
    kIns=datDes.kIns,
    cPip=datDes.cPip,
    rhoPip=datDes.rhoPip,
    thickness=datDes.thickness,
    T_start_in=datDes.T_ini,
    T_start_out=datDes.T_ini) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-96,-124})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    m_flow_nominal={2,-1,-1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-132,-124})));
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Medium,
    T_start=datDes.T_ini,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-58,-124})));
  BaseClass.PlugFlowPipe FlowPipeSRC2(
    redeclare package Medium = Medium,
    m_flow_nominal=datDes.mNomSrc[1]/2,
    v_nominal=datDes.v_nominal_SRC[1],
    roughness=datDes.roughness,
    length=datDes.L_SRC[1],
    dIns=datDes.dIns,
    kIns=datDes.kIns,
    cPip=datDes.cPip,
    rhoPip=datDes.rhoPip,
    thickness=datDes.thickness,
    T_start_in=datDes.T_ini,
    T_start_out=datDes.T_ini) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-96,-154})));
  Buildings.HeatTransfer.Sources.FixedTemperature
                                        gnd1(T=datDes.T_Grd)
                                                      "Ground"
    annotation (Placement(transformation(extent={{-162,-102},{-150,-90}})));
equation
  connect(gnd.port, BLDG1.heatPort1) annotation (Line(points={{30,28},{76,28},{
          76,48},{168,48},{168,70.8},{179.4,70.8}},
                                 color={191,0,0}));
  connect(gnd.port, BLDG2.heatPort1) annotation (Line(points={{30,28},{76,28},{
          76,48},{108,48},{108,68.8},{119.4,68.8}},
                           color={191,0,0}));
  connect(gnd.port, Pipe2.heatPort) annotation (Line(points={{30,28},{48,28},{
          48,-24},{104,-24},{104,-35},{116,-35}},
                        color={191,0,0}));
  connect(BLDG3.heatPort1, gnd.port) annotation (Line(points={{59.4,68.8},{44,
          68.8},{44,28},{30,28}},
                              color={191,0,0}));
  connect(Pipe1.heatPort, gnd.port) annotation (Line(points={{56,-35},{44,-35},
          {44,28},{30,28}},           color={191,0,0}));
  connect(Pipe1.port_bDisSup, Pipe2.port_aDisSup)
    annotation (Line(points={{76,-42},{116,-42}},
                                                color={0,127,255},
      thickness=0.5));
  connect(Pipe1.port_aDisRet, Pipe2.port_bDisRet)
    annotation (Line(points={{76,-48},{116,-48}},
                                                color={0,127,255},
      thickness=0.5));
  connect(BLDG3.Inlet, senMasFloA4.port_b)
    annotation (Line(points={{66,56},{66,20}},            color={0,127,255},
      thickness=0.5));
  connect(Pipe2.port_bCon, senMasFloA3.port_a)
    annotation (Line(points={{126,-32},{126,14}},    color={0,127,255},
      thickness=0.5));
  connect(senMasFloA3.port_b, BLDG2.Inlet) annotation (Line(points={{126,22},{
          126,56}},             color={0,127,255},
      thickness=0.5));
  connect(Pipe2.port_bDisSup, senMasFloA1.port_a)
    annotation (Line(points={{136,-42},{136,-44},{186,-44},{186,14}},
                                                         color={0,127,255},
      thickness=0.5));
  connect(senMasFloA1.port_b, BLDG1.Inlet)
    annotation (Line(points={{186,22},{186,58}},       color={0,127,255},
      thickness=0.5));
  connect(senMasFloA4.port_a, Pipe1.port_bCon)
    annotation (Line(points={{66,12},{66,-32}},         color={0,127,255},
      thickness=0.5));
  connect(BLDG3.Outlet, ToA4.port_a) annotation (Line(
      points={{74,56},{80,56},{80,22},{86,22}},
      color={0,127,255},
      thickness=0.5));
  connect(ToA4.port_b, Pipe1.port_aCon) annotation (Line(
      points={{86,14},{86,-32},{72,-32}},
      color={0,127,255},
      thickness=0.5));
  connect(BLDG2.Outlet, ToA3.port_a) annotation (Line(
      points={{134,56},{134,24},{150,24}},
      color={0,127,255},
      thickness=0.5));
  connect(ToA3.port_b, Pipe2.port_aCon) annotation (Line(
      points={{150,16},{150,-20},{132,-20},{132,-32}},
      color={0,127,255},
      thickness=0.5));
  connect(BLDG1.Outlet, ToA1.port_a) annotation (Line(
      points={{194,58},{194,40},{204,40},{204,22}},
      color={0,127,255},
      thickness=0.5));
  connect(ToA1.port_b, Pipe2.port_aDisRet) annotation (Line(
      points={{204,14},{204,-48},{136,-48}},
      color={0,127,255},
      thickness=0.5));
  connect(Pipe1.port_bDisRet, Tret.port_a) annotation (Line(points={{56,-48},{
          48,-48},{48,-58},{42,-58}},
                               color={0,127,255},
      thickness=0.5));
  connect(mSup.port_b, Tsup.port_a) annotation (Line(
      points={{8,-42},{18,-42}},
      color={0,127,255},
      thickness=0.5));
  connect(Tsup.port_b, Pipe1.port_aDisSup)
    annotation (Line(points={{26,-42},{56,-42}},   color={0,127,255},
      thickness=0.5));
  connect(Tret.port_b, plant.LdI) annotation (Line(
      points={{34,-58},{16,-58},{16,-101.803},{1.53333,-101.803}},
      color={0,127,255},
      thickness=0.5));
  connect(TretSRC.port_b, SrcBou2.ports[1]) annotation (Line(
      points={{68,-80},{77,-80},{77,-79},{86,-79}},
      color={0,255,255},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(bou.ports[1], plant.LdI) annotation (Line(points={{5,-118},{1.53333,
          -118},{1.53333,-101.803}},                  color={0,127,255}));
  connect(mSup.m_flow,PltLgc. mFlow) annotation (Line(points={{4,-37.6},{4,-16},
          {-35,-16}},           color={0,0,127}));
  connect(plant.LdO, mSup.port_a) annotation (Line(
      points={{-24.7333,-63.4103},{-24.7333,-42},{-2.22045e-16,-42}},
      color={0,127,255},
      thickness=0.5));
  connect(Tret.T,PltLgc. TRet) annotation (Line(points={{38,-53.6},{38,-9},{-35,
          -9}},                                         color={0,0,127}));
  connect(PltLgc.CH, plant.Sig_CH) annotation (Line(points={{-56.5,-1},{-64,-1},
          {-64,-67.8},{-25.4333,-67.8}},      color={255,0,255}));
  connect(PltLgc.HP, plant.Sig_HP) annotation (Line(points={{-56.5,-9},{-64,-9},
          {-64,-78.5448},{-25.4333,-78.5448}},   color={255,127,0}));
  connect(PltLgc.SigCHV, plant.Sig_VCH) annotation (Line(points={{-56.5,-5},{
          -64,-5},{-64,-73.3034},{-25.4333,-73.3034}},              color={0,0,
          127}));
  connect(plant.Sig_HPV, PltLgc.SigHPV) annotation (Line(points={{-25.3,
          -85.8828},{-68,-85.8828},{-68,-13.2},{-56.5,-13.2}}, color={0,0,127}));

  connect(SrcBou1.ports[1], SrcPmpS.port_a) annotation (Line(
      points={{-198,-123},{-185,-123},{-185,-124},{-174,-124}},
      color={0,255,255},
      thickness=0.5));
  connect(BypPIDCtrl.y, GainH.u)
    annotation (Line(points={{-8,130},{-28.8,130}}, color={0,0,127}));
  connect(Zero.y, BypPIDCtrl.u_s)
    annotation (Line(points={{29.4,130},{16,130}}, color={0,0,127}));
  connect(PrimPmpCtrlH.ReqMasFlo,GainH. y)
    annotation (Line(points={{-81.8,130},{-43.2,130}},  color={0,0,127}));
  connect(PrimPmpCtrlC.ReqMasFlo,GainC. y)
    annotation (Line(points={{-83.8,80},{-45.2,80}},    color={0,0,127}));
  connect(GainC.u, BypPIDCtrl.y) annotation (Line(points={{-30.8,80},{-20,80},{
          -20,130},{-8,130}}, color={0,0,127}));
  connect(minBypFlow.y, BypPIDCtrl.u_m)
    annotation (Line(points={{6,153},{4,153},{4,142}},
                                                 color={0,0,127}));
  connect(PrimPmpCtrlH.y, plant.u_HWP) annotation (Line(points={{-105,130},{
          -120,130},{-120,16},{-64,16},{-64,-94.9241},{-25.3333,-94.9241}},
                                                          color={0,0,127}));
  connect(plant.u_CWP, PrimPmpCtrlC.y) annotation (Line(points={{-25.3333,
          -98.069},{-112,-98.069},{-112,64},{-116,64},{-116,80},{-107,80}},
                                                 color={0,0,127}));
  connect(TsetExp.y, plant.Tset) annotation (Line(points={{-81,-76},{-36,-76},{
          -36,-91.6483},{-25.3333,-91.6483}},   color={0,0,127}));
  connect(EachBuiMd.y, PltLgc.SysMdPartial) annotation (Line(points={{-37,50},{
          -44,50},{-44,12},{-35,12},{-35,4}},
                                            color={255,127,0}));
  connect(BLDG3.Load, PltLgc.bui3) annotation (Line(points={{81,78},{88,78},{88,
          48},{-4,48},{-4,-5},{-35,-5}},       color={0,0,127}));
  connect(BLDG2.Load, PltLgc.bui2) annotation (Line(points={{141,78},{148,78},{
          148,48},{-4,48},{-4,-2},{-35,-2}},
                                      color={0,0,127}));
  connect(BLDG1.Load, PltLgc.bui1) annotation (Line(points={{201,80},{208,80},{
          208,48},{-4,48},{-4,1},{-35,1}},
                                      color={0,0,127}));
  connect(PrimPmpCtrlH.u, PltLgc.SysMd) annotation (Line(points={{-82,140},{-84,
          140},{-84,148},{-57,148},{-57,4}},           color={255,127,0}));
  connect(PrimPmpCtrlC.u, PltLgc.SysMd) annotation (Line(points={{-84,90},{-57,
          90},{-57,4}},                                color={255,127,0}));
  connect(PltLgc.TSup, TsetExp.y) annotation (Line(points={{-35,-12.5},{-28,
          -12.5},{-28,-52},{-68,-52},{-68,-76},{-81,-76}},
                                             color={0,0,127}));
  connect(SysMode.y, BLDG3.yMdSys) annotation (Line(points={{31,104},{58,104},{
          58,78}},                       color={255,127,0}));
  connect(SysMode.y, BLDG2.yMdSys) annotation (Line(points={{31,104},{118,104},
          {118,78}},                        color={255,127,0}));
  connect(SysMode.y, BLDG1.yMdSys) annotation (Line(points={{31,104},{178,104},
          {178,80}},                           color={255,127,0}));
  connect(TsupSrc.port_b, plant.SrcI) annotation (Line(
      points={{-34,-124},{-34,-116},{-25.4,-116},{-25.4,-102.066}},
      color={0,255,255},
      thickness=0.5));
  connect(PltLgc.SysMd, mParFixCtrlSrc.u) annotation (Line(points={{-57,4},{-64,
          4},{-64,8},{-124,8}},             color={255,127,0}));
  connect(mPmpSrc.mReqOut, SrcPmpS.u) annotation (Line(points={{-182,-65},{-184,
          -65},{-184,-120},{-176,-120}},  color={0,0,127}));
  connect(mParFixCtrlSrc.y, mPmpSrc.mReqIn) annotation (Line(points={{-147,-2},
          {-147,-4},{-182,-4},{-182,-42}},     color={0,0,127}));
  connect(PltLgc.SigCHV, mParFixCtrlSrc.u1) annotation (Line(points={{-56.5,-5},
          {-56.5,-2},{-124,-2}},                          color={0,0,127}));
  connect(PltLgc.SigHPV, mParFixCtrlSrc.u2) annotation (Line(points={{-56.5,
          -13.2},{-56.5,-10},{-124,-10}},
                 color={0,0,127}));
  connect(PChHpClg.y, PClg.u[1]) annotation (Line(points={{274.5,201},{292,201},
          {292,138.425},{304,138.425}},
                                      color={0,0,127}));
  connect(PCwpClg.y, PClg.u[2]) annotation (Line(points={{274.5,175},{292,175},
          {292,139.475},{304,139.475}},
                                      color={0,0,127}));
  connect(PPmpBClg.y, PClg.u[3]) annotation (Line(points={{274.5,149},{274.5,
          140.525},{304,140.525}},
                        color={0,0,127}));
  connect(PPmpSsClg.y, PClg.u[4]) annotation (Line(points={{274.5,123},{288,123},
          {288,141.575},{304,141.575}},
                         color={0,0,127}));
  connect(PClg.y, EClg.u)
    annotation (Line(points={{317.02,140},{332,140}},
                                                    color={0,0,127}));
  connect(PChHpHtg.y, PHtg.u[1]) annotation (Line(points={{274.5,-17},{300,-17},
          {300,-43.575},{308,-43.575}},                color={0,0,127}));
  connect(PCwpHtg.y, PHtg.u[2]) annotation (Line(points={{274.5,-43},{288,-43},
          {288,-42.525},{308,-42.525}},           color={0,0,127}));
  connect(PPmpBHtg.y, PHtg.u[3]) annotation (Line(points={{274.5,-69},{300,-69},
          {300,-41.475},{308,-41.475}},                  color={0,0,127}));
  connect(PPmpSsHtg.y, PHtg.u[4]) annotation (Line(points={{274.5,-95},{300,-95},
          {300,-40.425},{308,-40.425}},                  color={0,0,127}));
  connect(PHtg.y, EHtg.u)
    annotation (Line(points={{321.02,-42},{338,-42}}, color={0,0,127}));
  connect(PClg.y, P.u[1]) annotation (Line(points={{317.02,140},{324,140},{324,
          -1.05},{384,-1.05}}, color={0,0,127}));
  connect(PHtg.y, P.u[2]) annotation (Line(points={{321.02,-42},{321.02,-44},{
          332,-44},{332,1.05},{384,1.05}},
                             color={0,0,127}));
  connect(P.y, E.u)
    annotation (Line(points={{397.02,0},{418,0}}, color={0,0,127}));
  connect(QHtg.y, yQHtg.u) annotation (Line(points={{274.5,-147},{284,-147},{
          284,-112},{296,-112}},
                      color={0,0,127}));
  connect(QClg.y, yQClg.u) annotation (Line(points={{274.5,71},{274.5,70},{294,
          70}},                 color={0,0,127}));
  connect(plant.SrcO, FlowPipeSRC3.port_a) annotation (Line(
      points={{0.2,-63.1483},{24,-63.1483},{24,-80},{30,-80}},
      color={0,255,255},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(FlowPipeSRC3.port_b, TretSRC.port_a) annotation (Line(
      points={{50,-80},{60,-80}},
      color={0,255,255},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(gnd1.port, FlowPipeSRC1.heatPort) annotation (Line(points={{-150,-96},
          {-96,-96},{-96,-114}},                            color={191,0,0}));
  connect(jun1.port_2, FlowPipeSRC1.port_a) annotation (Line(
      points={{-122,-124},{-106,-124}},
      color={85,255,255},
      thickness=0.5));
  connect(FlowPipeSRC1.port_b, jun2.port_1) annotation (Line(
      points={{-86,-124},{-68,-124}},
      color={85,255,255},
      thickness=0.5));
  connect(gnd1.port, FlowPipeSRC2.heatPort) annotation (Line(points={{-150,-96},
          {-76,-96},{-76,-144},{-96,-144}},                             color={
          191,0,0}));
  connect(jun1.port_3, FlowPipeSRC2.port_a) annotation (Line(
      points={{-132,-134},{-132,-154},{-106,-154}},
      color={85,255,255},
      thickness=0.5));
  connect(jun2.port_3, FlowPipeSRC2.port_b) annotation (Line(
      points={{-58,-134},{-60,-134},{-60,-154},{-86,-154}},
      color={85,255,255},
      thickness=0.5));
  connect(SrcPmpS.port_b, jun1.port_1) annotation (Line(
      points={{-154,-124},{-142,-124}},
      color={85,255,255},
      thickness=0.5));
  connect(TsupSrc.port_a, jun2.port_2) annotation (Line(
      points={{-42,-124},{-48,-124}},
      color={85,255,255},
      thickness=0.5));
  connect(gnd.port, FlowPipeSRC3.heatPort) annotation (Line(points={{30,28},{40,
          28},{40,-44},{36,-44},{36,-52},{28,-52},{28,-64},{24,-64},{24,-70},{
          40,-70}},               color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -220},{220,220}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-220},{220,
            220}}), graphics={
        Rectangle(
          extent={{220,220},{362,0}},
          lineColor={28,108,200},
          fillColor={212,255,254},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{220,0},{362,-220}},
          lineColor={28,108,200},
          fillColor={255,226,224},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{362,100},{462,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}),
    experiment(StopTime=208800, __Dymola_Algorithm="Dassl"));
end System1;
