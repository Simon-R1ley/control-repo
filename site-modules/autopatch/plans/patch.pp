# plan/patch.pp
plan autopatch::patch (
  TargetSpec $targets,
) {
  # Invoke the task and store the result in $rootstatus
  $rootstatus = run_task('autopatch::checkingroot', $targets)

  # Access the exit_code attribute to obtain the exit code
  $exit_code = $rootstatus['exit_code']

  # Check the exit code and take appropriate actions
  if $exit_code == 0 {
    notify { 'Root space check succeeded': }
  } else {
    notify { 'Root space check failed': }
  }

  # Continue with patching logic
  $patchstatus = run_task('autopatch::patch', $targets)

  if $patchstatus == 0 {
    fail_plan('patching failed')
  }
}
