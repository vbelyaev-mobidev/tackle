class HostManagerBase

  def modify_dns(docker_ip)
    #TODO file is overwritten by resolveconf
    f = File.open('/etc/resolv.conf', 'r')
    lines = f.readlines
    f.close
    if lines.grep(/#{docker_ip}/).size == 0
      # Prepend lines to a file
      system("sudo sh -c 'echo \"nameserver #{docker_ip}\"|cat - /etc/resolv.conf > /tmp/out && mv /tmp/out /etc/resolv.conf'")
      system("sudo sh -c 'echo \"search consul\"|cat - /etc/resolv.conf > /tmp/out && mv /tmp/out /etc/resolv.conf'")
      puts "Host's DNS successfully modified. (/etc/resolv.conf)\n".green
    end
  end

end