require_relative '../../helper'

module VagrantWindows
  module Guest
    module Cap
      class MountSharedFolder
        
        def self.mount_virtualbox_shared_folder(machine, name, guestpath, options)
          mount_shared_folder(machine, name, guestpath, options, "\\\\vboxsrv\\")
        end
        
        def self.mount_vmware_shared_folder(machine, name, guestpath, options)
          mount_shared_folder(machine, name, guestpath, options, "\\\\vmware-host\\Shared Folders\\")
        end
        
        protected
        
        def self.mount_shared_folder(machine, name, guestpath, options, vm_provider_unc_base)
          share_name = VagrantWindows::Helper.win_friendly_share_id(name)
          drive_letter = options.fetch(:drive_letter, nil)
          template_options = {
            :mount_point => guestpath,
            :share_name => share_name,
            :vm_provider_unc_path => vm_provider_unc_base + share_name,
            :drive_letter => drive_letter}
          mount_script = VagrantWindows.load_script_template("mount_volume.ps1", :options => template_options)
          machine.communicate.execute(mount_script, {:shell => :powershell})
        end
        
      end
    end
  end
end
