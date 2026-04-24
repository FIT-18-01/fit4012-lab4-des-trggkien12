[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/BJH8GGf3)
# FIT4012 - Lab 4: DES / TripleDES Starter Repository

Repo này là **starter repo** cho Lab 4 của FIT4012.  

## 1. Cấu trúc repo

```text
.
├── .github/
│   ├── scripts/
│   │   └── check_submission.sh
│   └── workflows/
│       └── ci.yml
├── logs/
│   ├── .gitkeep
│   └── README.md
├── scripts/
│   └── run_sample.sh
├── tests/
│   ├── test_des_sample.sh
│   ├── test_encrypt_decrypt_roundtrip.sh
│   ├── test_multiblock_padding.sh
│   ├── test_tamper_negative.sh
│   └── test_wrong_key_negative.sh
├── .gitignore
├── CMakeLists.txt
├── Makefile
├── README.md
├── des.cpp
└── report-1page.md
```

## 2. Cách chạy chương trình (How to run)

### Cách 1: Dùng Makefile

```bash
make
./des
```

### Cách 2: Biên dịch trực tiếp

```bash
g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des
./des
```

### Cách 3: Dùng CMake

```bash
cmake -S . -B build
cmake --build build
./build/des
```

## 3. Input / Đầu vào
Chương trình nhận đầu vào trực tiếp từ luồng tiêu chuẩn (`stdin`), phù hợp cho việc đánh giá tự động.
- Chế độ chạy (mode) được nhập đầu tiên (1: DES Encrypt, 2: DES Decrypt, 3: 3DES Encrypt, 4: 3DES Decrypt).
- Dữ liệu `plaintext` hoặc `ciphertext` được nhập dưới dạng chuỗi bit nhị phân (ví dụ: `00010...`). Hỗ trợ độ dài đa khối (lớn hơn 64 bit).
- `key` (Khóa) được nhập dạng chuỗi bit nhị phân dài đúng 64 bit. Đối với Triple DES, cần nhập lần lượt 3 khóa K1, K2, K3 cách nhau bởi dòng mới.

## 4. Output / Đầu ra
- Chương trình xử lý toán học tuần tự qua các round keys và in ra chuỗi bit nhị phân tương ứng với bản rõ hoặc bản mã (ciphertext/plaintext) qua `stdout`.
- Có hỗ trợ in ra toàn bộ ciphertext thành chuỗi nhị phân dài liên tục cho chế độ đa khối.
- TripleDES được hoàn thiện đầy đủ luồng thực thi chuẩn: Mã hóa (E-D-E) và Giải mã (D-E-D).

## 5. Padding đang dùng
Chương trình sử dụng cơ chế **Zero Padding**:
- Trước khi mã hóa/giải mã, độ dài chuỗi đầu vào được kiểm tra. Nếu tổng số bit không chia hết cho 64 (kích thước chuẩn của một khối DES), chương trình sẽ tự động chèn thêm các ký tự `'0'` vào cuối cho đến khi khối cuối cùng đạt chuẩn 64 bit.
- **Hạn chế:** Cách này tuy dễ hiểu và phù hợp cho việc học tập giao thức mật mã cơ bản, nhưng trong thực tế nó không an toàn do dễ bị tấn công Padding Oracle và không thể phân biệt được `0` gốc với `0` được đệm thêm.

## 6. Tests bắt buộc
Repo này có đủ 5 file shell script phục vụ test. Các test case phủ rộng các trường hợp như mã hóa cơ bản, xử lý padding và test fail (tamper, wrong key).

## 7. Logs / Minh chứng
Ảnh minh chứng và log test được lưu trong thư mục `logs/`.

## 8. Ethics & Safe use

- Chỉ chạy và kiểm thử trên dữ liệu học tập hoặc dữ liệu giả lập.
- Không dùng repo này để tấn công hay can thiệp hệ thống thật.
- Không trình bày đây là công cụ bảo mật sẵn sàng cho môi trường sản xuất.
- Nếu tham khảo mã, tài liệu, công cụ hoặc AI, phải ghi nguồn rõ ràng.
- Khi cộng tác nhóm, cần trung thực học thuật và mô tả đúng phần việc của mình.
- Việc kiểm thử chỉ phục vụ học DES / TripleDES ở mức nhập môn.

## 9. Checklist nộp bài

Trước khi nộp, cần có:
- `des.cpp`
- `README.md` hoàn chỉnh
- `report-1page.md` hoàn chỉnh
- `tests/` với ít nhất 5 test
- có negative test cho `tamper` và `wrong key`
- `logs/` có ít nhất 1 file minh chứng thật
- không còn dòng `TODO`

## 10. Lưu ý về CI

CI sẽ **không chỉ kiểm tra file có tồn tại** mà còn kiểm tra:
- các mục bắt buộc trong README
- các mục bắt buộc trong report
- sự hiện diện của negative tests
- có minh chứng trong `logs/`
- repo **không còn placeholder `TODO`**

Vì vậy repo starter này sẽ **chưa pass CI** cho tới khi sinh viên hoàn thiện nội dung.


## 11. Submission contract để auto-check Q2 và Q4

Để GitHub Actions kiểm tra được **Q2** và **Q4**, repo này dùng **một contract nhập/xuất thống nhất**.
Sinh viên cần sửa `des.cpp` để chương trình nhận dữ liệu từ **stdin** theo đúng thứ tự sau:

```text
Chọn mode:
1 = DES encrypt
2 = DES decrypt
3 = TripleDES encrypt
4 = TripleDES decrypt
```

### Mode 1: DES encrypt 
Nhập lần lượt:
1. `1`
2. plaintext nhị phân
3. key 64-bit

Yêu cầu:
- nếu plaintext dài hơn 64 bit: chia block 64 bit và mã hóa tuần tự
- nếu block cuối thiếu bit: zero padding
- in ra **ciphertext cuối cùng** dưới dạng chuỗi nhị phân

### Mode 2: DES decrypt
Nhập lần lượt:
1. `2`
2. ciphertext nhị phân
3. key 64-bit

Yêu cầu:
- giải mã DES theo round keys đảo ngược
- in ra plaintext cuối cùng

### Mode 3: TripleDES encrypt 
Nhập lần lượt:
1. `3`
2. plaintext 64-bit
3. `K1`
4. `K2`
5. `K3`

Yêu cầu:
- thực hiện đúng chuỗi **E(K3, D(K2, E(K1, P)))**
- in ra ciphertext cuối cùng

### Mode 4: TripleDES decrypt 
Nhập lần lượt:
1. `4`
2. ciphertext 64-bit
3. `K1`
4. `K2`
5. `K3`

Yêu cầu:
- thực hiện giải mã TripleDES ngược lại
- in ra plaintext cuối cùng

### Lưu ý về output
- Có thể in prompt tiếng Việt hoặc tiếng Anh.
- Có thể in thêm round keys hay thông báo trung gian.
- Nhưng **kết quả cuối cùng phải xuất hiện dưới dạng một chuỗi nhị phân dài hợp lệ** để CI tách và đối chiếu.

## 14. CI hiện kiểm tra được gì

Ngoài checklist nộp bài, CI hiện còn kiểm tra tự động:
- chương trình thực sự nhận plaintext/key từ bàn phím và mã hóa multi-block với zero padding đúng.
- chương trình thực sự mã hóa và giải mã TripleDES đúng theo vector kiểm thử.

Nói cách khác, nếu sinh viên chỉ sửa README/tests cho đủ hình thức mà **không làm Q2 hoặc Q4**, CI sẽ vẫn fail.
