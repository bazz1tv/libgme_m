#include "gme/Spc_Report.h"

Spc_Report *Spc_Report::obj = NULL;
//void (*Spc_Report::report)(Type type, unsigned addr, unsigned opcode) = NULL;
/*void (*Spc_Report::mem_read)(unsigned addr) = NULL;
void (*Spc_Report::mem_echo)(unsigned addr) = NULL;
void (*Spc_Report::mem_execute)(unsigned addr, unsigned opcode) = NULL;
void (*Spc_Report::mem_write)(unsigned addr) = NULL;*/
int Spc_Report::last_pc = -1;
int Spc_Report::bcolor = 0; // backup color
unsigned char Spc_Report::used[0x10006];
unsigned char Spc_Report::used2[0x101];
Spc_Report::Src Spc_Report::src[MAX_SRCN_ENTRIES];


/*namespace Spc_Report
{
  //const int BRR_HEADER_MAX, SRCN_MAX = NULL;
  unsigned char used2[0x101] = NULL;
  unsigned char used[0x10006] = NULL;
  //Mem_Surface memsurface = NULL;
  int last_pc = -1 = NULL;
  int bcolor=0 = NULL; // backup color
  Src src[MAX_SRCN_ENTRIES] = NULL;
  //blargg_vector<unsigned int> memread, memread2, memecho, memwrite = NULL;

  void (*report)(Type type, unsigned addr, unsigned opcode/*=0*///) = NULL;
	/*void (*mem_read)(unsigned addr) = NULL = NULL;
	void (*mem_echo)(unsigned addr) = NULL = NULL;
	void (*mem_execute)(unsigned addr, unsigned opcode) = NULL = NULL;
	void (*mem_write)(unsigned addr) = NULL = NULL;
}*/