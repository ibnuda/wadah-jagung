
tenting_screw_positions = [
    [ 54, -120 ],
    [ 54, -75 ],
    [ 170, -57 ],
    [ 193, -147 ],
];

tenting_screw_rotation = [
    30,
    30,
    0,
    0,
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

module
tenting_holes()
{
    for (i = [0:len(tenting_screw_positions) - 1]) {
        translate(tenting_screw_positions[i]) linear_extrude(height = 25)
            tenting_hole();
    }
}

module
tenting_screw_housing()
{
    for (i = [0:len(tenting_screw_positions) - 1]) {
        translate(tenting_screw_positions[i]) translate([ 0, 0, 17 ])
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

module alpha_holes(width = 14)
{
    for (j = [0:2]) {
        for (i = [0:len(stagger) - 1]) {
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