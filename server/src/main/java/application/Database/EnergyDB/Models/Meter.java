package application.Database.EnergyDB.Models;

import javax.persistence.*;

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
	public Integer utilityID;

	@Column(name = "building_code", nullable = false)
	public String buildingCode;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "building_code", insertable = false, updatable = false)
	public Building building;
}
