module Landrush
  module Cap
    module Arch
      module RestartDnsmasq
        class << self
          SED_COMMAND = <<-EOF.gsub(/^ +/, '')
          sudo sed -i.orig '1 i\
          # Added by landrush, a vagrant plugin \\
          nameserver 127.0.0.1 \\
          ' /etc/resolv.conf
          EOF

          def restart_dnsmasq(_env)
            system(SED_COMMAND) unless system("cat /etc/resolv.conf | grep 'nameserver 127.0.0.1' > /dev/null 2>&1")
            system('sudo systemctl restart dnsmasq')
          end
        end
      end
    end
  end
end
