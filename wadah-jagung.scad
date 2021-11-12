include <common.scad>

module
basic_shape_of_case()
{
    minkowski()
    {
        translate([ 0, 0, 3 ]) linear_extrude(height = 16) offset(12)
            shape_of_case();
        sphere(r = 3, $fn = 30);
    }
}

module case ()
{
    difference()
    {
        basic_shape_of_case();
        tenting_holes();
        tenting_screw_housing();
        translate([ 0, 0, 3 ]) linear_extrude(height = 4) offset(1)
            shape_of_pcb();
        translate([ 0, 0, 7 ]) linear_extrude(height = 14) alpha_holes();
        translate([ 0, 0, 7 ]) linear_extrude(height = 14) thumb_holes();
        translate([ 0, 0, 3 ]) linear_extrude(height = 11) promicro_space();
        translate([ 0, 0, 3 ]) linear_extrude(height = 11) trrs_hole();
        translate([ 0, 0, 7 ]) linear_extrude(height = 15) lcd_hole();
        translate([ 0, 0, 12 ]) linear_extrude(height = 14) alpha_holes(19.5);
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