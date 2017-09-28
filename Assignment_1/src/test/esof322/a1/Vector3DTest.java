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
	@Test
	public void testScale() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D scale = new Vector3D(10, 20, 30);
		assertTrue(scale.equals(v.scale(10)));
	}

	@Test
	public void testSubtract() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D diff = new Vector3D(-1, -1, -1);
		assertTrue(diff.equals(v.subtract(new Vector3D(2, 3, 4))));
	}
	@Test
	public void testDot() {
		Vector3D v = new Vector3D(1, 2, 3);
		double dot = 14;
		assertTrue(dot == v.dot(new Vector3D(1, 2, 3)));
	}
	
	@Test
	public void testMgnitude() {
		Vector3D v = new Vector3D(1, 2, 3);
		double diff = Math.abs(3.74 - v.magnitude());
		assertTrue(diff <= 1);	
	}
	
	@Test
	public void testEquals() {
		Vector3D vector1 = new Vector3D(1, 2, 3);
		Vector3D vector2 = new Vector3D(1, 2, 3.1);
		assertFalse(vector1.equals(vector2));
		
		//  Check precision
		Vector3D vectorP1 = new Vector3D(1, 2, 3);
		Vector3D vectorP2= new Vector3D(1, 2, 3.000000001);
		assertTrue(vectorP1.equals(vectorP2));
	}

}
