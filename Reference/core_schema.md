# Canonical Schema — Source of Truth Cho Toàn Bộ Curriculum

> **Mục đích:** Đây là **schema chuẩn duy nhất** dùng xuyên suốt tuần 3-9.
> Mọi `lesson.md`, `example.sql`, `exercise.md`, và `slide.html` phải **khớp tuyệt đối** với file này.
> Khi có mâu thuẫn giữa các file khác — file này là đúng.

**Cập nhật lần cuối:** 2026-04-23

---

## 1. Tổng Quan

Toàn bộ curriculum dùng **5 bảng** sau, mô phỏng một cửa hàng bán lẻ nhỏ:

```
khach_hang  ──┐
              ├──→  don_hang  ──→  chi_tiet_don_hang  ──→  san_pham
nhan_vien   ──┘
```

| Bảng | Ý nghĩa | Bắt đầu dùng từ |
|---|---|---|
| `nhan_vien` | Nhân viên công ty | Tuần 3 |
| `san_pham` | Sản phẩm bán | Tuần 3 |
| `khach_hang` | Khách hàng | Tuần 3 |
| `don_hang` | Đơn hàng (header) | Tuần 7 |
| `chi_tiet_don_hang` | Dòng chi tiết mỗi đơn | Tuần 7 |

---

## 2. Quy Tắc Đặt Tên

### 2.1. Nguyên tắc chung

- `snake_case`, tiếng Việt không dấu
- Khóa chính luôn tên `id`, kiểu `SERIAL PRIMARY KEY`
- Khóa ngoại: `<ten_bang>_id` (ví dụ: `khach_hang_id`, `san_pham_id`)
- Business code (mã hiển thị cho người dùng): `ma_<ten_bang>` (ví dụ: `ma_sp`, `ma_khach_hang`, `ma_don_hang`)
- Boolean: dạng tính từ hoặc `la_<tính_từ>` (ví dụ: `dang_lam`, `con_ban`, `la_vip`)

### 2.2. Bảng tên chuẩn vs tên cấm

| Tên chuẩn ✅ | Tên cấm ❌ | Ghi chú |
|---|---|---|
| `ten_sp` | `ten_san_pham` | Ngắn, đã dùng từ tuần 3 |
| `so_dien_thoai` | `dien_thoai`, `sdt` | Đầy đủ, rõ nghĩa |
| `dang_lam` (BOOLEAN) | `dang_lam_viec`, `tinh_trang`, `trang_thai_nv` | BOOLEAN đơn giản hơn |
| `ngay_vao` | `ngay_vao_lam`, `ngay_tuyen` | Ngắn, đủ |
| `khach_hang_id` (FK) | `ma_khach_hang` (dùng làm FK) | `ma_khach_hang` là business code |
| `nhan_vien_id` (FK) | `ma_nv`, `ma_nv_id` | — |
| `san_pham_id` (FK) | `ma_sp_id` | `ma_sp` là business code |
| `don_hang_id` (FK) | `ma_don_hang` (dùng làm FK) | — |
| `so_luong` | `so_luong_ban`, `sl` | — |
| `don_gia` (trong `chi_tiet_don_hang`) | `gia_ban` | Giá tại thời điểm mua |
| `gia` (trong `san_pham`) | `gia_ban` | Giá niêm yết hiện tại |

---

## 3. Canonical Schema Chính Thức

### 3.1. `nhan_vien`

```sql
CREATE TABLE nhan_vien (
    id              SERIAL          PRIMARY KEY,
    ho_ten          VARCHAR(100)    NOT NULL,
    phong_ban       VARCHAR(50),
    luong           NUMERIC(12,2),
    ngay_sinh       DATE,
    email           VARCHAR(150),
    so_dien_thoai   VARCHAR(20),
    ngay_vao        DATE            DEFAULT CURRENT_DATE,
    dang_lam        BOOLEAN         DEFAULT TRUE
);
```

**Ghi chú sư phạm:**
- `dang_lam` là BOOLEAN vì beginner dễ hiểu (TRUE/FALSE như checkbox Excel). Trong production thực tế, nhiều hệ thống dùng ENUM status với nhiều giá trị (`dang_lam`, `nghi_phep`, `da_nghi_viec`) — xem `Reference/datatypes_reference.md`.

### 3.2. `san_pham`

```sql
CREATE TABLE san_pham (
    id              SERIAL          PRIMARY KEY,
    ma_sp           VARCHAR(20)     UNIQUE,
    ten_sp          VARCHAR(200)    NOT NULL,
    danh_muc        VARCHAR(100),
    gia             NUMERIC(12,2)   NOT NULL,
    so_luong_ton    INTEGER         NOT NULL DEFAULT 0,
    mo_ta           TEXT,
    ngay_nhap       DATE            DEFAULT CURRENT_DATE,
    con_ban         BOOLEAN         DEFAULT TRUE
);
```

