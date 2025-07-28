import openpyxl
import json

# Load the Excel file
wb = openpyxl.load_workbook('Stakeholder Request Log.xlsx')
ws = wb.active

# Extract all rows as a list of dicts (assuming headers in first row)
rows = list(ws.iter_rows(values_only=True))
headers = [str(h).strip() for h in rows[0]]
data = [dict(zip(headers, row)) for row in rows[1:] if any(row)]

# Save as JSON for further processing
with open('Stakeholder_Request_Log.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print(f"Extracted {len(data)} rows from Excel.")
