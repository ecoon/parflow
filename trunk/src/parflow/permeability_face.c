/*BHEADER**********************************************************************
 * (c) 1995   The Regents of the University of California
 *
 * See the file COPYRIGHT_and_DISCLAIMER for a complete copyright
 * notice, contact person, and disclaimer.
 *
 * $Revision: 1.1.1.1 $
 *********************************************************************EHEADER*/
/******************************************************************************
 *
 *****************************************************************************/

#include "parflow.h"

#define Mean(a, b) CellFaceConductivity(a, b)

/*--------------------------------------------------------------------------
 * Structures
 *--------------------------------------------------------------------------*/

typedef struct
{
   int          time_index;
} PublicXtra;

typedef struct
{
   Grid              *z_grid;
} InstanceXtra;


/*--------------------------------------------------------------------------
 * PermeabilityFace
 *--------------------------------------------------------------------------*/

void    PermeabilityFace(zperm, permeability)
Vector *zperm;
Vector *permeability;
{
   PFModule      *this_module      = ThisPFModule;
   InstanceXtra  *instance_xtra    = PFModuleInstanceXtra(this_module);
   PublicXtra   *public_xtra   = PFModulePublicXtra(this_module);


   Grid         *z_grid   = (instance_xtra -> z_grid);

   CommHandle   *handle;

   SubgridArray *subgrids;
   Subgrid      *subgrid;

   Subvector    *subvector_pc, *subvector_pf;

   int           ix, iy, iz;
   int           nx, ny, nz;
   double        dx, dy, dz;

   int           nx_pc, ny_pc, nz_pc;
   int           nx_pf, ny_pf, nz_pf;

   int           pci, pfi;

   int           sg, i, j, k;
   int           flopest;

   double       *pf,  *pc_l, *pc_u;

   /*-----------------------------------------------------------------------
    * Begin timing
    *-----------------------------------------------------------------------*/

    BeginTiming(public_xtra -> time_index);

   /*-----------------------------------------------------------------------
    * exchange boundary data for cell permeability values
    *-----------------------------------------------------------------------*/
   handle = InitVectorUpdate(permeability, VectorUpdateAll);
   FinalizeVectorUpdate(handle);

   /*-----------------------------------------------------------------------
    * compute the z-face permeabilities for each subgrid
    *-----------------------------------------------------------------------*/

   subgrids = GridSubgrids(z_grid);
   ForSubgridI(sg, subgrids)
   {
      subgrid = SubgridArraySubgrid(subgrids, sg);

      subvector_pc    = VectorSubvector(permeability, sg);
      subvector_pf    = VectorSubvector(zperm, sg);

      ix = SubgridIX(subgrid);
      iy = SubgridIY(subgrid);
      iz = SubgridIZ(subgrid);

      nx = SubgridNX(subgrid);
      ny = SubgridNY(subgrid);
      nz = SubgridNZ(subgrid);

      dx = SubgridDX(subgrid);
      dy = SubgridDY(subgrid);
      dz = SubgridDZ(subgrid);

      nx_pc = SubvectorNX(subvector_pc);
      ny_pc = SubvectorNY(subvector_pc);
      nz_pc = SubvectorNZ(subvector_pc);

      nx_pf = SubvectorNX(subvector_pf);
      ny_pf = SubvectorNY(subvector_pf);
      nz_pf = SubvectorNZ(subvector_pf);

      flopest = nx_pf * ny_pf * nz_pf;

      pc_l = SubvectorElt(subvector_pc, ix  ,iy  ,iz-1);
      pc_u = SubvectorElt(subvector_pc, ix  ,iy  ,iz  );

      pf = SubvectorElt(subvector_pf, ix  ,iy  ,iz);

      pci = 0; pfi = 0;

      BoxLoopI2(i,j,k,
                ix,iy,iz,nx,ny,nz,
                pci,nx_pc,ny_pc,nz_pc,1,1,1,
                pfi,nx_pf,ny_pf,nz_pf,1,1,1,
      {
         pf[pfi] = Mean( pc_l[pci], pc_u[pci] );
      });

      IncFLOPCount( flopest );

   }

   /*-----------------------------------------------------------------------
    * exchange boundary data for face permeabilities values
    *-----------------------------------------------------------------------*/
   handle = InitVectorUpdate(zperm, VectorUpdateVelZ);
   FinalizeVectorUpdate(handle);

   /*-----------------------------------------------------------------------
    * End timing
    *-----------------------------------------------------------------------*/

    EndTiming(public_xtra -> time_index);

}


/*--------------------------------------------------------------------------
 * PermeabilityFaceInitInstanceXtra
 *--------------------------------------------------------------------------*/

PFModule *PermeabilityFaceInitInstanceXtra(z_grid)
Grid     *z_grid;
{
   PFModule     *this_module  = ThisPFModule;
   InstanceXtra *instance_xtra;

   if ( PFModuleInstanceXtra(this_module) == NULL )
      instance_xtra = ctalloc(InstanceXtra, 1);
   else
      instance_xtra = PFModuleInstanceXtra(this_module);

   /*-----------------------------------------------------------------------
    * Setup the InstanceXtra structure
    *-----------------------------------------------------------------------*/
   /*** Set the pointer to the grid ***/
   if ( z_grid != NULL )
   {
      (instance_xtra -> z_grid) = z_grid;
   }

   PFModuleInstanceXtra(this_module) = instance_xtra;

   return this_module;
}

/*--------------------------------------------------------------------------
 * PermeabilityFaceFreeInstanceXtra
 *--------------------------------------------------------------------------*/

void  PermeabilityFaceFreeInstanceXtra()
{
   PFModule     *this_module   = ThisPFModule;
   InstanceXtra *instance_xtra = PFModuleInstanceXtra(this_module);

   if ( instance_xtra )
   {
      free( instance_xtra );
   }
}

/*--------------------------------------------------------------------------
 * PermeabilityFaceNewPublicXtra
 *--------------------------------------------------------------------------*/

PFModule  *PermeabilityFaceNewPublicXtra()
{
   PFModule     *this_module  = ThisPFModule;
   PublicXtra   *public_xtra;

   /*----------------------------------------------------------------------
    * Setup the PublicXtra structure
    *----------------------------------------------------------------------*/
   public_xtra = ctalloc(PublicXtra, 1);

   /*-------------------------------------------------------------*/
   /*                receive user input parameters                */

   /*-------------------------------------------------------------*/
   /*                     setup parameters                        */

   (public_xtra -> time_index) = RegisterTiming("Permeability Face");

   /*-------------------------------------------------------------*/

   PFModulePublicXtra(this_module) = public_xtra;

   return this_module;
}

/*--------------------------------------------------------------------------
 * PermeabilityFaceFreePublicXtra
 *--------------------------------------------------------------------------*/

void PermeabilityFaceFreePublicXtra()
{
   PFModule     *this_module  = ThisPFModule;
   PublicXtra   *public_xtra  = PFModulePublicXtra(this_module);

   if ( public_xtra )
   {
      free( public_xtra );
   }

}


/*--------------------------------------------------------------------------
 * PermeabilityFaceSizeOfTempData
 *--------------------------------------------------------------------------*/

int  PermeabilityFaceSizeOfTempData()
{
   return 0;
}
