BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "app_customer" (
	"id"	integer NOT NULL,
	"name"	varchar(200) NOT NULL,
	"locality"	varchar(200) NOT NULL,
	"city"	varchar(50) NOT NULL,
	"zipcode"	integer NOT NULL,
	"state"	varchar(50) NOT NULL,
	"user_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "app_product" (
	"id"	integer NOT NULL,
	"title"	varchar(100) NOT NULL,
	"selling_price"	real NOT NULL,
	"discounted_price"	real NOT NULL,
	"description"	text NOT NULL,
	"brand"	varchar(100) NOT NULL,
	"category"	varchar(2) NOT NULL,
	"product_image"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_orderplaced" (
	"id"	integer NOT NULL,
	"quantity"	integer unsigned NOT NULL CHECK("quantity" >= 0),
	"ordered_date"	datetime NOT NULL,
	"status"	varchar(50) NOT NULL,
	"customer_id"	bigint NOT NULL,
	"product_id"	bigint NOT NULL,
	"user_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("product_id") REFERENCES "app_product"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("customer_id") REFERENCES "app_customer"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "app_cart" (
	"id"	integer NOT NULL,
	"quantity"	integer unsigned NOT NULL CHECK("quantity" >= 0),
	"product_id"	bigint NOT NULL,
	"user_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("product_id") REFERENCES "app_product"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2022-06-24 17:13:03.882843');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2022-06-24 17:13:03.931848');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2022-06-24 17:13:03.969851');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2022-06-24 17:13:03.995852');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2022-06-24 17:13:04.043856');
INSERT INTO "django_migrations" VALUES (6,'app','0001_initial','2022-06-24 17:13:04.120861');
INSERT INTO "django_migrations" VALUES (7,'contenttypes','0002_remove_content_type_name','2022-06-24 17:13:04.167863');
INSERT INTO "django_migrations" VALUES (8,'auth','0002_alter_permission_name_max_length','2022-06-24 17:13:04.195866');
INSERT INTO "django_migrations" VALUES (9,'auth','0003_alter_user_email_max_length','2022-06-24 17:13:04.226870');
INSERT INTO "django_migrations" VALUES (10,'auth','0004_alter_user_username_opts','2022-06-24 17:13:04.249872');
INSERT INTO "django_migrations" VALUES (11,'auth','0005_alter_user_last_login_null','2022-06-24 17:13:04.282873');
INSERT INTO "django_migrations" VALUES (12,'auth','0006_require_contenttypes_0002','2022-06-24 17:13:04.295875');
INSERT INTO "django_migrations" VALUES (13,'auth','0007_alter_validators_add_error_messages','2022-06-24 17:13:04.320877');
INSERT INTO "django_migrations" VALUES (14,'auth','0008_alter_user_username_max_length','2022-06-24 17:13:04.360879');
INSERT INTO "django_migrations" VALUES (15,'auth','0009_alter_user_last_name_max_length','2022-06-24 17:13:04.394882');
INSERT INTO "django_migrations" VALUES (16,'auth','0010_alter_group_name_max_length','2022-06-24 17:13:04.427885');
INSERT INTO "django_migrations" VALUES (17,'auth','0011_update_proxy_permissions','2022-06-24 17:13:04.470888');
INSERT INTO "django_migrations" VALUES (18,'auth','0012_alter_user_first_name_max_length','2022-06-24 17:13:04.498894');
INSERT INTO "django_migrations" VALUES (19,'sessions','0001_initial','2022-06-24 17:13:04.511891');
INSERT INTO "django_admin_log" VALUES (1,'2022-06-24 17:25:17.703346','1','Product object (1)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (2,'2022-06-24 17:28:37.176965','2','Product object (2)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (3,'2022-06-24 18:25:41.059191','3','Product object (3)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (4,'2022-06-24 18:26:14.034399','4','Product object (4)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (5,'2022-06-24 18:26:46.163138','5','Product object (5)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (6,'2022-06-24 18:27:39.978344','6','Product object (6)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (7,'2022-06-24 18:28:36.566701','7','Product object (7)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (8,'2022-06-24 18:29:27.033120','8','Product object (8)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (9,'2022-06-24 18:29:52.595881','9','Product object (9)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (10,'2022-06-24 18:30:50.944300','10','Product object (10)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (11,'2022-06-24 18:31:22.331159','11','Product object (11)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (12,'2022-06-24 18:31:55.877981','12','Product object (12)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (13,'2022-06-24 18:32:23.995080','13','Product object (13)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (14,'2022-06-24 18:32:58.368930','14','Product object (14)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (15,'2022-06-24 18:33:34.425773','15','Product object (15)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (16,'2022-06-24 18:34:02.373302','3','Product object (3)','[{"changed": {"fields": ["Description"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (17,'2022-06-24 18:34:10.451226','6','Product object (6)','[{"changed": {"fields": ["Description"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (18,'2022-06-24 18:34:17.226504','5','Product object (5)','[{"changed": {"fields": ["Description"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (19,'2022-06-24 18:34:23.726072','4','Product object (4)','[{"changed": {"fields": ["Description"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (20,'2022-06-24 20:06:36.935590','15','Product object (15)','[{"changed": {"fields": ["Selling price", "Discounted price"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (21,'2022-06-25 09:11:41.185273','16','Product object (16)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (22,'2022-06-25 09:12:54.545880','17','Product object (17)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (23,'2022-06-25 09:13:55.708137','18','Product object (18)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (24,'2022-06-25 09:15:25.104518','19','Product object (19)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (25,'2022-06-25 09:16:34.577268','20','Product object (20)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (26,'2022-06-25 09:18:50.316077','21','Product object (21)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (27,'2022-06-25 09:20:25.330754','22','Product object (22)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (28,'2022-06-25 10:57:57.937032','2','21mci1127','',4,1,3);
INSERT INTO "django_admin_log" VALUES (29,'2022-06-26 09:58:56.814863','1','Product object (1)','[{"changed": {"fields": ["Discounted price"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (30,'2022-06-26 10:45:01.606295','8','Cart object (8)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (31,'2022-06-26 10:45:01.617297','7','Cart object (7)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (32,'2022-06-26 10:47:13.604898','9','Cart object (9)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (33,'2022-06-26 10:48:47.062524','10','Cart object (10)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (34,'2022-06-26 11:56:03.326772','12','Cart object (12)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (35,'2022-06-26 12:06:12.180311','1','Cart object (1)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (36,'2022-06-26 14:10:05.097248','2','OrderPlaced object (2)','[{"changed": {"fields": ["Status"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (37,'2022-06-26 14:10:23.488662','1','OrderPlaced object (1)','[{"changed": {"fields": ["Status"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (38,'2022-06-26 14:54:20.319403','3','OrderPlaced object (3)','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (39,'2022-06-26 14:54:33.054684','1','OrderPlaced object (1)','[{"changed": {"fields": ["Status"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (40,'2022-06-26 14:54:40.799247','2','OrderPlaced object (2)','[{"changed": {"fields": ["Status"]}}]',9,1,2);
INSERT INTO "app_customer" VALUES (1,'Mahesh Sharma','Padrauna','Padrauna',274304,' Uttar Pradesh ',5);
INSERT INTO "app_customer" VALUES (2,'Rahul','GKP','Pad',12345432,' Kerala ',5);
INSERT INTO "app_customer" VALUES (3,'Mahesh Sharma','Padrauna','Padrauna',274304,' Uttar Pradesh ',1);
INSERT INTO "app_customer" VALUES (4,'Rahul','Lakhnow','Lakhnow',123454,' Uttar Pradesh ',4);
INSERT INTO "app_product" VALUES (1,'Shirt 1',700.0,500.0,'Style Code : DOBBY_532_NAM
Ideal For : Men
Suitable For : Western Wear
Pack Of : 1
Pocket Type : Patch Pocket
Reversible : No
Sales Package : 1 Jean
Closure : Button','Broen','TW',' productimg/tp1.jpg');
INSERT INTO "app_product" VALUES (2,'Shert 2',900.0,300.0,'Style Code : DOBBY_532_NAM
Ideal For : Men
Suitable For : Western Wear
Pack Of : 1
Pocket Type : Patch Pocket
Reversible : No
Sales Package : 1 Jean
Closure : Button','Lzard','TW',' productimg/tp2.jpg');
INSERT INTO "app_product" VALUES (3,'Shert 3',600.0,98.0,'Style Code : DOBBY_532_NAM
Ideal For : Men
Suitable For : Western Wear
Pack Of : 1
Pocket Type : Patch Pocket
Reversible : No
Sales Package : 1 Jean
Closure : Button','Lzard','TW',' productimg/tp3.jpg');
INSERT INTO "app_product" VALUES (4,'Shert 4',700.0,88.0,'Style Code : DOBBY_532_NAM
Ideal For : Men
Suitable For : Western Wear
Pack Of : 1
Pocket Type : Patch Pocket
Reversible : No
Sales Package : 1 Jean
Closure : Button','Broen','TW',' productimg/tp4.jpg');
INSERT INTO "app_product" VALUES (5,'Shert 5',999.0,98.0,'Style Code : DOBBY_532_NAM
Ideal For : Men
Suitable For : Western Wear
Pack Of : 1
Pocket Type : Patch Pocket
Reversible : No
Sales Package : 1 Jean
Closure : Button','Lzard','TW',' productimg/tp5.jpg');
INSERT INTO "app_product" VALUES (6,'Shert 6',1000.0,9.0,'Style Code : DOBBY_532_NAM
Ideal For : Men
Suitable For : Western Wear
Pack Of : 1
Pocket Type : Patch Pocket
Reversible : No
Sales Package : 1 Jean
Closure : Button','Broen','TW',' productimg/tp6.jpg');
INSERT INTO "app_product" VALUES (7,'Wear 1',777.0,7.0,'Style Code : DOBBY_532_NAM
Ideal For : Men
Suitable For : Western Wear
Pack Of : 1
Pocket Type : Patch Pocket
Reversible : No
Sales Package : 1 Jean
Closure : Button','Lzard','BW',' productimg/bw1.jpg');
INSERT INTO "app_product" VALUES (8,'Wear 2',500.0,90.0,'Style Code : DOBBY_532_NAM
Ideal For : Men
Suitable For : Western Wear
Pack Of : 1
Pocket Type : Patch Pocket
Reversible : No
Sales Package : 1 Jean
Closure : Button','Broen','BW',' productimg/bw2.jpg');
INSERT INTO "app_product" VALUES (9,'Wear',300.0,1.0,'Style Code : DOBBY_532_NAM
Ideal For : Men
Suitable For : Western Wear
Pack Of : 1
Pocket Type : Patch Pocket
Reversible : No
Sales Package : 1 Jean
Closure : Button','Lzard','BW',' productimg/bw3.jpg');
INSERT INTO "app_product" VALUES (10,'Redmi 9C',9000.0,1000.0,'In The Box
Handset, Power Adapter, Micro-USB Cable, SIM Ejector Tool, User Guide and Warranty Card
Model Number
MZB0A0KIN
Model Name
C31
Color
Royal Blue
Browse Type
Smartphones
SIM Type
Dual Sim
Hybrid Sim Slot
No
Touchscreen
Yes
OTG Compatible
Yes
SAR Value
Head: 0.506 W/Kg, Body: 0.833 W/Kg','Redmi','M',' productimg/m1.jpg');
INSERT INTO "app_product" VALUES (11,'Realme C11',19000.0,900.0,'In The Box
Handset, Power Adapter, Micro-USB Cable, SIM Ejector Tool, User Guide and Warranty Card
Model Number
MZB0A0KIN
Model Name
C31
Color
Royal Blue
Browse Type
Smartphones
SIM Type
Dual Sim
Hybrid Sim Slot
No
Touchscreen
Yes
OTG Compatible
Yes
SAR Value
Head: 0.506 W/Kg, Body: 0.833 W/Kg','Broen','M',' productimg/m2.jpg');
INSERT INTO "app_product" VALUES (12,'Realme C2',8000.0,99.0,'In The Box
Handset, Power Adapter, Micro-USB Cable, SIM Ejector Tool, User Guide and Warranty Card
Model Number
MZB0A0KIN
Model Name
C31
Color
Royal Blue
Browse Type
Smartphones
SIM Type
Dual Sim
Hybrid Sim Slot
No
Touchscreen
Yes
OTG Compatible
Yes
SAR Value
Head: 0.506 W/Kg, Body: 0.833 W/Kg','Realme','M',' productimg/m3.jpg');
INSERT INTO "app_product" VALUES (13,'Moto G5',9900.0,80.0,'In The Box
Handset, Power Adapter, Micro-USB Cable, SIM Ejector Tool, User Guide and Warranty Card
Model Number
MZB0A0KIN
Model Name
C31
Color
Royal Blue
Browse Type
Smartphones
SIM Type
Dual Sim
Hybrid Sim Slot
No
Touchscreen
Yes
OTG Compatible
Yes
SAR Value
Head: 0.506 W/Kg, Body: 0.833 W/Kg','Moto','M',' productimg/m4.jpg');
INSERT INTO "app_product" VALUES (14,'Nokia GT45',1300.0,50.0,'In The Box
Handset, Power Adapter, Micro-USB Cable, SIM Ejector Tool, User Guide and Warranty Card
Model Number
MZB0A0KIN
Model Name
C31
Color
Royal Blue
Browse Type
Smartphones
SIM Type
Dual Sim
Hybrid Sim Slot
No
Touchscreen
Yes
OTG Compatible
Yes
SAR Value
Head: 0.506 W/Kg, Body: 0.833 W/Kg','Nokia','M',' productimg/m7.jpg');
INSERT INTO "app_product" VALUES (15,'Redmi 7',15000.0,11000.0,'In The Box
Handset, Power Adapter, Micro-USB Cable, SIM Ejector Tool, User Guide and Warranty Card
Model Number
MZB0A0KIN
Model Name
C31
Color
Royal Blue
Browse Type
Smartphones
SIM Type
Dual Sim
Hybrid Sim Slot
No
Touchscreen
Yes
OTG Compatible
Yes
SAR Value
Head: 0.506 W/Kg, Body: 0.833 W/Kg','Redmi','M',' productimg/m6.jpg');
INSERT INTO "app_product" VALUES (16,'MSI GF63 Thin Hexa Core i5 10th Gen - (8 GB/1 TB HDD/256 GB SSD/Windows 10 Home/4 GB Graphics/NVIDIA',76900.0,55900.0,'This MSI gaming laptop features a SteelSeries silver-lining printing keyboard that only enhances the appeal of the laptop but also ensures lasting build quality. This gaming laptop also ensures quiet and cool performance even under heavy load. And, with Hi-resolution Audio, you can experience rich sound while playing music, streaming content, gaming, and so on.','MSI','L',' productimg/l1.jpg');
INSERT INTO "app_product" VALUES (17,'ASUS TUF Gaming F15 Core i5 11th Gen - (8 GB/1 TB SSD/Windows 10 Home/4 GB Graphics/NVIDIA GeForce R',116000.0,75900.0,'ASUS TUF Gaming F15 Core i5 11th Gen - (8 GB/1 TB SSD/Windows 10 Home/4 GB Graphics/NVIDIA GeForce RTX 3050/144 Hz) FX506HCB-HN228T Gaming Laptop  (15.6 inch, Graphite Black, 2.30 kg)','Asus','L',' productimg/l2.jpg');
INSERT INTO "app_product" VALUES (18,'ASUS TUF Gaming',88000.0,46000.0,'You can upgrade the Windows 10 OS of this laptop to Windows 11 OS for free. The upgrade is scheduled to initiate in late 2021 which will continue into 2022, and the timing of the upgrade will vary by device. Also, certain features of Windows 11 may require specific hardware that you can check on the Microsoft website.','Asus','L',' productimg/l5.jpg');
INSERT INTO "app_product" VALUES (19,'MSI Gaming Leptop',110000.0,90000.0,'Sales Package
Laptop, Power Adaptor, User Guide, Warranty Documents
Model Number
FX506HCB-HN228T
Part Number
90NR0724-M06710
Model Name
FX506HCB-HN228T
Series
TUF Gaming F15
Color
Graphite Black
Type
Gaming Laptop
Suitable For
Gaming
Power Supply
180W AC Adapter
Battery Cell
4 Cell
MS Office Provided
No','MSI','L',' productimg/l4.jpg');
INSERT INTO "app_product" VALUES (20,'Asus Notebook Serices',150000.0,130000.0,'Sales Package
Laptop, Power Adaptor, User Guide, Warranty Documents
Model Number
FX506HCB-HN228T
Part Number
90NR0724-M06710
Model Name
FX506HCB-HN228T
Series
TUF Gaming F15
Color
Graphite Black
Type
Gaming Laptop
Suitable For
Gaming
Power Supply
180W AC Adapter
Battery Cell
4 Cell
MS Office Provided
Yes','Asus','L',' productimg/l7.jpg');
INSERT INTO "app_product" VALUES (21,'Lenovo IdeaPad 3 Core i3 11th Gen - (8 GB/512 GB SSD/Windows 11 Home) 15ITL6 Thin and Light Laptop',64990.0,54000.0,'Lenovo IdeaPad 3 Core i3 11th Gen - (8 GB/512 GB SSD/Windows 11 Home) 15ITL6 Thin and Light Laptop  (15.6 inch, Arctic Grey, 1.65 kg, With MS Office)
Lenovo IdeaPad 3 Core i3 11th Gen - (8 GB/512 GB SSD/Windows 11 Home) 15ITL6 Thin and Light Laptop  (15.6 inch, Arctic Grey, 1.65 kg, With MS Office)
Lenovo IdeaPad 3 Core i3 11th Gen - (8 GB/512 GB SSD/Windows 11 Home) 15ITL6 Thin and Light Laptop  (15.6 inch, Arctic Grey, 1.65 kg, With MS Office)','Lenovo','L',' productimg/l14.jpg');
INSERT INTO "app_product" VALUES (22,'HP Core i3 11th Gen - (8 GB/256 GB SSD/Windows 11 Home) 14s- dy2506TU Thin and Light Laptop  (14 inc',48933.0,36990.0,'General
Sales Package
Laptop, Power Adaptor, Battery, Warranty Documents, User Guide
Model Number
14s- dy2506TU
Part Number
546K2PA#ACJ
Model Name
14s- dy2506TU
Color
Natural Silver
Type
Thin and Light Laptop
Suitable For
Processing & Multitasking
Battery Cell
3 Cell
MS Office Provided
Yes
Processor And Memory Features
Processor Brand
Intel
Processor Name
Core i3
Processor Generation
11th Gen
SSD
Yes
SSD Capacity
256 GB
RAM
8 GB
RAM Type
DDR4
Processor Variant
1125G4
Clock Speed
1.7 GHz Upto Max Turbo Frequency at 4.1 GHz
Cache
8
Graphic Processor
Intel Integrated UHD
Number of Cores
4
Operating System
OS Architecture
64 bit
Operating System
Windows 11 Home
Supported Operating System
Windows 11 Home
System Architecture
64 bit
Port And Slot Features
Mic In
Yes
USB Port
1 x SuperSpeed USB Type-C 5Gbps signaling rate, 2 x SuperSpeed USB Type-A 5Gbps signaling rate
HDMI Port
1 x HDMI 1.4b
Multi Card Slot
1 multi-format SD media card reader
Hardware Interface
PCIe NVMe M.2
Display And Audio Features
Touchscreen
No
Screen Size
35.56 cm (14 inch)
Screen Resolution
1920 x 1080 Pixel
Screen Type
Full HD, IPS Brightview,micro-edge,WLED- Backlit, Brightness: 250 nits, 157 ppi, Color Gamut: 45%NTSC
Speakers
Built-in Dual Speakers
Internal Mic
Built-in Dual Array Microphone','HP','L',' productimg/l9.jpg');
INSERT INTO "app_orderplaced" VALUES (1,2,'2022-06-26 13:15:16.403037',' On The Way ',1,8,5);
INSERT INTO "app_orderplaced" VALUES (2,1,'2022-06-26 13:15:16.428026',' Delivered ',1,2,5);
INSERT INTO "app_orderplaced" VALUES (3,5,'2022-06-26 14:54:20.317416',' Accepted ',3,6,5);
INSERT INTO "app_orderplaced" VALUES (4,5,'2022-06-26 17:45:24.141897','Pending',2,2,5);
INSERT INTO "app_orderplaced" VALUES (5,4,'2022-06-26 17:45:24.167898','Pending',2,1,5);
INSERT INTO "app_cart" VALUES (26,1,2,4);
INSERT INTO "app_cart" VALUES (31,1,11,5);
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'app','customer');
INSERT INTO "django_content_type" VALUES (8,'app','product');
INSERT INTO "django_content_type" VALUES (9,'app','orderplaced');
INSERT INTO "django_content_type" VALUES (10,'app','cart');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_customer','Can add customer');
INSERT INTO "auth_permission" VALUES (26,7,'change_customer','Can change customer');
INSERT INTO "auth_permission" VALUES (27,7,'delete_customer','Can delete customer');
INSERT INTO "auth_permission" VALUES (28,7,'view_customer','Can view customer');
INSERT INTO "auth_permission" VALUES (29,8,'add_product','Can add product');
INSERT INTO "auth_permission" VALUES (30,8,'change_product','Can change product');
INSERT INTO "auth_permission" VALUES (31,8,'delete_product','Can delete product');
INSERT INTO "auth_permission" VALUES (32,8,'view_product','Can view product');
INSERT INTO "auth_permission" VALUES (33,9,'add_orderplaced','Can add order placed');
INSERT INTO "auth_permission" VALUES (34,9,'change_orderplaced','Can change order placed');
INSERT INTO "auth_permission" VALUES (35,9,'delete_orderplaced','Can delete order placed');
INSERT INTO "auth_permission" VALUES (36,9,'view_orderplaced','Can view order placed');
INSERT INTO "auth_permission" VALUES (37,10,'add_cart','Can add cart');
INSERT INTO "auth_permission" VALUES (38,10,'change_cart','Can change cart');
INSERT INTO "auth_permission" VALUES (39,10,'delete_cart','Can delete cart');
INSERT INTO "auth_permission" VALUES (40,10,'view_cart','Can view cart');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$320000$WclutbQ8d0c16dE9HUFDKo$ohDA+vqx0hSS8qji64f7GpS5zEMvqVAFr8yqMVUNsOw=','2022-06-26 09:30:08.662696',1,'admin','','',1,1,'2022-06-24 17:13:56.767245','');
INSERT INTO "auth_user" VALUES (3,'pbkdf2_sha256$320000$B8oeH7fJEqNchxEiGmURCm$jakLNZfvplejafK7dJMfsSkFz911MoEfKVR285CBISM=',NULL,0,'techstarmahesh','','mistermaheshsharma@gmail.com',0,1,'2022-06-25 10:59:30.474968','');
INSERT INTO "auth_user" VALUES (4,'pbkdf2_sha256$320000$vWcxAy8CmNCRkWGpRLsz6d$amzBoWtnKUEIa5g4KueSa7kTLPmc552WHNQ14IgWjr8=','2022-06-26 12:49:43.114528',0,'rahual','','rahul@gmail.com',0,1,'2022-06-25 11:05:32.054962','');
INSERT INTO "auth_user" VALUES (5,'pbkdf2_sha256$320000$obkBh2LqiNGR0GgRprZzun$YGt0uiAcAEZgo1iTEKtqdNoEHy+p/wxixYqcWOaYdPI=','2022-06-26 17:45:13.283405',0,'mahesh','','ma@gma.com',0,1,'2022-06-25 12:03:50.213667','');
INSERT INTO "django_session" VALUES ('k6sxzv06tj1nwqvox0ro3g75ve8xlgbp','.eJxVjDkOwjAUBe_iGln-wVso6XMGy38xDqBEipMKcXeIlALaNzPvpVLe1pq2JksaWV2UU6ffDTM9ZNoB3_N0mzXN07qMqHdFH7TpYWZ5Xg_376DmVr81oYHQ2cAxsxexrhCK7UPopIBnEPIWDJ5NbykCIBeMkG1EcKV3JOr9AfdEOGM:1o55cz:4RhBysh7sYJFH7PtSoXPCX_37yOMfpZ2E0NcxopXL4g','2022-07-09 13:15:09.646243');
INSERT INTO "django_session" VALUES ('ldfzpaa6jywks8m5o4dz93onf6uwx7y4','.eJxVjEEOwiAQRe_C2pABylBcuvcMZICpVA0kpV0Z765NutDtf-_9lwi0rSVsnZcwZ3EWSpx-t0jpwXUH-U711mRqdV3mKHdFHrTLa8v8vBzu30GhXr61Zk9u4uSSQUADo5uQEntlSUU0BGCjNqRhJDZgYUAERzkDObDJD-L9AdzfN1I:1o59pp:9orOQ3M5zpKay_UlKNgiMmYqK0q4DHYl8Xr6kjVxfL0','2022-07-09 17:44:41.140656');
INSERT INTO "django_session" VALUES ('xc0e0gzqbssa1qkl20agn3z3n8hzd9fa','.eJxVjEEOwiAQRe_C2pABylBcuvcMZICpVA0kpV0Z765NutDtf-_9lwi0rSVsnZcwZ3EWSpx-t0jpwXUH-U711mRqdV3mKHdFHrTLa8v8vBzu30GhXr61Zk9u4uSSQUADo5uQEntlSUU0BGCjNqRhJDZgYUAERzkDObDJD-L9AdzfN1I:1o5OWy:ipjK79QJv9bozvqqxQRLsCjSvrFJusvd9oRssPlbXm8','2022-07-10 09:26:12.799361');
INSERT INTO "django_session" VALUES ('7zj0zdgcmjwdqg0grdak1hb6c7bnk9u2','.eJxVjDsOwjAQBe_iGlmxN_5R0nMGa727wQHkSPlUiLtDpBTQvpl5L5VxW2veFpnzyOqsnDr9bgXpIW0HfMd2mzRNbZ3HondFH3TR14nleTncv4OKS_3WHQXbMRjDIRlyHXrL6ECcGaxISTEWcjFaiQgsQL1l0wMSgE9DMF69P9ndN5w:1o5WJt:meGU_m5svU23t6-STnoMeoKBTg0HpSEGTkD9p3qu4qg','2022-07-10 17:45:13.295419');
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "app_customer_user_id_e6e52921" ON "app_customer" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "app_orderplaced_customer_id_9d02fbb6" ON "app_orderplaced" (
	"customer_id"
);
CREATE INDEX IF NOT EXISTS "app_orderplaced_product_id_90c7863a" ON "app_orderplaced" (
	"product_id"
);
CREATE INDEX IF NOT EXISTS "app_orderplaced_user_id_3c6fe1e1" ON "app_orderplaced" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "app_cart_product_id_a4171918" ON "app_cart" (
	"product_id"
);
CREATE INDEX IF NOT EXISTS "app_cart_user_id_2bf07879" ON "app_cart" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
