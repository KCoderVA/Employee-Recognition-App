~!testing!~
A new award nomination packet was submitted to you (Award Packet #@{triggerOutputs()?['body/ID']}), as a member of the Hines "Award Committee Triage Team. You can interact with this award nomination within [Microsoft Teams (click this link)](msteams://teams.microsoft.com/l/entity/2d4edd75-5a69-41da-bead-44c3a268ece8/approvals "Microsoft Teams Approvals"), by opening [Microsoft Approvals (click this link)](https://make.gov.powerautomate.us/environments/Default-e95f1b23-abaf-45ee-821d-b7ab251ab3bf/approvals/received "Microsoft PowerAutomate"), or via an email you should have recieved from Microsoft Power Automate (flow-noreply@microsoft.com). Please review the details below, and either re-route this packet to the appropriate award sub-committee OR return this back to sender with your free-text comments to request follow-up/additional information.

&nbsp;
@{concat(
if(not(equals(outputs('Get_Refreshed_Item_Info')?['body/Text_AwardType'],'None provided')), concat('**Award Type:**  ', outputs('Get_Refreshed_Item_Info')?['body/Text_AwardType']), '')
)}
@{concat(
if(not(equals(triggerOutputs()?['body/field_5'],'None provided')), concat('**Nominee''s Name:**  ', triggerOutputs()?['body/field_5']), '')
)}
@{concat(
if(not(equals(formatDateTime(convertTimeZone(triggerOutputs()?['body/field_7'], 'UTC', 'Central Standard Time'), 'MM/dd/yyyy hh:mm tt'),'None provided')), concat('**Event Date:**  ', formatDateTime(convertTimeZone(triggerOutputs()?['body/field_7'], 'UTC', 'Central Standard Time'), 'MM/dd/yyyy hh:mm tt')), '')
)}
@{concat(
if(not(equals(outputs('Compose.Location.Text'),'None provided')), concat('**Location:**  ', outputs('Compose.Location.Text')), '')
)}
@{concat(
if(not(equals(triggerOutputs()?['body/SafetyBoolean'],'None provided')), concat('**Event is a safety concern:**  ', triggerOutputs()?['body/SafetyBoolean']), '')
)}
@{concat(
if(not(equals(triggerOutputs()?['body/NursingBoolean'],'No')), concat('**Nominee part of Nursing Service:**  ', triggerOutputs()?['body/NursingBoolean']), '')
)}
@{concat(
if(not(equals(outputs('Compose.Integrity.Text'),'None provided')), concat('**Integrity Comments:**  ', outputs('Compose.Integrity.Text')), '')
)}
@{concat(
if(not(equals(outputs('Compose.Commitment.Text'),'None provided')), concat('**Commitment Comments:**  ', outputs('Compose.Commitment.Text')), '')
)}
@{concat(
if(not(equals(outputs('Compose.Advocacy.Text'),'None provided')), concat('**Advocacy Comments:**  ', outputs('Compose.Advocacy.Text')), '')
)}
@{concat(
if(not(equals(outputs('Compose.Respect.Text'),'None provided')), concat('**Respect Comments:**  ', outputs('Compose.Respect.Text')), '')
)}
@{concat(
if(not(equals(outputs('Compose.Excellence.Text'),'None provided')), concat('**Excellence Comments:**  ', outputs('Compose.Excellence.Text')), '')
)}
@{concat(
if(not(equals(outputs('Compose.AdditionalComments.Text'),'None provided')), concat('**Additional Comments:**  ', outputs('Compose.AdditionalComments.Text')), '')
)}
@{concat(
if(not(or(empty(outputs('Compose_NomineeServiceLine_Text')), equals(outputs('Compose_NomineeServiceLine_Text'),'None provided'))), concat('**Nominee''s Service Line:**  ', outputs('Compose_NomineeServiceLine_Text')), '')
)}
@{concat(
if(not(or(empty(outputs('Compose_HinesHero_Summary_Text')), equals(outputs('Compose_HinesHero_Summary_Text'),'None provided'))), concat('**Hines Hero Summary:**  ', outputs('Compose_HinesHero_Summary_Text')), '')
)}
@{concat(
if(not(or(empty(outputs('Compose_HinesHero_Details_Text')), equals(outputs('Compose_HinesHero_Details_Text'),'None provided'))), concat('**Hines Hero Details:**  ', outputs('Compose_HinesHero_Details_Text')), '')
)}
@{concat(
if(not(or(empty(outputs('Compose_HROContext_Text')), equals(outputs('Compose_HROContext_Text'),'None provided'))), concat('**HRO Context:**  ', outputs('Compose_HROContext_Text')), '')
)}
@{concat(
if(not(or(empty(outputs('Compose_HROActions_Text')), equals(outputs('Compose_HROActions_Text'),'None provided'))), concat('**HRO Actions:**  ', outputs('Compose_HROActions_Text')), '')
)}
@{concat(
if(not(or(empty(outputs('Compose_HROResults_Text')), equals(outputs('Compose_HROResults_Text'),'None provided'))), concat('**HRO Results:**  ', outputs('Compose_HROResults_Text')), '')
)}
@{concat(
if(not(or(empty(outputs('Compose_HROPrinciples_Text')), equals(outputs('Compose_HROPrinciples_Text'),'None provided'))), concat('**HRO Principles:**  ', outputs('Compose_HROPrinciples_Text')), '')
)}
@{concat(
if(not(or(empty(outputs('Compose_HROClinicOrNonclinic_Text')), equals(outputs('Compose_HROClinicOrNonclinic_Text'),'None provided'))), concat('**Clinical or Non-clinical:**  ', outputs('Compose_HROClinicOrNonclinic_Text')), '')
)}





























!KyleTest
A new award nomination packet was submitted to you (Award Packet #@{triggerOutputs()?['body/ID']}), as a member of the Hines "Award Committee Triage Team. Please review the details below, and either re-route this packet to the appropriate award sub-committee OR return this back to sender with your free-text comments to request follow-up/additional information. You can interact with this award nomination within [Microsoft Teams (click this link)](msteams://teams.microsoft.com/l/entity/2d4edd75-5a69-41da-bead-44c3a268ece8/approvals "Microsoft Teams Approvals"), by opening [Microsoft Approvals (click this link)](https://make.gov.powerautomate.us/environments/Default-e95f1b23-abaf-45ee-821d-b7ab251ab3bf/approvals/received "Microsoft PowerAutomate"), or via an email you should have recieved from Microsoft Power Automate (flow-noreply@microsoft.com).

@{outputs('Compose.HRO.Table')}