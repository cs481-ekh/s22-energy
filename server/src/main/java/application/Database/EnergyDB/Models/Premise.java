package application.Database.EnergyDB.Models;

import javax.persistence.*;
import java.util.List;

/**
 * Entity for premise table in db.
 */
@Entity
@Table(schema = "public", name="premise")
public class Premise {
	@Id
	@Column(name = "premise_id", nullable = false, unique = true)
	public long premiseID;

	@Column(name = "building_code", nullable = false)
	public String buildingCode;

	@Column(name = "utility_id", nullable = false)
	public int utilityID;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "building_code", insertable = false, updatable = false)
	public Building building;
}
