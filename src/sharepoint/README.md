# SharePoint Components

<!--
   Copyright 2025 Kyle J. Coder

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

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
