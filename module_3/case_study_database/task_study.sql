use case_study;

-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
SELECT 
    *
FROM
    nhan_vien
WHERE
    (ho_ten LIKE 'H%') OR (ho_ten LIKE 'T%')
        OR (ho_ten LIKE 'K%')
        AND CHAR_LENGTH(ho_ten) <= 15;
        
--  3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.       
SELECT 
    *
FROM
    khach_hang
WHERE
    YEAR(CURDATE()) - YEAR(ngay_sinh) >= 18
        AND YEAR(CURDATE()) - YEAR(ngay_sinh) <= 50
        AND (dia_chi LIKE '%Quảng Trị')
        OR (dia_chi LIKE '%Đà Nẵng');

-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
-- Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
-- Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
 
 SELECT 
    khach_hang.ma_khach_hang,
    khach_hang.ho_ten,
    COUNT(hop_dong.ma_hop_dong) AS so_lan_dat_phong
FROM
    khach_hang
        JOIN
    hop_dong ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
        JOIN
    loai_khach ON loai_khach.ma_loai_khach = khach_hang.ma_loai_khach
WHERE
    loai_khach.ten_loai_khach = 'Diamond'
GROUP BY khach_hang.ma_khach_hang
ORDER BY so_lan_dat_phong;
 
--  5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc,
--  tong_tien (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và 
--  Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. 
--  (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).

SELECT 
    khach_hang.ma_khach_hang,
    khach_hang.ho_ten,
    loai_khach.ten_loai_khach,
    hop_dong.ma_hop_dong,
    dich_vu.ten_dich_vu,
    hop_dong.ngay_lam_hop_dong,
    hop_dong.ngay_ket_thuc,
    (IFNULL(dich_vu.chi_phi_thue, 0) + IFNULL(hop_dong_chi_tiet.so_luong, 0) * IFNULL(dich_vu_di_kem.gia, 0)) AS tong_tien
FROM
    khach_hang
        LEFT JOIN
    loai_khach ON loai_khach.ma_loai_khach = khach_hang.ma_loai_khach
        LEFT JOIN
    hop_dong ON hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
        LEFT JOIN
    dich_vu ON dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
        LEFT JOIN
    hop_dong_chi_tiet ON hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
        LEFT JOIN
    dich_vu_di_kem ON dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
GROUP BY hop_dong.ma_hop_dong , khach_hang.ma_khach_hang
ORDER BY ma_khach_hang;

-- 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của 
-- tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).

SELECT dich_vu.ma_dich_vu, dich_vu.ten_dich_vu, dich_vu.dien_tich, dich_vu.chi_phi_thue, loai_dich_vu.ten_loai_dich_vu
from dich_vu
JOIN loai_dich_vu on loai_dich_vu.ma_loai_dich_vu = dich_vu.ma_loai_dich_vu 
WHERE dich_vu.ma_dich_vu not in (
	SELECT hop_dong.ma_dich_vu
	from hop_dong
	WHERE hop_dong.ngay_lam_hop_dong BETWEEN '2021-01-01' AND '2021-03-31'
);

-- 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của 
-- tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.

SELECT 
    dich_vu.ma_dich_vu,
    dich_vu.ten_dich_vu,
    dich_vu.dien_tich,
    dich_vu.so_nguoi_toi_da,
    dich_vu.chi_phi_thue,
    loai_dich_vu.ten_loai_dich_vu
FROM
    dich_vu
        JOIN
    loai_dich_vu ON loai_dich_vu.ma_loai_dich_vu = dich_vu.ma_loai_dich_vu
WHERE
    dich_vu.ma_dich_vu NOT IN (SELECT 
            hop_dong.ma_dich_vu
        FROM
            hop_dong
        WHERE
            YEAR(ngay_lam_hop_dong) IN (2021))
;

-- 8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.
SELECT DISTINCT
    kh.ho_ten
FROM
    khach_hang kh;  

SELECT  kh.ho_ten   
FROM khach_hang kh
GROUP BY ho_ten;  

SELECT 
    kh.ho_ten
FROM
    khach_hang kh 
UNION SELECT 
    kh.ho_ten
FROM
    khach_hang kh;

-- 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 
-- 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.

SELECT 
    MONTH(hop_dong.ngay_lam_hop_dong) AS month,
    COUNT(hop_dong.ma_hop_dong) AS so_luong_khach_hang
