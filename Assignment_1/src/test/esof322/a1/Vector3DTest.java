package test.esof322.a1;

import static org.junit.Assert.*;

import org.junit.Test;

import esof322.a1.Vector3D;

public class Vector3DTest {


	@Test
	public void testAdd() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D sum = new Vector3D(3, 6, 9);
		assertTrue(sum.equals(v.add(new Vector3D(2, 4, 6))));
	}
	
	@Test
	public void testNegate() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D neg = new Vector3D(-1, -2, -3);
		assertTrue(neg.equals(v.negate()));
	}

}
