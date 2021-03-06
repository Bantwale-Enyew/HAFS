module diagnostics_interface

  !=======================================================================

  !$$$ MODULE DOCUMENTATION BLOCK
  
  ! obs_to_bufr :: diagnostics_interface
  ! Copyright (C) 2018 Henry R. Winterbottom

  ! Email: henry.winterbottom@noaa.gov

  ! This program is free software: you can redistribute it and/or
  ! modify it under the terms of the GNU General Public License as
  ! published by the Free Software Foundation, either version 3 of the
  ! License, or (at your option) any later version.

  ! This program is distributed in the hope that it will be useful,
  ! but WITHOUT ANY WARRANTY; without even the implied warranty of
  ! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  ! General Public License for more details.

  ! You should have received a copy of the GNU General Public License
  ! along with this program.  If not, see
  ! <http://www.gnu.org/licenses/>.

  !=======================================================================

  ! Define associated modules and subroutines

  use kinds_interface

  ! Define interfaces and attributes for module routines
  
  implicit none
  private
  public :: diagnostics_time_start
  public :: diagnostics_time_stop

  !-----------------------------------------------------------------------

contains

  !=======================================================================

  ! SUBROUTINE:

  ! diagnostics_time_start.f90

  ! DESCRIPTION:

  ! This subroutine calls the intrinsic subroutine cpu_time and
  ! defines the elapsed CPU time in seconds.

  ! INPUT VARIABLES:

  ! * time_start; a FORTRAN 4-byte real value.

  ! OUTPUT VARIABLES:

  ! * time_start; a FORTRAN 4-byte real value specifying the elapsed
  !   CPU time; units are seconds.

  !-----------------------------------------------------------------------

  subroutine diagnostics_time_start(time_start) 

    ! Define variables passed to routine

    real(r_kind)                                                        :: time_start

    !=====================================================================

    ! Define local variables

    call cpu_time(time_start)

    !=====================================================================

  end subroutine diagnostics_time_start

  !=======================================================================

  ! SUBROUTINE:

  ! diagnostics_time_stop.f90

  ! DESCRIPTION:

  ! This subroutine computes the total time since the user specified
  ! starting time and prints a message indicating the time in
  ! accordance with the optional variables provided by the user.

  ! INPUT VARIABLES:

  ! * time_start; a FORTRAN 4-byte real specifying the value returned
  !   by subroutine diagnostics_time_start.f90.

  ! OPTIONAL INPUT VARIABLES:

  ! * caller_name; a FORTRAN character string defining the calling
  !   subroutine/function name/

  !-----------------------------------------------------------------------

  subroutine diagnostics_time_stop(time_start,caller_name)

    ! Define variables passed to routine

    character(len=*),   optional                                        :: caller_name
    real(r_kind)                                                        :: time_start

    ! Define variables computed within routine

    real(r_kind)                                                        :: time_stop

    !=====================================================================

    ! Define local variables
    
    call cpu_time(time_stop)
    
    ! Check local variable and proceed accordingly
    
    if(.not. present(caller_name)) then
          
       ! Define local variables
       
       write(6,500) (time_stop - time_start)
       
    end if ! if(.not. present(caller_name))
    
    ! Check local variable and proceed accordingly

    if(present(caller_name)) then

       ! Define local variables

       write(6,501) trim(adjustl(caller_name)), (time_stop - time_start)

    end if ! if(present(caller_name)

    ! Define local variables

500 format('Execution time: ', f13.5, ' seconds.')
501 format('Time spent in routine ', a, ': ', f13.5, ' seconds.')

    !=====================================================================

  end subroutine diagnostics_time_stop

  !=======================================================================

end module diagnostics_interface
