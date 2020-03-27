// ANAVI Door Opener 

// Set to false to change the design for left hand
isForRightHand = true;

// Set to false to change to 2D which is appropriate for laser cutting
is3D = true;

module roundedSquare( width, length, radiusCorner ) 
{
	translate( [ radiusCorner, radiusCorner, 0 ] )
	{
		minkowski()
		{
			square( [width - 2 * radiusCorner, length - 2 * radiusCorner], false);
			circle(radiusCorner, $fn=50);
		}
	}
}

module makeHanger()
{
	// Add a small sticking out part with edge for rotating knobs
	linear_extrude(height = 8, center = false, convexity = 10, twist = 0)
	translate([2,30.8])
		rotate([0,0,45])
			square([10,3],false);
}

module drawOpenerBase()
{
	difference()
	{
		union()
		{
			difference()
			{
				roundedSquare(78, 40, 5);
				
				translate([8,-10])
					roundedSquare(40, 42, 5);
				
				translate([64,18])
					circle(12, false, $fn=50);
				
				translate([74,36])
					circle(2, false, $fn=50);
				
				translate([74,4])
					circle(2, false, $fn=50);
				
				translate([0,33])
					rotate([0,0,45])
						square([10,3],false);
			}
			roundedSquare(12, 8, 2);
			
			translate([44,0])
				roundedSquare(8, 8, 2);
			
			translate([44,-8])
				roundedSquare(16, 14, 2);
		}
		
		translate([65,-10])
			circle(12, false, $fn=50);
		
		translate([61,54])
			circle(18, false, $fn=50);
	}
}

module makeOpenerBase()
{
	//Make it 3D
	if ( true == is3D)
	{
		linear_extrude(height = 5, center = false, convexity = 10, twist = 0)
			drawOpenerBase();
	}
	else
	{
			drawOpenerBase();
	}
}

module makeDoorOpener( rightHand )
{
	makeOpenerBase();
	// Add the the hanger only for the 3D model
	if ( true  == is3D )
	{
		if (true == rightHand)
		{
			translate([0,0,-3])
				makeHanger();
		}
		else
		{
			makeHanger();
		}
	}
}

if (true == isForRightHand)
{
	rotate([0,0,180])
		makeDoorOpener(rightHand);
}
else
{
	makeDoorOpener(rightHand);
}
