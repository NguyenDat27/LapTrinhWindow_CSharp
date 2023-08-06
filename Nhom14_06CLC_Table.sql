create database QL_ChuyenBay
go
use QL_ChuyenBay
go
-- Tạo các bảng để đăng nhập theo chức năng
create table dn
(
	TK varchar(10) UNIQUE,
	MK varchar(15) NOT NULL,
	Phanquyen varchar(20) NOT NULL,
	primary key (TK)
)
ALTER TABLE dn ADD CONSTRAINT check_Phanquyen
CHECK (Phanquyen LIKE 'customer' OR Phanquyen LIKE 'pilot' 
		OR Phanquyen LIKE 'stewardess' OR Phanquyen LIKE 'hrm' OR Phanquyen LIKE 'mm' OR Phanquyen LIKE 'president')
GO

-- Tạo bảng KHACHHANG
create table KHACHHANG
(
 CMND varchar(9),
 TEN nvarchar(30),
 STREET nvarchar(30),
 commune_id nchar(5),
 EMAIL varchar(30),
 DTHOAI nvarchar(12),
 primary key (CMND)
)
go

-- Tạo bảng NHANVIEN
create table NHANVIEN
(
 MANV varchar(15),
 TEN nvarchar(30),
 STREET nvarchar(30),
 commune_id nchar(5),
 EMAIL varchar(30),
 DTHOAI nvarchar(12),
 LUONG float,
 LOAINV bit,
 primary key (MANV)
)
-- Tạo bảng LOAIMB
create table LOAIMB
(
 MALOAI nvarchar(15),
 HANGSX nvarchar(15),
 primary key (MALOAI)
)
-- Tạo bảng MAYBAY
create table MAYBAY
( 
 SOHIEU int,
 MALOAI nvarchar(15),
 TINHTRANG nvarchar(20),
 primary key (SOHIEU, MALOAI)
)
-- Tạo bảng chuyến bay
create table CHUYENBAY
(
 MACB nvarchar(4),
 SBDI nvarchar(30),
 SBDEN nvarchar(30),
 GIODI time,
 GIODEN time,
 primary key (MACB)
)
-- Tạo bảng LICHBAY
create table LICHBAY
(
 NGAYDI date,
 MACB nvarchar(4),
 SOHIEU int,
 MALOAI nvarchar(15),
 primary key (NGAYDI, MACB)
)
-- Tạo bảng Ve
create table Ve
(
	MAVE varchar(5),
	GIAVE int,
	LOAIVE nvarchar(15),
	CMND varchar(9),
	NGAYDI date,
	MACB nvarchar(4),
	primary key(MAVE)
)
-- Tạo bảng KHANANG
create table KHANANG
(
 MANV varchar(15),
 MALOAI nvarchar(15),
 primary key (MANV, MALOAI)
)
-- Tạo bảng PHANCONG
create table PHANCONG
(
 MANV varchar(15),
 NGAYDI date,
 MACB nvarchar(4),
 primary key (MANV, NGAYDI, MACB)
)
-- Tạo bảng PROVINCE --
create table PROVINCE
(
  province_id nchar(5),
  province_name nvarchar(30) NOT NULL,
  PRIMARY KEY (province_id),
)
-- Tạo bảng DICTRICT --
create table DISTRICT
(
  district_id nchar(5),
  district_name nvarchar(50) NOT NULL,
  province_id nchar(5) NOT NULL,
  PRIMARY KEY (district_id),
  FOREIGN KEY (province_id)
  REFERENCES province (province_id)
  ON DELETE CASCADE ON UPDATE CASCADE,
)
-- Tạo bảng COMMUNE --
create table COMMUNE
(
  commune_id nchar(5),
  commune_name nvarchar(50) ,
  degree int,
  district_id nchar(5),
  PRIMARY KEY (commune_id),
  FOREIGN KEY (district_id)
  REFERENCES district (district_id)
  ON DELETE CASCADE ON UPDATE CASCADE
);
-- Tạo khóa ngoại cho bảng MAYBAY tham chiếu khóa chính của các table khác
 -- tham chiếu đến table LOAIMB
 alter table MAYBAY
 add constraint THUOC
 foreign key(MALOAI)
 references LOAIMB(MALOAI) 
-- Tạo khóa ngoại cho bảng LICHBAY tham chiếu đến khóa chính của các table khác
 -- Tham chiếu MACB của table CHUYENBAY
 alter table LICHBAY
 add constraint BAY
 foreign key (MACB)
 references CHUYENBAY(MACB)
 -- Tham chiếu SOHIEU, MALOAI của table MAYBAY
 alter table LICHBAY
 add constraint DINHDANH
 foreign key(SOHIEU, MALOAI)
 references MAYBAY(SOHIEU, MALOAI)
-- Tạo khóa ngoại cho table VE tham chiếu đến khóa chính của các table khác
 -- Tham chiếu MAKH của table KHACHHANG
 alter table VE
 add constraint DOITUONG
 foreign key (CMND)
 references KHACHHANG(CMND)
 -- Tham chiếu NGAYDI VÀ MACB của table LICHBAY
 alter table VE
 add constraint PHUONGTIEN1
 foreign key (NGAYDI, MACB)
 references LICHBAY(NGAYDI, MACB)
-- Tạo khóa ngoại cho table KHANANG
 -- Tham chiếu MANV của table NHANVIEN
 alter table KHANANG
 add constraint PHUCVU
 foreign key (MANV)
 references NHANVIEN(MANV)
 -- Tham chiếu MALOAI của table LOAIMB
 alter table KHANANG
 add constraint T
 foreign key (MALOAI)
 references LOAIMB(MALOAI)
-- Tạo khóa ngoại cho table PHANCONG
 -- Tham chiếu MANV đến table NHANVIEN
 alter table PHANCONG
 add constraint NV
 foreign key (MANV)
 references NHANVIEN(MANV)
 --  Tham chiếu NGAYDI và MACB đến table LICHBAY
 alter table PHANCONG
 add constraint NV2
 foreign key( NGAYDI, MACB)
 references LICHBAY(NGAYDI, MACB)

 -- Tham chieu KHACHHANG den COMMUNE
 alter table KHACHHANG
 add constraint XaKH
 foreign key(commune_id)
 references COMMUNE(commune_id)

  -- Tham chieu NHANVIEN den COMMUNE
 alter table NHANVIEN
 add constraint XaNV
 foreign key(commune_id)
 references COMMUNE(commune_id)
