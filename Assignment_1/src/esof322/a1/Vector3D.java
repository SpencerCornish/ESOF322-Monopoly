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

	/// Negates the vector by returning a new vector with coordinates negated
	public Vector3D negate() {
		return new Vector3D(-xCoord, -yCoord, -zCoord);
	}

	public Vector3D scale(double f) {
		return new Vector3D((f * xCoord), (f * yCoord), (f * zCoord));
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
