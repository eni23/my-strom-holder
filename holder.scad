space_between = 0.3;
in_w = 38.4+space_between*2;
in_h = 80+space_between*2;
in_d = 52.3+space_between*2;
wall_side = 3;
wall_z = 3;
border_radius = 4;

epsilon = 0.01;

w = in_w + wall_side*2;
h = in_h + wall_side*2;

module wall_mount() {
  difference() {
    linear_extrude(wall_z+in_d)
      plate();
    translate([0,wall_side-epsilon,wall_z+epsilon])
      inside();
    translate([-in_w/2,wall_side+space_between+52.8,in_d/2+wall_z])
      bottom_plug_cutout();
    translate([in_w/2,wall_side+space_between+57.6,wall_z])
      top_plug_cutout();
  }
}

module plate() {
  translate([-w/2,border_radius])
    square([w, h-border_radius]);
  translate([-w/2+border_radius,0])
    square([w-2*border_radius, h-border_radius]);
  translate([w/2-border_radius, border_radius])
    circle(border_radius);
  translate([-w/2+border_radius, border_radius])
    circle(border_radius);
}

module inside() {
  translate([-in_w/2,0,0])
    cube([in_w, in_h, in_d]);
}

module bottom_plug_cutout() {
  plug_d = 35.3;
  plug_h = 19.8;
  space_per_side = 1.5;
  my_h = plug_h + 2*space_per_side;
  my_d = plug_d + 2*space_per_side;
  translate([-wall_side-epsilon, -space_per_side, -my_d/2])
    cube([wall_side+2*epsilon, my_h, my_d]);
}

module top_plug_cutout() {
  plug_h = 20;
  plug_d_offset =  7.5;
  space_per_side = 1.5;
  my_h = plug_h+2*space_per_side;
  my_d = in_d - space_between - plug_d_offset;
  translate([-epsilon, -space_per_side, plug_d_offset+space_between+epsilon])
    cube([wall_side+2*epsilon, my_h, my_d]);
}
