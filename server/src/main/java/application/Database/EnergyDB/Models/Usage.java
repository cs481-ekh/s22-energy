package application.Database.EnergyDB.Models;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(schema = "public", name = "usage")
public class Usage {
	@Id
	@Column(name="id", nullable = false, unique = true)
	public int id;

	@Column(name="building_code", nullable = false)
	public String buildingCode;

	@Column(name="utility_id", nullable = false)
	public int utilityID;

	@Column(name="time_stamp", nullable = false)
	public Timestamp timestamp;

	@Column(name="usage", nullable = false)
	public BigDecimal usage;

	@Column(name="cost", nullable = true)
	public BigDecimal cost;
}
