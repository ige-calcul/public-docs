program atmosphere

  use mpi
  implicit none

  character (len=10), parameter :: name = "atmosphere"
  integer :: error, n_proc, myself, n

  call mpi_init(error)
  call mpi_comm_size(mpi_comm_world, n_proc, error)
  call mpi_comm_rank(mpi_comm_world, myself, error)

  if (myself == 0) then
     print '(A, I1, A, I4)', name // " (rank=", myself, ") sending ", 1234
     call mpi_send(1234, 1, mpi_int, 7, 0, mpi_comm_world, error)
     call mpi_recv(n, 1, mpi_int, 7, 1, mpi_comm_world, mpi_status_ignore, error)
     print '(A, I1, A, I4)', name // " (rank=", myself, "), received ", n
  endif

  call mpi_finalize(error)

end program atmosphere
