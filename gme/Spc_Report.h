#pragma once

#include "blargg_common.h"
#include "gme/Spc_Dsp_Register_Map_Interface.h"

#define spc_report_mem_read(addr) do { if (Spc_Report::mem_read) Spc_Report::mem_read(addr); } while(0)
#define spc_report_mem_echo(addr) do { if (Spc_Report::mem_echo) Spc_Report::mem_echo(addr); } while(0)
#define spc_report_mem_read2(addr, opcode) do { if (Spc_Report::mem_read2) Spc_Report::mem_read2(addr, opcode); } while(0)
#define spc_report_mem_write(addr) do { if (Spc_Report::mem_write) Spc_Report::mem_write(addr); } while(0)


namespace Spc_Report
{
  static const int BRR_HEADER_MAX=100, SRCN_MAX=0x200;
  extern int last_pc;
  extern int bcolor; // backup color
  //extern Mem_Surface memsurface;
  extern unsigned char used2[0x101];
  extern unsigned char used[0x10006];
  //extern blargg_vector<unsigned int> memread, memread2, memecho, memwrite;

	extern void (*mem_read)(unsigned addr);
	extern void (*mem_echo)(unsigned addr);
	extern void (*mem_read2)(unsigned addr, unsigned opcode);
	extern void (*mem_write)(unsigned addr);

  struct Src
  {
    uint16_t dir_addr; //unused for now
    uint16_t brr_start=0xffff;
    uint16_t brr_end=0xffff;
    uint16_t brr_loop_start=0xffff;
    uint16_t brr_loop_end=0xffff;
  };
  extern Src src[MAX_SRCN_ENTRIES];

  //int backup_color(int addr);

  //void restore_color(int addr);
}