package com.jiat.recovery.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

/**
 * Exchange rate history entity.
 */
@Entity
@Table(name = "recovery_exchange_rate")
@NamedQueries({
    @NamedQuery(name = "RecoveryExchangeRate.findByDate", 
                query = "SELECT e FROM RecoveryExchangeRate e WHERE e.fromCurrencyId = :fromCurrencyId AND e.toCurrencyId = :toCurrencyId AND e.rateDate = :rateDate AND e.isActive = true"),
    @NamedQuery(name = "RecoveryExchangeRate.findLatest", 
                query = "SELECT e FROM RecoveryExchangeRate e WHERE e.fromCurrencyId = :fromCurrencyId AND e.toCurrencyId = :toCurrencyId AND e.isActive = true ORDER BY e.rateDate DESC"),
    @NamedQuery(name = "RecoveryExchangeRate.findByDateRange", 
                query = "SELECT e FROM RecoveryExchangeRate e WHERE e.fromCurrencyId = :fromCurrencyId AND e.toCurrencyId = :toCurrencyId AND e.rateDate BETWEEN :startDate AND :endDate AND e.isActive = true ORDER BY e.rateDate DESC")
})
public class RecoveryExchangeRate extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "from_currency_id", nullable = false)
    private Integer fromCurrencyId;

    @Column(name = "to_currency_id", nullable = false)
    private Integer toCurrencyId;

    @Column(name = "rate", nullable = false)
    private Double rate;

    @Column(name = "rate_date", nullable = false)
    private LocalDate rateDate;

    @Column(name = "source", length = 100)
    private String source;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getFromCurrencyId() {
        return fromCurrencyId;
    }

    public void setFromCurrencyId(Integer fromCurrencyId) {
        this.fromCurrencyId = fromCurrencyId;
    }

    public Integer getToCurrencyId() {
        return toCurrencyId;
    }

    public void setToCurrencyId(Integer toCurrencyId) {
        this.toCurrencyId = toCurrencyId;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public LocalDate getRateDate() {
        return rateDate;
    }

    public void setRateDate(LocalDate rateDate) {
        this.rateDate = rateDate;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    /**
     * Convert an amount using this exchange rate.
     */
    public Double convert(Double amount) {
        if (amount == null || rate == null) {
            return null;
        }
        return amount * rate;
    }

    /**
     * Create a GBP to LKR exchange rate.
     */
    public static RecoveryExchangeRate createGbpToLkr(Double rate, LocalDate date, String source) {
        RecoveryExchangeRate exchangeRate = new RecoveryExchangeRate();
        exchangeRate.setFromCurrencyId(2); // GBP
        exchangeRate.setToCurrencyId(1);   // LKR
        exchangeRate.setRate(rate);
        exchangeRate.setRateDate(date);
        exchangeRate.setSource(source);
        return exchangeRate;
    }
}
