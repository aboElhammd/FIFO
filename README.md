FIFO Verification Project :

This project involves verifying the functionality of a First-In-First-Out (FIFO) module with the following specifications:
![image](https://github.com/aboElhammd/FIFO/assets/124165601/6086b7b6-7c58-4f1f-880b-86656e5728ae)

Testbench Flow :
The top module will generate the clock, pass it to the interface, and the interface will be passed to the 
DUT, tb, and monitor modules. The tb will reset the DUT and then randomize the inputs. At the end of 
the test, the tb will assert a signal named test_finished. The signal will be defined as well as the 
error_count and correct_count in a shared package  named shared_pkg. 
The monitor module will do the following:
1. Create objects of 3 different classes (FIFO_transaction, FIFO_scoreboard, FIFO_coverage). .
2. It will have an initial block and inside it a forever loop that has a negedge clock sample. With 
each negedge clock, the monitor will sample the data of the interface and assign it to the data of 
the object of class FIFO_transaction. And then after that there will be fork join, where 2 
processes will run, the first one is calling a function named sample_data of the object of class 
FIFO_coverage and the second process is calling a function named check_data of the object of 
class FIFO_scoreboard .

So, in summary the monitor will sample the interface ports, and then pass these values to be 
sampled for functional coverage and to be checked if the output ports are correct or not.
After the fork join ends, you will check for the signal test_finished if it is high or not. If it high, 
then the simulation stops and I display a message with summary of correct and error counts .

Verification Requirements :

The verification requirements for the FIFO module are as follows:
![image](https://github.com/aboElhammd/FIFO/assets/124165601/ebaf0a76-2745-41e4-a195-459f07986246)

Coverage Report:
The coverage report for the verification is included in the repository and here is the most important parts of it :
branch coverage :
![image](https://github.com/aboElhammd/FIFO/assets/124165601/783ffb04-e2c1-424b-8269-f0cba609d5f6)
statement coverage :
![image](https://github.com/aboElhammd/FIFO/assets/124165601/6c129011-447d-4b79-8ef4-c7b09e238a77)
toggle coverage :
![image](https://github.com/aboElhammd/FIFO/assets/124165601/02d01b18-a3c2-4f58-b013-de09e00b80f4)
assertion covergae :
![image](https://github.com/aboElhammd/FIFO/assets/124165601/c558610e-a29b-4cf0-b4f5-54a28cf2777a)
functional coverage :
![image](https://github.com/aboElhammd/FIFO/assets/124165601/3a90414f-3126-43ce-ab3e-3c798ec66bc6)

Bug Identification and Rectification:
During the verification process, several bugs were identified and rectified and here is the bugs that i found :
1.almostfull signal is high when we have one place empty but in the code it was 
high when we have two places.
2.in the first always block the designer forget to reset wr_ack and overflow 
signals.
3.in the second always block underflow signal wasn’t there although it’s 
sequential so we add it to the always block and the data out wasn’t involved in 
reset case so we add it also.
4.counter didn’t handle corner cases like if the FIFO is full and I have read and 
write operations so the FIFO should read only and decrement the counter so we 
made it able to handle this situation and also the situation where we have an 
empty FIFO and read and write operations so the counter should increase but it 
didn’t so we handled these two cases
Random Questa snippets :
![image](https://github.com/aboElhammd/FIFO/assets/124165601/3279f694-cf8f-403b-9486-9004e5c9d9fc)

![image](https://github.com/aboElhammd/FIFO/assets/124165601/66c8a217-3393-4d65-9d9c-b3d86998072d)