FROM
    hop_dong
WHERE
    YEAR(hop_dong.ngay_lam_hop_dong) = 2021
GROUP BY MONTH(hop_dong.ngay_lam_hop_dong)
ORDER BY MONTH(hop_dong.ngay_lam_hop_dong);

-- 10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. 
-- Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem
--  (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).

SELECT 
    hd.ma_hop_dong,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    hd.tien_dat_coc,
    SUM(ifnull(hdct.so_luong,0)) AS so_luong_dich_vu_di_kem
FROM
    hop_dong hd
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
    --     LEFT JOIN
--     dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
GROUP BY hd.ma_hop_dong
ORDER BY hd.ma_hop_dong;


-- 11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach
--  là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
SELECT  dich_vu_di_kem.ma_dich_vu_di_kem, dich_vu_di_kem.ten_dich_vu_di_kem
FROM dich_vu_di_kem
JOIN hop_dong_chi_tiet ON hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
JOIN hop_dong ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
JOIN khach_hang ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
WHERE (khach_hang.ma_loai_khach = 1 )
 AND ( khach_hang.dia_chi LIKE ('%Vinh') 
 OR khach_hang.dia_chi LIKE ('%Quảng Ngãi') );
 
--  12.	Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), 
--  ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem),
--  tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 
--  nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.

SELECT 
    hop_dong.ma_hop_dong,
    nhan_vien.ho_ten,
    khach_hang.ho_ten,
    khach_hang.so_dien_thoai,
    dich_vu.ten_dich_vu,
    SUM(hop_dong_chi_tiet.so_luong) AS so_luong_dich_vu_di_kem,
    hop_dong.tien_dat_coc
FROM
    hop_dong
        LEFT JOIN
    nhan_vien ON nhan_vien.ma_nhan_vien = hop_dong.ma_nhan_vien
        LEFT JOIN
    khach_hang ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
        LEFT JOIN
    dich_vu ON dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
        LEFT JOIN
    hop_dong_chi_tiet ON hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
        LEFT JOIN
    dich_vu_di_kem ON dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
WHERE
    hop_dong.ma_dich_vu IN (SELECT 
            hop_dong.ma_dich_vu
        FROM
            hop_dong
                LEFT JOIN
            dich_vu ON hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
        WHERE
            hop_dong.ngay_lam_hop_dong BETWEEN '2020-10-01' AND '2020-12-31')
        AND hop_dong.ma_dich_vu NOT IN (SELECT 
            hop_dong.ma_dich_vu
        FROM
            hop_dong
                LEFT JOIN
            dich_vu ON hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
        WHERE
            hop_dong.ngay_lam_hop_dong BETWEEN '2021-01-01' AND '2021-06-30')
            GROUP BY hop_dong.ma_hop_dong;

