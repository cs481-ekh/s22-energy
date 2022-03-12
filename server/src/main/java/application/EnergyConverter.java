package application;

import java.math.*;
import java.text.DecimalFormat;

// Class for Converting different energy types to BTU's
public class EnergyConverter {

    /**
     * Convert Therms to kBTU
     * @param therms
     * @return
     */
    public static BigDecimal thermsToKbtu(BigDecimal therms) {
        BigDecimal btu = therms.multiply(BigDecimal.valueOf(100000));
        return btuToKbtu(btu);
    }

    /**
     * Convert kWh to kBTU
     * @param kWh
     * @return
     */
    public static BigDecimal kWhToKbtu(BigDecimal kWh) {
        BigDecimal btu = kWh.multiply(BigDecimal.valueOf(3412.14163312794));
        return btuToKbtu(btu);
    }

    /**
     * Convert BTU to kBTU
     * @param btu
     * @return
     */
    public static BigDecimal btuToKbtu(BigDecimal btu) {
        return btu.divide(BigDecimal.valueOf(1000));
    }

    /**
     * Convert a BigDecimal to a string with format "0.###"
     * We will need this for our parsers because the BigDecimal 
     * constructor with a string works more cleanly than with a BigDecimal
     * @param num
     * @return
     */
    public static String toString(BigDecimal num) {
        DecimalFormat df = new DecimalFormat("0.###");
        return df.format(num);
    }
}
