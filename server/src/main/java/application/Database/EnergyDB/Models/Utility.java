package application.Database.EnergyDB.Models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity for utility table in db.
 */
@Entity
@Table(schema = "public", name = "utilities")
public class Utility {
	@Id
	@Column(name = "utility_id", nullable = false, unique = true)
	public int utilityID;

	@Column(name = "utility_type", nullable = false)
	public String utilityType;
}
