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
    public static double thermsToKbtu(double therms) {
        double btu = therms * 100000;
        return btuToKbtu(btu);
    }

    /**
     * Convert kWh to kBTU
     * @param kWh
     * @return
     */
    public static double kWhToKbtu(double kWh) {
        double btu = kWh * 3412.14163312794;
        return btuToKbtu(btu);
    }

    /**
     * Convert BTU to kBTU
     * @param btu
     * @return
     */
    public static double btuToKbtu(double btu) {
        return btu / 1000;
    }

    /**
     * Convert a double to a string with format "0.##"
     * We will need this for our parsers because the BigDecimal 
     * constructor with a string works more cleanly than with a double
     * @param num
     * @return "0.##"
     */
    public static String doubleToString(double num) {
        DecimalFormat df = new DecimalFormat("0.##");
        return df.format(num);
    }
}
