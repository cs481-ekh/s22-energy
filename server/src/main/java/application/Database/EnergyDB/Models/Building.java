package application.Database.EnergyDB.Models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(schema = "public", name="buildings")
public class Building {
	@Id
	@Column(name="building_code", nullable = false, unique = true)
	public String buildingCode;

	@Column(name="abbreviation", nullable = true)
	public String abbreviation;

	@Column(name="building_name", nullable = false)
	public String buildingName;

	@Column(name="address", nullable = true)
	public String address;

	@Column(name="gross_sf", nullable = true)
	public int squareFt;

	@Column(name="year_built", nullable = true)
	public int yearBuilt;

	@Column(name="x_coord", nullable = true)
	public int xCoord;

	@Column(name="y_coord", nullable = true)
	public int yCoord;
}
