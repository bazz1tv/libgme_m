#pragma once

#include "blargg_common.h"
#include "gme/Spc_Dsp_Register_Map_Interface.h"

#define spc_report_mem_read(addr) do { if (Spc_Report::obj) Spc_Report::obj->report(Spc_Report::Type::Read, addr, 0); } while(0)
#define spc_report_mem_echo(addr) do { if (Spc_Report::obj) Spc_Report::obj->report(Spc_Report::Type::Echo, addr, 0); } while(0)
#define spc_report_mem_execute(addr, opcode) do { if (Spc_Report::obj) Spc_Report::obj->report(Spc_Report::Type::Execute, addr, opcode); } while(0)
#define spc_report_mem_write(addr) do { if (Spc_Report::obj) Spc_Report::obj->report(Spc_Report::Type::Write, addr, 0); } while(0)


class Spc_Report
{
public:
  Spc_Report() {obj = this;}
  static const int BRR_HEADER_MAX=100, SRCN_MAX=0x200;
  static int last_pc;
  static int bcolor; // backup color
  //extern Mem_Surface memsurface;
  static unsigned char used2[0x101];
  static unsigned char used[0x10006];
  //extern blargg_vector<unsigned int> memread, memread2, memecho, memwrite;
  enum Type { Read, Execute, Echo, Write};
  virtual void report(Type type, unsigned addr, unsigned opcode)=0;
	/*static void (*mem_read)(unsigned addr);
	static void (*mem_echo)(unsigned addr);
	static void (*mem_execute)(unsigned addr, unsigned opcode);
	static void (*mem_write)(unsigned addr);*/

  struct Src
  {
    uint16_t dir_addr; //unused for now
    uint16_t brr_start=0xffff;
    uint16_t brr_end=0xffff;
    uint16_t brr_loop_start=0xffff;
    uint16_t brr_loop_end=0xffff;
  };
  static Src src[MAX_SRCN_ENTRIES];

  static Spc_Report *obj;

  //int backup_color(int addr);

  //void restore_color(int addr);
};