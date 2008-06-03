#ifdef __STDC__
# define	P(s) s
#else
# define P(s) ()
#endif


/* amps_allreduce.c */
int amps_ReduceOperation P((amps_Comm comm , amps_Invoice invoice , char *buf_dest , char *buf_src , int operation ));
int amps_AllReduce P((amps_Comm comm , amps_Invoice invoice , int operation ));

/* amps_bcast.c */
int amps_BCast P((amps_Comm comm , int source , amps_Invoice invoice ));

/* amps_buffer.c */
void amps_FreeBufferFreeList P((void ));
int amps_AddToBufferList P((char *buf ));
char *amps_CheckBufferList P((int src ));

/* amps_clear.c */
void amps_ClearInvoice P((amps_Invoice inv ));

/* amps_clock.c */
void amps_clock_init P((void ));
amps_Clock_t amps_Clock P((void ));
amps_CPUClock_t amps_CPUClock P((void ));

/* amps_createinvoice.c */
int amps_CreateInvoice P((amps_Comm comm , amps_Invoice inv ));

/* amps_exchange.c */
void amps_vector_copy P((int type , amps_PackageItem *items , int dim , char **ptr_src , int *len , char **ptr_dst , int *dst_stride ));
void _amps_wait_exchange P((amps_Handle handle ));
amps_Handle amps_IExchangePackage P((amps_Package package ));

/* amps_ffopen.c */
amps_File amps_FFopen P((amps_Comm comm , char *filename , char *type , long size ));

/* amps_finalize.c */
int amps_memcheck P((void ));
int amps_Finalize P((void ));

/* amps_find_powers.c */
void amps_FindPowers P((int N , int *log , int *Nnext , int *Nprev ));

/* amps_fopen.c */
amps_File amps_Fopen P((char *filename , char *type ));

/* amps_init.c */
void amps_main P((void *arg ));
int main P((int argc , char *argv []));
int amps_Init P((int *argc , char **argv []));
void *_amps_CTAlloc P((int count , char *filename , int line ));
void *_amps_TAlloc P((int count , char *filename , int line ));

/* amps_invoice.c */
void amps_AppendInvoice P((amps_Invoice *invoice , amps_Invoice append_invoice ));
amps_Invoice amps_new_empty_invoice P((void ));
int amps_FreeInvoice P((amps_Invoice inv ));
int amps_add_invoice P((amps_Invoice *inv , int ignore , int type , int len_type , int len , int *ptr_len , int stride_type , int stride , int *ptr_stride , int dim_type , int dim , int *ptr_dim , int data_type , void *data ));
amps_Invoice amps_NewInvoice P((const char *fmt0 , ...));
int amps_num_package_items P((amps_Invoice inv ));

/* amps_io.c */
void amps_ScanChar P((amps_File file , char *data , int len , int stride ));
void amps_ScanShort P((amps_File file , short *data , int len , int stride ));
void amps_ScanInt P((amps_File file , int *data , int len , int stride ));
void amps_ScanLong P((amps_File file , long *data , int len , int stride ));
void amps_ScanFloat P((amps_File file , float *data , int len , int stride ));
void amps_ScanDouble P((amps_File file , double *data , int len , int stride ));
void amps_WriteDouble P((amps_File file , double *ptr , int len ));
void amps_WriteInt P((amps_File file , int *ptr , int len ));
void amps_ReadDouble P((amps_File file , double *ptr , int len ));
void amps_ReadInt P((amps_File file , int *ptr , int len ));
void amps_WriteInt P((amps_File file , int *ptr , int len ));
void amps_ReadInt P((amps_File file , int *ptr , int len ));

/* amps_irecv.c */
char *amps_recv P((int src ));
amps_Handle amps_IRecv P((amps_Comm comm , int source , amps_Invoice invoice ));

/* amps_newhandle.c */
amps_Handle amps_NewHandle P((amps_Comm comm , int id , amps_Invoice invoice , amps_Package package ));

/* amps_newpackage.c */
amps_Package amps_NewPackage P((amps_Comm comm , int num_send , int *dest , amps_Invoice *send_invoices , int num_recv , int *src , amps_Invoice *recv_invoices ));
void amps_FreePackage P((amps_Package package ));

/* amps_pack.c */
int amps_pack P((amps_Comm comm , amps_Invoice inv , char **buffer ));

/* amps_recv.c */
char *amps_recvb P((int src ));
int amps_Recv P((amps_Comm comm , int source , amps_Invoice invoice ));

/* amps_send.c */
int amps_xsend P((char *buffer , int dest ));
int amps_Send P((amps_Comm comm , int dest , amps_Invoice invoice ));

/* amps_sfbcast.c */
int amps_SFBCast P((amps_Comm comm , amps_File file , amps_Invoice invoice ));

/* amps_sfclose.c */
int amps_SFclose P((amps_File file ));

/* amps_sfopen.c */
amps_File amps_SFopen P((char *filename , char *type ));

/* amps_sizeofinvoice.c */
int amps_sizeof_invoice P((amps_Comm comm , amps_Invoice inv ));

/* amps_test.c */
int amps_Test P((amps_Handle handle ));

/* amps_unpack.c */
int amps_unpack P((amps_Comm comm , amps_Invoice inv , char *buffer ));

/* amps_vector.c */
void amps_vector_out P((amps_Comm comm , int type , char **data , char **buf_ptr , int dim , int *len , int *stride ));
void amps_vector_in P((amps_Comm comm , int type , char **data , char **buf_ptr , int dim , int *len , int *stride ));
int amps_vector_align P((amps_Comm comm , int type , char **data , char **buf_ptr , int dim , int *len , int *stride ));
int amps_vector_sizeof_buffer P((amps_Comm comm , int type , char **data , char **buf_ptr , int dim , int *len , int *stride ));
int amps_vector_sizeof_local P((amps_Comm comm , int type , char **data , char **buf_ptr , int dim , int *len , int *stride ));

/* amps_wait.c */
int amps_Wait P((amps_Handle handle ));

/* host.c */
int main P((int argc , char *argv []));

/* signal.c */
void handler_ill P((void ));
void handler_bus P((void ));
void handler_seg P((void ));
void handler_sys P((void ));
void handler_fpe P((void ));
void handler_division P((void ));
void handler_overflow P((void ));
void handler_invalid P((void ));
void Fsignal P((void ));

#undef P
