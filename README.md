Issue Reproduction
==================

## Environments
- GHC:
  + GHC 8.10.7, stage 2 booted by GHC version 8.10.4(installed via `ghcup`)
  + GHC 9.0.2, stage 2 booted by GHC version 8.10.7(installed via `ghcup`)
- OS: Linux 5.18.16-arch1-1, x86_64 ArchLinux

## Instructions

```
cabal run --enable-profiling -- rts-err +RTS -hc
```

## More information

```
(gdb) r
Starting program: /home/commelina/Work/rts-err/dist-newstyle/build/x86_64-linux/ghc-8.10.7/rts-err-0.1.0.0/x/rts-err/build/rts-err/rts-err +RTS -hc
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".
[New Thread 0x7ffff71fd6c0 (LWP 352300)]
[New Thread 0x7ffff69fc6c0 (LWP 352301)]
[New Thread 0x7ffff61fb6c0 (LWP 352302)]
[New Thread 0x7ffff59fa6c0 (LWP 352303)]
12345
[New Thread 0x7ffff51f96c0 (LWP 352304)]

Thread 4 "rts-err:w" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff61fb6c0 (LWP 352302)]
0x0000000001be41b4 in closureSatisfiesConstraints (p=0x42001df000) at rts/ProfHeap.c:623

(gdb) bt
#0  0x0000000001be41b4 in closureSatisfiesConstraints (p=0x42001df000) at rts/ProfHeap.c:623
#1  0x0000000001be4572 in heapProfObject (census=census@entry=0x26094b0, p=0x42001df000, size=134, prim=<optimized out>) at rts/ProfHeap.c:929
#2  0x0000000001be4760 in heapCensusChain (census=census@entry=0x26094b0, bd=0x42001037c0) at rts/ProfHeap.c:1176
#3  0x0000000001be5433 in heapCensus (t=t@entry=3108654) at rts/ProfHeap.c:1220
#4  0x0000000001bf1b83 in GarbageCollect (collect_gen=<optimized out>, collect_gen@entry=1, do_heap_census=do_heap_census@entry=true,
    deadlock_detect=deadlock_detect@entry=false, gc_type=gc_type@entry=2, cap=cap@entry=0x25fb6d0, idle_cap=idle_cap@entry=0x7fffe8000bc0)
    at rts/sm/GC.c:917
#5  0x0000000001be1960 in scheduleDoGC (pcap=pcap@entry=0x7ffff61fae50, task=task@entry=0x7ffff0000bc0, force_major=force_major@entry=false,
    deadlock_detect=deadlock_detect@entry=false) at rts/Schedule.c:1849
#6  0x0000000001be23da in schedule (initialCapability=initialCapability@entry=0x25d4a80 <MainCapability>, task=task@entry=0x7ffff0000bc0)
    at rts/Schedule.c:564
#7  0x0000000001be32fc in scheduleWorker (cap=cap@entry=0x25d4a80 <MainCapability>, task=task@entry=0x7ffff0000bc0) at rts/Schedule.c:2626
#8  0x0000000001bdf0d8 in workerStart (task=0x7ffff0000bc0) at rts/Task.c:446
#9  0x00007ffff7a9f78d in ?? () from /usr/lib/libc.so.6
#10 0x00007ffff7b208e4 in clone () from /usr/lib/libc.so.6

(gdb) p p->header.prof.ccs
$1 = (CostCentreStack *) 0x2cc

(gdb) p *p
$1 = {header = {info = 0x1c03a08 <stg_MUT_ARR_PTRS_FROZEN_CLEAN_info>, prof = {ccs = 0x2cc, hp = {trav = {lsb = 0, rs = 0x0}, ldvw = 0}}},
  payload = 0x42001df018}
```
