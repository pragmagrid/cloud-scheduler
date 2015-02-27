
delete from resources;
alter table resources AUTO_INCREMENT = 1;
insert into resources (`resource_id`, `name`, `location`, `contact_info`, `description`, `notes`, `min_duration`, `min_increment`, `max_duration`, `unit_cost`, `autoassign`, `requires_approval`, `allow_multiday_reservations`, `max_participants`, `min_notice_time`, `max_notice_time`, `image_name`, `legacyid`, `schedule_id`) VALUES
(1, 'Conference Room 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL, NULL, 'resource1.jpg', NULL, 1),
(2, 'Conference Room 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL, NULL, 'resource2.jpg', NULL, 1);

delete from accessories;
alter table accessories AUTO_INCREMENT = 1;
insert into accessories (`accessory_id`, `accessory_name`, `accessory_quantity`) values
(1, 'accessory limited to 10', 10),
(2, 'accessory limited to 2', 2),
(3, 'unlimited accessory', NULL);

truncate table custom_attributes;
insert into custom_attributes(`custom_attribute_id`,`display_label`,`display_type`,`attribute_category`,`validation_regex`,`is_required`,`possible_values`) VALUES
(1, 'Test Number', 1, 1, null, false, null),
(2, 'Test String', 1, 1, null, false, null),
(3, 'Test Number', 1, 4, null, false, null),
(4, 'Test String', 1, 4, null, false, null);

/* user_id resource_id, permission_id, add tuples if adding more users in install-admin.sql */
truncate table user_resource_permissions;
insert into user_resource_permissions values (1,1,1),(1,2,1);

