include <common.scad>

module
basic_shape_of_case()
{
    minkowski()
    {
        translate([ 0, 0, 3 ]) linear_extrude(height = 16) offset(12)
            shape_of_small_case();
        sphere(r = 3, $fn = 30);
    }
}
module case ()
{
    difference()
    {
        basic_shape_of_case();
        tenting_holes(true);
        tenting_screw_housing(true);
        translate([ 0, 0, 3 ]) linear_extrude(height = 4) offset(1)
            shape_of_small_pcb();
        translate([ 0, 0, 7 ]) linear_extrude(height = 14) alpha_holes(14, 1);
        translate([ 0, 0, 7 ]) linear_extrude(height = 14) thumb_holes();
        translate([ 0, 0, 7 ]) linear_extrude(height = 7) promicro_space();
        translate([ 0, 0, 7 ]) linear_extrude(height = 7) trrs_hole();
        translate([ 0, 0, 7 ]) linear_extrude(height = 15) lcd_hole();
        translate([ 0, 0, 12 ]) linear_extrude(height = 14)
            alpha_holes(19.5, 1);
        translate([ 0, 0, 12 ]) linear_extrude(height = 14)
            thumb_holes(19.8, 19.8 * 1.5);
    }
}

intersection()
{
    case();
    cube(size=[500, 500, 14], center=true);
}

translate([0, 150, 0])
difference()
{
    case();
    cube(size=[500, 500, 14], center=true);
}