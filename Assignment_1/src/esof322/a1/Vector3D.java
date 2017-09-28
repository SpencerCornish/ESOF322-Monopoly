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

	// Adds vector by returning a new vector with the coordinates of the parameter
	// plus the this instance, produces new object
	public Vector3D add(Vector3D v) {
		return new Vector3D((xCoord + v.xCoord), (yCoord + v.yCoord), (zCoord + v.zCoord));
	}

	/// Negates the vector by returning a new vector with coordinates negated,
	/// produces new object
	public Vector3D negate() {
		return new Vector3D(-xCoord, -yCoord, -zCoord);
	}

	// Subtracts v's coordinates from coordinates in this, produces new object
	public Vector3D subtract(Vector3D v) {
		return new Vector3D((xCoord - v.xCoord), (yCoord - v.yCoord), (zCoord - v.zCoord));
	}

	// Multiply each coordinate by value f, produce new object
	public Vector3D scale(double f) {
		return new Vector3D((f * xCoord), (f * yCoord), (f * zCoord));
	}

	// Produces dot product of this and argument v, returns a double
	public double dot(Vector3D v) {
		return this.xCoord * v.xCoord + this.yCoord * v.yCoord + this.zCoord * v.zCoord;
	}

	// Calculates the magnitude of vector3D
	public double magnitude() {
		return (Math.sqrt(xCoord * xCoord + yCoord * yCoord + zCoord * zCoord));
	}

	@Override
	public String toString() {
		return ("The X coordinate is: " + xCoord + " The Y coordinate is: " + yCoord + " The Z coordinate is: "
				+ zCoord);
	}

	@Override
	public boolean equals(Object o) {
		double precision = 0.001;
		double differenceX = Math.abs(((Vector3D) o).xCoord - this.xCoord);
		double differenceY = Math.abs(((Vector3D) o).yCoord - this.yCoord);
		double differenceZ = Math.abs(((Vector3D) o).zCoord - this.zCoord);
		if (differenceX < precision && differenceY < precision && differenceZ < precision) {
			return true;
		}

		return false;
	}
}