**Ghi chú:**
- `id` là PK nội bộ (dùng cho FK).
- `ma_sp` là **business code** hiển thị cho người dùng (ví dụ `SP001`). Dùng cho `ON CONFLICT` ở tuần 9.
- Đừng dùng `ma_sp` làm khóa ngoại — dùng `id`.

### 3.3. `khach_hang`

```sql
CREATE TABLE khach_hang (
    id              SERIAL          PRIMARY KEY,
    ma_khach_hang   VARCHAR(20)     UNIQUE,
    ho_ten          VARCHAR(100)    NOT NULL,
    so_dien_thoai   VARCHAR(20),
    email           VARCHAR(150),
    dia_chi         TEXT,
    thanh_pho       VARCHAR(50),
    ngay_dang_ky    DATE            DEFAULT CURRENT_DATE,
    la_vip          BOOLEAN         DEFAULT FALSE
);
```

### 3.4. `don_hang`

```sql
CREATE TABLE don_hang (
    id              SERIAL          PRIMARY KEY,
    ma_don_hang     VARCHAR(20)     UNIQUE NOT NULL,
    khach_hang_id   INTEGER         NOT NULL REFERENCES khach_hang(id),
    nhan_vien_id    INTEGER         REFERENCES nhan_vien(id),
    ngay_dat        TIMESTAMP       DEFAULT NOW(),
    ngay_giao       TIMESTAMP,
    tong_tien       NUMERIC(15,2),
    trang_thai      VARCHAR(20)     DEFAULT 'cho_xac_nhan'
);
```

**Ghi chú sư phạm:**
- `tong_tien` được **lưu sẵn** (denormalized) trong `don_hang`. Về mặt DB theory, giá trị này có thể tính lại từ `chi_tiet_don_hang` (`SUM(so_luong * don_gia)`) — nhưng với beginner, lưu sẵn đơn giản hơn.
- Giá trị hợp lệ cho `trang_thai`: `'cho_xac_nhan'`, `'dang_giao'`, `'hoan_thanh'`, `'huy'`.

### 3.5. `chi_tiet_don_hang`

```sql
CREATE TABLE chi_tiet_don_hang (
    id              SERIAL          PRIMARY KEY,
    don_hang_id     INTEGER         NOT NULL REFERENCES don_hang(id),
    san_pham_id     INTEGER         NOT NULL REFERENCES san_pham(id),
    so_luong        INTEGER         NOT NULL,
    don_gia         NUMERIC(12,2)   NOT NULL
);
```

**Ghi chú:**
- `don_gia` là **giá tại thời điểm mua** (snapshot), không phải `san_pham.gia` hiện tại.
- Khi viết query liên kết `san_pham`, dùng `chi_tiet_don_hang.san_pham_id = san_pham.id`.

---

## 4. Sơ Đồ Quan Hệ (ER)

```text
nhan_vien                         khach_hang
   │                                 │
   │ id                              │ id
   │                                 │
   └──→ don_hang.nhan_vien_id        └──→ don_hang.khach_hang_id
              │
              │ id
              │
              └──→ chi_tiet_don_hang.don_hang_id
                           │
                           │ san_pham_id
                           │
                           └──→ san_pham.id
```

---

## 5. Seed Data Tối Thiểu

Mỗi file `example.sql` từ tuần 3 trở đi nên bắt đầu bằng đoạn "kiểm tra trước khi học":

```sql
-- Kiểm tra các bảng đã tồn tại với đúng schema
SELECT 'nhan_vien' AS bang, COUNT(*) AS so_dong FROM nhan_vien
UNION ALL
SELECT 'san_pham',          COUNT(*)              FROM san_pham
UNION ALL
SELECT 'khach_hang',        COUNT(*)              FROM khach_hang;
```

Nếu kết quả không như mong đợi → chạy lại example của tuần 3 để tạo bảng + insert dữ liệu mẫu.

---

## 6. Quy Tắc Mở Rộng Schema (Cho Maintainer)

Khi một tuần cần cột mới:

1. **Thêm vào file này trước**, kèm dòng: `-- Thêm tuần X (YYYY-MM-DD), lý do: ...`
2. Cập nhật `CREATE TABLE` ở tuần 3 nếu cột nên có từ đầu
3. Nếu cột chỉ cần từ tuần X trở đi, dùng `ALTER TABLE` trong example tuần X
4. **Không bao giờ** tạo `DROP TABLE` + `CREATE TABLE` mới trong một tuần giữa chừng (tuần 4-9)

---

## 7. Checklist Cho Người Viết Lesson/Example Mới

- [ ] Tên bảng khớp mục 3
- [ ] Tên cột khớp mục 3 (không có tên trong mục 2.2 "tên cấm")
- [ ] Nếu dùng FK, dùng `<bang>_id` (không phải `ma_<bang>`)
- [ ] Nếu cần cột mới, đã update file này chưa?
- [ ] Query test copy vào DBeaver có chạy được không?
