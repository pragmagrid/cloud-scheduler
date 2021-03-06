
delete from resources;
alter table resources AUTO_INCREMENT = 1;
INSERT INTO resources VALUES  
(1,'SDSC cloud','UCSD/SDSC','admin@address','Rocks 6.2 KVM.\nHosting Virtual clusters and virtual machines',NULL,NULL,NULL,NULL,NULL,1,0,1,NULL,NULL,NULL,'resource-sdsc.png',1,NULL,NULL,'54f4e13a8e3d1',0,0,NULL,1,NULL,NULL),
(2,'UF cloud','University of Florida','admin@address','Rocks 6.2 KVM. ENT-enabled.\nHosting virtual clusters and virtual machines',NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,'resource-uf.png',1,NULL,NULL,'54f4e142c44b5',0,0,NULL,1,NULL,NULL);

delete from accessories;
alter table accessories AUTO_INCREMENT = 1;
insert into accessories (`accessory_id`, `accessory_name`, `accessory_quantity`) values
(1, 'accessory limited to 10', 10),
(2, 'accessory limited to 2', 2),
(3, 'unlimited accessory', NULL);

truncate table custom_attributes;
INSERT INTO `custom_attributes` VALUES
( 1, 'Available CPUs', 5, 4, '', 1, NULL, 1, NULL),
( 2, 'Available Gb Memory',  5, 4, '', 1, NULL, 2, NULL),
( 3, 'Deployment type',        3, 4, '', 1, 'Rocks KVM, OpenNebula, OpenStack, CloudStack', 3, NULL),
( 4, 'ENT-enabled',            3, 4, '', 1, 'yes, no', 4, NULL),
( 5, 'Affiliation',            1, 2, '', 1, NULL, 0, NULL),
( 6, 'SSH public key',         1, 2, '', 1, NULL, 1, NULL),
( 7, 'CPUs',         5, 1, '', 1, NULL, 1, NULL),
( 8, 'Memory (GB)',       5, 1, '', 1, NULL,2,NULL),
 (9, 'ENT-enabled',            3, 1, '', 1, 'yes, no', 4, NULL),
(10, 'Site hostname',          1, 4, '', 1, NULL, 5, NULL),
(11, 'VC Name',                3, 1, '', 1, 'docking,lmserver,lmcompute,rocks-sge-ipop', 5, NULL);

truncate table custom_attribute_values;
INSERT INTO `custom_attribute_values` VALUES
(1, 1, '16',         1, 4 ),
(2, 2, '32',         1, 4 ),
(3, 3, 'Rocks KVM',  1, 4 ),
(4, 4, 'no',         1, 4 ),
(5, 1, '32',         2, 4 ),
(6, 2, '64',         2, 4 ),
(7, 3, 'Rocks KVM',  2, 4 ),
(8, 4, 'yes',        2, 4 ),
(9, 11, 'pc-163.calit2.optiputer.net', 1, 4 ),
(10, 11, 'rocks-1.acis.ufl.edu', 2, 4 );

/* user_id resource_id, permission_id, add tuples if adding more users in install-admin.sql */
truncate table user_resource_permissions;
insert into user_resource_permissions values (1,1,1),(1,2,1);

