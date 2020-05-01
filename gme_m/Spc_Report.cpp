#include "Spc_Report.h"

Spc_Report *Spc_Report::obj = NULL;
int Spc_Report::last_pc = -1;
unsigned char Spc_Report::used[0x10006];
unsigned char Spc_Report::used2[0x101];
Spc_Report::Src Spc_Report::src[MAX_SRCN_ENTRIES];
