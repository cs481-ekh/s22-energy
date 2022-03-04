package application.Database.EnergyDB.Models;

import javax.persistence.*;

/**
 * Building entity that maps to our buildings table.
 */
@Entity
@Table(schema = "public", name = "buildings")
public class Building {
	@Id
	@Column(name = "building_code", nullable = false, unique = true)
	public String buildingCode;

	@Column(name = "abbreviation", nullable = true)
	public String abbreviation;

	@Column(name = "building_name", nullable = false)
	public String buildingName;

	@Column(name = "address", nullable = true)
	public String address;

	@Column(name = "gross_sf", nullable = true)
	public Integer squareFt;

	@Column(name = "year_built", nullable = true)
	public Integer yearBuilt;

	@Column(name = "x_coord", nullable = true)
	public Double xCoord;

	@Column(name = "y_coord", nullable = true)
	public Double yCoord;
}
