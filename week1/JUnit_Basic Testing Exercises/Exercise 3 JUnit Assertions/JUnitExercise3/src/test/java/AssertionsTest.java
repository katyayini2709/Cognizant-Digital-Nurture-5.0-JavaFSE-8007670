import org.junit.Test;

import static org.junit.Assert.*;

public class AssertionsTest {

    @Test
    public void testAssertions() {

        // Check if values are equal
        assertEquals(10, 4 + 6);
        System.out.println("Equal assertion passed");

        // Check if condition is true
        assertTrue(20 > 15);
        System.out.println("True assertion passed");

        // Check if condition is false
        assertFalse(8 < 5);
        System.out.println("False assertion passed");

        // Check for null value
        String name = null;
        assertNull(name);
        System.out.println("Null assertion passed");

        // Check for non-null value
        String course = "JUnit";
        assertNotNull(course);
        System.out.println("Not Null assertion passed");
    }
}