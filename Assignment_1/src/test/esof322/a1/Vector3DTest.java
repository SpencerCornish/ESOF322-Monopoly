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
	public void testScale() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D scale = new Vector3D(10, 20, 30);
		assertTrue(scale.equals(v.scale(10)));
	}

}
