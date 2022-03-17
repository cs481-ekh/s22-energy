package application.Database.EnergyDB.Models;

import application.Model.UsageSummary;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import static javax.persistence.GenerationType.SEQUENCE;

/**
 * Entity for usage table in db.
 */
@Entity
@Table(schema = "public", name = "usage")
public class Usage {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id", unique = true, insertable = false)
	public int id;

	@Column(name = "building_code", nullable = false)
	public String buildingCode;

	@Column(name = "utility_id", nullable = false)
	public int utilityID;

	@Column(name = "time_stamp", nullable = false)
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss.SSS")
	public Timestamp timestamp;

	@Column(name = "usage", nullable = false)
	public BigDecimal utilityUsage;

	@Column(name = "cost", nullable = true)
	public BigDecimal cost;

	public Usage(){
		utilityUsage = new BigDecimal(0);
		cost = new BigDecimal(0);
		buildingCode = "0";
	}
}
