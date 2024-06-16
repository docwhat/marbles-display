// Units are mm.

marble = 25.4; // 1 inch
height = 10;
edge = 0.20 * marble;

intersection() {
    difference() {
        translate([0,0,height / 2])
            cube([edge + marble, edge + marble,height], true);
        translate([0,0,(height/2) + (marble/2)])
            sphere(marble/2);
    };
    translate([0,0, -1 * edge * 2])
        sphere(d=( 4*edge + marble));
}