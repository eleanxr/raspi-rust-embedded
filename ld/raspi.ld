OUTPUT_FORMAT("elf32-littlearm")

ENTRY(_reset);

SECTIONS
{
  . = 0x8000;
  .text :
  {
    /* Reset handler */
    _reset = .;
    *(.text._reset)

    *(.text*)
  }

  /DISCARD/ :
  {
    *(.ARM.exidx*)
    *(.note.gnu.build-id*)
  }
}
