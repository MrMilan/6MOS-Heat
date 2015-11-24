package heat
  model heat_eq
    constant Integer num = 100;
    Real u[num](each start = 0);
    parameter Real alpha = 1;
    parameter Real dx = 1;
  initial equation
    for i in 2:integer(num / 10) loop
      u[i] = 1;
    end for;
  equation
    u[1] = u[2];
    u[num - 1] = u[num];
    for i in 2:num - 1 loop
      der(u[i]) = (u[i + 1] - 2 * u[i] + u[i - 1]) * alpha / dx;
    end for;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end heat_eq;

  model odpor
    parameter Real r = 1;
    pq pq1 annotation(Placement(visible = true, transformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq pq2 annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    pq1.p - pq2.p = r * pq1.q;
    pq1.q + pq2.q = 0;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-4, -5}, extent = {{-64, 31}, {64, -31}}), Text(origin = {-6, -2}, extent = {{-62, -28}, {62, 28}}, textString = "%name")}));
  end odpor;

  model DpBlock
    pq q_in annotation(Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-86, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq q_out annotation(Placement(visible = true, transformation(origin = {90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    odpor odpor1(r = R) annotation(Placement(visible = true, transformation(origin = {-1, -5}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
    kapacita kapacita1(v0 = C) annotation(Placement(visible = true, transformation(origin = {-2, 56}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 1) annotation(Placement(visible = true, transformation(origin = {-72, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real R = 3;
    parameter Real C = 1;
  equation
    connect(const.y, kapacita1.c) annotation(Line(points = {{-61, 76}, {-26, 76}, {-26, 78}, {-26, 78}}, color = {0, 0, 127}));
    connect(pq1, odpor1.pq1) annotation(Line(points = {{-90, 0}, {-65, 0}, {-65, -5}, {-18, -5}}));
    connect(odpor1.pq2, kapacita1.pq1) annotation(Line(points = {{14, -5}, {14, -5}, {14, 18}, {0, 18}, {0, 30}, {0, 30}}));
    connect(odpor1.pq2, pq2) annotation(Line(points = {{14, -5}, {90, -5}, {90, -6}, {90, -6}}));
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-15, 19}, extent = {{-43, 27}, {71, -59}}, textString = "%name"), Rectangle(origin = {2, -3}, extent = {{-74, 79}, {74, -79}})}));
  end DpBlock;

  model kapacita
    pq pq1 annotation(Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput c "compliance" annotation(Placement(visible = true, transformation(origin = {-86, 86}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Real v;
    parameter Real v0 = 2;
  initial equation
    v = v0;
  equation
    pq1.p = c * v;
    der(v) = pq1.q;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {17, 37}, extent = {{-71, 45}, {49, -83}}, endAngle = 360), Line(origin = {-20, 20}, points = {{0, 40}, {0, -40}}, thickness = 4), Line(origin = {20, 20}, points = {{0, 40}, {0, -40}}, thickness = 4), Line(origin = {-56, 20}, points = {{34, 0}, {-34, 0}}), Line(origin = {56, 20}, points = {{34, 0}, {-34, 0}})}));
  end kapacita;

  connector pq
    Real p;
    flow Real q;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-1, 2}, fillPattern = FillPattern.Solid, extent = {{-95, 94}, {95, -94}}), Text(origin = {-63, -99}, extent = {{-5, -1}, {111, -39}}, textString = "%name")}));
  end pq;

  model tlak
    pq pq1 annotation(Placement(visible = true, transformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real p;
  equation
    pq1.p = p;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {4, -15}, rotation = 45, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-36, 79}, {79, -36}}, radius = 13), Ellipse(origin = {-4, 16}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{30, -42}, {-16, 42}}, endAngle = 360), Text(origin = {5, -79}, extent = {{-49, 13}, {49, -13}}, textString = "%name")}));
  end tlak;

  model DpEq
    pq pq1 annotation(Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-86, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq pq2 annotation(Placement(visible = true, transformation(origin = {90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real v0 = 1.0;
    parameter Real r = 3.0;
    constant Real c = 1;
    Real v;
  initial equation
    v = v0;
  equation
    pq1.p - pq2.p = r * pq1.q;
    pq2.p = c * v;
    der(v) = pq1.q + pq2.q;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {1, -9}, fillColor = {255, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-77, 79}, {77, -79}}), Text(origin = {-4, 0}, extent = {{-56, -28}, {56, 28}}, textString = "%name")}));
  end DpEq;

  model comparDPs
    tlak tlak1(p = 1) annotation(Placement(visible = true, transformation(origin = {-86, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tlak tlak2(p = 2) annotation(Placement(visible = true, transformation(origin = {68, 64}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    tlak tlak3(p = 1) annotation(Placement(visible = true, transformation(origin = {-80, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tlak tlak4(p = 2) annotation(Placement(visible = true, transformation(origin = {72, -48}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    odpor zatez2(r = 1) annotation(Placement(visible = true, transformation(origin = {40, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    odpor zatez1(r = 1) annotation(Placement(visible = true, transformation(origin = {36, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DpEq dpEq1 annotation(Placement(visible = true, transformation(origin = {-18, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DpBlock dpBlock1 annotation(Placement(visible = true, transformation(origin = {-12, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(tlak1.pq1, dpBlock1.pq1) annotation(Line(points = {{-77, 59}, {-54, 59}, {-54, 66}, {-20, 66}, {-20, 66}}));
    connect(dpBlock1.pq2, zatez1.pq1) annotation(Line(points = {{-3, 66}, {6, 66}, {6, 60}, {28, 60}, {28, 60}}));
    connect(tlak3.pq1, dpEq1.pq1) annotation(Line(points = {{-71, -53}, {-38, -53}, {-38, -52}, {-26, -52}, {-26, -52}}));
    connect(dpEq1.pq2, zatez2.pq1) annotation(Line(points = {{-9, -52}, {16, -52}, {16, -56}, {32, -56}, {32, -56}}));
    connect(zatez1.pq2, tlak2.pq1) annotation(Line(points = {{44, 60}, {51, 60}, {51, 55}, {59, 55}}));
    connect(zatez2.pq2, tlak4.pq1) annotation(Line(points = {{48, -56}, {54, -56}, {54, -58}, {62, -58}, {62, -58}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end comparDPs;

  model cevaDpBlock
    pq pq1 annotation(Placement(visible = true, transformation(origin = {-86, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-78, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq pq2 annotation(Placement(visible = true, transformation(origin = {86, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real paramR = 3;
    parameter Real paramC = 1;
    parameter Integer num = 1;
    DpBlock dpBlockArr[num](each R = paramR, each C = paramC);
  equation
    connect(pq1, dpBlockArr[1].q_in);
    connect(dpBlockArr[num].q_out, pq2);
    for i in 1:num - 1 loop
      connect(dpBlockArr[i].q_in, dpBlockArr[i + 1].q_out);
    end for;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-3, -68}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-53, -56}, {53, 56}}, textString = "Ceva_Block_%name"), Ellipse(origin = {-1, 16}, extent = {{-55, 66}, {55, -66}}, endAngle = 360)}));
  end cevaDpBlock;

  model cevaDpEq
    pq pq1 annotation(Placement(visible = true, transformation(origin = {-86, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-78, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq pq2 annotation(Placement(visible = true, transformation(origin = {86, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real paramR = 3;
    parameter Real paramC = 1;
    parameter Integer num = 1;
    DpEq dpEqArr[num](each R = paramR, each C = paramC);
  equation
    connect(pq1, dpEqArr[1].q_in);
    connect(dpEqArr[num].q_out, pq2);
    for i in 1:num - 1 loop
      connect(dpEqArr[i].q_in, dpEqArr[i + 1].q_out);
    end for;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {1, -68}, extent = {{-53, -56}, {53, 56}}, textString = "Ceva_EQ_%name"), Ellipse(origin = {4, 15}, fillColor = {255, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-54, 63}, {54, -63}}, endAngle = 360)}));
  end cevaDpEq;

  model chlopen
    pq pq1 annotation(Placement(visible = true, transformation(origin = {-84, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-84, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pq pq2 annotation(Placement(visible = true, transformation(origin = {86, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Real q;
    Real dp;
    Real s;
    Boolean on;
  equation
    pq1.q + pq2.q = 0;
    pq1.p - pq2.p = dp;
    pq1.q = q;
    on = s > 0;
    if on then
      dp = 0;
      q = s;
    else
      dp = s;
      q = 0;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {-4, 0.02}, fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, points = {{-56, 79.9808}, {-56, -80.0192}, {44, -2.01921}, {44, -80.0192}, {56, -80.0192}, {56, 79.9808}, {44, 79.9808}, {44, 11.9808}, {-56, 79.9808}})}));
  end chlopen;

  model finalModel
    Modelica.Blocks.Sources.Sine sine1(amplitude = 1, freqHz = 1, offset = 1.1) annotation(Placement(visible = true, transformation(origin = {-64, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tlak tlak1(p = 1) annotation(Placement(visible = true, transformation(origin = {-86, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    kapacita kapacita1(v0 = 2) annotation(Placement(visible = true, transformation(origin = {-11, 43}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
    cevaDpEq cevaDpEq1 annotation(Placement(visible = true, transformation(origin = {38, -4}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    odpor odpor1(r = 1) annotation(Placement(visible = true, transformation(origin = {-55, -17}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    chlopen chlopen2 annotation(Placement(visible = true, transformation(origin = {-24, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    odpor odpor2(r = 1) annotation(Placement(visible = true, transformation(origin = {71, -3}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    tlak tlak2(p = 2) annotation(Placement(visible = true, transformation(origin = {72, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    chlopen chlopen1 annotation(Placement(visible = true, transformation(origin = {6, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(cevaDpEq1.pq2, odpor2.pq1) annotation(Line(points = {{50, -4}, {58, -4}, {58, -2}, {58, -2}}));
    connect(chlopen1.pq2, cevaDpEq1.pq1) annotation(Line(points = {{15, -14}, {18, -14}, {18, -4}, {26, -4}, {26, -4}}));
    connect(kapacita1.pq1, chlopen2.pq2) annotation(Line(points = {{-11, 26}, {-12, 26}, {-12, -6}, {-8, -6}, {-8, -16}, {-14, -16}, {-14, -16}}));
    connect(chlopen2.pq2, chlopen1.pq1) annotation(Line(points = {{-15, -16}, {-10, -16}, {-10, -14}, {-2, -14}, {-2, -14}, {-2, -14}}));
    connect(odpor2.pq2, tlak2.pq1) annotation(Line(points = {{81, -3}, {90, -3}, {90, -55}, {81, -55}}));
    connect(odpor1.pq2, chlopen2.pq1) annotation(Line(points = {{-45, -17}, {-31, -17}, {-31, -16}, {-32, -16}}));
    connect(tlak1.pq1, odpor1.pq1) annotation(Line(points = {{-77, -23}, {-72, -23}, {-72, -17}, {-67, -17}}));
    connect(sine1.y, kapacita1.c) annotation(Line(points = {{-53, 52}, {-42, 52}, {-42, 56}, {-28, 56}, {-28, 56}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end finalModel;

  model experimentModel
    Modelica.Blocks.Sources.Sine sine1(amplitude = 1, freqHz = 1, offset = 1.1) annotation(Placement(visible = true, transformation(origin = {-64, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tlak tlak1(p = 1) annotation(Placement(visible = true, transformation(origin = {-86, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    kapacita kapacita1(v0 = 2) annotation(Placement(visible = true, transformation(origin = {-11, 43}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
    cevaDpBlock cevaDpBlock1 annotation(Placement(visible = true, transformation(origin = {38, -4}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    odpor odpor1(r = 1) annotation(Placement(visible = true, transformation(origin = {-55, -17}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    chlopen chlopen2 annotation(Placement(visible = true, transformation(origin = {-24, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    odpor odpor2(r = 1) annotation(Placement(visible = true, transformation(origin = {71, -3}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    tlak tlak2(p = 2) annotation(Placement(visible = true, transformation(origin = {72, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    chlopen chlopen1 annotation(Placement(visible = true, transformation(origin = {6, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(cevaDpBlock1.pq2, odpor2.pq1) annotation(Line(points = {{50, -4}, {58, -4}, {58, -2}, {58, -2}}));
    connect(chlopen1.pq2, cevaDpBlock1.pq1) annotation(Line(points = {{15, -14}, {18, -14}, {18, -4}, {26, -4}, {26, -4}}));
    connect(kapacita1.pq1, chlopen2.pq2) annotation(Line(points = {{-11, 26}, {-12, 26}, {-12, -6}, {-8, -6}, {-8, -16}, {-14, -16}, {-14, -16}}));
    connect(chlopen2.pq2, chlopen1.pq1) annotation(Line(points = {{-15, -16}, {-10, -16}, {-10, -14}, {-2, -14}, {-2, -14}, {-2, -14}}));
    connect(odpor2.pq2, tlak2.pq1) annotation(Line(points = {{81, -3}, {90, -3}, {90, -55}, {81, -55}}));
    connect(odpor1.pq2, chlopen2.pq1) annotation(Line(points = {{-45, -17}, {-31, -17}, {-31, -16}, {-32, -16}}));
    connect(tlak1.pq1, odpor1.pq1) annotation(Line(points = {{-77, -23}, {-72, -23}, {-72, -17}, {-67, -17}}));
    connect(sine1.y, kapacita1.c) annotation(Line(points = {{-53, 52}, {-42, 52}, {-42, 56}, {-28, 56}, {-28, 56}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end experimentModel;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end heat;