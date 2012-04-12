task :do_work do
  while true
    sleep 10.seconds
    `rake score`
  end
end
