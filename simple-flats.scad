// Units are mm.

$fn = 200;
marble = 25.4; // 1 inch
height = 10;
edge = 0.20 * marble;

// Distance along x or y axis from center to the nearest edge.
from_center_to_edge = marble/2 + edge;

intersection() {
// union() {
    difference() {
        translate([0,0,height / 2])
            cube([edge + marble, edge + marble,height], true);

        rotate([0, 180, 0])
          text("Al", halign = "center");
        rotate([0, 180, 0])
          translate([8, 8, 0])
            text("13", halign = "center", size = 2);
        rotate([0, 180, 0])
          translate([0, -5, 0])
            text("2.699 g/cm³", halign = "center", size = 3);
        rotate([0, 180, 0])
          translate([0, -10, 0])
            text("185.26 g", halign = "center", size = 3);

        translate([0,0,(height/2) + (marble/2)])
            sphere(marble/2);
    };
    translate([0, 0, -0.3 * edge])
      scale([2, 2, 1])
        sphere((sqrt(2) * from_center_to_edge)/2 );
}

// EOF
