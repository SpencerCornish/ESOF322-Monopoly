package esof322.pa1;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class Vector3DTest {

	//tests toString method; creates a test vector and asserts that the string produces is the expected string
	@Test
	public void testToString() {
		Vector3D v = new Vector3D(1, 2, 3);
		assertTrue(v.toString().equals("The X coordinate is: 1.0 The Y coordinate is: 2.0 The Z coordinate is: 3.0"));
	}
	
	//tests our equals override method; creates vectors and tests the tolerance built in (tolerance is within 0.001)
	@Test
	public void testEquals() {
		Vector3D vector1 = new Vector3D(1, 2, 3);
		Vector3D vector2 = new Vector3D(1, 2, 3.1);
		assertFalse(vector1.equals(vector2));
		//self equality test
		assertTrue(vector1.equals(vector1));

		// Check precision
		Vector3D vectorP1 = new Vector3D(1, 2, 3);
		Vector3D vectorP2 = new Vector3D(1, 2.00000001, 3);
		assertTrue(vectorP1.equals(vectorP2));
	}
	
	//tests scale method against what the scaled vector should be
	@Test
	public void testScale() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D scale = new Vector3D(10, 20, 30);
		//tests scaling by 10
		assertTrue(scale.equals(v.scale(10)));
		//tests scaling by the unit scale (should equal itself)
		assertTrue(v.equals(v.scale(1)));
	}
	
	//tests add method against what the added value should be
	@Test
	public void testAdd() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D sum = new Vector3D(3, 6, 9);
		assertTrue(sum.equals(v.add(new Vector3D(2, 4, 6))));
	}
	
	//tests subtract method against what the subtracted value should be
	@Test
	public void testSubtract() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D diff = new Vector3D(-1, -1, -1);
		assertTrue(diff.equals(v.subtract(new Vector3D(2, 3, 4))));
	}
	
	//tests negate method against what the negated vector should be
	@Test
	public void testNegate() {
		Vector3D v = new Vector3D(1, 2, 3);
		Vector3D neg = new Vector3D(-1, -2, -3);
		assertTrue(neg.equals(v.negate()));
	}
	
	//tests dot method against what the dot product of the two vectors should be (in this case, 
	//the vector is dotted with itself
	@Test
	public void testDot() {
		Vector3D v = new Vector3D(1, 2, 3);
		double dot = 14;
		assertTrue(dot == v.dot(new Vector3D(1, 2, 3)));
	}
	
	//tests magnitude method against what the vector's magnitude value should be
	@Test
	public void testMagnitude() {
		Vector3D v = new Vector3D(1, 2, 3);
		double diff = Math.abs(3.74 - v.magnitude());
		assertTrue(diff <= 1);
	}
	
	//tests that the constructor creates a new instance of Vector3D - extraneous but implemented
	//for 100% code coverage, and for practice.
	@Test
	public void testConstructor() {
		Vector3D v = new Vector3D(1, 2, 3);
		assertTrue(v != null);
	}
}
