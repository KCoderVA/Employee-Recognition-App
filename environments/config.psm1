# Power Platform Development Configuration
# Environment-specific settings for Employee Recognition App

# Development Environment
$DevConfig = @{
    Environment = "Development"
    TenantId = "YOUR_TENANT_ID"
    EnvironmentUrl = "https://YOUR_DEV_ENV.crm.dynamics.com"
    SharePointSite = "https://YOUR_TENANT.sharepoint.com/sites/dev-employee-recognition"

    # App Configuration
    AppDisplayName = "Employee Recognition App (Dev)"
    AppDescription = "Development version of Employee Recognition application"

    # Security Settings
    SecurityGroup = "Employee_Recognition_Dev_Users"
    AdminGroup = "Employee_Recognition_Dev_Admins"

    # SharePoint Lists
    Lists = @{
        Nominations = "Employee_Nominations_Dev"
        Awards = "Award_Types_Dev"
        Approvers = "Approvers_Dev"
        AuditLog = "Audit_Log_Dev"
    }

    # Email Settings
    NotificationFromEmail = "dev-employee-recognition@yourdomain.com"
    EmailTemplateLibrary = "Dev_Email_Templates"

    # Features
    Features = @{
        EnableAuditLogging = $true
        EnableEmailNotifications = $true
        EnableApprovalWorkflow = $true
        EnableBulkActions = $false
        MaxAttachmentSize = 10 # MB
    }
}

# Production Environment
$ProdConfig = @{
    Environment = "Production"
    TenantId = "YOUR_TENANT_ID"
    EnvironmentUrl = "https://YOUR_PROD_ENV.crm.dynamics.com"
    SharePointSite = "https://YOUR_TENANT.sharepoint.com/sites/employee-recognition"

    # App Configuration
    AppDisplayName = "Employee Recognition App"
    AppDescription = "Official Employee Recognition application for VA Healthcare"

    # Security Settings
    SecurityGroup = "Employee_Recognition_Users"
    AdminGroup = "Employee_Recognition_Admins"

    # SharePoint Lists
    Lists = @{
        Nominations = "Employee_Nominations"
        Awards = "Award_Types"
        Approvers = "Approvers"
        AuditLog = "Audit_Log"
    }

    # Email Settings
    NotificationFromEmail = "employee-recognition@va.gov"
    EmailTemplateLibrary = "Email_Templates"

    # Features
    Features = @{
        EnableAuditLogging = $true
        EnableEmailNotifications = $true
        EnableApprovalWorkflow = $true
        EnableBulkActions = $true
        MaxAttachmentSize = 25 # MB
    }
}

# Export configurations
Export-ModuleMember -Variable DevConfig, ProdConfig
