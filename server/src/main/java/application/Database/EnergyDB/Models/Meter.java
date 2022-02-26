package application.Database.EnergyDB.Models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Matches meter table schema in database.
 */
@Entity
@Table(schema = "public", name = "meter")
public class Meter {
	@Id
	@Column(name = "meter_id", nullable = false, unique = true)
	public int meterID;

	@Column(name = "utility_id", nullable = false)
	public int utilityID;

	@Column(name = "building_code", nullable = false)
	public String buildingCode;
}
