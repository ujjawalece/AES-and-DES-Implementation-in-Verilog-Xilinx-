# Advanced Encryption Standard(AES) Implementation in Verilog(Xilinx)-
### Problem Statement-
We have to design Encryption and Decryption scheme for following modes of operation on Advanced Encryption Standard **(AES-128)**:
1) Electronic Code Book Mode
2) Cipher Block Chaining Mode
3) Cipher Feedback Mode
4) Output Feedback Mode

And we have to implement these all modes on a input image i.e. we have to encrypt a given image using different modes of operation on AES.

You can refer complete Problem Sattement [here](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/I-Chip'21_PS2.pdf).

### Advanced Encryption Standard(AES)-
You can study about AES from [here](https://drive.google.com/file/d/1fXcfTqueZp4jEbvJ7aREmucFXVnKPwJU/view?usp=sharing) and about different modes of operation from [here](https://drive.google.com/file/d/1sOd31YbFAfZne7c2WQ0h9owgZI_9_66C/view?usp=sharing) or you can read [this](https://drive.google.com/file/d/1COexFHtUOkY0hctzP4QFXxKHtCyYmSTj/view?usp=sharing) also.

### Approach-
We have an [image](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/input%20img.png) as input. But we can run our verilog code only on binary input so first we have to convert the given image to binary format using a [python code](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/img_to_bin.py).

Now we have a [binary file](https://drive.google.com/file/d/1sv3McjstNTsyuFuCgej_9hQ33x0G6OXg/view?usp=sharing), we will process on this file.

### Solution-
All files are uploaded in this [Folder](https://drive.google.com/drive/folders/1RY1nacWV1pgeSxUQ8AQtCQ7WS-oZZzpe?usp=sharing).
Please refer [this file](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/ClasherS_Explanation.txt) to understand what each file do.

### Results-

### ECB (Electronic Code Book) mode-

**Encrypted image-**
![im](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/ecb_enc.png)

**Decrypted image-**
![im](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/ecb_dec.png)

### CBC (Cipher Block Chaining) mode-

**Encrypted image-**
![im](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/cbc_enc.png)

**Decrypted image-**
![im](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/cbc_dec.png)

### CFB (Cipher FeedBack) mode-

**Encrypted image-**
![im](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/cfb_enc.png)

**Decrypted image-**
![im](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/cfb_dec.png)

### OFB (Output FeedBack) mode-

**Encrypted image-**
![im](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/ofb_enc.png)

**Decrypted image-**
![im](https://github.com/ujjawalece/AES-and-DES-Implementation-in-Verilog-Xilinx-/blob/main/ofb_dec.png)




# Data Encryption Standard(DES) Implementation in Verilog(Xilinx)-
You can see complete **DES cipher implementation** [here](https://github.com/ujjawalece/Verilog-code-for-different-modes-of-DES).
