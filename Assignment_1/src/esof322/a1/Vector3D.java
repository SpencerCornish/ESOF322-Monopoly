package esof322.a1;

public class Vector3D {
	int xCoord;
	int yCoord;
	int zCoord;

	public Vector3D(int xCoord, int yCoord, int zCoord) {
		this.xCoord = xCoord;
		this.yCoord = yCoord;
		this.zCoord = zCoord;
	}

	/// Negates the vector by returning a new vector with coordinates negated
	public Vector3D negate() {
		return new Vector3D(-xCoord, -yCoord, -zCoord);
	}

	//Subtracts v's coordinates from coordinates in this, produces new object
	public Vector3D subtract(Vector3D v){
		return new Vector3D((xCoord - v.xCoord), (yCoord - v.yCoord), (zCoord - v.zCoord));
	}

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
