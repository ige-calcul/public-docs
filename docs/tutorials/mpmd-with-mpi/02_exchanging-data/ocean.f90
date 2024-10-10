program ocean

  use mpi
  implicit none

  character(len=5), parameter :: name = "ocean"
  integer :: error, n_proc, myself, n

  call mpi_init(error)
  call mpi_comm_size(mpi_comm_world, n_proc, error)
  call mpi_comm_rank(mpi_comm_world, myself, error)

  if (myself == 7) then
     call mpi_recv(n, 1, mpi_int, 0, 0, mpi_comm_world, mpi_status_ignore, error)
     print '(A, I1, A, I4)', name // " (rank=", myself, "), received ", n
     print '(A, I1, A, I4)', name // " (rank=", myself, "), sending ", 5678
     call mpi_send(5678, 1, mpi_int, 0, 1, mpi_comm_world, error)
  endif

  call mpi_finalize(error)

end program ocean
