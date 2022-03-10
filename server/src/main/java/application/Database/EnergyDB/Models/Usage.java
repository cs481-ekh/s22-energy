package application.Database.EnergyDB.Models;

import application.Model.UsageSummary;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Entity;
import javax.persistence.Column;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

/**
 * Entity for usage table in db.
 */
@Entity
@Table(schema = "public", name = "usage")
public class Usage {

	@Id
	@Column(name = "id", nullable = false, unique = true)
	public int id;

	@Column(name = "building_code", nullable = false)
	public String buildingCode;

	@Column(name = "utility_id", nullable = false)
	public int utilityID;

	@Column(name = "time_stamp", nullable = false)
	public Timestamp timestamp;

	@Column(name = "usage", nullable = false)
	public BigDecimal utilityUsage;

	@Column(name = "cost", nullable = true)
	public BigDecimal cost;

	public Usage(){
		utilityUsage = new BigDecimal(0);
		cost = new BigDecimal(0);
	}
}
