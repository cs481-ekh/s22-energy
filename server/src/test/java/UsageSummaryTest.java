import application.Database.EnergyDB.Models.Usage;
import application.Model.UsageSummary;
import net.bytebuddy.build.Plugin;
import org.testng.annotations.Test;
import org.testng.asserts.Assertion;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UsageSummaryTest {
    private Assertion a = new Assertion();

    /**
     * Ensures that the timestamp is updating properly with one item
     */
    @Test
    public void ensureTimestampUpdates(){
        try{
            List<Usage> usageList = new ArrayList<Usage>();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/mm/yyyy");
            Date date = dateFormat.parse("23/09/2007");
            Usage usage = new Usage();
            usage.timestamp = new Timestamp(date.getTime());
            usageList.add(usage);

            UsageSummary summary = new UsageSummary();
            summary.generateSummary(usageList);

            a.assertEquals(usage.timestamp, summary.start);
            a.assertEquals(usage.timestamp, summary.end);

        }
        catch (Exception ex){
            a.fail();
        }
    }

    /**
     * Checks the sum values
     */
    @Test
    public void checkSums(){
        try{

            // Builds usage list
            List<Usage> usageList = new ArrayList<Usage>();
            Usage usage = new Usage();
            usage.cost = new BigDecimal(25);
            usage.utilityUsage = new BigDecimal(25);

            Usage usage2 = new Usage();
            usage2.utilityUsage = new BigDecimal(25);
            usage2.cost = new BigDecimal(25);

            usageList.add(usage);
            usageList.add(usage2);

            UsageSummary summary = new UsageSummary();
            summary.generateSummary(usageList);

            // Asserts cost and usage equality
            final int EQUAL = 0;
            BigDecimal expectedCost = new BigDecimal(50);
            BigDecimal expectedUsage = new BigDecimal(50);
            a.assertEquals(summary.cost.compareTo(expectedCost), EQUAL);
            a.assertEquals(summary.utilityUsage.compareTo(expectedUsage), EQUAL);
        }
        catch (Exception ex){
            a.fail();
        }
    }

    /**
     * Tests entire method with multiple usage objects
     */
    @Test
    public void endToEnd(){
        try{
            // Build objects
            List<Usage> usageList = new ArrayList<Usage>();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/mm/yyyy");
            Date date = dateFormat.parse("23/09/2007");
            Usage usage = new Usage();
            usage.utilityUsage = new BigDecimal(25);
            usage.cost = new BigDecimal(25);
            usage.timestamp = new Timestamp(date.getTime());

            Usage usage2 = new Usage();
            date = dateFormat.parse("23/09/2008");
            usage2.utilityUsage = new BigDecimal(25);
            usage2.cost = new BigDecimal(25);
            usage2.timestamp = new Timestamp(date.getTime());

            Usage usage3 = new Usage();
            date = dateFormat.parse("23/09/2005");
            usage3.utilityUsage = new BigDecimal(25);
            usage3.cost = new BigDecimal(25);
            usage3.timestamp = new Timestamp(date.getTime());

            Usage usage4 = new Usage();
            date = dateFormat.parse("23/09/2009");
            usage4.utilityUsage = new BigDecimal(25);
            usage4.cost = new BigDecimal(25);
            usage4.timestamp = new Timestamp(date.getTime());

            // Build list
            usageList.add(usage);
            usageList.add(usage2);
            usageList.add(usage3);
            usageList.add(usage4);

            // Generate summary
            UsageSummary summary = new UsageSummary();
            summary.generateSummary(usageList);

            // Expected values
            BigDecimal expectedCost = new BigDecimal(100);
            BigDecimal expectedUsage = new BigDecimal(100);

            final int EQUAL = 0;
            // Assert equality
            a.assertEquals(summary.cost.compareTo(expectedCost), EQUAL);
            a.assertEquals(summary.utilityUsage.compareTo(expectedUsage), EQUAL);
            a.assertEquals(usage3.timestamp, summary.start);
            a.assertEquals(usage4.timestamp, summary.end);

        }
        catch (Exception ex){
            a.fail();
        }
    }

}
