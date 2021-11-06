
tenting_screw_positions = [
    [ 170, -57 ],
    [ 193, -147 ],
    [ 54, -120 ],
    [ 54, -75 ],
];

tenting_screw_small_positions = [
    [ 170, -57 ],
    [ 193, -147 ],
    [ 71.5, -97.5 ],
];

tenting_screw_rotation = [
    0,
    0,
    30,
    30,
];

tightening_screw_positions = [
    [ 17.5, -26, 0 ],
    [ 18.5, -88, 0 ],
    [ 81.0, -116, 0 ],
    [ 118.5, -132.5, 0 ],
    [ 139, -88.5, 0 ],
    [ 140, -56.5, 0 ],
    [ 140, -20.5, 0 ],
    [ 112.5, -17.2, 0 ],
    [ 71, -8.6, 0 ]
];

stagger = [ -77.125, -77.125, -72.375, -70, -72.375, -74.75 ];

module sector(radius, angles, fn = 60)
{
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat(
        [[ 0, 0 ]],
        [for (a = [angles[0]:step:angles[1] - 360])[r * cos(a), r * sin(a)]],
        [[r * cos(angles[1]), r * sin(angles[1])]]);

    difference()
    {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 60)
{
    difference()
    {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
}

module
tenting_hole()
{
    circle(r = 3.2, $fn = 30);
}

module tenting_holes(small = false)
{
    tenting_location =
        small ? tenting_screw_small_positions : tenting_screw_positions;
    for (i = [0:len(tenting_location) - 1]) {
        translate(tenting_location[i]) linear_extrude(height = 25)
            tenting_hole();
    }
}

module tenting_screw_housing(small = false)
{
    tenting_location =
        small ? tenting_screw_small_positions : tenting_screw_positions;
    for (i = [0:len(tenting_location) - 1]) {
        translate(tenting_location[i]) translate([ 0, 0, 17 ])
            rotate(tenting_screw_rotation[i]) linear_extrude(height = 5.5)
                circle(r = 6.5, $fn = 6);
    }
}

module
tightening_hole()
{
    circle(r = 1.2);
}

module
promicro_space()
{
    polygon(points = [
        [ 175, -67 ],
        [ 180, -67 ],
        [ 180, -10 ],
        [ 191, -10 ],
        [ 191, -67 ],
        [ 196, -67 ],
        [ 196, -103.5 ],
        [ 175, -103.5 ],
    ]);
}

module
lcd_hole()
{
    polygon(points = [
        [ 179.5, -103.5 ],
        [ 179.5, -107 ],
        [ 190.5, -107 ],
        [ 190.5, -103.5 ],
    ]);
}

module
trrs_hole()
{
    polygon(points = [
        [ 181, -111 ],
        [ 181, -121 ],
        [ 281, -121 ],
        [ 281, -111 ],
    ]);
}

module alpha_holes(width = 14, start = 0)
{
    for (j = [0:2]) {
        for (i = [start:len(stagger) - 1]) {
            translate([ (70 + i * 19), (stagger[i] - j * 19), 0 ])
            {
                square(size = [ width, width ], center = true);
            }
        }
    }
}

module thumb_holes(width = 14, long_thumb = 14)
{
    union()
    {
        translate([ 136.5, -130, 0 ])
        {
            rotate([ 0, 0, 0 ])
            {
                square(size = [ width, width ], center = true);
            }
        }
        translate([ 157.5, -132.75, 0 ])
        {
            rotate([ 0, 0, 165 ])
            {
                square(size = [ width, width ], center = true);
            }
        }
        translate([ 179.75, -136.5, 0 ])
        {
            rotate([ 0, 0, 240 ])
            {
                square(size = [ long_thumb, width ], center = true);
            }
        }
    }
}

integrated_tenting_screw_positions = [
    [ 16.3, -23.5 ],
    [ 16.3, -153 ],
    [ 88, -154 ],
    [ 140.5, -101 ],
    [ 140, -18.1 ],
];

module
shape_of_pcb()
{
    import("shape-of-pcb.dxf");
}

module
shape_of_small_pcb()
{
    import("shape-of-small-pcb.dxf");
}

module
shape_of_case()
{
    upper_angles = [ 66.7, 112.6 ];
    lower_angles_a = [ 60, 90 ];
    lower_angles_b = [ 40, 210 ];
    difference()
    {
        union()
        {
            translate([ 127, -226 ]) sector(172.65, upper_angles, 72);
            polygon(points = [
                [ 60.75, -66.70 ],
                [ 60.75, -124.55 ],
                [ 127.76, -139.55 ],
                [ 180.76, -153.55 ],
                [ 195.23, -128.56 ],
                [ 195.23, -67.56 ],
            ]);
        }
        translate([ 57, -301 ]) sector(176.3, lower_angles_a, 72);
        translate([ 132, -240 ]) sector(99, lower_angles_b, 72);
    }
}

module
shape_of_small_case()
{
    top_angles = [ 59, 120.3 ];
    top_center = [ 136.5, -164.5 ];
    top_radius = 112.6;
    left_angles = [ 165.4, 194.5 ];
    left_center = [ 190, -96 ];
    left_radius = 113.9;
    lower_left_angles = [ 0, 180 ];
    lower_left_center = [ 80, -210 ];
    lower_left_radius = 85.42;
    lower_right_angles = [ 0, 180 ];
    lower_right_center = [ 125, -262 ];
    lower_right_radius = 121.5;
    right_angles = [ -8.9, 10.3 ];
    right_center = [ 4.5, -102.5 ];
    right_radius = 193.55;
    difference()
    {
        union()
        {
            translate(top_center) sector(top_radius, top_angles);
            translate(left_center) sector(left_radius, left_angles);
            difference()
            {
                translate(right_center) sector(right_radius, right_angles);
                square(size = [ 300, 300 ], center = true);
            }
            polygon(points = [
                [ 80, -68 ],
                [ 80, -125 ],
                [ 127, -139 ],
                [ 143.5, -142 ],
                [ 182.5, -157.5 ],
                [ 195.5, -132.2 ],
                [ 193.75, -68 ],
            ]);
        }
        translate(lower_right_center)
            sector(lower_right_radius, lower_right_angles);
        translate(lower_left_center)
            sector(lower_left_radius, lower_left_angles);
    }
}