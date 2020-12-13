// Andre Betz
// github@AndreBetz.de

// Form zum Aussgiessen mit Silikon

WandDicke   = 5;
StopfenD1   = 12;
StopfenD2   = 20;
StopfenH    = 25;
$fn=100;

difference()
{
    cylinder(r1=StopfenD1/2+WandDicke,r2=StopfenD2/2+WandDicke,StopfenH);
    translate([0,0,-.5])
        cylinder(r1=StopfenD1/2,r2=StopfenD2/2,StopfenH+1);
    translate([-100,0,-1]) 
        cube([200,100,100],center = false);
}