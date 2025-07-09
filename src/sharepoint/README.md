# SharePoint Components

This folder contains SharePoint lists, pages, and queries for the Employee Recognition project.

## Structure

- `lists/` - SharePoint list schemas and configurations
- `pages/` - Custom SharePoint pages and web parts
- `queries/` - Power Query and data extraction scripts

## SharePoint Lists

### Employee Recognition Lists
- **[Employee Nominations](./lists/employee-nominations.md)** - Award nominations and submissions
- **[User Profiles](./lists/user-profiles.md)** - Employee directory and profiles
- **[Award Categories](./lists/award-categories.md)** - Award types and categories
- **[Admin Settings](./lists/admin-settings.md)** - Application configuration settings
- **[Audit Log](./lists/audit-log.md)** - Comprehensive audit trail and activity logs

### Data Management
- Regular exports for backup and analysis
- Query optimizations for performance
- Content type management

## Development Guidelines

### Naming Conventions
- Lists: Use PascalCase (EmployeeAwards, AwardCategories)
- Columns: Use clear, descriptive names
- Content Types: Follow organizational standards

### Best Practices
- Use content types for structured data
- Implement proper permissions and security
- Document list relationships and dependencies
- Regular backup and maintenance schedules

## Security Considerations
- Follow principle of least privilege
- Regular permission audits
- Secure sensitive employee data
- Compliance with organizational policies
