package com.jiat.recovery.entity.readonly;

import jakarta.persistence.*;
import java.io.Serializable;

/**
 * Read-only JPA entity for existing currency_type table.
 */
@Entity
@Table(name = "currency_type")
@NamedQueries({
    @NamedQuery(name = "CurrencyType.findAll", 
                query = "SELECT c FROM CurrencyType c WHERE c.isActive = true"),
    @NamedQuery(name = "CurrencyType.findByName", 
                query = "SELECT c FROM CurrencyType c WHERE c.name = :name AND c.isActive = true")
})
public class CurrencyType implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "is_active")
    private Boolean isActive;

    // Getters only
    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public boolean isLkr() {
        return id != null && id == 1;
    }

    public boolean isGbp() {
        return id != null && id == 2;
    }
}
