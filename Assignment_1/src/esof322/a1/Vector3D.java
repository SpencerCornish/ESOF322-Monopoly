package esof322.a1;

public class Vector3D {
	private final double xCoord;
	private final double yCoord;
	private final double zCoord;

	public Vector3D(double xCoord, double yCoord, double zCoord) {
		this.xCoord = xCoord;
		this.yCoord = yCoord;
		this.zCoord = zCoord;
	}

	//Adds vector by returning a new vector with the coordinates of the parameter plus the this instance, produces new object
	public Vector3D add(Vector3D v) {
		return new Vector3D((xCoord + v.xCoord), (yCoord + v.yCoord), (zCoord + v.zCoord));
	}
	
	/// Negates the vector by returning a new vector with coordinates negated, produces new object
	public Vector3D negate() {
		return new Vector3D(-xCoord, -yCoord, -zCoord);
	}

	//Subtracts v's coordinates from coordinates in this, produces new object
	public Vector3D subtract(Vector3D v){
		return new Vector3D((xCoord - v.xCoord), (yCoord - v.yCoord), (zCoord - v.zCoord));
	}

	//Multiply each coordinate by value f, produce new object
	public Vector3D scale(double f) {
		return new Vector3D((f * xCoord), (f * yCoord), (f * zCoord));
	}
	
<<<<<<< HEAD
=======
	//Produces dot product of this and argument v, returns a double
	public double dot(Vector3D v){
		return this.xCoord*v.xCoord + this.yCoord*v.yCoord + this.zCoord*v.zCoord;
	}
	
	
	
	

>>>>>>> 1c48eb208e9dc8aa20d737efccc202b428d5e095
	@Override
	public boolean equals(Object o) {
		if (o instanceof Vector3D) {
			if (((Vector3D) o).xCoord == this.xCoord && ((Vector3D) o).yCoord == this.yCoord
					&& ((Vector3D) o).zCoord == this.zCoord) {
				return true;
			}
		}
		return false;
	}
}
