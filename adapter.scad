module my_strom_adapter() {
  h = 80;
  w = 52.3;
  round_h = 66;
  top_r = 31.8;
  depth = 38.4;

  color("blue")
    linear_extrude(depth) base();
  toggle();
  translate([w/2,53.9,depth]) plug_top();
  translate([w/2,52.8,0]) plug_bottom();
  
  module plug_top() {
    width = 42.6;
    w2 = 22/2;
    height = 26.8;
    h2 = 6/2;
    depth = 67.8;
    color("green") translate([-width/2,0,0]) linear_extrude(depth)
      polygon(points=[[width/2-w2,0],
        [0,height/2-h2],[0,height/2+h2],
        [width/2-w2,height], [width/2+w2,height],
        [width,height/2+h2],[width,height/2-h2],
        [width/2+w2,0], [width/2-w2,0]]);
  }

  module plug_bottom() {
    width = 35.3;
    w2 = 17.3/2;
    height = 19.8;
    depth = 31.6;
    color("green") translate([-width/2,0,-depth]) linear_extrude(depth)
      polygon(points=[[width/2-w2,0],
        [0, height/2], [width/2-w2,height],
        [width/2+w2,height],
        [width, height/2],
        [width/2+w2,0], [width/2-w2,0]]);
  }

  module toggle() {
    switch = [15.5, 14.9];
    color("blue") translate([w/2,0,switch[1]/2+7])
      cube([switch[0], .1, switch[1]], center=true);
  }

  module base() {
    intersection() {
      color("blue")
        translate([w/2, h-top_r])
        circle(top_r, $fn=360);
      translate([0, round_h])
        square([w, h-round_h]);
    }
    square([w, round_h]);
  }
}
