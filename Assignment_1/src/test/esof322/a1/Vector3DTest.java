package test.esof322.a1;

import static org.junit.Assert.*;

import org.junit.Test;

import esof322.a1.Vector3D;

public class Vector3DTest {


	@Test
	public void testNegate() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D neg = new Vector3D(-1, -2, -3);
		assertTrue(neg.equals(v.negate()));
	}

	@Test
	public void testSubtract() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D diff = new Vector3D(-1, -1, -1);
		assertTrue(diff.equals(v.subtract(new Vector3D(2, 3, 4))));
	}

}
