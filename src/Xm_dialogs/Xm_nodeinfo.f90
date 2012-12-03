  !***********************************************************************
  !    Copyright (C) 1995-
  !        Roy A. Walters, R. Falconer Henry
  !
  !        rawalters@shaw.ca
  !
  !    This file is part of TQGG, Triangle-Quadrilateral Grid Generation,
  !    a grid generation and editing program.
  !
  !    TQGG is free software; you can redistribute it and/or
  !    modify it under the terms of the GNU General Public
  !    License as published by the Free Software Foundation; either
  !    version 3 of the License, or (at your option) any later version.
  !
  !    This program is distributed in the hope that it will be useful,
  !    but WITHOUT ANY WARRANTY; without even the implied warranty of
  !    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  !    General Public License for more details.
  !
  !    You should have received a copy of the GNU General Public
  !    License along with this program; if not, write to the Free Software
  !    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
  !    USA, or see <http://www.gnu.org/licenses/>.
  !***********************************************************************

!---------------------------------------------------------------------------*
!                              INFO.FOR                                     *
!     This module controls the right hand display panel for the displaying  *
!     of information about vertices and allows the user to change values    *
!     associated with those vertices. The Text file option is also handled  *
!     in this module, along with a proposed module to display triangle info.*
!---------------------------------------------------------------------------*
!---------------------------------------------------------------------------*
      SUBROUTINE Init_Info( )

! Purpose : To initialize the area to the right of the grid which
!           is the INFO screen.
! Given   : 
! Returns : None.

!--------BEGIN--------------

      call PigPutMessage('Choose node in main window...')

      END

!--------------------------------------------------------------------------*

      SUBROUTINE GetVal_CW_ehandler( )

! Purpose : To get all the information for a point on the grid
! Given   : nrec = the number of points read in from the data file
!           mmode = whether operation is for Information
!                   or Change a value
! Returns : index = index of the point we will be examining,
!           changev = logical set TRUE if any changes take place
!                     to the data that is to be written back
!                     to the files.

! put in dialog
      end

!--------------------------------------------------------------------------*

      SUBROUTINE GetVal_MW_Ehandler(Xinp, Yinp, Index)

! Purpose : To get all the information for a point on the grid
! Given   : nrec = the number of points read in from the data file
!           mmode = whether operation is for Information
!                   or Change a value
!           Xinp = x position to locate node
!           Yinp = y position to locate node
! Returns : index = index of the point we will be examining,
!           changev = logical set TRUE if any changes take place
!                     to the data that is to be written back
!                     to the files.

      use MainArrays

      INCLUDE '../includes/defaults.inc'

! - PASSED VARIABLES
      real xinp, yinp
      integer index

! *** LOCAL VARIABLES ***
      integer ierr

!     - see if the point exists
      call CHKPT( xinp, yinp, INDEX, ierr )
      if ( ierr .eq. 1 ) then
        call PigPutMessage('ERROR - Invalid point..')
      else
        call PutMarker( DXRAY(index), DYRAY(index), 4, InfoColor)
        write(*,*) ' index, code=', index, code(index)
        write(*,*) ' x,y,z=',DXRAY(index), DYRAY(index),depth(index)
        write(*,*) ' nbrs=',(nL(j,index),j=1,nbtotr)
!        call Put_Val( index, mmode )
      endif
      
      END

!---------------------------------------------------------------------------*

      SUBROUTINE InfoFiles

! Purpose : Displays the default filenames currently in use during the
!           current interactive session.
! Givens  : None
! Returns : None
! Effects : None

      INCLUDE '../includes/defaults.inc'

      character*256 cstr
      integer len1, len2, len3, len4, len5, len6
!-----------BEGIN------------------

      if(DispNodes) then
        len1 = len_trim(NodeRName)
      else
        len1 = len_trim(GridRName)
      endif
      len2 = len_trim(LastInterim)
      len3 = len_trim(ContFName)
      len4 = len_trim(BoundFName)
      len5 = len_trim(VCritName)
      len6 = len_trim(TCritName)

      if(DispNodes) then
        cstr = &
       'Node File: '// NodeRName(:len1)//char(13)//&
       'Last Interim Node File: '// LastInterim(:len2)//char(13)//&
       'Contours File: '// ContFName(:len3)//char(13)//&
       'Boundary File: '// BoundFName(:len4)//char(13)//&
       'Vertex Criterion File: '// VCritName(:len5)//char(13)//&
       'Triangle Criterion File: '// TCritName(:len6)//char(0)
      else
        cstr = &
       'Grid File: '// GridRName(:len1)//char(13)//&
       'Last Interim Grid File: '// LastInterim(:len2)//char(13)//&
       'Contours File: '// ContFName(:len3)//char(13)//&
       'Boundary File: '// BoundFName(:len4)//char(13)//&
       'Vertex Criterion File: '// VCritName(:len5)//char(13)//&
       'Triangle Criterion File: '// TCritName(:len6)//char(0)
      endif

      call PigMessageOK(cstr, 'FILES')

      END
!-----------------------------------------------------------------------*
!                       END INFO.FOR                                    *
!-----------------------------------------------------------------------*