Show all active parcel / letters in distripution center

SELECT distribution_center.distribution_center_id FROM distribution_center WHERE is_active = 1;

Show all active parcel / letters from all carries

SELECT mail_carries.mail_carries_id FROM mail_carries WHERE is_active = 1;

Get the ID from employee on processing

SELECT processing.processing_id, fk_empl_id FROM processing INNER JOIN employee ON employee.employee_id	= fk_empl_id

Get the Name from employee on processing

SELECT processing.processing_id, staff.first_name, staff.last_name FROM processing INNER JOIN employee ON employee.employee_id	= fk_empl_id
INNER JOIN staff on staff.staff_id = employee.fk_staff_id