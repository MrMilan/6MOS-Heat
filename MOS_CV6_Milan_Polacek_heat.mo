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
    con con1 annotation(Placement(visible = true, transformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    con con2 annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    con1.u - con2.u = r * con1.i;
    con1.i + con2.i = 0;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-4, -5}, extent = {{-64, 31}, {64, -31}})}));
  end odpor;

  model tok
    con con1 annotation(Placement(visible = true, transformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real u;
  equation
    con1.u = u;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {4, -15}, rotation = 45, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-36, 79}, {79, -36}}, radius = 13), Ellipse(origin = {-4, 16}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{30, -42}, {-16, 42}}, endAngle = 360), Text(origin = {5, -79}, extent = {{-49, 13}, {49, -13}}, textString = "%name")}));
  end tok;

  model DpBlock
    tok tok2 annotation(Placement(visible = true, transformation(origin = {69, -17}, extent = {{29, -29}, {-29, 29}}, rotation = 0)));
    tok tok1 annotation(Placement(visible = true, transformation(origin = {-67, -13}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end DpBlock;

  model kapacita
    con con1 annotation(Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput c "compliance" annotation(Placement(visible = true, transformation(origin = {-86, 86}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Real q;
    parameter Real q0 = 2;
  initial equation
    q = q0;
  equation
    con1.u = c * q;
    der(q) = con1.i;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {17, 37}, extent = {{-71, 45}, {49, -83}}, endAngle = 360), Line(origin = {-20, 20}, points = {{0, 40}, {0, -40}}, thickness = 4), Line(origin = {20, 20}, points = {{0, 40}, {0, -40}}, thickness = 4), Line(origin = {-56, 20}, points = {{34, 0}, {-34, 0}}), Line(origin = {56, 20}, points = {{34, 0}, {-34, 0}})}));
  end kapacita;

  connector con
    Real u;
    flow Real i;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-1, 2}, fillPattern = FillPattern.Solid, extent = {{-95, 94}, {95, -94}})}));
  end con;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end heat;