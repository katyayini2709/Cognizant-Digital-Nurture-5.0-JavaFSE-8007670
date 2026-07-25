import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class CalculatorTest {

    private Calculator calculator;

    @Before
    public void setUp() {
        calculator = new Calculator();
        System.out.println("Setup: Calculator object created");
    }

    @Test
    public void testAddition() {

        // Arrange
        int num1 = 15;
        int num2 = 5;

        // Act
        int result = calculator.add(num1, num2);

        // Assert
        assertEquals(20, result);

        System.out.println("Test executed successfully");
    }

    @After
    public void tearDown() {
        calculator = null;
        System.out.println("Teardown: Calculator object destroyed");
    }
}