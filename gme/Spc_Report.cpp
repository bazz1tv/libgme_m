#include "gme/Spc_Report.h"

namespace Spc_Report
{
  //const int BRR_HEADER_MAX, SRCN_MAX;
  unsigned char used2[0x101];
  unsigned char used[0x10006];
  //Mem_Surface memsurface;
  int last_pc = -1;
  int bcolor=0; // backup color
  Src src[MAX_SRCN_ENTRIES];
  //blargg_vector<unsigned int> memread, memread2, memecho, memwrite;

	void (*mem_read)(unsigned addr) = NULL;
	void (*mem_echo)(unsigned addr) = NULL;
	void (*mem_read2)(unsigned addr, unsigned opcode) = NULL;
	void (*mem_write)(unsigned addr) = NULL;
}