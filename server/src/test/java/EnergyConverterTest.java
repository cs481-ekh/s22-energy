import org.testng.annotations.Test;
import org.testng.asserts.*;
import java.text.DecimalFormat;

import application.EnergyConverter;


class EnergyConverterTest {
    // we want at least 3 decimal points of precision
    private final double DELTA = .0001;
    private Assertion a = new Assertion();


    @Test
    public void test1_btuToKbtu() {
        double btu = 5000;
        double kbtu = EnergyConverter.btuToKbtu(btu);
        a.assertEquals(kbtu, (double)5, DELTA);
    }

    @Test
    public void test2_btuToKbtu() {
        double btu = 12345;
        double kbtu = EnergyConverter.btuToKbtu(btu);
        a.assertEquals(kbtu, (double)12.345, DELTA);
    }

    @Test
    public void test3_btuToKbtu() {
        double btu = 12345.6789;
        double kbtu = EnergyConverter.btuToKbtu(btu);
        a.assertEquals(kbtu, (double)12.3456, DELTA);
    }

    @Test
    public void test1_kwhToKbtu() {
        double kWh = 1;
        double kbtu = EnergyConverter.kWhToKbtu(kWh);
        a.assertEquals(kbtu, (double)3.41214163312794, DELTA);
    }

    @Test
    public void test2_kwhToKbtu() {
        double kWh = 1;
        double kbtu = EnergyConverter.kWhToKbtu(kWh);
        a.assertEquals(kbtu, (double)3.4121, DELTA);
    }

    @Test
    public void test3_kwhToKbtu() {
        double kWh = 123;
        double kbtu = EnergyConverter.kWhToKbtu(kWh);
        a.assertEquals(kbtu, (double)419.693420875, DELTA);
    }

    @Test
    public void test1_thermsToKbtu() {
        double therms = 1;
        double kbtu = EnergyConverter.thermsToKbtu(therms);
        a.assertEquals(kbtu, (double)100, DELTA);
    }

    @Test
    public void test2_thermsToKbtu() {
        double therms = 12345;
        double kbtu = EnergyConverter.thermsToKbtu(therms);
        a.assertEquals(kbtu, (double)1234500, DELTA);
    }

    @Test
    public void test3_thermsToKbtu() {
        double therms = -1;
        double kbtu = EnergyConverter.thermsToKbtu(therms);
        a.assertEquals(kbtu, (double)-100, DELTA);
    }

    @Test
    public void test4_thermsToKbtu() {
        double therms = 0;
        double kbtu = EnergyConverter.thermsToKbtu(therms);
        a.assertEquals(kbtu, (double)0, DELTA);
    }
}
