import org.testng.annotations.Test;
import org.testng.asserts.*;

import java.math.BigDecimal;
import java.text.DecimalFormat;

import application.EnergyConverter;


class EnergyConverterTest {
    // we want at least 3 decimal points of precision
//    private final var DELTA = .0001;
    private Assertion a = new Assertion();


    @Test
    public void test1_btuToKbtu() {
        var btu = BigDecimal.valueOf(5000);
        var kbtu = EnergyConverter.btuToKbtu(btu);
        a.assertEquals(kbtu.compareTo(BigDecimal.valueOf(5)), 0);
    }

    @Test
    public void test2_btuToKbtu() {
        var btu = BigDecimal.valueOf(12345);
        var kbtu = EnergyConverter.btuToKbtu(btu);
        a.assertEquals(kbtu.compareTo(BigDecimal.valueOf(12.345)), 0);
    }

    @Test
    public void test3_btuToKbtu() {
        var btu = BigDecimal.valueOf(12345.6789);
        var kbtu = EnergyConverter.btuToKbtu(btu);
        a.assertEquals(kbtu.compareTo(BigDecimal.valueOf(12.3456789)), 0);
    }

    @Test
    public void test4_kwhToKbtu() {
        var kWh = BigDecimal.valueOf(1);
        var kbtu = EnergyConverter.kWhToKbtu(kWh);
        a.assertEquals(kbtu.compareTo(BigDecimal.valueOf(3.41214163312794)),0);
    }

    @Test
    public void test5_kwhToKbtu() {
        var kWh = BigDecimal.valueOf(1);
        var kbtu = EnergyConverter.kWhToKbtu(kWh);
        a.assertEquals(kbtu.compareTo(BigDecimal.valueOf(3.41214163312794)), 0);
    }

    @Test
    public void test6_thermsToKbtu() {
        var therms = BigDecimal.valueOf(1);
        var kbtu = EnergyConverter.thermsToKbtu(therms);
        a.assertEquals(kbtu.compareTo(BigDecimal.valueOf(100)), 0);
    }

    @Test
    public void test7_thermsToKbtu() {
        var therms = BigDecimal.valueOf(12345);
        var kbtu = EnergyConverter.thermsToKbtu(therms);
        a.assertEquals(kbtu.compareTo(BigDecimal.valueOf(1234500)), 0);
    }

    @Test
    public void test8_thermsToKbtu() {
        var therms = BigDecimal.valueOf(-1);
        var kbtu = EnergyConverter.thermsToKbtu(therms);
        a.assertEquals(kbtu.compareTo(BigDecimal.valueOf(-100)), 0);
    }

    @Test
    public void test9_thermsToKbtu() {
        var therms = BigDecimal.valueOf(0);
        var kbtu = EnergyConverter.thermsToKbtu(therms);
        a.assertEquals(kbtu.compareTo(BigDecimal.valueOf(0)), 0);
    }
}
