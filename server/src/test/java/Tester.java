import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;
import org.testng.asserts.Assertion;

/**
 * Tester class.
 */
class Tester {

    private transient int number;

    /**
     * Sets up the class.
     */
    @BeforeClass
    public void setup() {
        number = 12;
    }

    /**
     * Tears down the class.
     */
    @AfterClass
    public void ngTearDown() {
        number = 0;
    }

    /**
     * Tests numbers.
     */
    @Test
    public void givenNumberTest() {
        int myNumber = 9;
        Assertion asserter = new Assertion();
        asserter.assertTrue(number > myNumber);
    }

}
