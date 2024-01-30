# shale is a homebrew operating system on a (mostly) custom toolchain
Relying on the [substratum language and compiler](https://github.com/Mitch-Siegel/substratum), this is my first attempt to write an operating system.

It takes inspiration for much of its lowest-level functionality from [xv6-riscv](https://github.com/mit-pdos/xv6-riscv), such as RISC-V primitives and interaction with the uarch iteself. Consider this my fessing up to "copying their homework" for things such as "how do I interact with the system to set up the proper superviser-mode permissions?" and other such functionality that I would otherwise flounder with.

I'm not completely sure what my design goal is in the long-term, however I'm currently leaning towards a message-passing based microkernel.

