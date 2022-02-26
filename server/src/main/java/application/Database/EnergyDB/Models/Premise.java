package application.Database.EnergyDB.Models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(schema = "public", name="premise")
public class Premise {
	@Id
	@Column(name="premise_id", nullable = false, unique = true)
	public long premiseID;

	@Column(name="building_code", nullable = false)
	public String buildingCode;

	@Column(name="utility_id", nullable = false)
	public int utilityID;
}
