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
	public Vector3D negate() {
		return new Vector3D(-xCoord, -yCoord, -zCoord);
	}
	


}
