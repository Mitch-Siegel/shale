OUTPUT_ARCH( "riscv" )

ENTRY( _start )

MEMORY
{
  ram   (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 128M
}

PHDRS
{
  text PT_LOAD;
  data PT_LOAD;
  bss PT_LOAD;
}

SECTIONS
{
  .text : {
    . = ALIGN(16);
    PROVIDE(_text_start = .);
    *(.text.init) *(.text .text.*)
    . = ALIGN(16);
    PROVIDE(_text_end = .);
  } AT>ram :text

  .rodata : {
    . = ALIGN(16);    
    PROVIDE(_rodata_start = .);
    *(.rodata .rodata.*)
    . = ALIGN(16);
    PROVIDE(_rodata_end = .);
  } AT>ram :text

  .data : {
    . = ALIGN(16);
    PROVIDE(_data_start = .);
    *(.sdata .sdata.*) 
    . = ALIGN(16);
    *(.data .data.*)
    . = ALIGN(16);
    PROVIDE(_data_end = .);
  } AT>ram :data

  .bss :{
    . = ALIGN(16);
    PROVIDE(_bss_start = .);
    *(.sbss .sbss.*) *(.bss .bss.*)
    . = ALIGN(16);
    PROVIDE(_bss_end = .);
  } AT>ram :bss

  PROVIDE(_memory_start = ORIGIN(ram));
  PROVIDE(_memory_end = ORIGIN(ram) + LENGTH(ram));
}