-- 13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
--  (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
 
 SELECT dich_vu_di_kem.ma_dich_vu_di_kem, dich_vu_di_kem.ten_dich_vu_di_kem , sum(hop_dong_chi_tiet.so_luong) AS so_luong_dich_vu_di_kem
 FROM dich_vu_di_kem
 JOIN hop_dong_chi_tiet ON hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
 JOIN hop_dong on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
 JOIN khach_hang on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
 GROUP BY dich_vu_di_kem.ten_dich_vu_di_kem
 HAVING SUM(hop_dong_chi_tiet.so_luong) >= ALL (SELECT sum(hop_dong_chi_tiet.so_luong) FROM hop_dong_chi_tiet GROUP BY hop_dong_chi_tiet.so_luong);


-- 14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.
--  Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung
--  (được tính dựa trên việc count các ma_dich_vu_di_kem).
SELECT 
    hop_dong.ma_hop_dong,
    loai_dich_vu.ten_loai_dich_vu,
    dich_vu_di_kem.ten_dich_vu_di_kem,
    COUNT(hop_dong_chi_tiet.ma_dich_vu_di_kem) AS so_lan_su_dung
FROM
    hop_dong
        JOIN
    dich_vu ON dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
        JOIN
    loai_dich_vu ON loai_dich_vu.ma_loai_dich_vu = dich_vu.ma_loai_dich_vu
        JOIN
    hop_dong_chi_tiet ON hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
        JOIN
    dich_vu_di_kem ON dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
GROUP BY hop_dong_chi_tiet.ma_dich_vu_di_kem
HAVING so_lan_su_dung = 1
; 

 
-- 15.	Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do,
--  ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.

SELECT 
    nhan_vien.ma_nhan_vien,
    nhan_vien.ho_ten,
    trinh_do.ten_trinh_do,
    bo_phan.ten_bo_phan,
    nhan_vien.so_dien_thoai,
    nhan_vien.dia_chi
FROM
    nhan_vien    
        JOIN
    trinh_do ON trinh_do.ma_trinh_do = nhan_vien.ma_trinh_do 
        JOIN
    bo_phan ON bo_phan.ma_bo_phan = nhan_vien.ma_bo_phan
        JOIN
    hop_dong ON hop_dong.ma_nhan_vien = nhan_vien.ma_nhan_vien

    WHERE YEAR(hop_dong.ngay_lam_hop_dong) BETWEEN '2020' AND '2021'
GROUP BY nhan_vien.ma_nhan_vien
HAVING COUNT(hop_dong.ma_hop_dong) <= 3;

-- 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.


SELECT 
    nhan_vien.ho_ten AS nhan_vien_can_xoa
FROM
    nhan_vien
        LEFT JOIN
    hop_dong ON hop_dong.ma_nhan_vien = nhan_vien.ma_nhan_vien
WHERE
    nhan_vien.ma_nhan_vien NOT IN (SELECT 
            nhan_vien.ma_nhan_vien
        FROM
            nhan_vien
                JOIN
            hop_dong ON hop_dong.ma_nhan_vien = nhan_vien.ma_nhan_vien
        WHERE
            YEAR(hop_dong.ngay_lam_hop_dong) BETWEEN 2019 AND 2021);


SET SQL_SAFE_UPDATES = 0;
DELETE 
FROM nhan_vien
WHERE nhan_vien.ma_nhan_vien not in (SELECT hop_dong.ma_nhan_vien
FROM hop_dong
WHERE year(hop_dong.ngay_lam_hop_dong) BETWEEN 2019 AND 2021  );
SELECT 
    nhan_vien.ma_nhan_vien, nhan_vien.ho_ten
FROM
    nhan_vien;


-- 17.	Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond,
--  chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.

SELECT 
    khach_hang.ma_khach_hang,
    khach_hang.ho_ten,
    khach_hang.ma_loai_khach,
    SUM(dich_vu.chi_phi_thue + (hop_dong_chi_tiet.so_luong * dich_vu_di_kem.gia)) AS tong_tien_thanh_toan
FROM
    khach_hang
        JOIN
    hop_dong ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
        JOIN
    dich_vu ON hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
        JOIN
    hop_dong_chi_tiet ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
        JOIN
    dich_vu_di_kem ON hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
WHERE
    YEAR(hop_dong.ngay_lam_hop_dong) = 2021
GROUP BY khach_hang.ma_khach_hang
HAVING tong_tien_thanh_toan > 10000000;


set sql_safe_updates =0;
UPDATE loai_khach
        -- JOIN
--     khach_hang ON loai_khach.ma_loai_khach = khach_hang.ma_loai_khach 
SET 
    loai_khach.ten_loai_khach = 'Diamond'
WHERE
    loai_khach.ma_loai_khach IN (SELECT khach_hang.ma_loai_khach
        FROM
            khach_hang
                JOIN
            hop_dong ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
                JOIN
            dich_vu ON hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
                JOIN
            hop_dong_chi_tiet ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
                JOIN
            dich_vu_di_kem ON hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
        WHERE
            YEAR(hop_dong.ngay_lam_hop_dong) = 2021
        GROUP BY khach_hang.ma_khach_hang
        HAVING SUM(dich_vu.chi_phi_thue + (hop_dong_chi_tiet.so_luong * dich_vu_di_kem.gia)) > 10000000);

-- 18.	Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).
   DELETE
   FROM khach_hang
   WHERE ma_khach_hang in (
   SELECT khach_hang.ma_khach_hang
   from khach_hang
   JOIN hop_dong on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
   WHERE year(hop_dong.ngay_lam_hop_dong) < 2021);
   
--    19.	Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.

SELECT 
    dv.ma_dich_vu_di_kem, dv.ten_dich_vu_di_kem
FROM
    dich_vu_di_kem dv
        JOIN
    hop_dong_chi_tiet hd ON dv.ma_dich_vu_di_kem = hd.ma_dich_vu_di_kem
        JOIN
    hop_dong h ON hd.ma_hop_dong = h.ma_hop_dong
