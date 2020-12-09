// Andre Betz
// github@AndreBetz.de

WandDicke               = 5;
TurmDurchmesser         = 40;
TurmHoehe               = 60;
CylinderD               = 12;
CylinderH               = 20;
KupplungH               = 10;
VerbindungLaenge        = 40;
VerbindungBreite        = 20;
VerbindungHoehe         = 30;
$fn=100;


module Turm(radius,hohe,wanddicke,cylinderD,cylinderH,kupplungH)
{   
    difference()
    {
        cylinder(r=radius/2,TurmHoehe);
        translate([0,0,-1])
            cylinder(r=radius/2-wanddicke,hohe+2);
    }
    cylinder(r=radius/2,wanddicke);
    difference()
    {
        translate([0,0,hohe])
            cylinder(r1=radius/2,r2=CylinderD/2,cylinderH);    
        translate([0,0,hohe-.5])
            cylinder(r1=radius/2-wanddicke,r2=CylinderD/2-wanddicke,cylinderH+1);
    }
    difference()
    {
        translate([0,0,hohe+cylinderH])
            cylinder(r=cylinderD/2,kupplungH);
        translate([0,0,hohe+cylinderH-1])
            cylinder(r=cylinderD/2-wanddicke,kupplungH+2);
    }    
}

module Dach(laenge,breite)
{
    translate([laenge,0,breite/2])
        rotate([0,-90,0])
            cylinder(laenge,breite,breite,center = false,$fn=3);
            
}

module Verbindung(laenge,hoehe,breite,wandicke)
{
    difference()
    {
        union()
        {
            difference()
            {
                translate([-(laenge+TurmDurchmesser)/2,0,0])
                    Dach(laenge+VerbindungLaenge,VerbindungBreite);
                translate([-laenge,0,0])
                     cylinder(r=TurmDurchmesser/2,TurmHoehe);
                translate([laenge,0,0])
                    cylinder(r=TurmDurchmesser/2,TurmHoehe);
            }
            translate([-laenge,0,0])
                Turm(TurmDurchmesser,TurmHoehe,WandDicke,CylinderD,CylinderH,KupplungH);
            translate([laenge,0,0])
                Turm(TurmDurchmesser,TurmHoehe,WandDicke,CylinderD,CylinderH,KupplungH);
            rotate([0,0,-90])    
                Dach(VerbindungLaenge,VerbindungBreite);
            translate([0,-VerbindungLaenge/2,WandDicke])
                cylinder(r=(CylinderD+WandDicke)/2,TurmHoehe+CylinderH/2);            
        }
        translate([-(laenge+TurmDurchmesser)/2,0,wandicke])
            Dach(laenge+TurmDurchmesser,VerbindungBreite-2*wandicke);
        rotate([0,0,-90])
            translate([-1,0,WandDicke])
                Dach(VerbindungLaenge-WandDicke,VerbindungBreite-2*WandDicke);
        translate([0,-VerbindungLaenge/2,WandDicke])
                cylinder(r=(CylinderD)/2,TurmHoehe+CylinderH+1);
    }
    difference()
    {
        translate([0,-VerbindungLaenge/2,TurmHoehe+CylinderH/2+WandDicke])
            cylinder(r1=(CylinderD+WandDicke)/2,r2=TurmDurchmesser/2,KupplungH+WandDicke);
        translate([0,-VerbindungLaenge/2,TurmHoehe+CylinderH/2+WandDicke-1])
            cylinder(r1=CylinderD/2,r2=TurmDurchmesser/2-WandDicke,KupplungH+WandDicke+2);
    }
}


difference()
{
    Verbindung(VerbindungLaenge,VerbindungBreite,VerbindungHoehe,WandDicke);
//    translate([-100,0,-1]) cube([200,100,100],center = false);
}
