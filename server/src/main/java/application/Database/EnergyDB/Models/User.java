package application.Database.EnergyDB.Models;


import javax.persistence.*;


/**
 * Entity for users table in db.
 */
@Entity
@Table(schema = "public", name = "users")
public class User {
    protected User() {}

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id", unique = true, insertable = false)
    public int id;

    @Column(name = "email", nullable = false)
    public String email;

    @Column(name = "password", nullable = false)
    public String password;

    @Column(name = "admin", nullable = false)
    public Boolean admin;

    public User(String email, String password, boolean admin) {
        this.email = email;
        this.password = password;
        this.admin = admin;
    }
}
