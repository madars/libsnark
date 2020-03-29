; TinyRAM V=1.996 M=vn W=16 K=16
;;; knapsack
;;; primary input: TARGET a_1 a_2 ... a_k
;;; auxiliary input: b_k b_{k-1} ... b_1
;;; answer = TARGET - (a_1 * b_1 + ... + a_k * b_k)
;;; memory layout: LEN, input0, input1, ...
store.w 0 r0                    ; I_0:
mov r0 32768                    ; I_1:
read r1 0                       ; I_2:
cjmp 28                         ; I_3:
add r0 r0 14                    ; I_4:
store.w r0 r1                   ; I_5:
jmp 12                          ; I_6:
store.w 32768 r0                ; I_7: end of prelude
_loop: cmpe r0 32770            ; I_8:
cjmp _bail                      ; I_9: bail out if end of input
load.w r1 r0                    ; I_10: read [r0] into r1
sub r0 r0 2                     ; I_11: r0 -= 2
read r2 1                       ; I_12: read auxiliary input in r2 (note that pairs are processed in reverse order)
mull r3 r1 r2                   ; I_13: r3 = [r0] * aux
add r4 r4 r3                    ; I_14: r4 += [r0] * aux
jmp _loop                       ; I_15: another iteration
_bail: load.w r5 r0             ; I_16: r5 = [r0] = [32770]
sub r4 r4 r5                    ; I_17: check if cumulative sum is [32770]
answer r4                       ; I_18:
