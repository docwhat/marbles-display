// Units are mm.

$fn = 200;
marble = 25.4; // 1 inch
height = 10;
edge = 0.20 * marble;

// Squares in box are 32cm by 36cm.
x = 34; // mm
y = 30; // mm

// Distance along x or y axis from center to the nearest edge.
from_center_to_edge = marble/2 + edge;

module element(symbol, number, density, mass) {
  union() {
    text(symbol, halign = "center");
    translate([8, 8, 0])
      text(number, halign = "center", size = 2);
    translate([0, -5, 0])
      text(str(density, " g/cm³"), halign = "center", size = 3);
    translate([0, -10, 0])
      text(str(mass, " g"), halign = "center", size = 3);
  };
}

module non_element(name, density, mass) {
  union() {
    translate([0, 3, 0])
      text(name, halign = "center", size = 6);
    translate([0, -2, 0])
      text(str(density, " g/cm³"), halign = "center", size = 3);
    translate([0, -6, 0])
      text(str(mass, " g"), halign = "center", size = 3);
  };
}

intersection() {
  difference() {
      translate([0,0,height / 2])
          cube([x, y, height], true);

      linear_extrude(height = 0.5, center = true)
        rotate([0, 180, 0])
          // element("W", "74", "17.02", "146");
          non_element("Zirconia", "6.077", "52.14");

      translate([0,0,(height/2) + (marble/2)])
          sphere(marble/2);
    };
    translate([0, 0, -0.3 * edge])
      scale([2, 2, 1])
        sphere((sqrt(2) * from_center_to_edge)/2 );
}

// EOF
