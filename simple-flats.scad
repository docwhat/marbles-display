// Units are mm.

$fn = 200;
marble = 25.4; // 1 inch
height = 10;
edge = 0.20 * marble;

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

intersection() {
  difference() {
      translate([0,0,height / 2])
          cube([edge + marble, edge + marble,height], true);

      linear_extrude(height = 0.5, center = true)
        rotate([0, 180, 0])
          // element("Al", "13", "2.699", "185.26");
          element("W", "74", "19.254", "1,321.6");

      translate([0,0,(height/2) + (marble/2)])
          sphere(marble/2);
    };
    translate([0, 0, -0.3 * edge])
      scale([2, 2, 1])
        sphere((sqrt(2) * from_center_to_edge)/2 );
}

// EOF
