package test.esof322.a1;

import static org.junit.Assert.*;

import org.junit.Test;

import esof322.a1.Vector3D;

public class Vector3DTest {

	@Test
	public void test() {
		fail("Not yet implemented");
	}
	@Test
	public void testNegate() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D neg = new Vector3D(-1, -2, -3);
		assertTrue(neg.equals( v.negate()));
	}

}
