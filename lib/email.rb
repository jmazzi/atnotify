def send_mail(to, message)
  m = Escape.shell_command(message)
  t = Escape.shell_command(to)
  system("echo #{m} | mail -s AtNotify #{t}")
end