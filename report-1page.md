# Report 1 page - Lab 4 DES / TripleDES

## Mục tiêu
Hoàn thiện thuật toán mã hóa DES và mở rộng nó để hỗ trợ giải mã, xử lý văn bản nhiều khối (multi-block) kèm cơ chế zero padding. Tích hợp và kiểm thử thuật toán TripleDES theo quy chuẩn E-D-E cho mã hóa và D-E-D cho giải mã.

## Cách làm / Method
- **Cấu trúc lại luồng IO:** Thay đổi `main()` để sử dụng `cin` và xử lý chọn chức năng (mode 1 -> 4).
- **Phát triển Giải mã (Decryption):** Tận dụng lại bộ Feistel network của quá trình mã hóa gốc nhưng truyền vào mảng Round Keys theo thứ tự ngược (từ 16 về 1).
- **Xử lý khối lớn (Multi-block & Padding):** Viết hàm đệm thêm chuỗi bit '0' (`zero_pad()`) nếu chuỗi vào bị lẻ. Cắt chuỗi nhập vào thành các đoạn 64 bit, lặp qua thuật toán DES và ghép nối chuỗi kết quả cuối cùng.
- **Tích hợp TripleDES:** Chạy liên tiếp 3 block của DES với 3 khóa k1, k2, k3 theo mô hình E(k3, D(k2, E(k1, block))) cho mã hóa. 

## Kết quả / Result
- Thuật toán đọc input thành công từ CI auto-grade. Q2 và Q4 test scripts đều báo PASS (Xử lý đúng padding cho input 80 bits, Triple DES ra đúng chuỗi mong đợi).
- Các kịch bản Negative Testing đã được xây dựng và chứng minh đúng lỗ hổng nếu nhập sai key hoặc sửa byte.

## Kết luận / Conclusion
Thuật toán DES đã hoạt động trọn vẹn ở cả hai chiều và có khả năng xử lý chuỗi độ dài bất kỳ thông qua padding. Tuy nhiên, zero padding chưa tối ưu cho khôi phục bản gốc nguyên bản. Kiến trúc phát triển dạng hướng đối tượng giúp việc tái sử dụng hàm để thiết kế TripleDES rất ngắn gọn và rành mạch.