WHERE
    YEAR(h.ngay_lam_hop_dong) = 2020
GROUP BY dv.ma_dich_vu_di_kem
HAVING SUM(hd.so_luong) > 10;


-- 20.Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), 
-- ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.
SELECT 
    nhan_vien.ma_nhan_vien AS id,
    nhan_vien.ho_ten,
    nhan_vien.email,
    nhan_vien.so_dien_thoai,
    nhan_vien.ngay_sinh,
    nhan_vien.dia_chi
FROM
    nhan_vien  
UNION ALL SELECT 
    khach_hang.ma_khach_hang,
    khach_hang.ho_ten,
    khach_hang.email,
    khach_hang.so_dien_thoai,
    khach_hang.ngay_sinh,
    khach_hang.dia_chi
FROM
    khach_hang ;


-- 21.	Tạo khung nhìn có tên là v_nhan_vien để lấy được thông
--      tin của tất cả các nhân viên có địa chỉ là “Hải Châu” và
--     đã từng lập hợp đồng cho một hoặc nhiều khách hàng bất kì với ngày lập hợp đồng là “12/12/2019”.
                                         
create view v_nhan_vien as
 select nhan_vien.*   from nhan_vien
join hop_dong on nhan_vien.ma_nhan_vien =  hop_dong.ma_nhan_vien
 where (hop_dong.ngay_lam_hop_dong) between '2021-04-01' and '2021-04-30' and nhan_vien.dia_chi like '% Đà Nẵng' ;

drop VIEW v_nhan_vien ;
-- 22.	Thông qua khung nhìn v_nhan_vien thực hiện cập nhật địa chỉ thành “Liên Chiểu” 
-- đối với tất cả các nhân viên được nhìn thấy bởi khung nhìn này.

SET sql_safe_updates = 0;
update v_nhan_vien 
set  dia_chi = 'Liên Chiểu'
where (SELECT*from (SELECT nhan_vien.ma_nhan_vien from v_nhan_vien) as a);

drop v_nhan_vien 
-- 23.	Tạo Stored Procedure sp_xoa_khach_hang dùng để xóa thông tin của một khách hàng 
-- nào đó với ma_khach_hang được truyền vào như là 1 tham số của sp_xoa_khach_hang.

DELIMITER //
CREATE PROCEDURE sp_xoa_khach_hang(IN p_id INT)
BEGIN
delete from khach_hang
WHERE khach_hang.ma_khach_hang = p_id;
end//
DELIMITER //;
CALL sp_xoa_khach_hang(2) ;


-- 24.	Tạo Stored Procedure sp_them_moi_hop_dong dùng để thêm mới vào bảng hop_dong với
--  yêu cầu sp_them_moi_hop_dong phải thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung,
--  với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.

DELIMITER //
create PROCEDURE sp_them_moi_hop_dong( ma_hop_dong int, ngay_lam_hop_dong DATETIME, ngay_ket_thuc  DATETIME, tien_dat_coc DOUBLE, ma_nhan_vien int, ma_khach_hang int, ma_dich_vu INT)
BEGIN 
INSERT INTO hop_dong 
VALUES(ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, ma_nhan_vien, ma_khach_hang, ma_dich_vu);
end //
DELIMITER // ;
CALL sp_them_moi_hop_dong(1000, '2020-09-25', '2022-09-25', 1540000, 1, 1, 1);


-- 25.	Tạo Trigger có tên tr_xoa_hop_dong khi xóa bản ghi trong bảng hop_dong thì 
-- hiển thị tổng số lượng bản ghi còn lại có trong bảng hop_dong ra giao diện console của database.
-- Lưu ý: Đối với MySQL thì sử dụng SIGNAL hoặc ghi log thay cho việc ghi ở console.
SET FOREIGN_KEY_CHECKS=0;
create table so_luong_hop_dong_sau_khi_xoa (
so_luong int
);
delimiter //
create trigger tr_xoa_hop_dong
after delete on hop_dong for each row
begin  
insert into so_luong_hop_dong_sau_khi_xoa 
select count(*) from hop_dong;
end //
delimiter ;
drop  trigger tr_xoa_hop_dong;
DELETE FROM hop_dong 
WHERE
    ma_hop_dong = 10;
select * from  so_luong_hop_dong_sau_khi_xoa;







