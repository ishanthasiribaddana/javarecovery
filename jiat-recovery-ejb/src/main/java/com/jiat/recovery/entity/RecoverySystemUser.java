package com.jiat.recovery.entity;

import com.jiat.recovery.entity.enums.UserRole;
import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Recovery system user entity.
 */
@Entity
@Table(name = "recovery_system_user")
@NamedQueries({
    @NamedQuery(name = "RecoverySystemUser.findByUsername", 
                query = "SELECT u FROM RecoverySystemUser u WHERE u.username = :username AND u.isActive = true"),
    @NamedQuery(name = "RecoverySystemUser.findByEmail", 
                query = "SELECT u FROM RecoverySystemUser u WHERE u.email = :email AND u.isActive = true"),
    @NamedQuery(name = "RecoverySystemUser.findByRole", 
                query = "SELECT u FROM RecoverySystemUser u WHERE u.role = :role AND u.isActive = true"),
    @NamedQuery(name = "RecoverySystemUser.findByStudentId", 
                query = "SELECT u FROM RecoverySystemUser u WHERE u.studentSId = :studentSId AND u.isActive = true")
})
public class RecoverySystemUser extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username", unique = true, nullable = false, length = 100)
    private String username;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Column(name = "email")
    private String email;

    @Column(name = "full_name")
    private String fullName;

    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false)
    private UserRole role;

    @Column(name = "general_user_profile_gup_id")
    private Integer generalUserProfileGupId;

    @Column(name = "student_s_id")
    private Integer studentSId;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "last_login")
    private LocalDateTime lastLogin;

    @Column(name = "login_attempts")
    private Integer loginAttempts = 0;

    @Column(name = "is_locked")
    private Boolean isLocked = false;

    @Column(name = "locked_until")
    private LocalDateTime lockedUntil;

    @Column(name = "password_changed_at")
    private LocalDateTime passwordChangedAt;

    @Column(name = "must_change_password")
    private Boolean mustChangePassword = false;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public Integer getGeneralUserProfileGupId() {
        return generalUserProfileGupId;
    }

    public void setGeneralUserProfileGupId(Integer generalUserProfileGupId) {
        this.generalUserProfileGupId = generalUserProfileGupId;
    }

    public Integer getStudentSId() {
        return studentSId;
    }

    public void setStudentSId(Integer studentSId) {
        this.studentSId = studentSId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }

    public Integer getLoginAttempts() {
        return loginAttempts;
    }

    public void setLoginAttempts(Integer loginAttempts) {
        this.loginAttempts = loginAttempts;
    }

    public Boolean getIsLocked() {
        return isLocked;
    }

    public void setIsLocked(Boolean isLocked) {
        this.isLocked = isLocked;
    }

    public LocalDateTime getLockedUntil() {
        return lockedUntil;
    }

    public void setLockedUntil(LocalDateTime lockedUntil) {
        this.lockedUntil = lockedUntil;
    }

    public LocalDateTime getPasswordChangedAt() {
        return passwordChangedAt;
    }

    public void setPasswordChangedAt(LocalDateTime passwordChangedAt) {
        this.passwordChangedAt = passwordChangedAt;
    }

    public Boolean getMustChangePassword() {
        return mustChangePassword;
    }

    public void setMustChangePassword(Boolean mustChangePassword) {
        this.mustChangePassword = mustChangePassword;
    }

    public boolean isAccountLocked() {
        if (Boolean.TRUE.equals(isLocked)) {
            if (lockedUntil != null && LocalDateTime.now().isAfter(lockedUntil)) {
                return false; // Lock expired
            }
            return true;
        }
        return false;
    }
}
