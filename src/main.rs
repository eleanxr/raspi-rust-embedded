#![feature(lang_items)]
#![no_main]
#![no_std]

const RPI_PERIPHERAL_BASE: u32 = 0x3f000000;
const RPI_UART0_BASE: u32 = RPI_PERIPHERAL_BASE + 0x00201000;

fn print_uart0() {
  let addr = RPI_UART0_BASE as *mut char;
  unsafe { *addr = 'R' }
}

#[export_name = "_reset"]
pub extern "C" fn main() -> ! {
  let x = 42;
  let y = x;

  print_uart0();
  loop {}
}

mod lang_items {
  #[lang = "panic_fmt"]
  extern "C" fn panic_fmt() {}
  #[lang = "eh_personality"]
  extern "C" fn eh_personality() {}
}
