OUTPUT_ARCH( "riscv" )

ENTRY( _start )

MEMORY
{
  ram   (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS
{
  . = 0x80000000;

  .text : {
    . = ALIGN(16);
    PROVIDE(_text_start = .);
    *(.text.init) *(.text .text.*)
    . = ALIGN(16);
    PROVIDE(_text_end = .);
  }

  .rodata : {
    . = ALIGN(16);    
    PROVIDE(_rodata_start = .);
    *(.rodata .rodata.*)
    . = ALIGN(16);
    PROVIDE(_rodata_end = .);
  }

  .data : {
    . = ALIGN(16);
    PROVIDE(_data_start = .);
    *(.sdata .sdata.*) 
    . = ALIGN(16);
    *(.data .data.*)
    . = ALIGN(16);
    PROVIDE(_data_end = .);
  }

  .bss :{
    . = ALIGN(16);
    PROVIDE(_bss_start = .);
    *(.sbss .sbss.*) *(.bss .bss.*)
    . = ALIGN(16);
    PROVIDE(_bss_end = .);
  }

  PROVIDE(_kernel_end = .);
  PROVIDE(_memory_end = ORIGIN(ram) + LENGTH(ram));
}